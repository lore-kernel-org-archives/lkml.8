Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C682C20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594561364;
	bh=YyUE0OgeiZ7J5J4saaGtSuMP8qRods8NoQGoTEHtQLE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=etIp20Ht+ApUrEBuaihwyNSdUoYiYCgvUuUShzDltSdKu9JXKVn5VMDn7668bm42D
	 eJnEjNrKkZWfBUgVGcmUjEp9lKvZI4z3hJkniZScwPLOb02BkWXOEiB1BRZj3D5MMt
	 u9Saya8kqv9sW2qW0OYnTkTWQcBRyREH6jxTDf2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgGLNmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgGLNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:42:42 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19863206D9;
        Sun, 12 Jul 2020 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594561362;
        bh=YyUE0OgeiZ7J5J4saaGtSuMP8qRods8NoQGoTEHtQLE=;
        h=From:To:Cc:Subject:Date:From;
        b=kPA3mDcvzWK5v+v/ghGmHhI0L8gAaoajPv/wGe+BISoCIra9xIyqHZkekkL+Ty2Zm
         1uzimxMYhsh0PrcIrJ2opbeNejrlKmQGLlzijCvelQ/2+2dd94EBUTAbRtXS00qxXp
         w8rX7wg1t7DHp43uicS+xMBAGvAnYcWADHQsMsb8=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: Cleanup unnecessary define in asm-offset.c
Date:   Sun, 12 Jul 2020 13:41:49 +0000
Message-Id: <1594561309-65026-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

 - TASK_THREAD_SP is duplicated define
 - TASK_STACK is no use at all
 - Don't worry about thread_info's offset in task_struct, have
   a look on comment in include/linux/sched.h:

struct task_struct {
	/*
	 * For reasons of header soup (see current_thread_info()), this
	 * must be the first element of task_struct.
	 */
	struct thread_info		thread_info;

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/asm-offsets.c | 3 ---
 arch/riscv/kernel/entry.S       | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 07cb9c1..db20344 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -27,9 +27,6 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
 	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
-	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
-	OFFSET(TASK_STACK, task_struct, stack);
-	OFFSET(TASK_TI, task_struct, thread_info);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index cae7e6d..3e8707e 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -389,12 +389,7 @@ ENTRY(__switch_to)
 	lw a4, TASK_TI_CPU(a1)
 	sw a3, TASK_TI_CPU(a1)
 	sw a4, TASK_TI_CPU(a0)
-#if TASK_TI != 0
-#error "TASK_TI != 0: tp will contain a 'struct thread_info', not a 'struct task_struct' so get_current() won't work."
-	addi tp, a1, TASK_TI
-#else
 	move tp, a1
-#endif
 	ret
 ENDPROC(__switch_to)
 
-- 
2.7.4

