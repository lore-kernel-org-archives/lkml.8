Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF7AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EC9214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VoaClWUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:21:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28248 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgBGRVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:21:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48DhsP26gbzB09Zr;
        Fri,  7 Feb 2020 18:20:57 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VoaClWUr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id e1C3b03JzNBL; Fri,  7 Feb 2020 18:20:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48DhsP160HzB09Zp;
        Fri,  7 Feb 2020 18:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581096057; bh=QmgAwYNt3Y3elDYjH3yl1rB9CCdQ07RGLgxMITM3Uwk=;
        h=From:Subject:To:Cc:Date:From;
        b=VoaClWUr9iEnxwlTALSGavZ19/VKbqxRqNmemnN+MqFhj4X9peSsCs5l6R52BydRq
         c4Oq9vOmzA64RK6ekwrju3kJ3W8V07Xx8xHyGOKyhu8thXfIC0fUu76AZHgjJJCoQt
         TW+TXNhhw/QNZUhUIFS8tWK0fj/UOWgCynQLS2+M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB85F8B8DB;
        Fri,  7 Feb 2020 18:20:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JdGYIXlNYGc2; Fri,  7 Feb 2020 18:20:58 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B0DDD8B8BA;
        Fri,  7 Feb 2020 18:20:58 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 29631652C9; Fri,  7 Feb 2020 17:20:57 +0000 (UTC)
Message-Id: <daeacdc0dec0416d1c587cc9f9e7191ad3068dc0.1581095957.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: Fix CONFIG_TRACE_IRQFLAGS with CONFIG_VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 Feb 2020 17:20:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROVE_LOCKING is selected together with (now default)
CONFIG_VMAP_STACK, kernel enter deadlock during boot.

At the point of checking whether interrupts are enabled or not, the
value of MSR saved on stack is read using the physical address of the
stack. But at this point, when using VMAP stack the DATA MMU
translation has already been re-enabled, leading to deadlock.

Don't use the physical address of the stack when
CONFIG_VMAP_STACK is set.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 028474876f47 ("powerpc/32: prepare for CONFIG_VMAP_STACK")
---
 arch/powerpc/kernel/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 77abbc34bbe0..0713daa651d9 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -214,7 +214,7 @@ transfer_to_handler_cont:
 	 * To speed up the syscall path where interrupts stay on, let's check
 	 * first if we are changing the MSR value at all.
 	 */
-	tophys(r12, r1)
+	tophys_novmstack r12, r1
 	lwz	r12,_MSR(r12)
 	andi.	r12,r12,MSR_EE
 	bne	1f
-- 
2.25.0

