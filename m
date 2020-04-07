Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E6C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D04B2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P1AeqVor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgDGOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32944 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgDGOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay1so1347070plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7uXdqcuiavHxznT4lBdSfVCr+fRg7NRHIyZNAY7wD8=;
        b=P1AeqVorlKShJdhSjCpTu5VNpL+Za5BmA1B3JGSOcSzJ7IsnKO3GBuODRscgWd8G4+
         U72bLLhsvWgXXJ9Z1Ys3LQZ496OgU8thm3JeaaBzwwPjF/H3FQJkdS03gosEpC5ynCmL
         nY8/ZsqWzGMBTjzKMdq8js54lm2TGULQE7TTAQS8L5PfeMfte0gj0xFKVGk9ezdp9Fc7
         w9U63uhPj5rz3outYretqeP1s6X1T5TiNUFE37tqUZ095aTt0Y09G07DpmSKngy9k33Z
         qOUfgd9dMFrG2P/+48+pVd6EsnmDd0hNYKATwaX5XJVyR/fax2lE16ib2MIitH8AiofC
         e8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7uXdqcuiavHxznT4lBdSfVCr+fRg7NRHIyZNAY7wD8=;
        b=puG7dJXpIGq4S7wGfUpKIFQRLRNjaEZ5sAZ00xlHTXBcm6jojpmNTIWYHQ/ztET5AI
         6fILoEr0eRgE75uHY8tZOHE221aUQf4FKSv7cV0kgmocd69Qr05Ol4AgRwnACNcaq7rd
         NiySnE3k3NuCyzIu3OW5PaEqtsMWxR4frxD0XL97FPHh4R1NPC02Kn26DQTlBxmMaJaI
         6R0F3BzuiRmWJDxyv7vwpo057Ja6MEak/b0X3xaSdE0ZSLr83/XKZ0lVSrg/YWv+6dTw
         imQf3Vx7BNII+CTdT6TqjlmhZwcC41I5TAoIc2No9/r3XNRnHQps2oVg9Tybp1f924fv
         pvxw==
X-Gm-Message-State: AGi0Pub5+vqyXhhRy5csA+uXG7UoZHQ/JSetmBikIAh7F5wCzmOE0565
        4t4iEegWnSjsPaPrc0DZM7K15w==
X-Google-Smtp-Source: APiQypILA25M+qgwgYPvpmKFU28Lv6GclMDIO1ifCU+inCy8FTJZT6CORAEugRPYmfSQcdv9GSOt8w==
X-Received: by 2002:a17:90b:3714:: with SMTP id mg20mr3197336pjb.127.1586270822588;
        Tue, 07 Apr 2020 07:47:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:02 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 2/9] riscv: introduce interfaces to patch kernel code
Date:   Tue,  7 Apr 2020 22:46:47 +0800
Message-Id: <a491ce48973a0b4f0eed3fe4e97d6a07cb6d6ae8.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On strict kernel memory permission, we couldn't patch code without
writable permission. Preserve two holes in fixmap area, so we can map
the kernel code temporarily to fixmap area, then patch the instructions.

We need two pages here because we support the compressed instruction, so
the instruction might be align to 2 bytes. When patching the 32-bit
length instruction which is 2 bytes alignment, it will across two pages.

Introduce two interfaces to patch kernel code:
riscv_patch_text_nosync:
 - patch code without synchronization, it's caller's responsibility to
   synchronize all CPUs if needed.
riscv_patch_text:
 - patch code and always synchronize with stop_machine()

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/riscv/include/asm/fixmap.h |   2 +
 arch/riscv/include/asm/patch.h  |  12 ++++
 arch/riscv/kernel/Makefile      |   4 +-
 arch/riscv/kernel/patch.c       | 120 ++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/kernel/patch.c

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 42d2c42f3cc9..2368d49eb4ef 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -27,6 +27,8 @@ enum fixed_addresses {
 	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
 	FIX_PTE,
 	FIX_PMD,
+	FIX_TEXT_POKE1,
+	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
 };
diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
new file mode 100644
index 000000000000..9a7d7346001e
--- /dev/null
+++ b/arch/riscv/include/asm/patch.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#ifndef _ASM_RISCV_PATCH_H
+#define _ASM_RISCV_PATCH_H
+
+int patch_text_nosync(void *addr, const void *insns, size_t len);
+int patch_text(void *addr, u32 insn);
+
+#endif /* _ASM_RISCV_PATCH_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f40205cb9a22..d189bd3d8501 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -4,7 +4,8 @@
 #
 
 ifdef CONFIG_FTRACE
-CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_ftrace.o	= -pg
+CFLAGS_REMOVE_patch.o	= -pg
 endif
 
 extra-y += head.o
@@ -26,6 +27,7 @@ obj-y	+= traps.o
 obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
+obj-y	+= patch.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
new file mode 100644
index 000000000000..5b4f0d37097f
--- /dev/null
+++ b/arch/riscv/kernel/patch.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <linux/stop_machine.h>
+#include <asm/kprobes.h>
+#include <asm/cacheflush.h>
+#include <asm/fixmap.h>
+
+struct patch_insn_patch {
+	void *addr;
+	u32 insn;
+	atomic_t cpu_count;
+};
+
+#ifdef CONFIG_MMU
+static void *patch_map(void *addr, int fixmap)
+{
+	uintptr_t uintaddr = (uintptr_t) addr;
+	struct page *page;
+
+	if (core_kernel_text(uintaddr))
+		page = phys_to_page(__pa_symbol(addr));
+	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		page = vmalloc_to_page(addr);
+	else
+		return addr;
+
+	BUG_ON(!page);
+
+	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
+					 (uintaddr & ~PAGE_MASK));
+}
+NOKPROBE_SYMBOL(patch_map);
+
+static void patch_unmap(int fixmap)
+{
+	clear_fixmap(fixmap);
+}
+NOKPROBE_SYMBOL(patch_unmap);
+
+static int patch_insn_write(void *addr, const void *insn, size_t len)
+{
+	void *waddr = addr;
+	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
+	int ret;
+
+	if (across_pages)
+		patch_map(addr + len, FIX_TEXT_POKE1);
+
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = probe_kernel_write(waddr, insn, len);
+
+	patch_unmap(FIX_TEXT_POKE0);
+
+	if (across_pages)
+		patch_unmap(FIX_TEXT_POKE1);
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_insn_write);
+#else
+static int patch_insn_write(void *addr, const void *insn, size_t len)
+{
+	return probe_kernel_write(addr, insn, len);
+}
+NOKPROBE_SYMBOL(patch_insn_write);
+#endif /* CONFIG_MMU */
+
+int patch_text_nosync(void *addr, const void *insns, size_t len)
+{
+	u32 *tp = addr;
+	int ret;
+
+	ret = patch_insn_write(tp, insns, len);
+
+	if (!ret)
+		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_text_nosync);
+
+static int patch_text_cb(void *data)
+{
+	struct patch_insn_patch *patch = data;
+	int ret = 0;
+
+	if (atomic_inc_return(&patch->cpu_count) == 1) {
+		ret =
+		    patch_text_nosync(patch->addr, &patch->insn,
+					    GET_INSN_LENGTH(patch->insn));
+		atomic_inc(&patch->cpu_count);
+	} else {
+		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		smp_mb();
+	}
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_text_cb);
+
+int patch_text(void *addr, u32 insn)
+{
+	struct patch_insn_patch patch = {
+		.addr = addr,
+		.insn = insn,
+		.cpu_count = ATOMIC_INIT(0),
+	};
+
+	return stop_machine_cpuslocked(patch_text_cb,
+				       &patch, cpu_online_mask);
+}
+NOKPROBE_SYMBOL(patch_text);
-- 
2.26.0

