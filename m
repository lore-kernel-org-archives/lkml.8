Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E53EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2796424683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222677;
	bh=5q3qoVVuTy8YvTWJS56/FshoR2Qy/XfFf6H6ywclMsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k8U7GmDRdfnZ4EOPdT4x18uzb2a+uSiJhyJLqQs2BIflhIlMiYpy5kbFH1msNhe+7
	 08PuqxRVWwtGWxqv8wlBv13xwBVHH+Yl/lCzb0zklXHCT/8Tcw7HiWMI123+rkzSj/
	 Du6fEigAQPescXxG3fi1Yv2XXCHKIhQDnLvd6Lvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgA1Oog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgA1OKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C632B24681;
        Tue, 28 Jan 2020 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220604;
        bh=5q3qoVVuTy8YvTWJS56/FshoR2Qy/XfFf6H6ywclMsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmdlQMibek3tvW+vTmaZkm6XYMMvuP7C1UeMcinIeKYVJCxcvl040zoVL2fIrjaYF
         PCvkgotQpIoKO+HXdfcpPG5sWmz59YHVddtIqFSJy+lfnC4pkDZcQUysNVhOQDTFZx
         ItzXO8s8Dt3KgLQ+9G0/Ol+I3py1iwrLxgdL1fFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 036/183] ASoC: imx-sgtl5000: put of nodes if finding codec fails
Date:   Tue, 28 Jan 2020 15:04:15 +0100
Message-Id: <20200128135833.615853745@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
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



