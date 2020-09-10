Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC15CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7886620829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y49qLon9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgIJKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIJKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:17:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E728C061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so6073066wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHBmx055sbBg7MqNM/uYc59WPPRKIM4LLsW0G6hMtvg=;
        b=y49qLon9Y4Etak0KwvCgdmRAo1Pq/cipmeh1cqbXkWTIG5zuMIGASeDjTmIS83m5Kg
         62z6dAzb7pb53LWlRZBQ4Ykbf40jVFYp3DNY91VtyzZ/QMdW2wYOLVtjukcMTfMoY38r
         zyuuMjqA+IDbOrLNEGNtr6MVmnBm+LO/YycDzuDZIvH2RuV3nWFID0UmfpqdKQeGwwuH
         49qkQyc1mCakmJ19LP9N9QfJcg25xU200US+bjTV42GlIZsY3FLFgHyrJKMiZJM4VWkr
         KxxbvjVzAfKxMzZJOSk48JLuK/Hke24sWdK4A1bbzEh0lmy3ObRjPM8A2ng6JY+k3QuD
         rZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHBmx055sbBg7MqNM/uYc59WPPRKIM4LLsW0G6hMtvg=;
        b=aeYLz1W4YHgWPyzoOgc8Ef+c7Be+4dcsufqBS1skJnu5hf6DZ0cAlLwYLzedfv/fip
         zjsfJABwVcVzytQQPJzvdIqxIPBrAOA72bjAFB7bTcaXGFfCuxi+MJET1oFTp/4rcSe8
         Aw+VkFnJXESNJdBymaOvokpY5QSLWyOvU5XRBp2bgSzFXIYWPDaDH2NK3XbcNrywHLux
         Nf9SjN26ThaJgJfLLdx+i8YVq5NStpenkGsKofWOD+SmzQdMRzSH8eP/y0ZtP06v+Zi9
         TaG2bAemcr7V6a7F2WUBnJOcDptdwxn4z+8wDUIlS1DxFwrT3j6afI2FA11NocLRoJ7V
         Rdgw==
X-Gm-Message-State: AOAM530TuzcTcYbOdAJd9VNKm5T4ufIaisHhscuzbEG7Mvm2ZAjtBxvf
        brYNM2jKss3GjOdcUWZD6XvCog==
X-Google-Smtp-Source: ABdhPJxE6xAn8FhlHViC8YqDPkyu5r9y93x+ZpcBSaE5gk4i+oOB70VUqDZL0NkNpuuhkUb39yTOZQ==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr8083560wrq.408.1599733068711;
        Thu, 10 Sep 2020 03:17:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/8] ASoC: q6dsp: q6afe: add support to Codec DMA ports
Date:   Thu, 10 Sep 2020 11:17:25 +0100
Message-Id: <20200910101732.23484-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New LPASS supports various codec macros, DSP firmware already
has support to those ports. Add corresponding configuration
support to those ports in adsp drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/dt-bindings/sound/qcom,q6afe.h |  22 +++++
 sound/soc/qcom/qdsp6/q6afe.c           | 127 ++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6afe.h           |  14 ++-
 3 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index 1df06f8ad5c3..7207ab2b57bf 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -107,6 +107,28 @@
 #define QUINARY_TDM_RX_7	102
 #define QUINARY_TDM_TX_7	103
 #define DISPLAY_PORT_RX		104
+#define WSA_CODEC_DMA_RX_0	105
+#define WSA_CODEC_DMA_TX_0	106
+#define WSA_CODEC_DMA_RX_1	107
+#define WSA_CODEC_DMA_TX_1	108
+#define WSA_CODEC_DMA_TX_2	109
+#define VA_CODEC_DMA_TX_0	110
+#define VA_CODEC_DMA_TX_1	111
+#define VA_CODEC_DMA_TX_2	112
+#define RX_CODEC_DMA_RX_0	113
+#define TX_CODEC_DMA_TX_0	114
+#define RX_CODEC_DMA_RX_1	115
+#define TX_CODEC_DMA_TX_1	116
+#define RX_CODEC_DMA_RX_2	117
+#define TX_CODEC_DMA_TX_2	118
+#define RX_CODEC_DMA_RX_3	119
+#define TX_CODEC_DMA_TX_3	120
+#define RX_CODEC_DMA_RX_4	121
+#define TX_CODEC_DMA_TX_4	122
+#define RX_CODEC_DMA_RX_5	123
+#define TX_CODEC_DMA_TX_5	124
+#define RX_CODEC_DMA_RX_6	125
+#define RX_CODEC_DMA_RX_7	126
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index e0945f7a58c8..8ceefb431bcb 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -42,6 +42,7 @@
 #define AFE_PARAM_ID_I2S_CONFIG	0x0001020D
 #define AFE_PARAM_ID_TDM_CONFIG	0x0001029D
 #define AFE_PARAM_ID_PORT_SLOT_MAPPING_CONFIG	0x00010297
