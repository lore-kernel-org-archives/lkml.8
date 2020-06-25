Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B690EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E64320773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVXl0wtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390287AbgFYGqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390155AbgFYGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4BBC061798
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g18so4626889wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2LvBowpzfqfQHnK/gnFZDPalEMEwUf10cp2QuQIuRg=;
        b=MVXl0wtgTNbcqhYy50uwzSMS91a5du9fhzg4oeB/etwz+t21MCLhi+PSWsJnrEyp3H
         37sCoamMGW5zxACUygyfAjblD0iWrElfagnCgzarbJmDFtDaBnfibzhRcELTWRTz6+f7
         dAi5vForunxsCLorBb9k5irOYwFYlroFBnbYQ1jQfAosFB6pAR4irkMzKX7m8YjCMfG/
         CtRLuLArlmcY/lmBV/bEL17oZ9ZujckJiDZXTLnMsNwn3W3g4RPRBmTy3T6cIdrOxqez
         DbK7Q3oChBAP1tW0xprzEo4N3hk/VQGb0VfV/LS1HQKjjxRD12nh6V7Q/w8KLxSkDACU
         DcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2LvBowpzfqfQHnK/gnFZDPalEMEwUf10cp2QuQIuRg=;
        b=D+x9Ve3Tt6KMlJUVYv0nApNiUH8xMrCXE9icaB1zfY/ZYFUxMSiWX5bAqFoTMixGQa
         PEwnRu3Roflr2IokZd/O5eUeunHFaKu/drD6cE2VQcrFd/UjRfjRkXnlQ1FbacjhnbCG
         pmFx4MQA1RqHy78AGlyMExtR4lOq3eDonI8nmb90tsujc7ppEWWiyfxT6iQR89/7rnpc
         vczXnmNV4Eu61hptsnbORB3taLOAkiyZLyUkCGJEbZ1vjyex5JHyWRKFbF/0V+Co2y+0
         yICtSxSeKOswIAqtbsudkHskxtaPV6BSpam8TuAHEDFwn4rwR5sO57mmp7/1oDYUT1Su
         lnGQ==
X-Gm-Message-State: AOAM532FPaSZB+mQGssug7zKDywNh02MRDMov84I8eWzomGvw5t3f9Lr
        c1C5jX6Sr3wI1jl1Zx5tOQtbtg==
X-Google-Smtp-Source: ABdhPJz8KzvsZKFGSyJkJ71Ru54KSb6+CeeKrbaJt/6Ar9O5KO9HCidzIoTFO4ALy3HXGkPV6umT0A==
X-Received: by 2002:adf:8091:: with SMTP id 17mr33043279wrl.244.1593067596171;
        Wed, 24 Jun 2020 23:46:36 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 09/10] mfd: atmel-smc: Add missing colon(s) for 'conf' arguments
Date:   Thu, 25 Jun 2020 07:46:18 +0100
Message-Id: <20200625064619.2775707-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625064619.2775707-1-lee.jones@linaro.org>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc valication gets confused if syntax isn't "@.*: ".

Adding the missing colons squashes the following W=1 warnings:

drivers/mfd/atmel-smc.c:247: warning: Function parameter or member 'conf' not described in 'atmel_smc_cs_conf_apply'
drivers/mfd/atmel-smc.c:268: warning: Function parameter or member 'conf' not described in 'atmel_hsmc_cs_conf_apply'

Cc: <stable@vger.kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/atmel-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
index 17bbe9d1fa740..4aac96d213369 100644
--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -237,7 +237,7 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_cycle);
  * atmel_smc_cs_conf_apply - apply an SMC CS conf
  * @regmap: the SMC regmap
  * @cs: the CS id
- * @conf the SMC CS conf to apply
+ * @conf: the SMC CS conf to apply
  *
  * Applies an SMC CS configuration.
  * Only valid on at91sam9/avr32 SoCs.
@@ -257,7 +257,7 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_apply);
  * @regmap: the HSMC regmap
  * @cs: the CS id
  * @layout: the layout of registers
- * @conf the SMC CS conf to apply
+ * @conf: the SMC CS conf to apply
  *
  * Applies an SMC CS configuration.
  * Only valid on post-sama5 SoCs.
-- 
2.25.1

