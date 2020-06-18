Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE02C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D2020885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446629;
	bh=082nMbW7W4EL25ot2oiMRYNGZ531syXYTu7mVW7Gabo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r5GUwnFv5YGM++tyIBKwITCTXmEIOwoIvmvRj2qo874X7/7Msegsj5ot1RbU/Maka
	 3rLabrHeu310H2UkUN+oT4SvB8zGuOGgPBdaFoRo5KvlJCrUivdZRzCk+KoAWyBDb7
	 e3AuM+flWFuc/e0Mnhq6NGjgBspcufffOAatnLNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgFRBUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgFRBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:16:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA71221ED;
        Thu, 18 Jun 2020 01:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443005;
        bh=082nMbW7W4EL25ot2oiMRYNGZ531syXYTu7mVW7Gabo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vf243AJj/k+EsVeXSSw/2fKB9ZWYnapKldOO1HYH3sZ/RhFUDKL9dPXX2jHsjCFIB
         twDlHUGDnbaqbUYV9wP/FrSHetIFoUbSDYPVVGKxebiBdoWTdQ9EXSl9/EEekMXnwJ
         ifRc0jnJOZhpmEyQS4dYG+zGk5lE7u8NI7caGif8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 010/266] ASoC: fsl_esai: Disable exception interrupt before scheduling tasklet
Date:   Wed, 17 Jun 2020 21:12:15 -0400
Message-Id: <20200618011631.604574-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 1fecbb71fe0e46b886f84e3b6decca6643c3af6d ]

Disable exception interrupt before scheduling tasklet, otherwise if
the tasklet isn't handled immediately, there will be endless xrun
interrupt.

Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7a49d03463a..84290be778f0 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -87,6 +87,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
 	if ((saisr & (ESAI_SAISR_TUE | ESAI_SAISR_ROE)) &&
 	    esai_priv->reset_at_xrun) {
 		dev_dbg(&pdev->dev, "reset module for xrun\n");
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				   ESAI_xCR_xEIE_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+				   ESAI_xCR_xEIE_MASK, 0);
 		tasklet_schedule(&esai_priv->task);
 	}
 
-- 
2.25.1

