Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732C1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1362820829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EoumDldE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgIJIWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgIJIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F872C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so2674289pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+FN/0yN24J6IiKxuS/0mgAvPddNbqvEn7AzBtkIlwI=;
        b=EoumDldEILlO7UO4CWF6SV6YO5nn0Afv+jwc8NvqD7N7k50F6/iM2SgRq7P1CmPoAA
         4jG0qOeRmGw01BGtNrmswFi1NO4/Ne4iagdaaSr7E6o3RI8vYOwEqHr3TkZyizcK5tsA
         itE53x7VlnCMFJBVBiYmNLt8zQYDLIBK6ctIpgcM8wT3svnhEylHbb05dX2fNHgjetd4
         MBgafa+8lDv6Mi9moNehH7jp5J/LUWUcuMWlB+4eMveb2YSNkcM0B48EHn/PAomGgv9o
         oSaWxH7/jP7lgdvzbKw5iARwT15ANbc4J8AsY9YOh+/BY3mqZjASqDo3PoVnKL1H1ztR
         VaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+FN/0yN24J6IiKxuS/0mgAvPddNbqvEn7AzBtkIlwI=;
        b=qnOtiOdgAlcGPMfcUkbDqLdIici/1w6ZQJF/zN+yvrBHVwN7CaCrxy+GZhPCWLq/9I
         dV7doPuyXNcKLyO11DNL3jlVV/+M4HT3NWqAU7KQ3J6Zd6X2NLOQGavtwRVMpsWPjwAL
         D/dg7T29sWMvB7R5vrUoVpGrOcIoozwYm2aUMJQlwfby3GMOSNd36BRTYg8enT7H4dNj
         ruqd1IAnQcoxpguLb09oHCIgboVXxZ1pRYniVfWgZJ5Iky+iif8Z5Jc84NqrCzcF1+h0
         fsnlUonXdRoWhy9zY0786HF/YC5PWv8P68Y3PvU3ZmV43JM7+ejdh1UFX1biEW4kCXep
         /Yrw==
X-Gm-Message-State: AOAM530H4mPZJlHStARh0M3VsQ1AEpCJ42UDFjSSEJ9+EXt/H6FUcbP3
        lNVIPpxHtVaHYp3Cuct2A7x6Kw==
X-Google-Smtp-Source: ABdhPJyV8GaV6rV+gDCwOe+yDmOEvVPHjvGvHMWOf/pGYV37+0kwz+yEXcz4D+jvl7YBvXo5kuy90A==
X-Received: by 2002:a17:90a:e697:: with SMTP id s23mr4203392pjy.175.1599725579802;
        Thu, 10 Sep 2020 01:12:59 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:59 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v7 11/21] riscv: Add ptrace vector support
Date:   Thu, 10 Sep 2020 16:12:06 +0800
Message-Id: <fe2a6ead3028f14b3b20c2340078e784bb8072c5.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ptrace support for riscv vector. The vector registers will
be saved in datap pointer of __riscv_v_state. This pointer will be set
right after the __riscv_v_state data structure then it will be put in ubuf
for ptrace system call to get or set. It will check if the datap got from
ubuf is set to the correct address or not when the ptrace system call is
trying to set the vector registers.

[guoren@linux.alibaba.com: Add the first version porting to support vector
of ptrace]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/uapi/asm/ptrace.h | 18 +++++++
 arch/riscv/kernel/ptrace.c           | 74 ++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 93 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 661b0466b850..42144fe6acee 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -80,16 +80,34 @@ union __riscv_fp_state {
 struct __riscv_v_state {
 	__u32 magic;
 	__u32 size;
+	/*
+	 * This is the size of vector registers not including
+	 * __riscv_v_state itself.
+	 */
 	unsigned long vstart;
 	unsigned long vl;
 	unsigned long vtype;
 	unsigned long vcsr;
 	void *datap;
+	/*
+	 * In signal handler, datap will be set a correct user stack offset
+	 * and vector registers will be copied to the address of datap
+	 * pointer.
+	 *
+	 * In ptrace syscall, datap will be set to zero and the vector
+	 * registers will be copied to the address right after this
+	 * structure.
+	 */
 #if __riscv_xlen == 32
 	__u32 __padding;
 #endif
 } __attribute__((aligned(16)));
 
+/*
+ * To define a practical maximum vlenb for ptrace and it may need to be
+ * extended someday.
+ */
+#define RISCV_MAX_VLENB (16384)
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2d6395f5ad54..c5f96b4e3df9 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -10,6 +10,7 @@
 #include <asm/ptrace.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
+#include <asm/switch_to.h>
 #include <linux/audit.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
@@ -26,6 +27,9 @@ enum riscv_regset {
 #ifdef CONFIG_FPU
 	REGSET_F,
 #endif
+#ifdef CONFIG_VECTOR
+	REGSET_V,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -81,6 +85,66 @@ static int riscv_fpr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_VECTOR
+static int riscv_vr_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+	__u32 magic = RVV_MAGIC;
+
+	/* Copy magic number */
+	membuf_store(&to, magic);
+	/* Copy vector header from vstate. */
+	membuf_write(&to, &(vstate->size), RISCV_V_STATE_DATAP - RISCV_V_STATE_SIZE);
+	membuf_zero(&to, sizeof(void *));
+#if __riscv_xlen == 32
+	membuf_zero(&to, sizeof(__u32));
+#endif
+	/* Copy all the vector registers from vstate. */
+	return membuf_write(&to, vstate->datap, vstate->size);
+}
+
+static int riscv_vr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int ret, size;
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+
+	/* Skip copy magic because kernel doesn't need to use it. */
+	size = sizeof(vstate->magic);
+	pos += size;
+	count -= size;
+	ubuf += size;
+
+	/* Copy rest of the vstate except datap and __padding. */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate, 0,
+				 RISCV_V_STATE_DATAP);
+	if (unlikely(ret))
+		return ret;
+
+	/* Skip copy datap. */
+	size = sizeof(vstate->datap);
+	count -= size;
+	ubuf += size;
+
+#if __riscv_xlen == 32
+	/* Skip copy _padding. */
+	size = sizeof(vstate->__padding);
+	count -= size;
+	ubuf += size;
+#endif
+
+	/* Copy all the vector registers. */
+	pos = 0;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate->datap,
+				 0, vstate->size);
+	return ret;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -100,6 +164,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_VECTOR
+	[REGSET_V] = {
+		.core_note_type = NT_RISCV_VECTOR,
+		.align = 16,
+		.n = (32 * RISCV_MAX_VLENB)/sizeof(__u32),
+		.size = sizeof(__u32),
+		.regset_get = riscv_vr_get,
+		.set = riscv_vr_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 22220945a5fd..66d02df08f46 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -430,6 +430,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_VECTOR	0x900		/* RISC-V vector registers */
 
 /* Note types with note name "GNU" */
 #define NT_GNU_PROPERTY_TYPE_0	5
-- 
2.28.0

