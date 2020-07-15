Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A55C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DAA2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuVa6YUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGOPHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgGOPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EEC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so5928598wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKemoWjqR6g96Xgsgirmftjm/E0sdVIsOFgpktr/D0I=;
        b=MuVa6YUilZbMg938X6+LEiTeMKwmIyt0RScRI3mHKMSuc868HMtye15e+tdjz7hn5l
         pm6AT7nOyryMAZpDFrCikxebECb2ckO+QnyNGZ5PNQYIudu90DgxNcpa4DuPtVhVjIUa
         SN8IPX+xnfZAB8oFwQjswqvmWXCNl5KOCfrc+RCbt7EJY9QOTaIuoG+4Ay8r/xYX+oJh
         iZGI4AKMukXc74MYDDnc2SxtzANeEqihLcQ94ZD+XxjhGJHuZ3b07myurXNAUcCQLAD/
         g50CYKeZ/F5UaVtwBdnc/n2IPvzfF6dQV/1Bf5xrb2Hm5uRn+r/OYpDGHLKgLuhHWo1R
         IO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKemoWjqR6g96Xgsgirmftjm/E0sdVIsOFgpktr/D0I=;
        b=gGWOxJW2gZU1LGx7pLfLTPZMBpL2Wr64lruFh8XAu/gX9zSL/xA9C0VUZSqcUHtMU3
         1a8U7nXiBuc6FCXaaxEHGcd/CwPNBsh/5kgBy3O1tqHbtguBDQkst83fQ3Q0yjYHPCaf
         8thdpfCHOl+cpicyLc9FxJ3r5BNEGZuOdnSOJbz8Ld9zCLgeRu0uorVfNVElXvR5EJKM
         sgSDDyh6tcY63QjqPYdiv4Y6p8NiqLiOVrq2qYdBr3eOe8bBlI8ztRgz5ucdSQLkrLQW
         HhChvFoJpGfwpmEaTeIi6Hcl6s1jVjF+kb6D4PhjucOQmpDwnLoZzK+eeigCbO+vCHeJ
         xcFg==
X-Gm-Message-State: AOAM530sMo7YCIcfgiIRd3mUQDxqFpyHF5UHB5YX+sQ9Ao3OJfd6sflE
        IDBuTL9l/ZSKV/6DzFb+Dt6pVg==
X-Google-Smtp-Source: ABdhPJyX7pdGpzS47hcVgtTiOYRgvA0VEgqvOXAjH60JAODiKRtGtZA78dSsUpVRg8hrCzcXmu+7PA==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr9037305wmi.35.1594825598535;
        Wed, 15 Jul 2020 08:06:38 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
Date:   Wed, 15 Jul 2020 16:06:21 +0100
Message-Id: <20200715150632.409077-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-davinci.c:249: warning: Function parameter or member 'dspi' not described in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:249: warning: Function parameter or member 'max_speed_hz' not described in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:249: warning: Excess function parameter 'maxspeed_hz' description in 'davinci_spi_get_prescale'
 drivers/spi/spi-davinci.c:719: warning: Function parameter or member 'data' not described in 'dummy_thread_fn'
 drivers/spi/spi-davinci.c:719: warning: Excess function parameter 'context_data' description in 'dummy_thread_fn'
 drivers/spi/spi-davinci.c:735: warning: Function parameter or member 'data' not described in 'davinci_spi_irq'
 drivers/spi/spi-davinci.c:735: warning: Excess function parameter 'context_data' description in 'davinci_spi_irq'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-davinci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f50c0c79cbdfa..818f2b22875d2 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -236,7 +236,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 
 /**
  * davinci_spi_get_prescale - Calculates the correct prescale value
- * @maxspeed_hz: the maximum rate the SPI clock can run at
+ * @dspi: the controller data
+ * @max_speed_hz: the maximum rate the SPI clock can run at
  *
  * This function calculates the prescale value that generates a clock rate
  * less than or equal to the specified maximum.
@@ -710,7 +711,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 /**
  * dummy_thread_fn - dummy thread function
  * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
+ * @data: structure for SPI Master controller davinci_spi
  *
  * This is to satisfy the request_threaded_irq() API so that the irq
  * handler is called in interrupt context.
@@ -723,7 +724,7 @@ static irqreturn_t dummy_thread_fn(s32 irq, void *data)
 /**
  * davinci_spi_irq - Interrupt handler for SPI Master Controller
  * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
+ * @data: structure for SPI Master controller davinci_spi
  *
  * ISR will determine that interrupt arrives either for READ or WRITE command.
  * According to command it will do the appropriate action. It will check
-- 
2.25.1

