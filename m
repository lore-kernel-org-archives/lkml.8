Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7454CC5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4685C20774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TbVj8OhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgCROnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:43:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCROnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:43:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IEcsvs022631;
        Wed, 18 Mar 2020 15:42:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qmRrscMq5Bm23UmAjzqLg4xvf0NZtoGZEA7BhOJb94E=;
 b=TbVj8OhFuzNmHhA0OWHk0QYdoahepFdELxVgfVl9jg5UmrciYbZ40CODzLUxVrCckg0Y
 Y2tI2JL39ei2SUegWJYeIGogBmsHdMCKMpwmUjW2OLq4E2B9Okw963GhA8scniEMqb11
 Ieh8NP3loRLqg2oxYTNCmlbMo+7Dk1qaZGNoLgI/sr+rbsBsNLeM2Vmoib6RFkgoC768
 Q8nQaH4wCxBr9Lp/Vy51tU+IJX6otXkX7GFrrvEc2vqRuLoThbKImKSmwW4rTxGoGIGP
 7+c2SHsseqpf1yJAZUYgQURcqY3Tx0xieXmfpzC2SiOaG40+8ELoLD5Hge9zrn10w/5B vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu6xdckqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 15:42:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9C0C210002A;
        Wed, 18 Mar 2020 15:42:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8F1522AE6C9;
        Wed, 18 Mar 2020 15:42:28 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Mar 2020 15:42:26
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: stm32: i2s: manage rebind issue
Date:   Wed, 18 Mar 2020 15:41:25 +0100
Message-ID: <20200318144125.9163-4-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318144125.9163-1-olivier.moysan@st.com>
References: <20200318144125.9163-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_06:2020-03-18,2020-03-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e894efef9ac7 ("ASoC: core: add support to card rebind")
allows to rebind the sound card after a rebind of one of its component.
With this commit, the sound card is actually rebound,
but may be no more functional.

Corrections:
- Call snd_dmaengine_pcm_register() before snd_soc_register_component().
- Call snd_dmaengine_pcm_unregister() and snd_soc_unregister_component()
explicitly from I2S driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 2478405727c3..7c4d63c33f15 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -888,6 +888,14 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int stm32_i2s_remove(struct platform_device *pdev)
+{
+	snd_dmaengine_pcm_unregister(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
 static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
@@ -921,47 +929,56 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->regmap);
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
-					      i2s->dai_drv, 1);
-	if (ret)
-		return ret;
-
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
-					      &stm32_i2s_pcm_config, 0);
+	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
 		return ret;
 	}
 
+	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
+					 i2s->dai_drv, 1);
+	if (ret) {
+		snd_dmaengine_pcm_unregister(&pdev->dev);
+		return ret;
+	}
+
 	/* Set SPI/I2S in i2s mode */
 	ret = regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 				 I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = regmap_read(i2s->regmap, STM32_I2S_IPIDR_REG, &val);
 	if (ret)
-		return ret;
+		goto error;
 
 	if (val == I2S_IPIDR_NUMBER) {
 		ret = regmap_read(i2s->regmap, STM32_I2S_HWCFGR_REG, &val);
 		if (ret)
-			return ret;
+			goto error;
 
 		if (!FIELD_GET(I2S_HWCFGR_I2S_SUPPORT_MASK, val)) {
 			dev_err(&pdev->dev,
 				"Device does not support i2s mode\n");
-			return -EPERM;
+			ret = -EPERM;
+			goto error;
 		}
 
 		ret = regmap_read(i2s->regmap, STM32_I2S_VERR_REG, &val);
+		if (ret)
+			goto error;
 
 		dev_dbg(&pdev->dev, "I2S version: %lu.%lu registered\n",
 			FIELD_GET(I2S_VERR_MAJ_MASK, val),
 			FIELD_GET(I2S_VERR_MIN_MASK, val));
 	}
 
+	return ret;
+
+error:
+	stm32_i2s_remove(pdev);
+
 	return ret;
 }
 
@@ -998,6 +1015,7 @@ static struct platform_driver stm32_i2s_driver = {
 		.pm = &stm32_i2s_pm_ops,
 	},
 	.probe = stm32_i2s_probe,
+	.remove = stm32_i2s_remove,
 };
 
 module_platform_driver(stm32_i2s_driver);
-- 
2.17.1

