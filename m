Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D49C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CA8207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696891;
	bh=Cbug4Zw6pLdPJMyM6ewVPi8za9fxR3JM1cojC9EnM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=spG/HZj2B278uod1wLZTM7ww8x9EiBsdLu/KMuIMvN95z6H8uhh2+NHjgT1ecYnq6
	 axBmTq4i8jre5MJfm9Rz1pyLgck9q7ivrzTebrk8XgQjIw8Zn39IHfkAFpsGClvMCJ
	 AnMMJuCiGPymgeLTJtNwvVvmxKNSfpE9KT1mQZ1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407070AbgE1UOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407019AbgE1UO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE06E2088E;
        Thu, 28 May 2020 20:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696865;
        bh=Cbug4Zw6pLdPJMyM6ewVPi8za9fxR3JM1cojC9EnM+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4AEdmZm0JNgL/s0oKV0nM8NQEtvV6FVP+zpgtOHyGsyffMn6AxwzOQXx0Qhl5raN
         rQdeD3rlf9SHPYNeGSHLlkQLrUSO5SQaJKvouupTtButX4L8jUewo3SCzNZMTMx2eJ
         a+dSGyhGVU/1cRPAohlORhLGnA1RlgocBEFGsmEs=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 07/16] x86/process/64: Use FSGSBASE instructions on thread copy and ptrace
Date:   Thu, 28 May 2020 16:13:53 -0400
Message-Id: <20200528201402.1708239-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

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
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-9-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/process.c    | 10 ++++++----
 arch/x86/kernel/process_64.c |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b279dad..0264d9bb8991 100644
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
index aefb30bc56bc..0bcb48a1264a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -423,7 +423,8 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -437,7 +438,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
-- 
2.25.1

