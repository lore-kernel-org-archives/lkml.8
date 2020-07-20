Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE5EC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17D12064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260349;
	bh=nh1xRDrN6zBEI2NrGoxZOGj0ZeTCvBgg7tyKQG3W9mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YOBRX5svWLskF5LiPk0np4VkNRyL/75TDqcpMW5zlVmqoYSYs/0UJaw8R5yqOmBdM
	 mVOeRUwOa2YXaUv0GYYGqxZNBj+auzxildF/56a4savNIroPoKxOTd9SIJD90QZ++6
	 et7wQZ6iXwZClSK1hRhERGPAdhpi7eKD2HpGJQpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgGTPw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbgGTPwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4107F22CF6;
        Mon, 20 Jul 2020 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260338;
        bh=nh1xRDrN6zBEI2NrGoxZOGj0ZeTCvBgg7tyKQG3W9mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+GiSVN/8zXi49LdbPgjz2Hsiri6oSQJ2qJfbJ3FWfn7vMn6yA9nj4oQdtYTffJfi
         5pkoSi90Xt5wZ0uLr8WsCC56ebxrdPLOSEX82Mjw+AaoGDPXiO8Goj290PIOpTW72k
         ZAG3JcI8wma7WGgstr3ylsbEflI7VT8QsvsLV9sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Angelo Dureghello <angelo@sysam.it>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/133] spi: fix initial SPI_SR value in spi-fsl-dspi
Date:   Mon, 20 Jul 2020 17:36:24 +0200
Message-Id: <20200720152805.510958657@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo@sysam.it>

[ Upstream commit aa54c1c9d90e6db75190813907190fadcce1bf45 ]

On ColdFire mcf54418, using DSPI_DMA_MODE mode, spi transfers
at first boot stage are not succeding:

m25p80 spi0.1: unrecognized JEDEC id bytes: 00, 00, 00

The reason is the SPI_SR initial value set by the driver, that
is not clearing (not setting to 1) the RF_DF flag. After a tour
on the dspi hw modules that use this driver(Vybrid, ColdFire and
ls1021a) a better init value for SR register has been set.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 2844c9a72a980..1144d022cc582 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -71,7 +71,7 @@
 #define SPI_SR			0x2c
 #define SPI_SR_EOQF		0x10000000
 #define SPI_SR_TCFQF		0x80000000
-#define SPI_SR_CLEAR		0xdaad0000
+#define SPI_SR_CLEAR		0x9aaf0000
 
 #define SPI_RSER_TFFFE		BIT(25)
 #define SPI_RSER_TFFFD		BIT(24)
-- 
2.25.1



