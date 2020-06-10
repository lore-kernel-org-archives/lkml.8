Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF232064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dp78FMTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFJHsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgFJHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:47:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44C9C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:47:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so734468pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=dp78FMTkX/1hJTaR4QYkcHQUaUVIESR4j5kc63tOAbf8hOuzjuBzZFRWA0YGERKt1q
         Fe+frKwucez80KwyDfZZhvqQ43xy385tpF1u3N1dUcrGgXUnhmSuOgypFwPorgFp/EE1
         x5k1cy/YYVD9vjPMqhXe44SNx7RmE4yLW+x0e1bQIEsKlEDZH+vvW6KgntpZFTDdDNOg
         CxEWx4C19RqCWnHyGto6GJxHQzYTINLSpdxjiRdHvZWdQL9f7VO1x+yLdVkz3iubkSvB
         OIoPprlM3jlTcDXIOMAxCFC/fK1u+pI49c+RO7r94JS8/SsoaDAz/kxUU7jdUEfHxJAD
         JSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=BfCBTsSo7KuaoGwA/pSaf4RYFOAZHVu4MmQVOUiOBCiX36ElLu7Mfny9HplgjZPRmf
         tZA6eI4uW1Jec+mn865uYRsX3kyCziFMBL66yKoLJHm7NEYsipugvNOzbc5A7jnQxvzw
         wgKRscJlLIqgUrbEmtuW5CaZVtpBf6dTPUXkNstTcQeNOIQ3exXMMjljR7+dC32Pzfxm
         ghXtearMogQ+Q0D0tOkTprFG/lc9pd/dxxGaVC/4G9cNPTJfYQ6FwUm1txtO+qWVWgVv
         veg/x0n9tL+oifGMklvxcV0XcGynI3ANotYa6tmOMiwYoxtFFJO/vDXO777qvRU7UCRB
         BiiA==
X-Gm-Message-State: AOAM533YwqDXGkZf5xvfJ7NXNVi9puQgkp1ty2dZxgC9rbW693Ec3GkQ
        ZeIsoL+rfIrhR1tBRqkwgsrT
X-Google-Smtp-Source: ABdhPJyKw3UJzSTMp9lhzgNqf67W/XlxmmABmAg82mh6fgAO8XDUkxzjD7gXIfEdOVKdAMsBrIFLJw==
X-Received: by 2002:a63:f854:: with SMTP id v20mr1693743pgj.0.1591775278160;
        Wed, 10 Jun 2020 00:47:58 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id u1sm10075040pgf.28.2020.06.10.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:47:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 6/6] MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver
Date:   Wed, 10 Jun 2020 13:17:11 +0530
Message-Id: <20200610074711.10969-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
References: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Microchip MCP25XXFD CAN network driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..591b6fc2d83a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10360,6 +10360,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
+MCP25XXFD CAN NETWORK DRIVER
+M:	Martin Sperl <kernel@martin.sperl.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+F:	drivers/net/can/mcp25xxfd/
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

