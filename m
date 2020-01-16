Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E46C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B375C2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199794;
	bh=tdBSwxxCeitoPSZ6ScJGChgxmx8QvubbLNKi1Z1+VLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QO493+sVya/VuvMI0u2JXvVPHzd3BB0sQiWe0YXxw6d1Ahmf61UrYLKfHH1sbZw19
	 yfMQnfbo69zM7yoe+MqYnqDIwiW5qxefd0ROtkg2vwNiglVjGjET+Ik0fyptcQGYrE
	 dG6jM6Lvlbsat+ZPqz9z1D1eDuKNDhB/I8lJNRmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436803AbgAPSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:36:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391685AbgAPRYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FD72468D;
        Thu, 16 Jan 2020 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195452;
        bh=tdBSwxxCeitoPSZ6ScJGChgxmx8QvubbLNKi1Z1+VLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofdXbKysNZByOAQiJXWp7OpkNnWXMu018Xr7wUYLx9ItIzCuv2/FjaHnW9NFXnUvz
         6yr+BOTZM11wBt48XPQvkxJv7qgi+3xJLSRv//JW6sQQ+leZ4YNC3tqJeOn9SjdOZh
         LZafTS2dYYbhvO01j5vnDRZP1gQ9Se2lYvdwuzr4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 062/371] ASoC: imx-sgtl5000: put of nodes if finding codec fails
Date:   Thu, 16 Jan 2020 12:18:54 -0500
Message-Id: <20200116172403.18149-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8e525f7ac08d..3d99a8579c99 100644
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

