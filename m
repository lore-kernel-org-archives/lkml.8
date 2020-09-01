Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F3DC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA632087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978358;
	bh=loNW8vulpaTwGdG8J1vyIIQEP2OudAGgSdq4gP20T0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0klR9MKP/xIZqjUKdsgcJ2s2HO7K/brx7rmFH2tCFi9TP8MhLuH/UESYWCdKATpl
	 K5wLXrmmaR1tet5jRsXbVNSneA84zekq5szk6o7os/QILF2Z3oitnb8Ga8KG7HTgPJ
	 ugF8fO8Fqa2GY/OKbRDZsAIhi01JKICqeTBI+1tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgIAP2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgIAPZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:25:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2672020BED;
        Tue,  1 Sep 2020 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973914;
        bh=loNW8vulpaTwGdG8J1vyIIQEP2OudAGgSdq4gP20T0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+OUm3zDuV4uKw0BwRxsPwQ4vizhhDMqZX5wL0nsZDuW/+YTy/p9ee1pbB54tVx3d
         F6OguB9VGgxdjKAQb4RH7XX723ml11MDuN7UHAL2yL/4yx7ayj2jl7GgDNIYi41IAn
         ghhI9W1Dulo+sUgNEcxatB1iIlJ7S2pEGO31HPcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>,
        Alain Volmat <alain.volmat@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/125] spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
Date:   Tue,  1 Sep 2020 17:10:22 +0200
Message-Id: <20200901150937.856694702@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

[ Upstream commit 9cc61973bf9385b19ff5dda4a2a7e265fcba85e4 ]

Fix spi->clk_rate when it is odd to the nearest lowest even value because
minimum SPI divider is 2.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
Link: https://lore.kernel.org/r/1597043558-29668-4-git-send-email-alain.volmat@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ad1e55d3d5d59..391a20b3d2fda 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -254,7 +254,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 {
 	u32 div, mbrdiv;
 
-	div = DIV_ROUND_UP(spi->clk_rate, speed_hz);
+	/* Ensure spi->clk_rate is even */
+	div = DIV_ROUND_UP(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
 	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-- 
2.25.1



