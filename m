Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A36AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4069420B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="xdXpHbJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgFPNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgFPNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:50:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4CBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:50:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so8415019pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKgw8yL2fG/OFCaOWETgOyQMdJ8jj68sdqGzhJZN1iE=;
        b=xdXpHbJm9xexh+go+YRBMq+GBe0v63E86PTybh8kJwGw2Rn6NiU60+Z9J3i10hlVDb
         MuHwzp+3aGRK8R38H8fnfe6cMOLV1G/si5W0984JkNpB1m1RpA8PFCbPSTOKsuLP/p7F
         hyK0JAyaKmzgMzJI21ZCzdtiulDl5OHuZuQm8gRL0FRT3JmbaplpTOF5sJ75xLWvLH8v
         lD62Ty0mSSoOzoHlZL6TDx2h3ZbZzyclm9cNKXORJBqd9bz+c8xvg09AEIVUZUwBPY4e
         9F1eLVUEGi9cza4aYmh4sN/qS+fQPISnFI4dgHI/r/cxFjCILIXGZv9BhcsZ47dO9eb1
         Vxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKgw8yL2fG/OFCaOWETgOyQMdJ8jj68sdqGzhJZN1iE=;
        b=I05oVkMaaT05pnz3cppI0ocMll07tmG9WNjmTuseGJ8TGARZyj259BxCGxgWAToH24
         x1/1PocG5mAP1mvyLOzznwUWuKXJANXUF5cua7Ni6vg7ddqI0lRcqkTTvTtXfyaQjV8Z
         nTlFQZzOlegcrrJduws7pLwNuw+HRiUpJhAWkQDNosZqq5g0NrgnMrNZRxM1Jq2JRJoS
         +puQBE87zE7CjwBy4tG5zPU1PdxWGna8WuZPy0D3NBwksR5aGwvP3xhnXwM6O01VI1ZH
         KYaMwKAOfqyJHC4Uo/zowxNKWkwAoVL5xhvpWURWsx66p5nvQ771ce6lrzBWbzWNyiOH
         uzVA==
X-Gm-Message-State: AOAM532DAPIo4DVWvFu47xnrPfv1VqioLZsMiLQuN6qDat2npCG0hM3M
        He+0PqcyT89BE6BQAXWHOflRuA==
X-Google-Smtp-Source: ABdhPJxQ/bgAkHjSLUQ1Ge4GhONjafEz01dOHSVJ60W/OI87vJ+Tvg9OgrgCGPeXcFaKuZxwykc9Tw==
X-Received: by 2002:a17:90a:260e:: with SMTP id l14mr2969872pje.76.1592315440653;
        Tue, 16 Jun 2020 06:50:40 -0700 (PDT)
Received: from localhost.localdomain (118-171-140-99.dynamic-ip.hinet.net. [118.171.140.99])
        by smtp.gmail.com with ESMTPSA id y81sm17451102pfb.33.2020.06.16.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 06:50:39 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6358: Remove BROKEN dependency
Date:   Tue, 16 Jun 2020 21:50:30 +0800
Message-Id: <20200616135030.1163660-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD part is merged into v5.8-rc1, thus remove BROKEN dependency.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c398e90e0e73..f60eeaae7afd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -694,7 +694,7 @@ config REGULATOR_MT6323
 
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
-	depends on MFD_MT6397 && BROKEN
+	depends on MFD_MT6397
 	help
 	  Say y here to select this option to enable the power regulator of
 	  MediaTek MT6358 PMIC.
-- 
2.25.1

