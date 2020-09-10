Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A88C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCB2214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Oz+WMPN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/OI6y12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIJS5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgIJSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:54:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47BC061757;
        Thu, 10 Sep 2020 11:54:38 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DSwAXd/5jzZIujZDN7Y8HgKA43b9bCIbb1xoVGCvIz8=;
        b=4Oz+WMPNdss5ltOezKVGrCfSXJogqDjk+U1qKgtvws2FIOqFrTAMrI5rwz2Va+grHA4QN+
        2dZStRhTBMqG2DdLNuG6OkZFQjc574tm47rfunG2KvXD2exWHI7Vs2Wi8ZHphs/VqK8+e/
        StBhCaGdHW6aqR/Jk9rza1+Vr3/WPjWY1jf+nmRkxIkOrSpG7TGFyNfeMwfKX4A+XsBP1Y
        o4f7ppPqvv9MwlRCijkPKWfJgcl6cdNsYwtC5eBb3PadWf6ElZ0bMlCsVEnPq2NmJaBSxr
        TyLZWLOgot+Y8DqGUMcK6AUqi1Y3c6rQ9b6xRFT1pABeB9kiXNbDiTylXetVUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DSwAXd/5jzZIujZDN7Y8HgKA43b9bCIbb1xoVGCvIz8=;
        b=w/OI6y12DNrzoPW6XPBoHlkMYiOQ117ZCEw6c0t7Sf79SB5eOT0Z1wESYCnhK7B1vwFbMv
        s9uASgdZKWtemICQ==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rename frame.h -> objtool.h
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407592.20229.1653605146880450425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     00089c048eb4a8250325efb32a2724fd0da68cce
Gitweb:        https://git.kernel.org/tip/00089c048eb4a8250325efb32a2724fd0da68cce
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:25 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Rename frame.h -> objtool.h

Header frame.h is getting more code annotations to help objtool analyze
object files.

Rename the file to objtool.h.

[ jpoimboe: add objtool.h to MAINTAINERS ]

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 MAINTAINERS                          |  1 +-
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/kprobes/core.c       |  2 +-
 arch/x86/kernel/kprobes/opt.c        |  2 +-
 arch/x86/kernel/reboot.c             |  2 +-
 arch/x86/kvm/svm/svm.c               |  2 +-
 arch/x86/kvm/vmx/nested.c            |  2 +-
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 arch/x86/xen/enlighten_pv.c          |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c  |  3 +--
 include/linux/frame.h                | 35 +---------------------------
 include/linux/objtool.h              | 35 +++++++++++++++++++++++++++-
 kernel/bpf/core.c                    |  2 +-
 kernel/kexec_core.c                  |  2 +-
 14 files changed, 47 insertions(+), 47 deletions(-)
 delete mode 100644 include/linux/frame.h
 create mode 100644 include/linux/objtool.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c8..2605a08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12481,6 +12481,7 @@ M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
 F:	tools/objtool/
+F:	include/linux/objtool.h
 
 OCELOT ETHERNET SWITCH DRIVER
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e7752b4..86651e8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -4,7 +4,7 @@
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
 #include <linux/static_key.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index fdadc37..ae24886 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -38,9 +38,9 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
-#include <linux/frame.h>
 #include <linux/kasan.h>
 #include <linux/moduleloader.h>
+#include <linux/objtool.h>
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index c068e21..9b1cb8f 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -16,7 +16,7 @@
 #include <linux/kdebug.h>
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/pgtable.h>
 #include <linux/static_call.h>
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index a515e2d..db11594 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -10,7 +10,7 @@
 #include <linux/sched.h>
 #include <linux/tboot.h>
 #include <linux/delay.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/pgtable.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0194336..17ba613 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -19,7 +19,7 @@
 #include <linux/trace_events.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/psp-sev.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 23b58c2..ae4ff7c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/percpu.h>
 
 #include <asm/debugreg.h>
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 819c185..df29fb4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -13,7 +13,6 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
 
-#include <linux/frame.h>
 #include <linux/highmem.h>
 #include <linux/hrtimer.h>
 #include <linux/kernel.h>
@@ -22,6 +21,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mm.h>
+#include <linux/objtool.h>
 #include <linux/sched.h>
 #include <linux/sched/smt.h>
 #include <linux/slab.h>
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 22e741e..58382d2 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -32,7 +32,7 @@
 #include <linux/pci.h>
 #include <linux/gfp.h>
 #include <linux/edd.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index e9f448a..15b5bde 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -24,7 +24,7 @@
  *
  */
 
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -599,4 +599,3 @@ out_open:
 
 	return -EINVAL;
 }
-
diff --git a/include/linux/frame.h b/include/linux/frame.h
deleted file mode 100644
index 303cda6..0000000
--- a/include/linux/frame.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_FRAME_H
-#define _LINUX_FRAME_H
-
-#ifdef CONFIG_STACK_VALIDATION
-/*
- * This macro marks the given function's stack frame as "non-standard", which
- * tells objtool to ignore the function when doing stack metadata validation.
- * It should only be used in special cases where you're 100% sure it won't
- * affect the reliability of frame pointers and kernel stack traces.
- *
- * For more information, see tools/objtool/Documentation/stack-validation.txt.
- */
-#define STACK_FRAME_NON_STANDARD(func) \
-	static void __used __section(.discard.func_stack_frame_non_standard) \
-		*__func_stack_frame_non_standard_##func = func
-
-/*
- * This macro indicates that the following intra-function call is valid.
- * Any non-annotated intra-function call will cause objtool to issue a warning.
- */
-#define ANNOTATE_INTRA_FUNCTION_CALL				\
-	999:							\
-	.pushsection .discard.intra_function_calls;		\
-	.long 999b;						\
-	.popsection;
-
-#else /* !CONFIG_STACK_VALIDATION */
-
-#define STACK_FRAME_NON_STANDARD(func)
-#define ANNOTATE_INTRA_FUNCTION_CALL
-
-#endif /* CONFIG_STACK_VALIDATION */
-
-#endif /* _LINUX_FRAME_H */
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
new file mode 100644
index 0000000..358175c
--- /dev/null
+++ b/include/linux/objtool.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OBJTOOL_H
+#define _LINUX_OBJTOOL_H
+
+#ifdef CONFIG_STACK_VALIDATION
+/*
+ * This macro marks the given function's stack frame as "non-standard", which
+ * tells objtool to ignore the function when doing stack metadata validation.
+ * It should only be used in special cases where you're 100% sure it won't
+ * affect the reliability of frame pointers and kernel stack traces.
+ *
+ * For more information, see tools/objtool/Documentation/stack-validation.txt.
+ */
+#define STACK_FRAME_NON_STANDARD(func) \
+	static void __used __section(.discard.func_stack_frame_non_standard) \
+		*__func_stack_frame_non_standard_##func = func
+
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL				\
+	999:							\
+	.pushsection .discard.intra_function_calls;		\
+	.long 999b;						\
+	.popsection;
+
+#else /* !CONFIG_STACK_VALIDATION */
+
+#define STACK_FRAME_NON_STANDARD(func)
+#define ANNOTATE_INTRA_FUNCTION_CALL
+
+#endif /* CONFIG_STACK_VALIDATION */
+
+#endif /* _LINUX_OBJTOOL_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ed0b357..03e2848 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -25,7 +25,7 @@
 #include <linux/moduleloader.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 #include <linux/rbtree_latch.h>
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c19c0da..c5e5e5a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -36,7 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
-#include <linux/frame.h>
+#include <linux/objtool.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
