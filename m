Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E842C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A1820661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgBLP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:26:29 -0500
Received: from foss.arm.com ([217.140.110.172]:34074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgBLP03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:26:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FD9328;
        Wed, 12 Feb 2020 07:26:28 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2063F68F;
        Wed, 12 Feb 2020 07:26:26 -0800 (PST)
Date:   Wed, 12 Feb 2020 15:26:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: tlb: skip tlbi broadcast for single threaded
 TLB flushes
Message-ID: <20200212152624.GA587247@arrakis.emea.arm.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-3-aarcange@redhat.com>
 <6e59905d-3e5b-bbd5-d192-9f18a0a152f5@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e59905d-3e5b-bbd5-d192-9f18a0a152f5@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:13:56PM +0000, qi.fuli@fujitsu.com wrote:
> On 2/4/20 5:17 AM, Andrea Arcangeli wrote:
> > With multiple NUMA nodes and multiple sockets, the tlbi broadcast
> > shall be delivered through the interconnects in turn increasing the
> > interconnect traffic and the latency of the tlbi broadcast instruction.
> > 
> > Even within a single NUMA node the latency of the tlbi broadcast
> > instruction increases almost linearly with the number of CPUs trying to
> > send tlbi broadcasts at the same time.
> > 
> > When the process is single threaded however we can achieve full SMP
> > scalability by skipping the tlbi broadcasting. Other arches already
> > deploy this optimization.
> > 
> > After the local TLB flush this however means the ASID context goes out
> > of sync in all CPUs except the local one. This can be tracked in the
> > mm_cpumask(mm): if the bit is set it means the asid context is stale
> > for that CPU. This results in an extra local ASID TLB flush only if a
> > single threaded process is migrated to a different CPU and only after a
> > TLB flush. No extra local TLB flush is needed for the common case of
> > single threaded processes context scheduling within the same CPU and for
> > multithreaded processes.
> > 
> > Skipping the tlbi instruction broadcasting is already implemented in
> > local_flush_tlb_all(), this patch only extends it to flush_tlb_mm(),
> > flush_tlb_range() and flush_tlb_page() too.
> > 
> > Here's the result of 32 CPUs (ARMv8 Ampere) running mprotect at the same
> > time from 32 single threaded processes before the patch:
> > 
> >   Performance counter stats for './loop' (3 runs):
> > 
> >                   0      dummy
> > 
> >            2.121353 +- 0.000387 seconds time elapsed  ( +-  0.02% )
> > 
> > and with the patch applied:
> > 
> >   Performance counter stats for './loop' (3 runs):
> > 
> >                   0      dummy
> > 
> >           0.1197750 +- 0.0000827 seconds time elapsed  ( +-  0.07% )
> 
> I have tested this patch on thunderX2 with Himeno benchmark[1] with 
> LARGE calculation size. Here are the results.
> 
>    w/o patch:   MFLOPS : 1149.480174
>    w/  patch:   MFLOPS : 1110.653003
> 
> In order to validate the effectivness of the patch, I ran a 
> single-threded program, which calls mprotect() in a loop to issue the 
> tlbi broadcast instruction on a CPU core. At the same time, I ran Himeno 
> benchmark on another CPU core. The results are:
> 
>    w/o patch:   MFLOPS :  860.238792
>    w/  patch:   MFLOPS : 1110.449666
> 
> Though Himeno benchmark is a microbenchmark, I hope it helps.

It doesn't really help. What if you have a two-thread program calling
mprotect() in a loop? IOW, how is this relevant to real-world scenarios?

Thanks.

-- 
Catalin
