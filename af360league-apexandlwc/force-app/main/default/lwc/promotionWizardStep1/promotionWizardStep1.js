import { LightningElement, api } from 'lwc';

import { fromContext } from '@lwc/state';
import promotionStateManager from 'c/promotionStateManager';

export default class PromotionWizardStep1 extends LightningElement {

    promotionState = fromContext(promotionStateManager);

    promotionName;

    connectedCallback(){
        this.promotionName = this.promotionState?.value?.promotionName;
    }

    handleChange(event) {
        this.promotionName = event.detail.value;
    }

    @api
    allValid(){
        if(this.promotionName === undefined || this.promotionName === ''){
            return false;
        }
        
        this.promotionState.value.updatePromotionName(this.promotionName);

        return true;
    }
}