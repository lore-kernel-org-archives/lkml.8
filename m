Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B073C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F2C24693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="F+89lzO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgB0LtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:49:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34710 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgB0LtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:49:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SrYK59z8z9tyj6;
        Thu, 27 Feb 2020 12:49:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=F+89lzO2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uBLJNqdVR22r; Thu, 27 Feb 2020 12:49:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SrYK44ryz9tyhM;
        Thu, 27 Feb 2020 12:49:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582804149; bh=VgMuq2wX8mbn+y/Awc3vwO6firKTtF6E52gAdT5jeTc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=F+89lzO24xUsyILNd7yDpwEkvmm4pOa/Jz47Ilpgb0lU7l1NnTxDkzao/+kVMG+d4
         gjoocxGwmB7rUKK+B4i7MA8vh9uogA7ui4v25RH5tFzb4dw7KsFhtH3lZPh1UuRPOk
         MiTqzXp+hsekYmC3S9URxycReias/mt8+GH9APJs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBF928B872;
        Thu, 27 Feb 2020 12:49:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZYPtMti6oLRY; Thu, 27 Feb 2020 12:49:10 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FE6F8B799;
        Thu, 27 Feb 2020 12:49:10 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 57DCC65402; Thu, 27 Feb 2020 11:49:10 +0000 (UTC)
Message-Id: <d45c91cf5f83424b8f3989b7ead28c50d8d765a9.1582803998.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1582803998.git.christophe.leroy@c-s.fr>
References: <cover.1582803998.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 13/13] powerpc/ptrace: move ptrace_triggered() into
 hw_breakpoint.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Feb 2020 11:49:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_triggered() is declared in asm/hw_breakpoint.h and
only needed when CONFIG_HW_BREAKPOINT is set, so move it
into hw_breakpoint.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v4: removing inclusing of hw_breakpoint.h now. Previously it was done too early.
---
 arch/powerpc/kernel/hw_breakpoint.c | 16 ++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c | 19 -------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 2462cd7c565c..2c0be9d941cf 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -427,3 +427,19 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
 {
 	/* TODO */
 }
+
+void ptrace_triggered(struct perf_event *bp,
+		      struct perf_sample_data *data, struct pt_regs *regs)
+{
+	struct perf_event_attr attr;
+
+	/*
+	 * Disable the breakpoint request here since ptrace has defined a
+	 * one-shot behaviour for breakpoint exceptions in PPC64.
+	 * The SIGTRAP signal is generated automatically for us in do_dabr().
+	 * We don't have to do anything about that here
+	 */
+	attr = bp->attr;
+	attr.disabled = true;
+	modify_user_hw_breakpoint(bp, &attr);
+}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index a44f6e5e05ff..f6e51be47c6e 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -18,7 +18,6 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/audit.h>
-#include <linux/hw_breakpoint.h>
 #include <linux/context_tracking.h>
 #include <linux/syscalls.h>
 
@@ -31,24 +30,6 @@
 
 #include "ptrace-decl.h"
 
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-void ptrace_triggered(struct perf_event *bp,
-		      struct perf_sample_data *data, struct pt_regs *regs)
-{
-	struct perf_event_attr attr;
-
-	/*
-	 * Disable the breakpoint request here since ptrace has defined a
-	 * one-shot behaviour for breakpoint exceptions in PPC64.
-	 * The SIGTRAP signal is generated automatically for us in do_dabr().
-	 * We don't have to do anything about that here
-	 */
-	attr = bp->attr;
-	attr.disabled = true;
-	modify_user_hw_breakpoint(bp, &attr);
-}
-#endif /* CONFIG_HAVE_HW_BREAKPOINT */
-
 /*
  * Called by kernel/ptrace.c when detaching..
  *
-- 
2.25.0

