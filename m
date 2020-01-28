Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BD624688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220994;
	bh=5q3qoVVuTy8YvTWJS56/FshoR2Qy/XfFf6H6ywclMsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZZiSEMLnIA7nbDfTEk/c7FOK5tY+5CxQUJIjnfd4uVnIzGZcCGVGkQg1mlbZ0aqe
	 xAEgNsPrHCMVNf4aRFcYJpxHFXao3441PCAvAz/0wxjBnP0K4XsJD/kLwyjcRWShA9
	 afm5pUVUkr/HRnbp84b4ilN2IOhFGIeXODnuk9wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgA1OQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgA1OQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:16:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A919624692;
        Tue, 28 Jan 2020 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220990;
        bh=5q3qoVVuTy8YvTWJS56/FshoR2Qy/XfFf6H6ywclMsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBZaYjKf6kNEjsUcCFGfggt/fqh+iTpi6ShaeO2QBMV9YrHY+YMMLnmNx4IGuQa09
         cZKhzIusrHU92nM0eBBqttsDWAvV6WEbcEctOkjp5jh5JlcRsIrtvnQ/9J0HF4bgX1
         mJ/reJqBcS640xmoyKfCOZtv0zIoc88KCe3WZ1FM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 045/271] ASoC: imx-sgtl5000: put of nodes if finding codec fails
Date:   Tue, 28 Jan 2020 15:03:14 +0100
Message-Id: <20200128135856.001364289@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit d9866572486802bc598a3e8576a5231378d190de ]

Make sure to properly put the of node in case finding the codec
fails.

Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-sgtl5000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 8e525f7ac08d1..3d99a8579c99f 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -119,7 +119,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto fail;
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-- 
2.20.1



