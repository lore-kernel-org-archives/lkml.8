Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEBFC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB592080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCSORL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:17:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgCSORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:17:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvyp-0002lm-4I; Thu, 19 Mar 2020 15:17:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A39E81C22B0;
        Thu, 19 Mar 2020 15:17:02 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:17:02 -0000
From:   "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Fix static memory detection
Cc:     Guenter Roeck <linux@roeck-us.net>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200131021159.9178-1-linux@roeck-us.net>
References: <20200131021159.9178-1-linux@roeck-us.net>
MIME-Version: 1.0
Message-ID: <158462742211.28353.13380254694038883498.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     bac59d18c7018a2fd5e800a1e72a8271bf404977
Gitweb:        https://git.kernel.org/tip/bac59d18c7018a2fd5e800a1e72a8271bf404977
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 30 Jan 2020 18:11:59 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Mar 2020 11:58:13 +01:00

x86/setup: Fix static memory detection

When booting x86 images in qemu, the following warning is seen randomly
if DEBUG_LOCKDEP is enabled.

  WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1119
	  lockdep_register_key+0xc0/0x100

static_obj() returns true if an address is between _stext and _end.

On x86, this includes the brk memory space. Problem is that this memory
block is not static on x86; its unused portions are released after init
and can be allocated. This results in the observed warning if a lockdep
object is allocated from this memory.

Solve the problem by implementing arch_is_kernel_initmem_freed() for
x86 and have it return true if an address is within the released memory
range.

The same problem was solved for s390 with commit

  7a5da02de8d6e ("locking/lockdep: check for freed initmem in static_obj()"),

which introduced arch_is_kernel_initmem_freed().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200131021159.9178-1-linux@roeck-us.net
---
 arch/x86/include/asm/sections.h | 20 ++++++++++++++++++++
 arch/x86/kernel/setup.c         |  1 -
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 036c360..a6e8373 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SECTIONS_H
 #define _ASM_X86_SECTIONS_H
 
+#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
+
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
@@ -14,4 +16,22 @@ extern char __end_rodata_hpage_align[];
 
 extern char __end_of_kernel_reserve[];
 
+extern unsigned long _brk_start, _brk_end;
+
+static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
+{
+	/*
+	 * If _brk_start has not been cleared, brk allocation is incomplete,
+	 * and we can not make assumptions about its use.
+	 */
+	if (_brk_start)
+		return 0;
+
+	/*
+	 * After brk allocation is complete, space between _brk_end and _end
+	 * is available for allocation.
+	 */
+	return addr >= _brk_end && addr < (unsigned long)&_end;
+}
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a74262c..e6b5450 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -64,7 +64,6 @@ RESERVE_BRK(dmi_alloc, 65536);
  * at link time, with RESERVE_BRK*() facility reserving additional
  * chunks.
  */
-static __initdata
 unsigned long _brk_start = (unsigned long)__brk_base;
 unsigned long _brk_end   = (unsigned long)__brk_base;
 
