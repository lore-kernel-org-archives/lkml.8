Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD181C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B70D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nY/E0H35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgAXHH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:07:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:46469 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbgAXHHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:07:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483qwT5mPvz9tyWd;
        Fri, 24 Jan 2020 08:07:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nY/E0H35; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eb61aV3emSk8; Fri, 24 Jan 2020 08:07:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483qwT4Ztzz9tyWM;
        Fri, 24 Jan 2020 08:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579849673; bh=7sNJkXXrrR2l09m78IGdGM/V65gmCVpuHAJKsu4TK5w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=nY/E0H35e3j5q9kSynJCW29VBxKp+r5I9zaCY22ZI888zStCb3Q8KEG/YAZEdRZNN
         wdX+EXlvUaL0hsWJGo68tFZ/txIHYTc9SaGqgmm7tUcRRkFV8HRrhc0Q/wb8RAvwDX
         cWeZMmWYP0D+YXz5Bgw2xBfR5IQjxErEwdKTzn2s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8572A8B83D;
        Fri, 24 Jan 2020 08:07:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qUFsSM37Df73; Fri, 24 Jan 2020 08:07:54 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.111])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 64F658B768;
        Fri, 24 Jan 2020 08:07:54 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6358E6379C; Fri, 24 Jan 2020 07:07:54 +0000 (UTC)
Message-Id: <a37e699e7ab897742c07b6838a08af33bc9217e3.1579849665.git.christophe.leroy@c-s.fr>
In-Reply-To: <435e0030e942507766cbef5bc95f906262d2ccf2.1579849665.git.christophe.leroy@c-s.fr>
References: <435e0030e942507766cbef5bc95f906262d2ccf2.1579849665.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/3] powerpc/irq: don't use current_stack_pointer() in
 do_IRQ()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 24 Jan 2020 07:07:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until commit 7306e83ccf5c ("powerpc: Don't use CURRENT_THREAD_INFO to
find the stack"), the current stack base address was obtained by
calling current_thread_info(). That inline function was simply masking
out the value of r1.

In that commit, it was changed to using current_stack_pointer(), which
is an heavier function as it is an outline assembly function which
cannot be inlined and which reads the content of the stack at 0(r1)

Revert to just using get_sp() for geting r1 and masking out its value
to obtain the base address of the stack pointer as before.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 7306e83ccf5c ("powerpc: Don't use CURRENT_THREAD_INFO to find the stack")
---
v2: New in this series. Using get_sp()
---
 arch/powerpc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9333e115418f..193c2b64ce37 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -647,7 +647,7 @@ void do_IRQ(struct pt_regs *regs)
 	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
-	cursp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	cursp = (void *)(get_sp() & ~(THREAD_SIZE - 1));
 	irqsp = hardirq_ctx[raw_smp_processor_id()];
 	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
-- 
2.25.0

