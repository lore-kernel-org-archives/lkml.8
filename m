Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16001C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28812086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgBKOA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:00:29 -0500
Received: from foss.arm.com ([217.140.110.172]:46624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgBKOA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:00:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6210A30E;
        Tue, 11 Feb 2020 06:00:28 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4917E3F68F;
        Tue, 11 Feb 2020 06:00:27 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:00:25 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: tlb: skip tlbi broadcast for single threaded
 TLB flushes
Message-ID: <20200211140025.GB153117@arrakis.emea.arm.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-3-aarcange@redhat.com>
 <20200210175106.GA27215@arrakis.emea.arm.com>
 <20200210201411.GC3699@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210201411.GC3699@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Mon, Feb 10, 2020 at 03:14:11PM -0500, Andrea Arcangeli wrote:
> On Mon, Feb 10, 2020 at 05:51:06PM +0000, Catalin Marinas wrote:
> > It may be better if you used mm_cpumask to mark wherever an mm ever ran
> > than relying on mm_users.
> 
> Agreed.
> 
> If we can use mm_cpumask to track where the mm ever run, then if I'm
> not mistaken we could optimize also multithreaded processes in the
> same way: if only one thread is running frequently and the others are
> frequently sleeping, we could issue a single tlbi broadcast (modulo
> invalidates of small virtual ranges).

Possibly, though not sure how you'd detect such scenario.

> In the meantime the below should be enough to address the concern you
> raised of the proof of concept RFC patch.
> 
> I already experimented with mm_users == 1 earlier and it doesn't
> change the benchmark results for the "best case" below.
> 
> (untested)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 772bbc45b867..a2d53b301f22 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
[...]
> @@ -212,7 +215,8 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
>  
>  	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
> -	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1) {
> +	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1 &&
> +	    (system_uses_ttbr0_pan() || atomic_read(&mm->mm_count) == 1)) {
>  		int cpu = get_cpu();
>  
>  		cpumask_setall(mm_cpumask(mm));

I think there is another race here. IIUC, the assumption you make is
that when mm_users <= 1 && mm_count == 1, the only active user of this
pgd/ASID is on the CPU doing the TLBI. This is not the case for
try_to_unmap() where the above condition may be true but the active
thread on a different CPU won't notice the local TLBI.

> > That's a pretty artificial test and it is indeed improved by this patch.
> > However, it would be nice to have some real-world scenarios where this
> > matters.
[...]
> Still your question if it'll make a difference in practice is a good
> one and I don't have a sure answer yet. I suppose before doing more
> benchmarking it's better to make a new version of this that uses
> mm_cpumask to track where the asid was ever loaded as you suggested,
> so that it will also optimize away tlbi broadcasts from multithreaded
> processes where only one thread is running frequently?

I was actually curious what triggered this patch series, whether you've
seen a real use-case where the TLBI was a bottleneck.

-- 
Catalin
