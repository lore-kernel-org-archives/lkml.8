Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47EE206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXkbxbAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgEVKVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgEVKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:21:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D700C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:21:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so12352335ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=POPglGew/cq7Fh3lzWt5jzw//XiaJ0U+eE6M/nZ46PE=;
        b=HXkbxbAPPaOIi1vBFvOH0rF0y8ltpzsJ/lBiWigcsLc9jSNJndrYz3imJ+LSJL6TPj
         6BjbTD11XqeL9eI1U6RSrVx814wygYKfxwjGuoUB3N7Lo+eNl/Lv0LVa9VrkldxGt46P
         SADCzcTA0SWD0LdfbkzfEhpJijvRD4NnXeTUEl2wy1e5D6jscDDPunPCAycUv49S1SYU
         57PS86PXDUMDBOiTv0qn8ZBm3sVXP4tHMxm169LpNK3REJjw5G7jUFhmjV1BHVCuYYHk
         t4zPhz/c2OxgU3Gh5anI8kpNd5q2kVrJ11h1ROko9U+eknJRsORi3W0cVbGT1Ig2sJLK
         9v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=POPglGew/cq7Fh3lzWt5jzw//XiaJ0U+eE6M/nZ46PE=;
        b=hRa35FzKG+yItPXQybe1/MWGWYSGX77yWxV00fqgTaunSzDQYvSaYHEf4NyU7BUHtE
         sGJygG4vM93xbpMzsfHADJSZIw9EWhMERDfF/v73txeGpvZVCzd3cQGdlLkkK/+JBBL9
         BcCS8OQ9CtfcWaFuXAWM8tApn2Z8zTPz3IWmpH6LQ0Z3+SRCCH7gNPZGNNbc9hdhu0cF
         NkTHPa6XhVyxchHDNDtev2kIYcf3MSEKuQ6VObg4dib4N0COG/GxFMPoqh8xSB0bTBGl
         xE6QpNaTMgNmR+TwCTrfqdziwycZ7mjSz/UmHDYJZR6dj8KKO+aIPgEqerJnl6G9r0fA
         7eVw==
X-Gm-Message-State: AOAM532UzB5LlFGCKwC93EEBzLt6nXWnq7Wo2RKJWDF1eXKW1edmw1Qs
        99ySIB0J6XBGxZ0T4+7S4F3A3A==
X-Google-Smtp-Source: ABdhPJxusO2sj7i9AzZa/+pdI1I/q3pAWDlBSWuq0T4Sjds7K6f87kmGOQXdGisF58+e3ee9GgKRkA==
X-Received: by 2002:a17:906:278e:: with SMTP id j14mr7264295ejc.270.1590142898982;
        Fri, 22 May 2020 03:21:38 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-12.ip.btc-net.bg. [212.5.158.12])
        by smtp.gmail.com with ESMTPSA id z14sm7472532ejd.37.2020.05.22.03.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 03:21:38 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] arm64: defconfig: Enable SDM845 video clock controller
Date:   Fri, 22 May 2020 13:21:09 +0300
Message-Id: <20200522102109.3607-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the build of sdm845 video clock controller by default.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 03d0189f7d68..4eb7e35d2d7d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -806,6 +806,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
 CONFIG_SDM_GPUCC_845=y
+CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_QCOM_HFPLL=y
-- 
2.17.1

