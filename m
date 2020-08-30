Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7864FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCA620578
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzglhZqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgH3Vfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:35:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgH3Vfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598823349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPhC1+5bbsbtEa8ZJuKpaDEIo2tOFrzHggB+hQ04mew=;
        b=TzglhZqU7hAZNTMsykqs4Qt1wekzvIrt2ZyMvGihQGgkiOXD64eZ4HQuLBWJ7WdTrvPDRX
        LkB0/iLTl/uC8CTGHyUnR+fqlLlSFeJwzL2AqaoX6Nt6eIhq2hH/BB9SmvcBVQB+o2UL2k
        0MJhYcK5ACrjUdJAqqvgbh5ceBvxvBo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-flJEbupoNWCs8c5zaM8wxw-1; Sun, 30 Aug 2020 17:35:46 -0400
X-MC-Unique: flJEbupoNWCs8c5zaM8wxw-1
Received: by mail-ot1-f69.google.com with SMTP id a3so327133oti.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nPhC1+5bbsbtEa8ZJuKpaDEIo2tOFrzHggB+hQ04mew=;
        b=k+1Sq2dogubVTvC3pWjn1AbVmE6Ny0ltU4mGhocZqSSuLBVm18pdVwJcPPSQuTRDbQ
         ZoUzhQUNfZPCupDeF3hg0BhiEQNbW/TaziCOw1BQm4YX8Gg/07EMKSgizzWu+TWbdnRA
         SkiW3ijKGV1AtOzBdXQLit+njYHPxcKtu00fUOveQH7jo/r1KIMTBT7IYiHWojpY9bBr
         icRsq8fpOgMRLVzRLrB80sTWEdkqI06AsGhhduB3i5dJ20Z21EnZdYMk2FeEtTQ9Gj0r
         sUwxsTN7jUrYXcM+CJYUOp0XRVLO0LKnx8zkIwNc/1IJhjyMfRLK+jl/mo4sQxR5X+rt
         dWrA==
X-Gm-Message-State: AOAM5328/+B/UE+sSAr7O+1wo0csXx7BMerWxye78yQ4jn7sz6kml3Bc
        vxub6jIb+l2FgD2KL1MjZGqtnGi9d+JbRBoIPLvqmObvDMAATL+jPN7PWYF7XY0gRq+V5ExX40Y
        Ep9yTjmaNkBm4bnmq4UdkzRw2
X-Received: by 2002:aca:eb51:: with SMTP id j78mr1837286oih.169.1598823344353;
        Sun, 30 Aug 2020 14:35:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1H/VMgokYQ3TYCwh3DbOCvK/y+iY2fq9anmdRZ6PIUxY5QvrBXRaSbybzqi3m1HJ3iMIh4A==
X-Received: by 2002:aca:6c5:: with SMTP id 188mr1845062oig.84.1598823343518;
        Sun, 30 Aug 2020 14:35:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m11sm296973ooe.43.2020.08.30.14.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 14:35:43 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: net2272: assert for a valid dma request
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        christophe.jaillet@wanadoo.fr, peter.chen@nxp.com, b-liu@ti.com,
        chunfeng.yun@mediatek.com, novikov@ispras.ru, yanaijie@huawei.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200830183646.24930-1-trix@redhat.com>
 <20200830212249.GA528080@rowland.harvard.edu>
From:   Tom Rix <trix@redhat.com>
Message-ID: <40bac66a-2c05-6f1b-0e46-e577a54aab6e@redhat.com>
Date:   Sun, 30 Aug 2020 14:35:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200830212249.GA528080@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/20 2:22 PM, Alan Stern wrote:
> On Sun, Aug 30, 2020 at 11:36:46AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags this representive problem
>>
>> net2272.c:1541:8: warning: Dereference of null pointer
>>     if ((req->req.length % ep->ep.maxpacket != 0) ||
>>          ^~~~~~~~~~~~~~~
>> This is mostly not a problem.
>>
>> In net2272_handle_dma(), even though every path through
>> the routine dereferences req, it is set to NULL when the
>> ep->queue is empty.  If the eq->queue was ever empty this
>> would have oops.
>>
>> So the else statement should not be needed.  If it is,
>> flag it as a BUG.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> This patch really seems to be overkill.  In particular, Linus Torvalds 
> feels very strongly that people should not add BUG or BUG_ON calls 
> except in extreme situations -- which this isn't.
>
>> ---
>>  drivers/usb/gadget/udc/net2272.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
>> index 44d1ea2307bb..8301723a8b1a 100644
>> --- a/drivers/usb/gadget/udc/net2272.c
>> +++ b/drivers/usb/gadget/udc/net2272.c
>> @@ -1506,17 +1506,16 @@ static int net2272_stop(struct usb_gadget *_gadget)
>>  static void
>>  net2272_handle_dma(struct net2272_ep *ep)
>>  {
>> -	struct net2272_request *req;
>> +	struct net2272_request *req = NULL;
>>  	unsigned len;
>>  	int status;
>>  
>>  	if (!list_empty(&ep->queue))
>>  		req = list_entry(ep->queue.next,
>>  				struct net2272_request, queue);
>> -	else
>> -		req = NULL;
>>  
>>  	dev_vdbg(ep->dev->dev, "handle_dma %s req %p\n", ep->ep.name, req);
>> +	BUG_ON(!req);
> There's no point in adding this.  If the function goes on to dereference 
> a NULL pointer, you'll get the same effect in any case -- an oops.
>
> If you want to make the point that req had better not be NULL, just get 
> rid of the "if" test entirely.  You could even change the list_entry to 
> list_first_entry.

Since nothing is really going to change, drop this patch.

Tom

> Alan Stern
>

