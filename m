Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F168C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416DE206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PeWJGwrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgELNcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:32:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35946 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgELNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:32:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589290332; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Pnp7vCHkgD7FucXCkrRb8JTH8OxBN3TyDHzUXyTSUpI=; b=PeWJGwrlLWaUfCWUv0nsPzq5p/xBmxCoTFaXjjhjPpUo35ZPOVnK8LY1Ui5Yvd5VB9GDpREe
 JtX1wG84KlgdkAn+zC4hxfotNIJ8w6Co1KiLXmyGFJmPRL05G9Zsr+TXhTdIlW4KIS5rkMu3
 G1YS4VF8wThAQ6dtdE72eK2WVl0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebaa538.7f2f9deb0a78-smtp-out-n02;
 Tue, 12 May 2020 13:31:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13511C433BA; Tue, 12 May 2020 13:31:35 +0000 (UTC)
Received: from [192.168.0.102] (unknown [183.83.139.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BEBEC433CB;
        Tue, 12 May 2020 13:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BEBEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: reset the zone->watermark_boost early
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1589204408-5152-1-git-send-email-charante@codeaurora.org>
 <20200511131155.0b40ee443c3367e8f748b16f@linux-foundation.org>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <1cf5e778-eae1-fc71-aed4-d84d664d79dd@codeaurora.org>
Date:   Tue, 12 May 2020 19:01:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511131155.0b40ee443c3367e8f748b16f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you Andrew for the reply.

On 5/12/2020 1:41 AM, Andrew Morton wrote:
> On Mon, 11 May 2020 19:10:08 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:
> 
>> Updating the zone watermarks by any means, like extra_free_kbytes,
>> min_free_kbytes, water_mark_scale_factor e.t.c, when watermark_boost is
>> set will result into the higher low and high watermarks than the user
>> asks. This can be avoided by resetting the zone->watermark_boost to zero
>> early.
> 
> Does this solve some problem which has been observed in testing?

Sorry, what are those issues observed in testing? It would be helpful
If you post them here. 

> 
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7746,9 +7746,9 @@ static void __setup_per_zone_wmarks(void)
>>  			    mult_frac(zone_managed_pages(zone),
>>  				      watermark_scale_factor, 10000));
>>  
>> +		zone->watermark_boost = 0;
>>  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>>  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
>> -		zone->watermark_boost = 0;
>>  
>>  		spin_unlock_irqrestore(&zone->lock, flags);
>>  	}
> 
> This could only be a problem if code is accessing these things without
> holding zone->lock.  Is that ever the case?
> 

This is a problem even when accessing these things with zone->lock
held because we are directly using the macro min_wmark_pages(zone)
which leads to the issue. Pasting macro here for reference.

#define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)

Steps that lead to the issue is like below:
1) On the extfrag event, we try to boost the watermark by storing the
   value in ->watermark_boost.

2) User changes the value of extra|min_free_kbytes or watermark_scale_factor.
  
   In __setup_perzone_wmarks, we directly store the user asked
   watermarks in the zones structure. In this step, the value
   is always offsets by ->watermark_boost as we use the min_wmark_pages() macro.

3) Later, when kswapd woke up, it resets the zone's watermark_boost to zero. 

Step 2 from the above is what resulting into the issue.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
