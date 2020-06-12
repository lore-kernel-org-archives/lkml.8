Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6C9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FEE207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Rqi0/V5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFLLHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:07:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:38600 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgFLLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:07:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591960049; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=BnCXV1eT4PYNxgO3yiQdkkkdhOl00dNU0VRujVxajZ8=; b=Rqi0/V5Pn+cYI4AwSShmVwzbob7MsP38PWPRuX/3wI8UW4lLFsKjwvlfgM076o55yBaDP32z
 7JXtG9Srelwcjy3uok2fIiCaAVNRVwXCWwRUmkDgDwArtjJ9iXaWnDOUxRrPNA9o/H7KJNP1
 t8NISpLLYV6J7JDzEz+2stoiX00=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ee361efad153efa342b57df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 11:07:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB888C433C8; Fri, 12 Jun 2020 11:07:27 +0000 (UTC)
Received: from [192.168.1.102] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6870DC433CA;
        Fri, 12 Jun 2020 11:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6870DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic order-0
 allocations
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
 <20200609122811.GK3127@techsingularity.net>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <8a94eccb-5d57-7168-9c6a-03241407630d@codeaurora.org>
Date:   Fri, 12 Jun 2020 16:37:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609122811.GK3127@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mel for feedback.

On 6/9/2020 5:58 PM, Mel Gorman wrote:
> On Tue, May 19, 2020 at 03:28:04PM +0530, Charan Teja Reddy wrote:
>> When boosting is enabled, it is observed that rate of atomic order-0
>> allocation failures are high due to the fact that free levels in the
>> system are checked with ->watermark_boost offset. This is not a problem
>> for sleepable allocations but for atomic allocations which looks like
>> regression.
>>
> 
> Are high-order allocations in general of interest to this platform? If
> not then a potential option is to simply disable boosting. The patch is
> still relevant but it's worth thinking about.
> 

Yes we do care till order-3.

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
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>  mm/page_alloc.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d001d61..5193d7e 100644
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
>> +		 */
> 
> The comment is a bit difficult to parse. Maybe this.
> 
> 	/*
> 	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> 	 * when checking the min watermark. The min watermark is the
> 	 * point where boosting is ignored so that kswapd is woken up
> 	 * when below the low watermark.
> 	 */
> 
> I left out the ALLOC_ part for reasons that are explained blow.
> 
>> +		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
>> +		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
>> +			mark = zone->_watermark[WMARK_MIN];
>> +		}
> 
> The second check is a bit more obscure than it needs to be and depends
> on WMARK_MIN == 0. That will probably be true forever but it's not
> obvious at a glance. I suggest something like
> ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN).
> 
> For detecting atomic alloctions, you rely on the either ALLOC_HARDER or
> ALLOC_HIGH being set. ALLOC_HIGH can be set for non-atomic allocations
> and ALLOC_HARDER can be set for RT tasks. You probably should just test
> the gfp_mask because as it stands non-atomic allocations can ignore the
> boost too.
> 
> Finally, the patch puts an unlikely check into a relatively fast path even
> though watermarks may be fine with or without boosting.  Instead you could
> put the checks in zone_watermark_fast() if and only if the watermarks
> failed the first time. If the checks pass, the watermarks get checked
> a second time. This will be fractionally slower for requests failing
> watermark checks but there is no penalty for most allocation requests.
> It would need the gfp_mask to be passed into zone_watermark_fast but
> as it's an inlined function, there should be no cost to passing in the
> arguement i.e. do something like this at the end of zone_watermark_fast
> 
> 	if (__zone_watermark_ok(z, order, mark, classzone_idx, alloc_flags, free_pages))
> 		return true;
> 
> 	/* Ignore watermark boosting for .... */
> 	if (unlikely(!order .....) {
> 		mark = ...
> 		return __zone_watermark_ok(...);
> 	}
> 
> 	return false;
> 

Incorporated these suggestions at:
https://lore.kernel.org/patchwork/patch/1254998/. Can you please help in
reviewing?

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
