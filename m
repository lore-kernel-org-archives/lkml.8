Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C529C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22C2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC7Z5v+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBJUOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:14:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgBJUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581365682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aru7SYuZXhhhxDg5jfxc1VIsQsLEX+56nBygo91zRPY=;
        b=LC7Z5v+T17jDhEwHe5nX0F4M1QrSCcQRYhVgZSoOUKfwqmpLfQ9lQO56+UizD3k+AMxKZA
        VQxdmOkbtu+eHI7XgDQWyQR0UbzVmUkJI7xgDvBzDSWL3HBavgMl86KUTd4zPQSOUeFCNx
        pzPCWCVKoHTIwvaLbHv4WE+Yy6HsJh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-9VHrNn0mNp24TCJ6OQIh7g-1; Mon, 10 Feb 2020 15:14:38 -0500
X-MC-Unique: 9VHrNn0mNp24TCJ6OQIh7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E652800D41;
        Mon, 10 Feb 2020 20:14:37 +0000 (UTC)
Received: from mail (ovpn-125-144.rdu2.redhat.com [10.10.125.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C38E719C70;
        Mon, 10 Feb 2020 20:14:22 +0000 (UTC)
Date:   Mon, 10 Feb 2020 15:14:11 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: tlb: skip tlbi broadcast for single threaded
 TLB flushes
Message-ID: <20200210201411.GC3699@redhat.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
 <20200203201745.29986-3-aarcange@redhat.com>
 <20200210175106.GA27215@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210175106.GA27215@arrakis.emea.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Catalin,

On Mon, Feb 10, 2020 at 05:51:06PM +0000, Catalin Marinas wrote:
> Relying om mm_users is not sufficient AFAICT. Let's say on CPU0 you have
> a kernel thread running with the previous user pgd and ASID set in
> ttbr0_el1. The mm_users would still be 1 since only mm_count is
> incremented in context_switch(). If the user thread now runs on CPU1, a
> local tlbi would only invalidate the TLBs on CPU1. However, CPU0 may
> still walk (speculatively) the user page tables.
> 
> An example where this matters is a group of small pages converted to a
> huge page. If CPU0 already has some TLB entries for small pages in the
> group but, not being aware of a TLBI for the ptes in the range, may read
> a block pmd entry (huge page) and we end up with a TLB conflict on CPU0
> (CPU1 is fine since you do the local tlbi).
> 
> There are other examples where this could go wrong as the hardware may
> keep intermediate pgtable entries in a walk cache. In the arm64 kernel
> we rely on something the architecture calls break-before-make for any
> page table updates and these need to be broadcast to other CPUs that may
> potentially have an entry in their TLB.
> 
> It may be better if you used mm_cpumask to mark wherever an mm ever ran
> than relying on mm_users.

Agreed.

If we can use mm_cpumask to track where the mm ever run, then if I'm
not mistaken we could optimize also multithreaded processes in the
same way: if only one thread is running frequently and the others are
frequently sleeping, we could issue a single tlbi broadcast (modulo
invalidates of small virtual ranges).

In the meantime the below should be enough to address the concern you
raised of the proof of concept RFC patch.

I already experimented with mm_users == 1 earlier and it doesn't
change the benchmark results for the "best case" below.

(untested)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 772bbc45b867..a2d53b301f22 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -169,7 +169,8 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	unsigned long asid = __TLBI_VADDR(0, ASID(mm));
 
 	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
-	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1) {
+	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1 &&
+	    (system_uses_ttbr0_pan() || atomic_read(&mm->mm_count) == 1)) {
 		int cpu = get_cpu();
 
 		cpumask_setall(mm_cpumask(mm));
@@ -177,7 +178,9 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 
 		smp_mb();
 
-		if (atomic_read(&mm->mm_users) <= 1) {
+		if (atomic_read(&mm->mm_users) <= 1 &&
+		    (system_uses_ttbr0_pan() ||
+		     atomic_read(&mm->mm_count) == 1)) {
 			dsb(nshst);
 			__tlbi(aside1, asid);
 			__tlbi_user(aside1, asid);
@@ -212,7 +215,8 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
 
 	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
-	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1) {
+	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1 &&
+	    (system_uses_ttbr0_pan() || atomic_read(&mm->mm_count) == 1)) {
 		int cpu = get_cpu();
 
 		cpumask_setall(mm_cpumask(mm));
@@ -220,7 +224,9 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 
 		smp_mb();
 
-		if (atomic_read(&mm->mm_users) <= 1) {
+		if (atomic_read(&mm->mm_users) <= 1 &&
+		    (system_uses_ttbr0_pan() ||
+		     atomic_read(&mm->mm_count) == 1)) {
 			dsb(nshst);
 			__tlbi(vale1, addr);
 			__tlbi_user(vale1, addr);
@@ -264,7 +270,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	end = __TLBI_VADDR(end, asid);
 
 	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
-	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1) {
+	if (current->mm == mm && atomic_read(&mm->mm_users) <= 1  &&
+	    (system_uses_ttbr0_pan() || atomic_read(&mm->mm_count) == 1)) {
 		int cpu = get_cpu();
 
 		cpumask_setall(mm_cpumask(mm));
@@ -272,7 +279,9 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 
 		smp_mb();
 
-		if (atomic_read(&mm->mm_users) <= 1) {
+		if (atomic_read(&mm->mm_users) <= 1 &&
+		    (system_uses_ttbr0_pan() ||
+		     atomic_read(&mm->mm_count) == 1)) {
 			dsb(nshst);
 			for (addr = start; addr < end; addr += stride) {
 				if (last_level) {


> That's a pretty artificial test and it is indeed improved by this patch.
> However, it would be nice to have some real-world scenarios where this
> matters.

I don't know exactly how much we should rely on the hardware to snoop
the asid on NUMA. The hardware to fully optimize would need to
implement a replicated mm_cpumask bitflag for each asid and every CPU
would need to tell every other CPU which asid it is loading every time
it is loading it. Exactly what x86 does with mm_cpumask in software.

That is ideal, but is it an arch requirement to add the above in all
implementations?

The case I measured has a single socket so it's even simpler because
it could be optimized all in-core. Even with a single socket I'm not
sure what's going wrong in the chip: it felt like it's the engine that
does the broadcast that runs serially system wide and then all CPUs
have to wait on it.

Still your question if it'll make a difference in practice is a good
one and I don't have a sure answer yet. I suppose before doing more
benchmarking it's better to make a new version of this that uses
mm_cpumask to track where the asid was ever loaded as you suggested,
so that it will also optimize away tlbi broadcaasts from multithreaded
processes where only one thread is running frequently?

Thanks!
Andrea

