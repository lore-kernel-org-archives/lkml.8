Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD81C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D5D20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519902;
	bh=fQ0DWWGOqMI2LHCgElUKESIoUuz8FVVSSn09zsHcakU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ih7dExUKCsMpbyhc4//d6+pcYnH73AtvKm1Q7AG3EhMS7MRqN2egLwHdbDaKGS3KD
	 AMg5rdez4MF35u+wrYWdm/4FFuEhjIrKVi1oxKF9+uDUKPsk8UeyfFaMMXl/pMZM02
	 3zhZhJnSDeRuVGH/+34zhQK2R0RKVDLXD5EC//3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbgEZTFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391440AbgEZTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:04:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE7920776;
        Tue, 26 May 2020 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519897;
        bh=fQ0DWWGOqMI2LHCgElUKESIoUuz8FVVSSn09zsHcakU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zby7Ct47lAZWYr028qjFEEMk+rLy4ADnOrxl7xZNTf2Byg1k/lgUOWfZc8AWEIofi
         P+65YofK2Ls5fUpE+FVKZLvFvpFocPmRvbd0hunt8d8PaxlNaGKPq4cYLs2bEDZIwU
         7X4v6X1F8QrH0yT5UCvKA08Ticts9tERDJkupeoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/81] mtd: spinand: Propagate ECC information to the MTD structure
Date:   Tue, 26 May 2020 20:52:44 +0200
Message-Id: <20200526183926.164686852@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
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
index a2f38b3b9776..1d61ae7aaa66 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1045,6 +1045,10 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	/* Propagate ECC information to mtd_info */
+	mtd->ecc_strength = nand->eccreq.strength;
+	mtd->ecc_step_size = nand->eccreq.step_size;
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.25.1



