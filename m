Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECF5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809D92071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592840248;
	bh=w+n3GXMx1WtB5UHv7VqoBHtI52Yq6xS8QD01kcbCUA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fad+LkcDeMolA2KxIVKklKiyBdzsP8ZGjSV6rJdqIJ9zQFi3oBNErdDTSy2TwgHwB
	 kp/TIOsOCx9Njjg3ahzYJoR1TdPrBuRZ7ECD7DukOS8LMQLuB5s94aq6bvZombQaYu
	 aXeGKiTkuqqzapvP8M0O7UWvGobQOrsRV2UzniXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgFVPh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:37:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45777 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgFVPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:37:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so17106918wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiJ5TZjSRnSbkwESwPasgJWLT9F9zu3NMWdA7xdTANU=;
        b=rW6IVFVYpoBAZsFawfm4DSRhQfQCkifQAwFqRHeIZhzYgqlrSK+WHwPEfDWK9JLgvr
         VGYX88zPt9r8Yj/irQlhiFgoTxWVJ/SIplc0VZuNbR6DS1riKRpmdukme5A8cIxs5tzc
         6iiCnsRp7qXCOBw+2jODNSnPd7RPE4VhD0KYY06eEvbHdymBmmkWnl5x1/NSugzMVcX1
         6dAl92r2eb2I/6i27NbqnpLvPqhkZ04PNpWMRYek8qtOSkF0X4GpmRyuuINLkj6+7KpC
         6w5K9tfz1rrawesFuTJeZrPIzLpGs+ORMhZe5eFCbZztRjNrmkGUZLUzO4R8LzV2uQ+o
         WZGg==
X-Gm-Message-State: AOAM532qTX2azeKDBWU4ri6e+qisandPN6NxtWdd+REpUw8Kp688+3sy
        blYqluBeGhnNouNytxRYNFM=
X-Google-Smtp-Source: ABdhPJxK5y2wIis0CHcxEXbB3wQ7gwgnUyqHchK/etrSgy/TSoi/MZM30ajjys2QFNc1qNU5mlXbTw==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr19658661wro.151.1592840240912;
        Mon, 22 Jun 2020 08:37:20 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id w14sm18498114wrt.55.2020.06.22.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:37:20 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:37:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] mm/shuffle: remove dynamic reconfiguration
Message-ID: <20200622153719.GI31426@dhcp22.suse.cz>
References: <20200619125923.22602-1-david@redhat.com>
 <20200619125923.22602-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619125923.22602-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-06-20 14:59:22, David Hildenbrand wrote:
> Commit e900a918b098 ("mm: shuffle initial free memory to improve
> memory-side-cache utilization") promised "autodetection of a
> memory-side-cache (to be added in a follow-on patch)" over a year ago.
> 
> The original series included patches [1], however, they were dropped
> during review [2] to be followed-up later.
> 
> Due to lack of platforms that publish an HMAT, autodetection is currently
> not implemented. However, manual activation is actively used [3]. Let's
> simplify for now and re-add when really (ever?) needed.
> 
> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com
> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com
> [3] https://lkml.kernel.org/r/CAPcyv4irwGUU2x+c6b4L=KbB1dnasNKaaZd6oSpYjL9kfsnROQ@mail.gmail.com
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/shuffle.c | 28 ++--------------------------
>  mm/shuffle.h | 17 -----------------
>  2 files changed, 2 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index dd13ab851b3ee..9b5cd4b004b0f 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -10,33 +10,11 @@
>  #include "shuffle.h"
>  
>  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
> -static unsigned long shuffle_state __ro_after_init;
> -
> -/*
> - * Depending on the architecture, module parameter parsing may run
> - * before, or after the cache detection. SHUFFLE_FORCE_DISABLE prevents,
> - * or reverts the enabling of the shuffle implementation. SHUFFLE_ENABLE
> - * attempts to turn on the implementation, but aborts if it finds
> - * SHUFFLE_FORCE_DISABLE already set.
> - */
> -__meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
> -{
> -	if (ctl == SHUFFLE_FORCE_DISABLE)
> -		set_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state);
> -
> -	if (test_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state)) {
> -		if (test_and_clear_bit(SHUFFLE_ENABLE, &shuffle_state))
> -			static_branch_disable(&page_alloc_shuffle_key);
> -	} else if (ctl == SHUFFLE_ENABLE
> -			&& !test_and_set_bit(SHUFFLE_ENABLE, &shuffle_state))
> -		static_branch_enable(&page_alloc_shuffle_key);
> -}
>  
>  static bool shuffle_param;
>  static int shuffle_show(char *buffer, const struct kernel_param *kp)
>  {
> -	return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
> -			? 'Y' : 'N');
> +	return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
>  }
>  
>  static __meminit int shuffle_store(const char *val,
> @@ -47,9 +25,7 @@ static __meminit int shuffle_store(const char *val,
>  	if (rc < 0)
>  		return rc;
>  	if (shuffle_param)
> -		page_alloc_shuffle(SHUFFLE_ENABLE);
> -	else
> -		page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
> +		static_branch_enable(&page_alloc_shuffle_key);
>  	return 0;
>  }
>  module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index 4d79f03b6658f..71b784f0b7c3e 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -4,23 +4,10 @@
>  #define _MM_SHUFFLE_H
>  #include <linux/jump_label.h>
>  
> -/*
> - * SHUFFLE_ENABLE is called from the command line enabling path, or by
> - * platform-firmware enabling that indicates the presence of a
> - * direct-mapped memory-side-cache. SHUFFLE_FORCE_DISABLE is called from
> - * the command line path and overrides any previous or future
> - * SHUFFLE_ENABLE.
> - */
> -enum mm_shuffle_ctl {
> -	SHUFFLE_ENABLE,
> -	SHUFFLE_FORCE_DISABLE,
> -};
> -
>  #define SHUFFLE_ORDER (MAX_ORDER-1)
>  
>  #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
>  DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
> -extern void page_alloc_shuffle(enum mm_shuffle_ctl ctl);
>  extern void __shuffle_free_memory(pg_data_t *pgdat);
>  extern bool shuffle_pick_tail(void);
>  static inline void shuffle_free_memory(pg_data_t *pgdat)
> @@ -58,10 +45,6 @@ static inline void shuffle_zone(struct zone *z)
>  {
>  }
>  
> -static inline void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
> -{
> -}
> -
>  static inline bool is_shuffle_order(int order)
>  {
>  	return false;
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
