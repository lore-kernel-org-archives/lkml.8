Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55972C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1688620823
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WFGsSysa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgFIMqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:46:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54176 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbgFIMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:46:27 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D4B21314;
        Tue,  9 Jun 2020 14:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591706784;
        bh=k2d6Fgi2DgTc07BY1d7t3Uj5hqRkZW7TQacEh7wmTzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFGsSysaYs+5unqI2BUTf63py99p8e6AsjzRDMPr/wx2ZOkReZbwRY72uyNfMcphz
         C5o/B9a1Gl/4fq7clChpv0yA0dkgMyCFVsiUfhNlzSB2skBccLhn0BOnanRGLgBB9B
         GMDi8Czfb+rWvc2bfNBYWfEib1hdQn3Vri9kHj9Y=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Kosina <trivial@kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/17] drivers: mtd: nand: raw: Fix trivial spelling
Date:   Tue,  9 Jun 2020 13:45:57 +0100
Message-Id: <20200609124610.3445662-5-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/mtd/nand/raw/mxc_nand.c | 2 +-
 drivers/mtd/nand/raw/nand_bbt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 59554c187e01..81659c09770a 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1432,7 +1432,7 @@ static int mxc_nand_get_features(struct nand_chip *chip, int addr,
 }
 
 /*
- * The generic flash bbt decriptors overlap with our ecc
+ * The generic flash bbt descriptors overlap with our ecc
  * hardware, so define some i.MX specific ones.
  */
 static uint8_t bbt_pattern[] = { 'B', 'b', 't', '0' };
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 96045d60471e..344a24fd2ca8 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1226,7 +1226,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 		return -ENOMEM;
 
 	/*
-	 * If no primary table decriptor is given, scan the device to build a
+	 * If no primary table descriptor is given, scan the device to build a
 	 * memory based bad block table.
 	 */
 	if (!td) {
-- 
2.25.1

