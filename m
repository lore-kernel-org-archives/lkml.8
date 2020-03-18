Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EBEC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463B0206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DrKo9YpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCRBL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:11:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45899 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgCRBL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584493917; x=1616029917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y2/UXPjDwLdOfy/PVsYTckPFyrTJv4F9RDTRgyq+C5I=;
  b=DrKo9YpYOZN3g8sxLS++u+N+OV84Jnr860MLXvAyW4NiGr0j3KjV/R7a
   BjvczjwmPsyiqdTy0q+1kDDOIh0Qid6HgR9yPNVfvWvAn9VK6rCc9sQ0o
   P6kmEcblkj/61CTWets05bDiiOduWQCxJLeKmV/JoZwx5d5umpdzBHlRZ
   Hli5+ELrpZiesWnRKv1R/N1xlPh57hiRa54HsOg+oYbMcLP5M+/w7Wd4a
   DxLdYN1p0foiOkmKjNwCmEx+3GJ3sMmUKoCuBxvUMXK4kxWt+4CGb3SRv
   MlubCVognzEFnqZQEjB+JeEqdrtUxXR5PMvcrK8BMKBXyUMxpMK9gBRYc
   A==;
IronPort-SDR: aKNnEsm4XwgfKC+Inxs0BqcocZgApdljhCrg7QC4myS9AZ7U2Gor3NCPhfzS91ciFqNILQhELh
 kD/Gpsr4JTthIVjR88wMJQ/ryWdl66QX1kSDGgLZvXcOC5/K3V4uv6Cr1tn0y8wAYQMrMIDiZL
 td+yBFG+CW9x8Vb+aLteKioIklYUcjndq0yIXIk6cYw/lyS1OwRNI2G3dGtK62jbe24J3MZWDp
 pUnE+VfEWe+yp3amqYbJBpIDBVKTt1TwXtnbaEQBgvZHBWPAEFBTQATAZ+WwYtIxGzNyl0bVKH
 WLY=
X-IronPort-AV: E=Sophos;i="5.70,565,1574092800"; 
   d="scan'208";a="133241500"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2020 09:11:57 +0800
IronPort-SDR: JV3wLUtG6bvMQ3etucUX5uh5ZbLNEGB+4jfNN5/9KHFQP0/w87gxXMKj3UsxvYAl/rhVT/IAam
 B4NE2S5iGMxM3KhizVitoKuqcJQDA7oG9bWIbl1W/ML7+5JqvetykatIAofjPE0JGqincA54Mx
 DicE/yqU9tbRtw0Kcvdv8XwWBvPwFOSNi4wIJHZyZ+fZsFCsh3bGefez4WFLRe87CIv7nJ+/g4
 Ld8SiBweSYnDvbrL4NLHMvCVW0kOYVngYvw3pJEyf/o3SiDfFHiXo0Kx74naudr6ccwaChKhP+
 4vrXapY1MCekVTMfOq/GEwVj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:03:47 -0700
IronPort-SDR: xY8ehpWLqWdIYdqgCFrF2W/NcrR7iUVIpxby8TSmla+ksvRl/SX/3BaGD8zHoNrc+JWF2RvKov
 tozLN37QTrwmp1GsxAtr243Smg5kxZRPCao7E9w/xPmnxnb3ANeqS3o5JuzZSl4WHCIrIAFn56
 RTo6OsDB+CcIutFuEJ+Emeq28rKeoIpPU3wPCWxBuALDrKOyzNT/BGuycgBwsmWsYoUbEuV5CO
 cGp/igAoM0+3/l2Fxdi5bSiRfbBj5iK9pgEU9ecQ/0NqPQdRnl1iU+j5JFMnwwTWlKddJEJDC7
 U/c=
WDCIronportException: Internal
Received: from mccorma-lt.ad.shared (HELO yoda.hgst.com) ([10.86.54.125])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2020 18:11:56 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v11 02/11] RISC-V: Add basic support for SBI v0.2
Date:   Tue, 17 Mar 2020 18:11:35 -0700
Message-Id: <20200318011144.91532-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318011144.91532-1-atish.patra@wdc.com>
References: <20200318011144.91532-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI v0.2 introduces a base extension which is backward compatible
with v0.1. Implement all helper functions and minimum required SBI
calls from v0.2 for now. All other base extension function will be
added later as per need.
As v0.2 calling convention is backward compatible with v0.1, remove
the v0.1 helper functions and just use v0.2 calling convention.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/sbi.h | 139 ++++++++++----------
 arch/riscv/kernel/sbi.c      | 243 ++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/setup.c    |   5 +
 3 files changed, 314 insertions(+), 73 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2a637ebd7a22..5b7b91c7e7e6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -10,92 +10,88 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_RISCV_SBI
