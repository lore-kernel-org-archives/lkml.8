Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB17DC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77172070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCWTyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:54:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCWTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:54:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGT9Y-00065X-Mb; Mon, 23 Mar 2020 20:54:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2D20A1C0475;
        Mon, 23 Mar 2020 20:54:28 +0100 (CET)
Date:   Mon, 23 Mar 2020 19:54:27 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] um: Fix header inclusion
Cc:     kbuild test robot <lkp@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323124109.7104-1-vincenzo.frascino@arm.com>
References: <20200323124109.7104-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158499326782.28353.14321453432536168841.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1c1a18b00d7e25d1bed3507880de2da07be704a2
Gitweb:        https://git.kernel.org/tip/1c1a18b00d7e25d1bed3507880de2da07be704a2
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Mon, 23 Mar 2020 12:41:09 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 23 Mar 2020 18:45:14 +01:00

um: Fix header inclusion

User Mode Linux is a flavor of x86 that from the vDSO prospective always
falls back on system calls. This implies that it does not require any
of the unified vDSO definitions and their inclusion causes side effects
like this:

  In file included from include/vdso/processor.h:10:0,
                      from include/vdso/datapage.h:17,
                      from arch/x86/include/asm/vgtod.h:7,
                      from arch/x86/um/../kernel/sys_ia32.c:49:
  >> arch/x86/include/asm/vdso/processor.h:11:29: error: redefinition of 'rep_nop'
      static __always_inline void rep_nop(void)
                                  ^~~~~~~
     In file included from include/linux/rcupdate.h:30:0,
                      from include/linux/rculist.h:11,
                      from include/linux/pid.h:5,
                      from include/linux/sched.h:14,
                      from arch/x86/um/../kernel/sys_ia32.c:25:
     arch/x86/um/asm/processor.h:24:20: note: previous definition of 'rep_nop' was here
      static inline void rep_nop(void)

Make sure that the unnecessary headers are not included when um is built
to address the problem.

Fixes: abc22418db02 ("x86/vdso: Enable x86 to use common headers")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200323124109.7104-1-vincenzo.frascino@arm.com
---
 arch/x86/include/asm/vgtod.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fc8e4cd..7aa38b2 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_X86_VGTOD_H
 #define _ASM_X86_VGTOD_H
 
+/*
+ * This check is required to prevent ARCH=um to include
+ * unwanted headers.
+ */
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #include <linux/compiler.h>
 #include <asm/clocksource.h>
 #include <vdso/datapage.h>
@@ -14,5 +19,6 @@ typedef u64 gtod_long_t;
 #else
 typedef unsigned long gtod_long_t;
 #endif
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #endif /* _ASM_X86_VGTOD_H */
