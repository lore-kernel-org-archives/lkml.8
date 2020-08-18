Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931B6204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hgduRtMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHRKgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHRKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:36:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A7C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 03:36:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09D491EC0242;
        Tue, 18 Aug 2020 12:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597746985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=oLuV1otE+FXjmTbf+3p7DVNs3egn/fXYLEmfGswqK8Q=;
        b=hgduRtMdVqnlmKL/bI/1lMwTajg9X3GxtEQuufdoqkbHovXwrq8243OTAAqJbZ5/CIGmln
        dZW+UwNOxlx0SlzgR4Bb4bm7h+/RcqWbhPsNBjb71MJQOpL0/NSzGptjbXHWHcp7z54NDI
        VFWBseG0p3DkzlH8FiRDb36EITH6ppk=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/fsgsbase: Replace static_cpu_has() with boot_cpu_has()
Date:   Tue, 18 Aug 2020 12:37:15 +0200
Message-Id: <20200818103715.32736-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

ptrace and prctl() are not really fast paths to warrant the use of
static_cpu_has() and cause alternatives patching for no good reason.
Replace with boot_cpu_has() which is simple and fast enough.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fsgsbase.h | 4 ++--
 arch/x86/kernel/process_64.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index d552646411a9..35cff5f2becf 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -57,7 +57,7 @@ static inline unsigned long x86_fsbase_read_cpu(void)
 {
 	unsigned long fsbase;
 
-	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
 		fsbase = rdfsbase();
 	else
 		rdmsrl(MSR_FS_BASE, fsbase);
@@ -67,7 +67,7 @@ static inline unsigned long x86_fsbase_read_cpu(void)
 
 static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE))
 		wrfsbase(fsbase);
 	else
 		wrmsrl(MSR_FS_BASE, fsbase);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9afefe325acb..df342bedea88 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -407,7 +407,7 @@ unsigned long x86_gsbase_read_cpu_inactive(void)
 {
 	unsigned long gsbase;
 
-	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE)) {
 		unsigned long flags;
 
 		local_irq_save(flags);
@@ -422,7 +422,7 @@ unsigned long x86_gsbase_read_cpu_inactive(void)
 
 void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
 {
-	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+	if (boot_cpu_has(X86_FEATURE_FSGSBASE)) {
 		unsigned long flags;
 
 		local_irq_save(flags);
@@ -439,7 +439,7 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+	else if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
 		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
@@ -454,7 +454,7 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+	else if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
 		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
-- 
2.21.0