-#define SBI_EXT_0_1_SET_TIMER 0x0
-#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
-#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
-#define SBI_EXT_0_1_CLEAR_IPI 0x3
-#define SBI_EXT_0_1_SEND_IPI 0x4
-#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
-#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
-#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
-#define SBI_EXT_0_1_SHUTDOWN 0x8
+enum sbi_ext_id {
+	SBI_EXT_0_1_SET_TIMER = 0x0,
+	SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
+	SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
+	SBI_EXT_0_1_CLEAR_IPI = 0x3,
+	SBI_EXT_0_1_SEND_IPI = 0x4,
+	SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
+	SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
+	SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
+	SBI_EXT_0_1_SHUTDOWN = 0x8,
+	SBI_EXT_BASE = 0x10,
+};
 
-#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);	\
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(which);	\
-	asm volatile ("ecall"					\
-		      : "+r" (a0)				\
-		      : "r" (a1), "r" (a2), "r" (a3), "r" (a7)	\
-		      : "memory");				\
-	a0;							\
-})
+enum sbi_ext_base_fid {
+	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
+	SBI_EXT_BASE_GET_IMP_ID,
+	SBI_EXT_BASE_GET_IMP_VERSION,
+	SBI_EXT_BASE_PROBE_EXT,
+	SBI_EXT_BASE_GET_MVENDORID,
+	SBI_EXT_BASE_GET_MARCHID,
+	SBI_EXT_BASE_GET_MIMPID,
+};
 
-/* Lazy implementations until SBI is finalized */
-#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
-#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
-#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
-#define SBI_CALL_3(which, arg0, arg1, arg2) \
-		SBI_CALL(which, arg0, arg1, arg2, 0)
-#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
-		SBI_CALL(which, arg0, arg1, arg2, arg3)
+#define SBI_SPEC_VERSION_DEFAULT	0x1
+#define SBI_SPEC_VERSION_MAJOR_SHIFT	24
+#define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
+#define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
 
-static inline void sbi_console_putchar(int ch)
-{
-	SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
-}
+/* SBI return error codes */
+#define SBI_SUCCESS		0
+#define SBI_ERR_FAILURE		-1
+#define SBI_ERR_NOT_SUPPORTED	-2
+#define SBI_ERR_INVALID_PARAM	-3
+#define SBI_ERR_DENIED		-4
+#define SBI_ERR_INVALID_ADDRESS	-5
 
-static inline int sbi_console_getchar(void)
-{
-	return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
-}
+extern unsigned long sbi_spec_version;
+struct sbiret {
+	long error;
+	long value;
+};
 
-static inline void sbi_set_timer(uint64_t stime_value)
-{
-#if __riscv_xlen == 32
-	SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
-		   stime_value >> 32);
-#else
-	SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
-#endif
-}
-
-static inline void sbi_shutdown(void)
-{
-	SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
-}
+int sbi_init(void);
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5);
 
-static inline void sbi_clear_ipi(void)
-{
-	SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
-}
+void sbi_console_putchar(int ch);
+int sbi_console_getchar(void);
+void sbi_set_timer(uint64_t stime_value);
+void sbi_shutdown(void);
+void sbi_clear_ipi(void);
+void sbi_send_ipi(const unsigned long *hart_mask);
+void sbi_remote_fence_i(const unsigned long *hart_mask);
+void sbi_remote_sfence_vma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size);
 
-static inline void sbi_send_ipi(const unsigned long *hart_mask)
-{
-	SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
-}
+void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long asid);
+int sbi_probe_extension(int ext);
 
-static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
+/* Check if current SBI specification version is 0.1 or not */
+static inline int sbi_spec_is_0_1(void)
 {
-	SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
+	return (sbi_spec_version == SBI_SPEC_VERSION_DEFAULT) ? 1 : 0;
 }
 
-static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
-					 unsigned long start,
-					 unsigned long size)
+/* Get the major version of SBI */
+static inline unsigned long sbi_major_version(void)
 {
-	SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask, start, size);
+	return (sbi_spec_version >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
+		SBI_SPEC_VERSION_MAJOR_MASK;
 }
 
-static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
-					      unsigned long start,
-					      unsigned long size,
-					      unsigned long asid)
+/* Get the minor version of SBI */
+static inline unsigned long sbi_minor_version(void)
 {
-	SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
-		   start, size, asid);
+	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
 }
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
@@ -103,5 +99,6 @@ void sbi_set_timer(uint64_t stime_value);
 void sbi_clear_ipi(void);
 void sbi_send_ipi(const unsigned long *hart_mask);
 void sbi_remote_fence_i(const unsigned long *hart_mask);
+void sbi_init(void);
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f6c7c3e82d28..4aee0b49df3c 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -1,17 +1,256 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SBI initialilization and all extension implementation.
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ */
 
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <asm/sbi.h>
 
