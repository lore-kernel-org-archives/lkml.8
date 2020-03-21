Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50504C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A332072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WvlWrorl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgCUKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:37:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30741 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgCUKh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:37:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48kxst1vZdz9v26c;
        Sat, 21 Mar 2020 11:37:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WvlWrorl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dV6ZTpKe0rJh; Sat, 21 Mar 2020 11:37:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48kxst0j1Mz9v26D;
        Sat, 21 Mar 2020 11:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584787042; bh=8dNFekUvF26E/zA1FpkQASGFZrLQ7xw2bJ/GI3qh8iI=;
        h=From:Subject:To:Cc:Date:From;
        b=WvlWrorlU+XIPJ9tLAHV0CI4dnTs9hnGB2sYjUE/W9bIQZm0jkCGnau6ejoiTRaOI
         K8z2yiyMCKYjCfC1WeeKP2R+WbqsWRQZpn28TyHpEVJFW3Gija9CgYT/spm3yitRig
         cmbjF4ciUZo8cez30CSI5SJgXJlhz1H/DYOEpwzE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2571E8B774;
        Sat, 21 Mar 2020 11:37:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zOeJedXCgpaI; Sat, 21 Mar 2020 11:37:18 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CC848B752;
        Sat, 21 Mar 2020 11:37:17 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2B5BB655CB; Sat, 21 Mar 2020 10:37:17 +0000 (UTC)
Message-Id: <5558d8c22ff0ed03cb5392798564dd203bd68501.1584787012.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/ptrace: Fix ptrace-hwbreak selftest failure
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 21 Mar 2020 10:37:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pieces of commit c3f68b0478e7 ("powerpc/watchpoint: Fix ptrace
code that muck around with address/len") disappeared with
commit 53387e67d003 ("powerpc/ptrace: split out ADV_DEBUG_REGS
related functions.").

Restore them.

Fixes: 53387e67d003 ("powerpc/ptrace: split out ADV_DEBUG_REGS related functions.")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index cf05fadba0d5..d4170932acb4 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -153,7 +153,7 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
-	brk.address = bp_info->addr & ~7UL;
+	brk.address = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
 	brk.type = HW_BRK_TYPE_TRANSLATE;
 	brk.len = DABR_MAX_LEN;
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
@@ -161,10 +161,6 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
 		brk.type |= HW_BRK_TYPE_WRITE;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	/*
-	 * Check if the request is for 'range' breakpoints. We can
-	 * support it if range < 8 bytes.
-	 */
 	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
 		len = bp_info->addr2 - bp_info->addr;
 	else if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
@@ -177,7 +173,7 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
 
 	/* Create a new breakpoint request if one doesn't exist already */
 	hw_breakpoint_init(&attr);
-	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
+	attr.bp_addr = (unsigned long)bp_info->addr;
 	attr.bp_len = len;
 	arch_bp_generic_fields(brk.type, &attr.bp_type);
 
-- 
2.25.0

