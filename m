Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD16320786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="B0GbCmDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHSSSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:18:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57422 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgHSSSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:18:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597861078; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+yY6ARtxEi7zwXwHoX/pmkrR5nxBNg14YNXmTQgs4QI=; b=B0GbCmDKyCZ8O2Y5qiZrkCP2tpo0gHXFzb8zjMGLkB1AX92EWCED6NHnkvshXKEBPqDXKf9c
 Ov2tAbKj0xOahhvd0NNmnfpW/exDI9s2DIzQVIUbqFV30Yi4d4OHI7+Q4XJ0WPs2CWhwpTSh
 EEmK0VfnfPxdFH3Ay0CXp/VmVBg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3d6cc1673250c006118322 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 18:17:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2355DC433CB; Wed, 19 Aug 2020 18:17:37 +0000 (UTC)
Received: from [10.110.104.6] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51B0DC433C6;
        Wed, 19 Aug 2020 18:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51B0DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
References: <20200819051739.22123-1-wcheng@codeaurora.org>
 <87zh6qyihk.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <3b87cc4c-f45c-b168-a7e3-9e60101e526e@codeaurora.org>
Date:   Wed, 19 Aug 2020 11:17:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh6qyihk.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2020 4:37 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Wesley Cheng <wcheng@codeaurora.org> writes:
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
> 
> these two should be the same. If pullups are not connected, there's no
> way we can have an endpoint descriptor. Did you find a race condition here?
> 

Hi Felipe,

At least for EP0, I don't see us clearing the EP0 desc after we set it
during dwc3_gadget_init_endpoint().  In the dwc3_gadget_ep_disable() we
only clear the desc for non control EPs:

static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
{
...
	/* Clear out the ep descriptors for non-ep0 */
	if (dep->number > 1) {
		dep->endpoint.comp_desc = NULL;
		dep->endpoint.desc = NULL;
	}

Is the desc for ep0 handled elsewhere? (checked ep0.c as well, but
couldn't find any references there)

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
>> +
>> +		/*
>> +		 * The databook explicitly mentions for a device-initiated
>> +		 * disconnect sequence, the SW needs to ensure that it ends any
>> +		 * active transfers.
>> +		 */
>> +		dwc3_stop_active_transfers(dwc);
> 
> IIRC, gadget driver is required to dequeue transfers before
> disconnecting. My memory is a bit fuzzy in that area, but anyway, how
> did you trigger this problem?
> 

I had a script that just did the following to trigger the soft disconnect:
echo "" > /sys/kernel/config/usb_gadget/g1/UDC
sleep 4
echo "a600000.dwc3" > /sys/kernel/config/usb_gadget/g1/UDC

Then on the PC, I just had a batch file executing adb push (of a large
file), in order to create the situation where there was a device
initiated disconnect while an active transfer was occurring.  After
maybe after 4-5 iterations, I saw that the controller halt failed.

[   87.364252] dwc3_gadget_run_stop run stop = 0
[   87.374168] ffs_epfile_io_complete: eshutdown
[   87.376162] __dwc3_gadget_ep_queue
[   87.386160] ffs_epfile_io_complete: eshutdown

I added some prints to hopefully show that while we are disabling the
controller, the gadget/function driver is still active.  The eshutdown
prints happen due to the dwc3_stop_active_transfers() call, which means
there are still some pending/active reqs.

Thanks
Wesley

>> @@ -1994,9 +2033,15 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * Synchronize and disable any further event handling while controller
>> +	 * is being enabled/disabled.
>> +	 */
>> +	disable_irq(dwc->irq_gadget);
> 
> looks like a call to synchronize_irq() would be enough here.
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
