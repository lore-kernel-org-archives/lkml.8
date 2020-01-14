Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC08C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C60D24656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eTvHwM2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgANRyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:54:03 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60972 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:54:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47xykc37Nyz9txgx;
        Tue, 14 Jan 2020 18:54:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eTvHwM2o; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 02RRu8SgBgJd; Tue, 14 Jan 2020 18:54:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47xykc1zTtz9txgv;
        Tue, 14 Jan 2020 18:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579024440; bh=B0+TB2t6Mf/OCq6ADh5LqwrW8zgDmLQL+/a0NWwMyqI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eTvHwM2on4WsspJ/vCRKarI7o8Yws20UAfQNTEPcQYMneVScYOE8yhXmf1GOEngYz
         jQFH+L2ywylAfm5HKHHocO5JVqWhDt96TQD8ggSvk1Roeu8S9u6O3D4EEr9etDUowl
         OK9oMLXvOqFHuds0u8YEWasnc/27CaHLi1jN3RvM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 028548B7EB;
        Tue, 14 Jan 2020 18:54:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MgB5gcRAG-D9; Tue, 14 Jan 2020 18:54:01 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C44C78B7E8;
        Tue, 14 Jan 2020 18:54:01 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9DC396381C; Tue, 14 Jan 2020 17:54:01 +0000 (UTC)
Message-Id: <6f28085c2a1aa987093d50db17586633bbf8e206.1579024426.git.christophe.leroy@c-s.fr>
In-Reply-To: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
References: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/5] powerpc/kconfig: move CONFIG_PPC32 into Kconfig.cputype
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Jan 2020 17:54:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CONFIG_PPC32 at the same place as CONFIG_PPC64 for consistency.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                   | 4 ----
 arch/powerpc/platforms/Kconfig.cputype | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a247bbfb03d4..c2a604b9592b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 source "arch/powerpc/platforms/Kconfig.cputype"
 
-config PPC32
-	bool
-	default y if !PPC64
-
 config 32BIT
 	bool
 	default y if PPC32
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 8d7f9c3dc771..536a2efcb7f0 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+config PPC32
+	bool
+	default y if !PPC64
+
 config PPC64
 	bool "64-bit kernel"
 	select ZLIB_DEFLATE
-- 
2.13.3

