Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38AAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC49A20659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dT3wxCH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgDERos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:44:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23029 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDERoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:44:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wLf134Cmz9ty3G;
        Sun,  5 Apr 2020 19:44:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dT3wxCH1; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DGeDWB6g3opG; Sun,  5 Apr 2020 19:44:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wLf123G8z9ty2y;
        Sun,  5 Apr 2020 19:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586108681; bh=zLuYf+7Km/Hj3g2gh34/z615PspqReQ7BYQSaRHeRPY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dT3wxCH1tYT6ZVbkeWILv7/0xxSCiGzdsQzpQzeaC6LDY4L07E/Dg+5tGMPk3HMpc
         j03hNnh8LRp9DKdE7uFM4BDZqnwHarRmmrD8Sw+MbheEVU7IbJlnMJRBsM3WTXNg/c
         hZE+jehW1wRuglF783m8luA/xCVsFi2ka52VWRd0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D83188B783;
        Sun,  5 Apr 2020 19:44:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id s5SakeYdHLfQ; Sun,  5 Apr 2020 19:44:44 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A33148B774;
        Sun,  5 Apr 2020 19:44:44 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 764926571C; Sun,  5 Apr 2020 17:44:44 +0000 (UTC)
Message-Id: <7ca977e2a82c1992a98fe7e5d8669460177cd78b.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 09/13] powerpc/syscall: Selectively check MSR_RI and
 MSR_PR on syscall entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  5 Apr 2020 17:44:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In system_call_exception(), MSR_RI needs to also be checked on 8xx.
Only book3e doesn't have MSR_RI.

On PPC32, MSR_PR is checked in real mode to avoid clobbering the
stack, so no need to check and panic in system_call_exception().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 986489ea9fb4..69d75fc4a5eb 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -36,9 +36,9 @@ notrace long system_call_exception(long r3, long r4, long r5,
 
 	trace_hardirqs_off(); /* finish reconciling */
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
+	if (!IS_ENABLED(CONFIG_PPC_BOOK3E))
 		BUG_ON(!(regs->msr & MSR_RI));
-	BUG_ON(!(regs->msr & MSR_PR));
+	BUG_ON(IS_ENABLED(CONFIG_PPC64) && !(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
 #ifdef CONFIG_PPC64
 	BUG_ON(regs->softe != IRQS_ENABLED);
-- 
2.25.0

