Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15847205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597681794;
	bh=5uDo564OW44HvyNxYlsZc/u02fwF7XtOjL5ThZ8US6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2DZ/SIvLAKkgeQIUJ1nmm5xCNInGlmSbkqp5gDmgRDjUf4BS0kBzgfzt+e64XcI23
	 7DIc05EtcIBkaqCtWkOBUseuqy5USdcHmrfNYJ7ulOgNWKRS4c41f/EkXJpvdYw5+g
	 Tl0R/MWM1v6gTPkTaD0TT5sfoWsNWv6cxd5v7D6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbgHQQ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387929AbgHQPxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:53:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D842063A;
        Mon, 17 Aug 2020 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679618;
        bh=5uDo564OW44HvyNxYlsZc/u02fwF7XtOjL5ThZ8US6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bThJa26z7wVDQMV4tOD2N7TXwXZUYtPt6h7UMHJa4X9eMJ9cw4L/zJ9JytLNFgkFc
         Tv58Dk4WMEZhr05lgVF/aOk4XQS+8eNq5G6i1uXctS9C6eEv+7mYLGCGmETnZ7Uhpc
         GANPiN3uoZoS7pLMAks6BLhMOGpY3tVETC/qXRGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 276/393] ASoC: meson: axg-tdmin: fix g12a skew
Date:   Mon, 17 Aug 2020 17:15:26 +0200
Message-Id: <20200817143833.007828101@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 80a254394fcfe55450b0351da298ca7231889219 ]

After carefully checking the result provided by the TDMIN on the g12a and
sm1 SoC families, the TDMIN skew offset appears to be 3 instead of 2 on the
axg.

Fixes: f01bc67f58fd ("ASoC: meson: axg-tdm-formatter: rework quirks settings")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200729154456.1983396-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdmin.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index 973d4c02ef8db..3d002b4eb939e 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -233,10 +233,26 @@ static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
 	},
 };
 
+static const struct axg_tdm_formatter_driver g12a_tdmin_drv = {
+	.component_drv	= &axg_tdmin_component_drv,
+	.regmap_cfg	= &axg_tdmin_regmap_cfg,
+	.ops		= &axg_tdmin_ops,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk	= false,
+		.skew_offset	= 3,
+	},
+};
+
 static const struct of_device_id axg_tdmin_of_match[] = {
 	{
 		.compatible = "amlogic,axg-tdmin",
 		.data = &axg_tdmin_drv,
+	}, {
+		.compatible = "amlogic,g12a-tdmin",
+		.data = &g12a_tdmin_drv,
+	}, {
+		.compatible = "amlogic,sm1-tdmin",
+		.data = &g12a_tdmin_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmin_of_match);
-- 
2.25.1



