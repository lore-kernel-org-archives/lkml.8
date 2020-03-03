Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFAAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DAD2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VwJiMCnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgCCRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:21:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44911 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgCCRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:21:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id j23so3379999qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9+7wdl96+pcZ7KOZjzEhoq8+QQtDm+nRL0/PPEraqiQ=;
        b=VwJiMCnWis/rcKy+sK37kLKIyxblOfMElqg6DvJH9xeK/nZUNJu5E2EhW7KF1ErhGa
         JLNIlWs+bjd8XmyKfINU0iDzY2PDLC1M2Em69BpDIQiuJi8+2sqDOTv6duqzYhRToaZV
         CbARpxT3JgbZHmrkGvfXTVZJWz7TfPy9jPF3IzxsdOvofOBa0NQxnzhtw7WesPsqHORl
         DRsURMwm2c2BDLPJBdQiVW0W10J3+N/Zeh9iE41UZkVCQ+KJpOlX3ZpthLI7I4Tm/gY2
         mJufyKsfnGIB7Ld/QtJ6uXwOPGYABB8sptg6B9AwBudDFOsUd71GbJJV1gVI3qz7d0qO
         UwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9+7wdl96+pcZ7KOZjzEhoq8+QQtDm+nRL0/PPEraqiQ=;
        b=FnJPA0M9JiJwG3XsMDbxlPX9a2PWbDwgVoWc8vHN4U3/UcjwHKTlL2y1TwsnoR1HK+
         viD//XTSJvGJtoh02fpnXly4lt7yQzlSreB/HjNRzfG2seO0+seaIn9wKQeQcBjuogxI
         hnsNVA+bK+26+MWfF1PjO3ZfxfAYFplE6dKqOvkAdU/Obvb+d5mk40Egf7D32BpMVYov
         aey5NNySBX18IGW6bPAKgjwtl9PUaLJxll6uyhPmlSbXTo51kvWsQzJEfLD1bKbRUg2m
         imE5rZDHY93uSEYi+JN7gQdNt+WDbZAMCblc/8qn7XwfSsPoY3bIMW7fDPR/KteRflkg
         IgYA==
X-Gm-Message-State: ANhLgQ2JZYr0fsoRmV3zfQVtiQB72ArcuSwxGJmO+WxKX041k4lYn7Zp
        daX910od4c/f5Ct8mtDvMpqlHsL6J+s=
X-Google-Smtp-Source: ADFU+vsTKG3GlktHiGKjRL2YfaeKO87PdA2sn2nEz1WXCWIrHFmrD29IIuKNXuxLCpUtTqYeN1L8LA==
X-Received: by 2002:ac8:3893:: with SMTP id f19mr5376802qtc.46.1583256059513;
        Tue, 03 Mar 2020 09:20:59 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o127sm12532383qke.92.2020.03.03.09.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 09:20:58 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     oleg@redhat.com, catalin.marinas@arm.com, elver@google.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] signal: annotate data races in sys_rt_sigaction
Date:   Tue,  3 Mar 2020 12:20:49 -0500
Message-Id: <1583256049-15497-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak could scan task stacks while plain writes happens to those
stack variables which could results in data races. For example, in
sys_rt_sigaction and do_sigaction(), it could have plain writes in
a 32-byte size. Since the kmemleak does not care about the actual values
of a non-pointer and all do_sigaction() call sites only copy to stack
variables, annotate them as intentional data races using the
data_race() macro. The data races were reported by KCSAN,

 BUG: KCSAN: data-race in _copy_from_user / scan_block

 read to 0xffffb3074e61fe58 of 8 bytes by task 356 on cpu 19:
  scan_block+0x6e/0x1a0
  scan_block at mm/kmemleak.c:1251
  kmemleak_scan+0xbea/0xd20
  kmemleak_scan at mm/kmemleak.c:1482
  kmemleak_scan_thread+0xcc/0xfa
  kthread+0x1cd/0x1f0
  ret_from_fork+0x3a/0x50

 write to 0xffffb3074e61fe58 of 32 bytes by task 30208 on cpu 2:
  _copy_from_user+0xb2/0xe0
  copy_user_generic at arch/x86/include/asm/uaccess_64.h:37
  (inlined by) raw_copy_from_user at arch/x86/include/asm/uaccess_64.h:71
  (inlined by) _copy_from_user at lib/usercopy.c:15
  __x64_sys_rt_sigaction+0x83/0x140
  __do_sys_rt_sigaction at kernel/signal.c:4245
  (inlined by) __se_sys_rt_sigaction at kernel/signal.c:4233
  (inlined by) __x64_sys_rt_sigaction at kernel/signal.c:4233
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/signal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 5b2396350dd1..bf39078c8be1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3964,14 +3964,15 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 
 	spin_lock_irq(&p->sighand->siglock);
 	if (oact)
-		*oact = *k;
+		/* Kmemleak could scan the task stack. */
+		data_race(*oact = *k);
 
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
-		*k = *act;
+		data_race(*k = *act);
 		/*
 		 * POSIX 3.3.1.3:
 		 *  "Setting a signal action to SIG_IGN for a signal that is
@@ -4242,7 +4243,9 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 	if (sigsetsize != sizeof(sigset_t))
 		return -EINVAL;
 
-	if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
+	if (act &&
+	    /* Kmemleak could scan the task stack. */
+	    data_race(copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa))))
 		return -EFAULT;
 
 	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
-- 
1.8.3.1

