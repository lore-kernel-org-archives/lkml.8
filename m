Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B3C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377E7206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgD0Lh5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0Lhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:37:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71DBC0610D5;
        Mon, 27 Apr 2020 04:37:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jT257-0001BY-9Z; Mon, 27 Apr 2020 13:37:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C368D1C0131;
        Mon, 27 Apr 2020 13:37:48 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:37:48 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86: Fix early boot crash on gcc-10, next try
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200314164451.346497-1-slyfox@gentoo.org>
References: <20200314164451.346497-1-slyfox@gentoo.org>
MIME-Version: 1.0
Message-ID: <158798746828.28353.6010675315553653459.tip-bot2@tip-bot2>
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

Commit-ID:     f670269a42bfdd2c83a1118cc3d1b475547eac22
Gitweb:        https://git.kernel.org/tip/f670269a42bfdd2c83a1118cc3d1b475547eac22
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 22 Apr 2020 18:11:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 27 Apr 2020 13:32:04 +02:00

x86: Fix early boot crash on gcc-10, next try

... or the odyssey of trying to disable the stack protector for the
function which generates the stack canary value.

The whole story started with Sergei reporting a boot crash with a kernel
built with gcc-10:

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

This happens because gcc-10 tail-call optimizes the last function call
in start_secondary() - cpu_startup_entry() - and thus emits a stack
canary check which fails because the canary value changes after the
boot_init_stack_canary() call.

To fix that, the initial attempt was to mark the one function which
generates the stack canary with:

  __attribute__((optimize("-fno-stack-protector"))) ... start_secondary(void *unused)

however, using the optimize attribute doesn't work cumulatively
as the attribute does not add to but rather replaces previously
supplied optimization options - roughly all -fxxx options.

The key one among them being -fno-omit-frame-pointer and thus leading to
not present frame pointer - frame pointer which the kernel needs.

The next attempt to prevent compilers from tail-call optimizing
the last function call cpu_startup_entry(), shy of carving out
start_secondary() into a separate compilation unit and building it with
-fno-stack-protector, is this one.

The current solution is short and sweet, and reportedly, is supported by
both compilers so let's see how far we'll get this time.

Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200314164451.346497-1-slyfox@gentoo.org
---
 arch/x86/include/asm/stackprotector.h | 7 ++++++-
 arch/x86/kernel/smpboot.c             | 8 ++++++++
 arch/x86/xen/smp_pv.c                 | 1 +
 include/linux/compiler.h              | 6 ++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 91e29b6..9804a79 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -55,8 +55,13 @@
 /*
  * Initialize the stackprotector canary value.
  *
- * NOTE: this must only be called from functions that never return,
+ * NOTE: this must only be called from functions that never return
  * and it must always be inlined.
+ *
+ * In addition, it should be called from a compilation unit for which
+ * stack protector is disabled. Alternatively, the caller should not end
+ * with a function call which gets tail-call optimized as that would
+ * lead to checking a modified canary value.
  */
 static __always_inline void boot_init_stack_canary(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab96..4f275ac 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -266,6 +266,14 @@ static void notrace start_secondary(void *unused)
 
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+
+	/*
+	 * Prevent tail call to cpu_startup_entry() because the stack protector
+	 * guard has been changed a couple of function calls up, in
+	 * boot_init_stack_canary() and must not be checked before tail calling
+	 * another function.
+	 */
+	prevent_tail_call_optimization();
 }
 
 /**
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 8fb8a50..f2adb63 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -93,6 +93,7 @@ asmlinkage __visible void cpu_bringup_and_idle(void)
 	cpu_bringup();
 	boot_init_stack_canary();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+	prevent_tail_call_optimization();
 }
 
 void xen_smp_intr_free_pv(unsigned int cpu)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 034b0a6..732754d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -356,4 +356,10 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/*
+ * This is needed in functions which generate the stack canary, see
+ * arch/x86/kernel/smpboot.c::start_secondary() for an example.
+ */
+#define prevent_tail_call_optimization()	asm("")
+
 #endif /* __LINUX_COMPILER_H */
