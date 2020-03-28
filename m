Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2706C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD5D206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgC1ItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:49:08 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58946 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgC1ItH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:49:07 -0400
Received: from sf.home (host86-151-215-168.range86-151.btcentralplus.com [86.151.215.168])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 2D73B34F98C;
        Sat, 28 Mar 2020 08:49:06 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
        id EE3D15A22061; Sat, 28 Mar 2020 08:49:02 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Matz <matz@suse.de>, x86@kernel.org
Subject: [PATCH v2] x86: fix early boot crash on gcc-10
Date:   Sat, 28 Mar 2020 08:48:58 +0000
Message-Id: <20200328084858.421444-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326223501.GK11398@zn.tnic>
References: <20200326223501.GK11398@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change fixes boot failure on physical machine where kernel
is built with gcc-10 with stack protector enabled by default:

```
Kernel panic — not syncing: stack-protector: Kernel stack is corrupted in: start_secondary+0x191/0x1a0
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5—00235—gfffb08b37df9 #139
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M—D3H, BIOS F12 11/14/2013
Call Trace:
  dump_stack+0x71/0xa0
  panic+0x107/0x2b8
  ? start_secondary+0x191/0x1a0
  __stack_chk_fail+0x15/0x20
  start_secondary+0x191/0x1a0
  secondary_startup_64+0xa4/0xb0
-—-[ end Kernel panic — not syncing: stack—protector: Kernel stack is corrupted in: start_secondary+0x191
```

This happens because `start_secondary()` is responsible for setting
up initial stack canary value in `smpboot.c`, but nothing prevents
gcc from inserting stack canary into `start_secondary()` itself
before `boot_init_stack_canary()` call.

The fix inhibits stack canary check foa single `start_secondary()`
function.

Tested the change by successfully booting the machine.

A few similar crashes on VMs:
- https://bugzilla.redhat.com/show_bug.cgi?id=1796780
- http://rglinuxtech.com/?p=2694

CC: Jakub Jelinek <jakub@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Michael Matz <matz@suse.de>
CC: x86@kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/x86/kernel/smpboot.c      | 5 ++++-
 include/linux/compiler-gcc.h   | 1 +
 include/linux/compiler_types.h | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2d446c..99a4cb631a64 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -207,8 +207,11 @@ static int cpu0_logical_apicid;
 static int enable_start_cpu0;
 /*
  * Activate a secondary processor.
+ *
+ * Note: 'boot_init_stack_canary' changes canary value. Omit
+ * stack protection to avoid canary check (and boot) failure.
  */
-static void notrace start_secondary(void *unused)
+static void __no_stack_protector notrace start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* except direct CPU state initialization
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..fb67c743138c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -172,3 +172,4 @@
 #endif
 
 #define __no_fgcse __attribute__((optimize("-fno-gcse")))
+#define __no_stack_protector __attribute__((optimize("-fno-stack-protector")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..9d5de1ea0b03 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -212,6 +212,10 @@ struct ftrace_likely_data {
 #define asm_inline asm
 #endif
 
+#ifndef __no_stack_protector
+# define __no_stack_protector
+#endif
+
 #ifndef __no_fgcse
 # define __no_fgcse
 #endif
-- 
2.26.0

