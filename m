Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693DEC2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B97621D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BU07gu7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIJV1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731002AbgIJOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F976C061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:57:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so135289wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5LHymWJ1t58cRZI4MxwTqiMv3bCXN9LR4UYb0nY9Ks=;
        b=BU07gu7RbTwVUCaVgyCcrK6dlZRCQMCpP0JLqt4VxVj9PkiQON6snK8y8evDWZJ9C7
         G8ssLCUwz9l9RP5wku9eS6dKXlZIhl4KGyrHEFlyTNQ69idDig2PugrYXY+znUd1vB3n
         P+HKcxvKMEzj8muUBzw+37tSpBaGsPM2cSLlugb106UvcTJ3Loka58FbnEsk6KI//4mw
         Gg/WdilAn8NOl9yX2VwvHV+Sdx1/umi5ouYY7HKddcpPfWdWJaoN+6xF5nFE6H/xU4j2
         u4EIFHXYhKdPqomERJLcJd2EhDkZRnPG1C71B7pNw73aauNnYqSmM9YZiqKn17/MvTD+
         gIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5LHymWJ1t58cRZI4MxwTqiMv3bCXN9LR4UYb0nY9Ks=;
        b=cSSxSAU8QJssd3lNKYH5pp8IvxYoA4+kjRGVeY3nY954b9X817DO1TfSFfJBAeiSqt
         hG6S3scIxzvA0K3y28QTFAcfHLLwU1xk5/UcPYtWHog8M0/OvUF1GAi0j7exbKq/KUhy
         iT2y5ajDsUTEESBaETCYAfDRGRz1O2Bapek1kYZ1+FiYsNtUjt/gnzXaIJuk9zSRFdUY
         4CdvIvW0bpO/pPPBpEXj7CLFylj2jOljBnaM6rM4eaUFX6H4kB/r7rxALXq0b6Zc/gFN
         rARqvPohVr0MmGA99teX32+nIwVKaiIowht8nqqGSZ2z5B59gHYfJOlSVByIOEkDEu1e
         4Qzg==
X-Gm-Message-State: AOAM532ORtYWsYq9ysjB33CdROZK39QbYCGl0+Sc+uWG5IMURGgf6Bj5
        E9Dlo8znSY5A1m5yhDT715Znfw==
X-Google-Smtp-Source: ABdhPJz8JPkdphleeGWLjFTULiHVBVjim7Pu1cJZNz2RZlrDgsKlArRXdMY8J0edNYU4G94ktur8Yw==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr138263wmk.86.1599746251701;
        Thu, 10 Sep 2020 06:57:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b2sm3786154wmh.47.2020.09.10.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:57:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: q6afe: dt-bindings: add q6afe clock bindings
Date:   Thu, 10 Sep 2020 14:57:07 +0100
Message-Id: <20200910135708.14842-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
References: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6afe exposes various lpass clocks controls via q6dsp q6afe commands.
This patch adds bindings required for this clock controller.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt  | 23 ++++++
 include/dt-bindings/sound/qcom,q6afe.h        | 74 ++++++++++++++++++-
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index 4916dd6a0896..2d6fb2ea75a0 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -98,6 +98,24 @@ configuration of each dai. Must contain the following properties.
 		0 - MSB
 		1 - LSB
 
+= AFE CLOCKSS
+"clocks" subnode of the AFE node. It represents q6afe clocks
+"clocks" node should have following properties.
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-clocks"
+
+- #clock-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 2. Clock Id followed by
+		below valid clock coupling attributes.
+		1 - for no coupled clock
+		2 - for dividend of the coupled clock
+		3 - for divisor of the coupled clock
+		4 - for inverted and no couple clock
+
 = EXAMPLE
 
 apr-service@4 {
@@ -175,4 +193,9 @@ apr-service@4 {
 			qcom,sd-lines = <1>;
 		};
 	};
+
+	clocks {
+		compatible = "qcom,q6afe-clocks";
+		#clock-cells = <2>;
+	};
 };
diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index 7207ab2b57bf..f64b5d2e6efd 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -130,5 +130,77 @@
 #define RX_CODEC_DMA_RX_6	125
 #define RX_CODEC_DMA_RX_7	126
 
