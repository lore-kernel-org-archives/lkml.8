Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2DB206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581454;
	bh=T+jPFC0lA+eBgkxLgd3PN4lxPcbqGMXjwaRExUrc1pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NmcG+ReSzjmB/UPDY3M6ZZmjxfif+SSYkkOIMYRXfZQ2TnuEeYMqunu9WFUkBDBr4
	 Y15PzQnV+aDJOsB2IXpp1K3/knMmxF7jReINvfteOL4bmZqTb3ZZW8tPPzB5ckkLNT
	 nIXu8GLN9y35fdTR6YreOT+h+2a+gasKIv1gEryc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404492AbgFSP2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393371AbgFSP1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:27:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBD320734;
        Fri, 19 Jun 2020 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580419;
        bh=T+jPFC0lA+eBgkxLgd3PN4lxPcbqGMXjwaRExUrc1pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0BqSmM9amzxL8kRl/jfwTfZCN2DtPofx9jKO32pBjjqgzoyaunklC772B+xrOZ51
         cau8TwxAnUNqkL7klmJLHsok5lFpnQx3Wfx58oLZ+7wURAOjvPd6ltim5dE4fBE41g
         BoSIpDqxPHzKQ+ryGIuYg25egUzjV1rrTYDzf2yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 240/376] spi: spi-fsl-dspi: fix native data copy
Date:   Fri, 19 Jun 2020 16:32:38 +0200
Message-Id: <20200619141721.690045233@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo.dureghello@timesys.com>

[ Upstream commit 263b81dc6c932c8bc550d5e7bfc178d2b3fc491e ]

ColdFire is a big-endian cpu with a big-endian dspi hw module,
so, it uses native access, but memcpy breaks the endianness.

So, if i understand properly, by native copy we would mean
be(cpu)->be(dspi) or le(cpu)->le(dspi) accesses, so my fix
shouldn't break anything, but i couldn't test it on LS family,
so every test is really appreciated.

Fixes: 53fadb4d90c7 ("spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics")
Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200529195756.184677-1-angelo.dureghello@timesys.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 50e41f66a2d7..2e9f9adc5900 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -246,13 +246,33 @@ struct fsl_dspi {
 
 static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
 {
-	memcpy(txdata, dspi->tx, dspi->oper_word_size);
+	switch (dspi->oper_word_size) {
+	case 1:
+		*txdata = *(u8 *)dspi->tx;
+		break;
+	case 2:
+		*txdata = *(u16 *)dspi->tx;
+		break;
+	case 4:
+		*txdata = *(u32 *)dspi->tx;
+		break;
+	}
 	dspi->tx += dspi->oper_word_size;
 }
 
 static void dspi_native_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
 {
-	memcpy(dspi->rx, &rxdata, dspi->oper_word_size);
+	switch (dspi->oper_word_size) {
+	case 1:
+		*(u8 *)dspi->rx = rxdata;
+		break;
+	case 2:
+		*(u16 *)dspi->rx = rxdata;
+		break;
+	case 4:
+		*(u32 *)dspi->rx = rxdata;
+		break;
+	}
 	dspi->rx += dspi->oper_word_size;
 }
 
-- 
2.25.1



