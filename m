Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F2FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2F82076A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgHANGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 09:06:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbgHANGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 09:06:13 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24B54892E5DB33B6111B;
        Sat,  1 Aug 2020 21:06:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 1 Aug 2020 21:05:58 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <chenzhou10@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <wangkefeng.wang@huawei.com>
Subject: [PATCH v11 2/5] x86: kdump: move reserve_crashkernel_low() into crash_core.c
Date:   Sat, 1 Aug 2020 21:08:53 +0800
Message-ID: <20200801130856.86625-3-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200801130856.86625-1-chenzhou10@huawei.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting reserve_crashkernel_low in arm64 as
x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.

BTW, move x86_64 CRASH_ALIGN to 2M suggested by Dave. CONFIG_PHYSICAL_ALIGN
can be selected from 2M to 16M, move to the same as arm64.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/include/asm/kexec.h | 24 ++++++++++
 arch/x86/kernel/setup.c      | 86 +++---------------------------------
 include/linux/crash_core.h   |  3 ++
 include/linux/kexec.h        |  2 -
 kernel/crash_core.c          | 74 +++++++++++++++++++++++++++++++
 kernel/kexec_core.c          | 17 -------
 6 files changed, 107 insertions(+), 99 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 6802c59e8252..f8f9d952e09f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,30 @@
 
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
+/* 2M alignment for crash kernel regions */
+#define CRASH_ALIGN	SZ_2M
+
+/*
+ * Keep the crash kernel below this limit.
+ *
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
+ * due to mapping restrictions.
+ *
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
+ */
+#ifdef CONFIG_X86_32
+# define CRASH_ADDR_LOW_MAX	SZ_512M
+# define CRASH_ADDR_HIGH_MAX	SZ_512M
+#else
+# define CRASH_ADDR_LOW_MAX	SZ_4G
+# define CRASH_ADDR_HIGH_MAX	SZ_64T
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758..46763c1e5d9f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -401,83 +401,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 #ifdef CONFIG_KEXEC_CORE
 
-/* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		SZ_16M
-
-/*
- * Keep the crash kernel below this limit.
- *
- * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
- * due to mapping restrictions.
- *
- * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
- * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jump could be from 5-level paging to 4-level paging, the jump will fail if
- * the kernel is put above 64 TB, and during the 1st kernel bootup there's
- * no good way to detect the paging mode of the target kernel which will be
- * loaded for dumping.
- */
-#ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	SZ_512M
-# define CRASH_ADDR_HIGH_MAX	SZ_512M
-#else
-# define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	SZ_64T
-#endif
-
-static int __init reserve_crashkernel_low(void)
-{
-#ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long total_low_mem;
-	int ret;
-
-	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
-	if (ret) {
-		/*
-		 * two parts from kernel/dma/swiotlb.c:
-		 * -swiotlb size: user-specified with swiotlb= or default.
-		 *
-		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-		 * to 8M for other buffers that may need to stay low too. Also
-		 * make sure we allocate enough extra low memory so that we
-		 * don't run out of DMA buffers for 32-bit devices.
-		 */
-		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-	} else {
-		/* passed with crashkernel=0,low ? */
-		if (!low_size)
-			return 0;
-	}
-
-	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	ret = memblock_reserve(low_base, low_size);
-	if (ret) {
-		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
-		return ret;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(total_low_mem >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-#endif
-	return 0;
-}
-
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base, total_mem;
@@ -541,9 +464,12 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-		memblock_free(crash_base, crash_size);
-		return;
+	if (crash_base >= (1ULL << 32)) {
+		if (reserve_crashkernel_low()) {
+			memblock_free(crash_base, crash_size);
+			return;
+		}
+		insert_resource(&iomem_resource, &crashk_low_res);
 	}
 
 	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a9f965..4df8c0bff03e 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -63,6 +63,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 extern unsigned char *vmcoreinfo_data;
 extern size_t vmcoreinfo_size;
 extern u32 *vmcoreinfo_note;
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
 
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
@@ -74,5 +76,6 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int __init reserve_crashkernel_low(void);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ea67910ae6b7..a460afdbab0f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -330,8 +330,6 @@ extern int kexec_load_disabled;
 
 /* Location of a reserved region to hold the crash kernel.
  */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
 /* flag to track if kexec reboot is in progress */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b98468..c81b15dd78c2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,7 +7,10 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
 
+#include <asm/kexec.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
@@ -19,6 +22,22 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+/* Location of the reserved area for the crash kernel */
+struct resource crashk_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+struct resource crashk_low_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+
 /*
  * parsing the "crashkernel" commandline
  *
@@ -292,6 +311,61 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+int __init reserve_crashkernel_low(void)
+{
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
+	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long total_low_mem;
+	int ret;
+
+	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size,
+			&base);
+	if (ret) {
+		/*
+		 * two parts from lib/swiotlb.c:
+		 * -swiotlb size: user-specified with swiotlb= or default.
+		 *
+		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+		 * to 8M for other buffers that may need to stay low too. Also
+		 * make sure we allocate enough extra low memory so that we
+		 * don't run out of DMA buffers for 32-bit devices.
+		 */
+		low_size = max(swiotlb_size_or_default() + (8UL << 20),
+				256UL << 20);
+	} else {
+		/* passed with crashkernel=0,low ? */
+		if (!low_size)
+			return 0;
+	}
+
+	low_base = memblock_find_in_range(0, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
+	if (!low_base) {
+		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
+		       (unsigned long)(low_size >> 20));
+		return -ENOMEM;
+	}
+
+	ret = memblock_reserve(low_base, low_size);
+	if (ret) {
+		pr_err("%s: Error reserving crashkernel low memblock.\n",
+				__func__);
+		return ret;
+	}
+
+	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
+		(unsigned long)(low_size >> 20),
+		(unsigned long)(low_base >> 20),
+		(unsigned long)(total_low_mem >> 20));
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+#endif
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0dad1ebe..db66bbabfff3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,23 +53,6 @@ note_buf_t __percpu *crash_notes;
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-
-/* Location of the reserved area for the crash kernel */
-struct resource crashk_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-struct resource crashk_low_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.20.1

