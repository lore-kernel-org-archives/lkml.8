Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D807C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9828207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259086;
	bh=AZXZEQCCAcc7yAFFDD4jb1Cme4oR0AkWkjL5b+2mTso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XwSdOcKoPVArmkjkH3sruRPugiKaPqwqEd3k22/4Q4T358fNOK2NOAvQI2Zzo4et9
	 5gobphL0xEJZawk9Lxg+5d7tl18T7NM2XZcYtAK34J/SKtOkjrBC1h9PodSWNcfsWL
	 m/oo0uVP8HOwbLqJfHs6Wz+6AeGYpuD12mipkIGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgHXIvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbgHXIvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:51:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD212072D;
        Mon, 24 Aug 2020 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259075;
        bh=AZXZEQCCAcc7yAFFDD4jb1Cme4oR0AkWkjL5b+2mTso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN6/Py1loI2+xUP2/CEqjP0Ua3FwzoOPQkp4gD2nOI2wH+J8+163hHrzqpcTGHK6g
         MdCyJSj+Vhv/0m8+1X615Al44GciVprV1wMjgUsOrC5nz0RSAjMdQvSTFQJ7tnLlwe
         FaRvWHrwuXJISwdCPoUnNByVi8TKShb5eXBmFlGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Liu Ying <victor.liu@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/39] drm/imx: imx-ldb: Disable both channels for split mode in enc->disable()
Date:   Mon, 24 Aug 2020 10:31:02 +0200
Message-Id: <20200824082348.647547565@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Ying <victor.liu@nxp.com>

[ Upstream commit 3b2a999582c467d1883716b37ffcc00178a13713 ]

Both of the two LVDS channels should be disabled for split mode
in the encoder's ->disable() callback, because they are enabled
in the encoder's ->enable() callback.

Fixes: 6556f7f82b9c ("drm: imx: Move imx-drm driver out of staging")
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/imx-ldb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 67881e5517fbf..2df407b2b0da7 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -317,6 +317,7 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 {
 	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
 	struct imx_ldb *ldb = imx_ldb_ch->ldb;
+	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
 	int mux, ret;
 
 	/*
@@ -333,14 +334,14 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 
 	drm_panel_disable(imx_ldb_ch->panel);
 
-	if (imx_ldb_ch == &ldb->channel[0])
+	if (imx_ldb_ch == &ldb->channel[0] || dual)
 		ldb->ldb_ctrl &= ~LDB_CH0_MODE_EN_MASK;
-	else if (imx_ldb_ch == &ldb->channel[1])
+	if (imx_ldb_ch == &ldb->channel[1] || dual)
 		ldb->ldb_ctrl &= ~LDB_CH1_MODE_EN_MASK;
 
 	regmap_write(ldb->regmap, IOMUXC_GPR2, ldb->ldb_ctrl);
 
-	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
+	if (dual) {
 		clk_disable_unprepare(ldb->clk[0]);
 		clk_disable_unprepare(ldb->clk[1]);
 	}
-- 
2.25.1



