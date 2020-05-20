Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BACBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529BE2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DzoV9JPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgETQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:36:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:56931 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgETQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:36:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589992617; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=UVOfeW+/4QZnjUD8LghkRnU2huy7fBKqvDr+AdvgTxk=; b=DzoV9JPrX99Pic3N73AoR6oUFw9HAO/XXeqYKQI6YuogQnGNk5tCBG4EQnrDoLXylLJiSxjy
 L82pr326Nkwu+5oGhXaYU8fyoz26cMeqeaP+nVCQaoSTernt9OuogUrNt6Yt8lt7FdMM73rd
 1uxOHEq9pSfN8Hhrwn6/ohZVRYw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ec55ca89d4cf4d3efad212b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 16:36:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E90A9C433AF; Wed, 20 May 2020 16:36:55 +0000 (UTC)
Received: from [10.137.174.185] (unknown [183.83.141.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A86DEC433C6;
        Wed, 20 May 2020 16:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A86DEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic order-0
 allocations
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
 <20200519184010.e77d25d7f6b853414e760d76@linux-foundation.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <319c055a-4c86-5a65-c24c-e63f6fe5e5b3@codeaurora.org>
Date:   Wed, 20 May 2020 22:06:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519184010.e77d25d7f6b853414e760d76@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andrew for the comments..

On 5/20/2020 7:10 AM, Andrew Morton wrote:
> On Tue, 19 May 2020 15:28:04 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:
> 
>> When boosting is enabled, it is observed that rate of atomic order-0
>> allocation failures are high due to the fact that free levels in the
>> system are checked with ->watermark_boost offset. This is not a problem
>> for sleepable allocations but for atomic allocations which looks like
>> regression.
>>
>> This problem is seen frequently on system setup of Android kernel
>> running on Snapdragon hardware with 4GB RAM size. When no extfrag event
>> occurred in the system, ->watermark_boost factor is zero, thus the
>> watermark configurations in the system are:
>>    _watermark = (
>>           [WMARK_MIN] = 1272, --> ~5MB
>>           [WMARK_LOW] = 9067, --> ~36MB
>>           [WMARK_HIGH] = 9385), --> ~38MB
>>    watermark_boost = 0
>>
>> After launching some memory hungry applications in Android which can
>> cause extfrag events in the system to an extent that ->watermark_boost
>> can be set to max i.e. default boost factor makes it to 150% of high
>> watermark.
>>    _watermark = (
>>           [WMARK_MIN] = 1272, --> ~5MB
>>           [WMARK_LOW] = 9067, --> ~36MB
>>           [WMARK_HIGH] = 9385), --> ~38MB
>>    watermark_boost = 14077, -->~57MB
>>
>> With default system configuration, for an atomic order-0 allocation to
>> succeed, having free memory of ~2MB will suffice. But boosting makes
>> the min_wmark to ~61MB thus for an atomic order-0 allocation to be
>> successful system should have minimum of ~23MB of free memory(from
>> calculations of zone_watermark_ok(), min = 3/4(min/2)). But failures are
>> observed despite system is having ~20MB of free memory. In the testing,
>> this is reproducible as early as first 300secs since boot and with
>> furtherlowram configurations(<2GB) it is observed as early as first
>> 150secs since boot.
>>
>> These failures can be avoided by excluding the ->watermark_boost in
>> watermark caluculations for atomic order-0 allocations.
> 
> Seems sensible.
> 
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3709,6 +3709,18 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
>>  		}
>>  
>>  		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
>> +		/*
>> +		 * Allow GFP_ATOMIC order-0 allocations to exclude the
>> +		 * zone->watermark_boost in its watermark calculations.
>> +		 * We rely on the ALLOC_ flags set for GFP_ATOMIC
>> +		 * requests in gfp_to_alloc_flags() for this. Reason not to
>> +		 * use the GFP_ATOMIC directly is that we want to fall back
>> +		 * to slow path thus wake up kswapd.
> 
> Nice comment, but I don't understand it ;)
> 
> Why would testing gfp_mask prevent us from waking kswapd?

This piece of code is in the common function get_page_from_freelist()
which will be called in the below order:
1) alloc_pages() with alloc_flags = ALLOC_WMARK_LOW. If watermark check
fails here then,
2) Allocation request will fall back to the slow path,
__alloc_pages_slowpath with alloc_flags = ALLOC_WMARK_MIN, **where it
wakes up kswapd**.

If I use the GFP_ATOMIC directly then even if watermarks are boosted
(and kswapd is yet to wake up), then atomic allocation can return
success from 1) with out even waking up kswapd. This doesn't seem correct.

> 
>> +		 */
>> +		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
>> +		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
>> +			mark = zone->_watermark[WMARK_MIN];
>> +		}
> 
> Why is this not implemented for higher-order allocation attempts?

I don't think that higher-order allocation failures are such critical, I
meant that there will be no critical users who can rely on higher-order
atomic allocations to be successful. Please correct me If I am wrong
here. Atleast this is the case on Android systems..

> 
>>  		if (!zone_watermark_fast(zone, order, mark,
>>  				       ac->highest_zoneidx, alloc_flags)) {
>>  			int ret;
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
