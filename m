Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB7C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158D020719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585771098;
	bh=2mhILg0bSugkh1BT3B2Cb/X9VgSVEXTdJSigKSRVuUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gFzxkkAQ5xews5uOqehBDrkkBx/O2jMx1z269uzPRt2ySvK50BzFF/IRINwwC14jJ
	 h4P9MtzOVaw8i6nftwTO2/62TcUqI3uLj/ah1YjQk4eurF6qvj9TRY/8H9ebCpxCdg
	 hLTtjHdhcNFPUuJn7CmOrjdMNvzXl/hWCWpSfoow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgDAT6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:58:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47038 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbgDAT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:58:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so1491642wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 12:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMwC7Ow1BhaKidjzqGN+TLI1c7T2E6r0Gwj56dB3pj8=;
        b=hhebMX3MnvCFW3gNWgPDiwtQUzcBNR97ex07BPxJ6xnx++qF1dQS/ESToYK1Depvsj
         kbGf46YVbPdyNT7zOebpcr8eU5jG4t5fdVOOA5JuXlx/v4DgOk8BA1ZQ5aER1QUxejv0
         Mon2e063NdWHFDRM0gDM/oTZLvyBvli69hRYe/KoEUrdDIIGqSSzMdbVFpj1/A25nMsC
         vqP61GDF5CTfOZ/94Q0f+xxTL2cUC6pROVzLmf+5T4Ps/jZecRQYZYsHO5EZPnghzoAQ
         AtuiKcHWF+bFQZaRp/dY7zke6lPQMmNw6yM6rn0cqOdHG1YcEuDi5Qv3j0c9AoENe0Th
         v8zg==
X-Gm-Message-State: ANhLgQ3jvdJZBL84dIZwn6q8+XESb2rIcT8bzswxn5O/3wQTo6tBNDPA
        Of61yqDBy9Bq8fS4bQ6Xcg4=
X-Google-Smtp-Source: ADFU+vtzrgwB9GrelE4K+wWscH7hXAQNbr8+HwyinHoIwxKJs0vWKvLo+Cn0lq5i+PQmi5gaFFtJnA==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr27584519wre.412.1585771094276;
        Wed, 01 Apr 2020 12:58:14 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id w9sm4324853wrk.18.2020.04.01.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:58:13 -0700 (PDT)
Date:   Wed, 1 Apr 2020 21:58:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
Message-ID: <20200401195812.GA22681@dhcp22.suse.cz>
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401193238.22544-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btw. Cc Vlastimil

On Wed 01-04-20 15:32:38, Pavel Tatashin wrote:
> Initializing struct pages is a long task and keeping interrupts disabled
> for the duration of this operation introduces a number of problems.
> 
> 1. jiffies are not updated for long period of time, and thus incorrect time
>    is reported. See proposed solution and discussion here:
>    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> 2. It prevents farther improving deferred page initialization by allowing
>    inter-node multi-threading.
> 
> We are keeping interrupts disabled to solve a rather theoretical problem
> that was never observed in real world (See 3a2d7fa8a3d5).
> 
> Lets keep interrupts enabled. In case we ever encounter a scenario where
> an interrupt thread wants to allocate large amount of memory this early in
> boot we can deal with that by growing zone (see deferred_grow_zone()) by
> the needed amount before starting deferred_init_memmap() threads.
> 
> Before:
> [    1.232459] node 0 initialised, 12058412 pages in 1ms
> 
> After:
> [    1.632580] node 0 initialised, 12051227 pages in 436ms
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/page_alloc.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..4498a13b372d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1792,6 +1792,13 @@ static int __init deferred_init_memmap(void *data)
>  	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
>  	pgdat->first_deferred_pfn = ULONG_MAX;
>  
> +	/*
> +	 * Once we unlock here, the zone cannot be grown anymore, thus if an
> +	 * interrupt thread must allocate this early in boot, zone must be
> +	 * pre-grown prior to start of deferred page initialization.
> +	 */
> +	pgdat_resize_unlock(pgdat, &flags);
> +
>  	/* Only the highest zone is deferred so find it */
>  	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>  		zone = pgdat->node_zones + zid;
> @@ -1812,8 +1819,6 @@ static int __init deferred_init_memmap(void *data)
>  	while (spfn < epfn)
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>  zone_empty:
> -	pgdat_resize_unlock(pgdat, &flags);
> -
>  	/* Sanity check that the next zone really is unpopulated */
>  	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
>  
> @@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  		return false;
>  
>  	pgdat_resize_lock(pgdat, &flags);
> -
> -	/*
> -	 * If deferred pages have been initialized while we were waiting for
> -	 * the lock, return true, as the zone was grown.  The caller will retry
> -	 * this zone.  We won't return to this function since the caller also
> -	 * has this static branch.
> -	 */
> -	if (!static_branch_unlikely(&deferred_pages)) {
> -		pgdat_resize_unlock(pgdat, &flags);
> -		return true;
> -	}
> -
>  	/*
>  	 * If someone grew this zone while we were waiting for spinlock, return
>  	 * true, as there might be enough pages already.
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
