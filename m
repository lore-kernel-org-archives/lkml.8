Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDFBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA74C206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="J7/1uOlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFJJQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:16:45 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:57510 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFJJQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:16:45 -0400
IronPort-SDR: QPwtd4PcZPyNZ7xjw5yFjJ4Y1Z8et1VF/uhqk0znRb+k7N/trw6xfkPltpRtHBKJf9kVll1Ct4
 cLANCzUhoyl7LUlMK6XpB7inYHhHVK09f5Uv27yn0IJJYgI9oo49QtVnEfjtQqUxcQXILqj/1h
 ZeIuq0daIKXHoA4mYfIxadWs80tVyY6fpFu9/nJ4WN+0hQOJf9Uu+OZUTLlO9HKGcBBO0gZ/Ph
 OqJvmC8Iju+rPYrS2VQSBPE//r32WPr5miET4lVykTu/BCSCYUhR/AfblD7XbBKCLZlOxiZi8A
 yHQ=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12632101"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Jun 2020 11:16:42 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 Jun 2020 11:16:42 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 Jun 2020 11:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591780602; x=1623316602;
  h=from:to:cc:subject:date:message-id;
  bh=SX7bKwUUzHRTqxNVLzwW4z+x2qXT4twsmECkG5lWMXw=;
  b=J7/1uOltcQpINyPJbQQgp6qUSG9QCxtSsrBreI40RN7h5AvFB1aAAGc4
   MxSkcDJ2izp0362df8qY7GCRdnYjztRSkVlJFAMxqD9Bf9KC0vD7oFRAt
   CU3sria1ZtTBYEv5lRhIL6gHpNY7Vtt6Vcx0kOFpZ4JvnhwZLlWorqpni
   ruxYd7xpTWoRKCWzxdCuVaIcR9o1l7qel/pkZ832+Wh1wGOdW0TB67H86
   oC25fauxtdeQ98/j/ITWGW0nS7abZYrmHCT9gofCGbAvTsEZhc2kkC6w0
   woNk5ZwV40jJyEC1tXx/6rzFpSU/GG1QA2f6QlrRK2kI40gJpvMrBua4N
   A==;
IronPort-SDR: mBT2aiLqUhCJswTXYJscs4zNFhgiuH9x90QvWp81VGM3M9sbZnOfSoFS1StLCP+O8QtzP6VvWC
 vssH08/zYlyLCOvxBENWBEUSvtzWnvF1yGxMOIh72JRcTumEAzxzo2gIFl4wjwJQp7tdkop3CQ
 O3NNuJp3jsCNW2iXaUxOC4EGyUDKyuNhnzkhd5edCUnlNkJQwMRKOov5Zd1KyVMVcdVr/ifJr3
 wwLnuYcxzlxO/59jgcKveDp0aJVBaIKmkVKYusAmD0r0PvkiNteg9xbJ5h8jp4nS822BHOb/wy
 9qg=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12632099"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jun 2020 11:16:42 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id C8AB3280065;
        Wed, 10 Jun 2020 11:16:49 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Krummsdorf <michael.krummsdorf@tq-group.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] mtd: spi-nor: micron-st: enable 4-byte opcodes for n25q512a
Date:   Wed, 10 Jun 2020 11:16:16 +0200
Message-Id: <20200610091616.29555-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>

Set SPI_NOR_4B_OPCODES, as the flash supports 4-byte opcodes.

Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mtd/spi-nor/micron-st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3dca5b9af3b6..8edfde053f31 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -58,7 +58,8 @@ static const struct flash_info st_parts[] = {
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
-			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
+			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6 |
+			      SPI_NOR_4B_OPCODES) },
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
 			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
-- 
2.17.1

