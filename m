Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA9E2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mvVjA5mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgEZHDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgEZHDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C414C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n15so9731903pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f85Vn4OuGxjQe/WprhGo5P1pwBgJ5q0VeEPd5gC4HYw=;
        b=mvVjA5mkqlSCRsV0hWJXQfgQW2EKXKVzl9KCXz0dVWjoM7MNkN/UwWJvoT68TiixQZ
         pOgMpdfKhcG3KKooS4e7Lb687eSsfVtruJJoZPgc/qPvWkaxccEEErkfNDgcnkVZruTd
         PVcyh5PyK24WUzGUCHEoe9BsnF7AJZjBZn/ktvYEAnuYlL+MqnJS8///agNGaX0M1MeJ
         jutdO/RjRfK3B0PM8C0K5glqPOpYqhOvsdh5YdPos9IAwYpXN9tGD3d5+bSRglTsLvpf
         +l1NBti/l6MTxRhJnUg/z/QuYmbzPsxgsWNLfqLI8T0GFy2VH1u4TieQkbkWXrnsrdeD
         hSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f85Vn4OuGxjQe/WprhGo5P1pwBgJ5q0VeEPd5gC4HYw=;
        b=fxLyHFoRpAzXwJfGmjfCiFcIGzdeYRbzstzgs5ZuEG/hkQqhgcthDFYBmIVSKWCebP
         fU4Iui2hUDvA+QLSxQqS1Jz0poejHaInpY5xCCgKNI9wmIHuj3V56ZGwZu+bdJeB90Vd
         m/E7+5ei6XJN5tLINwbUw9r5tindrJD+4WLIwEqkGUUuye6c5RrUe/A4Szsu7ERR4u76
         kBU2qHWeFVWiJPBX1uQCcBM0y7PjNfK2a4ZHsvojs5CpiTASvpyAFBfRkn7mly4Ff2fL
         1ye98jElh7KlXCe3XtAl/FRSLvQQlAbUQsdJRodi5utK82YunReB5My9UaZppB/ohCiM
         7j7w==
X-Gm-Message-State: AOAM531XMIAo0BhQPqzRtc5T58tFwJyYxUe9CJ/NOKRdKgIXuFtcm74q
        QtPeeCejITRJ/hPUJ3vR1AIxIA==
X-Google-Smtp-Source: ABdhPJyA8DWABjY15lGbo3kBA5t3k19gSIsjCy5JXETqptaEzgVZp8aO2jxq7pDI7+wl9J0+PPPIMw==
X-Received: by 2002:a62:9244:: with SMTP id o65mr14222963pfd.138.1590476594852;
        Tue, 26 May 2020 00:03:14 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:03:14 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 12/13] riscv: Add sigcontext save/restore for vector
Date:   Tue, 26 May 2020 15:02:41 +0800
Message-Id: <8dd3e441842d2b0fb63da82ecc04b08f99930e6a.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds sigcontext save/restore for vector. The vector registers
will be saved in datap pointer. The datap pointer will be allocaed
dynamically when the task needs in kernel space. The datap pointer will
be set right after the __riscv_v_state data structure to save all the
vector registers in the signal handler stack.

[greentime.hu@sifive.com: add support for dynamic vlen]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/uapi/asm/sigcontext.h |  2 +
 arch/riscv/kernel/signal.c               | 92 +++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index 84f2dfcfdbce..4217f3f1c8ba 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -8,6 +8,7 @@
 
 #include <asm/ptrace.h>
 
+#define RVV_MAGIC	0x53465457
 /*
  * Signal context structure
  *
@@ -17,6 +18,7 @@
 struct sigcontext {
 	struct user_regs_struct sc_regs;
 	union __riscv_fp_state sc_fpregs;
+	struct __riscv_v_state sc_vregs;
 };
 
 #endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 17ba190e84a5..9ada6f74bb95 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -83,6 +83,80 @@ static long save_fp_state(struct pt_regs *regs,
 #define restore_fp_state(task, regs) (0)
 #endif
 
+#ifdef CONFIG_VECTOR
+static long restore_v_state(struct pt_regs *regs, struct sigcontext *sc)
+{
+	long err;
+	struct __riscv_v_state __user *state = &sc->sc_vregs;
+	void *datap;
+	__u32 magic;
+
+	/* Get magic number and check it. */
+	err = __get_user(magic, &state->magic);
+	if (unlikely(err))
+		return err;
+
+	if (magic != RVV_MAGIC)
+		return -EINVAL;
+
+	/* Copy everything of __riscv_v_state except datap. */
+	err = __copy_from_user(&current->thread.vstate, state,
+			       RISCV_V_STATE_DATAP);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the pointer datap itself. */
+	err = __get_user(datap, &state->datap);
+	if (unlikely(err))
+		return err;
+
+
+	/* Copy the whole vector content from user space datap. */
+	err = __copy_from_user(current->thread.vstate.datap, datap,
+			       current->thread.vstate.size);
+	if (unlikely(err))
+		return err;
+
+	vstate_restore(current, regs);
+
+	return err;
+}
+
+static long save_v_state(struct pt_regs *regs, struct sigcontext *sc)
+{
+	long err;
+	struct __riscv_v_state __user *state = &sc->sc_vregs;
+	/* Set the datap right after the sigcntext structure. */
+	void *datap = sc + 1;
+
+	vstate_save(current, regs);
+	/* Copy everything of vstate but datap. */
+	err = __copy_to_user(state, &current->thread.vstate,
+			     RISCV_V_STATE_DATAP);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the magic number. */
+	err = __put_user(RVV_MAGIC, &state->magic);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the pointer datap itself. */
+	err = __put_user(datap, &state->datap);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the whole vector content to user space datap. */
+	err = __copy_to_user(datap, current->thread.vstate.datap,
+			     current->thread.vstate.size);
+
+	return err;
+}
+#else
+#define save_v_state(task, regs) (0)
+#define restore_v_state(task, regs) (0)
+#endif
+
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
 {
@@ -92,6 +166,9 @@ static long restore_sigcontext(struct pt_regs *regs,
 	/* Restore the floating-point state. */
 	if (has_fpu)
 		err |= restore_fp_state(regs, &sc->sc_fpregs);
+	/* Restore the vector state. */
+	if (has_vector)
+		err |= restore_v_state(regs, sc);
 	return err;
 }
 
@@ -101,13 +178,16 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	struct rt_sigframe __user *frame;
 	struct task_struct *task;
 	sigset_t set;
+	size_t frame_size = sizeof(*frame);
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
 	frame = (struct rt_sigframe __user *)regs->sp;
 
-	if (!access_ok(frame, sizeof(*frame)))
+	if (has_vector)
+		frame_size += current->thread.vstate.size;
+	if (!access_ok(frame, frame_size))
 		goto badframe;
 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
@@ -145,6 +225,9 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	/* Save the floating-point state. */
 	if (has_fpu)
 		err |= save_fp_state(regs, &sc->sc_fpregs);
+	/* Save the vector state. */
+	if (has_vector)
+		err |= save_v_state(regs, sc);
 	return err;
 }
 
@@ -176,9 +259,12 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe __user *frame;
 	long err = 0;
+	size_t frame_size = sizeof(*frame);
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame));
-	if (!access_ok(frame, sizeof(*frame)))
+	if (has_vector)
+		frame_size += current->thread.vstate.size;
+	frame = get_sigframe(ksig, regs, frame_size);
+	if (!access_ok(frame, frame_size))
 		return -EFAULT;
 
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-- 
2.26.2

