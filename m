Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAFD20674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs27DYnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGGPIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:08:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16ABC061755;
        Tue,  7 Jul 2020 08:08:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so46895851wmh.2;
        Tue, 07 Jul 2020 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6BV5c7GorEWs2/docPZWbdVobbwC05M0F5l2kuEJhY=;
        b=Vs27DYnDqO9a35ks/Wv6aMUwNy9xFVR8p18Nvb7vO6wX95Cy6fsmB1rU4/1thR7zXC
         e1/Mk6cHvVpABEaIsNGCtJuNcqImVGH8zhbyvS5TXQC30do5WjxGwukaU2FUIBiWop8v
         aUlcJI8pLbUcegVSVlyjI7mYOQQJvCAzgdCC2dTl9wS81Yl9xJ8/jHeOmoogUbXvBKYP
         ticsQy4rYuD70mX6zhpiMXMebPdLKJTMIS8J/XTm5XxC1iUN43wRYMMEPHuEcHCQBzGB
         Mi5+IebW5qB7hcXMecyoBv110X4VRHxaSwhr0LvdJ0uF7vxJE4OKaV9ZzBfJbW0EIb7F
         RFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=M6BV5c7GorEWs2/docPZWbdVobbwC05M0F5l2kuEJhY=;
        b=YZEWsnehExMDFaZ5lLIFxy68I72lemt+udldx8AHnJZCEhOuR15+7j3s4OwXZxP13E
         vfR4WteXTOu6ABEAgrWXRoUcDYRSDOcsXPsKuiknn3zkK3lPGUt5Sk46HN6FHWWcfuz+
         cuSz5HxxrWXxHhwiFyOMVmJr2tw1UmBFYE82AD6gPauTXLuxkd3Vtb1iN2Id0sy/9Il4
         tph/6in9luLD/lZPneEN+HOGtmo585yF3a1RPQM9G3fFB0+rtNNBOA6loDi3gkpQwLgy
         POmY5L88TwmaXQ31pN7qrYh/qV0j4NRUi6KgnB1kJhlL4m+HXyFA7ihq0vtTg1G3PAs8
         4VMA==
X-Gm-Message-State: AOAM533/TzEYD4sZywCZJ/752KDc0zzSabr6x3sIwdLIBGEKxsmytY3b
        P+NUWEpdeVAj5fy6t2buXhqEkBRUultz8w==
X-Google-Smtp-Source: ABdhPJw3uu5XW1AIN9bCVkNNsTt1jsZSNk03Bs513KYmzIrWkZcCF6ZvU9vC+U9q2Co1plIOC3JXNA==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr4637763wmd.59.1594134480351;
        Tue, 07 Jul 2020 08:08:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4262:1ab:c:984b:540d:db53:2adb])
        by smtp.gmail.com with ESMTPSA id d13sm1452605wrn.61.2020.07.07.08.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:07:59 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: Add jump-label implementation
Date:   Tue,  7 Jul 2020 17:07:48 +0200
Message-Id: <20200707150748.14651-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jump-label implementation based on the ARM64 version.

Tested on the HiFive Unleashed board.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---

Changes since RFC:
- Use RISCV_PTR and RISCV_LGPTR macros to match struct jump_table
  also in 32bit kernels.
- Remove unneeded branch ? 1 : 0, thanks Björn
- Fix \n\n instead of \n\t mistake

 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/riscv/Kconfig                            |  2 +
 arch/riscv/include/asm/jump_label.h           | 59 +++++++++++++++++++
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/jump_label.c                | 44 ++++++++++++++
 5 files changed, 108 insertions(+), 1 deletion(-)
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
index 000000000000..55b2d742efe1
--- /dev/null
+++ b/arch/riscv/kernel/jump_label.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Emil Renner Berthing
+ *
+ * Based on arch/arm64/kernel/jump_label.c
+ */
+#include <linux/kernel.h>
+#include <linux/jump_label.h>
+#include <asm/patch.h>
+
+#define RISCV_INSN_NOP 0x00000013
+#define RISCV_INSN_JAL 0x0000006f
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	void *addr = (void *)jump_entry_code(entry);
+	u32 insn;
+
+	if (type == JUMP_LABEL_JMP) {
+		u32 offset = jump_entry_target(entry) - jump_entry_code(entry);
+
+		insn = RISCV_INSN_JAL |
+			((offset & GENMASK(19, 12)) << (12 - 12)) |
+			((offset & GENMASK(11, 11)) << (20 - 11)) |
+			((offset & GENMASK(10,  1)) << (21 -  1)) |
+			((offset & GENMASK(20, 20)) << (31 - 20));
+	} else
+		insn = RISCV_INSN_NOP;
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

