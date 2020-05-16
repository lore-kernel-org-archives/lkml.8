Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6391C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B2C207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="czRugynH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgEPMiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:38:23 -0400
Received: from mout02.posteo.de ([185.67.36.66]:51357 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:38:23 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9095F2400FB
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 14:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1589632700; bh=qcpg3ygXrvNalvkBvFBuuFtGT1hgLMu0Ganj5drZp3g=;
        h=From:To:Cc:Subject:Date:From;
        b=czRugynHkoLZyUZzvX5Ir4BYg5BplKwcgkhzySqDhHG6ql82VJ1vPMO2xe/J7gQSo
         /WpRIL3HxyOJMzS3Zb/7O6/jLuNYRPLevZ/aEGJHHQQs39llcRhIwY4aZoNmuCNLq4
         Sg/9DXzhWwu/CoAmNc83++dm13BTJ9fvbvRWJotfz1P68UiIwWafXs+xeWYUThZDP9
         gC/D8DJBRUQzTnlxejSJWJGNThuEDKFurawyxlHwP9NceWseG87xZJ4BSQ41tc4fiz
         X5hqL09ZR34021MUCE8bLASljHjgWE5Ccae5fj6xft+mwe2psnA4mzFz0f9dHqz55N
         f/uJi9NtlNwlg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 49PPvc0GJGz9rxc;
        Sat, 16 May 2020 14:38:19 +0200 (CEST)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     x86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/audit: Fix a -Wmissing-prototypes warning for ia32_classify_syscall()
Date:   Sat, 16 May 2020 14:38:16 +0200
Message-Id: <20200516123816.2680-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lift the prototype of ia32_classify_syscall() into its own header.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/ia32/audit.c        | 1 +
 arch/x86/include/asm/audit.h | 7 +++++++
 arch/x86/kernel/audit_64.c   | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/audit.h

diff --git a/arch/x86/ia32/audit.c b/arch/x86/ia32/audit.c
index 3d21eab7aaed..6efe6cb3768a 100644
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
index 000000000000..36aec57ea7a3
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
index e1efe44ebefc..83d9cad4e68b 100644
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
-- 
2.20.1

