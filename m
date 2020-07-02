Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB50C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9E2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwA+SCdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGBUHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:07:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE02C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:07:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so28749696wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwcOL44/6/46bE3/0vVlUgkMmYErY370J4sDOgg59nk=;
        b=UwA+SCdqUguWwxxLckgnzNztsdeZeLfjkurpCiyiRk1X1kD6IHn76V5vHvpE5o48Yc
         AkNrUoJ7i9npVnssaVzLY7P3EER6cUYBDho+siALS7Wg+S/qb0c9VtDSvOSgqCk7vu5n
         96VNdLAcbAzoWZqDZl6O5Bu4ZN5FFZQeeYvJ+xUV4o+NPM6OBsJW6OghiLq47/4z4bIG
         rlopFHv4JOHS1zP4dWGApHMoIkuWMH52wKT7zKNWZVs5tqJs2FeN7H/HnsdZdbQSgijY
         FkUgGl0I2pge5Dj4oz9Ok3WgUPMOxWzWVk8XHemO5iV13ZxmQI6RffLSfogdTf0IIYT1
         GrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dwcOL44/6/46bE3/0vVlUgkMmYErY370J4sDOgg59nk=;
        b=bc0rh1OT4Iec43uyXgcIiTODMD7D/o2c7hwFXFE68vCs/ATzBNUx5lKCP53X6n6msx
         qu3zcI9ga1bD74H4kz+MNOUMlD1TNIhgGYnpPVi3x7reQH8+b7i/x5IJfT8VvLP5+FJJ
         rhZEeT3yoP8a3LVBTPiCAFXlsJ9jRY+RchvC86buxjB/7tWW+I6F4o/Cnyouq+CTiCYd
         0HZ2hu10IB34xWuh8J6m+vrpkzIP/nGt1qzVJDWcb80YkQ+breAKm4v7QZnc3cc/wyZJ
         Z5wCjOgC2sfpkmoBq8iUs3B9u/ppa8LEr4jZxOTUu5RqNf2CgdDqiOSOik5ZpGVd/ZTK
         kf4A==
X-Gm-Message-State: AOAM5317B0YRHgWdFZsns3tk3qs0yQlbChD9A/pts33scTkYJmzmJMco
        4BrLwEvkjNTwUjdbXO3sRzYMXEg4V+I=
X-Google-Smtp-Source: ABdhPJzFARY6FE78ZvF/8RPjaMM8SxlV/4oa1w6Phs+euFFJvB8dZKlxPA66UHi/PKGIWpD0qKf35A==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr33537422wme.69.1593720460773;
        Thu, 02 Jul 2020 13:07:40 -0700 (PDT)
Received: from localhost.localdomain ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t15sm11699463wmj.14.2020.07.02.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:07:40 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [RFC] riscv: Add jump-label implementation
Date:   Thu,  2 Jul 2020 22:07:27 +0200
Message-Id: <20200702200727.239348-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic jump-label implementation heavily based
on the ARM64 version.

Tested on the HiFive Unleashed.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---

This seems to work on my HiFive Unleashed. At least boots, runs fine
and the static key self-tests doesn't complain, but I'm sure I've missed
something, so I'm sending this as an RFC.

/Emil

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
index 000000000000..29be6d351866
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
+		"	.option push				\n\n"
+		"	.option norelax				\n\n"
+		"	.option norvc				\n\n"
+		"1:	nop					\n\t"
+		"	.option pop				\n\n"
+		"	.pushsection	__jump_table, \"aw\"	\n\t"
+		"	.align		3			\n\t"
+		"	.long		1b - ., %l[l_yes] - .	\n\t"
+		"	.quad		%0 - .			\n\t"
+		"	.popsection				\n\t"
+		:  :  "i"(&((char *)key)[branch ? 1 : 0]) :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
+{
+	asm_volatile_goto(
+		"	.option push				\n\n"
+		"	.option norelax				\n\n"
+		"	.option norvc				\n\n"
+		"1:	jal		zero, %l[l_yes]		\n\t"
+		"	.option pop				\n\n"
+		"	.pushsection	__jump_table, \"aw\"	\n\t"
+		"	.align		3			\n\t"
+		"	.long		1b - ., %l[l_yes] - .	\n\t"
+		"	.quad		%0 - .			\n\t"
+		"	.popsection				\n\t"
+		:  :  "i"(&((char *)key)[branch ? 1 : 0]) :  : l_yes);
+
+	return false;
+l_yes:
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

