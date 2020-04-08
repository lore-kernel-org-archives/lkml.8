Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA7C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8220220769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TVULhxZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgDHP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:58:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48033 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgDHP6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:58:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48y88V6Pc2z9v1H5;
        Wed,  8 Apr 2020 17:58:50 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TVULhxZv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id N7YYW_kaFFbe; Wed,  8 Apr 2020 17:58:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48y88V4wYkz9v1H0;
        Wed,  8 Apr 2020 17:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586361530; bh=SSLdeS8jfMrpRRTIZEZS17MpZ133uX84ktpTVXBDtCg=;
        h=From:Subject:To:Cc:Date:From;
        b=TVULhxZvLlDYNB5L6uZv00xd22hUZ2dA+0stSCVDIWeqMFFOnmHF9qflDH158mpSN
         3MkOJzDLZ/cRuqeBETWhaD9sRiificlHsKZ2lC5SxMj8r0EktnzpcajifsJkJlwFZE
         m9CMIfSvL79Dx09zlBF9hnHk5L7ZlyDE1VZHV4VY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D0E168B7A0;
        Wed,  8 Apr 2020 17:58:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N4nKQRmSnhYP; Wed,  8 Apr 2020 17:58:51 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 901FC8B78D;
        Wed,  8 Apr 2020 17:58:50 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 040AC6574F; Wed,  8 Apr 2020 15:58:49 +0000 (UTC)
Message-Id: <2c50f3b1c9bbaa4217c9a98f3044bd2a36c46a4f.1586361277.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/kasan: Fix stack overflow by increasing THREAD_SHIFT
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, <erhard_f@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  8 Apr 2020 15:58:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_KASAN is selected, the stack usage is increased.

In the same way as x86 and arm64 architectures, increase
THREAD_SHIFT when CONFIG_KASAN is selected.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=207129
Reported-by: <erhard_f@mailbox.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 05d20a8d6581..4444511f9bbc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -771,6 +771,7 @@ config THREAD_SHIFT
 	range 13 15
 	default "15" if PPC_256K_PAGES
 	default "14" if PPC64
+	default "14" if KASAN
 	default "13"
 	help
 	  Used to define the stack size. The default is almost always what you
-- 
2.25.0

