Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF44207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eyGuIIOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFIK7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:59:21 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61893 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbgFIK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591700359; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=14BbUKA8gwFuHIS7l3zksIQLyrm5UF4WwK4qtAEQ7i8=; b=eyGuIIOS2C0ShV8uazxLXHb5RkA/XJHjlbvC0FtLDNyPW3jR3m/3IReRBmjDBFgFQyZ++epf
 mIug425ilTimTZ0yDWJrnrl86MKH8d0rFLz158H3bxxL/yytUrIIl+fgyx8qbGJHXnMx5G7N
 Y+IG1QtTWL60bUNxe2I/znbT1BI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5edf6b7a9545e9541f864646 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 10:59:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0568BC43391; Tue,  9 Jun 2020 10:59:05 +0000 (UTC)
Received: from [192.168.1.102] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24780C433CA;
        Tue,  9 Jun 2020 10:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24780C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic order-0
 allocations
To:     Andrew Morton <akpm@linux-foundation.org>, mgorman@suse.de,
        mhocko@kernel.org, minchan@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
 <20200604144347.7804bc81bbd6dd3027a1cb10@linux-foundation.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <a2c56bac-92c7-626d-453a-f9d4bc95ccb4@codeaurora.org>
Date:   Tue, 9 Jun 2020 16:29:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200604144347.7804bc81bbd6dd3027a1cb10@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding more people to get additional reviewer inputs.

On 6/5/2020 3:13 AM, Andrew Morton wrote:
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
> Do we have any additional reviewer input on this one?
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
>> +		 */
>> +		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
>> +		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
>> +			mark = zone->_watermark[WMARK_MIN];
>> +		}
>>  		if (!zone_watermark_fast(zone, order, mark,
>>  				       ac->highest_zoneidx, alloc_flags)) {
>>  			int ret;
> 
> It would seem smart to do
> 
> --- a/mm/page_alloc.c~mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations-fix
> +++ a/mm/page_alloc.c
> @@ -3745,7 +3745,6 @@ retry:
>  			}
>  		}
>  
> -		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
>  		/*
>  		 * Allow GFP_ATOMIC order-0 allocations to exclude the
>  		 * zone->watermark_boost in their watermark calculations.
> @@ -3757,6 +3756,8 @@ retry:
>  		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
>  		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
>  			mark = zone->_watermark[WMARK_MIN];
> +		} else {
> +			mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
>  		}
>  		if (!zone_watermark_fast(zone, order, mark,
>  				       ac->highest_zoneidx, alloc_flags)) {
> 
> but that makes page_alloc.o 16 bytes larger, so I guess don't bother.
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
