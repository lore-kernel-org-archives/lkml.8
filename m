Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8578F2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgFRNwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgFRNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2931C0613ED;
        Thu, 18 Jun 2020 06:51:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwW-0002la-4O; Thu, 18 Jun 2020 15:51:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1E1EC1C0087;
        Thu, 18 Jun 2020 15:50:58 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:57 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/process/64: Use FSBSBASE in switch_to() if available
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-8-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-8-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825791.16989.5523689077949902384.tip-bot2@tip-bot2>
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

Commit-ID:     673903495c85137791d5820d690229efe09c8f7b
Gitweb:        https://git.kernel.org/tip/673903495c85137791d5820d690229efe09c8f7b
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 28 May 2020 16:13:51 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:02 +02:00

x86/process/64: Use FSBSBASE in switch_to() if available

With the new FSGSBASE instructions, FS and GSABSE can be efficiently read
and writen in __switch_to().  Use that capability to preserve the full
state.

This will enable user code to do whatever it wants with the new
instructions without any kernel-induced gotchas.  (There can still be
architectural gotchas: movl %gs,%eax; movl %eax,%gs may change GSBASE if
WRGSBASE was used, but users are expected to read the CPU manual before
doing things like that.)

This is a considerable speedup.  It seems to save about 100 cycles
per context switch compared to the baseline 4.6-rc1 behavior on a
Skylake laptop. This is mostly due to avoiding the WRMSR operation.

[ chang: 5~10% performance improvements were seen with a context switch
  benchmark that ran threads with different FS/GSBASE values (to the
  baseline 4.16). Minor edit on the changelog. ]

[ tglx: Masaage changelog ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1557309753-24073-8-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-6-sashal@kernel.org


---
 arch/x86/kernel/process_64.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ef2f755..8ccc587 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -236,8 +236,18 @@ static __always_inline void save_fsgs(struct task_struct *task)
 {
 	savesegment(fs, task->thread.fsindex);
 	savesegment(gs, task->thread.gsindex);
-	save_base_legacy(task, task->thread.fsindex, FS);
-	save_base_legacy(task, task->thread.gsindex, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * If FSGSBASE is enabled, we can't make any useful guesses
+		 * about the base, and user code expects us to save the current
+		 * value.  Fortunately, reading the base directly is efficient.
+		 */
+		task->thread.fsbase = rdfsbase();
+		task->thread.gsbase = __rdgsbase_inactive();
+	} else {
+		save_base_legacy(task, task->thread.fsindex, FS);
+		save_base_legacy(task, task->thread.gsindex, GS);
+	}
 }
 
 /*
@@ -319,10 +329,22 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 					      struct thread_struct *next)
 {
-	load_seg_legacy(prev->fsindex, prev->fsbase,
-			next->fsindex, next->fsbase, FS);
-	load_seg_legacy(prev->gsindex, prev->gsbase,
-			next->gsindex, next->gsbase, GS);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/* Update the FS and GS selectors if they could have changed. */
+		if (unlikely(prev->fsindex || next->fsindex))
+			loadseg(FS, next->fsindex);
+		if (unlikely(prev->gsindex || next->gsindex))
+			loadseg(GS, next->gsindex);
+
+		/* Update the bases. */
+		wrfsbase(next->fsbase);
+		__wrgsbase_inactive(next->gsbase);
+	} else {
+		load_seg_legacy(prev->fsindex, prev->fsbase,
+				next->fsindex, next->fsbase, FS);
+		load_seg_legacy(prev->gsindex, prev->gsbase,
+				next->gsindex, next->gsbase, GS);
+	}
 }
 
 static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
