Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD3C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D704924689
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="V8q2DGGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgBZLyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:54:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7417 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgBZLx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:53:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SDjF6jSgz9txVC;
        Wed, 26 Feb 2020 12:53:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=V8q2DGGw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id t871unOA5B4O; Wed, 26 Feb 2020 12:53:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SDjF5h0Yz9txV6;
        Wed, 26 Feb 2020 12:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582718033; bh=6vG0rup5AhQFG+005MTudCeahFqQe+VU9AdxRQQ/uh4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=V8q2DGGwUSQ5X+2OVS145trChFfjKtYwlhvLn3p/ZPgxVgBTibx5ctohaZZ+BWOQ+
         fRmTEHCGzaUjleTAWvQk6YSqfOUMikWtDnBHqrOycnDPkaf9kdh5cEk4UA5myVTTOo
         z8HBVhwkQubPNcv7fRqvjQnAegT2U+tjMWSwJaxY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DAB08B847;
        Wed, 26 Feb 2020 12:53:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4x-3og4IaD_W; Wed, 26 Feb 2020 12:53:54 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B27198B776;
        Wed, 26 Feb 2020 12:53:54 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8ABDA65400; Wed, 26 Feb 2020 11:53:54 +0000 (UTC)
Message-Id: <6dac2b49207647f75cbf0e6771a545e691f0fd93.1582717645.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1582717645.git.christophe.leroy@c-s.fr>
References: <cover.1582717645.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 04/13] powerpc/ptrace: drop PARAMETER_SAVE_AREA_OFFSET
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 26 Feb 2020 11:53:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PARAMETER_SAVE_AREA_OFFSET is not used, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/ptrace.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 3dd94c296ac7..22826c942eae 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -33,16 +33,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/*
- * The parameter save area on the stack is used to store arguments being passed
- * to callee function and is located at fixed offset from stack pointer.
- */
-#ifdef CONFIG_PPC32
-#define PARAMETER_SAVE_AREA_OFFSET	24  /* bytes */
-#else /* CONFIG_PPC32 */
-#define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
-#endif
-
 struct pt_regs_offset {
 	const char *name;
 	int offset;
-- 
2.25.0

