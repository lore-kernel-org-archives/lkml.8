Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F995C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09972207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgIIPsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:48:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730446AbgIIPpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:45:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43882EA083EC8B2B931C;
        Wed,  9 Sep 2020 21:43:31 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:43:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <stefan@agner.ch>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yuehaibing@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: rawnand: vf610_nfc: Remove unused function vf610_nfc_transfer_size()
Date:   Wed, 9 Sep 2020 21:43:18 +0800
Message-ID: <20200909134318.36340-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ecc40b8df59a ("mtd: rawnand: vf610_nfc: remove old hooks")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 7248c5901183..ed8e0928c0b2 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -323,11 +323,6 @@ static inline void vf610_nfc_ecc_mode(struct vf610_nfc *nfc, int ecc_mode)
 			    CONFIG_ECC_MODE_SHIFT, ecc_mode);
 }
 
-static inline void vf610_nfc_transfer_size(struct vf610_nfc *nfc, int size)
-{
-	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, size);
-}
-
 static inline void vf610_nfc_run(struct vf610_nfc *nfc, u32 col, u32 row,
 				 u32 cmd1, u32 cmd2, u32 trfr_sz)
 {
-- 
2.17.1