-#endif /* __DT_BINDINGS_Q6_AFE_H__ */
+#define LPASS_CLK_ID_PRI_MI2S_IBIT	1
+#define LPASS_CLK_ID_PRI_MI2S_EBIT	2
+#define LPASS_CLK_ID_SEC_MI2S_IBIT	3
+#define LPASS_CLK_ID_SEC_MI2S_EBIT	4
+#define LPASS_CLK_ID_TER_MI2S_IBIT	5
+#define LPASS_CLK_ID_TER_MI2S_EBIT	6
+#define LPASS_CLK_ID_QUAD_MI2S_IBIT	7
+#define LPASS_CLK_ID_QUAD_MI2S_EBIT	8
+#define LPASS_CLK_ID_SPEAKER_I2S_IBIT	9
+#define LPASS_CLK_ID_SPEAKER_I2S_EBIT	10
+#define LPASS_CLK_ID_SPEAKER_I2S_OSR	11
+#define LPASS_CLK_ID_QUI_MI2S_IBIT	12
+#define LPASS_CLK_ID_QUI_MI2S_EBIT	13
+#define LPASS_CLK_ID_SEN_MI2S_IBIT	14
+#define LPASS_CLK_ID_SEN_MI2S_EBIT	15
+#define LPASS_CLK_ID_INT0_MI2S_IBIT	16
+#define LPASS_CLK_ID_INT1_MI2S_IBIT	17
+#define LPASS_CLK_ID_INT2_MI2S_IBIT	18
+#define LPASS_CLK_ID_INT3_MI2S_IBIT	19
+#define LPASS_CLK_ID_INT4_MI2S_IBIT	20
+#define LPASS_CLK_ID_INT5_MI2S_IBIT	21
+#define LPASS_CLK_ID_INT6_MI2S_IBIT	22
+#define LPASS_CLK_ID_QUI_MI2S_OSR	23
+#define LPASS_CLK_ID_PRI_PCM_IBIT	24
+#define LPASS_CLK_ID_PRI_PCM_EBIT	25
+#define LPASS_CLK_ID_SEC_PCM_IBIT	26
+#define LPASS_CLK_ID_SEC_PCM_EBIT	27
+#define LPASS_CLK_ID_TER_PCM_IBIT	28
+#define LPASS_CLK_ID_TER_PCM_EBIT	29
+#define LPASS_CLK_ID_QUAD_PCM_IBIT	30
+#define LPASS_CLK_ID_QUAD_PCM_EBIT	31
+#define LPASS_CLK_ID_QUIN_PCM_IBIT	32
+#define LPASS_CLK_ID_QUIN_PCM_EBIT	33
+#define LPASS_CLK_ID_QUI_PCM_OSR	34
+#define LPASS_CLK_ID_PRI_TDM_IBIT	35
+#define LPASS_CLK_ID_PRI_TDM_EBIT	36
+#define LPASS_CLK_ID_SEC_TDM_IBIT	37
+#define LPASS_CLK_ID_SEC_TDM_EBIT	38
+#define LPASS_CLK_ID_TER_TDM_IBIT	39
+#define LPASS_CLK_ID_TER_TDM_EBIT	40
+#define LPASS_CLK_ID_QUAD_TDM_IBIT	41
+#define LPASS_CLK_ID_QUAD_TDM_EBIT	42
+#define LPASS_CLK_ID_QUIN_TDM_IBIT	43
+#define LPASS_CLK_ID_QUIN_TDM_EBIT	44
+#define LPASS_CLK_ID_QUIN_TDM_OSR	45
+#define LPASS_CLK_ID_MCLK_1		46
+#define LPASS_CLK_ID_MCLK_2		47
+#define LPASS_CLK_ID_MCLK_3		48
+#define LPASS_CLK_ID_MCLK_4		49
+#define LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE	50
+#define LPASS_CLK_ID_INT_MCLK_0		51
+#define LPASS_CLK_ID_INT_MCLK_1		52
+#define LPASS_CLK_ID_MCLK_5		53
+#define LPASS_CLK_ID_WSA_CORE_MCLK	54
+#define LPASS_CLK_ID_WSA_CORE_NPL_MCLK	55
+#define LPASS_CLK_ID_VA_CORE_MCLK	56
+#define LPASS_CLK_ID_TX_CORE_MCLK	57
+#define LPASS_CLK_ID_TX_CORE_NPL_MCLK	58
+#define LPASS_CLK_ID_RX_CORE_MCLK	59
+#define LPASS_CLK_ID_RX_CORE_NPL_MCLK	60
+#define LPASS_CLK_ID_VA_CORE_2X_MCLK	61
+
+#define LPASS_HW_AVTIMER_VOTE		101
+#define LPASS_HW_MACRO_VOTE		102
+#define LPASS_HW_DCODEC_VOTE		103
+
+#define Q6AFE_MAX_CLK_ID			104
 
+#define LPASS_CLK_ATTRIBUTE_INVALID		0x0
+#define LPASS_CLK_ATTRIBUTE_COUPLE_NO		0x1
+#define LPASS_CLK_ATTRIBUTE_COUPLE_DIVIDEND	0x2
+#define LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR	0x3
+
+#endif /* __DT_BINDINGS_Q6_AFE_H__ */
-- 
2.21.0

