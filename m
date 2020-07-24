Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9AD20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccd6ytBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGXIiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXIiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:38:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DFC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:38:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so4071292plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0IULCq/Q+AE1YxUkLmIKHqXfNPlAYmp+Itiol6P2JY=;
        b=Ccd6ytBXOtKD5o+42jMgMbZ2gCvJ0abn1yDVFv6Ym+JbqwHJ30QuFcaqmqQuup0eUC
         DqiNTHAng20np18m4pmIC2uqci4mGZdxKeeDBu82p1PlG4Aac0UtHrnfaQhuigSrMKqn
         jOt13HE0JX5VSi3FMu9J2dzgjKh8aJJmRgmDerCca1AColglURL442y0YmXE8E3Em4m/
         u3xKvdBn+a5t5bw1t3yBMNJlT9Neo0MK+p0X5ptr/RN52/wOfSoLNkf55GuIVkdnGa5U
         gYzNq864o3/rpEw6/tve5FgIGYzMzXDxOLmX37adtAPVj3KQIft+UAeqNSKmO3ogoby2
         raBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0IULCq/Q+AE1YxUkLmIKHqXfNPlAYmp+Itiol6P2JY=;
        b=M19G5EzaaPkX9iPiC9LyqGJOJtgZ2cGkuJ3x/9r3ZSYnLSEueG0f7ScPUcpvyL2SPr
         q6Zjjr8TWe3e7KhQo5aO32NbIyyevNX3EF7WxzN9LfVp70lIUl11UYvxAyRQlwpNQEyN
         w2IZxzQaI35OIPh73LwuPjT+uo1a1QtQhVXzvs+TLmrb7djQz+hArfW8IY2vQZ9w42Ez
         +vTtacL9Y5vLJejp+/1laLMp3MQAR3JjarkBMdfgQDtqfBOEt277igheCCVTlISDfBCB
         wSeCLxyvLbdGS21ZBWE9H41LjddIQaS5dHiR6RblPFb3Qx06g98GDWoP2nEW0kUlIsiP
         LDXQ==
X-Gm-Message-State: AOAM5330t9mgXhJtucaytyRryYGgMiL4Qg3BWqLpXzX57FVdBGZOPRYp
        p2yNIW2V51pJaCZkxgC3lXHJDr53
X-Google-Smtp-Source: ABdhPJymSlWtgenETZB6v17Bf2UUDR0hi0PKjuxgRa2nAHSr8QUUZffT+uyvgS7xZGQeXydniUlJZA==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr7277568pls.244.1595579879502;
        Fri, 24 Jul 2020 01:37:59 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id e5sm4905956pjy.26.2020.07.24.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 01:37:58 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v2] openrisc: Fix oops caused when dumping stack
Date:   Fri, 24 Jul 2020 17:37:50 +0900
Message-Id: <20200724083751.580738-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping a stack with 'cat /proc/#/stack' the kernel would oops.
For example:

    # cat /proc/690/stack
    Unable to handle kernel access
     at virtual address 0x7fc60f58

    Oops#: 0000
    CPU #: 0
       PC: c00097fc    SR: 0000807f    SP: d6f09b9c
    GPR00: 00000000 GPR01: d6f09b9c GPR02: d6f09bb8 GPR03: d6f09bc4
    GPR04: 7fc60f5c GPR05: c00099b4 GPR06: 00000000 GPR07: d6f09ba3
    GPR08: ffffff00 GPR09: c0009804 GPR10: d6f08000 GPR11: 00000000
    GPR12: ffffe000 GPR13: dbb86000 GPR14: 00000001 GPR15: dbb86250
    GPR16: 7fc60f63 GPR17: 00000f5c GPR18: d6f09bc4 GPR19: 00000000
    GPR20: c00099b4 GPR21: ffffffc0 GPR22: 00000000 GPR23: 00000000
    GPR24: 00000001 GPR25: 000002c6 GPR26: d78b6850 GPR27: 00000001
    GPR28: 00000000 GPR29: dbb86000 GPR30: ffffffff GPR31: dbb862fc
      RES: 00000000 oGPR11: ffffffff
    Process cat (pid: 702, stackpage=d79d6000)

    Stack:
    Call trace:
    [<598977f2>] save_stack_trace_tsk+0x40/0x74
    [<95063f0e>] stack_trace_save_tsk+0x44/0x58
    [<b557bfdd>] proc_pid_stack+0xd0/0x13c
    [<a2df8eda>] proc_single_show+0x6c/0xf0
    [<e5a737b7>] seq_read+0x1b4/0x688
    [<2d6c7480>] do_iter_read+0x208/0x248
    [<2182a2fb>] vfs_readv+0x64/0x90

This was caused by the stack trace code in save_stack_trace_tsk using
the wrong stack pointer.  It was using the user stack pointer instead of
the kernel stack pointer.  Fix this by using the right stack.

Also for good measure we add try_get_task_stack/put_task_stack to ensure
the task is not lost while we are walking it's stack.

Fixes: eecac38b0423a ("openrisc: support framepointers and STACKTRACE_SUPPORT")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - V1 was not properly locating the stack, adjust for redzone and pt_regs.

 arch/openrisc/kernel/stacktrace.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/stacktrace.c b/arch/openrisc/kernel/stacktrace.c
index 43f140a28bc7..54d38809e22c 100644
--- a/arch/openrisc/kernel/stacktrace.c
+++ b/arch/openrisc/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 
 #include <asm/processor.h>
@@ -68,12 +69,25 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	unsigned long *sp = NULL;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	if (tsk == current)
 		sp = (unsigned long *) &sp;
-	else
-		sp = (unsigned long *) KSTK_ESP(tsk);
+	else {
+		unsigned long ksp;
+
+		/* Locate stack from kernel context */
+		ksp = task_thread_info(tsk)->ksp;
+		ksp += STACK_FRAME_OVERHEAD;	/* redzone */
+		ksp += sizeof(struct pt_regs);
+
+		sp = (unsigned long *) ksp;
+	}
 
 	unwind_stack(trace, sp, save_stack_address_nosched);
+
+	put_task_stack(tsk);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
-- 
2.26.2

