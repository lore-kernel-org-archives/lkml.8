Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A431C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BCF21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qytJ0anu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgIJKVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgIJKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:17:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E1C061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so6073199wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35FP4zv+pwkbGr1a0ICMd6sQ90vGjx362WgHWWdE2EE=;
        b=qytJ0anu0r8iejL2J6YFmry4i70Yz/OxSO1hg0YXgpdvILS87SEuM+OW/N06uatodz
         PxYfg+QYPOwoxehP3B4PVH7HPiFr7AvPe1OGaELzxBmV8IGd8EGASeJC12C9VE6aOfXj
         ELoDnCUfz2fhMZxAnb0fX9axz9fdFuTIrGUY6ncQU1vrXqrNMWGwHirCdtdDrcF5tLwt
         nz4alzp1i/jrRUVE8npi1+JiG6oduIEDZHsIgpN3crEIVyP/DG9cituiP4B3LG7sL2MR
         o0ZODSoIXBmYK62jfACiBuEneyDJHaaSJLAwewbUAyCOlxYo1NvpAwkeppcil4ggIabb
         WFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35FP4zv+pwkbGr1a0ICMd6sQ90vGjx362WgHWWdE2EE=;
        b=E7C9T/YSHZb6bBxkbkBWBbwNQAaiNylBCTJJmbmMKvoox24Ty1JXbI2xswL6s7IphR
         Cq5LcReSMz2doyvCNzaxAR9S/xBtDUI9jCGkiuzwefgHf5CcUGEHg1JZJskTw3RaYldG
         qS0bHaDYPgbNPcNrM0flSdFZ59Brs9rUFGWvjkAURa7vWFo6+fiESZfpJhXeTrpgjUVY
         Pp6kR/Wldr6uQc79eKRat9AYK0zkX1A9LBCq7uEvRW4CnzHiTqLJ9UmxypZqkSb3IsYF
         kwXhwFyXTIaAB0tustKXxBdd5ECNDta4ownjlUlD5fwm+TAXzkQblnQ6Vs1DBfTf58eJ
         /ajw==
X-Gm-Message-State: AOAM531wn1kasPtg4zlmv6ciJ/J1Bq37x5iHwTiBSncjYOBWGglTfeVw
        UDkmYHPtHIVogH7tsmkMvXc6sg==
X-Google-Smtp-Source: ABdhPJwwyy6FJ4lFjbkvIsHCWHQE2fqsNe40JDp5tIgVLRzzrHZGi8Opl4fcPMyaHoVU6nJlbkLJtg==
X-Received: by 2002:adf:9e43:: with SMTP id v3mr8377833wre.306.1599733071084;
        Thu, 10 Sep 2020 03:17:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/8] ASoC: q6dsp: q6afe: prepare afe_apr_send_pkt to take response opcode
Date:   Thu, 10 Sep 2020 11:17:27 +0100
Message-Id: <20200910101732.23484-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update afe_apr_send_pkt() to take response opcode that it should wait for.
This is helpful in cases where we expect response other than the
actual command opcode.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 8ceefb431bcb..f934c69f0a14 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -902,10 +902,9 @@ int q6afe_get_port_id(int index)
 EXPORT_SYMBOL_GPL(q6afe_get_port_id);
 
 static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
-			    struct q6afe_port *port)
+			    struct q6afe_port *port, uint32_t rsp_opcode)
 {
 	wait_queue_head_t *wait = &port->wait;
-	struct apr_hdr *hdr = &pkt->hdr;
 	int ret;
 
 	mutex_lock(&afe->lock);
@@ -919,7 +918,7 @@ static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 		goto err;
 	}
 
-	ret = wait_event_timeout(*wait, (port->result.opcode == hdr->opcode),
+	ret = wait_event_timeout(*wait, (port->result.opcode == rsp_opcode),
 				 msecs_to_jiffies(TIMEOUT_MS));
 	if (!ret) {
 		ret = -ETIMEDOUT;
@@ -976,7 +975,7 @@ static int q6afe_port_set_param(struct q6afe_port *port, void *data,
 	pdata->param_id = param_id;
 	pdata->param_size = psize;
 
-	ret = afe_apr_send_pkt(afe, pkt, port);
+	ret = afe_apr_send_pkt(afe, pkt, port, AFE_SVC_CMD_SET_PARAM);
 	if (ret)
 		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
 		       port_id, ret);
@@ -1025,7 +1024,7 @@ static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 	pdata->param_id = param_id;
 	pdata->param_size = psize;
 
-	ret = afe_apr_send_pkt(afe, pkt, port);
+	ret = afe_apr_send_pkt(afe, pkt, port, AFE_PORT_CMD_SET_PARAM_V2);
 	if (ret)
 		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
 		       port_id, ret);
@@ -1155,7 +1154,7 @@ int q6afe_port_stop(struct q6afe_port *port)
 	stop->port_id = port_id;
 	stop->reserved = 0;
 
-	ret = afe_apr_send_pkt(afe, pkt, port);
+	ret = afe_apr_send_pkt(afe, pkt, port, AFE_PORT_CMD_DEVICE_STOP);
 	if (ret)
 		dev_err(afe->dev, "AFE close failed %d\n", ret);
 
@@ -1467,7 +1466,7 @@ int q6afe_port_start(struct q6afe_port *port)
 
 	start->port_id = port_id;
 
-	ret = afe_apr_send_pkt(afe, pkt, port);
+	ret = afe_apr_send_pkt(afe, pkt, port, AFE_PORT_CMD_DEVICE_START);
 	if (ret)
 		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
 			port_id, ret);
-- 
2.21.0

