Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65381C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 04:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41308206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 04:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgHXEFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 00:05:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgHXEFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 00:05:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F111063;
        Sun, 23 Aug 2020 21:05:18 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BBF53F66B;
        Sun, 23 Aug 2020 21:05:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/hotplug: Improve memory offline event notifier
Date:   Mon, 24 Aug 2020 09:34:29 +0530
Message-Id: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings about three different changes to the sole memory event notifier
for arm64 platform and improves it's robustness while also enhancing debug
capabilities during potential memory offlining error conditions.

This moves the memory notifier registration bit earlier in the boot process
from device_initcall() to setup_arch() which will help in guarding against
potential early boot memory offline requests.

This enables MEM_OFFLINE memory event handling. It will help intercept any
possible error condition such as if boot memory some how still got offlined
even after an expilicit notifier failure, potentially by a future change in
generic hotplug framework. This would help detect such scenarious and help
debug further.

It also adds a validation function which scans entire boot memory and makes
sure that early memory sections are online. This check is essential for the
memory notifier to work properly as it cannot prevent boot memory offlining
if they are not online to begin with. But this additional sanity check is
enabled only with DEBUG_VM.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 5.9-rc2

Changes in V2:

- Dropped all generic changes wrt MEM_CANCEL_OFFLINE reasons enumeration
- Dropped all related (processing MEM_CANCEL_OFFLINE reasons) changes on arm64
- Added validate_boot_mem_online_state() that gets called with early_initcall()
- Added CONFIG_MEMORY_HOTREMOVE check before registering memory notifier
- Moved notifier registration i.e memory_hotremove_notifier into setup_arch()

Changes in V1: (https://patchwork.kernel.org/project/linux-mm/list/?series=271237)

 arch/arm64/include/asm/mmu.h |   8 +++
 arch/arm64/kernel/setup.c    |   8 +++
 arch/arm64/mm/mmu.c          | 108 ++++++++++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index a7a5ecaa2e83..b7e99b528766 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -73,6 +73,14 @@ static inline struct bp_hardening_data *arm64_get_bp_hardening_data(void)
 static inline void arm64_apply_bp_hardening(void)	{ }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern void memory_hotremove_notifier(void);
+#else
+static inline void memory_hotremove_notifier(void)
+{
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 extern void arm64_memblock_init(void);
 extern void paging_init(void);
 extern void bootmem_init(void);
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c4c9bad1b8..44406c9f8d83 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -376,6 +376,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 			"This indicates a broken bootloader or old kernel\n",
 			boot_args[1], boot_args[2], boot_args[3]);
 	}
+
+	/*
+	 * Register the memory notifier which will prevent boot
+	 * memory offlining requests - early enough. But there
+	 * should not be any actual offlinig request till memory
+	 * block devices are initialized with memory_dev_init().
+	 */
+	memory_hotremove_notifier();
 }
 
 static inline bool cpu_can_disable(unsigned int cpu)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..8cdb0b02089f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1482,13 +1482,40 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
 	unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
 	unsigned long pfn = arg->start_pfn;
 
-	if (action != MEM_GOING_OFFLINE)
+	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
 		return NOTIFY_OK;
 
-	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-		if (early_section(ms))
-			return NOTIFY_BAD;
+	if (action == MEM_GOING_OFFLINE) {
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+			if (early_section(ms)) {
+				pr_warn("Boot memory offlining attempted\n");
+				return NOTIFY_BAD;
+			}
+		}
+	} else if (action == MEM_OFFLINE) {
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+			if (early_section(ms)) {
+
+				/*
+				 * This should have never happened. Boot memory
+				 * offlining should have been prevented by this
+				 * very notifier. Probably some memory removal
+				 * procedure might have changed which would then
+				 * require further debug.
+				 */
+				pr_err("Boot memory offlined\n");
+
+				/*
+				 * Core memory hotplug does not process a return
+				 * code from the notifier for MEM_OFFLINE event.
+				 * Error condition has been reported. Report as
+				 * ignored.
+				 */
+				return NOTIFY_DONE;
+			}
+		}
 	}
 	return NOTIFY_OK;
 }
@@ -1497,9 +1524,74 @@ static struct notifier_block prevent_bootmem_remove_nb = {
 	.notifier_call = prevent_bootmem_remove_notifier,
 };
 
-static int __init prevent_bootmem_remove_init(void)
+void memory_hotremove_notifier(void)
 {
-	return register_memory_notifier(&prevent_bootmem_remove_nb);
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+		return;
+
+	rc = register_memory_notifier(&prevent_bootmem_remove_nb);
+	if (!rc)
+		return;
+
+	pr_err("Notifier registration failed - boot memory can be removed\n");
+}
+
+/*
+ * This ensures that boot memory sections on the plaltform are online
+ * during early boot. They could not be prevented from being offlined
+ * if for some reason they are not brought online to begin with. This
+ * help validate the basic assumption on which the above memory event
+ * notifier works to prevent boot memory offlining and it's possible
+ * removal.
+ */
+static int __init validate_bootmem_online_state(void)
+{
+	struct memblock_region *mblk;
+	struct mem_section *ms;
+	unsigned long pfn, end_pfn, start, end;
+
+	/*
+	 * Scanning across all memblock might be expensive
+	 * on some big memory systems. Hence enable this
+	 * validation only with DEBUG_VM.
+	 */
+	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) ||
+			!IS_ENABLED(CONFIG_DEBUG_VM))
+		return 0;
+
+	for_each_memblock(memory, mblk) {
+		pfn = PHYS_PFN(mblk->base);
+		end_pfn = PHYS_PFN(mblk->base + mblk->size);
+
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			ms = __pfn_to_section(pfn);
+
+			/*
+			 * All memory ranges in the system at this point
+			 * should have been marked early sections.
+			 */
+			WARN_ON(!early_section(ms));
+
+			/*
+			 * Memory notifier mechanism here to prevent boot
+			 * memory offlining depends on the fact that each
+			 * early section memory on the system is intially
+			 * online. Otherwise a given memory section which
+			 * is already offline will be overlooked and can
+			 * be removed completely. Call out such sections.
+			 */
+			if (!online_section(ms)) {
+				start = PFN_PHYS(pfn);
+				end = start + (1UL << PA_SECTION_SHIFT);
+
+				pr_err("Memory range [%lx %lx] is offline\n", start, end);
+				pr_err("Memory range [%lx %lx] can be removed\n", start, end);
+			}
+		}
+	}
+	return 0;
 }
-device_initcall(prevent_bootmem_remove_init);
+early_initcall(validate_bootmem_online_state);
 #endif
-- 
2.20.1

