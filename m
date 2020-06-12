Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15652C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE98207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YPopjf7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgFLHKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgFLHKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CCC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so3704719pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P9Pa9sX2hCWEpSvVJf+FpLMUkYZkkhyDVpp3YBSMMho=;
        b=YPopjf7BjgfR9P6MH2P5gmjjphEm5PftEMUk4KVtGergK6VXmdMIvx8AbuVSTla928
         Pyk7F+QztXyTZr2LFXm+lhPMTgPxHj/w5rLH2FkDJ6DCT3M4KfifnsIBHl98QJMk8kPL
         aaYxBV6sXMijkd2fNrlTv5/gyEYQZmKNnFi6m50G43UohbFWL+/TZHCNbmC4UNXrA8fC
         Vbk5pN6LQsWxIK0jxq/hpdlswusFQZyG8PXy4JKC0hTn9QbE+fX6s2MHpzfW48YtXKDy
         t/j4SQPEkhRrXsZnwHKxPmosWimYFMBJaOKDggmdjJPzFNZrLzdhPFfeM7EdkOwotr8i
         nE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9Pa9sX2hCWEpSvVJf+FpLMUkYZkkhyDVpp3YBSMMho=;
        b=tDL2gjqLgoVOPn7vqfhqfn5uaMBmRsT7rUKfvtyX14C19TwmhPuIkZhjxK5isZ3K3S
         8DkkRjcYO/d1JvWHb7er0Xz362Ymm8J21zoYqTegKH1kypMLryvKbcQ3/e8UHt0xu9O8
         nDShi1nKpi3VKD25GTTWX56AA5pPwnYwfCIkxd/a32lOGJGpKKqNMqkZYBaoOwhoklgs
         WEdAeSfe5ZYVRWn4YDETc/VydRvBd5Rkd8vsahpP8eWQ5eZCyWOte2iBm3IJ+jrg05ga
         h4m2X5toT5YDjNj+MoevcNIvIek3qGRt4ocL8hUKy37kEn1ij6UH9Mu7HVKmti4qGZx8
         W6/A==
X-Gm-Message-State: AOAM5326c/UnRzv41f7ACLy+6sShRpSWIBYQWf/lkoG4zR3PT6PVb1I7
        lf0oEgzQInAUJHBh3a3jmeRB5w==
X-Google-Smtp-Source: ABdhPJzsRw6oDxsMkoH09iu+rTk7MoFSiqjbxsoMOkY49g2MoPX+b/PCxGziRX2lD3N4N5swVaZc2w==
X-Received: by 2002:a63:235c:: with SMTP id u28mr9409667pgm.278.1591945836587;
        Fri, 12 Jun 2020 00:10:36 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:36 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] riscv: Add sigcontext save/restore for vector
Date:   Fri, 12 Jun 2020 15:10:01 +0800
Message-Id: <c407847d2b05d04c18b563430643fa7d8e7f9813.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sigcontext save/restore for vector. The vector registers
will be saved in datap pointer. The datap pointer will be allocaed
dynamically when the task needs in kernel space. The datap pointer will
be set right after the __riscv_v_state data structure to save all the
vector registers in the signal handler stack.

[guoren@linux.alibaba.com: add the first porting for vector signal and
sigcontext support]
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
2.27.0

