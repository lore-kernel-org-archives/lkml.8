Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD79C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD64520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GCzTtBwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBGO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:27:02 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:51046 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgBGO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1581085619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JmXWwk8oHTimwKvrSamYiM0wOxkB9k4nQlVk5d1YLh8=;
  b=GCzTtBwcjVWL309y1oKyRNnnD6PDQnm+l3R7H8y1HnCFdFZv/Uval1FU
   u+UzeojBluTNVQ4WJVCDcWyEuzNiwspKo3JSx8oGu9Lt9J7YtAJWNFbtE
   jHPjihuGHLMZbjEvS1iIKK+JI5cPq/w6tcbDf0x8oIZl5htPQIjYwD+k4
   8=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: JVR+CfOyL+tpYmHAlsitcbny7cVCDfpEkdNoxfH9qe1SlGKJAJ3g6EJhzTvj3+s9UDCFdzgiJ8
 e9hfHqgfjfh1B5+nE25y09t45e/no+XXb4ywMvS6UtmNeZIUjC5WPpurjMb34uuY/HBajQUxQQ
 owXrGCfWMF8JUnvvRP9Idg+rXw5TtSSypLeyDkztAqTvHKuPdqD8MbhesrPTnvSWdzet2BQCUh
 +y2yt1ZnsMxgca7ZHKU/qdg5DrXR8O41IQG5s0fbqmPmxQeWLqGb/KcuAL6GtkLGKEqrcohKAF
 PO0=
X-SBRS: 2.7
X-MesageID: 12479585
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,413,1574139600"; 
   d="scan'208";a="12479585"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v3 2/4] x86/xen: add basic KASAN support for PV kernel
Date:   Fri, 7 Feb 2020 14:26:50 +0000
Message-ID: <20200207142652.670-3-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207142652.670-1-sergey.dyasli@citrix.com>
References: <20200207142652.670-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce and use xen_kasan_* functions that are needed to properly
initialise KASAN for Xen PV domains. Disable instrumentation for files
that are used by xen_start_kernel() before kasan_early_init() could
be called.

This enables to use Outline instrumentation for Xen PV kernels.
KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
and hence disabled.

Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
v2 --> v3:
- Fix compilation without CONFIG_KASAN
- Dropped _pv prefixes from new functions
- Made xen_kasan_early_init() call kasan_map_early_shadow() directly
- Updated description

v1 --> v2:
- Fix compilation without CONFIG_XEN_PV
- Use macros for KASAN_SHADOW_START

RFC --> v1:
- New functions with declarations in xen/xen-ops.h
- Fixed the issue with free_kernel_image_pages() with the help of
  xen_pv_kasan_unpin_pgd()
---
 arch/x86/mm/kasan_init_64.c | 10 ++++++++-
 arch/x86/xen/Makefile       |  7 ++++++
 arch/x86/xen/enlighten_pv.c |  3 +++
 arch/x86/xen/mmu_pv.c       | 43 +++++++++++++++++++++++++++++++++++++
 drivers/xen/Makefile        |  2 ++
 include/linux/kasan.h       |  2 ++
 include/xen/xen-ops.h       | 10 +++++++++
 lib/Kconfig.kasan           |  3 ++-
 8 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 763e71abc0fe..b862c03a2019 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -13,6 +13,8 @@
 #include <linux/sched/task.h>
 #include <linux/vmalloc.h>
 
+#include <xen/xen-ops.h>
+
 #include <asm/e820/types.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -231,7 +233,7 @@ static void __init kasan_early_p4d_populate(pgd_t *pgd,
 	} while (p4d++, addr = next, addr != end && p4d_none(*p4d));
 }
 
-static void __init kasan_map_early_shadow(pgd_t *pgd)
+void __init kasan_map_early_shadow(pgd_t *pgd)
 {
 	/* See comment in kasan_init() */
 	unsigned long addr = KASAN_SHADOW_START & PGDIR_MASK;
@@ -317,6 +319,8 @@ void __init kasan_early_init(void)
 
 	kasan_map_early_shadow(early_top_pgt);
 	kasan_map_early_shadow(init_top_pgt);
+
+	xen_kasan_early_init();
 }
 
 void __init kasan_init(void)
@@ -348,6 +352,8 @@ void __init kasan_init(void)
 				__pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
 	}
 
+	xen_kasan_pin_pgd(early_top_pgt);
+
 	load_cr3(early_top_pgt);
 	__flush_tlb_all();
 
@@ -412,6 +418,8 @@ void __init kasan_init(void)
 	load_cr3(init_top_pgt);
 	__flush_tlb_all();
 
