Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26159C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077D92076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414682AbgDOPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:25:59 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:14998 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636875AbgDOPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:25:39 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id D969D4E1A58;
        Wed, 15 Apr 2020 23:25:35 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2,1/5] powerpc: 85xx: make FSL_85XX_CACHE_SRAM configurable
Date:   Wed, 15 Apr 2020 08:24:38 -0700
Message-Id: <20200415152442.122873-2-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415152442.122873-1-wenhu.wang@vivo.com>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVKQk9LS0tJT09KT0tNSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6CAw6GTg8QwgyLyoIGQs5
        VjdPFB1VSlVKTkNNQk1PSEhNSU1DVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhLSUI3Bg++
X-HM-Tid: 0a717e720e149376kuwsd969d4e1a58
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable FSL_85XX_CACHE_SRAM selection. On e500 platforms, the cache
could be configured and used as a piece of SRAM which is hignly
friendly for some user level application performances.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changes since v1:
 * None
---
 arch/powerpc/platforms/85xx/Kconfig    | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index fa3d29dcb57e..6debb4f1b9cc 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -17,7 +17,7 @@ if FSL_SOC_BOOKE
 if PPC32
 
 config FSL_85XX_CACHE_SRAM
-	bool
+	bool "Freescale 85xx Cache-Sram"
 	select PPC_LIB_RHEAP
 	help
 	  When selected, this option enables cache-sram support
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0c3c1902135c..1921e9a573e8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC32
-	bool
+	bool "32-bit kernel"
 	default y if !PPC64
 	select KASAN_VMALLOC if KASAN && MODULES
 
@@ -15,6 +15,7 @@ config PPC_BOOK3S_32
 	bool
 
 menu "Processor support"
+
 choice
 	prompt "Processor Type"
 	depends on PPC32
@@ -211,9 +212,9 @@ config PPC_BOOK3E
 	depends on PPC_BOOK3E_64
 
 config E500
+	bool "e500 Support"
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
-	bool
 
 config PPC_E500MC
 	bool "e500mc Support"
-- 
2.17.1

