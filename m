Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2013C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9294620722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgCWNRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:17:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgCWNRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:17:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D028A1FB;
        Mon, 23 Mar 2020 06:17:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C864F3F52E;
        Mon, 23 Mar 2020 06:17:23 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:17:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Two questions about cache coherency on arm platforms
Message-ID: <20200323131720.GE2597@C02TD0UTHF1T.local>
References: <20200323123524.w67fici6oxzdo665@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323123524.w67fici6oxzdo665@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:35:26PM +0800, Changbin Du wrote:
> Hi, All,
> I am not very familiar with ARM processors. I have two questions about
> cache coherency. Could anyone help me?
> 
> 1. How is cache coherency maintenanced on ARMv8 big.LITTLE system?
> As far as I know, big cores and little cores are in seperate clusters on
> big.LITTLE system.

This is often true, but not always the case. For example, with DSU big
and little cores can be placed within the same cluster.

> And cache coherence betwwen clusters requires the
> memory regions are marked as 'Outer Shareable' and is very expensive.

This is not correct.

Linux requires that all cores it uses are within the same Inner
Shareable domain, regardless of whether they are in distinct clusters.
Linux does not support systems where cores are in distinct Inner
Shareable domains.

This is the intended use of the architecture. Per ARM DDI 0487E.a page
B2-144:

| This architecture assumes that all PEs that use the same operating
| system or hypervisor are in the same Inner Shareable shareability
| shareability

... where a PE is a "Processing Element", which you can think of as a
single core.

> I have checked the kernel code, and seems it only requires coherence in
> 'Inner Shareable' domain. So my question is how can linux guarantees
> cache coherence in 'CPU migration' or 'Global Task Scheduling' models
> wich both clusters are active at the same time? For example, a thread
> ran in Cluster A and modified 'Inner Shareable' memory, then it migrates
> to Cluster B.

As above, this works because all the relevant cores are within the same
Inner Shareable domain.

> 2. ARM64 cache maintenance code sync_icache_aliases() for non-aliasing icache.
> In linux kernel on arm64 platform, the flow function sync_icache_aliases()
> is used to sync i-cache and d-cache. I understand the aliasing case. but
> for non-aliasing case why it just does "dc cvau" (in __flush_icache_range())
> whithout really invalidate the icache?

The __flush_icache_range/__flush_cache_user_range assembly function does
both the D-cache maintenance with DC CVAU, then the I-cache maintenance
with IC IVAU, so I think you have misread it.

Thanks,
Mark.

> Will i-cache refill from L2 cache?
>
> void sync_icache_aliases(void *kaddr, unsigned long len)
> {
> 	unsigned long addr = (unsigned long)kaddr;
> 
> 	if (icache_is_aliasing()) {
> 		__clean_dcache_area_pou(kaddr, len);
> 		__flush_icache_all();
> 	} else {
> 		/*
> 		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
> 		 * for user mappings.
> 		 */
> 		__flush_icache_range(addr, addr + len);
> 	}
> }
> 
> -- 
> Cheers,
> Changbin Du
