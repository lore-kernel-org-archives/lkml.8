Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E36C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2C207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgBQRws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:52:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgBQRws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:52:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3kZW-0003nw-Ux; Mon, 17 Feb 2020 18:52:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3D4D31C20B2;
        Mon, 17 Feb 2020 18:52:42 +0100 (CET)
Date:   Mon, 17 Feb 2020 17:52:41 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/syscalls: Add prototypes for C syscall callbacks
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200123152754.20149-1-b.thiel@posteo.de>
References: <20200123152754.20149-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158196196194.13786.17938311473984803785.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     99ce3255fddf08fca9249488793c9b5c909ff0ab
Gitweb:        https://git.kernel.org/tip/99ce3255fddf08fca9249488793c9b5c909ff0ab
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Thu, 23 Jan 2020 16:27:54 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 17 Feb 2020 18:22:25 +01:00

x86/syscalls: Add prototypes for C syscall callbacks

.. in order to fix a couple of -Wmissing-prototypes warnings.

No functional change.

 [ bp: Massage commit message and drop newlines. ]

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200123152754.20149-1-b.thiel@posteo.de
---
 arch/x86/entry/common.c        | 1 +
 arch/x86/include/asm/syscall.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9747876..ec167d8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -34,6 +34,7 @@
 #include <asm/fpu/api.h>
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
+#include <asm/syscall.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 8db3fdb..d20ffc5 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -168,6 +168,11 @@ static inline int syscall_get_arch(struct task_struct *task)
 		task->thread_info.status & TS_COMPAT)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
+
+void do_syscall_64(unsigned long nr, struct pt_regs *regs);
+void do_int80_syscall_32(struct pt_regs *regs);
+long do_fast_syscall_32(struct pt_regs *regs);
+
 #endif	/* CONFIG_X86_32 */
 
 #endif	/* _ASM_X86_SYSCALL_H */
