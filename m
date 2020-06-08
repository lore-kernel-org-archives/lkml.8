Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B966C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B9B2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657615;
	bh=zJyy96p/S5Lp67gqr1bh7mhGEJc1LIXF5relYqsc5RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2CkRpl81zXnAuL8TJLIp66g2DT81UY7b0tJkI5cBfkl5ZPAnNH9a8sWGGr52L8KZ
	 UdHBYnBugkOKr8dbsgs43l2nEnb0pV77bXNq9GiJ22fZAIe6cYWyBq/LLlHmHZYy8o
	 LJmFYYHsib4YODvbiSMVNEv7Jhg7/CdhX/1/ni1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgFHXGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgFHXGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC83D20774;
        Mon,  8 Jun 2020 23:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657590;
        bh=zJyy96p/S5Lp67gqr1bh7mhGEJc1LIXF5relYqsc5RM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWuAW5ks9URcrPAuqgZb08nUkOdo+EE+XPtSAzshPhJXKNbwntu1Ho+tltJAo/wyT
         Zq5Vqp2wEt392zhL20zb0UdqZR2b2Iam1TLVYcvSYPu/g+sZHugHLIMvKAzvpbCc7l
         PDn2I+0/9pqeRF8ULlyV/QlMjkDqg0s6l6Sifw68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 018/274] spi: spi-mem: Fix Dual/Quad modes on Octal-capable devices
Date:   Mon,  8 Jun 2020 19:01:51 -0400
Message-Id: <20200608230607.3361041-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

