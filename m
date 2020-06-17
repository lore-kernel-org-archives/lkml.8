Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6632098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFQOg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgFQOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:36:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843BC06179B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:36:50 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:b57b:2191:a081:571d])
        by xavier.telenet-ops.be with bizsmtp
        id sEcm2200K1Jlgh201EcmLE; Wed, 17 Jun 2020 16:36:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlZBG-0007pl-NJ; Wed, 17 Jun 2020 16:36:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlZBG-0004mO-LU; Wed, 17 Jun 2020 16:36:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/9] Revert "sh: add loglvl to printk_address()"
Date:   Wed, 17 Jun 2020 16:36:32 +0200
Message-Id: <20200617143639.18315-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
References: <20200617143639.18315-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2deebe4d56d638269a4a728086d64de5734b460a.

printk_address() is always used as a continuation of the previous
logging, hence it should not include a log level.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/sh/include/asm/kdebug.h | 3 +--
 arch/sh/kernel/dumpstack.c   | 6 +++---
 arch/sh/mm/fault.c           | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/kdebug.h b/arch/sh/include/asm/kdebug.h
index 960545306afa4d93..de8693fabb1d95b5 100644
--- a/arch/sh/include/asm/kdebug.h
+++ b/arch/sh/include/asm/kdebug.h
@@ -12,8 +12,7 @@ enum die_val {
 };
 
 /* arch/sh/kernel/dumpstack.c */
-extern void printk_address(unsigned long address, int reliable,
-			   const char *loglvl);
+extern void printk_address(unsigned long address, int reliable);
 extern void dump_mem(const char *str, const char *loglvl,
 		     unsigned long bottom, unsigned long top);
 
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index a13c045804ed1027..ad548fc976350c50 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -44,9 +44,9 @@ void dump_mem(const char *str, const char *loglvl,
 	}
 }
 
-void printk_address(unsigned long address, int reliable, const char *loglvl)
+void printk_address(unsigned long address, int reliable)
 {
-	printk("%s [<%p>] %s%pS\n", loglvl, (void *) address,
+	printk(" [<%p>] %s%pS\n", (void *) address,
 			reliable ? "" : "? ", (void *) address);
 }
 
@@ -118,7 +118,7 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk_address(addr, reliable, (char *)data);
+	printk_address(addr, reliable);
 }
 
 static const struct stacktrace_ops print_trace_ops = {
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index acd1c75994983825..92b1ce105f4b6c6f 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -213,7 +213,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
 				     : "paging request",
 		 address);
 	pr_alert("PC:");
-	printk_address(regs->pc, 1, KERN_ALERT);
+	printk_address(regs->pc, 1);
 
 	show_pte(NULL, address);
 }
-- 
2.17.1

