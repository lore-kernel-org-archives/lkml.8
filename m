Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C3BC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7D2137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585755743;
	bh=4/vpXD5xtz7lIUYQ/tf1WcP5BjJDoVhxRF2aKX0WKzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bk5HN9cWN2X4T2yCJ8bjNfhWvgblQjrERauUU00xWCBwMZjR65u5XB5cu9bpCzISS
	 Kgp6NCf2tvTlnMfAbFXaCU/O6szvB6XiwdoX/+zxBDiqLGlmfX+4U+2HZPiAPsNB8z
	 /SRCMojtBYo+jT/58Bk7+5A9KQIZBXbp1+kgwbxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbgDAPmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:42:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38099 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732849AbgDAPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:42:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so215603wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qh51pqUcxSK1vy6HHAY3PK3fGGZoLe1l0UQDBNVaGW8=;
        b=MgqrVMHsgPreWBYx9E0FR9r9m2pNuofHguq7cWRktHqq8yLtiHNUFO1oq3xPCyWSRr
         X8Sya023KPrnSPpKknolCwtzZPbx0CBduJ14CCUZjtFs7VsRLGJcQ/bxjgvx3g2l5pO6
         IUdRojgcMEPygmhC0UnHKJZbRRA0uj03NQbhg/buh3f1LG3yUnTN2bAibohrvgcDbsSZ
         0gm1bO3WRo8CHes/nw+Uk58iAYyXpKl6ayd7QMDQqLbo68x0exqt4r84f49qXHJs80gg
         Hr0PCXHia4VpOBdW1E79Z0rkoVz/bKK00pU5gmAE0U4ok3aNfNE/EhLWCO02UQysLGbe
         QbBg==
X-Gm-Message-State: AGi0PuZITlsLLnT6J6ZRr912O9ZPmLk1hJZ/Ch+vYxB2lbGgh8SyeB6w
        FzvSxQHt1oXMslZQUqFjQ8g=
X-Google-Smtp-Source: APiQypKfZZzePopjzy6XhMXAehJzcOCmIFHyJEDfDiqCyC+Lo4Awo+YvRWIG0adATkzNq+8IjdVjZw==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr5284608wmc.68.1585755740307;
        Wed, 01 Apr 2020 08:42:20 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id g2sm3322729wrs.42.2020.04.01.08.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:42:19 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:42:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401154217.GQ22681@dhcp22.suse.cz>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry but I have completely missed this patch.

On Wed 11-03-20 20:38:48, Shile Zhang wrote:
> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> initialise the deferred pages with local interrupts disabled. It is
> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> initializing deferred pages").
> 
> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
> the boot CPU, which could caused the tick timer long time stall, system
> jiffies not be updated in time.
> 
> The dmesg shown that:
> 
>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
> 
> Obviously, 1ms is unreasonable.
> 
> Now, fix it by restore in the pending interrupts for every 32*1204 pages
> (128MB) initialized, give the chance to update the systemd jiffies.
> The reasonable demsg shown likes:
> 
>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
> 
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").

I dislike this solution TBH. It effectivelly conserves the current code
and just works around the problem. Why do we hold the IRQ lock here in
the first place? This is an early init code and a very limited code is
running at this stage. Certainly nothing memory hotplug related which
should be the only path really interested in the resize lock AFAIR.

This needs a double checking but I strongly believe that the lock can be
simply dropped in this path.
 
> Co-developed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..a3a47845e150 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1763,12 +1763,17 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
>  	return nr_pages;
>  }
>  
> +/*
> + * Release the pending interrupts for every TICK_PAGE_COUNT pages.
> + */
> +#define TICK_PAGE_COUNT	(32 * 1024)
> +
>  /* Initialise remaining memory on a node */
>  static int __init deferred_init_memmap(void *data)
>  {
>  	pg_data_t *pgdat = data;
>  	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> -	unsigned long spfn = 0, epfn = 0, nr_pages = 0;
> +	unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>  	unsigned long first_init_pfn, flags;
>  	unsigned long start = jiffies;
>  	struct zone *zone;
> @@ -1779,6 +1784,7 @@ static int __init deferred_init_memmap(void *data)
>  	if (!cpumask_empty(cpumask))
>  		set_cpus_allowed_ptr(current, cpumask);
>  
> +again:
>  	pgdat_resize_lock(pgdat, &flags);
>  	first_init_pfn = pgdat->first_deferred_pfn;
>  	if (first_init_pfn == ULONG_MAX) {
> @@ -1790,7 +1796,6 @@ static int __init deferred_init_memmap(void *data)
>  	/* Sanity check boundaries */
>  	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
>  	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
> -	pgdat->first_deferred_pfn = ULONG_MAX;
>  
>  	/* Only the highest zone is deferred so find it */
>  	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> @@ -1809,9 +1814,23 @@ static int __init deferred_init_memmap(void *data)
>  	 * that we can avoid introducing any issues with the buddy
>  	 * allocator.
>  	 */
> -	while (spfn < epfn)
> +	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		/*
> +		 * Release the interrupts for every TICK_PAGE_COUNT pages
> +		 * (128MB) to give tick timer the chance to update the
> +		 * system jiffies.
> +		 */
> +		if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
> +			prev_nr_pages = nr_pages;
> +			pgdat->first_deferred_pfn = spfn;
> +			pgdat_resize_unlock(pgdat, &flags);
> +			goto again;
> +		}
> +	}
> +
>  zone_empty:
> +	pgdat->first_deferred_pfn = ULONG_MAX;
>  	pgdat_resize_unlock(pgdat, &flags);
>  
>  	/* Sanity check that the next zone really is unpopulated */
> -- 
> 2.24.0.rc2

-- 
Michal Hocko
SUSE Labs
