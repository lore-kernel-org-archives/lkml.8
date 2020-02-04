Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8529BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2B82082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 02:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBDC0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:26:41 -0500
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:58750 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBDC0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 21:26:41 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0142QEjX025013; Tue, 4 Feb 2020 11:26:14 +0900
X-Iguazu-Qid: 2wHH7JlGcNxSmOpG1Q
X-Iguazu-QSIG: v=2; s=0; t=1580783174; q=2wHH7JlGcNxSmOpG1Q; m=NNGISSgBWmspy5FTh8p2hYNr1NBYTFInzixMIb7InI4=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1113) id 0142QDo0022522;
        Tue, 4 Feb 2020 11:26:13 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0142QD0b027265;
        Tue, 4 Feb 2020 11:26:13 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 0142QCc5003277;
        Tue, 4 Feb 2020 11:26:12 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: nand: Add comment about Kioxia ID
Date:   Tue,  4 Feb 2020 11:26:03 +0900
X-TSB-HOP: ON
Message-Id: <1580783163-5601-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment above NAND_MFR_TOSHIBA and SPINAND_MFR_TOSHIBA definitions
that Toshiba and Kioxia ID are the same.

Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
---
 drivers/mtd/nand/raw/internals.h | 1 +
 drivers/mtd/nand/spi/toshiba.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index cba6fe7..2918376b 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -30,6 +30,7 @@
 #define NAND_MFR_SAMSUNG	0xec
 #define NAND_MFR_SANDISK	0x45
 #define NAND_MFR_STMICRO	0x20
+/* Toshiba and Kioxia ID are the same. */
 #define NAND_MFR_TOSHIBA	0x98
 #define NAND_MFR_WINBOND	0xef
 
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 0db5ee4..a92ecc8 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
 
+/* Toshiba and Kioxia ID are the same. */
 #define SPINAND_MFR_TOSHIBA		0x98
 #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
 
-- 
1.9.1

