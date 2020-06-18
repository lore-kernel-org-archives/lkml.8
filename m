Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1218DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED505207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgFRNv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbgFRNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0DC0613EF;
        Thu, 18 Jun 2020 06:51:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwY-0002lb-4M; Thu, 18 Jun 2020 15:51:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA9721C0493;
        Thu, 18 Jun 2020 15:50:57 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:57 -0000
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/process/64: Use FSGSBASE instructions on
 thread copy and ptrace
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-9-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-9-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825763.16989.13638586965371863585.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     005f141e5d5e05d3986539567d0bc5aa2f4dc640
Gitweb:        https://git.kernel.org/tip/005f141e5d5e05d3986539567d0bc5aa2f4dc640
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 28 May 2020 16:13:53 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:02 +02:00

x86/process/64: Use FSGSBASE instructions on thread copy and ptrace

When FSGSBASE is enabled, copying threads and reading fsbase and gsbase
using ptrace must read the actual values.

When copying a thread, use save_fsgs() and copy the saved values.  For
ptrace, the bases must be read from memory regardless of the selector if
FSGSBASE is enabled.

[ tglx: Invoke __rdgsbase_inactive() with interrupts disabled ]
[ luto: Massage changelog ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1557309753-24073-9-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-8-sashal@kernel.org


---
 arch/x86/kernel/process.c    | 10 ++++++----
 arch/x86/kernel/process_64.c |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f362ce0..216c88d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -140,10 +140,12 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
+	current_save_fsgs();
+	p->thread.fsindex = current->thread.fsindex;
+	p->thread.fsbase = current->thread.fsbase;
+	p->thread.gsindex = current->thread.gsindex;
+	p->thread.gsbase = current->thread.gsbase;
+
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
 #else
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8ccc587..d618969 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -426,7 +426,8 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -440,7 +441,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
