Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF152C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAE8206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgESTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:42:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C865C08C5C0;
        Tue, 19 May 2020 12:42:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb87j-0007dB-EL; Tue, 19 May 2020 21:41:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C095A1C0178;
        Tue, 19 May 2020 21:41:58 +0200 (CEST)
Date:   Tue, 19 May 2020 19:41:58 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/audit: Fix a -Wmissing-prototypes warning for
 ia32_classify_syscall()
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200516123816.2680-1-b.thiel@posteo.de>
References: <20200516123816.2680-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158991731859.17951.14834257660085300527.tip-bot2@tip-bot2>
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

Commit-ID:     0e5e3d4461a22d739fb2284a6e313fb6cecf2871
Gitweb:        https://git.kernel.org/tip/0e5e3d4461a22d739fb2284a6e313fb6cecf2871
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Sat, 16 May 2020 14:38:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 May 2020 18:03:07 +02:00

x86/audit: Fix a -Wmissing-prototypes warning for ia32_classify_syscall()

Lift the prototype of ia32_classify_syscall() into its own header.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200516123816.2680-1-b.thiel@posteo.de
---
 arch/x86/ia32/audit.c        | 1 +
 arch/x86/include/asm/audit.h | 7 +++++++
 arch/x86/kernel/audit_64.c   | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/audit.h

diff --git a/arch/x86/ia32/audit.c b/arch/x86/ia32/audit.c
index 3d21eab..6efe6cb 100644
--- a/arch/x86/ia32/audit.c
+++ b/arch/x86/ia32/audit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/unistd_32.h>
+#include <asm/audit.h>
 
 unsigned ia32_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
diff --git a/arch/x86/include/asm/audit.h b/arch/x86/include/asm/audit.h
new file mode 100644
index 0000000..36aec57
--- /dev/null
+++ b/arch/x86/include/asm/audit.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AUDIT_H
+#define _ASM_X86_AUDIT_H
+
+int ia32_classify_syscall(unsigned int syscall);
+
+#endif /* _ASM_X86_AUDIT_H */
diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
index e1efe44..83d9cad 100644
--- a/arch/x86/kernel/audit_64.c
+++ b/arch/x86/kernel/audit_64.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/audit.h>
 #include <asm/unistd.h>
+#include <asm/audit.h>
 
 static unsigned dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
@@ -41,7 +42,6 @@ int audit_classify_arch(int arch)
 int audit_classify_syscall(int abi, unsigned syscall)
 {
 #ifdef CONFIG_IA32_EMULATION
-	extern int ia32_classify_syscall(unsigned);
 	if (abi == AUDIT_ARCH_I386)
 		return ia32_classify_syscall(syscall);
 #endif
