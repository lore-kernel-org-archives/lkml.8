Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35CFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731FF206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BeXjt4ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgCaQDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:03:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21148 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgCaQDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdg29KCz9twdV;
        Tue, 31 Mar 2020 18:03:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BeXjt4ut; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0PdTXi77vLjH; Tue, 31 Mar 2020 18:03:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdg0n23z9twdT;
        Tue, 31 Mar 2020 18:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670615; bh=jr6C836d6/K+QMPMhDUcw03Ae25ZLJxgX2gqBs7HA5s=;
        h=From:Subject:To:Cc:Date:From;
        b=BeXjt4utb5qUj+kYChi9T2UI4MDNHG3pDSE7OnJV38cZ/1qm4NJBKCq2sX8MUkTft
         V9yI5dv36rNBfrQoGumHIx6JQkdnRmLOOd+MQai/1OA0stjYYWz2vKpIt2ls5GBnVm
         75NhBYvtETTk0d6ztJZ/mpxK+EmIAVr0T/ZAWKsk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B37AB8B868;
        Tue, 31 Mar 2020 18:03:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZouzspUcVyRt; Tue, 31 Mar 2020 18:03:36 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58BBF8B752;
        Tue, 31 Mar 2020 18:03:36 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 43508656AC; Tue, 31 Mar 2020 16:03:36 +0000 (UTC)
Message-Id: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/12] powerpc/52xx: Blacklist functions running with MMU
 disabled for kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/52xx/lite5200_sleep.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/lite5200_sleep.S b/arch/powerpc/platforms/52xx/lite5200_sleep.S
index 3a9969c429b3..70083649c9ea 100644
--- a/arch/powerpc/platforms/52xx/lite5200_sleep.S
+++ b/arch/powerpc/platforms/52xx/lite5200_sleep.S
@@ -248,6 +248,7 @@ mmu_on:
 
 
 	blr
+_ASM_NOKPROBE_SYMBOL(lite5200_wakeup)
 
 
 /* ---------------------------------------------------------------------- */
@@ -391,6 +392,7 @@ restore_regs:
 	LOAD_SPRN(TBWU,  0x5b);
 
 	blr
+_ASM_NOKPROBE_SYMBOL(restore_regs)
 
 
 
-- 
2.25.0

