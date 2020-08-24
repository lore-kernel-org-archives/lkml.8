Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ACDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0B4207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598263009;
	bh=1KZTkyyQvb4ak/RXe1qfPICijwZ/tYPNPs68qQFUQUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MtVbMN1diMyFhZ7KhwYiqjH/Ujwnrjdh4Jla2UkuGFYxSj9tg1uK0KEHjuwkmv3Pn
	 6Ctv6suzwq6uCYGmcXUfLQZjpNvJj2khSF/5UWZD1vsZsWJ2TEL71wQkHU+MqvQGYu
	 g1DzRTFLn4rkjC/u+c4CUIJ4bDeK4MvXV84babIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgHXIfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgHXIfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:35:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67176207D3;
        Mon, 24 Aug 2020 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258111;
        bh=1KZTkyyQvb4ak/RXe1qfPICijwZ/tYPNPs68qQFUQUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uv0X2y9J4UBwgd7rl0Vc5+ZplUgvIGXPPdpJnVZxagHzypzuQYDzTR25nQzDzxF9r
         gO8uxD1+D1je9nWxwmhqg3RHl9VMrYLA51faQa8M1HX6JTI9DbHYktfDjOb47LuACZ
         nXF1UqGD/sEmLQBdv0534KJkAU2BtVZ1f1OKAqi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 078/148] ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
Date:   Mon, 24 Aug 2020 10:29:36 +0200
Message-Id: <20200824082417.812359407@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 56235e4bc5ae58cb8fcd9314dba4e9ab077ddda8 ]

Looks like the q6afe-dai dapm widget registers are set as "0",
which is a not correct.

As this registers will be read by ASoC core during startup
which will throw up errors, Fix this by making the registers
as SND_SOC_NOPM as these should be never used.

With recent changes to ASoC core, every register read/write
failures are reported very verbosely. Prior to this fails to reads
are totally ignored, so we never saw any error messages.

Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200811120205.21805-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 210 +++++++++++++++----------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 2a5302f1db98a..0168af8492727 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1150,206 +1150,206 @@ static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
 }
 
 static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
-	SND_SOC_DAPM_AIF_IN("HDMI_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_RX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_TX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_TX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_TX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_TX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_TX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_TX", NULL, 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("HDMI_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_TX", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_RX", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_TX", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_MI2S_RX", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_TX", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_MI2S_RX", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_TX", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_MI2S_RX_SD1",
 			"Secondary MI2S Playback SD1",
-			0, 0, 0, 0),
+			0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRI_MI2S_RX", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_TX", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_0", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_1", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_2", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_3", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_4", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_5", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_6", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_7", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_0", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_1", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_2", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_3", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_4", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_5", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_6", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_7", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_0", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_1", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_2", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_3", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_4", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_5", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_6", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_7", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_0", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_1", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_2", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_3", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_4", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_5", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_6", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_7", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_0", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_1", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_2", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_3", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_4", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_5", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_6", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_7", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_0", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_1", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_2", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_3", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_4", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_5", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_6", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_7", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_0", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_1", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_2", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_3", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_4", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_5", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_6", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_7", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_0", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_1", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_2", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_3", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_4", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_5", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_6", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_7", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_0", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_1", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_2", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_3", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_4", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_5", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_6", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_7", NULL,
-			     0, 0, 0, 0),
+			     0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_0", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_1", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_2", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_3", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_4", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_5", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_6", NULL,
-						0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
-						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, 0, 0, 0),
+						0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
2.25.1



