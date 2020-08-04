Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0813C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AB822B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596533612;
	bh=aQKKqDy17ziHBCiv2d2dAf3VIZ1X8YFSH1m8utzGFbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u4ZleS5mDu976CJHJNXMA5ehs8a4T2OncH1PpB0ZS9bJnmBmnV7vGhHb/oDk4c4Hi
	 rEBg7LNpbLV4hkzT6v5u9TNRBmImWZQJc11+agsmwssgb4iQ3f0XkruRAUdYLoAiF5
	 oEoel8K9OIHKgbveIFEPa1R88CPyUTiguS6I5fgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHDJdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHDJda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:33:30 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23EF2086A;
        Tue,  4 Aug 2020 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596533610;
        bh=aQKKqDy17ziHBCiv2d2dAf3VIZ1X8YFSH1m8utzGFbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlGw7DAMoqf5Ljw2tkvh+4Zc7yYANPPF11nIJHparrvH9awTMgdBA/l/4hMXv5ewR
         rTyRZr1pq2S1h9EeB8nDnwZXRZVfYaWBSC2sFjVEYEmrVr6qbfggZeLyx0/Buv2kpj
         Fwyj/uPZqgNaRR68syGoX+0zNcfAUl1Pfv7mlo/w=
Date:   Tue, 4 Aug 2020 12:33:23 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 6/6] mm: document semantics of ZONE_MOVABLE
Message-ID: <20200804093323.GB8243@kernel.org>
References: <20200804072408.5481-1-david@redhat.com>
 <20200804072408.5481-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804072408.5481-7-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 09:24:08AM +0200, David Hildenbrand wrote:
> Let's document what ZONE_MOVABLE means, how it's used, and which special
> cases we have regarding unmovable pages (memory offlining vs. migration /
> allocations).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Several nits below, othersize

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mmzone.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index f6f884970511d..600d449e7d9e9 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -372,6 +372,40 @@ enum zone_type {
>  	 */
>  	ZONE_HIGHMEM,
>  #endif
> +	/*
> +	 * ZONE_MOVABLE is similar to ZONE_NORMAL, except that it *primarily*
> +	 * only contains movable pages. Main use cases are to make memory

"Primarily only" sounds awkward. Maybe

	... except that it only contains movable pages with few exceptional
	cases described below. 

And then 

	Main use cases for ZONE_MOVABLE are ...

> +	 * offlining more likely to succeed, and to locally limit unmovable
> +	 * allocations - e.g., to increase the number of THP/huge pages.
> +	 * Notable special cases are:
> +	 *
> +	 * 1. Pinned pages: (Long-term) pinning of movable pages might

		            ^long, capital L looked out of place for me

> +	 *    essentially turn such pages unmovable. Memory offlining might
> +	 *    retry a long time.
> +	 * 2. memblock allocations: kernelcore/movablecore setups might create
> +	 *    situations where ZONE_MOVABLE contains unmovable allocations
> +	 *    after boot. Memory offlining and allocations fail early.
> +	 * 3. Memory holes: Such pages cannot be allocated. Applies only to
> +	 *    boot memory, not hotplugged memory. Memory offlining and
> +	 *    allocations fail early.

I would clarify where page struct for abscent memory come from

> +	 * 4. PG_hwpoison pages: While poisoned pages can be skipped during
> +	 *    memory offlining, such pages cannot be allocated.
> +	 * 5. Unmovable PG_offline pages: In paravirtualized environments,
> +	 *    hotplugged memory blocks might only partially be managed by the
> +	 *    buddy (e.g., via XEN-balloon, Hyper-V balloon, virtio-mem). The
> +	 *    parts not manged by the buddy are unmovable PG_offline pages. In
> +	 *    some cases (virtio-mem), such pages can be skipped during
> +	 *    memory offlining, however, cannot be moved/allocated. These
> +	 *    techniques might use alloc_contig_range() to hide previously
> +	 *    exposed pages from the buddy again (e.g., to implement some sort
> +	 *    of memory unplug in virtio-mem).
> +	 *
> +	 * In general, no unmovable allocations that degrade memory offlining
> +	 * should end up in ZONE_MOVABLE. Allocators (like alloc_contig_range())
> +	 * have to expect that migrating pages in ZONE_MOVABLE can fail (even
> +	 * if has_unmovable_pages() states that there are no unmovable pages,
> +	 * there can be false negatives).
> +	 */
>  	ZONE_MOVABLE,
>  #ifdef CONFIG_ZONE_DEVICE
>  	ZONE_DEVICE,
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
