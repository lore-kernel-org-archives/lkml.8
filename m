Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_DISCARD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2F1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C366720663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCJUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:41:20 -0400
Received: from shelob.oktetlabs.ru ([91.220.146.113]:38751 "EHLO
        shelob.oktetlabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJUlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:41:20 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 16:41:18 EDT
Received: by shelob.oktetlabs.ru (Postfix, from userid 122)
        id 5C94B7F5A6; Tue, 10 Mar 2020 23:33:33 +0300 (MSK)
Received: from varda.oktetlabs.ru (varda.oktetlabs.ru [192.168.37.38])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by shelob.oktetlabs.ru (Postfix) with ESMTPS id 7FA067F536;
        Tue, 10 Mar 2020 23:33:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 7FA067F536
Authentication-Results: shelob.oktetlabs.ru/7FA067F536; dkim=none;
        dkim-atps=neutral
Received: from mkshevetskiy by varda.oktetlabs.ru with local (Exim 4.92)
        (envelope-from <mkshevetskiy@varda.oktetlabs.ru>)
        id 1jBlZ5-001in5-AX; Tue, 10 Mar 2020 23:33:23 +0300
From:   Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
Subject: [PATCH 1/2] mtd: spinand: wait for erase completion before writing bad block maker
Date:   Tue, 10 Mar 2020 23:32:23 +0300
Message-Id: <20200310203224.410198-1-mikhail.kshevetskiy@oktetlabs.ru>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI flash will discard any write operation while it is busy with block
erasing. As result bad block marker will not be writed to a flash.
To fix it just wait for completion of erase operation.

The erasing code is almost the same as in spinand_erase(). The only
difference is: we ignore ERASE_FAILED status.

This patch also improve error handling a bit.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
---
 drivers/mtd/nand/spi/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 89f6beefb01c..bb4eac400b0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -610,6 +610,7 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.out = spinand->oobbuf,
 	};
 	int ret;
+	u8 status;
 
 	/* Erase block before marking it bad. */
 	ret = spinand_select_target(spinand, pos->target);
@@ -620,7 +621,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	spinand_erase_op(spinand, pos);
+	ret = spinand_erase_op(spinand, pos);
+	if (ret)
+		return ret;
+
+	/* ignore status as erase may fail for bad blocks */
+	spinand_wait(spinand, &status);
+	if (ret)
+		return ret;
 
 	memset(spinand->oobbuf, 0, 2);
 	return spinand_write_page(spinand, &req);
-- 
2.25.0

