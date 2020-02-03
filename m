Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657FEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BFA20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmGLDLUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBCUSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:18:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgBCUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580761079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnGScHbTlJ76sEJ4ZUeqFR3hYk6wSCyUU5+x/f3HazU=;
        b=dmGLDLUUNbM/PhgGJl9z2GxX0KNOIxDfcgtIhRlcbUsxBrPMIUaxKqWMlxAGAefq21IvTz
        thKRsi9l9q70WcHwMCfsWSo2W76AYjvwvR11k4c2yQpaHqF8t+ybSp+ibv5YBx1N/BYawU
        q7OlU6WEAi9vibneofWzUKft+wOHGhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-8YXHLavUPaS-JWZqlrwJfw-1; Mon, 03 Feb 2020 15:17:50 -0500
X-MC-Unique: 8YXHLavUPaS-JWZqlrwJfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C42AC1005514;
        Mon,  3 Feb 2020 20:17:48 +0000 (UTC)
Received: from mail (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D6E210018FF;
        Mon,  3 Feb 2020 20:17:46 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: tlb: skip tlbi broadcast for single threaded TLB flushes
Date:   Mon,  3 Feb 2020 15:17:45 -0500
Message-Id: <20200203201745.29986-3-aarcange@redhat.com>
In-Reply-To: <20200203201745.29986-1-aarcange@redhat.com>
References: <20200203201745.29986-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multiple NUMA nodes and multiple sockets, the tlbi broadcast
shall be delivered through the interconnects in turn increasing the
interconnect traffic and the latency of the tlbi broadcast instruction.

Even within a single NUMA node the latency of the tlbi broadcast
instruction increases almost linearly with the number of CPUs trying to
send tlbi broadcasts at the same time.

When the process is single threaded however we can achieve full SMP
scalability by skipping the tlbi broadcasting. Other arches already
deploy this optimization.

After the local TLB flush this however means the ASID context goes out
of sync in all CPUs except the local one. This can be tracked in the
mm_cpumask(mm): if the bit is set it means the asid context is stale
for that CPU. This results in an extra local ASID TLB flush only if a
single threaded process is migrated to a different CPU and only after a
TLB flush. No extra local TLB flush is needed for the common case of
single threaded processes context scheduling within the same CPU and for
multithreaded processes.

Skipping the tlbi instruction broadcasting is already implemented in
local_flush_tlb_all(), this patch only extends it to flush_tlb_mm(),
flush_tlb_range() and flush_tlb_page() too.

Here's the result of 32 CPUs (ARMv8 Ampere) running mprotect at the same
time from 32 single threaded processes before the patch:

 Performance counter stats for './loop' (3 runs):

                 0      dummy

          2.121353 +- 0.000387 seconds time elapsed  ( +-  0.02% )

and with the patch applied:

 Performance counter stats for './loop' (3 runs):

                 0      dummy

         0.1197750 +- 0.0000827 seconds time elapsed  ( +-  0.07% )

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/arm64/include/asm/efi.h         |  2 +-
 arch/arm64/include/asm/mmu.h         |  3 +-
 arch/arm64/include/asm/mmu_context.h | 10 +--
 arch/arm64/include/asm/tlbflush.h    | 91 +++++++++++++++++++++++++++-
 arch/arm64/mm/context.c              | 13 +++-
 5 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 44531a69d32b..5d9a1433d918 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -131,7 +131,7 @@ static inline void efifb_setup_from_dmi(struct screen=
_info *si, const char *opt)
=20
 static inline void efi_set_pgd(struct mm_struct *mm)
 {
-	__switch_mm(mm);
+	__switch_mm(mm, smp_processor_id());
=20
 	if (system_uses_ttbr0_pan()) {
 		if (mm !=3D current->active_mm) {
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index e4d862420bb4..1f84289d3e44 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -27,7 +27,8 @@ typedef struct {
  * ASID change and therefore doesn't need to reload the counter using
  * atomic64_read.
  */
-#define ASID(mm)	((mm)->context.id.counter & 0xffff)
+#define __ASID(asid)	((asid) & 0xffff)
+#define ASID(mm)	__ASID((mm)->context.id.counter)
=20
 extern bool arm64_use_ng_mappings;
=20
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/as=
m/mmu_context.h
index 3827ff4040a3..5ec264297968 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -210,10 +210,8 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_str=
uct *tsk)
 	update_saved_ttbr0(tsk, &init_mm);
 }
=20
-static inline void __switch_mm(struct mm_struct *next)
+static inline void __switch_mm(struct mm_struct *next, unsigned int cpu)
 {
-	unsigned int cpu =3D smp_processor_id();
-
 	/*
 	 * init_mm.pgd does not contain any user mappings and it is always
 	 * active for kernel addresses in TTBR1. Just set the reserved TTBR0.
@@ -230,8 +228,12 @@ static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	  struct task_struct *tsk)
 {
+	unsigned int cpu =3D smp_processor_id();
+
 	if (prev !=3D next)
-		__switch_mm(next);
+		__switch_mm(next, cpu);
+	else if (cpumask_test_and_clear_cpu(cpu, mm_cpumask(next)))
+		local_flush_tlb_asid(atomic64_read(&next->context.id));
=20
 	/*
 	 * Update the saved TTBR0_EL1 of the scheduled-in task as the previous
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
index bc3949064725..283f97af3fc5 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -136,6 +136,15 @@ static inline void local_flush_tlb_all(void)
 	isb();
 }
=20
+static inline void local_flush_tlb_asid(unsigned long asid)
+{
+	asid =3D __TLBI_VADDR(0, __ASID(asid));
+	dsb(nshst);
+	__tlbi(aside1, asid);
+	__tlbi_user(aside1, asid);
+	dsb(nsh);
+}
+
 static inline void flush_tlb_all(void)
 {
 	dsb(ishst);
@@ -148,6 +157,27 @@ static inline void flush_tlb_mm(struct mm_struct *mm=
)
 {
 	unsigned long asid =3D __TLBI_VADDR(0, ASID(mm));
=20
+	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
+	if (current->mm =3D=3D mm && atomic_read(&mm->mm_users) <=3D 1) {
+		int cpu =3D get_cpu();
+
+		cpumask_setall(mm_cpumask(mm));
+		cpumask_clear_cpu(cpu, mm_cpumask(mm));
+
+		smp_mb();
+
+		if (atomic_read(&mm->mm_users) <=3D 1) {
+			dsb(nshst);
+			__tlbi(aside1, asid);
+			__tlbi_user(aside1, asid);
+			dsb(nsh);
+
+			put_cpu();
+			return;
+		}
+		put_cpu();
+	}
+
 	dsb(ishst);
 	__tlbi(aside1is, asid);
 	__tlbi_user(aside1is, asid);
@@ -167,7 +197,33 @@ static inline void flush_tlb_page_nosync(struct vm_a=
rea_struct *vma,
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
-	flush_tlb_page_nosync(vma, uaddr);
+	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long addr =3D __TLBI_VADDR(uaddr, ASID(mm));
+
+	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
+	if (current->mm =3D=3D mm && atomic_read(&mm->mm_users) <=3D 1) {
+		int cpu =3D get_cpu();
+
+		cpumask_setall(mm_cpumask(mm));
+		cpumask_clear_cpu(cpu, mm_cpumask(mm));
+
+		smp_mb();
+
+		if (atomic_read(&mm->mm_users) <=3D 1) {
+			dsb(nshst);
+			__tlbi(vale1, addr);
+			__tlbi_user(vale1, addr);
+			dsb(nsh);
+
+			put_cpu();
+			return;
+		}
+		put_cpu();
+	}
+
+	dsb(ishst);
+	__tlbi(vale1is, addr);
+	__tlbi_user(vale1is, addr);
 	dsb(ish);
 }
=20
@@ -181,14 +237,15 @@ static inline void __flush_tlb_range(struct vm_area=
_struct *vma,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level)
 {
-	unsigned long asid =3D ASID(vma->vm_mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long asid =3D ASID(mm);
 	unsigned long addr;
=20
 	start =3D round_down(start, stride);
 	end =3D round_up(end, stride);
=20
 	if ((end - start) >=3D (MAX_TLBI_OPS * stride)) {
-		flush_tlb_mm(vma->vm_mm);
+		flush_tlb_mm(mm);
 		return;
 	}
=20
@@ -198,6 +255,34 @@ static inline void __flush_tlb_range(struct vm_area_=
struct *vma,
 	start =3D __TLBI_VADDR(start, asid);
 	end =3D __TLBI_VADDR(end, asid);
=20
+	/* avoid TLB-i broadcast to remote NUMA nodes if it's a local flush */
+	if (current->mm =3D=3D mm && atomic_read(&mm->mm_users) <=3D 1) {
+		int cpu =3D get_cpu();
+
+		cpumask_setall(mm_cpumask(mm));
+		cpumask_clear_cpu(cpu, mm_cpumask(mm));
+
+		smp_mb();
+
+		if (atomic_read(&mm->mm_users) <=3D 1) {
+			dsb(nshst);
+			for (addr =3D start; addr < end; addr +=3D stride) {
+				if (last_level) {
+					__tlbi(vale1, addr);
+					__tlbi_user(vale1, addr);
+				} else {
+					__tlbi(vae1, addr);
+					__tlbi_user(vae1, addr);
+				}
+			}
+			dsb(nsh);
+
+			put_cpu();
+			return;
+		}
+		put_cpu();
+	}
+
 	dsb(ishst);
 	for (addr =3D start; addr < end; addr +=3D stride) {
 		if (last_level) {
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 8ef73e89d514..b44459d64dff 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -198,6 +198,7 @@ void check_and_switch_context(struct mm_struct *mm, u=
nsigned int cpu)
 {
 	unsigned long flags;
 	u64 asid, old_active_asid;
+	int need_flush =3D 0;
=20
 	if (system_supports_cnp())
 		cpu_set_reserved_ttbr0();
@@ -233,7 +234,8 @@ void check_and_switch_context(struct mm_struct *mm, u=
nsigned int cpu)
 		atomic64_set(&mm->context.id, asid);
 	}
=20
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	need_flush =3D cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending);
+	if (need_flush)
 		local_flush_tlb_all();
=20
 	atomic64_set(&per_cpu(active_asids, cpu), asid);
@@ -241,6 +243,15 @@ void check_and_switch_context(struct mm_struct *mm, =
unsigned int cpu)
=20
 switch_mm_fastpath:
=20
+	/*
+	 * Enforce CPU ordering between the mmget() in use_mm() and
+	 * the below cpumask_test_and_clear_cpu().
+	 */
+	smp_mb();
+	if (cpumask_test_and_clear_cpu(cpu, mm_cpumask(mm)) &&
+	    likely(!need_flush))
+		local_flush_tlb_asid(asid);
+
 	arm64_apply_bp_hardening();
=20
 	/*

