Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0EB20775
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662303;
	bh=5dYKczIvQ+iFI127IXOGGHsWU0/YsZaZeXftt1nV9sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TtTj3nOoSIGPFLj+nB7gapNiHAYp5nDj7DUaOgQxEeKcL0/WtmJmE3yxXtj7BH471
	 Mir2s+i3TISHq1BHCBjV4CfU+WSvWoew9BmcnGNA1T93vx7n1g85d6hY45X1HNsOAM
	 MfL01NE3EI6f/QZTVmPxhNyi8F5g+NlM/mgqyZlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgFHXRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgFHXN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C91208C3;
        Mon,  8 Jun 2020 23:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658038;
        bh=5dYKczIvQ+iFI127IXOGGHsWU0/YsZaZeXftt1nV9sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkRzZo2QJ8th5SxXeyPHztf26SBMrdfWnbMdXzfhtnjIYdoltg2m6VyEYAED40S6n
         Xzg9WiOa0GoQE0FHoMMlA/6ShUBXbQQR1f2Ok9wHWxLkiI1bg2pKh/V9i3F7gufOfk
         FRi9Mt81q0+N8GalzXaO2XumN1R51Z3eZFLY1V6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 088/606] mtd: spinand: Propagate ECC information to the MTD structure
Date:   Mon,  8 Jun 2020 19:03:33 -0400
Message-Id: <20200608231211.3363633-88-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 3507273d5a4d3c2e46f9d3f9ed9449805f5dff07 ]

This is done by default in the raw NAND core (nand_base.c) but was
missing in the SPI-NAND core. Without these two lines the ecc_strength
and ecc_step_size values are not exported to the user through sysfs.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8dda51bbdd11..0d21c68bfe24 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1049,6 +1049,10 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	/* Propagate ECC information to mtd_info */
+	mtd->ecc_strength = nand->eccreq.strength;
+	mtd->ecc_step_size = nand->eccreq.step_size;
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.25.1

