Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39756206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbRsINFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGHVKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:10:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DCBC061A0B;
        Wed,  8 Jul 2020 14:10:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so4599503wml.3;
        Wed, 08 Jul 2020 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRdWrZGotFU/V/N69RBCWuEXsKoewH6WQsweVR7ALZI=;
        b=YbRsINFQuj4rsIvUK1OvMoLvTYf9ohCqUDZGyBsOUBI3xxHIV+sh/Njeh0iTFSfrm7
         nf2DXUHUvXzafp9O+7dfPtZWLreUJkV7xdBl9yr1xSMjbrDpILgJ7cmk8GUwE45rdFvk
         7+CIS4sSr7qsGv2SYKoAsRWs1ERetwZ6R2d70aPbkxz3tv7n+UvK2nuSZk4QB+OP5rLb
         JzTk7d1DU4nNJuvteFyS03a3Y7A1fkarmms0pCRX+2RLyA5oTERnh4J3Y95M3CdfIXWp
         aLbbh1t0UXAEekvcWViq+7HAn1MfESw1eamf8rR3WjF+ZYAdSXjKU7kiyPaOOwVn1/UT
         EJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BRdWrZGotFU/V/N69RBCWuEXsKoewH6WQsweVR7ALZI=;
        b=geybeQ7rhn/aTSoNGX4x7PFEN4Qq/zTVx0YUQTW80veZ+Vlq8vmCDhXigGiyKaWVHZ
         uS4Vrb47CARp9Xe8g8vaL7KDOnM72v8OB1cRkHATbZIygZ1CZOKymkjlEptZLCGZSMc9
         6U2fIc/0h75uT5a2j2B525EOzGp51SsLsoElBsLE84bMZUIqVsv7G85Jo1l4W8Nz4hYe
         JuEXb9bpYDAWtoaLitMk+h7xde8YR3fivPlAHgG8KbRdbtdOrS2qdGxFkoHITA0D8fob
         TaIBOvGCe2vODJSC8HxkJgpxSwV7pgm9hTNxciSRYioj45RAH3lbP2CJr+rBx8Z7Kj/9
         XXVA==
X-Gm-Message-State: AOAM530sLBb17UGtGvc5TzwJSOFBLlwujv8yz40TMrFXj1R9gF8GSDPX
        nB8Yq3GX3IoEB/Y1gphBXcg=
X-Google-Smtp-Source: ABdhPJwkstX8Sj2urYCU2SdzhkKIKmrEBrTXDdHq8hml/jbRvgiqZRnT5smUI7pFxM091Bbt5K6WzA==
X-Received: by 2002:a1c:4804:: with SMTP id v4mr11080060wma.139.1594242613783;
        Wed, 08 Jul 2020 14:10:13 -0700 (PDT)
Received: from localhost.localdomain ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id u23sm1971515wru.94.2020.07.08.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:10:13 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: Add jump-label implementation
Date:   Wed,  8 Jul 2020 23:09:48 +0200
Message-Id: <20200708210948.34197-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708210948.34197-1-kernel@esmil.dk>
References: <20200708210948.34197-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jump-label implementation based on the ARM64 version
and add CONFIG_JUMP_LABEL=y to the defconfigs.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Reviewed-by: Björn Töpel <bjorn.topel@gmail.com>
---

Tested on the HiFive Unleashed board.

Changes since v1:
- WARN and give up gracefully if the jump offset cannot be
  represented in a JAL instruction.
- Add missing braces.
- Add CONFIG_JUMP_LABEL=y to defconfigs.

All suggested by Björn Töpel.

Changes since RFC:
- Use RISCV_PTR and RISCV_LGPTR macros to match struct jump_table
  also in 32bit kernels.
- Remove unneeded branch ? 1 : 0, thanks Björn
- Fix \n\n instead of \n\t mistake

 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/riscv/Kconfig                            |  2 +
 arch/riscv/configs/defconfig                  |  1 +
 arch/riscv/configs/nommu_k210_defconfig       |  1 +
 arch/riscv/configs/nommu_virt_defconfig       |  1 +
 arch/riscv/configs/rv32_defconfig             |  1 +
 arch/riscv/include/asm/jump_label.h           | 59 +++++++++++++++++++
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/jump_label.c                | 49 +++++++++++++++
 9 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/jump_label.h
 create mode 100644 arch/riscv/kernel/jump_label.c

diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 632a1c7aefa2..760243d18ed7 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fd639937e251..d2f5c53fdc19 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,8 @@ config RISCV
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if MMU && 64BIT
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_KGDB_QXFER_PKT
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4da4886246a4..d58c93efb603 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index b48138e329ea..cd1df62b13c7 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -33,6 +33,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
 CONFIG_CMDLINE_FORCE=y
+CONFIG_JUMP_LABEL=y
 # CONFIG_BLOCK is not set
 CONFIG_BINFMT_FLAT=y
 # CONFIG_COREDUMP is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index cf74e179bf90..f27596e9663e 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -30,6 +30,7 @@ CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
 CONFIG_CMDLINE_FORCE=y
+CONFIG_JUMP_LABEL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_MSDOS_PARTITION is not set
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 05bbf5240569..3a55f0e00d6c 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
 CONFIG_SMP=y
+CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_NET=y
diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
new file mode 100644
index 000000000000..d5fb342bfccf
--- /dev/null
+++ b/arch/riscv/include/asm/jump_label.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Emil Renner Berthing
+ *
+ * Based on arch/arm64/include/asm/jump_label.h
+ */
+#ifndef __ASM_JUMP_LABEL_H
+#define __ASM_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#define JUMP_LABEL_NOP_SIZE 4
+
+static __always_inline bool arch_static_branch(struct static_key *key,
+					       bool branch)
+{
+	asm_volatile_goto(
+		"	.option push				\n\t"
+		"	.option norelax				\n\t"
+		"	.option norvc				\n\t"
+		"1:	nop					\n\t"
+		"	.option pop				\n\t"
+		"	.pushsection	__jump_table, \"aw\"	\n\t"
+		"	.align		" RISCV_LGPTR "		\n\t"
+		"	.long		1b - ., %l[label] - .	\n\t"
+		"	" RISCV_PTR "	%0 - .			\n\t"
+		"	.popsection				\n\t"
+		:  :  "i"(&((char *)key)[branch]) :  : label);
+
+	return false;
+label:
+	return true;
+}
+
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
+{
+	asm_volatile_goto(
+		"	.option push				\n\t"
+		"	.option norelax				\n\t"
+		"	.option norvc				\n\t"
+		"1:	jal		zero, %l[label]		\n\t"
+		"	.option pop				\n\t"
+		"	.pushsection	__jump_table, \"aw\"	\n\t"
+		"	.align		" RISCV_LGPTR "		\n\t"
+		"	.long		1b - ., %l[label] - .	\n\t"
+		"	" RISCV_PTR "	%0 - .			\n\t"
+		"	.popsection				\n\t"
+		:  :  "i"(&((char *)key)[branch]) :  : label);
+
+	return false;
+label:
+	return true;
+}
+
+#endif  /* __ASSEMBLY__ */
+#endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index b355cf485671..a5287ab9f7f2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -53,4 +53,6 @@ endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
+
 clean:
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
new file mode 100644
index 000000000000..1bab1abc1aa5
--- /dev/null
+++ b/arch/riscv/kernel/jump_label.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Emil Renner Berthing
+ *
+ * Based on arch/arm64/kernel/jump_label.c
+ */
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+#include <asm/bug.h>
+#include <asm/patch.h>
+
+#define RISCV_INSN_NOP 0x00000013U
+#define RISCV_INSN_JAL 0x0000006fU
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	void *addr = (void *)jump_entry_code(entry);
+	u32 insn;
+
+	if (type == JUMP_LABEL_JMP) {
+		long offset = jump_entry_target(entry) - jump_entry_code(entry);
+
+		if (WARN_ON(offset & 1 || offset < -524288 || offset >= 524288))
+			return;
+
+		insn = RISCV_INSN_JAL |
+			(((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
+			(((u32)offset & GENMASK(11, 11)) << (20 - 11)) |
+			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
+			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
+	} else {
+		insn = RISCV_INSN_NOP;
+	}
+
+	patch_text_nosync(addr, &insn, sizeof(insn));
+}
+
+void arch_jump_label_transform_static(struct jump_entry *entry,
+				      enum jump_label_type type)
+{
+	/*
+	 * We use the same instructions in the arch_static_branch and
+	 * arch_static_branch_jump inline functions, so there's no
+	 * need to patch them up here.
+	 * The core will call arch_jump_label_transform  when those
+	 * instructions need to be replaced.
+	 */
+}
-- 
2.27.0

