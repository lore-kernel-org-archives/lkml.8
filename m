Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111EBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8A206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VoaVuywh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgCaQDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:03:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35314 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731270AbgCaQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdp2NH7z9twdW;
        Tue, 31 Mar 2020 18:03:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VoaVuywh; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6YysAR21lhVX; Tue, 31 Mar 2020 18:03:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdp1M75z9twdT;
        Tue, 31 Mar 2020 18:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670622; bh=OYEgyqYCSbP3aCV8XAeI9zykMgj+YwbsQ71DptZ1Kkc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VoaVuywhNAjOTTpytnq+f0ZvjweJ6G1aQqWN+k/WlF2pDFf37ciegpnbttutzQlJR
         00J8oBykBcQT1QARfAccFKXisra33kLtxKg5MBwvJ1xKfKIG0bB3DjLhCCFvirqrC2
         sGzs06nxokrgRMlZUEeLPla7yj4NPO6RMTwEz3mw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB9FA8B868;
        Tue, 31 Mar 2020 18:03:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id D1PC6GqoT1xO; Tue, 31 Mar 2020 18:03:43 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 842648B752;
        Tue, 31 Mar 2020 18:03:43 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 73D87656AC; Tue, 31 Mar 2020 16:03:43 +0000 (UTC)
Message-Id: <78899f40f89cb3c4f69bdff7f04eb6ec7cb753d5.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/12] powerpc/rtas: Remove machine_check_in_rtas()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_check_in_rtas() is just a trap.

Do the trap directly in the machine check exception handler.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
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

