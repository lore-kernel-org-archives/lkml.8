Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43380C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1611F2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFQOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgFQOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:36:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E59C0617BB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:36:50 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:b57b:2191:a081:571d])
        by xavier.telenet-ops.be with bizsmtp
        id sEcm2200V1Jlgh201EcnLH; Wed, 17 Jun 2020 16:36:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlZBG-0007q1-SJ; Wed, 17 Jun 2020 16:36:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlZBG-0004md-R3; Wed, 17 Jun 2020 16:36:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 7/9] sh: sh2007: Modernize printing of kernel messages
Date:   Wed, 17 Jun 2020 16:36:37 +0200
Message-Id: <20200617143639.18315-8-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
References: <20200617143639.18315-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Convert from printk() to pr_*(),
  - Add missing continuation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
  - Add Tested-by.
---
 arch/sh/boards/board-sh2007.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/board-sh2007.c b/arch/sh/boards/board-sh2007.c
index ef9c87deeb08828c..6ea85e4808512f94 100644
--- a/arch/sh/boards/board-sh2007.c
+++ b/arch/sh/boards/board-sh2007.c
@@ -126,14 +126,14 @@ static void __init sh2007_init_irq(void)
  */
 static void __init sh2007_setup(char **cmdline_p)
 {
-	printk(KERN_INFO "SH-2007 Setup...");
+	pr_info("SH-2007 Setup...");
 
 	/* setup wait control registers for area 5 */
 	__raw_writel(CS5BCR_D, CS5BCR);
 	__raw_writel(CS5WCR_D, CS5WCR);
 	__raw_writel(CS5PCR_D, CS5PCR);
 
-	printk(KERN_INFO " done.\n");
+	pr_cont(" done.\n");
 }
 
 /*
-- 
2.17.1

