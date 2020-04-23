Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43869C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C4321582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgDWHuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgDWHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B00C03C1AB;
        Thu, 23 Apr 2020 00:49:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcJ-0008SA-1W; Thu, 23 Apr 2020 09:49:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64FAA1C047B;
        Thu, 23 Apr 2020 09:49:44 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:44 -0000
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Split out arch-specific CFI definitions
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158762818401.28353.4361966704110954019.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6f8ca67683962d408c7a337664212669bd3e8355
Gitweb:        https://git.kernel.org/tip/6f8ca67683962d408c7a337664212669bd3e8355
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 27 Mar 2020 15:28:46 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:49 +02:00

objtool: Split out arch-specific CFI definitions

Some CFI definitions used by generic objtool code have no reason to vary
from one architecture to another.  Keep those definitions in generic
code and move the arch-specific ones to a new arch-specific header.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/Makefile                    |  3 ++-
 tools/objtool/arch/x86/include/cfi_regs.h | 25 ++++++++++++++++++++++-
 tools/objtool/cfi.h                       | 21 +-----------------
 3 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d1ab0cc..6b91388 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,8 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/arch/$(SRCARCH)/include
+	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
+	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
new file mode 100644
index 0000000..79bc517
--- /dev/null
+++ b/tools/objtool/arch/x86/include/cfi_regs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_AX			0
+#define CFI_DX			1
+#define CFI_CX			2
+#define CFI_BX			3
+#define CFI_SI			4
+#define CFI_DI			5
+#define CFI_BP			6
+#define CFI_SP			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_RA			16
+#define CFI_NUM_REGS		17
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index 4427bf8..1a3e7b8 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -6,30 +6,13 @@
 #ifndef _OBJTOOL_CFI_H
 #define _OBJTOOL_CFI_H
 
+#include "cfi_regs.h"
+
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
 #define CFI_SP_INDIRECT		-3
 #define CFI_BP_INDIRECT		-4
 
-#define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
-#define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
-#define CFI_R8			8
-#define CFI_R9			9
-#define CFI_R10			10
-#define CFI_R11			11
-#define CFI_R12			12
-#define CFI_R13			13
-#define CFI_R14			14
-#define CFI_R15			15
-#define CFI_RA			16
-#define CFI_NUM_REGS		17
-
 struct cfi_reg {
 	int base;
 	int offset;
