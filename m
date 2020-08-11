Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E456C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8339206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="maI1jdIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgHKFKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:10:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26438 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgHKFKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:10:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597122651; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fNTNLk+YcU+2RefkRwGbM5Ie2n6ZAQJJrXgsBdwG+QA=; b=maI1jdIw33ai4aDosAs2xEY9bElgRcfU5qyyFLrAjDtlfsYLrE6ijUKb8uzFaxI0RCFE/kti
 bLNjYRQf4IblEzLiR66X+/cbnTg1sIROY1kNk0lkNWwzgfgqizYQDnFcorLoaNFqls6ddHDU
 FbzZHCnrkpo29OZwpwaoE2WzBgw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f32285bcbcd42bdeec913c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 05:10:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37DFFC433CB; Tue, 11 Aug 2020 05:10:50 +0000 (UTC)
Received: from [10.110.5.78] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDC73C433C6;
        Tue, 11 Aug 2020 05:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDC73C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [RFC v4 1/3] usb: dwc3: Resize TX FIFOs to meet EP bursting
 requirements
To:     Felipe Balbi <balbi@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
References: <20200624022848.7765-1-wcheng@codeaurora.org>
 <20200624022848.7765-2-wcheng@codeaurora.org> <87d03yptxi.fsf@kernel.org>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <b0c8a95b-45e3-0d79-2a7c-14c8936dd551@codeaurora.org>
Date:   Mon, 10 Aug 2020 22:10:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87d03yptxi.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2020 5:27 AM, Felipe Balbi wrote:
> Wesley Cheng <wcheng@codeaurora.org> writes:
> 
> Hi,
> 
>> Some devices have USB compositions which may require multiple endpoints
>> that support EP bursting.  HW defined TX FIFO sizes may not always be
>> sufficient for these compositions.  By utilizing flexible TX FIFO
>> allocation, this allows for endpoints to request the required FIFO depth to
>> achieve higher bandwidth.  With some higher bMaxBurst configurations, using
>> a larger TX FIFO size results in better TX throughput.
> 
> how much better? What's the impact? Got some real numbers of this
> running with upstream kernel? I guess mass storage gadget is the
> simplest one to test.
> 
Hi Felipe,

Thanks for the input.

Sorry for not including the numbers in the patch itself, but I did
mention the set of mass storage tests I ran w/ the upstream kernel on
SM8150 in the cover letter.  Let me just share that here:

Test Parameters:
 - Platform: Qualcomm SM8150
 - bMaxBurst = 6
 - USB req size = 256kB
 - Num of USB reqs = 16
 - USB Speed = Super-Speed
 - Function Driver: Mass Storage (w/ ramdisk)
 - Test Application: CrystalDiskMark

Results:

TXFIFO Depth = 3 max packets

Test Case | Data Size | AVG tput (in MB/s)
-------------------------------------------
Sequential|1 GB x     |
Read      |9 loops    | 193.60
	  |           | 195.86
          |           | 184.77
          |           | 193.60
-------------------------------------------

TXFIFO Depth = 6 max packets

Test Case | Data Size | AVG tput (in MB/s)
-------------------------------------------
Sequential|1 GB x     |
Read      |9 loops    | 287.35
	  |           | 304.94
          |           | 289.64
          |           | 293.61
-------------------------------------------

