Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE45C55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA78620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCR0glYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDWNPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726361AbgDWNPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:15:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A60C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:15:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so6784808wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Zo7rnxcWhUpGEGC0nWboNyq0EHY811ymcRqQTZrBts=;
        b=WCR0glYLeRqbNhxoWsBzFO6l5UUoaRoxjdKWZ2MbdNINhaKIRJRId4i1CXLryvSX2J
         z50vjVbdsB3EY59IywGT9xwebLEOHe3JouFr2pdgeJMGsvdX3QOsU/HWkdo3srqny1wh
         dqagNUm/QvHATmeU9aSJ1mpLMjIUo3/bZOMf4oXQ4ZcGf/WXCy8VXC5u/S890rSTrFuU
         0DBprcOdiRZ+hAqv/KzJBUFGYHpPmfh4NLDNzQsXhrNaWLpFX7SexeabHNSnDL3BitBH
         lYRjA9tZqMztK1Ky73ezr1OzrNBk9fm6Dp1cdbhgakwVF28lSgDfWSjGCbLXv2NPKsRC
         B5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Zo7rnxcWhUpGEGC0nWboNyq0EHY811ymcRqQTZrBts=;
        b=Bn13JlSfp/qGEMb5tZxOkpDzgh1N4fs3D6iSi24YU9JMav37RWwYWmR6BB4H3XvYkf
         DI4Kxf5YdJvbMPmhxdpcSaRvk25EADn2ovwfxqwTPJYdF5z/t51i98MCwbmwynnn7UeB
         hJthm0UkrFK/EkVLDq3vh4QIxEl9uoYqRph1vn+PJ6O5WYm9UW5hiiLJUJsbSc+y8R2v
         aBcc58wYgUhfLqfl8qaMoeCN6ZEZ5voFntqZch88giwHv4q1JC1mVJsNt+eLYgWcGvVg
         owNBwL3FGdagj+jiAudg5Tz0nbgx9YHFwCkhnzunxtuQmpOQ9old+5cSrPayWgbshuGw
         3OTQ==
X-Gm-Message-State: AGi0PuYnVVPAZv2Sqx/uF817s3gXNIt1d7BunaBA6y572L2mBJWK/Fs+
        OVJv/IMCgnHGw0epzFMlhrY=
X-Google-Smtp-Source: APiQypLaxp9NmdxBGBPIfKR5TavmFEm7Ppkn/eT6DNSWE0EeOB61kyNkpgW6pYT2y2Pc58nGR9KsNA==
X-Received: by 2002:a05:6000:1242:: with SMTP id j2mr4830499wrx.274.1587647709238;
        Thu, 23 Apr 2020 06:15:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 1sm3588747wmz.13.2020.04.23.06.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 06:15:08 -0700 (PDT)
Date:   Thu, 23 Apr 2020 13:15:07 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in
 scan_swap_map_slots()
Message-ID: <20200423131507.2rgrk3okh42oo6gh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
 <87d07y2181.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d07y2181.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:57:34PM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> After commit c60aa176c6de8 ("swapfile: swap allocation cycle if
>> nonrot"), swap allocation is cyclic. Current approach is done with two
>> separate loop on the upper and lower half. This looks a little
>> redundant.
>
>I can understand that the redundant code doesn't smell good.  But I
>don't think the new code is easier to be understood than the original
>one.
>
>> From another point of view, the loop iterates [lowest_bit, highest_bit]
>> range starting with (offset + 1) but except scan_base. So we can
>> simplify the loop with condition (next_offset() != scan_base) by
>> introducing next_offset() which makes sure offset fit in that range
>> with correct order.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Hugh Dickins <hughd@google.com>
>> CC: "Huang, Ying" <ying.huang@intel.com>
>>
>> ---
>> v2:
>>   * return scan_base if the lower part is eaten
>>   * only start over when iterating on the upper part
>> ---
>>  mm/swapfile.c | 31 ++++++++++++++-----------------
>>  1 file changed, 14 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index f903e5a165d5..0005a4a1c1b4 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -729,6 +729,19 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>>  	}
>>  }
>>  
>> +static unsigned long next_offset(struct swap_info_struct *si,
>> +				unsigned long *offset, unsigned long scan_base)
>> +{
>> +	/* only start over when iterating on the upper part */
>> +	if (++(*offset) > si->highest_bit && *offset > scan_base) {
>> +		*offset = si->lowest_bit;
>> +		/* someone has eaten the lower part */
>> +		if (si->lowest_bit >= scan_base)
>> +			return scan_base;
>> +	}
>
>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>scan_base need to be returned.
>

When this case would happen in the original code?

>Again, the new code doesn't make it easier to find this kind of issues.
>
>Best Regards,
>Huang, Ying

-- 
Wei Yang
Help you, Help me
