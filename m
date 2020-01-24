Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C92AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218B420718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uG8LkU4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgAXHHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:07:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52473 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAXHHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:07:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483qwR70nhz9tyWR;
        Fri, 24 Jan 2020 08:07:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uG8LkU4w; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LKF188HDJ8Kb; Fri, 24 Jan 2020 08:07:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483qwR5qSTz9tyWM;
        Fri, 24 Jan 2020 08:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579849671; bh=PerBBHHcPcD64QxBFQtP7ChNSh/ByrU17mdch6v1v7k=;
        h=From:Subject:To:Cc:Date:From;
        b=uG8LkU4wYSWErWCVn6oQedMwCcneAv6ilzQ0+1X9I5sxmLx1dRABee1BngJ4kpdTQ
         5KV/54GrQbUmxwiPxJNIKRNvuYl9bRmLBoTjm2eUJYcRpK5226yzhNPfOoYf7T6iJK
         l8+ytotvoMcFkEdGGnATjOyyq/sUTG5IoWUm3AEQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E1F98B83D;
        Fri, 24 Jan 2020 08:07:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JzumcI8_-fUR; Fri, 24 Jan 2020 08:07:52 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.111])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AC798B768;
        Fri, 24 Jan 2020 08:07:52 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4F56D6379C; Fri, 24 Jan 2020 07:07:52 +0000 (UTC)
Message-Id: <435e0030e942507766cbef5bc95f906262d2ccf2.1579849665.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/3] powerpc/irq: don't use current_stack_pointer() in
 check_stack_overflow()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 24 Jan 2020 07:07:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_stack_pointer() doesn't return the stack pointer, but the
caller's stack frame. See commit bfe9a2cfe91a ("powerpc: Reimplement
__get_SP() as a function not a define") and commit acf620ecf56c
("powerpc: Rename __get_SP() to current_stack_pointer()") for details.

The purpose of check_stack_overflow() is to verify that the stack has
not overflowed.

To really know whether the stack pointer is still within boundaries,
the check must be done directly on the value of r1.

Define a get_sp() macro to get the value of r1 directly. (Adapted from
arch/powerpc/boot/reg.h)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: Define a get_sp() macro instead of using asm("r1") locally.
---
 arch/powerpc/include/asm/reg.h | 3 +++
 arch/powerpc/kernel/irq.c      | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1aa46dff0957..d585f2566338 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1450,6 +1450,9 @@ static inline void mtsrin(u32 val, u32 idx)
 
 extern unsigned long current_stack_pointer(void);
 
+register unsigned long __stack_pointer asm("r1");
+#define get_sp()	(__stack_pointer)
+
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index add67498c126..cd29c2eb2d8e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -601,7 +601,7 @@ static inline void check_stack_overflow(void)
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	long sp;
 
-	sp = current_stack_pointer() & (THREAD_SIZE-1);
+	sp = get_sp() & (THREAD_SIZE - 1);
 
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(sp < 2048)) {
-- 
2.25.0

