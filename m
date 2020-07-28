Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8765920809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgG1UXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgG1UW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:22:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BFDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:22:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1759128EA02
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 4/6] arch: x86: Expose psABI on thread_info
Date:   Tue, 28 Jul 2020 16:22:27 -0400
Message-Id: <20200728202229.1195682-5-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728202229.1195682-1-krisman@collabora.com>
References: <20200728202229.1195682-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose psABI in thread_info, in preparation for the TIF_IA32 and
TIF_X32 flags removal.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/thread_info.h | 2 ++
 arch/x86/kernel/process_64.c       | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 6d55a9c0dda2..698feefd5f5f 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -62,11 +62,13 @@ enum {
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	u32			status;		/* thread synchronous flags */
+	short int		psabi;
 };
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.flags		= 0,			\
+	.psabi		= 0,			\
 }
 
 #else /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index f20a365017b8..aea2c03e8a5d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -532,6 +532,7 @@ void set_personality_64bit(void)
 	/* inherit personality from parent */
 
 	/* Make sure to be in 64bit mode */
+	current_thread_info()->psabi = PSABI_IA64;
 	clear_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_ADDR32);
 	clear_thread_flag(TIF_X32);
@@ -553,6 +554,7 @@ void set_personality_64bit(void)
 static void __set_personality_x32(void)
 {
 #ifdef CONFIG_X86_X32
+	current_thread_info()->psabi = PSABI_X32;
 	clear_thread_flag(TIF_IA32);
 	set_thread_flag(TIF_X32);
 	if (current->mm)
@@ -574,6 +576,7 @@ static void __set_personality_x32(void)
 static void __set_personality_ia32(void)
 {
 #ifdef CONFIG_IA32_EMULATION
+	current_thread_info()->psabi = PSABI_IA32;
 	set_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_X32);
 	if (current->mm)
-- 
2.27.0

