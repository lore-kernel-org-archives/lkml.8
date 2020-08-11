Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E427C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E06420656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pe3SJSUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgHKKZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgHKKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:25:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:25:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs17so8674259edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE2Owqviue/VQIXGk6mVLnEvDF33jGGXHgxlHjLuh/g=;
        b=Pe3SJSUZ+vkfgPFgS5Ata/faB6BErqPNLSX71PgTg6EpmCYHXqzuuYILr082+uF+Vh
         3MxncsZE+KaWFYMdBfFtn4E6YLavtrALT+MztOdCtwWgkqciIUFChZK1tbDGkWnCL42z
         52fCBFF4F/gRMALt5efXhPqirlwsYS4Bdmlczd5tqtxFOH2Rg2K/Ccw4siRbYjbuJtqN
         ulh7S+8c2thaMXICdmY/xBGL4vzOUoJUZ+T9/G+LOSdan0uSEZtYD0Vt6EPweZJhEOKz
         I9yH/e/qfPE5/mWDFC//nO3s1gO6lshMezP5wp0yU5QWRQiOUM+D9VjFvGwn3dkAMNkp
         W2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE2Owqviue/VQIXGk6mVLnEvDF33jGGXHgxlHjLuh/g=;
        b=IVmgNwM8uZlHaFHxPKOLCuMGsBJR0mYwh101nqZq755PTN4nLzsc2BQtnZxwN4gI/P
         1QjTn9YJH1TmNmrwIxyPRfLuq/a4/lPGru5DDgI6ir2qpTQwsdfwkxCignRKWUrQG6QF
         bSHq1bri5tVSLGRXuTjrIUGqudd3rXKtGAnqsRtdqRzTDTEk3KQW1IOBQ9kDcSx7ZgId
         kyVTG6lRSxIMYc6EcblEv4KBKbpYHETOARtMfG4NGP4UwlljjMzO4HzmnsT4IiJiGDgA
         M7C5ZYxmaEdrv6VJH5bADEpLrwmgxz2pD3vXmMsn8v1wBxftH53ABlvlcmgEEAKfX4E6
         ueDg==
X-Gm-Message-State: AOAM532UHD9nq+QbjoYIl4s36oRAUp+g4mRz3L0e62ULIaGoHzljgQ/I
        StE7nAS1OuqQloXx8Z3bMQLf4g==
X-Google-Smtp-Source: ABdhPJwyjbinnjY6qvExiC6LJv5rawE65Y9qVNsEqu/7UT4pEtUrxKdedoviaZuV8xcdXXlgUM1IvA==
X-Received: by 2002:aa7:dc44:: with SMTP id g4mr25707392edu.273.1597141557638;
        Tue, 11 Aug 2020 03:25:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v14sm14864196ejb.63.2020.08.11.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:25:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: q6afe-dai: add dummy register read function
Date:   Tue, 11 Aug 2020 11:25:51 +0100
Message-Id: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the DAPM widgets for DSP ASoC components reuse reg field
of the widgets for its internal calculations, however these are not
real registers. So read/writes to these numbers are not really
valid. However ASoC core will read these registers to get default
state during startup.

With recent changes to ASoC core, every register read/write
failures are reported very verbosely. Prior to this fails to reads
are totally ignored, so we never saw any error messages.

To fix this add dummy read function to return default value.

Reported-by: John Stultz <john.stultz@linaro.org>
Fixes: 24c4cbcfac09 ("ASoC: qdsp6: q6afe: Add q6afe dai driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 2a5302f1db98..492bdbaf13c4 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1352,6 +1352,13 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, 0, 0, 0),
 };
 
+static unsigned int q6afe_reg_read(struct snd_soc_component *component,
+				   unsigned int reg)
+{
+	/* default value */
+	return 0;
+}
+
 static const struct snd_soc_component_driver q6afe_dai_component = {
 	.name		= "q6afe-dai-component",
 	.dapm_widgets = q6afe_dai_widgets,
@@ -1359,7 +1366,7 @@ static const struct snd_soc_component_driver q6afe_dai_component = {
 	.dapm_routes = q6afe_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(q6afe_dapm_routes),
 	.of_xlate_dai_name = q6afe_of_xlate_dai_name,
-
+	.read = q6afe_reg_read,
 };
 
 static void of_q6afe_parse_dai_data(struct device *dev,
-- 
2.21.0

