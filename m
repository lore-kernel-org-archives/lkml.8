Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4927218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddcl7tEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgIIQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgIIQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:09:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2DC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:09:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so2955536wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9TiY5/bRVaXFVk1XIFOpSl5QkIq5j2T93HOt+CCPbQ=;
        b=ddcl7tEhnPfNtD0kQtjIW4AO4O9gqEadXfWVNAeO5xFb006m2m113HocUiwSP256uS
         oKZ6y6oMKI70IFBfi5WeBJqjONblrJCyY4FQucEgtNJc+6oI8VDcbvEdvr8MhjvMyPx+
         GjimWAegdexG2jth71ZMNjjw1dMu1EX7K2b/3qEWd5vZ60I64N1TUY8U22tCGsPc2ldr
         scwawNcgK83Omt9Z9u5IpVgsuJ3PtcWEFeMRZybOQjTEf9mj9sQZH88cY7adGKXRYMY5
         nFgqDLVNgGhVEmxtfWhSQKx8CKBEE9uCs4EtuZNj0mA8Aq9IEg8cnfL4afRiqTo3olFU
         Qh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9TiY5/bRVaXFVk1XIFOpSl5QkIq5j2T93HOt+CCPbQ=;
        b=qNaVviu7jp8Kuu/lSJtXWqOCE8r4i2IdrqeM7vTwSk/ixzZ1ErhI5Md+7lER/SjJSc
         QJ8j6nRQPR7T5cQ2VwAExjMK98zXW1PTkaJSP5UwLp3OQwaIubGy3egNVURdB3le1Ede
         MzN4AQ3VoTLUTfneOBWvGW74d0bBvzjwlHywMTedwMHcxjWiEzpP7T6z4VSFp6nlH/uQ
         HDt4sba+Oy/4DUFWrkGGUNhyTFMYjjib0ZsJ0T+PYStARj2ykER4yTwxkUcdw/HFH6nd
         ieUH2T59N6ZaoBQakpgqCNR1hudYszzOk35uGQZohe3zhEJaVrqDBzA9KA0vIu3rkH3R
         J9uQ==
X-Gm-Message-State: AOAM53113YxBzMTIil+KKDyIeNV+qNktQPxpnbcFBojKbIcAPn+pWFbi
        Vqg2mz2h0ncLkyDTXl0GmfpvVQ==
X-Google-Smtp-Source: ABdhPJzNDImkocSgTlMk5wUA2B5Z+RFEl3n/ikeyBHhrp4Cu+ZM10SKJtoSscc/73DqUc7yGYvE/VA==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4311608wmd.95.1599667764481;
        Wed, 09 Sep 2020 09:09:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id k22sm4900824wrd.29.2020.09.09.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:09:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] soundwire: qcom: add support to block packing mode
Date:   Wed,  9 Sep 2020 17:09:11 +0100
Message-Id: <20200909160912.3656-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
References: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to block pack mode, which is required
on Qcom soundwire controllers v1.5.x on few ports!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 4b3ef7559e6a..1ec0ee931f5b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -57,6 +57,7 @@
 #define SWRM_MCP_SLV_STATUS					0x1090
 #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
 #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
 #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
@@ -85,6 +86,7 @@ struct qcom_swrm_port_config {
 	u8 si;
 	u8 off1;
 	u8 off2;
+	u8 bp_mode;
 };
 
 struct qcom_swrm_ctrl {
@@ -400,14 +402,22 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 {
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
 	u32 value;
+	int reg = SWRM_DP_PORT_CTRL_BANK((params->port_num), bank);
+	int ret;
 
 	value = params->offset1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
 	value |= params->offset2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
 	value |= params->sample_interval - 1;
 
-	return ctrl->reg_write(ctrl,
-			       SWRM_DP_PORT_CTRL_BANK((params->port_num), bank),
-			       value);
+	ret = ctrl->reg_write(ctrl, reg, value);
+
+	if (!ret && params->blk_pkg_mode) {
+		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+
+		ret = ctrl->reg_write(ctrl, reg, 1);
+	}
+
+	return ret;
 }
 
 static int qcom_swrm_port_enable(struct sdw_bus *bus,
@@ -455,6 +465,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 			p_rt->transport_params.sample_interval = pcfg->si + 1;
 			p_rt->transport_params.offset1 = pcfg->off1;
 			p_rt->transport_params.offset2 = pcfg->off2;
+			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
@@ -465,6 +476,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 					pcfg->si + 1;
 				p_rt->transport_params.offset1 = pcfg->off1;
 				p_rt->transport_params.offset2 = pcfg->off2;
+				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 				i++;
 			}
 		}
@@ -711,6 +723,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	u8 off1[QCOM_SDW_MAX_PORTS];
 	u8 off2[QCOM_SDW_MAX_PORTS];
 	u8 si[QCOM_SDW_MAX_PORTS];
+	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
 	int i, ret, nports, val;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
@@ -753,10 +766,13 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
+					bp_mode, nports);
 	for (i = 0; i < nports; i++) {
 		ctrl->pconfig[i].si = si[i];
 		ctrl->pconfig[i].off1 = off1[i];
 		ctrl->pconfig[i].off2 = off2[i];
+		ctrl->pconfig[i].bp_mode = bp_mode[i];
 	}
 
 	return 0;
-- 
2.21.0

