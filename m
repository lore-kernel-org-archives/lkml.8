Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A98C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9F82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJLvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:51:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbgDJLvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:51:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5BD10F7AA6D541B079DB;
        Fri, 10 Apr 2020 19:51:32 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:51:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harveyhuntnexus@gmail.com>, <paul@crapouillou.net>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mtd: rawnand: ingenic: Make qi_lb60_ooblayout_ops static
Date:   Fri, 10 Apr 2020 19:51:21 +0800
Message-ID: <20200410115121.11852-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c:105:32:
 warning: symbol 'qi_lb60_ooblayout_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index 935c4902ada7..e7bd845fdbf5 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -102,7 +102,7 @@ static int qi_lb60_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
+static const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
 	.ecc = qi_lb60_ooblayout_ecc,
 	.free = qi_lb60_ooblayout_free,
 };
-- 
2.17.1


