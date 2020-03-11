Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1101C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71D20691
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGUQqjtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgCKSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:04:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40630 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:04:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so3158991wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko+f04MVdRtDW1tJPAYxq3VR8XAY3gAswAGYqmbv10w=;
        b=KGUQqjtXCiM9TTaRqOalBpsoGhAuqWfLxdC6jGMu+jkWXmhHu++/mDWPhjwg5VTICC
         hWegtEImHiXCNZaoTi3Laup0KYsxQ2k085mIEQmS6D2JiSrZYeJY5ZjdXgIALRpbeSDr
         Fd+uWYZRl7wPw/zZbTgx1YmHlc+Z8dCeXcGDEljSjVACdlcDLEgRcFGnzQZi5vcCO6Ij
         QNcVufk66xuZss6cNQ4zuGxvxXCYHCbp/JY+Y/BYbHNhbuUOC+wa0MPGMlNIQPc2yEb+
         ucOGh5mhxY0yKALnJieG8fEuUWBM6rHgnePfPMBG7TUI20LlJVyodk8vIYBIOtvt8i9g
         ScXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko+f04MVdRtDW1tJPAYxq3VR8XAY3gAswAGYqmbv10w=;
        b=LrzMUE0RK29fmNsmLiC9m33a9bKtEyk/Y7pX3wLZ4TBWVxrO5cPpwPgTudHKK6wek4
         Annx5lkFGuMR3lzsrDd/3OqeHiG3m1HrwROjDMMyNzhdmchedEU6dG8zmjTYU+QzXyK8
         Zd+qqLarOSLuPs+E9s6LsOaHeAlrGr1GCghRvq22j03476XOsOX4cBNHaDAoiM3588pG
         qnCmIYBZLGnqb00q90NkNKaZ6sLWtG+6USBL8Je5ChHF5VDzLE2xYB2x9RVEIQZdnpUM
         DuUMFN2aZUAZUgqrNzpi6j3DzZkpKO1SmmHd3mbn57SXCuPnRqBX2VT4wSpdbgkdZIYb
         5EpQ==
X-Gm-Message-State: ANhLgQ1qpReosQRwLuvp1zWCMuUrlOo56ZHexEZ/IFTGq3nwpipk+x2I
        sKCxP0wBYEI3/S+awQAz8BJIag==
X-Google-Smtp-Source: ADFU+vvVrTaAUu7ON5vFK7p0ja0xplS1TC2dk+nm4D+UFMEJx/tKEtHgJH5iT2cEGJuo+5TZgIq5fg==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr4772885wmg.15.1583949883888;
        Wed, 11 Mar 2020 11:04:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z11sm8997840wmd.47.2020.03.11.11.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:04:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: qdsp6: q6asm-dai: only enable dais from device tree
Date:   Wed, 11 Mar 2020 18:04:21 +0000
Message-Id: <20200311180422.28363-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
References: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing code enables all the playback and capture dais even
if there is no device tree entry. This can lead to
un-necessary dais in the system which will never be used.
So honour whats specfied in device tree.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c0d422d0ab94..8b48815ff918 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -69,6 +69,8 @@ struct q6asm_dai_rtd {
 };
 
 struct q6asm_dai_data {
+	struct snd_soc_dai_driver *dais;
+	int num_dais;
 	long long int sid;
 };
 
@@ -889,7 +891,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.compr_ops	= &q6asm_dai_compr_ops,
 };
 
-static struct snd_soc_dai_driver q6asm_fe_dais[] = {
+static struct snd_soc_dai_driver q6asm_fe_dais_template[] = {
 	Q6ASM_FEDAI_DRIVER(1),
 	Q6ASM_FEDAI_DRIVER(2),
 	Q6ASM_FEDAI_DRIVER(3),
@@ -903,10 +905,22 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 static int of_q6asm_parse_dai_data(struct device *dev,
 				    struct q6asm_dai_data *pdata)
 {
-	static struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_dai_driver *dai_drv;
 	struct snd_soc_pcm_stream empty_stream;
 	struct device_node *node;
-	int ret, id, dir;
+	int ret, id, dir, idx = 0;
+
+
+	pdata->num_dais = of_get_child_count(dev->of_node);
+	if (!pdata->num_dais) {
+		dev_err(dev, "No dais found in DT\n");
+		return -EINVAL;
+	}
+
+	pdata->dais = devm_kcalloc(dev, pdata->num_dais, sizeof(*dai_drv),
+				   GFP_KERNEL);
+	if (!pdata->dais)
+		return -ENOMEM;
 
 	memset(&empty_stream, 0, sizeof(empty_stream));
 
@@ -917,7 +931,8 @@ static int of_q6asm_parse_dai_data(struct device *dev,
 			continue;
 		}
 
-		dai_drv = &q6asm_fe_dais[id];
+		dai_drv = &pdata->dais[idx++];
+		*dai_drv = q6asm_fe_dais_template[id];
 
 		ret = of_property_read_u32(node, "direction", &dir);
 		if (ret)
@@ -955,11 +970,12 @@ static int q6asm_dai_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, pdata);
 
-	of_q6asm_parse_dai_data(dev, pdata);
+	rc = of_q6asm_parse_dai_data(dev, pdata);
+	if (rc)
+		return rc;
 
 	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
-					q6asm_fe_dais,
-					ARRAY_SIZE(q6asm_fe_dais));
+					       pdata->dais, pdata->num_dais);
 }
 
 static const struct of_device_id q6asm_dai_device_id[] = {
-- 
2.21.0

