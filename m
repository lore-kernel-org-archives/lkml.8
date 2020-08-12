Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C84C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B13620829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="VUE7wrr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHLPPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:15:54 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37154 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgHLPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:15:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 92DAB4C897;
        Wed, 12 Aug 2020 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1597245331; x=1599059732; bh=nnOj6MFAVv+oGP+mdBYK4SKBtK5bLxUUMPQ
        FQit6vVE=; b=VUE7wrr9MFz2yrgK2REr4+CB7rkx2YJ23dtvi3VLJC/VwsohcKp
        cJIYJhP3+r5+KWkfe7FE5jgXKSBLA+YA3fKT0bJrgVUTuievZkViuhL4La3EqeT1
        FU6gzyiR3JS4Vo5F89Y/8FfkqMSVrS+YD+u+zAvqGPOzGlJuL2rvabeU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fQU7Z207qrwn; Wed, 12 Aug 2020 18:15:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A243B4C84D;
        Wed, 12 Aug 2020 18:15:30 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.2.34) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 12 Aug 2020 18:15:30 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mtd: spi-nor: enable lock interface for macronix chips
Date:   Wed, 12 Aug 2020 18:18:18 +0300
Message-ID: <20200812151818.16699-3-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200812151818.16699-1-i.mikhaylov@yadro.com>
References: <20200812151818.16699-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.34]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add locks for whole macronix chip series with BP0-2 and BP0-3 bits.

Tested with mx25l51245g(BP0-3).

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/mtd/spi-nor/macronix.c | 75 ++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 96735d83c77c..80de43eb05d6 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -37,53 +37,78 @@ static const struct flash_info macronix_parts[] = {
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
-	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8, SECT_4K) },
-	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
-	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
-	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
-	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
-	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
-	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
+	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8,
+			      SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16,
+			      SPI_NOR_HAS_LOCK) },
+	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4,
+			      SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
-	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
-	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
-	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
-	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
+	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256,
+			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
+	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256,
+			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
 	{ "mx25r3235f",  INFO(0xc22816, 0, 64 * 1024,  64,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx25u12835f", INFO(0xc22538, 0, 64 * 1024, 256,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512,
-			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP)
 		.fixups = &mx25l25635_fixups },
 	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512,
-			      SECT_4K | SPI_NOR_4B_OPCODES) },
+			      SECT_4K | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx25u51245g", INFO(0xc2253a, 0, 64 * 1024, 1024,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
+			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
 	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
+	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512,
+			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
 	{ "mx25l51245g", INFO(0xc2201a, 0, 64 * 1024, 1024,
 			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			      SPI_NOR_4B_OPCODES) },
+			      SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			      SPI_NOR_4B_OPCODES) },
+			      SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
+			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048,
 			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_4BIT_BP) },
 };
 
 static void macronix_default_init(struct spi_nor *nor)
-- 
2.21.1

