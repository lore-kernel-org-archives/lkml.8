Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3229CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013E020656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHQtGDX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgHKK6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgHKK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:58:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F54C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:58:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so12608690eje.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Mdhgy2g8j34bV9EDBbB+YPJSYmiPaq1UApYM7OjSXk=;
        b=ZHQtGDX2EI+RREM5Bwzv6uSg1CEk5rSCRfXufWT0l75+UU8uz+ajv0/nWK3vdtsBut
         zNNjX9B83cd2u7uT8+7qM9EE6aNoItCD8TQEuAdk99OVg8Os7o8XYrZoreK48bPCDi+R
         8AHS4gOov1ma8bOQWNS3MEIoQ8e7wEA2Zp1VEGMQzOQfJHV73JSR9/bvUC/UJoc6N6Av
         VNJdxF6vgIiIDGPXzfG3rVXhQOhUo6I0zQdT4fusEXgr07FsCQhYv+oKER8mAGSiavU9
         ZR2cyFCvkmAUYeKoFmQvdsZlU1GQgIZkIhaOFIzLNz0Urb9vVE89qtfqEmy0qnNwKVRA
         SfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Mdhgy2g8j34bV9EDBbB+YPJSYmiPaq1UApYM7OjSXk=;
        b=P3dU5FWKpEVih3OcgXkWuI6Lcu+wHRrSEQjbjbhL3qMLF0RNjt1p+KDip4/I/8z1Cq
         jz7z6P5CZjGCng2LphoDWtp311IrjFSUquV1hpR88UK1QG1vxuFFjVg1wEkmWmZ7hhGr
         ZyMBnYblGec+Wicj7uyzZY2tCqNU5onNvw2Mep5/yJQWpNcNcVkezmqpidm5cbKgYRQ6
         gBWKV4GmmIoLpZuH0xQ0h6LE515OkxavPy4Tlvk5xL8btnkUVlwrnA1FZ2aET2y4jZy9
         PY+6vKkJrBMesckaKo9dtlCNMEhjZ8eQO36ftgHtvMuGR555cgM1/jv4peN3pEJNu+xS
         ZkGA==
X-Gm-Message-State: AOAM5326rDXfTD65E6kSUb7v+QiM+dp2o8f5aRrV5FuKyt7w08XsBsEA
        bm81DClVlLaoNaS0j8BknKnHNA==
X-Google-Smtp-Source: ABdhPJwaUA9aebRz4I71p+CtFQOyjlyFO6qO7PpLBsUyccpKKuLHPYricqFnO59v9/xWlARFGEzN6Q==
X-Received: by 2002:a17:907:4064:: with SMTP id nl4mr25602875ejb.342.1597143510319;
        Tue, 11 Aug 2020 03:58:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id e14sm14248436edl.86.2020.08.11.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:58:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: add a dedicated menuconfig
Date:   Tue, 11 Aug 2020 11:58:18 +0100
Message-Id: <20200811105818.7890-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently list of Qualcomm drivers is growing, so put them in to a
proper menu so that it does not mix up with other ASOC configs in menuconfig.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5d6b2466a2f2..be6b8d0e2f70 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -1,11 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config SND_SOC_QCOM
+menuconfig SND_SOC_QCOM
 	tristate "ASoC support for QCOM platforms"
 	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support to use audio devices
 	  in Qualcomm Technologies SOC-based platforms.
 
+if SND_SOC_QCOM
+
 config SND_SOC_LPASS_CPU
 	tristate
 	select REGMAP_MMIO
@@ -26,7 +28,6 @@ config SND_SOC_LPASS_APQ8016
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
-	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
@@ -35,7 +36,6 @@ config SND_SOC_STORM
 
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
-	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_APQ8016
 	select SND_SOC_QCOM_COMMON
 	help
@@ -110,3 +110,5 @@ config SND_SOC_SDM845
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
 	  Say Y if you want to use audio device on this SoCs.
+
+endif #SND_SOC_QCOM
-- 
2.21.0

