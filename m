Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87721C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6780A20774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgDMOQR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:16:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgDMOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:16:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jNzsW-00021U-Nm; Mon, 13 Apr 2020 16:16:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B5751C0092;
        Mon, 13 Apr 2020 16:16:00 +0200 (CEST)
Date:   Mon, 13 Apr 2020 14:15:59 -0000
From:   "tip-bot2 for Sergei Trofimovich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Fix early boot crash on gcc-10
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Borislav Petkov <bp@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Michael Matz <matz@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200328084858.421444-1-slyfox@gentoo.org>
References: <20200328084858.421444-1-slyfox@gentoo.org>
MIME-Version: 1.0
Message-ID: <158678735989.28353.17058422416826993351.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5871c72d659e5c312b9ad635034cab59f7786a98
Gitweb:        https://git.kernel.org/tip/5871c72d659e5c312b9ad635034cab59f7786a98
Author:        Sergei Trofimovich <slyfox@gentoo.org>
AuthorDate:    Sat, 28 Mar 2020 08:48:58 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Apr 2020 16:07:35 +02:00

x86: Fix early boot crash on gcc-10

Fix a boot failure where the kernel is built with gcc-10 with stack
protector enabled by default:

  Kernel panic — not syncing: stack-protector: Kernel stack is corrupted in: start_secondary
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5—00235—gfffb08b37df9 #139
  Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M—D3H, BIOS F12 11/14/2013
  Call Trace:
    dump_stack
    panic
    ? start_secondary
    __stack_chk_fail
    start_secondary
    secondary_startup_64
  -—-[ end Kernel panic — not syncing: stack—protector: Kernel stack is corrupted in: start_secondary

This happens because start_secondary() is responsible for setting
up initial stack canary value in smpboot.c but nothing prevents gcc
from inserting stack canary into start_secondary() itself before the
boot_init_stack_canary() call which sets up said canary value.

Inhibit the stack canary addition for start_secondary() only.

 [ bp: Massage a bit. ]

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Jakub Jelinek <jakub@redhat.com>
Cc: Michael Matz <matz@suse.de>
Link: https://lkml.kernel.org/r/20200328084858.421444-1-slyfox@gentoo.org
---
 arch/x86/kernel/smpboot.c      | 6 +++++-
 include/linux/compiler-gcc.h   | 1 +
 include/linux/compiler_types.h | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab96..9ea28e5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -209,10 +209,14 @@ static void smp_callin(void)
 
 static int cpu0_logical_apicid;
 static int enable_start_cpu0;
+
 /*
  * Activate a secondary processor.
+ *
+ * Note: boot_init_stack_canary() sets up the canary value so omit the stack
+ * canary creation for this function only.
  */
-static void notrace start_secondary(void *unused)
+static void __no_stack_protector notrace start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* except direct CPU state initialization
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6..fb67c74 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -172,3 +172,4 @@
 #endif
 
 #define __no_fgcse __attribute__((optimize("-fno-gcse")))
+#define __no_stack_protector __attribute__((optimize("-fno-stack-protector")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e970f97..069c981 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -203,6 +203,10 @@ struct ftrace_likely_data {
 #define asm_inline asm
 #endif
 
+#ifndef __no_stack_protector
+# define __no_stack_protector
+#endif
+
 #ifndef __no_fgcse
 # define __no_fgcse
 #endif
