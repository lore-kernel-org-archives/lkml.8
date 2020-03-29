Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B08C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472822073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Sf8zrvd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgC2JlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39885 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgC2JlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrFJ1NPwz9v0Cf;
        Sun, 29 Mar 2020 11:41:08 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Sf8zrvd4; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bwRwM-iJzW9J; Sun, 29 Mar 2020 11:41:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrFJ0NT4z9v0Bs;
        Sun, 29 Mar 2020 11:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474868; bh=EAN9wu96hIOOs9Jxj5AMmN+BQRhi9IaXixrZRhz2y4s=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Sf8zrvd4GZj8YvZu6ZqZIJU7UDFOSrHwkP5vxG+IMQoNlAFG1++PYHXlgndT5WFZw
         JVCfTtpNjEq1nPOz5DwEBALdwLo0U8MbQkDVqXGMAF+H+HPueE8TUIwB0f+vvx0ycQ
         nehAbJs5KPdN0qUO8YxtAXCNuoOSVAEvq0bPFM/w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 05D818B770;
        Sun, 29 Mar 2020 11:41:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lqb_UcoigZK2; Sun, 29 Mar 2020 11:41:10 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C70828B752;
        Sun, 29 Mar 2020 11:41:10 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 97ED565653; Sun, 29 Mar 2020 09:41:10 +0000 (UTC)
Message-Id: <aea027844b12fcbc29ea78d26c5848a6794d1688.1585474724.git.christophe.leroy@c-s.fr>
In-Reply-To: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 10/12] powerpc/entry32: Blacklist exception entry points for
 kprobe.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode.

As exception entry points are running with MMU disabled,
blacklist them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 94f78c03cb79..9a1a45d6038a 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -51,6 +51,7 @@ mcheck_transfer_to_handler:
 	mfspr	r0,SPRN_DSRR1
 	stw	r0,_DSRR1(r11)
 	/* fall through */
+_ASM_NOKPROBE_SYMBOL(mcheck_transfer_to_handler)
 
 	.globl	debug_transfer_to_handler
 debug_transfer_to_handler:
@@ -59,6 +60,7 @@ debug_transfer_to_handler:
 	mfspr	r0,SPRN_CSRR1
 	stw	r0,_CSRR1(r11)
 	/* fall through */
+_ASM_NOKPROBE_SYMBOL(debug_transfer_to_handler)
 
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
@@ -94,6 +96,7 @@ crit_transfer_to_handler:
 	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
+_ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
 #endif
 
 #ifdef CONFIG_40x
@@ -115,6 +118,7 @@ crit_transfer_to_handler:
 	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
+_ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
 #endif
 
 /*
@@ -127,6 +131,7 @@ crit_transfer_to_handler:
 	.globl	transfer_to_handler_full
 transfer_to_handler_full:
 	SAVE_NVGPRS(r11)
+_ASM_NOKPROBE_SYMBOL(transfer_to_handler_full)
 	/* fall through */
 
 	.globl	transfer_to_handler
@@ -286,6 +291,8 @@ reenable_mmu:
 	lwz	r2, GPR2(r11)
 	b	fast_exception_return
 #endif
+_ASM_NOKPROBE_SYMBOL(transfer_to_handler)
+_ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 
 #ifndef CONFIG_VMAP_STACK
 /*
-- 
2.25.0

