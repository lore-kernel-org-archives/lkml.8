Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35ACC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24612075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TMJ9DwhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgDXSo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:44:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47774 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgDXSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:44:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiZdf022849;
        Fri, 24 Apr 2020 13:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587753875;
        bh=AmgJS/+Rj4TLh0nHUX1yf4w64mP27rFO9sqoBW7OysQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TMJ9DwhXDAwf3f776IHVMxe4+fFbxtYbkYG/s3LPNE6lLALGRi9jo8ch04UbMTwHz
         i0M1zHNKUapwEN/ujI5vCSE06iVXVy4ymT2JvyeqXBsPJvAhg5GNTrdtlJg+UGOGfe
         sQ565P89YPMJH8okePFT7JZ0B5jSEit2Y3Mv3H8c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OIiZKq021045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 13:44:35 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 13:44:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 13:44:35 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiAaB047967;
        Fri, 24 Apr 2020 13:44:31 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v4 05/16] mtd: spi-nor: default to address width of 3 for configurable widths
Date:   Sat, 25 Apr 2020 00:13:59 +0530
Message-ID: <20200424184410.8578-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200424184410.8578-1-p.yadav@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JESD216D.01 says that when the address width can be 3 or 4, it defaults
to 3 and enters 4-byte mode when given the appropriate command. So, when
we see a configurable width, default to 3 and let flash that default to
4 change it in a post-bfpt fixup.

This fixes SMPT parsing for flashes with configurable address width. If
the SMPT descriptor advertises variable address width, we use
nor->addr_width as the address width. But since it was not set to any
value from the SFDP table, the read command uses an address width of 0,
resulting in an incorrect read being issued.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index f917631c8110..5cecc4ba2141 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -460,6 +460,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	/* Number of address bytes. */
 	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
 	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
+	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
 		nor->addr_width = 3;
 		break;
 
-- 
2.25.0

