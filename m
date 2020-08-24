Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72140C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC9A206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288758;
	bh=8gKnCc8mi8aHr5ssqwJG9pCLlFUTA0aDudLB8OZ4lsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2yBPUgF//njixEXcdkH21P7s3xEWGUU7XV6nuWKWXJv3Vb/Aa2XE8QKXae1QIUG1
	 HMp1DgdRDV3ij2/nD5PnQU2Lvu0fVCuuz4YKLEYI6UupzOI30onpe2q+k7MEPgLAb0
	 3A5N2WL3dknbwlWhCFZ3E/Md+ijAki5gRWiPuiU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHXRFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgHXQib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E4022E02;
        Mon, 24 Aug 2020 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287087;
        bh=8gKnCc8mi8aHr5ssqwJG9pCLlFUTA0aDudLB8OZ4lsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VGVrlbJidj2WbJMf8rNBJnuqsQ9C5mG4NlYLqmtWDymeugbSiQlWZkJsDl2btejl
         GEtuN8BXDrOaMLk1cbTO8u7rLftGcUqcaJ+sve8rWesQQvEUure9a/ru9SSUEtyGoQ
         cwUOIZoSmWCEVfhBpPQqgcGJjNO0ck1EnKwOLMHM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Alain Volmat <alain.volmat@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 12/38] spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
Date:   Mon, 24 Aug 2020 12:37:24 -0400
Message-Id: <20200824163751.606577-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 264a7e937f9eb..54fc14e08cee9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -442,7 +442,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 {
 	u32 div, mbrdiv;
 
-	div = DIV_ROUND_UP(spi->clk_rate, speed_hz);
+	/* Ensure spi->clk_rate is even */
+	div = DIV_ROUND_UP(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
 	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-- 
2.25.1

