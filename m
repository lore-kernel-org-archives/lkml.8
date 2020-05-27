Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62401C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AAA207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgE0Nmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:42:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbgE0Nma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:42:30 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MaIrN-1jYcro1YGL-00WCjo; Wed, 27 May 2020 15:42:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: arasan: select CONFIG_BCH
Date:   Wed, 27 May 2020 15:42:03 +0200
Message-Id: <20200527134210.847411-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0ERleDGDoYzZSO351/qcuQ53P9BOoY8n9kiIrDVxRwankQHZJKf
 q0LF7oeTmAubbA5uNTQKrD28V3IGepb0X6rPuNYuwHPTlRA4Vcx2h+MxTaSMfUTQRgHdqUE
 iL7XTOg4B0iJBExr22T1i764EAj9WNVWVts5wJOYYfZlLVF13fcdJ37PH+7lbbWC/YL5Pz4
 joHLK8o3erWRfgZ6koFrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TcWRwqlhomw=:27oxfRCh9GEKpKasOksz0+
 tqu0k7N/C+sN91belOMslygH/VVIX6C0L8VWWIeL1TCNn535PCE8Bk1xMlakycYSXv5uQIYjo
 ekmDmeuY4xe3jdt9oq3w1Mk2ybck1vmiUvMviRJ9W6FpvSaIIAeGJFWFlnRp591KUpTczegI2
 evePeEBRX/sn3AzSFBXFRL6c2fGEskiwkZoFrXjs30tXAEVzdbZGHe1ZsiDxQ8hR7d532jKak
 16k2No9kaC/VLMxjnf35RIelieaPnAB4wgoKW9PW+k767RGx72PQjybOYSc39nGYOX/kgtcYs
 nJiNfg3Qhc5wMDh7R0kxBTZLBVyVAQqoJZshWED7ee/euxetggP/iWKCO5MSBwyeDOu51e5nY
 46Ot3QpUXVMDNxpNR711+yLb1d0CLMiU6JpH80QsWSBjm0uiwQ0PYzjijx/DvvWRPEYo0BrUr
 6IDkwthIdyTZTJqe1/kJ7zZH1S6TiB189Nmn8BP/EmS9sEzTH4sVuzCRAPDO8xIkfxB7Vua2Y
 3K2tAhHaqJ6DPSNgKyOEqVyD2YCL/CefkZ7obf5kwwcsW1Zoz9GxVepDBPKomLUM96VOaXwXK
 UzwMO8JIUdJZ2sAUmo2BqRM2FHvvZTkeEtdB9F+nIBT2bnW2qUV2T1EP1VEqLBm2L1/2DqIu5
 VwY+v5rtp5aAlhp1evVZZZerXyxSMVEzS3uDQWMHEiGzC2A9X1t984fI0pixF19MeX5FrML0M
 JyJdrz3ods9BApsl3DCCO457qikGmcDKC+gCT6FNT5EBJVax4oWo0yh9a/P8h3DN6hMaqQwi8
 nC38W5X1AxIk4DQcemNb1njF3vlFbs1VLZ8EiUADPLc6mw3PYM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like several other nand flash drivers, this one requires the BCH
library to be selected from Kconfig.

arm-linux-gnueabi-ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_attach_chip':
arasan-nand-controller.c:(.text+0x894): undefined reference to `bch_init'
arm-linux-gnueabi-ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_detach_chip':
arasan-nand-controller.c:(.text+0x98c): undefined reference to `bch_free'
arm-linux-gnueabi-ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_read_page_hw_ecc':
arasan-nand-controller.c:(.text+0x1080): undefined reference to `bch_decode'

Fixes: 197b88fecc50 ("mtd: rawnand: arasan: Add new Arasan NAND controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index e2bc87779bf9..113f61052269 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -456,6 +456,7 @@ config MTD_NAND_CADENCE
 config MTD_NAND_ARASAN
 	tristate "Support for Arasan NAND flash controller"
 	depends on HAS_IOMEM && HAS_DMA
+	select BCH
 	help
 	  Enables the driver for the Arasan NAND flash controller on
 	  Zynq Ultrascale+ MPSoC.
-- 
2.26.2

