Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EAC20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947726;
	bh=jv9TmoNHZvbkTcvTMR+B0Yh6jQzHQ9JleDRbuqKRw9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuRvJQPy5MlHxoVrizjSiNd6HKDsR1HTmqPYYV9g44Gma/3yU5fwF3iaTpLKJ56F3
	 OXc3b06IyO8S7IF77wSuOYrHPjKvIJNo/S3EyJRPbCj8IgqlEO3dt4LK2DjI5siQbP
	 Gk4EVUp3naYMC0snGTc1wa5u6aNDmnZ6wAMR6gnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393570AbgFWV2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388152AbgFWUPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:15:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281D32064B;
        Tue, 23 Jun 2020 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943346;
        bh=jv9TmoNHZvbkTcvTMR+B0Yh6jQzHQ9JleDRbuqKRw9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeHkc1oIOrKpXTGj7wUDSO7M4pbfzXClYZm2iGBIDMdjRZSBEIS9OLf+ohW3eGE8E
         L3ygKZE2Jf92AmuGq8LxxD4qCTWrUiznAQfC4pSOu0BJ0SnTNQ3Z9SfxPwS9Plu8Ex
         VeLKisFDr3rmEvZjJaRfR+kPYYq/zdZWJWU7mk6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 356/477] ASoC: SOF: nocodec: conditionally set dpcm_capture/dpcm_playback flags
Date:   Tue, 23 Jun 2020 21:55:53 +0200
Message-Id: <20200623195424.367102295@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit ba4e5abc6c4e173af7c941c03c067263b686665d ]

With additional checks on dailinks, we see errors such as

[ 3.000418] sof-nocodec sof-nocodec: CPU DAI DMIC01 Pin for rtd
NoCodec-6 does not support playback

It's not clear why we set the dpcm_playback and dpcm_capture flags
unconditionally, add a check on number of channels for each direction
to avoid invalid configurations.

Fixes: 8017b8fd37bf5e ('ASoC: SOF: Add Nocodec machine driver support')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20200608194415.4663-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/nocodec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index 2233146386ccf..71cf5f9db79d0 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -52,8 +52,10 @@ static int sof_nocodec_bes_setup(struct device *dev,
 		links[i].platforms->name = dev_name(dev);
 		links[i].codecs->dai_name = "snd-soc-dummy-dai";
 		links[i].codecs->name = "snd-soc-dummy";
-		links[i].dpcm_playback = 1;
-		links[i].dpcm_capture = 1;
+		if (ops->drv[i].playback.channels_min)
+			links[i].dpcm_playback = 1;
+		if (ops->drv[i].capture.channels_min)
+			links[i].dpcm_capture = 1;
 	}
 
 	card->dai_link = links;
-- 
2.25.1



