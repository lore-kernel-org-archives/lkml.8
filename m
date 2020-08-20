Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E98DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA172078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k1g2GUsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHTCAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:00:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40208 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgHTCAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:00:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597888816; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=wcVoVZaavMf++fqDuxT3/6m9eN4VPSyrzZggPqhLt7k=; b=k1g2GUsDttwmAVqBZbi4Emnx03xAwbJQE6qDXp0YFhcPN2PsKPBVg3gyg+jTgyfUerZYsJbL
 Wz1lwuoboQrhdsBvj/dcaw8WH6QC4NtwRPc8eZ4xaIAWrPAM0Nk4kIrVhl76AdT7LG1mbCqV
 4fVzYf/AY7+kXJlqSYmOetFTeK0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f3dd8f0c651aed294b3d890 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 01:59:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CF21C433C6; Thu, 20 Aug 2020 01:59:12 +0000 (UTC)
Received: from [10.110.104.6] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D865C433C6;
        Thu, 20 Aug 2020 01:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D865C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
References: <20200819051739.22123-1-wcheng@codeaurora.org>
 <3917c516-7251-5b13-2192-0820c125eced@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <65645474-c136-c226-7762-db46ddb2c67a@codeaurora.org>
Date:   Wed, 19 Aug 2020 18:59:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3917c516-7251-5b13-2192-0820c125eced@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 2:42 PM, Thinh Nguyen wrote:
> Hi,
> 
> Wesley Cheng wrote:
>> In the DWC3 databook, for a device initiated disconnect, the driver is
>> required to send dependxfer commands for any pending transfers.
>> In addition, before the controller can move to the halted state, the SW
>> needs to acknowledge any pending events.  If the controller is not halted
>> properly, there is a chance the controller will continue accessing stale or
>> freed TRBs and buffers.
>>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>
>> ---
>> Verified fix by adding a check for ETIMEDOUT during the run stop call.
>> Shell script writing to the configfs UDC file to trigger disconnect and
>> connect.  Batch script to have PC execute data transfers over adb (ie adb
>> push)  After a few iterations, we'd run into a scenario where the
>> controller wasn't halted.  With the following change, no failed halts after
>> many iterations.
>> ---
>>  drivers/usb/dwc3/ep0.c    |  2 +-
>>  drivers/usb/dwc3/gadget.c | 59 +++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 57 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 59f2e8c31bd1..456aa87e8778 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
>>  	int				ret;
>>  
>>  	spin_lock_irqsave(&dwc->lock, flags);
>> -	if (!dep->endpoint.desc) {
>> +	if (!dep->endpoint.desc || !dwc->pullups_connected) {
>>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>>  				dep->name);
>>  		ret = -ESHUTDOWN;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 3ab6f118c508..1f981942d7f9 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1516,7 +1516,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>  {
>>  	struct dwc3		*dwc = dep->dwc;
>>  
>> -	if (!dep->endpoint.desc) {
>> +	if (!dep->endpoint.desc || !dwc->pullups_connected) {
>>  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>>  				dep->name);
>>  		return -ESHUTDOWN;
>> @@ -1926,6 +1926,24 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>>  	return 0;
>>  }
>>  
>> +static void dwc3_stop_active_transfers(struct dwc3 *dwc)
>> +{
>> +	u32 epnum;
>> +
>> +	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>> +		struct dwc3_ep *dep;
>> +
>> +		dep = dwc->eps[epnum];
>> +		if (!dep)
>> +			continue;
>> +
>> +		if (!(dep->flags & DWC3_EP_ENABLED))
>> +			continue;
>> +
>> +		dwc3_remove_requests(dwc, dep);
>> +	}
>> +}
>> +
>>  static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>>  {
>>  	u32			reg;
>> @@ -1950,16 +1968,37 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>>  
>>  		dwc->pullups_connected = true;
>>  	} else {
>> +		dwc->pullups_connected = false;
>> +
>> +		__dwc3_gadget_ep_disable(dwc->eps[0]);
>> +		__dwc3_gadget_ep_disable(dwc->eps[1]);
> 
> run_stop() function shouldn't be doing this. This is done in
> dwc3_gadget_stop(). Also, if it's device-initiated disconnect, driver
> needs to wait for control transfers to complete.
> 

Hi Thinh ,

Thanks for the feedback.

We already wait for the ep0state to move to the setup stage before
running the run stop routine, but events can still be triggered until
the controller is halted. (which is not started until we attempt to
write to the DCTL register) The reasoning will be the same as the below
comment.

>> +
>> +		/*
>> +		 * The databook explicitly mentions for a device-initiated
>> +		 * disconnect sequence, the SW needs to ensure that it ends any
>> +		 * active transfers.
>> +		 */
>> +		dwc3_stop_active_transfers(dwc);
> 
> It shouldn't be done here. Maybe move this to the dwc3_gadget_pullup()
> function. The run_stop() function can be called for other context beside
> this (e.g. hibernation).
> 

It was preferred to have it placed after the pullups_connected was set
to false, so that further ep queues would be blocked (with the added
check), and we can ensure after the stop active xfers was run, nothing
could be pending.

Also, for the hibernation case, the databook mentions that we should
issue the end transfer routine as well for the hibernation w/ device
disconnected situation. (I don't believe the current DWC3 gadget driver
supports the hibernation while device connected case, which has some
considerations we would need to address)

>> +
>>  		reg &= ~DWC3_DCTL_RUN_STOP;
>>  
>>  		if (dwc->has_hibernation && !suspend)
>>  			reg &= ~DWC3_DCTL_KEEP_CONNECT;
>> -
>> -		dwc->pullups_connected = false;
>>  	}
>>  
>>  	dwc3_gadget_dctl_write_safe(dwc, reg);
>>  
>> +	/* Controller is not halted until pending events are acknowledged */
>> +	if (!is_on) {
>> +		reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>> +		reg &= DWC3_GEVNTCOUNT_MASK;
>> +		if (reg > 0) {
>> +			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
>> +			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + reg) %
>> +						dwc->ev_buf->length;
>> +		}
>> +	}
>> +
> 
> Driver should handle the events before clearing the run_stop bit, not
> just acknowledging and ignoring them.
> 

