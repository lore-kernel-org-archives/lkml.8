Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26D0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB0620809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582288;
	bh=zJyy96p/S5Lp67gqr1bh7mhGEJc1LIXF5relYqsc5RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3jK7dTecX2HNdQdFaS3E+Kv1PzejwkYD33fenPDJY4NahWPTHTUq91y0fK3LeYuS
	 FK5ZSxvwjGplwSB4OP2LtcufiavlhJonYsilUr+2xAYBu293FiLzvUbSolNAMg8S0u
	 X1L4mherT0EmckDN5QICbSs/oPm/z5QiigEyMQaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404228AbgFSPTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392582AbgFSPSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB5F21835;
        Fri, 19 Jun 2020 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579892;
        bh=zJyy96p/S5Lp67gqr1bh7mhGEJc1LIXF5relYqsc5RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVXw0n/4+Z9CxRRNt315OR0fnKNpZU2ZZrtwdwfuLS+130+0FsOfQFn/4BBh0yANq
         oFkS6FwyxKuVd0qT1OrSXCmbhJfi1YTzHb4+YNCJ25AOi6VWCJVRvJOkd+HvVpuuqK
         R+fhjIsuSMfVYQF3kXLX8i1QpWM7nGURd3chltZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 016/376] spi: spi-mem: Fix Dual/Quad modes on Octal-capable devices
Date:   Fri, 19 Jun 2020 16:28:54 +0200
Message-Id: <20200619141711.137253615@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 80300a7d5f2d7178335652f41d2e55ba898b4ec1 ]

Currently buswidths 2 and 4 are rejected for a device that advertises
Octal capabilities.  Allow these buswidths, just like is done for
buswidth 2 and Quad-capable devices.

Fixes: b12a084c8729ef42 ("spi: spi-mem: add support for octal mode I/O data transfer")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200416101418.14379-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index adaa0c49f966..9a86cc27fcc0 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -108,15 +108,17 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
-- 
2.25.1



