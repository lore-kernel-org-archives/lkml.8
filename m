Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F512166E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzCIdKya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgFQJHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:07:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:07:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z63so816934pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnLnijT3kAKagUkRCUY6dPCloOW3fhO0MSYNzvoS/58=;
        b=dzCIdKya9MvwLcA8MAjN9GvG7PIaY0dbuxpTthmyWJyrErNkbrpxgQLsCixAt+0hb/
         gFk0MgUwcFDM5dKQFwBRfGi7rVbA4LLSNUrkPx0RF/EkXrORi4Jz0aR+59d26fJyP0Y3
         SpszT+FqP/z0qZs88HreytHRbz9KWlfJBhKySXZKiMAOWP01mbzpRwKjDJhNqL8bwKke
         WItWkXTyOjqHTPkIz3o7KbJ9RcZr7mXpcq25jEysd+FG5qQAiuIIF2MRjPNtB3tA+Fpr
         P8TQ1Rgsx3Z7eBsneK8g3GqwLRi+GsObq4hXixrn95PLbabyepjJrBtBGiJsXV/l+IMY
         dXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnLnijT3kAKagUkRCUY6dPCloOW3fhO0MSYNzvoS/58=;
        b=OjTes/HGLQKECMuFpV9YA6d0aTSb2YaNdSCrVafppWYWLcj4yy2BSHfPMNiGfbTvIn
         D5yJyhWzfqmGkfCYBtQqKO8W81W1e42BEeTZE1IVybEqu7+moxXO2NiWNqUFXNNkT2MD
         GiynYjP5mjVpdKKHEjoClpNMCr8vRFRRXgFqipHeqAcBp8t1oQOsrKTRjWNeVoFc9gJu
         NyoebB3e2pT4Jq4xIG4NioHgYWe2x1Z7ccB5FYxINmhTgkAobVsr4tCjoazfMuDHRYvf
         +qVGA8QR9+958moBrCTj6czjfoKZiZG792rT+y11RdCT8N5RM4vx06Ss+zeeSjf1iR+c
         WPUA==
X-Gm-Message-State: AOAM531u2ikuYqXG8ysAV4lgr7ls3IFZyTCgRHkvwUbvTCTG302qrCQN
        w5s+iLb3aH1+7BjcXLe78ZYT/MWUb38=
X-Google-Smtp-Source: ABdhPJwDb3WnWhllQKssed+/Sv/xzTVMmYrYBlGYX345oLJ8rS5GEETlkUkL+/3H6ZtKq6VXqBoqKQ==
X-Received: by 2002:a63:9e02:: with SMTP id s2mr5468301pgd.170.1592384838074;
        Wed, 17 Jun 2020 02:07:18 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id j5sm10340697pgi.42.2020.06.17.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:07:17 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Fix oops caused when dumping stack
Date:   Wed, 17 Jun 2020 18:07:01 +0900
Message-Id: <20200617090702.1684812-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping a stack siwth 'cat /proc/1/stack' the kernel would oops.
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

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/stacktrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/stacktrace.c b/arch/openrisc/kernel/stacktrace.c
index 43f140a28bc7..ac91614509c8 100644
--- a/arch/openrisc/kernel/stacktrace.c
+++ b/arch/openrisc/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 
 #include <asm/processor.h>
@@ -68,12 +69,17 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	unsigned long *sp = NULL;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	if (tsk == current)
 		sp = (unsigned long *) &sp;
 	else
-		sp = (unsigned long *) KSTK_ESP(tsk);
+		sp = (unsigned long *) task_thread_info(tsk)->ksp;
 
 	unwind_stack(trace, sp, save_stack_address_nosched);
+
+	put_task_stack(tsk);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
-- 
2.26.2

