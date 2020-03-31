Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF34C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D07212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BCXQU88e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgCaQEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:04:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14897 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgCaQDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdj348Kz9twdX;
        Tue, 31 Mar 2020 18:03:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BCXQU88e; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id M_F69GJ2S8CV; Tue, 31 Mar 2020 18:03:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdj1y8Fz9twdT;
        Tue, 31 Mar 2020 18:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670617; bh=s4fgZNE21fk07dfy8L9ZfeUugmrhM/7jqo4Mqhh8ugc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=BCXQU88ehVMJf8FvnevA/JSgzSOsNAfYYlZLJEtSBxUK69J28KJo36+7mvf6BITsf
         9JX6RFwAWxfCOl4h2SJIG31xLnAQFeVQiEmHM7XV0xDOnCDDWDAdmcXWbEP2f1O7wJ
         DudSRmsDCsQB8AOdXem7s1Z8LmBbIYLY/IZHk+Kg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B0D208B86B;
        Tue, 31 Mar 2020 18:03:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rCS9AIcjsD0w; Tue, 31 Mar 2020 18:03:38 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62A4B8B752;
        Tue, 31 Mar 2020 18:03:38 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 53303656AC; Tue, 31 Mar 2020 16:03:38 +0000 (UTC)
Message-Id: <3ac4ab8dd7008b9706d9228a60645a1756fa84bf.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/12] powerpc/83xx: Blacklist mpc83xx_deep_resume() for
 kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/83xx/suspend-asm.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/83xx/suspend-asm.S b/arch/powerpc/platforms/83xx/suspend-asm.S
index 3acd7470dc5e..bc6bd4d0ae96 100644
--- a/arch/powerpc/platforms/83xx/suspend-asm.S
+++ b/arch/powerpc/platforms/83xx/suspend-asm.S
@@ -548,3 +548,4 @@ mpc83xx_deep_resume:
 	mtdec	r0
 
 	rfi
+_ASM_NOKPROBE_SYMBOL(mpc83xx_deep_resume)
-- 
2.25.0