+#define AFE_PARAM_ID_CODEC_DMA_CONFIG	0x000102B8
 
 /* I2S config specific */
 #define AFE_API_VERSION_I2S_CONFIG	0x1
@@ -299,12 +300,58 @@
 #define AFE_PORT_ID_QUINARY_TDM_TX_7 \
 	(AFE_PORT_ID_QUINARY_TDM_TX + 0x0E)
 
+/* AFE WSA Codec DMA Rx port 0 */
+#define AFE_PORT_ID_WSA_CODEC_DMA_RX_0	0xB000
+/* AFE WSA Codec DMA Tx port 0 */
+#define AFE_PORT_ID_WSA_CODEC_DMA_TX_0	0xB001
+/* AFE WSA Codec DMA Rx port 1 */
+#define AFE_PORT_ID_WSA_CODEC_DMA_RX_1	0xB002
+/* AFE WSA Codec DMA Tx port 1 */
+#define AFE_PORT_ID_WSA_CODEC_DMA_TX_1	0xB003
+/* AFE WSA Codec DMA Tx port 2 */
+#define AFE_PORT_ID_WSA_CODEC_DMA_TX_2	0xB005
+/* AFE VA Codec DMA Tx port 0 */
+#define AFE_PORT_ID_VA_CODEC_DMA_TX_0	0xB021
+/* AFE VA Codec DMA Tx port 1 */
+#define AFE_PORT_ID_VA_CODEC_DMA_TX_1	0xB023
+/* AFE VA Codec DMA Tx port 2 */
+#define AFE_PORT_ID_VA_CODEC_DMA_TX_2	0xB025
+/* AFE Rx Codec DMA Rx port 0 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_0	0xB030
+/* AFE Tx Codec DMA Tx port 0 */
+#define AFE_PORT_ID_TX_CODEC_DMA_TX_0	0xB031
+/* AFE Rx Codec DMA Rx port 1 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_1	0xB032
+/* AFE Tx Codec DMA Tx port 1 */
+#define AFE_PORT_ID_TX_CODEC_DMA_TX_1	0xB033
+/* AFE Rx Codec DMA Rx port 2 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_2	0xB034
+/* AFE Tx Codec DMA Tx port 2 */
+#define AFE_PORT_ID_TX_CODEC_DMA_TX_2	0xB035
+/* AFE Rx Codec DMA Rx port 3 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_3	0xB036
+/* AFE Tx Codec DMA Tx port 3 */
+#define AFE_PORT_ID_TX_CODEC_DMA_TX_3	0xB037
+/* AFE Rx Codec DMA Rx port 4 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_4	0xB038
+/* AFE Tx Codec DMA Tx port 4 */
+#define AFE_PORT_ID_TX_CODEC_DMA_TX_4	0xB039
+/* AFE Rx Codec DMA Rx port 5 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_5	0xB03A
+/* AFE Tx Codec DMA Tx port 5 */
+#define AFE_PORT_ID_TX_CODEC_DMA_TX_5	0xB03B
+/* AFE Rx Codec DMA Rx port 6 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_6	0xB03C
+/* AFE Rx Codec DMA Rx port 7 */
+#define AFE_PORT_ID_RX_CODEC_DMA_RX_7	0xB03E
+
 #define Q6AFE_LPASS_MODE_CLK1_VALID 1
 #define Q6AFE_LPASS_MODE_CLK2_VALID 2
 #define Q6AFE_LPASS_CLK_SRC_INTERNAL 1
 #define Q6AFE_LPASS_CLK_ROOT_DEFAULT 0
 #define AFE_API_VERSION_TDM_CONFIG              1
 #define AFE_API_VERSION_SLOT_MAPPING_CONFIG	1
