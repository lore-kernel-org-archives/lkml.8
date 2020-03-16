Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A0BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E272520663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snHMyK9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgCPMDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:03:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40840 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgCPMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:03:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id z12so8536484wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onXCuvN65PHjTE+0EfUmxT7L78srpirmS0ZiKqVYQ5U=;
        b=snHMyK9QEfcSuHHR9QLQWzaJpBO8Rr88B+jvXfHnzTR66EkQ2Pej0NSRiDsZb/Kndi
         eRC96yDvyz66+9L+bqOnyTpqxw0nZHEsDJSLzrfJTYRj99844KDtM6f/V5G8BjjpFX02
         ViNGXCXE9Yi6DwDXHEIvD892kbPDVUXPHc22fF5WdaiHvXbZJIp/1U30fvlX6TTn+hwD
         Sd37LHjtS/diPIgHWzgE0Xzt+W7GQERZSOLv0WH24LjTSEortFghhHg/zrLKvYkAIlAa
         lGqgD/wmS1rJu5o5Mvazf8BDZeBxje6om2OkmTjsEpwDTDkVBeoIpBg8OY2L+H/JupAU
         rD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onXCuvN65PHjTE+0EfUmxT7L78srpirmS0ZiKqVYQ5U=;
        b=pThN9bK9viCA9l0YaRDvkJWK26q8oxvGHou4rRqPvaxKZkG6SGFgFaQpG+dLb8UM0a
         rl9yZK/4dXmOvPB2bmyD81QTawS5jeIFHcpkN9U3pK55bNrjS9Vrymt8Y+nup5EVtVCO
         SWczP8rUF9PDJnZcfrjeXIDbkyrgLjyUUpLc/8d5PYOQlDS+oldVSNLxp9kWuWDha/Xm
         lIf/3K4a3vAeavmOLwIsi2r6Mzi2r25WJNFzk+mFqW/vVDZUGhFq7CxysLBGFoZPoaai
         +UNmS4fQ9yJ9pj5nE6qSneb5p9+K2+nxb9GhbRlLA+PXa9a2nZi77a542ThHeutz8Tn6
         vz7w==
X-Gm-Message-State: ANhLgQ0+G4bDOrg37hP1PJsxrQIgJ3EEavISycH9M16sf8ToHNexZg9t
        Peqi0/vpeNnAXmcf6ZI9NKQmTg==
X-Google-Smtp-Source: ADFU+vt5Dj2XldoYXwor9TGrDgmRHbP3oq0TBe8+yx22nJQkaLn1TP77bmBQAmSJ4rPh1mZmJ6grvA==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr26799734wmg.62.1584360186500;
        Mon, 16 Mar 2020 05:03:06 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p10sm93395549wrx.81.2020.03.16.05.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 05:03:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: wsa881x: request gpio direction before setting
Date:   Mon, 16 Mar 2020 12:03:03 +0000
Message-Id: <20200316120303.3780-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that power down gpio direction is set to ouput
before even setting it.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 35b44b297f9e..1810e0775efe 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1154,7 +1154,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	wsa881x->sconfig.type = SDW_STREAM_PDM;
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
-	gpiod_set_value(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, 1);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
 	if (IS_ERR(wsa881x->regmap)) {
-- 
2.21.0

