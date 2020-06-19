Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C962080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405702AbgFSQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405015AbgFSQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C693DC06174E;
        Fri, 19 Jun 2020 09:46:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9O-00042s-GA; Fri, 19 Jun 2020 18:45:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 116361C0085;
        Fri, 19 Jun 2020 18:45:58 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:45:57 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: arm: Print CPU boot mode and MMU state at boot
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159258515777.16989.6870030689114091702.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     2a55280a3675203496d302463b941834228b9875
Gitweb:        https://git.kernel.org/tip/2a55280a3675203496d302463b941834228b9875
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 07 Jun 2020 15:41:35 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 17 Jun 2020 15:29:11 +02:00

efi/libstub: arm: Print CPU boot mode and MMU state at boot

On 32-bit ARM, we may boot at HYP mode, or with the MMU and caches off
(or both), even though the EFI spec does not actually support this.
While booting at HYP mode is something we might tolerate, fiddling
with the caches is a more serious issue, as disabling the caches is
tricky to do safely from C code, and running without the Dcache makes
it impossible to support unaligned memory accesses, which is another
explicit requirement imposed by the EFI spec.

So take note of the CPU mode and MMU state in the EFI stub diagnostic
output so that we can easily diagnose any issues that may arise from
this. E.g.,

  EFI stub: Entering in SVC mode with MMU enabled

Also, capture the CPSR and SCTLR system register values at EFI stub
entry, and after ExitBootServices() returns, and check whether the
MMU and Dcache were disabled at any point. If this is the case, a
diagnostic message like the following will be emitted:

  efi: [Firmware Bug]: EFI stub was entered with MMU and Dcache disabled, please fix your firmware!
  efi: CPSR at EFI stub entry        : 0x600001d3
  efi: SCTLR at EFI stub entry       : 0x00c51838
  efi: CPSR after ExitBootServices() : 0x600001d3
  efi: SCTLR after ExitBootServices(): 0x00c50838

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
---
 arch/arm/include/asm/efi.h                |  7 +++-
 drivers/firmware/efi/arm-init.c           | 34 +++++++++++++-
 drivers/firmware/efi/libstub/arm32-stub.c | 54 +++++++++++++++++++++-
 drivers/firmware/efi/libstub/efi-stub.c   |  3 +-
 drivers/firmware/efi/libstub/efistub.h    |  2 +-
 include/linux/efi.h                       |  1 +-
 6 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 84dc0ba..5dcf3c6 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -87,4 +87,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return dram_base + SZ_512M;
 }
 
+struct efi_arm_entry_state {
+	u32	cpsr_before_ebs;
+	u32	sctlr_before_ebs;
+	u32	cpsr_after_ebs;
+	u32	sctlr_after_ebs;
+};
+
 #endif /* _ASM_ARM_EFI_H */
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 6f4baf7..71c445d 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -52,9 +52,11 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 }
 
 static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
+static __initdata unsigned long cpu_state_table = EFI_INVALID_TABLE_ADDR;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
 	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
+	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
 	{}
 };
 
@@ -240,9 +242,37 @@ void __init efi_init(void)
 
 	init_screen_info();
 
+#ifdef CONFIG_ARM
 	/* ARM does not permit early mappings to persist across paging_init() */
