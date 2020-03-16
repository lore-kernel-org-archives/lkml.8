Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB5C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC902071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgCPOJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:09:18 -0400
Received: from foss.arm.com ([217.140.110.172]:49000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbgCPOJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:09:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD771FB;
        Mon, 16 Mar 2020 07:09:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C00A3F52E;
        Mon, 16 Mar 2020 07:09:16 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:09:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: Re: [PATCH 3/3] arm64: tlb: skip tlbi broadcast
Message-ID: <20200316140906.GA6220@lakrids.cambridge.arm.com>
References: <20200223192520.20808-1-aarcange@redhat.com>
 <20200223192520.20808-4-aarcange@redhat.com>
 <20200309112242.GB2487@mbp>
 <20200314031609.GB2250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314031609.GB2250@redhat.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Fri, Mar 13, 2020 at 11:16:09PM -0400, Andrea Arcangeli wrote:
> On Mon, Mar 09, 2020 at 11:22:42AM +0000, Catalin Marinas wrote:
> > One concern I have is the ordering between TTBR0_EL1 update in
> > cpu_do_switch_mm() and the nr_active_mm, both on a different CPU. We
> > only have an ISB for context synchronisation on that CPU but I don't
> > think the architecture guarantees any relation between sysreg access and
> > the memory update. We have a DSB but that's further down in switch_to().
> 
> There are several cpu_do_switch_mm updating TTBR0_EL1 and nr_active_mm
> updates that can happen on different CPUs simultaneously. It's hard to
> see exactly which one you refer to.
> 
> Overall the idea here is that even if a speculative tlb lookup happens
> in between those updates while the "mm" is going away and
> atomic_dec(&mm->nr_active_mm) is being called on the mm, it doesn't
> matter because no userland software can use such stale tlb anymore
> until local_flush_tlb_asid() gets rid of it.

I think you're focussing on the use of the end-to-end translations by
architecturally executed instructions, while Catalin is describing
problems resulting from the use of intermediate translations by
speculative walks.

The concern here is that speculation can result in intermediate walk
entries in the TLB being used to continue page table walks, and these
walks can have side-effects regardless of whether the resulting entires
are consumed by architecturally executed instructions.

For example, say we free a PMD page for which there is a stale
intermediate entry in a TLB, and that page gets reallocated for
arbitrary date. A speculative walk can consume that data as-if it were a
PMD, and depending on the value it sees a number of things can happen.
If the value happens to point at MMIO, the MMU might read from that MMIO
with side-effects. If the value happens to contain an architecturally
invalid configuration the result can be CONSTRAINED UNPREDICTABLE and
not limited to the corresponding ASID.

Even if the resulting end-to-end translation is never architecturally
consumed there are potential problems here, and I think that this series
is assuming stronger-than-architected behaviour from the MMU and page
table walks.

> This concern is still a corollary of the previous paragraph: it's
> still about stale tlb entries being left in an asid that can't ever be
> used through the current asid.

I'm not certain if the architecture generally allows or forbids walks to
be continued for an ASID that is not live in a TTBR, but there are cases
where that is possible, so I don't think the above accurately captures
the situation. Stale intermediate entries can certainly be consumed in
some cases.

> > TLB. All the architecture spec states is that the software must first
> > clear the entry followed by TLBI (the break-before-make rules).
> 
> The "break" in "break-before-make" is still guaranteed or it wouldn't
> boot: however it's not implemented with the tlbi broadcast anymore.
>
> The break is implemented by enforcing no stale tlb entry of such asid
> exists in the TLB while any userland code runs.

I understand the point you're making, but please don't overload the
terminology. Break-Before-Make is a well-defined term which refers to a
specific sequence which includes TLB invalidation, and the above is not
a break per that definition.

> X86 specs supposed an OS would allocate a TSS per-process and you
> would do a context switch by using a task gate. I recall the first
> Linux version I used had a TSS per process as envisioned by the
> specs. Later the TSS become per-CPU and the esp0 pointer was updated
> instead (native_load_sp0) and the stack was switched by hand.
> 
> I guess reading the specs may result confusing after such a software
> change, that doesn't mean the software shouldn't optimize things
> behind the specs if it's safe to do and it's not explicitly forbidden.

I think the important thing is that this is not necessarily safe. The
architecture currently states that a Break-Before-Make sequence is
necessary, and this series does not follow that.

AFAICT, this series relies on:

* An ISB completing prior page table walks when updating TTBR. I don't
  believe this is necessarily the case, given how things work for an
  EL1->EL2 transition where there can be ongoing EL1 walks.

* Walks never being initiated for `inactive` contexts within the current
  translation regime. e.g. while ASID x is installed, never starting a
  walk for ASID y. I can imagine that the architecture may permit a form
  of this starting with intermediate walk entries in the TLBs.

Before we can say whether this series is safe, we'd need to have a
better description of how a PE may use `inactive` values for an
in-context translation regime. 

I've asked for some clarification on these points.

Thanks,
Mark.
