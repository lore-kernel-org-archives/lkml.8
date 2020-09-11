Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413CDC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF49221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="dna9WOP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgIKIIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:08:23 -0400
Received: from smtp1.axis.com ([195.60.68.17]:44737 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgIKIIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2561; q=dns/txt; s=axis-central1;
  t=1599811690; x=1631347690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GWBdvjMgI+JP9kgF51iEb5ue97etB2/mb8U6CHpN/hI=;
  b=dna9WOP5AaCqRgTk8JHT3FtTzhC35ATfRDWyFe86kcWnCc0w3BPSDgks
   U7+mIuCDOB/FLkdwCS5Le6b2UkFW89lflX3hE9Ifpms8iHjIIDQmpBLXP
   q/Bmbxdp2AY5268jFDS9SANzQPMsDWsZQS01I4CKZBerqPmTSs8xxPAln
   zoZ6ZYc+5vgZeRtOhrtTAgvxJs/jkF3gIfo2v+hTg1j1sdyPpHj/Ir8L5
   X5/2P90u9DQE2zXg+QpSOpwILi7SJIiR4AzDcpjTI5tBAQvl5w3vaEdGt
   P12fwzgDBj8XgPQYwwkZBxgrRLmxzKRBoNVt2amowcJeeRk8PfqEnYjZU
   A==;
IronPort-SDR: BnKEjPvVZxmSMPmALemYWoYMsfP1TELibKrRlQoks6qxAV//kiy6uMQ0GTli5SCk6uimuC/xtS
 qCm3LqGWCS1mvMbzSh1Y2aT28dhxqmxZGc/bL6ZJ5bk+4HgXB9NX+1x4vcP7nPcWSrrkFOYJT3
 /LlKjgAsNG39TEEP4d6JfvZx7/4t/9DvpYzMD0kikQIoB+6Dh9CkWj0dppvsTbdJvvq5t8k7Eo
 xJueWhdyMF06BPehVvBON+jekPq6UdtqWOUFDBJXXzR9dh/5X0eOfslW827MoML4YkPbgSIufg
 bsk=
X-IronPort-AV: E=Sophos;i="5.76,414,1592863200"; 
   d="scan'208";a="12818398"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH v2 2/3] ASoC: tlv320adcx140: Add support for configuring GPIO pin
Date:   Fri, 11 Sep 2020 10:07:52 +0200
Message-ID: <20200911080753.30342-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911080753.30342-1-camel.guo@axis.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add support to configure the GPIO pin to the specific configuration.
The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
drive can be configured with various configuration.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 44 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  4 +++
 2 files changed, 48 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index f33ee604ee78..97f16fbba441 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -837,6 +837,46 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
 
 }
 
+static int adcx140_configure_gpio(struct adcx140_priv *adcx140)
+{
+	int gpio_count = 0;
+	u32 gpio_outputs[2];
+	u32 gpio_output_val = 0;
+	int ret;
+
+	gpio_count = device_property_count_u32(adcx140->dev,
+			"ti,gpio-config");
+	if (gpio_count == 0)
+		return 0;
+
+	if (gpio_count != 2)
+		return -EINVAL;
+
+	ret = device_property_read_u32_array(adcx140->dev, "ti,gpio-config",
+			gpio_outputs, gpio_count);
+	if (ret)
+		return ret;
+
+	if (gpio_outputs[0] > ADCX140_GPIO_CFG_MAX) {
+		dev_err(adcx140->dev, "GPIO config out of range\n");
+		return -EINVAL;
+	}
+
+	if (gpio_outputs[1] > ADCX140_GPIO_DRV_MAX) {
+		dev_err(adcx140->dev, "GPIO drive out of range\n");
+		return -EINVAL;
+	}
+
+	gpio_output_val = gpio_outputs[0] << ADCX140_GPIO_SHIFT
+		| gpio_outputs[1];
+
+	ret = regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0, gpio_output_val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int adcx140_codec_probe(struct snd_soc_component *component)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
@@ -934,6 +974,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = adcx140_configure_gpio(adcx140);
+	if (ret)
+		return ret;
+
 	ret = adcx140_configure_gpo(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index eedbc1d7221f..96f067e65e2a 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -145,4 +145,8 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
+#define ADCX140_GPIO_SHIFT		4
+#define ADCX140_GPIO_CFG_MAX		15
+#define ADCX140_GPIO_DRV_MAX		5
+
 #endif /* _TLV320ADCX140_ */
-- 
2.20.1

