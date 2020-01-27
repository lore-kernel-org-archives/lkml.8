Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE210C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C313120702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s6Xg+yxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgA0Mkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:40:33 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:49991 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgA0Mkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:40:32 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 00RCdcZH001287;
        Mon, 27 Jan 2020 21:39:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 00RCdcZH001287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580128779;
        bh=ct4hR2SFtJIjSGrUUZxMPG18H6AE2oR0KNstaSmV6n8=;
        h=From:To:Cc:Subject:Date:From;
        b=s6Xg+yxtzaTk72msg7Iif1XiiCbN/rSWwZGAerAvb6VnNcACSJb693VxZNoPd05wd
         Y572qWqmaYwWCsyA8aYXSu3aNd6T/2aGcDwQ6PZY9sxqtow1gvTqg839zMWdPoCEoj
         mR31nUbeFm0VHpKir4taZK61fwwiHVetoyAT7RYMjYl2GtiIWpXalzaWFJkNeZ4UgW
         DHIqMkgT0Q71YXGQdf5prLTiE2SqIb1UPplz36d5NnFCJQR668g0BnaMEeuw0whYD3
         BFomzO1wJ+aMo/G4YyxC/A/aomYHcXjQa35xHaINZu0TQ3vmmfwHh36vMUY7OdNyUg
         tHijUaAZA9IxQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: denali: deassert write protect pin
Date:   Mon, 27 Jan 2020 21:39:34 +0900
Message-Id: <20200127123934.11847-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the write protect signal from this IP is connected to the NAND
device, this IP can handle the WP# pin via the WRITE_PROTECT
register.

The Denali NAND Flash Memory Controller User's Guide describes
this register like follows:

  When the controller is in reset, the WP# pin is always asserted
  to the device. Once the reset is removed, the WP# is de-asserted.
  The software will then have to come and program this bit to
  assert/de-assert the same.

    1 - Write protect de-assert
    0 - Write protect assert

The default value is 1, so the write protect is de-asserted after
the reset is removed. The driver can write to the device unless
someone has explicitly cleared register before booting the kernel.

The boot ROM of some UniPhier SoCs (LD4, Pro4, sLD8, Pro5) is the
case; the boot ROM clears the WRITE_PROTECT register when the system
is booting from the NAND device, so the NAND device becomes read-only.

Set it to 1 in the driver in order to allow the write access to the
device.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index fafd0a0aa8e2..6a6c919b2569 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1317,6 +1317,7 @@ int denali_init(struct denali_controller *denali)
 	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);
 	iowrite32(ECC_ENABLE__FLAG, denali->reg + ECC_ENABLE);
 	iowrite32(0xffff, denali->reg + SPARE_AREA_MARKER);
+	iowrite32(WRITE_PROTECT__FLAG, denali->reg + WRITE_PROTECT);
 
 	denali_clear_irq_all(denali);
 
-- 
2.17.1