-	if (IS_ENABLED(CONFIG_ARM))
-		efi_memmap_unmap();
+	efi_memmap_unmap();
+
+	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
+		struct efi_arm_entry_state *state;
+		bool dump_state = true;
+
+		state = early_memremap_ro(cpu_state_table,
+					  sizeof(struct efi_arm_entry_state));
+		if (state == NULL) {
+			pr_warn("Unable to map CPU entry state table.\n");
+			return;
+		}
+
+		if ((state->sctlr_before_ebs & 1) == 0)
+			pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
+		else if ((state->sctlr_after_ebs & 1) == 0)
+			pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
+		else
+			dump_state = false;
+
+		if (dump_state || efi_enabled(EFI_DBG)) {
+			pr_info("CPSR at EFI stub entry        : 0x%08x\n", state->cpsr_before_ebs);
+			pr_info("SCTLR at EFI stub entry       : 0x%08x\n", state->sctlr_before_ebs);
+			pr_info("CPSR after ExitBootServices() : 0x%08x\n", state->cpsr_after_ebs);
+			pr_info("SCTLR after ExitBootServices(): 0x%08x\n", state->sctlr_after_ebs);
+		}
+		early_memunmap(state, sizeof(struct efi_arm_entry_state));
+	}
+#endif
 }
 
 static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 40243f5..d08e5d5 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -7,10 +7,49 @@
 
 #include "efistub.h"
 
+static efi_guid_t cpu_state_guid = LINUX_EFI_ARM_CPU_STATE_TABLE_GUID;
+
+struct efi_arm_entry_state *efi_entry_state;
+
+static void get_cpu_state(u32 *cpsr, u32 *sctlr)
+{
+	asm("mrs %0, cpsr" : "=r"(*cpsr));
+	if ((*cpsr & MODE_MASK) == HYP_MODE)
+		asm("mrc p15, 4, %0, c1, c0, 0" : "=r"(*sctlr));
+	else
+		asm("mrc p15, 0, %0, c1, c0, 0" : "=r"(*sctlr));
+}
+
 efi_status_t check_platform_features(void)
 {
+	efi_status_t status;
+	u32 cpsr, sctlr;
 	int block;
 
+	get_cpu_state(&cpsr, &sctlr);
+
+	efi_info("Entering in %s mode with MMU %sabled\n",
+		 ((cpsr & MODE_MASK) == HYP_MODE) ? "HYP" : "SVC",
+		 (sctlr & 1) ? "en" : "dis");
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*efi_entry_state),
+			     (void **)&efi_entry_state);
+	if (status != EFI_SUCCESS) {
+		efi_err("allocate_pool() failed\n");
+		return status;
+	}
+
+	efi_entry_state->cpsr_before_ebs = cpsr;
+	efi_entry_state->sctlr_before_ebs = sctlr;
+
+	status = efi_bs_call(install_configuration_table, &cpu_state_guid,
+			     efi_entry_state);
+	if (status != EFI_SUCCESS) {
+		efi_err("install_configuration_table() failed\n");
+		goto free_state;
+	}
+
 	/* non-LPAE kernels can run anywhere */
 	if (!IS_ENABLED(CONFIG_ARM_LPAE))
 		return EFI_SUCCESS;
@@ -19,9 +58,22 @@ efi_status_t check_platform_features(void)
 	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
 	if (block < 5) {
 		efi_err("This LPAE kernel is not supported by your CPU\n");
-		return EFI_UNSUPPORTED;
+		status = EFI_UNSUPPORTED;
+		goto drop_table;
 	}
 	return EFI_SUCCESS;
+
+drop_table:
+	efi_bs_call(install_configuration_table, &cpu_state_guid, NULL);
+free_state:
+	efi_bs_call(free_pool, efi_entry_state);
+	return status;
+}
+
+void efi_handle_post_ebs_state(void)
+{
+	get_cpu_state(&efi_entry_state->cpsr_after_ebs,
+		      &efi_entry_state->sctlr_after_ebs);
 }
 
 static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index e97370b..3318ec3 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -329,6 +329,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (status != EFI_SUCCESS)
 		goto fail_free_initrd;
 
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_handle_post_ebs_state();
+
 	efi_enter_kernel(image_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
 	/* not reached */
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index ac756f1..2c9d422 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -777,4 +777,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit);
 
+void efi_handle_post_ebs_state(void);
+
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c3449c9..bb35f33 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -350,6 +350,7 @@ void efi_native_runtime_setup(void);
  * associated with ConOut
  */
 #define LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+#define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
