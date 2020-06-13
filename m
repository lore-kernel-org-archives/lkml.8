Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34537C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 07:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E362071A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 07:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFMHiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgFMHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 03:38:04 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6680DC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 00:38:04 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:b5c0:3e9f:54c6:a282])
        by xavier.telenet-ops.be with bizsmtp
        id qXdw2200e0MrZeJ01Xdwn6; Sat, 13 Jun 2020 09:37:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jk0jk-0003e2-MN; Sat, 13 Jun 2020 09:37:56 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jk0jk-0004KU-K2; Sat, 13 Jun 2020 09:37:56 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: uapi: spidev: Use TABs for alignment
Date:   Sat, 13 Jun 2020 09:37:54 +0200
Message-Id: <20200613073755.15906-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UAPI <linux/spi/spidev.h> uses TABs for alignment.
Convert the recently introduced spaces to TABs to restore consistency.

Fixes: f30e8cbdf8ee1a43 ("spi: tools: Add macro definitions to fix build errors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/uapi/linux/spi/spidev.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index 9390615d52f0c1cb..d56427c0b3e05953 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -48,10 +48,10 @@
 #define SPI_TX_QUAD		0x200
 #define SPI_RX_DUAL		0x400
 #define SPI_RX_QUAD		0x800
-#define SPI_CS_WORD             0x1000
-#define SPI_TX_OCTAL            0x2000
-#define SPI_RX_OCTAL            0x4000
-#define SPI_3WIRE_HIZ           0x8000
+#define SPI_CS_WORD		0x1000
+#define SPI_TX_OCTAL		0x2000
+#define SPI_RX_OCTAL		0x4000
+#define SPI_3WIRE_HIZ		0x8000
 
 /*---------------------------------------------------------------------------*/
 
-- 
2.17.1

