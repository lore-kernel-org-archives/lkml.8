Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6CDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4CA20781
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nbjHHR5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgCaGYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:24:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61007 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgCaGYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:24:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48rznh7100z9v0KD;
        Tue, 31 Mar 2020 08:24:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nbjHHR5n; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1Rbbg18LYNuf; Tue, 31 Mar 2020 08:24:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48rznh5jJwz9v0KC;
        Tue, 31 Mar 2020 08:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585635880; bh=rQwkTfrjFiqmfYf4WsSfoDHWRa98N9YqiVIvJYZF6i0=;
        h=From:Subject:To:Cc:Date:From;
        b=nbjHHR5n/f0kVmtS3m+JiIFaxt5kkB5IhHcIRyh1lPQz0j5uTiIo51tMcvXKJ1FK9
         U/KKuTm3VaKmOmRGh6fZffDFqDOF7nCtQyHSeSl0iYAnhhJ5bQBRUj4g9VrtQxmulG
         6Eh0HDtgyTUooUF6AvzynMuhFzLg/8avau2lLpb0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 90D528B784;
        Tue, 31 Mar 2020 08:24:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ff4uzgkKsQ-o; Tue, 31 Mar 2020 08:24:41 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C7C98B752;
        Tue, 31 Mar 2020 08:24:41 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3064065673; Tue, 31 Mar 2020 06:24:41 +0000 (UTC)
Message-Id: <40899eb1b8f10da3706acd06c3d46d2418c8886e.1585635837.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 01/10] powerpc: Mark 4xx as Orphan in MAINTAINERS
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 06:24:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

The 4xx platforms are no longer maintained.

Cc: Alistair Popple <alistair@popple.id.au>
Cc: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a5332b3591d..054c5af124a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9647,11 +9647,8 @@ F:	arch/powerpc/platforms/512x/
 F:	arch/powerpc/platforms/52xx/
 
 LINUX FOR POWERPC EMBEDDED PPC4XX
-M:	Alistair Popple <alistair@popple.id.au>
-M:	Matt Porter <mporter@kernel.crashing.org>
-W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Orphan
 F:	arch/powerpc/platforms/40x/
 F:	arch/powerpc/platforms/44x/
 
-- 
2.25.0

