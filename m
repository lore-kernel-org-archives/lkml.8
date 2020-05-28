Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B920E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Al5I3K4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE1Glh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgE1Glf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF77C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so9951632pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E2tys82ZNZaPVJ+j676dyC3tB/POLAbHy0kxmjdDY1g=;
        b=Al5I3K4fYTAcO8syoj4RXIGfKW2MAtDPA6PXV7wexX+9hCiybB12rgtEzh6EW+42EQ
         vNB4RTob4YGEDGsP+eg4hni+rqcntgDG3Pwz2TyvfcOCbZAIltqjCtRSWiSOWm1QjReA
         8GxBCceHH3aMaymyEjblfDxpmicUxE1wDcbulgjNnzY8iCtzV5xg2+7SGu9Tyc/32lA7
         ok+AfPLvC0MIygL1AbELH5VfrLBHB+92jsjrX1goL0miu3iXckn9PAtILA1kLP4bXPgC
         A9BafR0BfT14fQyjFiPuLfBG/UE4HybdT7U+YbjI8Htg/PqJQS/QPrCoep9xQCmcQvuU
         wJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2tys82ZNZaPVJ+j676dyC3tB/POLAbHy0kxmjdDY1g=;
        b=EZFwWdrJ9p5z6l7cSxCRUfwGZwZBWCGIFy3psGTOMAUhptiZKqTQwjNtnXiIC5QPuf
         CDDU/CSiV9Z9henwQjnIMY9j5t/CXGlHtX8KJXjPaLc7PrSUU8qcwBKl7x9SNJ9JrLLp
         UHghS5vxgAeog3SiahCOWpyGxtdm/I16x09IvylQw7CZOBFZYyN3O1sLY/I2vdwFggTE
         A1FzVUwMFzAKJchj6VmB7cOvaKViwAI5b+WVbghs55TX7o54lcTwg3snsF9eTaAqgtZx
         QAFYYK23GJe7lW4clbSFyQS2CZDi97WA/wboY3tv84Mh2xmiaBaid/z6neMmyzDAxsY8
         YQWg==
X-Gm-Message-State: AOAM532G7D93Ro4LRLno3D4SwxraagUseUgfrcF3QtU3wtWBe1AIkJ5Y
        M/k0DB/oGkVihrOlYB19ZykRMA==
X-Google-Smtp-Source: ABdhPJziuAGvE98veT2Y4Z3+oUEKtpOxW505htOMNu82rRs4sDMp5hnavM8SRa3ADP7eyljn9k5FHg==
X-Received: by 2002:aa7:9494:: with SMTP id z20mr1572928pfk.314.1590648090700;
        Wed, 27 May 2020 23:41:30 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:30 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 11/13] riscv: Add ptrace vector support
Date:   Thu, 28 May 2020 14:40:59 +0800
Message-Id: <30cc61919c7b6ae3d65970c99a1e2e76cb045eaf.1590646208.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590646208.git.greentime.hu@sifive.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds ptrace support for riscv vector. The vector registers will
be saved in datap pointer of __riscv_v_state. This pointer will be set
right after the __riscv_v_state data structure then it will be put in ubuf
for ptrace system call to get or set. It will check if the datap got from
ubuf is set to the correct address or not when the ptrace system call is
trying to set the vector registers.

[greentime.hu@sifive.com: add support for dynamic vlen, fix vtype not
saved bug]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/uapi/asm/elf.h |   1 +
 arch/riscv/kernel/ptrace.c        | 115 ++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h          |   1 +
 3 files changed, 117 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..099434d075a7 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -23,6 +23,7 @@ typedef struct user_regs_struct elf_gregset_t;
 typedef __u64 elf_fpreg_t;
 typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
+#define ELF_NVREG  (sizeof(struct __riscv_v_state) / sizeof(elf_greg_t))
 
 #if __riscv_xlen == 64
 #define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 444dc7b0fd78..ff846a53cd8d 100644
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
@@ -92,6 +96,107 @@ static int riscv_fpr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_VECTOR
+static int riscv_vr_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 void *kbuf, void __user *ubuf)
+{
+	int ret;
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+	/* Set the datap right after the address of vstate. */
+	void *datap = ubuf + sizeof(struct __riscv_v_state);
+	u32 magic = RVV_MAGIC;
+
+	/* Copy the magic number. */
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &magic, 0,
+				  sizeof(u32));
+	if (unlikely(ret))
+		return ret;
+
+	/* Copy rest of vstate except datap. */
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, vstate, 0,
+				  RISCV_V_STATE_DATAP);
+	if (unlikely(ret))
+		return ret;
+
+	/* Copy the pointer datap itself. */
+	pos = 0;
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &datap, 0,
+				  sizeof(vstate->datap));
+	if (unlikely(ret))
+		return ret;
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
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  vstate->datap, 0, vstate->size);
+	return ret;
+}
+
+static int riscv_vr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int ret, size;
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+	const void *datap = ubuf + sizeof(struct __riscv_v_state);
+	const void *datap_addr = ubuf + RISCV_V_STATE_DATAP;
+	long val_datap;
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
+	/* Check if the datap is correct address of ubuf. */
+	__get_user(val_datap, (long *)datap_addr);
+	if (val_datap != (long)datap)
+		return -EFAULT;
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
+static unsigned int riscv_vr_get_size(struct task_struct *target,
+				      const struct user_regset *regset)
+{
+	if (!has_vector)
+		return 0;
+
+	return sizeof(struct __riscv_v_state) + riscv_vsize;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -111,6 +216,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = &riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_VECTOR
+	[REGSET_V] = {
+		.core_note_type = NT_RISCV_VECTOR,
+		.align = 16,
+		.size = sizeof(unsigned long),
+		.get = riscv_vr_get,
+		.set = riscv_vr_set,
+		.get_size = riscv_vr_get_size,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4290fe..e428f9e8710a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -428,6 +428,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_VECTOR	0x900		/* RISC-V vector registers */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
-- 
2.26.2

