Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31456C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0716F2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="dSKspFOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHSJAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:00:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747ADC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:00:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so11094773pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8UtwaqIlfVSIB6Dt6GOUKZqlSP3TY6fuzqmfdsiMlo=;
        b=dSKspFOpyxBO+8KHrabzB69kVWMmqjclzNTYuKF+IitXoGXlw3VBRROMVBIwCNyr38
         bqhoo9xnoHzU9yR3bbGXuSrNx6+xx9z2Iix2Q8XFFp1UCyN14mWorT+045QulTe0VrX3
         1+myvd9GIEIzoEd48GrMet2jdz4LxXZZG+LSqfG2CZAoabIhGuFAidA0rmKeoJFIGTjR
         HwbtbVi458OMOnkcFCmMX4PATh66pkOMpbg7OKC8oTIY9Pxo+wrR6bHDdKQGI12gF9s5
         7h7Znn7HTnRjRkiBp9TtvVpXHfYnbe7Omo1wwHQ/KI1g1IaA3yuLyIV+eFlt6n9IDTOd
         fjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8UtwaqIlfVSIB6Dt6GOUKZqlSP3TY6fuzqmfdsiMlo=;
        b=gTJ/nERSu+tlnAg8kb8FdOnjJKHgZjWZnm70UPalhhdeyC8aKplhzPwOsq3miO/Nog
         165h3kCV5bs5nKvFk6WlXD3WPkRPakuxD1Lgk26liXEx+lQpjE7rmKBsS1triJb47BlY
         W/q41TDOYfD8wtpmC5dhsKwjeFt5MHnWoJfemoo7a7hwWRMsj7J1d+DtCz8Fc8dCZ8Ga
         QqqW1mGPcN2NIR6Qo7euy3QKmupcwS3WCEOQy+KoZ4c9uLd+0WBpV3BNWabL2GMaw7eS
         wom0EoL84bRDwq0Hq/hujbuXo6ftmEZpH4G1kY3WoVIXMLUG5kaHVGqW6sSOQFcohJRp
         MLDg==
X-Gm-Message-State: AOAM533lhyw3Mf/j9RX0bSmd9+a0ziQKeBjI3zCwtUPAtvSX4GzkvhSu
        AZKZ3tSnHkYPLA1UhXVsOg03vQ==
X-Google-Smtp-Source: ABdhPJzzAkaNBRKKdL70R6JqGRiEeKD6sO8fKKx80iWvU/qSvK9Flv5EmV0SxIY5S6PiJjb4hZ99+A==
X-Received: by 2002:a62:e704:: with SMTP id s4mr19235303pfh.177.1597827637401;
        Wed, 19 Aug 2020 02:00:37 -0700 (PDT)
Received: from localhost.localdomain (36-239-211-11.dynamic-ip.hinet.net. [36.239.211.11])
        by smtp.gmail.com with ESMTPSA id u5sm12827237pfm.149.2020.08.19.02.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 02:00:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt4801: Select REGMAP_I2C to fix build error
Date:   Wed, 19 Aug 2020 16:59:59 +0800
Message-Id: <20200819085959.1914471-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_REGMAP_I2C is not set.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index ebce11cbab44..f719ed5a8c33 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -907,6 +907,7 @@ config REGULATOR_ROHM
 config REGULATOR_RT4801
 	tristate "Richtek RT4801 Regulators"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  This adds support for voltage regulators in Richtek RT4801 Display Bias IC.
 	  The device supports two regulators (DSVP/DSVN).
-- 
2.25.1

