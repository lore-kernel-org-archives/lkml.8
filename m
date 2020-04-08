Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E9C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A0F20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DUUM9esi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgDHH5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33389 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDHH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay1so2255575plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzfFvJg7bfdrO4wN3wqu7wI1vDUb7LOnXkYNhBz170c=;
        b=DUUM9esi5yDTXSCeZzowtJQEir93e17UxiKCRjrYo4mnv6nxqFylmAPtvD3smQejcm
         lJpb21k6+4md7Y8bwt5nrlCkyWISZ7kvJP8Dtg1E0ikmPiZkOFj+Z4Yjp0cIHCeuiePf
         +CrC+38+UO3/R2H/7o626s/xRNvv36sbC7++I8mt1Tb0GMqngN1tgAd97+UdUFC9jMfo
         X/n+qWxYwSR7rbY53FTcocyp9VjKWoMlFng8AL9MCieS8w7ASDULXLGOp4epJeWz/u5e
         IihrodIXip3NOHRh/k+cgJwRmtDESlr/uAxqOqmsmFl1OSVszWioEhBr03nrYtyEIjrj
         nERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzfFvJg7bfdrO4wN3wqu7wI1vDUb7LOnXkYNhBz170c=;
        b=h6MD5ikbjEcLQkyzG36N0n+HCgzrilP8XC1FTrRZQxrKS36hrtIyPF3FRMIDoF6UXU
         YKsvpS3+EQBrhbE7iEoogJKhWM25/MTpA+atI1ULjyUBBWNEUYbsOhw3nqwboI7YZcwb
         7i/80n6zE6XQQcmXDHBJ0yTAUcR2CCz4mQcNj+xL/1OJX5HoxNilt5Oa8wxx71XQ4Fsl
         +PV0gcK1+Zup5XeZ8lEH2DNdnR/kRIi4ezq7ozzguN9FzEiF93oVjCJFF9Af2w0GeLuE
         O6zhPHmJ4r4GUiJomKl92zAuULInYeiP/ok/d0Hs4rniUR+J8ejOGmGxpeks70W0H2V5
         067w==
X-Gm-Message-State: AGi0PubR8twu0xUd/uddNnOc1aBwZyh6MOkf7542xStT9jw6yAxGOODN
        GG/ZxJSD5ccrQJbxjeGdtkE+qQ==
X-Google-Smtp-Source: APiQypJqeiJZAEat09X84l9XFrf+GSwJJrpEFWwrSRBtjsWIdCdkVPTxNOW60AsyGwm+ha4ww8leAg==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr3826593pjr.22.1586332633065;
        Wed, 08 Apr 2020 00:57:13 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:12 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 2/9] riscv: introduce interfaces to patch kernel code
Date:   Wed,  8 Apr 2020 15:56:57 +0800
Message-Id: <6f145470ffdf83b303ecd83db4f6e06477b61220.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
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
 arch/riscv/include/asm/patch.h  |  12 +++
 arch/riscv/kernel/Makefile      |   4 +-
 arch/riscv/kernel/patch.c       | 128 ++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 1 deletion(-)
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
index 000000000000..f16466123947
--- /dev/null
+++ b/arch/riscv/kernel/patch.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#include <linux/mm.h>
+#include <linux/memory.h>
+#include <linux/uaccess.h>
+#include <linux/spinlock.h>
+#include <linux/stop_machine.h>
+#include <asm/fixmap.h>
+#include <asm/kprobes.h>
+#include <asm/cacheflush.h>
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
+	/*
+	 * Before reaching here, it was expected to lock the text_mutex
+	 * already, so we don't need to give another lock here and could
+	 * ensure that it was safe between each cores.
+	 */
+	lockdep_assert_held(&text_mutex);
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

