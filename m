Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A9DC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373D32073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kWxltBfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgC2JlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49675 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgC2JlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrFG2Qfrz9v0Bm;
        Sun, 29 Mar 2020 11:41:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kWxltBfk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QPY8a36xIR9s; Sun, 29 Mar 2020 11:41:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrFG0608z9v0BM;
        Sun, 29 Mar 2020 11:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474866; bh=eNn5DRDn7C/9pJUU37rtm1dYHf5KRZkxtMgfccvAFn8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=kWxltBfk1HA4+qEaqffeQ208JvA59gL9cs848ojXt3vb19gJTvzlVdqkbb40qHpmK
         B/T4zWhlq+mMGVKhRK7+Slpy/Mg+RQTbov7uwL+SgqIVx8PvEcfiwOYxIBrcoH9fyr
         qSqdOaJY5OivJQtijREn25VAlYBNYALGdF8ikdjs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2B358B770;
        Sun, 29 Mar 2020 11:41:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0dIkw25vn5rS; Sun, 29 Mar 2020 11:41:08 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9D028B752;
        Sun, 29 Mar 2020 11:41:08 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8B41665653; Sun, 29 Mar 2020 09:41:08 +0000 (UTC)
Message-Id: <5cfd9e5721750ba3a5995548f1c1aa491686b8f2.1585474724.git.christophe.leroy@c-s.fr>
In-Reply-To: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 08/12] powerpc/rtas: Remove machine_check_in_rtas()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_check_in_rtas() is just a trap.

Do the trap directly in the machine check exception handler.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 6 ------
 arch/powerpc/kernel/head_32.S  | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index a6371fb8f761..e652f6506888 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1391,10 +1391,4 @@ _GLOBAL(enter_rtas)
 	mtspr	SPRN_SRR0,r8
 	mtspr	SPRN_SRR1,r9
 	RFI			/* return to caller */
-
-	.globl	machine_check_in_rtas
-machine_check_in_rtas:
-	twi	31,0,0
-	/* XXX load up BATs and panic */
-
 #endif /* CONFIG_PPC_RTAS */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index daaa153950c2..cbd30cac2496 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -297,7 +297,7 @@ MachineCheck:
 	cmpwi	cr1, r4, 0
 #endif
 	beq	cr1, machine_check_tramp
-	b	machine_check_in_rtas
+	twi	31, 0, 0
 #else
 	b	machine_check_tramp
 #endif
-- 
2.25.0

