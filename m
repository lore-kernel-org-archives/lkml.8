Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00F92083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZvO1hhGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEHS4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:56:01 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:15829 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgEHS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:56:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588964160; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=EjH2qkZmqYJcFfcuR5tQQWIMkDzmufLYMlW8fjjJAbk=; b=ZvO1hhGOfgtTbQy69XxcwUnrenCoh9oG/M2PI5Ir9Ota2j6CnbJQ+wu9z8E1j8os9r/c521A
 g1MfprtQ/v23woZSslDZSO3a+d9U8yDRnilr3ZvSn3Z6brjB+Ee7Q1bNI+JWXesvnDRz3rJp
 6YLAwwepBaWJog9eICYVq3zDajM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5ab3b.7f0064356b58-smtp-out-n02;
 Fri, 08 May 2020 18:55:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35167C43636; Fri,  8 May 2020 18:55:55 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.248.210.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B97E0C433D2;
        Fri,  8 May 2020 18:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B97E0C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] iommu/iova: Retry from last rb tree node if iova search
 fails
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
 <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <b80fdf37-e635-2d65-c523-8e1d0bd8085b@codeaurora.org>
Date:   Sat, 9 May 2020 00:25:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2020 6:54 PM, Robin Murphy wrote:
> On 2020-05-06 9:01 pm, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> When ever a new iova alloc request comes iova is always searched
>> from the cached node and the nodes which are previous to cached
>> node. So, even if there is free iova space available in the nodes
>> which are next to the cached node iova allocation can still fail
>> because of this approach.
>>
>> Consider the following sequence of iova alloc and frees on
>> 1GB of iova space
>>
>> 1) alloc - 500MB
>> 2) alloc - 12MB
>> 3) alloc - 499MB
>> 4) free -  12MB which was allocated in step 2
>> 5) alloc - 13MB
>>
>> After the above sequence we will have 12MB of free iova space and
>> cached node will be pointing to the iova pfn of last alloc of 13MB
>> which will be the lowest iova pfn of that iova space. Now if we get an
>> alloc request of 2MB we just search from cached node and then look
>> for lower iova pfn's for free iova and as they aren't any, iova alloc
>> fails though there is 12MB of free iova space.
> 
> Yup, this could definitely do with improving. Unfortunately I think this
> particular implementation is slightly flawed...
> 
>> To avoid such iova search failures do a retry from the last rb tree node
>> when iova search fails, this will search the entire tree and get an iova
>> if its available
>>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>   drivers/iommu/iova.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 0e6a953..2985222 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>       unsigned long flags;
>>       unsigned long new_pfn;
>>       unsigned long align_mask = ~0UL;
>> +    bool retry = false;
>>         if (size_aligned)
>>           align_mask <<= fls_long(size - 1);
>> @@ -198,6 +199,8 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>         curr = __get_cached_rbnode(iovad, limit_pfn);
>>       curr_iova = rb_entry(curr, struct iova, node);
>> +
>> +retry_search:
>>       do {
>>           limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>>           new_pfn = (limit_pfn - size) & align_mask;
>> @@ -207,6 +210,14 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>       } while (curr && new_pfn <= curr_iova->pfn_hi);
>>         if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>> +        if (!retry) {
>> +            curr = rb_last(&iovad->rbroot);
> 
> Why walk when there's an anchor node there already? However...
> 
>> +            curr_iova = rb_entry(curr, struct iova, node);
>> +            limit_pfn = curr_iova->pfn_lo;
> 
> ...this doesn't look right, as by now we've lost the original limit_pfn
> supplied by the caller, so are highly likely to allocate beyond the
> range our caller asked for. In fact AFAICS we'd start allocating from
> directly directly below the anchor node, beyond the end of the entire
> address space.
> 
> The logic I was imagining we want here was something like the rapidly
> hacked up (and untested) diff below.
> 
> Thanks,
> Robin.
> 

Thanks for your comments ,I have gone through below logic and I see some
issue with retry check as there could be case where alloc_lo is set to
some pfn other than start_pfn in that case we don't retry and there can
still be iova available. I understand its a hacked up version, I can
work on this.

But how about we just store limit_pfn and get the node using that and
retry for once from that node, it would be similar to my patch just
correcting the curr node and limit_pfn update in retry check. do you see
any issue with this approach ?


Thanks,
Vijay.
> ----->8-----
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 0e6a9536eca6..3574c19272d6 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct
> iova_domain *iovad,
>         unsigned long flags;
>         unsigned long new_pfn;
>         unsigned long align_mask = ~0UL;
> +       unsigned long alloc_hi, alloc_lo;
> 
>         if (size_aligned)
>                 align_mask <<= fls_long(size - 1);
> @@ -196,17 +197,27 @@ static int __alloc_and_insert_iova_range(struct
> iova_domain *iovad,
>                         size >= iovad->max32_alloc_size)
>                 goto iova32_full;
> 
> +       alloc_hi = IOVA_ANCHOR;
> +       alloc_lo = iovad->start_pfn;
> +retry:
>         curr = __get_cached_rbnode(iovad, limit_pfn);
>         curr_iova = rb_entry(curr, struct iova, node);
> +       if (alloc_hi < curr_iova->pfn_hi) {
> +               alloc_lo = curr_iova->pfn_hi;
> +               alloc_hi = limit_pfn;
> +       }
> +
>         do {
> -               limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
> -               new_pfn = (limit_pfn - size) & align_mask;
> +               alloc_hi = min(alloc_hi, curr_iova->pfn_lo);
> +               new_pfn = (alloc_hi - size) & align_mask;
>                 prev = curr;
>                 curr = rb_prev(curr);
>                 curr_iova = rb_entry(curr, struct iova, node);
>         } while (curr && new_pfn <= curr_iova->pfn_hi);
> 
> -       if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +       if (limit_pfn < size || new_pfn < alloc_lo) {
> +               if (alloc_lo == iovad->start_pfn)
> +                       goto retry;
>                 iovad->max32_alloc_size = size;
>                 goto iova32_full;
>         }
