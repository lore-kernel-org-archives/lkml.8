Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35CEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C252072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="A3qsmNly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbgAXRD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:03:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7227 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387710AbgAXRD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:03:57 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48458B3zJfz9v0MC;
        Fri, 24 Jan 2020 18:03:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=A3qsmNly; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PlrBI8ncfS8t; Fri, 24 Jan 2020 18:03:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48458B1zkFz9v0M8;
        Fri, 24 Jan 2020 18:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579885434; bh=mrhcIGGf29wPqKelAuVacdgsgYagP0iavvcKEGj+5FI=;
        h=From:Subject:To:Cc:Date:From;
        b=A3qsmNlyynmqC5scs6xaMpM8BusLtOt/41xLmy7BykDfEOf4zxA3bllbpVQoyOXhk
         Eb+sQYh0jfA/rV3WrY5uwNVoadrNFv5HZHgZrvhPd65yfhokdfuNAydFR/8nJkP5cf
         KZZHCT1tLe8KSp+agMP7XVYhGic0VJP3i5gNbmpI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 680488B86A;
        Fri, 24 Jan 2020 18:03:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FQF1SzBxpfT8; Fri, 24 Jan 2020 18:03:54 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46D5E8B86B;
        Fri, 24 Jan 2020 18:03:49 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3C582651F6; Fri, 24 Jan 2020 17:03:48 +0000 (UTC)
Message-Id: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Add missing context synchronisation with
 CONFIG_VMAP_STACK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 24 Jan 2020 17:03:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reactivation of data translation by modifying MSR[DR], a isync
is required to ensure the translation is effective.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Rebased on powerpc/merge-test

@mpe: If not too late:
- change to head_32.h should be squashed into "powerpc/32: prepare for CONFIG_VMAP_STACK"
- change to head_32.S should be squashed into "powerpc/32s: Enable CONFIG_VMAP_STACK"

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 1 +
 arch/powerpc/kernel/head_32.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index cb7864091641..0493fcac6409 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -277,6 +277,7 @@ MachineCheck:
 #ifdef CONFIG_VMAP_STACK
 	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
 	mtmsr	r11
+	isync
 #endif
 #ifdef CONFIG_PPC_CHRP
 	mfspr	r11, SPRN_SPRG_THREAD
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 73a035b40dbf..a6a5fbbf8504 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -43,6 +43,7 @@
 	.ifeq	\for_rtas
 	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
 	mtmsr	r11
+	isync
 	.endif
 	subi	r11, r1, INT_FRAME_SIZE		/* use r1 if kernel */
 #else
@@ -123,6 +124,7 @@
 #ifdef CONFIG_VMAP_STACK
 	li	r9, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
 	mtmsr	r9
+	isync
 #endif
 	tovirt_vmstack r12, r12
 	tophys_novmstack r11, r11
-- 
2.25.0

