Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F64AC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E1F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263480;
	bh=nMIUeSSD+Emtx7Rx3Oh+WjaxNTlUbVbGWyjwxcCGi5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRewb+0ivtVIrqBVfcfJcTH4C3vOFcQzOL0KHsepjPulvTLBpYRm9Va/QnnyKhOG3
	 cYoy5SjQwLOqNjNFCXCWdD6Ke2RtZuQwTeMZlvYub/RAb8NEccUORHeJefmgSl6kVS
	 c0ePGdiuuAPSQgEw1mGC6Rev6HHt0kYf4fWFor2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgGTQoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgGTPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE422065E;
        Mon, 20 Jul 2020 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259695;
        bh=nMIUeSSD+Emtx7Rx3Oh+WjaxNTlUbVbGWyjwxcCGi5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utH9ejX+LTNVJZ2GZND4KyT3vfeHCjNHP1YBmLrWYfG98uPR43TvbMznCRsYfgT2n
         B/qRoLxfD36vn3iSDd9Iaq5ciPaN6wEQXr/u6WFVN3rVSyryGTfZisUYPb+aT1uG7O
         VLkjKzldsW3xv6QDPJcyt0njb+LE0x7RUWcFHIaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Angelo Dureghello <angelo@sysam.it>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 47/86] spi: fix initial SPI_SR value in spi-fsl-dspi
Date:   Mon, 20 Jul 2020 17:36:43 +0200
Message-Id: <20200720152755.527760275@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
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
index db3b6e9151a81..672152b49d95c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -70,7 +70,7 @@
 #define SPI_SR			0x2c
 #define SPI_SR_EOQF		0x10000000
 #define SPI_SR_TCFQF		0x80000000
-#define SPI_SR_CLEAR		0xdaad0000
+#define SPI_SR_CLEAR		0x9aaf0000
 
 #define SPI_RSER		0x30
 #define SPI_RSER_EOQFE		0x10000000
-- 
2.25.1



