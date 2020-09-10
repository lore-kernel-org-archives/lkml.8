Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3170AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF78D20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="az80YPjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIJKTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbgIJKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:18:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1BC06179F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so5241193wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VQ3bGKtBxRBApFT2T0Tmq9tmwkVFZ1oYNu2zUBN5wY=;
        b=az80YPjHOHIydGMO4T0LCTDhmktqPRLH6LMmcI2oOStXcYNtT0Dn7k16T1eCHa50G3
         H5VaiOhNbxhjav3+6kIsqF4W59WVmKeZzc7P6l7vHIilMC0ioTST56K4cv8mEaJUkDC+
         BTrl1LvDD0+HWfW2uTpJkmtltkX2ebwsoEE4bfw1X94WXAhjW2U66ZpZbaem5yqxSepM
         3AlVagzgxU8t3loxozOB4CLpOjHAHIfgsEz4gT7M42O4YpBKaMD+Preinl7Wcv0TOPpk
         vLhBN+SkhzHl+q8xfsu6XCF4F0y7yFSrNgcld7WpxN5T/S7iaC1Y61KNSai/YOR8xd62
         iPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VQ3bGKtBxRBApFT2T0Tmq9tmwkVFZ1oYNu2zUBN5wY=;
        b=b1yiCy4kZKjiuwwoDX1PIRWtLXOgV+m0fen/xIhCak8c31oDbym1AVgA7DudcpMHLn
         L2cZVlRYIJMKa9wDphrlOXbH9Chp98ZjHsE/s7v2N5fpHtGXD86QSl51zVm0FAdO9Rlo
         y9xUHb1TaoclY7Zbr39kKCnwdLT6dOV33vAjNDfHZrMbLvaq7jZjqY21gFjBEZAssMKv
         gfxxWdz6L3qeaBlA+uCu+mZsm+UZfMX2L4EWNBHbQV/jIXuFDMc/RBRwgIKb3FaRrOcp
         5JtgxKOPOqDQwgHuzDh3JDekHhHE6ekJv8rzzALuOTYl4bAjLMacT+zB0b9+aeFKvUSO
         +NJw==
X-Gm-Message-State: AOAM532Z17l1WDAG/qwKx9ClBDlme8NqHeFprL2Gh1F5mgVk7Zd2kHgU
        Sc2nKXZfG/O1xSrUPbr0OlpTvQ==
X-Google-Smtp-Source: ABdhPJzN1Uau/E0JLtlzAH0YotHH2e/OT0iND+6DjIa5vN8pMGBuma/nMuts/1GRS+oCzezB4dPzzA==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr7550515wme.162.1599733074961;
        Thu, 10 Sep 2020 03:17:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/8] ASoC: q6dsp: q6afe: update q6afe_set_param to support global clocks
Date:   Thu, 10 Sep 2020 11:17:30 +0100
Message-Id: <20200910101732.23484-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously there was no case where we need to set clock or send commands
that are not associated with q6afe ports, now we have cases like clock
voting and clock consumers like codecs that needed these clocks.

update q6afe_set_param() to support such cases, including token passing.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 51c94dd9998d..9ed5537ee58e 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -967,14 +967,13 @@ static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 	return ret;
 }
 
-static int q6afe_port_set_param(struct q6afe_port *port, void *data,
-				int param_id, int module_id, int psize)
+static int q6afe_set_param(struct q6afe *afe, struct q6afe_port *port,
+			   void *data, int param_id, int module_id, int psize,
+			   int token)
 {
 	struct afe_svc_cmd_set_param *param;
 	struct afe_port_param_data_v2 *pdata;
-	struct q6afe *afe = port->afe;
 	struct apr_pkt *pkt;
-	u16 port_id = port->id;
 	int ret, pkt_size;
 	void *p, *pl;
 
@@ -995,7 +994,7 @@ static int q6afe_port_set_param(struct q6afe_port *port, void *data,
 	pkt->hdr.pkt_size = pkt_size;
 	pkt->hdr.src_port = 0;
 	pkt->hdr.dest_port = 0;
-	pkt->hdr.token = port->token;
+	pkt->hdr.token = token;
 	pkt->hdr.opcode = AFE_SVC_CMD_SET_PARAM;
 
 	param->payload_size = sizeof(*pdata) + psize;
@@ -1008,13 +1007,19 @@ static int q6afe_port_set_param(struct q6afe_port *port, void *data,
 
 	ret = afe_apr_send_pkt(afe, pkt, port, AFE_SVC_CMD_SET_PARAM);
 	if (ret)
-		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
-		       port_id, ret);
+		dev_err(afe->dev, "AFE set params failed %d\n", ret);
 
 	kfree(pkt);
 	return ret;
 }
 
+static int q6afe_port_set_param(struct q6afe_port *port, void *data,
+				int param_id, int module_id, int psize)
+{
+	return q6afe_set_param(port->afe, port, data, param_id, module_id,
+			       psize, port->token);
+}
+
 static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 				   int param_id, int module_id, int psize)
 {
@@ -1064,7 +1069,7 @@ static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 	return ret;
 }
 
-static int q6afe_set_lpass_clock(struct q6afe_port *port,
+static int q6afe_port_set_lpass_clock(struct q6afe_port *port,
 				 struct afe_clk_cfg *cfg)
 {
 	return q6afe_port_set_param_v2(port, cfg,
@@ -1111,7 +1116,7 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 		ccfg.clk_src = clk_src;
 		ccfg.clk_root = clk_root;
 		ccfg.clk_set_mode = Q6AFE_LPASS_MODE_CLK1_VALID;
-		ret = q6afe_set_lpass_clock(port, &ccfg);
+		ret = q6afe_port_set_lpass_clock(port, &ccfg);
 		break;
 
 	case LPAIF_OSR_CLK:
@@ -1120,7 +1125,7 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 		ccfg.clk_src = clk_src;
 		ccfg.clk_root = clk_root;
 		ccfg.clk_set_mode = Q6AFE_LPASS_MODE_CLK2_VALID;
-		ret = q6afe_set_lpass_clock(port, &ccfg);
+		ret = q6afe_port_set_lpass_clock(port, &ccfg);
 		break;
 	case Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT ... Q6AFE_LPASS_CLK_ID_QUI_MI2S_OSR:
 	case Q6AFE_LPASS_CLK_ID_MCLK_1 ... Q6AFE_LPASS_CLK_ID_INT_MCLK_1:
-- 
2.21.0

