Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626FB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="K+4GfYRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392769AbgDOO5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:57:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53661 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390410AbgDOO5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:57:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 492QS61xD1z9v13t;
        Wed, 15 Apr 2020 16:57:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=K+4GfYRW; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l7_0scJaQh56; Wed, 15 Apr 2020 16:57:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 492QS60phYz9v13r;
        Wed, 15 Apr 2020 16:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586962630; bh=1Xb7ETTN09xsr/258GQZjtHOSSD6VgHkXQ6yunhYxr8=;
        h=From:Subject:To:Cc:Date:From;
        b=K+4GfYRWGpfU2GiiSNnqBM6cOtyEfZMohzRvwcz+6rYZ1mvFtIh8UtmpW1x1GJO6n
         UtWLVXsYPMY2wURgbUiSDVcc86+3acIZ+S2EdpNXT8mrsrEE9Doiz9hPsQVKBdvg1H
         5dPpa32TC8c5gFI9XS5lj20WbeDFn9UFbKiryqY4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E2918BB6C;
        Wed, 15 Apr 2020 16:57:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kOjgO8qiAm7j; Wed, 15 Apr 2020 16:57:11 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F59F8B931;
        Wed, 15 Apr 2020 16:57:11 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 05A9E6578F; Wed, 15 Apr 2020 14:57:11 +0000 (UTC)
Message-Id: <1492bb150c1aaa53d99a604b49992e60ea20cd5f.1586962582.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/uaccess: Don't set KUEP by default on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 15 Apr 2020 14:57:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On book3s/32, KUEP is an heavy process as it requires to
set/unset the NX bit in each of the 12 user segments
everytime the kernel is entered/exited from/to user space.

Don't select KUEP by default on book3s/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0c7151c98b56..11412078e732 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -377,7 +377,7 @@ config PPC_HAVE_KUEP
 config PPC_KUEP
 	bool "Kernel Userspace Execution Prevention"
 	depends on PPC_HAVE_KUEP
-	default y
+	default y if !PPC_BOOK3S_32
 	help
 	  Enable support for Kernel Userspace Execution Prevention (KUEP)
 
-- 
2.25.0

