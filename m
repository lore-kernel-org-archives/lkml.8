Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65ACC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E41206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ekdaiBxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbgEMKFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:05:01 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:15134 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732794AbgEMJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:47:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589363233; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=2ym0u7X5Osc4xDJAmwudyg1fVc6L2CkIAndFTTBUaJY=; b=ekdaiBxLIn+3knPeZldLX1TCfs+v9TmsmihdDGEk85NO/PpNEZ438qU2Elh62KoxP8syqOaX
 VyS05N9uZ9upo/2bggVaI8CwFnQDcqYUI8dqXLyEbMjPm6mD1dZwET9P2u/JMmoylkXF0FuW
 9gxZQ5i0Up6E4WlPq8l5o+oUxmI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebbc214.7fa93407ea78-smtp-out-n02;
 Wed, 13 May 2020 09:47:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D8A8C433BA; Wed, 13 May 2020 09:46:59 +0000 (UTC)
Received: from [192.168.0.102] (unknown [183.83.139.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3ABCEC432C2;
        Wed, 13 May 2020 09:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3ABCEC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: reset the zone->watermark_boost early
From:   Charan Teja Kalla <charante@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1589204408-5152-1-git-send-email-charante@codeaurora.org>
 <20200511131155.0b40ee443c3367e8f748b16f@linux-foundation.org>
 <1cf5e778-eae1-fc71-aed4-d84d664d79dd@codeaurora.org>
Message-ID: <ea46cdfd-526c-5109-2c09-263effb676dd@codeaurora.org>
Date:   Wed, 13 May 2020 15:16:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1cf5e778-eae1-fc71-aed4-d84d664d79dd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2020 7:01 PM, Charan Teja Kalla wrote:
> 
> Thank you Andrew for the reply.
> 
> On 5/12/2020 1:41 AM, Andrew Morton wrote:
>> On Mon, 11 May 2020 19:10:08 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:
>>
>>> Updating the zone watermarks by any means, like extra_free_kbytes,
>>> min_free_kbytes, water_mark_scale_factor e.t.c, when watermark_boost is
>>> set will result into the higher low and high watermarks than the user
>>> asks. This can be avoided by resetting the zone->watermark_boost to zero
>>> early.
>>
>> Does this solve some problem which has been observed in testing?

Sorry that I misunderstood your question. Yes it has solved problem of higher
water marks seen in the zone than what I set through min_free_kbytes.

Below are the steps I pursued to reproduce the problem
1) My system setup of Android kernel running on snapdragon hardware have the 
   below settings as default:
   #cat /proc/sys/vm/min_free_kbytes = 5162
   #cat /proc/zoneinfo | grep -e boost -e low -e "high " -e min -e Node
	Node 0, zone   Normal
        	min      797
	        low      8340
        	high     8539
        	boost    0 // This is the extra print I have added to check the boosting
2) Now I just try to change the zone watermark when the ->watermark_boost
   is greater than zero. I just write the same value of min_free_kbytes in 
   which case we should have seen the watermarks same as default(I mean of step 1)

   #echo 5162 > /proc/sys/vm/min_free_kbytes

   But I have seen very high values of watermarks in the system,
  # cat /proc/zoneinfo | grep -e boost -e low -e "high " -e min -e Node
	Node 0, zone   Normal
      	  min      797
      	  low      21148
      	  high     21347
      	  boost   0

So, yes, this problem is got fixed with the changes made in this patch.

> 
> Sorry, what are those issues observed in testing? It would be helpful
> If you post them here. 
> 
>>
>>> ...
>>>
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -7746,9 +7746,9 @@ static void __setup_per_zone_wmarks(void)
>>>  			    mult_frac(zone_managed_pages(zone),
>>>  				      watermark_scale_factor, 10000));
>>>  
>>> +		zone->watermark_boost = 0;
>>>  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>>>  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
>>> -		zone->watermark_boost = 0;
>>>  
>>>  		spin_unlock_irqrestore(&zone->lock, flags);
>>>  	}
>>
>> This could only be a problem if code is accessing these things without
>> holding zone->lock.  Is that ever the case?
>>
> 
> This is a problem even when accessing these things with zone->lock
> held because we are directly using the macro min_wmark_pages(zone)
> which leads to the issue. Pasting macro here for reference.
> 
> #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
> 
> Steps that lead to the issue is like below:
> 1) On the extfrag event, we try to boost the watermark by storing the
>    value in ->watermark_boost.
> 
> 2) User changes the value of extra|min_free_kbytes or watermark_scale_factor.
>   
>    In __setup_perzone_wmarks, we directly store the user asked
>    watermarks in the zones structure. In this step, the value
>    is always offsets by ->watermark_boost as we use the min_wmark_pages() macro.
> 
> 3) Later, when kswapd woke up, it resets the zone's watermark_boost to zero. 
> 
> Step 2 from the above is what resulting into the issue.
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
