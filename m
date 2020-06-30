Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25072C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0716520722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/GhyMw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgF3Neu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388152AbgF3Ndw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA1C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so18836218wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KDVLpzHsMQDeKu96sh9LYIj12RVnAxA/ichztsrMZQ=;
        b=x/GhyMw3/PifnbCbFgYc7YsXMeDkSg5tTzV3oQIeQg6caOEYi+xswGvOI4ODzVR/8n
         iYpm0sI3ldVEWE09KVrxRclwDY+yPK6PRD4DJgs9uGscSp38D6ptpQ1FCdluuhPOl+3a
         fjUpiqUFSOdZEY8qRBCBH2z1Xp7eeoe0+lVECx17sZjtUMuLT84RMxJ1egmxJL5M4AyA
         FyjcF0JSFT6aIyLB57aBRZk7L9szqdI9Oh3iXaf7HgtrY7jWAvB45lA39yduqcbnBQ/4
         YDdIIUEW1DQrsDmASh/wUS7qq16C1l2mnsG2iKBst8FVZG1WDGPO9hfscMSITQxIUidG
         53Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KDVLpzHsMQDeKu96sh9LYIj12RVnAxA/ichztsrMZQ=;
        b=ZiimIyhQzRi0b3wLG1ZxDn9PdHeWV8TdOO9otxUhW/Dzf0Mevb1QpTH7U8tKmtJ34q
         SOuoszgwUf7LEzum2ku4JYpmzTifiMHXUG26N2b8gjwv4WZggKT0Zf0g4+QqqZ1hl6pV
         w1yDveagxV4nPM436tTE+vcChfMIcFxoAdJ61if2N9483ob+LMD6/vrPIEgxolGS6bAQ
         9TZlNMDKveFEn9AfoeUiiwQODyK/xcO6bId5SARKeWRgnd5gLAPVOkeYeWztFDkI/XVi
         9TF8QkbU4GGuNnW9biOSv353DOewB51SUr9YEp4i0WTqvZIYujFvuObay29QHOf8Pn+0
         6TUw==
X-Gm-Message-State: AOAM5322ycYUqsRqmzpsBR4bvhp+KFHKVpdmKbDWkx4xo0B6p6W+Yh/h
        wdyaUDw8kYPoIoZRem6clnH2NSVK/0M=
X-Google-Smtp-Source: ABdhPJyW4GtmRxifF3bHq9VjFlQY+qelF9g4jJYBP6hKH+QoodWUb+3zaFky4HbgEYJPkrGSE/VpMw==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr22156497wmd.111.1593524030718;
        Tue, 30 Jun 2020 06:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Tien Hock Loh <thloh@altera.com>
Subject: [PATCH 02/10] gpio: gpio-altera: Add missing kerneldoc entry and demote comment
Date:   Tue, 30 Jun 2020 14:33:37 +0100
Message-Id: <20200630133345.2232932-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct altera_gpio_chip's 'irq_chip' property is undocumented.  So
add property description to the struct's kerneldoc header.  Also
demote comment block which is clearly not in kerneldoc format.

Fixes the following W=1 warnings:

 drivers/gpio/gpio-altera.c:34: warning: Function parameter or member 'irq_chip' not described in 'altera_gpio_chip'
 drivers/gpio/gpio-altera.c:78: warning: Function parameter or member 'd' not described in 'altera_gpio_irq_set_type'
 drivers/gpio/gpio-altera.c:78: warning: Function parameter or member 'type' not described in 'altera_gpio_irq_set_type'

Cc: Joyce Ooi <joyce.ooi@intel.com>
Cc: Tien Hock Loh <thloh@altera.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-altera.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index cc4ba71e4fe3c..b7932ecc3b613 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -24,6 +24,7 @@
 * @interrupt_trigger	: specifies the hardware configured IRQ trigger type
 *			  (rising, falling, both, high)
 * @mapped_irq		: kernel mapped irq number.
+* @irq_chip		: IRQ chip configuration
 */
 struct altera_gpio_chip {
 	struct of_mm_gpio_chip mmchip;
@@ -69,7 +70,7 @@ static void altera_gpio_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&altera_gc->gpio_lock, flags);
 }
 
-/**
+/*
  * This controller's IRQ type is synthesized in hardware, so this function
  * just checks if the requested set_type matches the synthesized IRQ type
  */
-- 
2.25.1

