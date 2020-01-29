Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18179C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA061206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="By0dBFVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgA2TuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:50:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21089 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbgA2TuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:50:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 487Dbk13KPz9v6Mk;
        Wed, 29 Jan 2020 20:50:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=By0dBFVu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q7PoxufizGrV; Wed, 29 Jan 2020 20:50:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 487Dbh6Ts9z9v6Mj;
        Wed, 29 Jan 2020 20:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580327408; bh=omfaf4XjOg/DOAMNgBIrA90fdsNIo9S16aDDtammHcA=;
        h=From:Subject:To:Cc:Date:From;
        b=By0dBFVu+gRnHvvbFgvwb0hK9EM/9M3ZV9pXAzO4uq1mvKF5B923cg00oWd7FvKqU
         FWo6Pgv3cHXhgpmfwU1c3ldxXmPDxSlO7wYDUNyzpxZabYjPw9aPWi9DtocJ7lVzo2
         JXx/ckC0U3jWeUbMhdXV0QjObPbhOMCzzUmi5e3A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD4468B82F;
        Wed, 29 Jan 2020 20:50:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yox7VE7PLePX; Wed, 29 Jan 2020 20:50:08 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FFE78B829;
        Wed, 29 Jan 2020 20:50:08 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 095696524E; Wed, 29 Jan 2020 19:50:07 +0000 (UTC)
Message-Id: <6ecbda05b4119c40222dc8ec284604e1597c9bff.1580327381.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/process: Remove unneccessary #ifdef CONFIG_PPC64 in
 copy_thread_tls()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 29 Jan 2020 19:50:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_32bit_task() exists on both PPC64 and PPC32, no need of an ifdefery.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fad50db9dcf2..e730b8e522b0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1634,11 +1634,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 		p->thread.regs = childregs;
 		childregs->gpr[3] = 0;  /* Result from fork() */
 		if (clone_flags & CLONE_SETTLS) {
-#ifdef CONFIG_PPC64
 			if (!is_32bit_task())
 				childregs->gpr[13] = tls;
 			else
-#endif
 				childregs->gpr[2] = tls;
 		}
 
-- 
2.25.0

