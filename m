Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF8C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE52A2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ChRpdbRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEGQUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:20:51 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:4848 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEGQUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2367; q=dns/txt; s=iport;
  t=1588868449; x=1590078049;
  h=from:to:cc:subject:date:message-id;
  bh=OV1yKebG18sSumlGTXlTtESd45PL10aWA2PsPs4tVwc=;
  b=ChRpdbRpn5ChLPHXRbYGVg+y8g3978UG4e15bDsTwQ2xk2XZgfABarHl
   WFKFn+4yxPIxAEOpgQDjtq0/Fi04CxDr5DrECZTuSJfcbf0yyWQIr1L29
   mQPBo/QJObELQknQ90+cE8C+KrGmbl7cmB6qsP4kmNP8YSTn9/Ni5knlF
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CLBACRNLRe/51dJa1mHgEBCxIMgXw?=
 =?us-ascii?q?LgiqBQzIqrxCBewsBAQEOLwQBAYREggkkNgcOAgMBAQsBAQUBAQECAQUEbYV?=
 =?us-ascii?q?ihh9SgT4TgyaCfa94gXUziSGBQBSBJIddhGcagUE/gRGDToQVhisEmAOBUJh?=
 =?us-ascii?q?+glKBA5cHDB2dIK1bgVgBMoFWMxoIGxWDJFAYDZ8qIQMwNwIGCAEBAwmQAYJ?=
 =?us-ascii?q?FAQE?=
X-IronPort-AV: E=Sophos;i="5.73,364,1583193600"; 
   d="scan'208";a="763140748"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 May 2020 16:20:48 +0000
Received: from zorba.cisco.com ([10.24.9.129])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id 047GKmsX010956;
        Thu, 7 May 2020 16:20:48 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     xe-linux-external@cisco.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Date:   Thu,  7 May 2020 09:20:47 -0700
Message-Id: <20200507162047.30788-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.9.129, [10.24.9.129]
X-Outbound-Node: rcdn-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some chips have 4B opcodes, but there is no way to know if they have
them. This device tree option allows platform owners to force enable 4b
opcodes when they know their chips support it even when it can be
automatically identified.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/mtd/spi-nor/core.c      | 5 +++++
 drivers/mtd/spi-nor/core.h      | 5 +++++
 drivers/mtd/spi-nor/micron-st.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cc68ea84318e..2bd130687f4b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3134,6 +3134,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_NOR_HAS_LOCK)
 		nor->flags |= SNOR_F_HAS_LOCK;
 
+	/* Add SPI_NOR_4B_OPCODES if force in the device tree */
+	if (info->flags & SPI_NOR_COND_4B_OPCODES &&
+		of_property_read_bool(np, "force-4b-opcodes"))
+		info->flags |= SPI_NOR_4B_OPCODES;
+
 	mtd->_write = spi_nor_write;
 
 	/* Init flash parameters based on flash_info struct and SFDP */
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6f2f6b27173f..49e17415d834 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -312,6 +312,11 @@ struct flash_info {
 					 * Must be used with SPI_NOR_4BIT_BP.
 					 */
 
+#define SPI_NOR_COND_4B_OPCODES	BIT(19) /*
+					 * Same as SPI_NOR_4B_OPCODES, but
+					 * must also be force in the device
+					 * tree.
+					 */
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
 };
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6c034b9718e2..f827454eaa5f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -37,7 +37,7 @@ static const struct flash_info st_parts[] = {
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
 			      USE_FSR | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_COND_4B_OPCODES) },
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.17.1