Do you think its better if we call the dwc3_check_event_buf() and
dwc3_process_event_buf() here?  That will handle the clearing of the
events and allow them to be handled.  There are some snippets in the
databook, which mentions that we don't need to handle/process the
events, and just acknowledge them. (it mentions this in the hibernation
section)

>>  	do {
>>  		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>>  		reg &= DWC3_DSTS_DEVCTRLHLT;
>> @@ -1994,9 +2033,15 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * Synchronize and disable any further event handling while controller
>> +	 * is being enabled/disabled.
>> +	 */
>> +	disable_irq(dwc->irq_gadget);
>>  	spin_lock_irqsave(&dwc->lock, flags);
>>  	ret = dwc3_gadget_run_stop(dwc, is_on, false);
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	enable_irq(dwc->irq_gadget);
>>  
>>  	return ret;
>>  }
>> @@ -3535,6 +3580,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>  	if (!count)
>>  		return IRQ_NONE;
>>  
>> +	/* Controller is halted; ignore new/pending events */
>> +	if (!dwc->pullups_connected) {
>> +		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>> +		dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
>> +					dwc->ev_buf->length;
>> +		return IRQ_HANDLED;
>> +	}
>> +
> 
> Why? Are you getting any event after the controller is halted? Also,
> make sure to take account of hibernation. The controller can get PMU
> event after halted to bring it out of hibernation.
> 

We aren't getting any events after the controller is halted, but before
we go and try to clear the run stop bit.  I added a print in the run
stop API after clearing the RS bit, and there were pending events in the
controller at that time.  It might be redundant to have this if we are
disabling the IRQ already before the run stop call.

I see, so maybe to ensure we don't block the PMU event, we can remove
this, and rely on the disable_irq() and the run stop API to ensure no
events will be pending.

>>  	evt->count = count;
>>  	evt->flags |= DWC3_EVENT_PENDING;
>>  
> 
> If you're making these fixes, can you also fix handling reset interrupt
> ? It also needs to end all the active transfers.
> 

Sure, I can consider that as well.

Thanks
Wesley

> Thanks,
> Thinh
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
