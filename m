Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C40C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DCC246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MzmMQyVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgB0VMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:12:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16130 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0VMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582837942; x=1614373942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZYzhno8a1AffpbwkqfiLIlm+fMZL1Dp81qcUzuHaRE=;
  b=MzmMQyVCL7k5buyRRkeIs5oHa8PY0w6gm8q7CDJPHbrpkhG2klY6o3+5
   4JVU25C1Ye1uPE8O1JT/oUsGEtUJsdvL9pGSzD0pulrqNzv/ySTMdqZAF
   TAUrrlGMIdDHwdkoFUhGpqTWrY1S6sGE5+crXPq4ZwMYgWEHVuRwtomWc
   emU5y80SOwKlYv4cvjrBXfTCH8iQxWrvFvyyYzkr6hmVPAEwTRLt+A6Gl
   Lj3vmRuFfa7xAv9REzOQeVKVDShQYuh8VccCxsUgk/uerd6rN8N341Vr5
   d5fze+4W3MgdcB0NHZR4lNRYtqZafaQRADKxf/DHY0CSf9JATFF+F2AV2
   g==;
IronPort-SDR: tbGJqOl+JAhox8pNPnj6l393cQmK0Y0Ra06fL1QCzrhjg1w50obkL8xxm3FzaL2wztOs05DTky
 z3utEj4+4zEBlj/KCfts8ok9ZFCSgo1KgA/jn0Hd79MWIi/0ut1a2Tx9VbA1zoy9krrATZ8XkZ
 VLuM4XyEM/D7wF8ja5vz+RM3uCO+kr/lrU2KqUfjLhL/Rop24vim7weWpwFE6dlwKuDOhDuuwW
 DZVQwM7lRyKzP26aQV1DMikwg1cJzszUuwfhMmiGXcA35IKoUoBRQ3AKPw9Efix3Dd/eC9+xf6
 XIM=
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="232858612"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 05:12:22 +0800
IronPort-SDR: MSubYsUrb2x1Cw2HfLZpah1uR2qjO/8/m40K3/1zT2OyGr0KqFab5GemDEHCzm4h/hOkJWFogp
 E5N8l4y64ZqQcFoKO2WOX+OI6hIJwLmO3CpQX4gLtA0hZ31jdU0CRQaYpscHeGXK4O0w5X2j94
 mW9bWOf4cwapDl0bTh1j4/nwxvnSQtcmPGaZVY9wR2GCZiUkirPHQ1hKWce9Sl9HGFuKczxW+V
 m2l7VcFG2++ONX6IE3oQIVINAsNQDlcZ5e0RWhdFxtqzxwaPBbOpvAjAy1fCO/7IJZMieDpp8b
 xDKvd1nGHG1Kweytk2hLVPdE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 13:04:07 -0800
IronPort-SDR: 13dHDQuDjVqwy8bQJ4BCMMPrMoM5zJFnejUUpuHIR70QwoFMAzTZphl0K1TRDjvt+V0mHY7dIN
 2qrCH9bD+NIRABatKHGwCexrRun/O6kt8oA/zGcHQKKX595Rv+/rS4Ea1pA9iqyzrzH7m/GuSw
 lNiCDt6q370n/YxDOk1tbF4xHMpTdaq65VQNiUB1n7f8ZG5go43b6PXOiwkT3eK/xHacdX0YDt
 nMD/aHbGf8kboB85aZrMza641cM7iDDZd3i74SeIxVcubdbqLaxNjirWa8S9GNKxIRw0RVlDag
 zGg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.158.235])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Feb 2020 13:12:06 -0800
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com,
        alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
        Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] drm/bochs: Remove vga write
Date:   Thu, 27 Feb 2020 13:04:54 -0800
Message-Id: <20200227210454.18217-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU model for the Bochs display has no VGA memory section at offset
0x400 [1]. By writing to this register Linux can create a write to
unassigned memory which depending on machine and architecture can result
in a store fault.

I don't see any reference to this address at OSDev [2] or in the Bochs
source code.

Removing this write still allows graphics to work inside QEMU with
the bochs-display.

1: https://gitlab.com/qemu-project/qemu/-/blob/master/hw/display/bochs-display.c#L264
2. https://wiki.osdev.org/Bochs_VBE_Extensions

Reported-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index b615b7dfdd9d..dfb2a5363c62 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -10,19 +10,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
-{
-	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
-		return;
-
-	if (bochs->mmio) {
-		int offset = ioport - 0x3c0 + 0x400;
-		writeb(val, bochs->mmio + offset);
-	} else {
-		outb(val, ioport);
-	}
-}
-
 static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
 {
 	u16 ret = 0;
@@ -217,8 +204,6 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 			 bochs->xres, bochs->yres, bochs->bpp,
 			 bochs->yres_virtual);
 
-	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
-
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_XRES,        bochs->xres);
-- 
2.25.0

