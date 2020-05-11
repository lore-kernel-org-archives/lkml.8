Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB98C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6D620820
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172853;
	bh=8moYjDH0vKaHVvSmmvJ+iPsPxHby3FvbWhV8B4oCY9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y052gmBDbP0sCXrV99M4JnU64dE+K4AxVYXIzggbtpelOYrh22wFNZw+U0l5y13TN
	 4hM87iFAYyn+6ZiW/oyzL/OZtSwII2743XhfFggvNQgHAOq0XXVnlLAEXB4OLjjj+X
	 Q0PIuB4fZDk8Rwhnf9N/JRdHr/Y0+275JhQHSNR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEKEyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgEKExp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870BE20820;
        Mon, 11 May 2020 04:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172824;
        bh=8moYjDH0vKaHVvSmmvJ+iPsPxHby3FvbWhV8B4oCY9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e96y07+OMcSoPsdQHcWR3bQrGgMGWHIXD+RZTVIMJD/N4J6e0epOSKbuwSFkkUoLF
         N0pd8EuzqTU6l/rcPohfRCJGtzu7TJl3DInpzUCYVASW5MQvdSgbahm7RAucdFUNVB
         hOmHKcn6o+akzyLVqUm8ATGu3MNLFwFuPI/KnQZo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 13/18] x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
Date:   Mon, 11 May 2020 00:53:06 -0400
Message-Id: <20200511045311.4785-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When FSGSBASE is enabled, copying threads and reading FS/GS base using
ptrace must read the actual values.

When copying a thread, use fsgs_save() and copy the saved values. For
ptrace, the bases must be read from memory regardless of the selector
if FSGSBASE is enabled.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/process.c    | 9 +++++----
 arch/x86/kernel/process_64.c | 6 ++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b279dad8..31dd24f9c8d8e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -140,10 +140,11 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
-	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
+	save_fsgs(current);
+	p->thread.fsindex = current->thread.fsindex;
+	p->thread.fsbase = current->thread.fsbase;
+	p->thread.gsindex = current->thread.gsindex;
+	p->thread.gsbase = current->thread.gsbase;
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
 #else
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4be88124d81ea..57cdbbb0381ac 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -346,7 +346,8 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -360,7 +361,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
-- 
2.20.1

