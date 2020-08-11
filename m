Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD692075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xl+yas4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgHKMCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgHKMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:02:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C16C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:02:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so8429238ejs.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS3knjmf2olzwbjqVSue9NVEfHLC1OBzOt29LxllL1c=;
        b=Xl+yas4maK8tO3TyP2eIj43TYiIap9CJVgInBiAO/ufnS9q09r3dqM0tJR8OxMon3E
         /1V6RWtGpbrFc6dFiqoaTNArUoLubtx/PdV0aYUc8DT5+ewWMBp3HUqyN/w6DO0+ZjXJ
         Y2WM/JFZfBoYSVeRPpRWoH72meYJ4MOM9nG2wYxWvM462BDxl7O0Hvb/Nac6H8hR90M3
         AkyRjS62snE1EoY0Set0lApjhAHxBn0sMAXeQtiher/Hoap4OoeVWgZQYutlqf7z85Ga
         jgrTfZ820/XZ5aOB/F4PVTO/6tJL6SBKUZvgOSjKZJ9jCkZInkpeeHryyQ4npVrlLyf5
         Ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS3knjmf2olzwbjqVSue9NVEfHLC1OBzOt29LxllL1c=;
        b=TZG8yuJ90TXIyt+gNz5dPNjzriWitg8h4mcrnuvnWxw+vFsYHlEbEGlVIZKcZwoci1
         fb3t0fHOf86fo47V55oxvFcfKX3u69DzlWQkmJXCp6mE4qQQp9WxWJReXc7N5edDuVg0
         dNXpbPyitSkR9jiZGzTDzXwxvEDqtwQLgM3Or4CCpf3b6mB1spkIdDfjjEbKdQL3mK3r
         GVnev/pPIptyvjfDFBPTpbjtEjdJ8EXP1qGF7M5YuZO1UNhC9WxxNTgvMs77LpB6N+4i
         gDDgJoOxJQppi8Z7nNnJTYVerEDlgmmHLd5teA9PbWysuEq91szJ4IAUrDD+peJD+I0j
         MXUQ==
X-Gm-Message-State: AOAM533xD6H8guCuXb5H2N0p7EuOhvtuTQ00AQ7aok0UVPkr1qcZwako
        oPXqYgnLx+e0kntJfi+HqSPkYw==
X-Google-Smtp-Source: ABdhPJw884vjrIRU0UMP1f+MNUj5qRAYw98YTvDZoecYpYw8d8inavVt2Ur1URHilmqIadhxLZMtCg==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr10484703ejb.292.1597147333305;
        Tue, 11 Aug 2020 05:02:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f21sm14238363edv.66.2020.08.11.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 05:02:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org, stephan@gerhold.net,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] ASoC: q6afe-dai: mark all widgets registers as SND_SOC_NOPM
Date:   Tue, 11 Aug 2020 13:02:04 +0100
Message-Id: <20200811120205.21805-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the q6afe-dai dapm widget registers are set as "0",
which is a not correct.

As this registers will be read by ASoC core during startup
which will throw up errors, Fix this by making the registers
as SND_SOC_NOPM as these should be never used.

With recent changes to ASoC core, every register read/write
failures are reported very verbosely. Prior to this fails to reads
are totally ignored, so we never saw any error messages.

Reported-by: John Stultz <john.stultz@linaro.org>
Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- replaced reg 0 with SND_SOC_NOPM and removed read callback

 sound/soc/qcom/qdsp6/q6afe-dai.c | 210 +++++++++++++++----------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 2a5302f1db98..0168af849272 100644
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
2.21.0

