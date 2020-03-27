Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F80C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E58E20705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="CXyIlPI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0JOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:14:21 -0400
Received: from www381.your-server.de ([78.46.137.84]:60896 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgC0JOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i5/GTfOj6acDIGpcrU7CL6Wpgc2I8NpZJXqjKZ1f8xw=; b=CXyIlPI1fbD/tvHVU1oew63ga7
        V3a4bhgbnN/UCS7lS/EkZ1S+0TX3+VNmhX6mK9xlpH5+hWXm15ypyQguBR18+YMX+se3b0QSPhNUJ
        HXyZQco3SxOGRcb6NseLfQ8YlojPrJQ9bCN9UbNo2qQ06sxcB3wz0hOMTvo3cdzFvAxvb2kiLzmtC
        cmUyg/bvUrh0r697HtgZ5gpQDLdYc+f4m5Mz4dcKLKf/fyDWNEB2uVdtL2h3dwqFUQAYzWsHsU5So
        xYHgA/D2ru9rHCCYq1m3nMPh3Vh4o6rnZJg0INChoLW+sX0f1LWmVPA27Oq55FirZ0qVaeuDRhNfv
        i/9KZjEQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jHl48-0006uj-Ca; Fri, 27 Mar 2020 10:14:16 +0100
Received: from [82.135.64.145] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jHl48-000RZG-3B; Fri, 27 Mar 2020 10:14:12 +0100
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already
 disabled endpoints
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        alexandru.Ardelean@analog.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de>
 <20200327084302.606-1-m.grzeschik@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f746cc1f-b5e2-af0a-d946-edce634c46c3@metafoo.de>
Date:   Fri, 27 Mar 2020 10:14:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327084302.606-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25763/Thu Mar 26 14:07:34 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 9:43 AM, Michael Grzeschik wrote:
> dwc3_gadget_ep_disable gets called before the last request gets
> dequeued.
>
> In __dwc3_gadget_ep_disable all started, pending and cancelled
> lists for this endpoint will call dwc3_gadget_giveback in
> dwc3_remove_requests.
>
> After that no list containing the afterwards dequed request,
> therefor it is not necessary to run the dequeue routine.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> @Lars-Peter Clausen:
>
> This patch addresses the case that not queued requests get dequeued.
> The only case that this happens seems on disabling the gadget.


I don't believe it does. Calling usb_ep_dequeue() is not limited to be 
called after the endpoint has been disabled. It is part of the API and 
can be called at any time. E.g. with function_fs you can abort a queued 
transfer from userspace at any time.

- Lars

>
>   drivers/usb/dwc3/gadget.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>   
>   	trace_dwc3_ep_dequeue(req);
>   
> +	if (!(dep->flags & DWC3_EP_ENABLED))
> +		return 0;
> +
>   	spin_lock_irqsave(&dwc->lock, flags);
>   
>   	list_for_each_entry(r, &dep->pending_list, list) {


