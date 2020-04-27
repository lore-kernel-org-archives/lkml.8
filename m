Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEFCC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAF5206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgD0Lhx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0Lhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:37:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C175C0610D5;
        Mon, 27 Apr 2020 04:37:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jT257-0001BZ-KW; Mon, 27 Apr 2020 13:37:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4715D1C0451;
        Mon, 27 Apr 2020 13:37:49 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:37:48 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Check whether the compiler is sane
Cc:     mliska@suse.cz, Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200423173058.GE26021@zn.tnic>
References: <20200423173058.GE26021@zn.tnic>
MIME-Version: 1.0
Message-ID: <158798746887.28353.12553648261169854767.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     73da86741e7f75c9f1b5c8a2660c90aa41840972
Gitweb:        https://git.kernel.org/tip/73da86741e7f75c9f1b5c8a2660c90aa41840972
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 23 Apr 2020 19:28:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 27 Apr 2020 13:31:57 +02:00

x86/build: Check whether the compiler is sane

Add a check script to verify whether the compiler is sane. This is
x86-only for now and checks one thing only but should be useful for more
checks in the future.

Suggested-by: Martin Liška <mliska@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20200423173058.GE26021@zn.tnic
---
 arch/x86/Makefile             |  4 ++++
 scripts/x86-check-compiler.sh |  9 +++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 scripts/x86-check-compiler.sh

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378d..38d3eec 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Unified Makefile for i386 and x86_64
 
+#  Check the compiler
+sane_compiler := $(shell $(srctree)/scripts/x86-check-compiler.sh $(CC))
+$(if $(sane_compiler),$(error $(CC) check failed. Aborting),)
+
 # select defconfig based on actual architecture
 ifeq ($(ARCH),x86)
   ifeq ($(shell uname -m),x86_64)
diff --git a/scripts/x86-check-compiler.sh b/scripts/x86-check-compiler.sh
new file mode 100755
index 0000000..b2b5b54
--- /dev/null
+++ b/scripts/x86-check-compiler.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Check whether the compiler tail-call optimizes across an asm() statement.
+# Fail the build if it does.
+
+echo "int foo(int a); int bar(int a) { int r = foo(a); asm(\"\"); return r; }" |\
+	     $* -O2 -x c -c -S - -o - 2>/dev/null |\
+	     grep -E "^[[:blank:]]+jmp[[:blank:]]+.*"
