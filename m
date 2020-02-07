Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69132C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A482253D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgBGFAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:00:12 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:40510 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBGFAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:00:12 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0174xkDD019064; Fri, 7 Feb 2020 13:59:46 +0900
X-Iguazu-Qid: 34trVEM7idIBmVbf7b
X-Iguazu-QSIG: v=2; s=0; t=1581051586; q=34trVEM7idIBmVbf7b; m=UZsojiNI0aZWMhOrDJiQBP8/gnldnswmBaoEmfRDmUU=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1512) id 0174xjdQ021370;
        Fri, 7 Feb 2020 13:59:45 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0174xjtE001584;
        Fri, 7 Feb 2020 13:59:45 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 0174xi9a027081;
        Fri, 7 Feb 2020 13:59:44 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3] mtd: spinand: toshiba: Add comment about Kioxia ID
Date:   Fri,  7 Feb 2020 13:59:21 +0900
X-TSB-HOP: ON
Message-Id: <1581051561-7302-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment above NAND_MFR_TOSHIBA and SPINAND_MFR_TOSHIBA definitions
that Toshiba and Kioxia ID are the same.
Since its independence from Toshiba Group, Toshiba memory Co has become
Kioxia Co.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
---
 drivers/mtd/nand/raw/internals.h | 1 +
 drivers/mtd/nand/spi/toshiba.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index cba6fe7..9d0caad 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -30,6 +30,7 @@
 #define NAND_MFR_SAMSUNG	0xec
 #define NAND_MFR_SANDISK	0x45
 #define NAND_MFR_STMICRO	0x20
+/* Kioxia is new name of Toshiba memory. */
 #define NAND_MFR_TOSHIBA	0x98
 #define NAND_MFR_WINBOND	0xef
 
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 0db5ee4..833e8f6 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
 
+/* Kioxia is new name of Toshiba memory. */
 #define SPINAND_MFR_TOSHIBA		0x98
 #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
 
-- 
1.9.1

