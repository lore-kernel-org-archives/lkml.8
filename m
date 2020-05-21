Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgEUQ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:56:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42445 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgEUQ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:56:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49SbNY3p05z9v0pj;
        Thu, 21 May 2020 18:55:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bOAWUMbJ0L3N; Thu, 21 May 2020 18:55:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49SbNY2zr1z9v0pY;
        Thu, 21 May 2020 18:55:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B46448B7DB;
        Thu, 21 May 2020 18:55:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TMNXswk7FcL5; Thu, 21 May 2020 18:55:59 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 804338B778;
        Thu, 21 May 2020 18:55:59 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 60D4A65A53; Thu, 21 May 2020 16:55:59 +0000 (UTC)
Message-Id: <7380974bf5952af825ae2552d0a987c0c1c8b506.1590079969.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1590079968.git.christophe.leroy@csgroup.eu>
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 08/13] powerpc/40x: Remove support for ISS Simulator
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 May 2020 16:55:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

ISS4xx has support for 405GP which is obsolete.

Remote it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/44x/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 39e93d23fb38..78ac6d67a935 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -167,8 +167,7 @@ config YOSEMITE
 
 config ISS4xx
 	bool "ISS 4xx Simulator"
-	depends on (44x || 40x)
-	select 405GP if 40x
+	depends on 44x
 	select 440GP if 44x && !PPC_47x
 	select PPC_FPU
 	select OF_RTC
-- 
2.25.0

