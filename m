Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_DISCARD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E17CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF2C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCJUlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:41:19 -0400
Received: from shelob.oktetlabs.ru ([91.220.146.113]:48909 "EHLO
        shelob.oktetlabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCJUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:41:19 -0400
Received: by shelob.oktetlabs.ru (Postfix, from userid 122)
        id 74E5C7F5AC; Tue, 10 Mar 2020 23:33:39 +0300 (MSK)
Received: from varda.oktetlabs.ru (varda.oktetlabs.ru [192.168.37.38])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by shelob.oktetlabs.ru (Postfix) with ESMTPS id 8B5F37F594;
        Tue, 10 Mar 2020 23:33:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 8B5F37F594
Authentication-Results: shelob.oktetlabs.ru/8B5F37F594; dkim=none;
        dkim-atps=neutral
Received: from mkshevetskiy by varda.oktetlabs.ru with local (Exim 4.92)
        (envelope-from <mkshevetskiy@varda.oktetlabs.ru>)
        id 1jBlZ8-001inJ-AD; Tue, 10 Mar 2020 23:33:26 +0300
From:   Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
Subject: [PATCH 2/2] mtd: spinand: fix bad block marker writing
Date:   Tue, 10 Mar 2020 23:32:24 +0300
Message-Id: <20200310203224.410198-2-mikhail.kshevetskiy@oktetlabs.ru>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200310203224.410198-1-mikhail.kshevetskiy@oktetlabs.ru>
References: <20200310203224.410198-1-mikhail.kshevetskiy@oktetlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spinand_markbad() we use spinand->oobbuf as a bad block marker, fill
it with zeroes and issue spinand_write_page() operation:

        struct nand_page_io_req req = {
                .pos = *pos,
                .ooboffs = 0,
                .ooblen = 2,
                .oobbuf.out = spinand->oobbuf,
        };
        ...
        memset(spinand->oobbuf, 0, 2);
        return spinand_write_page(spinand, &req);

spinand_write_page() will call spinand_write_to_cache_op() at some
moment. In spinand_write_to_cache_op() we have:

        nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
        memset(spinand->databuf, 0xff, nbytes);

This will fill spinand->databuf with 0xff, but spinand->oobbuf is the
part of spinand->databuf (see spinand_init()):

        spinand->oobbuf = spinand->databuf + nanddev_page_size(nand);

As result bad block marker will be overwrited by 0xff values, hence
bad block will NOT be marked.

A separate buffer for bad block marker used to fix this issue.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index bb4eac400b0f..d1355773d484 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -603,11 +603,12 @@ static int spinand_mtd_block_isbad(struct mtd_info *mtd, loff_t offs)
 static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 {
 	struct spinand_device *spinand = nand_to_spinand(nand);
+	char bad_block_marker[2] = {0, 0};
 	struct nand_page_io_req req = {
 		.pos = *pos,
 		.ooboffs = 0,
-		.ooblen = 2,
-		.oobbuf.out = spinand->oobbuf,
+		.ooblen = sizeof(bad_block_marker),
+		.oobbuf.out = bad_block_marker,
 	};
 	int ret;
 	u8 status;
@@ -630,7 +631,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	memset(spinand->oobbuf, 0, 2);
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.25.0