+#define AFE_API_VERSION_CODEC_DMA_CONFIG	1
 
 #define TIMEOUT_MS 1000
 #define AFE_CMD_RESP_AVAIL	0
@@ -448,11 +495,21 @@ struct afe_param_id_tdm_cfg {
 	u32	slot_mask;
 } __packed;
 
+struct afe_param_id_cdc_dma_cfg {
+	u32	cdc_dma_cfg_minor_version;
+	u32	sample_rate;
+	u16	bit_width;
+	u16	data_format;
+	u16	num_channels;
+	u16	active_channels_mask;
+} __packed;
+
 union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
 	struct afe_param_id_slimbus_cfg           slim_cfg;
 	struct afe_param_id_i2s_cfg	i2s_cfg;
 	struct afe_param_id_tdm_cfg	tdm_cfg;
+	struct afe_param_id_cdc_dma_cfg	dma_cfg;
 } __packed;
 
 
@@ -707,6 +764,50 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				QUINARY_TDM_TX_7, 0, 1},
 	[DISPLAY_PORT_RX] = { AFE_PORT_ID_HDMI_OVER_DP_RX,
 				DISPLAY_PORT_RX, 1, 1},
+	[WSA_CODEC_DMA_RX_0] = { AFE_PORT_ID_WSA_CODEC_DMA_RX_0,
+				WSA_CODEC_DMA_RX_0, 1, 1},
+	[WSA_CODEC_DMA_TX_0] = { AFE_PORT_ID_WSA_CODEC_DMA_TX_0,
+				WSA_CODEC_DMA_TX_0, 0, 1},
+	[WSA_CODEC_DMA_RX_1] = { AFE_PORT_ID_WSA_CODEC_DMA_RX_1,
+				WSA_CODEC_DMA_RX_1, 1, 1},
+	[WSA_CODEC_DMA_TX_1] = { AFE_PORT_ID_WSA_CODEC_DMA_TX_1,
+				WSA_CODEC_DMA_TX_1, 0, 1},
+	[WSA_CODEC_DMA_TX_2] = { AFE_PORT_ID_WSA_CODEC_DMA_TX_2,
+				WSA_CODEC_DMA_TX_2, 0, 1},
+	[VA_CODEC_DMA_TX_0] = { AFE_PORT_ID_VA_CODEC_DMA_TX_0,
+				VA_CODEC_DMA_TX_0, 0, 1},
+	[VA_CODEC_DMA_TX_1] = { AFE_PORT_ID_VA_CODEC_DMA_TX_1,
+				VA_CODEC_DMA_TX_1, 0, 1},
+	[VA_CODEC_DMA_TX_2] = { AFE_PORT_ID_VA_CODEC_DMA_TX_2,
+				VA_CODEC_DMA_TX_2, 0, 1},
+	[RX_CODEC_DMA_RX_0] = { AFE_PORT_ID_RX_CODEC_DMA_RX_0,
+				RX_CODEC_DMA_RX_0, 1, 1},
+	[TX_CODEC_DMA_TX_0] = { AFE_PORT_ID_TX_CODEC_DMA_TX_0,
+				TX_CODEC_DMA_TX_0, 0, 1},
+	[RX_CODEC_DMA_RX_1] = { AFE_PORT_ID_RX_CODEC_DMA_RX_1,
+				RX_CODEC_DMA_RX_1, 1, 1},
+	[TX_CODEC_DMA_TX_1] = { AFE_PORT_ID_TX_CODEC_DMA_TX_1,
+				TX_CODEC_DMA_TX_1, 0, 1},
+	[RX_CODEC_DMA_RX_2] = { AFE_PORT_ID_RX_CODEC_DMA_RX_2,
+				RX_CODEC_DMA_RX_2, 1, 1},
+	[TX_CODEC_DMA_TX_2] = { AFE_PORT_ID_TX_CODEC_DMA_TX_2,
+				TX_CODEC_DMA_TX_2, 0, 1},
+	[RX_CODEC_DMA_RX_3] = { AFE_PORT_ID_RX_CODEC_DMA_RX_3,
+				RX_CODEC_DMA_RX_3, 1, 1},
+	[TX_CODEC_DMA_TX_3] = { AFE_PORT_ID_TX_CODEC_DMA_TX_3,
+				TX_CODEC_DMA_TX_3, 0, 1},
+	[RX_CODEC_DMA_RX_4] = { AFE_PORT_ID_RX_CODEC_DMA_RX_4,
+				RX_CODEC_DMA_RX_4, 1, 1},
+	[TX_CODEC_DMA_TX_4] = { AFE_PORT_ID_TX_CODEC_DMA_TX_4,
+				TX_CODEC_DMA_TX_4, 0, 1},
+	[RX_CODEC_DMA_RX_5] = { AFE_PORT_ID_RX_CODEC_DMA_RX_5,
+				RX_CODEC_DMA_RX_5, 1, 1},
+	[TX_CODEC_DMA_TX_5] = { AFE_PORT_ID_TX_CODEC_DMA_TX_5,
+				TX_CODEC_DMA_TX_5, 0, 1},
+	[RX_CODEC_DMA_RX_6] = { AFE_PORT_ID_RX_CODEC_DMA_RX_6,
+				RX_CODEC_DMA_RX_6, 1, 1},
+	[RX_CODEC_DMA_RX_7] = { AFE_PORT_ID_RX_CODEC_DMA_RX_7,
+				RX_CODEC_DMA_RX_7, 1, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -1288,6 +1389,28 @@ int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg)
 }
 EXPORT_SYMBOL_GPL(q6afe_i2s_port_prepare);
 
