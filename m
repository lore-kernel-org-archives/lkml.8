Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9D8C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B9920780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Wd/3otyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgDQRx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:53:28 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:59290 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgDQRx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:53:28 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 13:53:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1064; q=dns/txt; s=iport;
  t=1587146007; x=1588355607;
  h=from:to:cc:subject:date:message-id;
  bh=qY+9PAFy7cPu/uPuW56FYsLvpzKOkBk6Uqf0v5jAxjs=;
  b=Wd/3otyZcm2e2mjgbYvdIbhZh0F40w8ce6aseWnMTUdHQQJJ9iHC8Ckc
   AtPQicl8RoRWsv6rv7xUhBqkAwO6JB6WyfHWT31ckDLzc0RWcLEBSFaJ6
   w53iYHXnqmpwO/Vg3aZjyIEegFlZV5Uv6LRW6PKaS5Fr96dfBCafLvql9
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AdBABq6ple/4oNJK1mHgELHIFwC4I?=
 =?us-ascii?q?pgUEyKq56gXsKAQEBDi8EAQGERIIRJDUIDgIDAQELAQEFAQEBAgEFBG2FYoZ?=
 =?us-ascii?q?xgT4TgyaCfa53gieJIYFAFIEkh1OEZhqBQT+EX4QVhioEmR+YUYJOgQGWVgw?=
 =?us-ascii?q?dnD4BLaxGgVQBNoFXMxoIGxWDJFAYDaBAIQMwjHKCRQEB?=
X-IronPort-AV: E=Sophos;i="5.72,395,1580774400"; 
   d="scan'208";a="746715712"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 Apr 2020 17:46:21 +0000
Received: from zorba.cisco.com ([10.24.5.71])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTP id 03HHkKH4019594;
        Fri, 17 Apr 2020 17:46:20 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     xe-linux-external@cisco.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to n25q256a
Date:   Fri, 17 Apr 2020 10:46:19 -0700
Message-Id: <20200417174620.16420-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.5.71, [10.24.5.71]
X-Outbound-Node: alln-core-5.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n25q256a supports 4-byte opcodes so lets add the flag.
Tested on Cisco IoT platform hardware using Marvell A7040 SoC.

This patch was base on one from Guo Yi <yi.guo@cavium.com>.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/mtd/spi-nor/micron-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6c034b9718e2..471fe2bc2ba4 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -37,7 +37,7 @@ static const struct flash_info st_parts[] = {
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
 			      USE_FSR | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.17.1

