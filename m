Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F02C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49CF2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="debXvkyu";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="jMIU9+tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIHVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:42:05 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:39660
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgIHVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599601323;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=MMxFcLq/Tfxamt12qfIPmZT++zwC8dnUjdn0xGbLW3U=;
        b=debXvkyu72EYya7PdbCNUmN+h16i/lPTyspR6KFF6m/LAyr+SXMJExOpukZZZeHi
        wgUuveROl9ULUoLEw2iGuFa9v2KHoidav3C70A31UH3iwsH9Lc6J5Z5Emhyr6+xp4Zc
        SpA0rhwAlKIUREL4ynVVMhrGxzcRRRQhHs6r+fK4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599601323;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=MMxFcLq/Tfxamt12qfIPmZT++zwC8dnUjdn0xGbLW3U=;
        b=jMIU9+tzOHKa1p8iYqB3w5iZc839HZk4rCz3mLXmG7n5XEgBLWoJr4RHRyZRhTry
        dgzBa5oXNf7CcmUiuzASeRg/9hBqGvz4ejV8CRGNhwmhKkJSwHQw0AvIaInpJpISY38
        qgISSPDUNGQZS2ls7KCcs97tMiU6Ts+ioBOTt+VE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 037CAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
References: <20200903210954.24504-1-wcheng@codeaurora.org>
 <87o8mi151l.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <010101746fab2ee1-91b46c27-fef0-4266-94cb-14dea5ca350e-000000@us-west-2.amazonses.com>
Date:   Tue, 8 Sep 2020 21:42:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87o8mi151l.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2020.09.08-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2020 11:20 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
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
> 
> this looks odd. If we don't have pullups connected, we shouldn't have a
> descriptor, likewise if we don't have a a description, we haven't been
> enumerated, therefore we shouldn't have pullups connected.
> 
> What am I missing here?
> 

Hi Felipe,

When we
echo "" > /sys/kernel/config/usb_gadget/g1/UDC

This triggers the usb_gadget_disconnect() routine to execute.

int usb_gadget_disconnect(struct usb_gadget *gadget)
{
...
	ret = gadget->ops->pullup(gadget, 0);
	if (!ret) {
		gadget->connected = 0;
		gadget->udc->driver->disconnect(gadget);
	}

So it is possible that we've already disabled the pullup before running
the disable() callbacks in the function drivers.  The disable()
callbacks usually are the ones responsible for calling usb_ep_disable(),
where we clear the desc field.  This means there is a brief period where
the pullups_connected = 0, but we still have valid ep desc, as it has
not been disabled yet.

Also, for function drivers like mass storage, the fsg_disable() routine
defers the actual usb_ep_disable() call to the fsg_thread, so its not
always ensured that the disconnect() execution would result in the
usb_ep_disable() to occur synchronously.

>> @@ -1926,6 +1926,21 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>>  	return 0;
>>  }
>>  
>> +static void dwc3_stop_active_transfers(struct dwc3 *dwc)
>> +{
>> +	u32 epnum;
>> +
>> +	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
> 
> dwc3 knows the number of endpoints available in the HW. Use dwc->num_eps
> instead.
> 

Sure, will do.

>> @@ -1971,6 +1986,8 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>>  	return 0;
>>  }
>>  
>> +static void __dwc3_gadget_stop(struct dwc3 *dwc);
>> +
>>  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  {
>>  	struct dwc3		*dwc = gadget_to_dwc(g);
>> @@ -1994,9 +2011,37 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * Synchronize and disable any further event handling while controller
>> +	 * is being enabled/disabled.
>> +	 */
>> +	disable_irq(dwc->irq_gadget);
> 
> why isn't dwc3_gadget_disable_irq() enough?
> 
>>  	spin_lock_irqsave(&dwc->lock, flags);
> 
> spin_lock_irqsave() will disable interrupts, why disable_irq() above?
> 

In the discussion I had with Thinh, the concern was that with the newly
added code to override the lpos here, if the interrupt routine
(dwc3_check_event_buf()) runs, then it will reference the lpos for
copying the event buffer contents to the event cache, and potentially
process events.  There is no locking in place, so it could be possible
to have both run in parallel.

Hence, the reason if there was already a pending IRQ triggered, the
dwc3_gadget_disable_irq() won't ensure the IRQ is handled.  We can do
something like:
if (!is_on)
	dwc3_gadget_disable_irq()
synchronize_irq()
spin_lock_irqsave()
if(!is_on) {
...

But the logic to only apply this on the pullup removal case is a little
messy.  Also, from my understanding, the spin_lock_irqsave() will only
disable the local CPU IRQs, but not the interrupt line on the GIC, which
means other CPUs can handle it, unless we explicitly set the IRQ
affinity to CPUX.

>> +	/* Controller is not halted until pending events are acknowledged */
>> +	if (!is_on) {
>> +		u32 count;
>> +
>> +		/*
>> +		 * The databook explicitly mentions for a device-initiated
>> +		 * disconnect sequence, the SW needs to ensure that it ends any
>> +		 * active transfers.
>> +		 */
> 
> make this a little better by mentioning the version and section of the
> databook you're reading. That makes it easier for future
> reference. Also, use an actual quote from the databook, along the lines
> of:
> 
> 		/*
>                  * Synopsys DesignWare Cores USB3 Databook Revision
>                  * X.YYa states in section W.Z that "device-initiated
>                  * disconnect ...."
>                  */
> 

Got it.

>> +		dwc3_stop_active_transfers(dwc);
>> +		__dwc3_gadget_stop(dwc);
>> +
>> +		count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>> +		count &= DWC3_GEVNTCOUNT_MASK;
>> +		if (count > 0) {
>> +			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>> +			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
>> +						dwc->ev_buf->length;
>> +		}
> 
> don't duplicate code. Add a patch before this extracting this into
> helper and use it for both irq handler and gadget pullup.
> 

We actually removed this call in the IRQ handler, as if we ensure that
the IRQ routine has fully complete and won't trigger anymore, then this
sequence will handle clearing of the event count.

>> +	}
>> +
>>  	ret = dwc3_gadget_run_stop(dwc, is_on, false);
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	enable_irq(dwc->irq_gadget);
>>  
>>  	return ret;
>>  }
>> @@ -3100,6 +3145,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>  	}
>>  
>>  	dwc3_reset_gadget(dwc);
>> +	/* Stop any active/pending transfers when receiving bus reset */
> 
> unnecessary comment. We're calling a function named "stop active
> transfers" from within the "bus reset handler".
> 

I can remove this.

Thanks
Wesley

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
