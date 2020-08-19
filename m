Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C70F2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597807100;
	bh=N1Hg73ubDcpjGJDJGT5jZegR8KHLiNUqoVxQYzYXmq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0YM5Wf62X379hMjhftpa6X/UvKaKg3zm8zdiahd/3Qrgge/3l6INSNdr1w0mcIjhY
	 KMYS+cGoaKEMiMODaxdwUPCCmzyFJnG8QBb0RT1OJaW73VO1hPRs49Tz94yhHRKFnp
	 qhL5LY/Vir+/5aEhoYetsshCv6758kFaDBM+/dtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHSDST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgHSDSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:18:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD21E20639;
        Wed, 19 Aug 2020 03:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597807097;
        bh=N1Hg73ubDcpjGJDJGT5jZegR8KHLiNUqoVxQYzYXmq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q4eHZB3jmK/o9r6C1qNxrrxqLIH78fh4WBV77DiWbC19R0kSzYG3STISlPhVNbmiK
         i6Zs6UNH1nD2G0nchzqbdrLDLucUm9JyiI11URqvXFlwwvA1fF26qvrYztOHNFlB5k
         YUM70z4OfHIlxGcPCAehnPaV2ZnIMGbBe8cOcrU0=
Date:   Tue, 18 Aug 2020 20:18:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: include CMA pages in lowmem_reserve at boot
Message-Id: <20200818201817.351499e75cba2a84e8bf33e6@linux-foundation.org>
In-Reply-To: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
References: <1597423766-27849-1-git-send-email-opendmb@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 09:49:26 -0700 Doug Berger <opendmb@gmail.com> wrote:

> The lowmem_reserve arrays provide a means of applying pressure
> against allocations from lower zones that were targeted at
> higher zones. Its values are a function of the number of pages
> managed by higher zones and are assigned by a call to the
> setup_per_zone_lowmem_reserve() function.
> 
> The function is initially called at boot time by the function
> init_per_zone_wmark_min() and may be called later by accesses
> of the /proc/sys/vm/lowmem_reserve_ratio sysctl file.
> 
> The function init_per_zone_wmark_min() was moved up from a
> module_init to a core_initcall to resolve a sequencing issue
> with khugepaged. Unfortunately this created a sequencing issue
> with CMA page accounting.
> 
> The CMA pages are added to the managed page count of a zone
> when cma_init_reserved_areas() is called at boot also as a
> core_initcall. This makes it uncertain whether the CMA pages
> will be added to the managed page counts of their zones before
> or after the call to init_per_zone_wmark_min() as it becomes
> dependent on link order. With the current link order the pages
> are added to the managed count after the lowmem_reserve arrays
> are initialized at boot.
> 
> This means the lowmem_reserve values at boot may be lower than
> the values used later if /proc/sys/vm/lowmem_reserve_ratio is
> accessed even if the ratio values are unchanged.
> 
> In many cases the difference is not significant, but for example
> an ARM platform with 1GB of memory and the following memory layout
> [    0.000000] cma: Reserved 256 MiB at 0x0000000030000000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
> 
> would result in 0 lowmem_reserve for the DMA zone. This would allow
> userspace to deplete the DMA zone easily.

Sounds fairly serious for thos machines.  Was a cc:stable considered?

> Funnily enough
> $ cat /proc/sys/vm/lowmem_reserve_ratio
> would fix up the situation because it forces
> setup_per_zone_lowmem_reserve as a side effect.
> 
> This commit breaks the link order dependency by invoking
> init_per_zone_wmark_min() as a postcore_initcall so that the
> CMA pages have the chance to be properly accounted in their
> zone(s) and allowing the lowmem_reserve arrays to receive
> consistent values.
> 

