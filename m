Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A40208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e60NHLWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgFSNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbgFSNtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:49:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9209FC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:49:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p20so10217476ejd.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUtUDEO7uf8o43KeJMaFdOcK00bicL+aAydzipPJiTc=;
        b=e60NHLWcKqhOgckYZvip4+wgTCow8xCgDxmiX7YmqWMlDkR6vBV1/ANbbt3Tzm+fJO
         8u7a2Ml3mC5DqqUx0blDwxN6UbZYcegv5rOFpWtY6/1sH12Q49LqCyaMsx1y7D5PnbLc
         a4ZegSYFt9YBGouzbDTO0Q3jtyZ+PJJXNej9ulhatCCjMecTY/49oyiJy0xntlncZAFE
         ET1EqfaRPnouVIVqXtDx85WpXi8Uu9nLKLdZaQa2PKFEQH1PFvGysYn4w9xJFLfY9ob5
         fA1NW8nRFndUSfGB/95VYLOC/QDvN6r6s/vLKCVLFz3lxWya3T2yvegtOt5U+hDpA2Rp
         vKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUtUDEO7uf8o43KeJMaFdOcK00bicL+aAydzipPJiTc=;
        b=Sbp4VaVYJ7IIIp2iE2XZk5xyHrUWiBvx1vEFVw7+hMyJ/TxSqHUTNHLLPx3qj+fRu5
         F7+oe/g1Hdircb7GJ1Zl9V0dKuzdwDSEKva0cvqtigAq6sOGbPbrJWxbj7efsNgwlRQD
         zU8LS/5FKRPHiygUfT9Kwt6ehhweU8gR/DDr8wtynWEmT8n56yigoDDeXgDAwJEwZIvi
         iNkdbfirnSBOhqHo8Htsq+EtWcMB6mV4D63MRwxsFiLJjLk1oTyC3USOT4H4ijgnX/hj
         ebwC56cjh0shADQtbTrBWkJYaw6Pt97L+nHaRNTnMAWQApbWY0dFnWk2lSintTE1CEFN
         w7qw==
X-Gm-Message-State: AOAM530MKiZQ493APCSGBNSBJpakC14yX9lQmZjzs5zkDF0j+3WebOJe
        GIHihE747UAa4M79lNRmMmM=
X-Google-Smtp-Source: ABdhPJxK6SYrZibXfR28eJB0dt69s0oNEDnQDtEFzrrFIVG4kD2b+rHebv1bcfRpQfooX3l5UXn6/g==
X-Received: by 2002:a17:906:ca54:: with SMTP id jx20mr3724564ejb.549.1592574539717;
        Fri, 19 Jun 2020 06:48:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s15sm4647901edw.54.2020.06.19.06.48.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 06:48:58 -0700 (PDT)
Date:   Fri, 19 Jun 2020 13:48:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: drop nr_free_pagecache_pages()
Message-ID: <20200619134858.hviovr5ysjikdnz7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200619132410.23859-1-david@redhat.com>
 <20200619132410.23859-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619132410.23859-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:24:10PM +0200, David Hildenbrand wrote:
>nr_free_pagecache_pages() isn't used outside page_alloc.c anymore - and
>the name does not really help to understand what's going on. Let's inline
>it instead and add a comment.

Not sure "inline it" is the proper word for this.

>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Minchan Kim <minchan@kernel.org>
>Cc: Huang Ying <ying.huang@intel.com>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Besides:

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> include/linux/swap.h |  1 -
> mm/page_alloc.c      | 16 ++--------------
> 2 files changed, 2 insertions(+), 15 deletions(-)
>
>diff --git a/include/linux/swap.h b/include/linux/swap.h
>index 124261acd5d0a..9bde6c6b2c045 100644
>--- a/include/linux/swap.h
>+++ b/include/linux/swap.h
>@@ -327,7 +327,6 @@ void workingset_update_node(struct xa_node *node);
> /* linux/mm/page_alloc.c */
> extern unsigned long totalreserve_pages;
> extern unsigned long nr_free_buffer_pages(void);
>-extern unsigned long nr_free_pagecache_pages(void);
> 
> /* Definition of global_zone_page_state not available yet */
> #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 7b0dde69748c1..c38903d1b3b4d 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5177,19 +5177,6 @@ unsigned long nr_free_buffer_pages(void)
> }
> EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
> 
>-/**
>- * nr_free_pagecache_pages - count number of pages beyond high watermark
>- *
>- * nr_free_pagecache_pages() counts the number of pages which are beyond the
>- * high watermark within all zones.
>- *
>- * Return: number of pages beyond high watermark within all zones.
>- */
>-unsigned long nr_free_pagecache_pages(void)
>-{
>-	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
>-}
>-
> static inline void show_node(struct zone *zone)
> {
> 	if (IS_ENABLED(CONFIG_NUMA))
>@@ -5911,7 +5898,8 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
> 		__build_all_zonelists(pgdat);
> 		/* cpuset refresh routine should be here */
> 	}
>-	vm_total_pages = nr_free_pagecache_pages();
>+	/* Get the number of free pages beyond high watermark in all zones. */
>+	vm_total_pages = nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
> 	/*
> 	 * Disable grouping by mobility if the number of pages in the
> 	 * system is too low to allow the mechanism to work. It would be
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
