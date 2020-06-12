Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B618C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602F620801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lzm/7SHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgFLHK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgFLHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703DAC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so3383051plv.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A2QaBTJhBJQRzylOX9vPhPzTgEPwvSh2CxTZj+1fI78=;
        b=lzm/7SHi4Y2LnyTA2A6iUc8tChivg1S6hfjql+7CInfU7VGpxRokFhUHYMnD8+Wi91
         ctpVZi3Rn9n6ZrzfRbrfTLRxG1DorH3KDQrEWyhdGpOZpg414iGAyH8q+vT64LqlgLwY
         aRBMLWzD2ce9ZQJ5LbdubChokm0OqeOeklDcc10mRMUO/SVoR1PT5nI58TZm8JRTOPdK
         qtwfn78qSOYNsOC8XPIX08/SLIY03WtsZfThrWRmErGEFoBydRpxcNK8y9/HlTABJspM
         V0OIZiy+xSK37sJlqwy4MLNvhX09bUHvwuoZKk76m7a/+Tyu2Xm0IJ+HHWqH1iZRudDU
         IlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2QaBTJhBJQRzylOX9vPhPzTgEPwvSh2CxTZj+1fI78=;
        b=OBVD9ZNuXl0CKwskW01aC9RsPAmsiJJXXvGTd6hqUWm8Rsn2y7x7uH6WHy2alfe+wN
         M6AUR4Rvgoy/7Xj4mQinMeyIw6sYnVP53dXvfi+75k1azGhFC9DkSMYU9aYT1zakQOWQ
         F1n8SB+uTHwCoIdi1X35M+Q9A0VW+NURz4q8cwit4UPG7cSZhG2SkTjiLJ5rdIG25FOe
         pBZE23XNlKdLwGFXuk5fHMQNf5bT+z8iH1PdCok+H1V8t7m6GHOOXKXmqFJO0z+OfaQ6
         gEav5zihYFrQ9zDJMuhDf5hG3UXv8G2fbAvb/YMvZ+Oz6eZWM/ceqCgTZTMSPBtla8XH
         D09g==
X-Gm-Message-State: AOAM530MUC5vQgS4QU9P0Bz9SlVZrGT6gvYXdJL0Zt28cW/NuqpStvhD
        Bs/747cQT+MZ1TijZvuFWG9hYHdnQHyyoQ==
X-Google-Smtp-Source: ABdhPJyoKYtGQArQjTuuVyk6DTQSNswCQAgwB0evJSXQ5wo1oNwLXoJhzMrYI9PQQTF4Yt6WX7vQ+A==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr10294966pln.300.1591945834535;
        Fri, 12 Jun 2020 00:10:34 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:34 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] riscv: Add ptrace vector support
Date:   Fri, 12 Jun 2020 15:10:00 +0800
Message-Id: <32bf683f9e25b3dd291edd77cc9a75c7bac07e88.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
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
 arch/riscv/include/uapi/asm/elf.h |   1 +
 arch/riscv/kernel/ptrace.c        | 114 ++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h          |   1 +
 3 files changed, 116 insertions(+)

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
index 444dc7b0fd78..b5b83260e674 100644
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
@@ -92,6 +96,106 @@ static int riscv_fpr_set(struct task_struct *target,
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
+	count -= sizeof(vstate->__padding);
+	ubuf += sizeof(vstate->__padding);
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
@@ -111,6 +215,16 @@ static const struct user_regset riscv_user_regset[] = {
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
2.27.0