+/* default SBI version is 0.1 */
+unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
+EXPORT_SYMBOL(sbi_spec_version);
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5)
+{
+	struct sbiret ret;
+
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
+	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	asm volatile ("ecall"
+		      : "+r" (a0), "+r" (a1)
+		      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
+		      : "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	return ret;
+}
+EXPORT_SYMBOL(sbi_ecall);
+
+static int sbi_err_map_linux_errno(int err)
+{
+	switch (err) {
+	case SBI_SUCCESS:
+		return 0;
+	case SBI_ERR_DENIED:
+		return -EPERM;
+	case SBI_ERR_INVALID_PARAM:
+		return -EINVAL;
+	case SBI_ERR_INVALID_ADDRESS:
+		return -EFAULT;
+	case SBI_ERR_NOT_SUPPORTED:
+	case SBI_ERR_FAILURE:
+	default:
+		return -ENOTSUPP;
+	};
+}
+
+/**
+ * sbi_console_putchar() - Writes given character to the console device.
+ * @ch: The data to be written to the console.
+ *
+ * Return: None
+ */
+void sbi_console_putchar(int ch)
+{
+	sbi_ecall(SBI_EXT_0_1_CONSOLE_PUTCHAR, 0, ch, 0, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL(sbi_console_putchar);
+
+/**
+ * sbi_console_getchar() - Reads a byte from console device.
+ *
+ * Returns the value read from console.
+ */
+int sbi_console_getchar(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_0_1_CONSOLE_GETCHAR, 0, 0, 0, 0, 0, 0, 0);
+
+	return ret.error;
+}
+EXPORT_SYMBOL(sbi_console_getchar);
+
+/**
+ * sbi_set_timer() - Program the timer for next timer event.
+ * @stime_value: The value after which next timer event should fire.
+ *
+ * Return: None
+ */
+void sbi_set_timer(uint64_t stime_value)
+{
+#if __riscv_xlen == 32
+	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
+		  stime_value >> 32, 0, 0, 0, 0);
+#else
+	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
+#endif
+}
+EXPORT_SYMBOL(sbi_set_timer);
+
+/**
+ * sbi_shutdown() - Remove all the harts from executing supervisor code.
+ *
+ * Return: None
+ */
+void sbi_shutdown(void)
+{
+	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL(sbi_shutdown);
+
+/**
+ * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
+ *
+ * Return: None
+ */
+void sbi_clear_ipi(void)
+{
+	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
+}
+
+/**
+ * sbi_send_ipi() - Send an IPI to any hart.
+ * @hart_mask: A cpu mask containing all the target harts.
+ *
+ * Return: None
+ */
+void sbi_send_ipi(const unsigned long *hart_mask)
+{
+	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
+		  0, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL(sbi_send_ipi);
+
+/**
+ * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
+ * @hart_mask: A cpu mask containing all the target harts.
+ *
+ * Return: None
+ */
+void sbi_remote_fence_i(const unsigned long *hart_mask)
+{
+	sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
+		  0, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL(sbi_remote_fence_i);
+
+/**
+ * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
+ *			     harts for the specified virtual address range.
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the virtual address
+ * @size: Total size of the virtual address range.
+ *
+ * Return: None
+ */
+void sbi_remote_sfence_vma(const unsigned long *hart_mask,
+			   unsigned long start,
+			   unsigned long size)
+{
+	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
+		  (unsigned long)hart_mask, start, size, 0, 0, 0);
+}
+EXPORT_SYMBOL(sbi_remote_sfence_vma);
+
+/**
+ * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on given
+ * remote harts for a virtual address range belonging to a specific ASID.
+ *
+ * @hart_mask: A cpu mask containing all the target harts.
+ * @start: Start of the virtual address
+ * @size: Total size of the virtual address range.
+ * @asid: The value of address space identifier (ASID).
+ *
+ * Return: None
+ */
+void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
+				unsigned long start,
+				unsigned long size,
+				unsigned long asid)
+{
+	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
+		  (unsigned long)hart_mask, start, size, asid, 0, 0);
+}
+EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
+
+/**
+ * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
+ * @extid: The extension ID to be probed.
+ *
+ * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
+ */
+int sbi_probe_extension(int extid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
+			0, 0, 0, 0, 0);
+	if (!ret.error)
+		if (ret.value)
+			return ret.value;
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL(sbi_probe_extension);
+
+static long __sbi_base_ecall(int fid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+
+static inline long sbi_get_spec_version(void)
+{
+	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
+}
+
+static inline long sbi_get_firmware_id(void)
+{
+	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
+}
+
+static inline long sbi_get_firmware_version(void)
+{
+	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_VERSION);
+}
+
 static void sbi_power_off(void)
 {
 	sbi_shutdown();
 }
 
-static int __init sbi_init(void)
+int __init sbi_init(void)
 {
+	int ret;
+
 	pm_power_off = sbi_power_off;
+	ret = sbi_get_spec_version();
+	if (ret > 0)
+		sbi_spec_version = ret;
+
+	pr_info("SBI specification v%lu.%lu detected\n",
+		sbi_major_version(), sbi_minor_version());
+	if (!sbi_spec_is_0_1())
+		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
+			sbi_get_firmware_id(), sbi_get_firmware_version());
 	return 0;
 }
-early_initcall(sbi_init);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 0a6d415b0a5a..44ac4ddf60ab 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
+#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
@@ -79,6 +80,10 @@ void __init setup_arch(char **cmdline_p)
 	kasan_init();
 #endif
 
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	sbi_init();
+#endif
+
 #ifdef CONFIG_SMP
 	setup_smp();
 #endif
-- 
2.25.1

