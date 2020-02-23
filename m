Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A291EC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0720656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmpNWasw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBWTZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:25:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582485927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zSCIh7K7Y8FlgneHdFGaX0aZ5L1KSsvBwva6avjhk6c=;
        b=KmpNWasw/tGAXf011Xh7URaxsIeJGu3K1Jn3DnN38wC4AYarKNbJs968K1HKFRZWc2moUA
        lpFVsddLU6odrxfbsXEYr0Y0ZpJUH9OlSAXN8/O1HlF5ci3plXQeqXbe6bveH3J5gkzOFz
        ZWqcueBAd6lHlYZZ9PyYkxuJDvLTTTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-3QBvPW4zM2Wmt9n2PN-D1A-1; Sun, 23 Feb 2020 14:25:25 -0500
X-MC-Unique: 3QBvPW4zM2Wmt9n2PN-D1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56230184B122;
        Sun, 23 Feb 2020 19:25:24 +0000 (UTC)
Received: from mail (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A44B5C241;
        Sun, 23 Feb 2020 19:25:21 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>
Cc:     Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: [PATCH 0/3] arm64: tlb: skip tlbi broadcast v2
Date:   Sun, 23 Feb 2020 14:25:17 -0500
Message-Id: <20200223192520.20808-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is introducing a nr_active_mm that allows to optimize away the
tlbi broadcast also for multi threaded processes, it doesn't rely
anymore on mm_users <=3D 1.

This also optimizes away all TLB flushes (including local ones) when
the process is not running in any cpu (including during exit_mmap with
lazy tlb state).

This optimization is generally only observable when there are parallel
TLB flushes from different processes in multiple CPUs. One possible
use case is an userland malloc libs freeing small objects with
MADV_DONTNEED and causing a frequent tiny tlb flushes as demonstrated
by the tcmalloc testsuite.

All memory intensive apps dealing a multitude of frequently freed
small objects tend to opt-out of glibc and they opt-in jemalloc or
tcmalloc, so this should facilitate the SMP/NUMA scalability of long
lived apps with small objects running in different containers if
they're issuing frequent MADV_DONTNEED tlb flushes while the other
threads of the process are not running.

I was suggested to implement the mm_cpumask the standard way in
order to optimize multithreaded apps too and to avoid restricting the
optimization to mm_users <=3D 1. So initially I had two bitmasks allocate=
d
as shown at the bottom of this cover letter, by setting
ARCH_NR_MM_CPUMASK to 2 with the below patch applied... however I
figured a single atomic per-mm achieves the exact same runtime behavior
of the extra bitmap, so I just dropped the extra bitmap and I replaced
it with nr_active_mm as an optimization.

If the switch_mm atomic ops in the switch_mm fast path would be a
concern (they're still faster than the cpumask_set_cpu/clear_cpu, with
less than 256-512 CPUs), it's worth mentioning it'd be possible to
remove all atomic ops from the switch_mm fast path by restricting this
optimization to single threaded processes by checking mm_users <=3D 1
and < 1 instead of nr_active_mm <=3D 1 and < 1 similarly to what the
earlier version of this patchset was doing.

Thanks,
Andrea

Andrea Arcangeli (3):
  mm: use_mm: fix for arches checking mm_users to optimize TLB flushes
  arm64: select CPUMASK_OFFSTACK if NUMA
  arm64: tlb: skip tlbi broadcast

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/efi.h         |  2 +-
 arch/arm64/include/asm/mmu.h         |  4 +-
 arch/arm64/include/asm/mmu_context.h | 33 ++++++++--
 arch/arm64/include/asm/tlbflush.h    | 95 +++++++++++++++++++++++++++-
 arch/arm64/mm/context.c              | 54 ++++++++++++++++
 mm/mmu_context.c                     |  2 +
 7 files changed, 180 insertions(+), 11 deletions(-)

Early attempt with the standard mm_cpumask follows:

From: Andrea Arcangeli <aarcange@redhat.com>
Subject: mm: allow per-arch mm_cpumasks based on ARCH_NR_MM_CPUMASK

Allow archs to allocate multiple mm_cpumasks in the mm_struct per-arch
by definining a ARCH_NR_MM_CPUMASK > 1 (to be included before
"linux/mm_types.h").

Those extra per-mm cpumasks can be referenced with
__mm_cpumask(N, mm), where N =3D=3D 0 points to the mm_cpumask()
known by the common code and N > 0 points to the per-arch private
ones.
---
 drivers/firmware/efi/efi.c |  3 ++-
 include/linux/mm_types.h   | 17 +++++++++++++++--
 kernel/fork.c              |  3 ++-
 mm/init-mm.c               |  2 +-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5da0232ae33f..608c9bf181e5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -86,7 +86,8 @@ struct mm_struct efi_mm =3D {
 	.mmap_sem		=3D __RWSEM_INITIALIZER(efi_mm.mmap_sem),
 	.page_table_lock	=3D __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			=3D LIST_HEAD_INIT(efi_mm.mmlist),
-	.cpu_bitmap		=3D { [BITS_TO_LONGS(NR_CPUS)] =3D 0},
+	.cpu_bitmap		=3D { [BITS_TO_LONGS(NR_CPUS) *
+				     ARCH_NR_MM_CPUMASK] =3D 0},
 };
=20
 struct workqueue_struct *efi_rts_wq;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f29bba20bba1..b53d5622b3b2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -531,6 +531,9 @@ struct mm_struct {
 	RH_KABI_RESERVE(7)
 	RH_KABI_RESERVE(8)
=20
+#ifndef ARCH_NR_MM_CPUMASK
+#define ARCH_NR_MM_CPUMASK 1
+#endif
 	/*
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.
@@ -544,15 +547,25 @@ extern struct mm_struct init_mm;
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
 	unsigned long cpu_bitmap =3D (unsigned long)mm;
+	int i;
=20
 	cpu_bitmap +=3D offsetof(struct mm_struct, cpu_bitmap);
-	cpumask_clear((struct cpumask *)cpu_bitmap);
+	for (i =3D 0; i < ARCH_NR_MM_CPUMASK; i++) {
+		cpumask_clear((struct cpumask *)cpu_bitmap);
+		cpu_bitmap +=3D cpumask_size();
+	}
 }
=20
 /* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
+static inline cpumask_t *__mm_cpumask(int index, struct mm_struct *mm)
+{
+	return (struct cpumask *)((unsigned long)&mm->cpu_bitmap +
+				  cpumask_size() * index);
+}
+
 static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 {
-	return (struct cpumask *)&mm->cpu_bitmap;
+	return __mm_cpumask(0, mm);
 }
=20
 struct mmu_gather;
diff --git a/kernel/fork.c b/kernel/fork.c
index 1dad2f91fac3..a6cbbc1b6008 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2418,7 +2418,8 @@ void __init proc_caches_init(void)
 	 * dynamically sized based on the maximum CPU number this system
 	 * can have, taking hotplug into account (nr_cpu_ids).
 	 */
-	mm_size =3D sizeof(struct mm_struct) + cpumask_size();
+	mm_size =3D sizeof(struct mm_struct) + cpumask_size() * \
+		ARCH_NR_MM_CPUMASK;
=20
 	mm_cachep =3D kmem_cache_create_usercopy("mm_struct",
 			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
diff --git a/mm/init-mm.c b/mm/init-mm.c
index a787a319211e..d975f8ce270e 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -35,6 +35,6 @@ struct mm_struct init_mm =3D {
 	.arg_lock	=3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		=3D LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	=3D &init_user_ns,
-	.cpu_bitmap	=3D { [BITS_TO_LONGS(NR_CPUS)] =3D 0},
+	.cpu_bitmap	=3D { [BITS_TO_LONGS(NR_CPUS) * ARCH_NR_MM_CPUMASK] =3D 0},
 	INIT_MM_CONTEXT(init_mm)
 };


[bitmap version depending on the above follows]

@@ -248,6 +260,42 @@ void check_and_switch_context(struct mm_struct *mm, =
unsigned int cpu)
 		cpu_switch_mm(mm->pgd, mm);
 }
=20
+enum tlb_flush_types tlb_flush_check(struct mm_struct *mm, unsigned int =
cpu)
+{
+	if (cpumask_any_but(mm_cpumask(mm), cpu) >=3D nr_cpu_ids) {
+		bool is_local =3D cpumask_test_cpu(cpu, mm_cpumask(mm));
+		cpumask_t *stale_cpumask =3D __mm_cpumask(1, mm);
+		int next_zero =3D cpumask_next_zero(-1, stale_cpumask);
+		bool local_is_clear =3D false;
+		if (next_zero < nr_cpu_ids &&
+		    (is_local && next_zero =3D=3D cpu)) {
+			next_zero =3D cpumask_next_zero(next_zero, stale_cpumask);
+			local_is_clear =3D true;
+		}
+		if (next_zero < nr_cpu_ids) {
+			cpumask_setall(stale_cpumask);
+			local_is_clear =3D false;
+		}
+
+		/*
+		 * Enforce CPU ordering between the
+		 * cpumask_setall() and cpumask_any_but().
+		 */
+		smp_mb();
+
+		if (likely(cpumask_any_but(mm_cpumask(mm),
+					   cpu) >=3D nr_cpu_ids)) {
+			if (is_local) {
+				if (!local_is_clear)
+					cpumask_clear_cpu(cpu, stale_cpumask);
+				return TLB_FLUSH_LOCAL;
+			}
+			return TLB_FLUSH_NO;
+		}
+	}
+	return TLB_FLUSH_BROADCAST;
+}
+
 /* Errata workaround post TTBRx_EL1 update. */
 asmlinkage void post_ttbr_update_workaround(void)
 {

