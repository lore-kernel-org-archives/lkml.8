Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100FBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E235E2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHtUi499"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLMiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:38:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19030C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:38:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q25so8187329wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIXmHBcROpxchkszRmgrfDVWOIEmYL2f5uIuEsh5OS4=;
        b=YHtUi499GQk9deXQoH7knrv7y7or0zY2iaYFn3fwx/xqb1H08no5hJUVqy6YHFJpXO
         LqilTTy16tyssFpPqHElz6LieaaqHz2TkQ4rz9DKqglETmD6j5jbE4YHoKnq2/C8RSd2
         oXny98IJkjJEMN9pnjiiKamlz1BGsOI6SZPTIbtuUE+FwWjY1uhvtmGgSbv0tDVDGlbG
         0zrf+DSS0qPLpIc40OB/GmVCQg8gSBX/WbC8wwgZulMe4rod/Cn7wPc/EqpFxNnthMMQ
         /asuIojT5MFcWFjYB+cOFtxvMHWKWVgPH6LRtWYODwLw+uJ7JGDohQU0rhEKH8qc6VRD
         UlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIXmHBcROpxchkszRmgrfDVWOIEmYL2f5uIuEsh5OS4=;
        b=PauYG8BuFX+6hfSBn3u4Dov/nOcm3wDmc/LSOpF5uYf6eoYeFYXFJV1sJTHyG9gdhS
         W2GjxYYxEJoKsCj4dRCUr/diJ+140qvTXiDaEkmX3BXoKkw7utE2VODOqtyELVHmKyQx
         TnE+X+J9/9XG4LND5r0+6CAEZzojQLuIr0ZCO2Pa+lFaPyQ8D2sAE4EYOB/gJkfFEk/1
         jMaeBLE7OAWSokMjg+IXiHm99q2ERYbUB/ruV92E/HKBxDGv+brHgCmd9kKy1m0dSTGe
         9V+hyBlTzWHQpJhhkfw+M6zjwXALN/1RYnNcYY1y3YVVLpD1ZFR3SMoojBbspMvfYKdo
         0YGA==
X-Gm-Message-State: AOAM532WaAwP4uOcjQpHL67Mc20wyoxS9Wz8ZmU+gIrJGJZWXJm6Swn7
        cPMUrEkEHspML3V43EkhfiSbknaAxTA=
X-Google-Smtp-Source: ABdhPJzKzD/xTNB5Vwz+jQuc946dHhh7qHJqaBh5N65UMZE9NDXk2wSXGSkicWSDa6bZKXMv6ttRLQ==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr13970417wme.65.1591965485666;
        Fri, 12 Jun 2020 05:38:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g18sm9392299wme.17.2020.06.12.05.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 05:38:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/2] ASoc: q6afe: add support to get port direction
Date:   Fri, 12 Jun 2020 13:37:10 +0100
Message-Id: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to q6afe_is_rx_port() to get direction
of DSP BE dai port, this is useful for setting dailink
directions correctly.

Fixes: c25e295cd77b (ASoC: qcom: Add support to parse common audio device nodes")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 8 ++++++++
 sound/soc/qcom/qdsp6/q6afe.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index e0945f7a58c8..0ce4eb60f984 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -800,6 +800,14 @@ int q6afe_get_port_id(int index)
 }
 EXPORT_SYMBOL_GPL(q6afe_get_port_id);
 
+int q6afe_is_rx_port(int index)
+{
+	if (index < 0 || index >= AFE_PORT_MAX)
+		return -EINVAL;
+
+	return port_maps[index].is_rx;
+}
+EXPORT_SYMBOL_GPL(q6afe_is_rx_port);
 static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 			    struct q6afe_port *port)
 {
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index c7ed5422baff..1a0f80a14afe 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -198,6 +198,7 @@ int q6afe_port_start(struct q6afe_port *port);
 int q6afe_port_stop(struct q6afe_port *port);
 void q6afe_port_put(struct q6afe_port *port);
 int q6afe_get_port_id(int index);
+int q6afe_is_rx_port(int index);
 void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
 void q6afe_slim_port_prepare(struct q6afe_port *port,
-- 
2.21.0

