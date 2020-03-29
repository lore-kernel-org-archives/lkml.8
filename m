Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1713CC2D0E7
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D779520732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sUMgP603"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgC2JlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16391 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgC2JlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:05 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrF872kMz9tyY2;
        Sun, 29 Mar 2020 11:41:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sUMgP603; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0zTLtzioxc7a; Sun, 29 Mar 2020 11:41:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrF85qTfz9tyXy;
        Sun, 29 Mar 2020 11:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474860; bh=K7HluQgRz2kSy70uO4u2iqL9+TKRo7ka4mDmZnfUrOU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=sUMgP6031PS5QUeT/rMZsEZ0VnKpN7H1rXob+eZC070cbqOnj2J7o7OzPjDvutnqv
         FVHNClLMJmIjuw+5mi2w3GUGeep7Nvtqhk5l2hp72MZmVIMp+0mYTP2mLQTihuATz6
         hZ77f5hG+fDhtidVmCBy2dZa4LJ6qUlHzoD6zGu0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BDDF48B770;
        Sun, 29 Mar 2020 11:41:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Oe7WNf2cKtin; Sun, 29 Mar 2020 11:41:03 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E1CC8B752;
        Sun, 29 Mar 2020 11:41:03 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6181F65653; Sun, 29 Mar 2020 09:41:03 +0000 (UTC)
Message-Id: <da8c04702ffd13073a5d24cacab234297c47d138.1585474724.git.christophe.leroy@c-s.fr>
In-Reply-To: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 03/12] powerpc/83xx: Blacklist mpc83xx_deep_resume() for
 kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
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