+/**
+ * q6afe_dam_port_prepare() - Prepare dma afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: DMA configuration for the afe port
+ *
+ */
+void q6afe_cdc_dma_port_prepare(struct q6afe_port *port,
+				struct q6afe_cdc_dma_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+	struct afe_param_id_cdc_dma_cfg *dma_cfg = &pcfg->dma_cfg;
+
+	dma_cfg->cdc_dma_cfg_minor_version = AFE_API_VERSION_CODEC_DMA_CONFIG;
+	dma_cfg->sample_rate = cfg->sample_rate;
+	dma_cfg->bit_width = cfg->bit_width;
+	dma_cfg->data_format = cfg->data_format;
+	dma_cfg->num_channels = cfg->num_channels;
+	if (!cfg->active_channels_mask)
+		dma_cfg->active_channels_mask = (1 << cfg->num_channels) - 1;
+}
+EXPORT_SYMBOL_GPL(q6afe_cdc_dma_port_prepare);
 /**
  * q6afe_port_start() - Start a afe port
  *
@@ -1420,7 +1543,9 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_PRIMARY_TDM_RX ... AFE_PORT_ID_QUINARY_TDM_TX_7:
 		cfg_type = AFE_PARAM_ID_TDM_CONFIG;
 		break;
-
+	case AFE_PORT_ID_WSA_CODEC_DMA_RX_0 ... AFE_PORT_ID_RX_CODEC_DMA_RX_7:
+		cfg_type = AFE_PARAM_ID_CODEC_DMA_CONFIG;
+	break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
 		return ERR_PTR(-EINVAL);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index c7ed5422baff..1f7cbed9335d 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 
-#define AFE_PORT_MAX		105
+#define AFE_PORT_MAX		127
 
 #define MSM_AFE_PORT_TYPE_RX 0
 #define MSM_AFE_PORT_TYPE_TX 1
@@ -184,11 +184,21 @@ struct q6afe_tdm_cfg {
 	u16	ch_mapping[AFE_MAX_CHAN_COUNT];
 };
 
+struct q6afe_cdc_dma_cfg {
+	u16	sample_rate;
+	u16	bit_width;
+	u16	data_format;
+	u16	num_channels;
+	u16	active_channels_mask;
+};
+
+
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
 	struct q6afe_slim_cfg slim;
 	struct q6afe_i2s_cfg i2s_cfg;
 	struct q6afe_tdm_cfg tdm;
+	struct q6afe_cdc_dma_cfg dma_cfg;
 };
 
 struct q6afe_port;
@@ -204,6 +214,8 @@ void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
 int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
 void q6afe_tdm_port_prepare(struct q6afe_port *port, struct q6afe_tdm_cfg *cfg);
+void q6afe_cdc_dma_port_prepare(struct q6afe_port *port,
+				struct q6afe_cdc_dma_cfg *cfg);
 
 int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 			  int clk_src, int clk_root,
-- 
2.21.0

