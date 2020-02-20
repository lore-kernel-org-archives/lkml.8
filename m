Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0F0C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863DE20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Tw8m8gSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgBTU5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:57:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34420 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgBTU5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:57:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so6219525wrm.1;
        Thu, 20 Feb 2020 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RG8nTnetEI+zdQjFw+fmF3JKM7yL0FmTV3DulfAKQCE=;
        b=Tw8m8gSMOT8HmDjVje0Qqtmvu1U75EqYkkj4CDyN694mrjiG4H9ixFL2ezGX4KPDP3
         RjqIMJCIlrU/m0Shxaa2uhHl2wTuHEFrA/kHFDRSTPMlEKfIWben3M4DFLBuw6204jVH
         iTuKVmWjSCBJr04vHF7OQcG73RbDcNi+T4WQtGbPHEwnhg4ioIebtxFg/2etrbwniV8Z
         HZEGb5wo+0xV8CYGYPyAoIZT3j6IJrBTt1glz3IaW9CBQpuFO03JuAkS5OfG6GH8ppkL
         hEQywUFRlH6qC359qrWtBjGugkoIYB3bc31prtrRyNhxwPULco1Mb3dkG1DM8Ydozbeu
         TqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RG8nTnetEI+zdQjFw+fmF3JKM7yL0FmTV3DulfAKQCE=;
        b=s1Qbbzv2xuSpdehi/8krRbHraOkc0u+rUJubt0siPsQPJTDsgiaawiCdsSG/rNCs3S
         eAlkMGYO0sjynDrzJ0Wf12PNFUb5h1kO0++LjvNrj1ykFWl8Xox6SQx5/AiszrpW2NLX
         /gZepfGejBMB1CCZ77Mn8lU1kUsVy7zH2sk/d4kctOJriqeydIps74yRp2mPXmuEPKfS
         +OfyFOPD5BaK28uSsEytOaR7EmnWUAcvyzZmFbl41/BAHqjvsj7h8Hz8oCH/thQxoemZ
         VVMWn/Utu9oJ1Zl3k/pMCbrIuckqFGpiNq32yt4aw0xu3rXEAKk/7d0MnCZ3YyURztLG
         255A==
X-Gm-Message-State: APjAAAWNy5OuVuivMb0cZYPC5Rj4L/LiYjbDuiWt6g2QcYtFDJ2SldK9
        pNhEavXW4izYLgDfSyHjG20=
X-Google-Smtp-Source: APXvYqxlxFGLAA9Vo8M059FO6ksBPW7ZfiFJySSp6CnBQQsFIx7JY0Gf28LdZvkjqbiU1JCkeMKvAQ==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr44990985wro.263.1582232240472;
        Thu, 20 Feb 2020 12:57:20 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a184sm695039wmf.29.2020.02.20.12.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:57:19 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ASoC: meson: aiu: introduce a struct for platform specific information
Date:   Thu, 20 Feb 2020 21:57:10 +0100
Message-Id: <20200220205711.77953-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
References: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a struct aiu_platform_data to make the driver aware of
platform specific information. Convert the existing check for the
internal stereo audio codec (only available on GXL) to this new struct.
Support for the 32-bit SoCs will need this as well because the
AIU_CLK_CTRL_MORE register doesn't have the I2S divider bits (and we
need to use the I2S divider from AIU_CLK_CTRL instead).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 sound/soc/meson/aiu.c | 19 ++++++++++++++++---
 sound/soc/meson/aiu.h |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index d3e2d40e9562..38209312a8c3 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -273,6 +273,11 @@ static int aiu_probe(struct platform_device *pdev)
 	aiu = devm_kzalloc(dev, sizeof(*aiu), GFP_KERNEL);
 	if (!aiu)
 		return -ENOMEM;
+
+	aiu->platform = device_get_match_data(dev);
+	if (!aiu->platform)
+		return -ENODEV;
+
 	platform_set_drvdata(pdev, aiu);
 
 	ret = device_reset(dev);
@@ -322,7 +327,7 @@ static int aiu_probe(struct platform_device *pdev)
 	}
 
 	/* Register the internal dac control component on gxl */
-	if (of_device_is_compatible(dev->of_node, "amlogic,aiu-gxl")) {
+	if (aiu->platform->has_acodec) {
 		ret = aiu_acodec_ctrl_register_component(dev);
 		if (ret) {
 			dev_err(dev,
@@ -344,9 +349,17 @@ static int aiu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aiu_platform_data aiu_gxbb_pdata = {
+	.has_acodec = false,
+};
+
+static const struct aiu_platform_data aiu_gxl_pdata = {
+	.has_acodec = true,
+};
+
 static const struct of_device_id aiu_of_match[] = {
-	{ .compatible = "amlogic,aiu-gxbb", },
-	{ .compatible = "amlogic,aiu-gxl", },
+	{ .compatible = "amlogic,aiu-gxbb", .data = &aiu_gxbb_pdata },
+	{ .compatible = "amlogic,aiu-gxl", .data = &aiu_gxl_pdata },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aiu_of_match);
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 06a968c55728..ab003638d5e5 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -27,11 +27,16 @@ struct aiu_interface {
 	int irq;
 };
 
+struct aiu_platform_data {
+	bool has_acodec;
+};
+
 struct aiu {
 	struct clk *pclk;
 	struct clk *spdif_mclk;
 	struct aiu_interface i2s;
 	struct aiu_interface spdif;
+	const struct aiu_platform_data *platform;
 };
 
 #define AIU_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |	\
-- 
2.25.1