>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 6dee4dabc0a4..76db9b530861 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -601,8 +601,9 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
>>  {
>>  	enum usb_device_state state = dwc->gadget.state;
>>  	u32 cfg;
>> -	int ret;
>> +	int ret, num, size;
> 
> no, no. Please one declaration per line.
> 
Got it.
>>  	u32 reg;
>> +	struct dwc3_ep *dep;
> 
> Keep reverse xmas tree order.
> 
Understood.
>> @@ -611,6 +612,40 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
>>  		return -EINVAL;
>>  
>>  	case USB_STATE_ADDRESS:
>> +		/*
>> +		 * If tx-fifo-resize flag is not set for the controller, then
>> +		 * do not clear existing allocated TXFIFO since we do not
>> +		 * allocate it again in dwc3_gadget_resize_tx_fifos
>> +		 */
>> +		if (dwc->needs_fifo_resize) {
>> +			/* Read ep0IN related TXFIFO size */
>> +			dep = dwc->eps[1];
>> +			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
>> +			if (dwc3_is_usb31(dwc))
>> +				dep->fifo_depth = DWC31_GTXFIFOSIZ_TXFDEP(size);
>> +			else
>> +				dep->fifo_depth = DWC3_GTXFIFOSIZ_TXFDEP(size);
>> +
>> +			dwc->last_fifo_depth = dep->fifo_depth;
>> +			/* Clear existing TXFIFO for all IN eps except ep0 */
>> +			for (num = 3; num < min_t(int, dwc->num_eps,
>> +				DWC3_ENDPOINTS_NUM); num += 2) {
>> +				dep = dwc->eps[num];
>> +				/* Don't change TXFRAMNUM on usb31 version */
>> +				size = dwc3_is_usb31(dwc) ?
>> +					dwc3_readl(dwc->regs,
>> +						   DWC3_GTXFIFOSIZ(num >> 1)) &
>> +						   DWC31_GTXFIFOSIZ_TXFRAMNUM :
>> +						   0;
>> +
>> +				dwc3_writel(dwc->regs,
>> +					    DWC3_GTXFIFOSIZ(num >> 1),
>> +					    size);
>> +				dep->fifo_depth = 0;
>> +			}
>> +			dwc->num_ep_resized = 0;
> 
> care to move this into a helper that you call unconditionally and the
> helper returns early is !needs_fifo_resize?
> 
Sure, I'll include that in the next revision.
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 00746c2848c0..777badf3e85d 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -540,6 +540,117 @@ static int dwc3_gadget_start_config(struct dwc3_ep *dep)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
>> + * @dwc: pointer to our context structure
>> + *
>> + * This function will a best effort FIFO allocation in order
>> + * to improve FIFO usage and throughput, while still allowing
>> + * us to enable as many endpoints as possible.
>> + *
>> + * Keep in mind that this operation will be highly dependent
>> + * on the configured size for RAM1 - which contains TxFifo -,
>> + * the amount of endpoints enabled on coreConsultant tool, and
>> + * the width of the Master Bus.
>> + *
>> + * In general, FIFO depths are represented with the following equation:
>> + *
>> + * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
>> + *
>> + * Conversions can be done to the equation to derive the number of packets that
>> + * will fit to a particular FIFO size value.
>> + */
>> +static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>> +{
>> +	struct dwc3 *dwc = dep->dwc;
>> +	int ram1_depth, mdwidth, fifo_0_start, tmp, num_in_ep;
>> +	int min_depth, remaining, fifo_size, mult = 1, fifo, max_packet = 1024;
> 
> one declaration per line, also make sure you order it in reverse xmas
> tree order.
> 
Will make sure to fix this in further declarations.
>> +	if (!dwc->needs_fifo_resize)
>> +		return 0;
>> +
>> +	/* resize IN endpoints except ep0 */
>> +	if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
>> +		return 0;
>> +
>> +	/* Don't resize already resized IN endpoint */
>> +	if (dep->fifo_depth)
> 
> using fifo_depth as a flag seems flakey to me. What happens when someone
> in the future changes the behavior below and this doesn't apply anymore?
> 
> Also, why is this procedure called more than once for the same endpoint?
> Does that really happen?
> 
I guess it can be considered a bug elsewhere (ie usb gadget or function
driver) if this happens twice.  Plus, if we decide to keep this in the
dwc3 enable endpoint path, the DWC3_EP_ENABLED flag will ensure it's
called only once as well.  Its probably overkill to check fifo_depth here.
>> +		return 0;
>> +
>> +	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>> +	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
>> +	/* MDWIDTH is represented in bits, we need it in bytes */
>> +	mdwidth >>= 3;
>> +
>> +	if (((dep->endpoint.maxburst > 1) &&
>> +			usb_endpoint_xfer_bulk(dep->endpoint.desc))
>> +			|| usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> +		mult = 3;
>> +
>> +	if ((dep->endpoint.maxburst > 6) &&
>> +			usb_endpoint_xfer_bulk(dep->endpoint.desc)
>> +			&& dwc3_is_usb31(dwc))
>> +		mult = 6;
>> +
>> +	/* FIFO size for a single buffer */
>> +	fifo = (max_packet + mdwidth)/mdwidth;
> 
> add spaces around integer division operator
> 
>> +	fifo++;
>> +
>> +	/* Calculate the number of remaining EPs w/o any FIFO */
>> +	num_in_ep = dwc->num_eps/2;
>> +	num_in_ep -= dwc->num_ep_resized;
>> +	/* Ignore EP0 IN */
>> +	num_in_ep--;
>> +
>> +	/* Reserve at least one FIFO for the number of IN EPs */
>> +	min_depth = num_in_ep * (fifo+1);
>> +	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
>> +
>> +	/* We've already reserved 1 FIFO per EP, so check what we can fit in
> 
> comment style is wrong
> 
>> +	 * addition to it.  If there is not enough remaining space, allocate
>> +	 * all the remaining space to the EP.
>> +	 */
>> +	fifo_size = (mult-1) * fifo;
> 
> spaces around subtraction
> 
Will fix the formatting comments above.
>> +	if (remaining < fifo_size) {
>> +		if (remaining > 0)
>> +			fifo_size = remaining;
>> +		else
>> +			fifo_size = 0;
>> +	}
>> +
>> +	fifo_size += fifo;
>> +	fifo_size++;
> 
> why the increment?
> 
This is to account for the last +1 in the equation from the DWC3 databook:
fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1 <- this one

>> +	dep->fifo_depth = fifo_size;
>> +
>> +	/* Check if TXFIFOs start at non-zero addr */
>> +	tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
>> +	fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
>> +
>> +	fifo_size |= (fifo_0_start + (dwc->last_fifo_depth << 16));
>> +	if (dwc3_is_usb31(dwc))
>> +		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
>> +	else
>> +		dwc->last_fifo_depth += DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
>> +
>> +	/* Check fifo size allocation doesn't exceed available RAM size. */
>> +	if (dwc->last_fifo_depth >= ram1_depth) {
>> +		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
>> +				(dwc->last_fifo_depth * mdwidth), ram1_depth,
>> +				dep->endpoint.name, fifo_size);
>> +		if (dwc3_is_usb31(dwc))
>> +			fifo_size = DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
>> +		else
>> +			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
>> +		dwc->last_fifo_depth -= fifo_size;
>> +		dep->fifo_depth = 0;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
>> +	dwc->num_ep_resized++;
> 
> add a blank line here
> 
>> +	return 0;
>> +}
>> +
>>  static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
>>  {
>>  	const struct usb_ss_ep_comp_descriptor *comp_desc;
>> @@ -620,6 +731,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>>  	int			ret;
>>  
>>  	if (!(dep->flags & DWC3_EP_ENABLED)) {
>> +		ret = dwc3_gadget_resize_tx_fifos(dep);
>> +		if (ret)
>> +			return ret;
> 
> doesn't it look odd that you're resizing every fifo every time a new
> endpoint is enabled? Is there a better way to achieve this?
> 
We're only resizing a single fifo per call, and clearing the previous
fifo configuration upon receiving the set address.  In the past, I know
the change was to resize all fifos after receiving the set configuration
packet.  With that approach, I believe we saw issues with some function
drivers that immediately queued a USB request during their set_alt()
routine, followed by the dwc3 ep0 driver calling the TX fifo resize
API.(as the tx fifo resize was executed after we delegated the set
config packet to the USB composite)

Thanks
Wesley

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
