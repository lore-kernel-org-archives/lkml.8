Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AFFC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ED820784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684180;
	bh=jBoFrACXx4Px8cBOPCtQwbLFMFIbg2WXxMawmMD5064=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lCrEljzFuaiDXsiLIMNLosSrkwKtBb1WGK+jQhlwPvhKAt/VelOqyHig2/A0BgzX+
	 uUDU9ZKrhDioDN5ej/Q+iVg+8OElCRdMQaio9QUDdr4ip0RsvkuaR2zq3XIlG3/Q4R
	 XtekDwL5S176hhhBGo6JvqhrCb/vfyjLNDZmhpT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgDWXW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgDWXW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE34521927;
        Thu, 23 Apr 2020 23:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684147;
        bh=jBoFrACXx4Px8cBOPCtQwbLFMFIbg2WXxMawmMD5064=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtbcQS/E4AkBtXiYomGS5ZciYcOq0l795OT/a6kcqifLdk2K7/eIQF5IJ2EwjUshS
         /nDlk9ZQ4BN7eO/GcDHfCBALSzN/ki0OK295Uy70McmVQk750OT7pj9Rn6KUnovm1F
         oL3gXfyySPWQqMqwjIsO6XO4lHl5xVNUBaLMe5Jk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 11/18] x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
Date:   Thu, 23 Apr 2020 19:22:00 -0400
Message-Id: <20200423232207.5797-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

With the new FSGSBASE instructions, FS/GS base can be efficiently read
and written in __switch_to(). Use that capability to preserve the full
state.

This will enable user code to do whatever it wants with the new
instructions without any kernel-induced gotchas.  (There can still be
architectural gotchas: movl %gs,%eax; movl %eax,%gs may change GS base
if WRGSBASE was used, but users are expected to read the CPU manual
before doing things like that.)

This is a considerable speedup. It seems to save about 100 cycles per
context switch compared to the baseline 4.6-rc1 behavior on a Skylake
laptop.

[ chang: 5~10% performance improvements were seen by a context switch
  benchmark that ran threads with different FS/GS base values (to the
  baseline 4.16). ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/process_64.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index aaa65f284b9b9..e066750be89a0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -199,8 +199,18 @@ static __always_inline void save_fsgs(struct task_struct *task)
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
+		task->thread.gsbase = x86_gsbase_read_cpu_inactive();
+	} else {
+		save_base_legacy(task, task->thread.fsindex, FS);
+		save_base_legacy(task, task->thread.gsindex, GS);
+	}
 }
 
 #if IS_ENABLED(CONFIG_KVM)
@@ -279,10 +289,22 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
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
+		x86_gsbase_write_cpu_inactive(next->gsbase);
+	} else {
+		load_seg_legacy(prev->fsindex, prev->fsbase,
+				next->fsindex, next->fsbase, FS);
+		load_seg_legacy(prev->gsindex, prev->gsbase,
+				next->gsindex, next->gsbase, GS);
+	}
 }
 
 static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-- 
2.20.1

