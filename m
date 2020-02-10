Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B13C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCE220838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBJRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:51:10 -0500
Received: from foss.arm.com ([217.140.110.172]:37012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgBJRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:51:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7446F1FB;
        Mon, 10 Feb 2020 09:51:09 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A183F68F;
        Mon, 10 Feb 2020 09:51:08 -0800 (PST)
Date:   Mon, 10 Feb 2020 17:51:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: tlb: skip tlbi broadcast for single threaded
 TLB flushes
Message-ID: <20200210175106.GA27215@arrakis.emea.arm.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-3-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203201745.29986-3-aarcange@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thanks for having a go at this.

On Mon, Feb 03, 2020 at 03:17:45PM -0500, Andrea Arcangeli wrote:
> With multiple NUMA nodes and multiple sockets, the tlbi broadcast
> shall be delivered through the interconnects in turn increasing the
> interconnect traffic and the latency of the tlbi broadcast instruction.

There are better ways to handle this in hardware (snoop filters), so
hopefully those vendors will eventually learn.

> After the local TLB flush this however means the ASID context goes out
> of sync in all CPUs except the local one. This can be tracked in the
> mm_cpumask(mm): if the bit is set it means the asid context is stale
> for that CPU. This results in an extra local ASID TLB flush only if a
> single threaded process is migrated to a different CPU and only after a
> TLB flush. No extra local TLB flush is needed for the common case of
> single threaded processes context scheduling within the same CPU and for
> multithreaded processes.

Relying om mm_users is not sufficient AFAICT. Let's say on CPU0 you have
a kernel thread running with the previous user pgd and ASID set in
ttbr0_el1. The mm_users would still be 1 since only mm_count is
incremented in context_switch(). If the user thread now runs on CPU1, a
local tlbi would only invalidate the TLBs on CPU1. However, CPU0 may
still walk (speculatively) the user page tables.

An example where this matters is a group of small pages converted to a
huge page. If CPU0 already has some TLB entries for small pages in the
group but, not being aware of a TLBI for the ptes in the range, may read
a block pmd entry (huge page) and we end up with a TLB conflict on CPU0
(CPU1 is fine since you do the local tlbi).

There are other examples where this could go wrong as the hardware may
keep intermediate pgtable entries in a walk cache. In the arm64 kernel
we rely on something the architecture calls break-before-make for any
page table updates and these need to be broadcast to other CPUs that may
potentially have an entry in their TLB.

It may be better if you used mm_cpumask to mark wherever an mm ever ran
than relying on mm_users.

> Skipping the tlbi instruction broadcasting is already implemented in
> local_flush_tlb_all(), this patch only extends it to flush_tlb_mm(),
> flush_tlb_range() and flush_tlb_page() too.
> 
> Here's the result of 32 CPUs (ARMv8 Ampere) running mprotect at the same
> time from 32 single threaded processes before the patch:
> 
>  Performance counter stats for './loop' (3 runs):
> 
>                  0      dummy
> 
>           2.121353 +- 0.000387 seconds time elapsed  ( +-  0.02% )
> 
> and with the patch applied:
> 
>  Performance counter stats for './loop' (3 runs):
> 
>                  0      dummy
> 
>          0.1197750 +- 0.0000827 seconds time elapsed  ( +-  0.07% )

That's a pretty artificial test and it is indeed improved by this patch.
However, it would be nice to have some real-world scenarios where this
matters.

-- 
Catalin
