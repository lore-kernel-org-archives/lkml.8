Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4455C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765FD246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cCmVfgWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgB1AOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:14:44 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60999 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgB1AOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:14:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48T95Y4c3sz9tyJc;
        Fri, 28 Feb 2020 01:14:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cCmVfgWZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fg8Z_dmJUoFf; Fri, 28 Feb 2020 01:14:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48T95Y3Spdz9tyJb;
        Fri, 28 Feb 2020 01:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582848881; bh=/xGAlSMxsbbK8Cs3mxqn4uvtWXswsjZq2+zN+Vo5MFY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=cCmVfgWZwlY4wVl2W9ZRiGvqrKOnPCT6GNloBnH57eOH9XNtNe6ZEF0pgdxWzIzSA
         U0653OD7DMQeJ8expIlX//dNgVJ7L76TfzkpyIiUNZqthLjNbybqrJyb/lacvlozXX
         l9TYfnd+H4mUapxK9emK9ThCF8EmrrCrMeA/Ts6I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA4378B881;
        Fri, 28 Feb 2020 01:14:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cr6emkYs4mFV; Fri, 28 Feb 2020 01:14:41 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C1008B799;
        Fri, 28 Feb 2020 01:14:39 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7F92B65403; Fri, 28 Feb 2020 00:14:37 +0000 (UTC)
Message-Id: <9ebcbe37834e9d447dd97f4381084795a673260c.1582848567.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1582848567.git.christophe.leroy@c-s.fr>
References: <cover.1582848567.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 01/13] powerpc: move ptrace into a subdirectory.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Feb 2020 00:14:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow splitting of ptrace depending on the
different CONFIG_ options, create a subdirectory dedicated to
ptrace and move ptrace.c and ptrace32.c into it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/Makefile                | 7 +++----
 arch/powerpc/kernel/ptrace/Makefile         | 9 +++++++++
 arch/powerpc/kernel/{ => ptrace}/ptrace.c   | 0
 arch/powerpc/kernel/{ => ptrace}/ptrace32.c | 0
 4 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/Makefile
 rename arch/powerpc/kernel/{ => ptrace}/ptrace.c (100%)
 rename arch/powerpc/kernel/{ => ptrace}/ptrace32.c (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 78a1b22d4fd8..d812d7760e50 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,8 +3,6 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
-
 ifdef CONFIG_PPC64
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
 endif
@@ -41,15 +39,16 @@ CFLAGS_cputable.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y				:= cputable.o ptrace.o syscalls.o \
+obj-y				:= cputable.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o
+obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
-				   signal_64.o ptrace32.o \
+				   signal_64.o \
 				   paca.o nvram_64.o firmware.o note.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
new file mode 100644
index 000000000000..02fb28eb3b55
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+
+obj-y				+= ptrace.o
+obj-$(CONFIG_PPC64)		+= ptrace32.o
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
similarity index 100%
rename from arch/powerpc/kernel/ptrace.c
rename to arch/powerpc/kernel/ptrace/ptrace.c
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace/ptrace32.c
similarity index 100%
rename from arch/powerpc/kernel/ptrace32.c
rename to arch/powerpc/kernel/ptrace/ptrace32.c
-- 
2.25.0

