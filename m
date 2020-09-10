Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D734C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2458220708
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AarNnDFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgIJIWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgIJINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D65C06179A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so2666984pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tmVmQi4QczzbK2b3xdY3rz6WWhSlEhI5RcevTuWtQ58=;
        b=AarNnDFOxNAlUIh0nHQvfBbeWAZNOrG7tjykLy0n25WFy2xVwm3LqnVIrayGXI1kCW
         yPjAcUqXSIEI0JX2OfN1AN4MUvYzLMFP2h68SoCybPpeLokYnXJ9GZ49GrU2ZiYa9Gv9
         s6zO3jwxF5ZgN+QmxfNLlEekdekFW0I/eZ4nXABF897qHg3WRtBAH/p2NP2Vu6s/YCHo
         W+NrwDTidOHsMP1+ryE/SwQktx1hzM/+rWs94acYkX2GPq76IdPTfVF0CQqEfuKuZRIm
         Nhzp6Rrxf19fIAvj8h/b//TKa3ojgKHUfH5t7Lhqo0p5gi3fTHWNt1/8JmYxxWtxXbqk
         5BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tmVmQi4QczzbK2b3xdY3rz6WWhSlEhI5RcevTuWtQ58=;
        b=WBHikrYnJO+pa/ukXCVH+PDalE/BhSKHZvDPC9OlAwxp074aENkVyIWtw3Bu/vVJO7
         6QyOZm5tD+4kYyJh41PcBFW9G5g8/JeOuRIcnOlWhwJFhDBlWiFVlp/nOei/LqiMMFbs
         M6qB1JS1fjvQe0TofsTFERDDYru5aI2X8gU3AHI8WVxP1PIZRn4jeg1LLD4VkFRf6ivg
         4PiWLj+ee8Et0IiPjaJm3ErVWUXl836Nwc3TNaZ6/R2t1LYxbah5x9Jplp3nqkkgsJLq
         E17qZf2iFHD4/JeyHjVzDH8HzroZ2A23DTuBS27XljidEZuhdeZfayk1vqpmL5fs/Q6u
         2eWQ==
X-Gm-Message-State: AOAM530zk2BD0Oy1eYP6i78nrbyhXvKqHghW/Zf84MlN51GCmrOcOnyL
        FF5HitJyyC0o/1iy8rna2QXPQ5Gc+Xr04/Dj
X-Google-Smtp-Source: ABdhPJz96xoXAZuuQhPrIcu0NvS5AAv98ShenisDtQDUjy++Pd2NlOyV0OLUFAOacfUYGIghGJ4GdA==
X-Received: by 2002:a17:90a:8418:: with SMTP id j24mr4248231pjn.212.1599725583693;
        Thu, 10 Sep 2020 01:13:03 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:03 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Vincent Chen <vincent.chen@sifive.com>
Subject: [RFC PATCH v7 13/21] riscv: signal: Report signal frame size to userspace via auxv
Date:   Thu, 10 Sep 2020 16:12:08 +0800
Message-Id: <1cee6bbffc9434d0a30cf0f47fa2c23e0dacaaeb.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

The vector register belongs to the signal context. They need to be stored
and restored as entering and leaving the signal handler. According to the
V-extension specification, the maximum length of the vector registers can
be 2^(XLEN-1). Hence, if userspace refers to the MINSIGSTKSZ #define
(2KB) to create a sigframe, it may not be enough. To resolve this problem,
this patch refers to the commit 94b07c1f8c39c
("arm64: signal: Report signal frame size to userspace via auxv") to enable
userspace to know the minimum required sigframe size through the auxiliary
vector and use it to allocate enough memory for signal context.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/elf.h         | 17 +++++++++++++----
 arch/riscv/include/asm/processor.h   |  2 ++
 arch/riscv/include/uapi/asm/auxvec.h |  2 ++
 arch/riscv/kernel/setup.c            |  5 +++++
 arch/riscv/kernel/signal.c           | 16 ++++++++++++++++
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index d83a4efd052b..b6b15fc5f784 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -57,10 +57,19 @@ extern unsigned long elf_hwcap;
 #define ELF_PLATFORM	(NULL)
 
 #ifdef CONFIG_MMU
-#define ARCH_DLINFO						\
-do {								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		(elf_addr_t)current->mm->context.vdso);		\
+#define ARCH_DLINFO						 \
+do {								 \
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				 \
+		(elf_addr_t)current->mm->context.vdso);		 \
+	/*							 \
+	 * Should always be nonzero unless there's a kernel bug. \
+	 * If we haven't determined a sensible value to give to	 \
+	 * userspace, omit the entry:				 \
+	 */							 \
+	if (likely(signal_minsigstksz))				 \
+		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz); \
+	else							 \
+		NEW_AUX_ENT(AT_IGNORE, 0);			 \
 } while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index a66a5d4ee5ad..bcf004435f26 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PROCESSOR_H
 
 #include <linux/const.h>
+#include <linux/cache.h>
 
 #include <vdso/processor.h>
 
@@ -72,6 +73,7 @@ int riscv_of_parent_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
+extern unsigned long signal_minsigstksz __ro_after_init;
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index d86cb17bbabe..9745a01e5e61 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -10,4 +10,6 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR 33
 
+#define AT_MINSIGSTKSZ 51
+
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c6dd329312b..f020fd627202 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
+#include <linux/processor.h>
 
 #include <asm/cpu_ops.h>
 #include <asm/setup.h>
@@ -60,6 +61,8 @@ void __init parse_dtb(void)
 #endif
 }
 
+extern void __init minsigstksz_setup(void);
+
 void __init setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _stext;
@@ -96,6 +99,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+
+	minsigstksz_setup();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index d27bd39a3490..b3f5375267cd 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -404,3 +404,19 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 		tracehook_notify_resume(regs);
 	}
 }
+
+unsigned long __ro_after_init signal_minsigstksz;
+
+/*
+ * Determine the stack space required for guaranteed signal devliery.
+ * This function is used to populate AT_MINSIGSTKSZ at process startup.
+ * cpufeatures setup is assumed to be complete.
+ */
+void __init minsigstksz_setup(void)
+{
+	signal_minsigstksz = sizeof(struct rt_sigframe);
+#ifdef CONFIG_VECTOR
+	if (has_vector)
+		signal_minsigstksz += riscv_vsize;
+#endif
+}
-- 
2.28.0

