Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5B62071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592311287;
	bh=GapVHlGrEsAm/jQ1JmT48SYnP3RJMi9sGHYp7hQgRwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mnt/9rEJeB+XHt6hcm5r6oq5CxybBFdvnzdB1y3dt25IEzzoLZnMy8DxJAos+iAdR
	 wyhXFAxLPhZ+dlUSVWv8sMnZMKaXNBKbxKCJzjhMPscRcKwGzVSPUFyQDq3BcO6CkG
	 BAftrRUH96/fbNRO4p2soeLfBYa21XuGbpAmzl2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFPMl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:41:26 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33895 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:41:24 -0400
Received: by mail-ej1-f66.google.com with SMTP id l27so21371198ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lvZ/JU8ey+1c4FuAoLVPy6uRu909Wdq/geZLMcxwUQ=;
        b=RvSk69ZFYiWAk2Cuq2VV0pSN/mlTf8+nubnxEai9uoEaRPiMrmYWb/PpgYyWZrovPd
         KaqxipCOkVKX+kMIYcq56c6ZYTztOSIAku2dLtRsjLAXflAjZgnF2NHRezJ4KG+mvbgX
         khMgj0rvlbnY0TGVSRN8kokTndFpXHZzuZ8nVHnJ4/W6eJWF5W13ISx/CRJnPkNbILzC
         uCs2zuldHWy+qJDJC4PkabIb/J3CHpVmK5KRwsw0IsAhb4jTDuILAx5ariUV9gFzkC5s
         M9vvdBVy1vvNGFnWmr3HH4IwCfvjSzjY5Jn6n7eNj+Ve8+Xmk3c2r9xFJljp5jLFaMy/
         CIBw==
X-Gm-Message-State: AOAM5333aQPGB4KR3JVd1wrl5OHg7/OzOI90qWCWOvZgOlHTJuq5mUBu
        p+iTGGCEMaOAeSTTNyhNfyYjptdR
X-Google-Smtp-Source: ABdhPJzD8qpDXrZl8rGpMKuZYO2zkPwUOexq1hIGe4/xU7UpT88gdrUmRb3LMXNgcPz9A38HWH0ZrA==
X-Received: by 2002:a17:907:4096:: with SMTP id nm6mr2596358ejb.4.1592311282608;
        Tue, 16 Jun 2020 05:41:22 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id o24sm10875556ejb.72.2020.06.16.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:41:21 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:41:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v1 3/3] mm/shuffle: remove dynamic reconfiguration
Message-ID: <20200616124120.GF9499@dhcp22.suse.cz>
References: <20200616115213.13109-1-david@redhat.com>
 <20200616115213.13109-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616115213.13109-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Add Dan]

On Tue 16-06-20 13:52:13, David Hildenbrand wrote:
> Commit e900a918b098 ("mm: shuffle initial free memory to improve
> memory-side-cache utilization") promised "autodetection of a
> memory-side-cache (to be added in a follow-on patch)" over a year ago.
> 
> The original series included patches [1], however, they were dropped
> during review [2] to be followed-up later.
> 
> Let's simplify for now and re-add when really (ever?) needed.
> 
> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com/
> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: David Hildenbrand <david@redhat.com>

While I am not against removing this unused code I am really curious
what is the future of the auto detection. Has this just fall through
cracks or there are some more serious problem to make detection
possible/reliable?

> ---
>  mm/shuffle.c | 28 ++--------------------------
>  mm/shuffle.h | 17 -----------------
>  2 files changed, 2 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index 609c26aa57db0..702c0d5cf276c 100644
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
> index 657e2b9ec38dd..5574cbd4611e3 100644
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
> @@ -46,10 +33,6 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
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
