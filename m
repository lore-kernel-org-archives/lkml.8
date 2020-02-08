Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F1C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C4D20715
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:36:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43382 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHLgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:36:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0OPE-000160-FI; Sat, 08 Feb 2020 11:36:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: fix spelling mistake "BlockMultiplerBits" -> "BlockMultiplierBits"
Date:   Sat,  8 Feb 2020 11:36:12 +0000
Message-Id: <20200208113612.817988-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake (missing i) in pr_info messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/inftlmount.c          | 2 +-
 drivers/mtd/nand/raw/diskonchip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index 54b176d4319f..af16d3485de0 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -130,7 +130,7 @@ static int find_boot_record(struct INFTLrecord *inftl)
 			 "    NoOfBootImageBlocks   = %d\n"
 			 "    NoOfBinaryPartitions  = %d\n"
 			 "    NoOfBDTLPartitions    = %d\n"
-			 "    BlockMultiplerBits    = %d\n"
+			 "    BlockMultiplierBits   = %d\n"
 			 "    FormatFlgs            = %d\n"
 			 "    OsakVersion           = 0x%x\n"
 			 "    PercentUsed           = %d\n",
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index c0e1a8ebe820..2833c49c1378 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1169,7 +1169,7 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 		"    NoOfBootImageBlocks   = %d\n"
 		"    NoOfBinaryPartitions  = %d\n"
 		"    NoOfBDTLPartitions    = %d\n"
-		"    BlockMultiplerBits    = %d\n"
+		"    BlockMultiplierBits   = %d\n"
 		"    FormatFlgs            = %d\n"
 		"    OsakVersion           = %d.%d.%d.%d\n"
 		"    PercentUsed           = %d\n",
-- 
2.25.0

