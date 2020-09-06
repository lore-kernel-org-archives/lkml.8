Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA674C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ACF2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="PuY/AaV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgIFTcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:32:04 -0400
Received: from crapouillou.net ([89.234.176.41]:36112 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgIFTcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599420601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1G3bUlgshQqNl4lGaTXsuCXI8wy10MkoW5Q89GP5UAY=;
        b=PuY/AaV1GCfrKXkWXQd9s9GVgefjzQEHaPNAZpCP7AcLYz0jX91wuxa5/Rf2YO5A5EdOnW
        eWNWv0inm7pFfDexL9rdFn6jXllfKAMiGOikLoBjy7ettmsuIzBRfVEGtk4ZsevdHeCXgd
        Nl+IStZNUKVy8eolI0MeFug1e347TqM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Maciej W . Rozycki" <macro@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 15/15] MAINTAINERS: Update paths to Ingenic platform code
Date:   Sun,  6 Sep 2020 21:29:35 +0200
Message-Id: <20200906192935.107086-16-paul@crapouillou.net>
In-Reply-To: <20200906192935.107086-1-paul@crapouillou.net>
References: <20200906192935.107086-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Ingenic chips has been moved to the generic MIPS platform.
Update the paths accordingly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change
    
    v3: Add arch/mips/include/asm/mach-ingenic/ path too

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..52ce4a1beede 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8595,8 +8595,9 @@ INGENIC JZ47xx SoCs
 M:	Paul Cercueil <paul@crapouillou.net>
 S:	Maintained
 F:	arch/mips/boot/dts/ingenic/
-F:	arch/mips/include/asm/mach-jz4740/
-F:	arch/mips/jz4740/
+F:	arch/mips/generic/board-ingenic.c
+F:	arch/mips/include/asm/mach-ingenic/
+F:	arch/mips/ingenic/Kconfig
 F:	drivers/clk/ingenic/
 F:	drivers/dma/dma-jz4780.c
 F:	drivers/gpu/drm/ingenic/
-- 
2.28.0

