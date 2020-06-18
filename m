Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21685C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBA2207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nitingupta.dev header.i=@nitingupta.dev header.b="gzA2fpTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgFROZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgFROZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:25:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBDC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:25:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so637098pfn.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KmDh7WFGo8eDXXNvbv3E2VMAocRFdN201dDRse8FZ+Y=;
        b=gzA2fpTC0SesiwtZyor33GPfMnbM4NWLDMf3on76kw/J2V0qq6i3dU1DlwFqYs7GC0
         l0Dxz+U/ageOuVGpHsC2o9Pf97ZKuZcmGwK9/d5mfrvY5urDYazN1n2T1+FD3a5BGcUh
         spSui7Iz17tRuP0KJkOVyVdDlYsEC0BafwRUhyIIS1KUo4EbkDpvhQPqQD/1y2vXHbzM
         2pLXTibDMTN0VFpmDcqVTwyUEBsd05qfjKn9wemfCTQ+vqFnGbCJBkRU9q7b9pTIu8aC
         OLoZUZwtkXuHxsLQXSRL08hnlzS2wbcXP20P4+yIR5HDjcJo9f1GlpJziKGvMGrecI1I
         g0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KmDh7WFGo8eDXXNvbv3E2VMAocRFdN201dDRse8FZ+Y=;
        b=D35r32wxQbCFKXWCGojirfFsYqFNhj7fMeS8YVWaS2YOaH4p0JQFh5RantvC3wCWxc
         +05v3cVj+2h90fkuEaLHgjbwp/EvfSLO/AGZfiTfnyKJD/x/dx/D8q7XpR4xyzSo/NQy
         FiYEEwI/IDE8NpkXNg4A43ZABvRpTfQT9lWBj+saDWZViiCHK972VTb7mHIwLUYU4lK9
         O/u8K+Zy7VnYAqVFDUxah48D2yi85veiuBONzmQsTysuXUMudFYBfXvfU9IX+Hfp6xKX
         gzUdx/+/f0PXDmHpaD2aDxcBpaDbfddrBKwDAlOrI5W4GLtdWjY5Trukr6fbqOjRH5c5
         a3Bw==
X-Gm-Message-State: AOAM533ilUyJ1NgHG61bGLJEjUvNJWo0HULuO0LgctHlfr9Iy3wbRp/w
        2i/EnKE1hPdQ1cSLKZkf59Ti/A==
X-Google-Smtp-Source: ABdhPJzYcdMYYIIDStWXFb9/ybpnI+0+TvK2l0kB7vneujNkEsj61fZGyysLeBP0YtPyBWG7vxc8tQ==
X-Received: by 2002:a65:5c45:: with SMTP id v5mr3587952pgr.281.1592490299680;
        Thu, 18 Jun 2020 07:24:59 -0700 (PDT)
Received: from ngvpn01-160-57.dyn.scz.us.nvidia.com ([2601:646:9302:1050:5536:595e:70b0:cc78])
        by smtp.gmail.com with ESMTPSA id i26sm3046553pfo.0.2020.06.18.07.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 07:24:58 -0700 (PDT)
Subject: Re: [PATCH] mm: Use unsigned types for fragmentation score
To:     Baoquan He <bhe@redhat.com>, Nitin Gupta <nigupta@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20200618010319.13159-1-nigupta@nvidia.com>
 <20200618134142.GD3346@MiWiFi-R3L-srv>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Message-ID: <f2bac2a3-f14a-1156-23e5-eabfcee7141d@nitingupta.dev>
Date:   Thu, 18 Jun 2020 07:24:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618134142.GD3346@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 6:41 AM, Baoquan He wrote:
> On 06/17/20 at 06:03pm, Nitin Gupta wrote:
>> Proactive compaction uses per-node/zone "fragmentation score" which
>> is always in range [0, 100], so use unsigned type of these scores
>> as well as for related constants.
>>
>> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
>> ---
>>  include/linux/compaction.h |  4 ++--
>>  kernel/sysctl.c            |  2 +-
>>  mm/compaction.c            | 18 +++++++++---------
>>  mm/vmstat.c                |  2 +-
>>  4 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
>> index 7a242d46454e..25a521d299c1 100644
>> --- a/include/linux/compaction.h
>> +++ b/include/linux/compaction.h
>> @@ -85,13 +85,13 @@ static inline unsigned long compact_gap(unsigned int order)
>>  
>>  #ifdef CONFIG_COMPACTION
>>  extern int sysctl_compact_memory;
>> -extern int sysctl_compaction_proactiveness;
>> +extern unsigned int sysctl_compaction_proactiveness;
>>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>>  			void *buffer, size_t *length, loff_t *ppos);
>>  extern int sysctl_extfrag_threshold;
>>  extern int sysctl_compact_unevictable_allowed;
>>  
>> -extern int extfrag_for_order(struct zone *zone, unsigned int order);
>> +extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
>>  extern int fragmentation_index(struct zone *zone, unsigned int order);
>>  extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>>  		unsigned int order, unsigned int alloc_flags,
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 58b0a59c9769..40180cdde486 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2833,7 +2833,7 @@ static struct ctl_table vm_table[] = {
>>  	{
>>  		.procname	= "compaction_proactiveness",
>>  		.data		= &sysctl_compaction_proactiveness,
>> -		.maxlen		= sizeof(int),
>> +		.maxlen		= sizeof(sysctl_compaction_proactiveness),
> 
> Patch looks good to me. Wondering why not using 'unsigned int' here,
> just curious.
> 


It's just coding style preference. I see the same style used for many
other sysctls too (min_free_kbytes etc.).

Thanks,
Nitin

