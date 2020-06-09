Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E062207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591706676;
	bh=+Ob6dSwNuEipVPooYZ+WdYEkmy6+SEZVsHUeHbDqUF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3oMO/gYYwn8GD6DHUdFVVJ3zqWaEkpFXvonla6zsqJmtK3FFExG+sYpasbrgGTWp
	 qxFzZbgWR2YwzjwP5oQZilTOdiOCqQdAPmmqs0hzvQrt+U+L9saVsKMDQvdg86YxLo
	 cm7M9GZBPbF4CVdwK/hTuSuEcbXce2wf0qJIoSFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgFIMof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:44:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56264 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFIMoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:44:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id c71so2684680wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bUQBLKaV0rY++J1kBEYJ4YPNIo1mi5EzugMLZWIn43Q=;
        b=alISAaXqI7zWCQulHuU/hcwu27KfeHc7JphQyXybpXCaZMkv7yA06SRq5m4Q3GlU2g
         vu4iq1J9WTjAchER+xTNCK7+s6OLeZcf1otRZwjVA3SdA6vDb7Sy2tmytWCdloa83TWz
         9Gip8X727whYLac6dbFo2Uld7FO53S9slHgWRQacvJhO1vpjqEqQdEeMWZzT4CiQqWZG
         XvsPnbf5EdsjCeG/57wIXwzfMBiMRKbAiMP/jZdME+IdMsbQR1q7QxZ1Ud8zAPOlpNoq
         nMbXZHCjb0KYMRO45lRBeowchHsyvOT/ggMEN1/jBLW+3MS5wCD4LJXDAN4XKMLSKBYc
         CCCw==
X-Gm-Message-State: AOAM531YV11aI+6cnljv2286M7eJ0y5N2zttKc/99O57bUkvi5AaPUQr
        i8Xzgzho12Uj7pQjLAQHy/I=
X-Google-Smtp-Source: ABdhPJzb2sh3iX+SD2l+aAZZxwA5hfV9JkiFsghd22abF8GC87Hoh5tSfr9vbVoOozVFyrm/rpQwvw==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr3722092wml.108.1591706672380;
        Tue, 09 Jun 2020 05:44:32 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id p16sm3438105wru.27.2020.06.09.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 05:44:31 -0700 (PDT)
Date:   Tue, 9 Jun 2020 14:44:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 02/12] mm/migrate: move migration helper from .h to .c
Message-ID: <20200609124430.GD22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-3-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:53, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> It's not performance sensitive function. Move it to .c.
> This is a preparation step for future change.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/migrate.h | 33 +++++----------------------------
>  mm/migrate.c            | 29 +++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3e546cb..1d70b4a 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -31,34 +31,6 @@ enum migrate_reason {
>  /* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
>  extern const char *migrate_reason_names[MR_TYPES];
>  
> -static inline struct page *new_page_nodemask(struct page *page,
> -				int preferred_nid, nodemask_t *nodemask)
> -{
> -	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> -	unsigned int order = 0;
> -	struct page *new_page = NULL;
> -
> -	if (PageHuge(page))
> -		return alloc_huge_page_nodemask(page_hstate(compound_head(page)),
> -				preferred_nid, nodemask);
> -
> -	if (PageTransHuge(page)) {
> -		gfp_mask |= GFP_TRANSHUGE;
> -		order = HPAGE_PMD_ORDER;
> -	}
> -
> -	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
> -		gfp_mask |= __GFP_HIGHMEM;
> -
> -	new_page = __alloc_pages_nodemask(gfp_mask, order,
> -				preferred_nid, nodemask);
> -
> -	if (new_page && PageTransHuge(new_page))
> -		prep_transhuge_page(new_page);
> -
> -	return new_page;
> -}
> -
>  #ifdef CONFIG_MIGRATION
>  
>  extern void putback_movable_pages(struct list_head *l);
> @@ -67,6 +39,8 @@ extern int migrate_page(struct address_space *mapping,
>  			enum migrate_mode mode);
>  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>  		unsigned long private, enum migrate_mode mode, int reason);
> +extern struct page *new_page_nodemask(struct page *page,
> +		int preferred_nid, nodemask_t *nodemask);
>  extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>  extern void putback_movable_page(struct page *page);
>  
> @@ -85,6 +59,9 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
>  		free_page_t free, unsigned long private, enum migrate_mode mode,
>  		int reason)
>  	{ return -ENOSYS; }
> +static inline struct page *new_page_nodemask(struct page *page,
> +		int preferred_nid, nodemask_t *nodemask)
> +	{ return NULL; }
>  static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	{ return -EBUSY; }
>  
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 22a26a5..824c22e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1537,6 +1537,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	return rc;
>  }
>  
> +struct page *new_page_nodemask(struct page *page,
> +				int preferred_nid, nodemask_t *nodemask)
> +{
> +	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> +	unsigned int order = 0;
> +	struct page *new_page = NULL;
> +
> +	if (PageHuge(page))
> +		return alloc_huge_page_nodemask(
> +				page_hstate(compound_head(page)),
> +				preferred_nid, nodemask);
> +
> +	if (PageTransHuge(page)) {
> +		gfp_mask |= GFP_TRANSHUGE;
> +		order = HPAGE_PMD_ORDER;
> +	}
> +
> +	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
> +		gfp_mask |= __GFP_HIGHMEM;
> +
> +	new_page = __alloc_pages_nodemask(gfp_mask, order,
> +				preferred_nid, nodemask);
> +
> +	if (new_page && PageTransHuge(new_page))
> +		prep_transhuge_page(new_page);
> +
> +	return new_page;
> +}
> +
>  #ifdef CONFIG_NUMA
>  
>  static int store_status(int __user *status, int start, int value, int nr)
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