+	xen_kasan_unpin_pgd(early_top_pgt);
+
 	/*
 	 * kasan_early_shadow_page has been used as early shadow memory, thus
 	 * it may contain some garbage. Now we can clear and write protect it,
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 084de77a109e..102fad0b0bca 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,3 +1,10 @@
+KASAN_SANITIZE_enlighten_pv.o := n
+KASAN_SANITIZE_enlighten.o := n
+KASAN_SANITIZE_irq.o := n
+KASAN_SANITIZE_mmu_pv.o := n
+KASAN_SANITIZE_p2m.o := n
+KASAN_SANITIZE_multicalls.o := n
+
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index ae4a41ca19f6..27de55699f24 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -72,6 +72,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#include <asm/kasan.h>
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -1231,6 +1232,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
+	kasan_early_init();
+
 	/*
 	 * Set up kernel GDT and segment registers, mainly so that
 	 * -fstack-protector code can be executed.
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index bbba8b17829a..a9a47f0bf22e 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1771,6 +1771,41 @@ static void __init set_page_prot(void *addr, pgprot_t prot)
 {
 	return set_page_prot_flags(addr, prot, UVMF_NONE);
 }
+
+#ifdef CONFIG_KASAN
+void __init xen_kasan_early_init(void)
+{
+	if (!xen_pv_domain())
+		return;
+
+	/* PV page tables must be read-only */
+	set_page_prot(kasan_early_shadow_pud, PAGE_KERNEL_RO);
+	set_page_prot(kasan_early_shadow_pmd, PAGE_KERNEL_RO);
+	set_page_prot(kasan_early_shadow_pte, PAGE_KERNEL_RO);
+
+	/* Add KASAN mappings into initial PV page tables */
+	kasan_map_early_shadow((pgd_t *)xen_start_info->pt_base);
+}
+
+void __init xen_kasan_pin_pgd(pgd_t *pgd)
+{
+	if (!xen_pv_domain())
+		return;
+
+	set_page_prot(pgd, PAGE_KERNEL_RO);
+	pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE, PFN_DOWN(__pa_symbol(pgd)));
+}
+
+void __init xen_kasan_unpin_pgd(pgd_t *pgd)
+{
+	if (!xen_pv_domain())
+		return;
+
+	pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, PFN_DOWN(__pa_symbol(pgd)));
+	set_page_prot(pgd, PAGE_KERNEL);
+}
+#endif /* ifdef CONFIG_KASAN */
+
 #ifdef CONFIG_X86_32
 static void __init xen_map_identity_early(pmd_t *pmd, unsigned long max_pfn)
 {
@@ -1943,6 +1978,14 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	if (i && i < pgd_index(__START_KERNEL_map))
 		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
 
+#ifdef CONFIG_KASAN
+	/* Copy KASAN mappings */
+	for (i = pgd_index(KASAN_SHADOW_START);
+	     i < pgd_index(KASAN_SHADOW_END);
+	     i++)
+		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
+#endif /* ifdef CONFIG_KASAN */
+
 	/* Make pagetable pieces RO */
 	set_page_prot(init_top_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level3_ident_pgt, PAGE_KERNEL_RO);
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 0c4efa6fe450..1e9e1e41c0a8 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+KASAN_SANITIZE_features.o := n
+
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
 obj-y	+= mem-reservation.o
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5cde9e7c2664..2ab644229217 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -20,6 +20,8 @@ extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
 extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
+void kasan_map_early_shadow(pgd_t *pgd);
+
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
 
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 095be1d66f31..f67f1f2d73c6 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -241,4 +241,14 @@ static inline void xen_preemptible_hcall_end(void)
 
 #endif /* CONFIG_PREEMPTION */
 
+#if defined(CONFIG_XEN_PV) && defined(CONFIG_KASAN)
+void xen_kasan_early_init(void);
+void xen_kasan_pin_pgd(pgd_t *pgd);
+void xen_kasan_unpin_pgd(pgd_t *pgd);
+#else
+static inline void xen_kasan_early_init(void) { }
+static inline void xen_kasan_pin_pgd(pgd_t *pgd) { }
+static inline void xen_kasan_unpin_pgd(pgd_t *pgd) { }
+#endif /* if defined(CONFIG_XEN_PV) && defined(CONFIG_KASAN) */
+
 #endif /* INCLUDE_XEN_OPS_H */
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 81f5464ea9e1..429a638625ea 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -98,6 +98,7 @@ config KASAN_OUTLINE
 
 config KASAN_INLINE
 	bool "Inline instrumentation"
+	depends on !XEN_PV
 	help
 	  Compiler directly inserts code checking shadow memory before
 	  memory accesses. This is faster than outline (in some workloads
@@ -147,7 +148,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on KASAN && HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN && HAVE_ARCH_KASAN_VMALLOC && !XEN_PV
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.17.1

