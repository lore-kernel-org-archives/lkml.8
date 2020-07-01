Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C5BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCD920772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9lB95Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgGAMrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbgGAMrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18DC03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so23669076wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yd63tKAD8TEw//9s1TXw4/kd8gj1ZByx7XV4rk7dLd0=;
        b=c9lB95ZlSkCDr8FrC6iJ4ySeiJo/PwpxEuvTW8mPxbMi7ihPg/iN9Ag0/siQ+aqpIN
         lJhnsv+KPo9I9zWCV2sxE1dhJLOJGFRNycvWH0auT6M8XZ7Mm/CEmwTqIi/r6BvFoFbn
         ZF67z9oamZZJ9uq+qhic/shA3dVgWeBSmdEv+aV9UMhqA1T2lxOnICn52HaGh14Z8zLs
         JlM+mZTh/a6C65EV3n2CX9SPSXdqj7qDRm8JgZVHxNSzK4s2KBtcxSMAE3tkpiwImxEL
         DLIl0Ew6S3oRNZnBNegDJAc0B6jWmDJxM/kmE9KyRsqZ+dUn1sLkGLyi21Q94OtsfMI6
         T5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd63tKAD8TEw//9s1TXw4/kd8gj1ZByx7XV4rk7dLd0=;
        b=Jlx9ZgVwyFg4neYuPkLs4SsaHHCYbFU08JRTHjraSflfGOZOEZT+rF3Fqz5U3GvipP
         tXhcY0w3Fh1Ee62J5Zy6rhUr6lYjaUl262lS8xjCWhSYsOvkuzN0c8f6LaO5uFJQrB9P
         q1V0zjLIpy42Kp3ANIU64006polG88K0VCUOww+osejgAN3Kn4GeeQFgcTfr+shBTCbt
         iV2TJAa+h/Q+AgQRRsqnDj/GOWOgllPHBa17HcWCakX0c8FMxq99lZfNr2/4Bf6O2WQs
         x7bvr5fILb0niJq152AnZj2P8x9JSr0CN2MOP5W76i+2KJhySEsh//qdhBpqIYb+zBcX
         dRKA==
X-Gm-Message-State: AOAM533RXudR6BpfLh2NjqJ8yB7yHIFeitCGMZlXBKre8ofEthPdE/jb
        G+BQI2dOXkjrrR8VUzo7XKhlnw==
X-Google-Smtp-Source: ABdhPJwshEQk22UxiuotqnoaKHFLuGrVwcP2gpb1t5Bt9UatQsrYDEIsRgMqxO9yunUFcwD7M//wEQ==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr26559514wrq.91.1593607636400;
        Wed, 01 Jul 2020 05:47:16 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Abraham <thomas.ab@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 08/15] mmc: host: dw_mmc-exynos: Add kerneldoc descriptions of for 'dev' args
Date:   Wed,  1 Jul 2020 13:46:55 +0100
Message-Id: <20200701124702.908713-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide missing documentation for dw_mci_exynos_suspend_noirq() and
dw_mci_exynos_resume_noirq() function headers.

Fixes the following W=1 kernel build warnings:

 drivers/mmc/host/dw_mmc-exynos.c:184: warning: Function parameter or member 'dev' not described in 'dw_mci_exynos_suspend_noirq'
 drivers/mmc/host/dw_mmc-exynos.c:200: warning: Function parameter or member 'dev' not described in 'dw_mci_exynos_resume_noirq'

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 5e3d95b636769..bd59186f59b39 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -176,6 +176,7 @@ static int dw_mci_exynos_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 /**
  * dw_mci_exynos_suspend_noirq - Exynos-specific suspend code
+ * @dev: Device to suspend (this device)
  *
  * This ensures that device will be in runtime active state in
  * dw_mci_exynos_resume_noirq after calling pm_runtime_force_resume()
@@ -188,6 +189,7 @@ static int dw_mci_exynos_suspend_noirq(struct device *dev)
 
 /**
  * dw_mci_exynos_resume_noirq - Exynos-specific resume code
+ * @dev: Device to resume (this device)
  *
  * On exynos5420 there is a silicon errata that will sometimes leave the
  * WAKEUP_INT bit in the CLKSEL register asserted.  This bit is 1 to indicate
-- 
2.25.1

