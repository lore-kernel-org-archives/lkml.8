Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764A220776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521099;
	bh=5dYKczIvQ+iFI127IXOGGHsWU0/YsZaZeXftt1nV9sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjnB2rB1yKWQJLoIXt6ahXtiCq4VuVZH1LZ0NrQrvzppFtF9vZK/FbsIFAt6YtJ+R
	 X3vsVkgQpBpBfNh2fnBzDzfzH4UHYMSu9SPXzdVzlQViPWYfeSLA1I//9opW33iss8
	 iHBOknBYsMmJ1ThE9Tdrvz+WAoFlrOKfHLSXWYq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392525AbgEZTY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390353AbgEZTHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:07:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB1620776;
        Tue, 26 May 2020 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520036;
        bh=5dYKczIvQ+iFI127IXOGGHsWU0/YsZaZeXftt1nV9sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8V+jnKV9OnOTqqXPql4HlBJC97u70uTZpFOef1lFcQT3iC8Adjh97JZRjqpxGuWA
         jvM5gshMBhdBkRbtfbJJbmBIpTARsh2cAWhLQbHNTNubcoq5Bm6vFA/akzQMSrkXwy
         h6r3DjpRSLEJGGgm0uhKDxEmtRCwyzTcu1dO1x6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 008/111] mtd: spinand: Propagate ECC information to the MTD structure
Date:   Tue, 26 May 2020 20:52:26 +0200
Message-Id: <20200526183933.304835227@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



