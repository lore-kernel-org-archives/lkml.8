Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF116C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6572063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255625;
	bh=yVDzDf7BPjN8V3Q1sj6RasbrxByVjWam1uXEnqFNqCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kd3W2mLEhFfpGDnqSBOKz79npv/o2EkkK3Nu+mWhgYOPvVx6zF/AUU+OQyqSOXfAI
	 Eq+TNND1DL/B3b4m6EYj927NDQJzJDBL8Y3ha0n/7QPYpwKD1I1IobSNC1/4NzIE3f
	 u7wAGdP3eZ6Be/mBLtRzBkAMT15rwCuIzToBXt14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgD3OHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgD3Nwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484EC208D6;
        Thu, 30 Apr 2020 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254765;
        bh=yVDzDf7BPjN8V3Q1sj6RasbrxByVjWam1uXEnqFNqCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSMFJE9OiX3uoaACvAsghtvRXNeshOFE856YUdaLMBtM+opDBhu3E2HPefVXnILN2
         j2kmmYw0Kjg+lgacxxXoDGNl0vauE33NgpDQ2T9FTjegxEILXOvIrPFtqdFDFimnmo
         ky3sZoKvPckTAyutniKwxh24nuMwS9HL3lgaN3Ho=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 23/57] ASoC: stm32: sai: fix sai probe
Date:   Thu, 30 Apr 2020 09:51:44 -0400
Message-Id: <20200430135218.20372-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit e2bcb65782f91390952e849e21b82ed7cb05697f ]

pcm config must be set before snd_dmaengine_pcm_register() call.

Fixes: 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200417142122.10212-1-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d3259de43712b..7e965848796c3 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1543,6 +1543,9 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		conf = &stm32_sai_pcm_config_spdif;
+
 	ret = snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register pcm dma\n");
@@ -1551,15 +1554,10 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
-	if (ret) {
+	if (ret)
 		snd_dmaengine_pcm_unregister(&pdev->dev);
-		return ret;
-	}
-
-	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
-		conf = &stm32_sai_pcm_config_spdif;
 
-	return 0;
+	return ret;
 }
 
 static int stm32_sai_sub_remove(struct platform_device *pdev)
-- 
2.20.1

