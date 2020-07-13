Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC226C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA5F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFwy12mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgGMOvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A17C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so13588170wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xfpl3krDlT8kqZoXWzMglbVA6yEQ7zQak8/zpsxBtws=;
        b=QFwy12mDhDjXsi8jVGm7MW3MzZHhi8fRtIBh763h/vU/iQIW2/e1ZjkNEqZRwTIsqI
         CVDQDQtRvNYzadV4mD+IQhF2tjgLdCuLoPFkjryFjF+nPggWzC0JBnNsAKpEeIzOXDXN
         fBc6w3f1kv0Efauvy1IP3qnvUxn9KYSk+OMgMICKfSwkIp22oX5CnpBORnfGVuGhgGPl
         uLTtCHN2qxiRuJPvxhRJ8RiGLDOSzQrIGXTmhwimhR2qFsDxEKYXSflgGfLyb2xInSbI
         qPiG9SuYlN0KdAhvKjOTrbIia8fR6wPLyfXDZTIGySrTc4wLowscvahoSUb0jdJEOErV
         Np+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xfpl3krDlT8kqZoXWzMglbVA6yEQ7zQak8/zpsxBtws=;
        b=PGYMAC6BXgCb1X6JD9kVZ6P5vof1vwo0yEmvT2L2hhMAh0qW5jU5XIDu3p7G0t7j03
         6WZCvvjKzL2/jBg0OVZX29T1A/TtRyEqxP6HyE4js8z4M48fxsC5ySGzAb2z2bPawSv4
         DJUA0faSTIroIF4o7nHK2PU+gMueEjvk6ItwdacK0/4T4TgaxRfcy08hADozhLCX8SKf
         gZ7Ob8O0zZnToTE/MlBeKTjhrq/1Yo08hJYm8bHHNlco8zh3qZ6MBJ1V2pMUl9Nmz5mE
         sMsUwzi9gGFiJigpWjugcZWo2s1L9E22nzy6q6K0gl9uIwleyiLUZtfLg4jElRhr7n8l
         Sw0g==
X-Gm-Message-State: AOAM532Y76w6ecDrk0AEaZk9Y7jfmcgX5Q6TSyRTcEQ7fSAdKYWNg/5i
        Q+WcwivLX+vrw6wfFclwWwIbrw==
X-Google-Smtp-Source: ABdhPJy3THByD16kYAsdQxLpJ7HKN6a8GpMJZ7qg/5/jCy7o5x18Xh0IE12RhAiUnL2EOxQsIhqfHw==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr319860wmd.104.1594651776266;
        Mon, 13 Jul 2020 07:49:36 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 03/25] pinctrl: bcm: pinctrl-bcm281xx: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Mon, 13 Jul 2020 15:49:08 +0100
Message-Id: <20200713144930.1034632-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been little to no attempt to document any of the demoted
structures here.  These are obviously not kerneldoc headers.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/bcm/pinctrl-bcm281xx.c:65: warning: cannot understand function prototype: 'enum bcm281xx_pin_type '
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c:79: warning: cannot understand function prototype: 'struct bcm281xx_pin_function '
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c:89: warning: cannot understand function prototype: 'struct bcm281xx_pinctrl_data '

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index 71e6661783006..9ab1f427286a7 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -59,7 +59,7 @@
 #define BCM281XX_HDMI_PIN_REG_MODE_MASK		0x0010
 #define BCM281XX_HDMI_PIN_REG_MODE_SHIFT	4
 
-/**
+/*
  * bcm281xx_pin_type - types of pin register
  */
 enum bcm281xx_pin_type {
@@ -73,7 +73,7 @@ static enum bcm281xx_pin_type std_pin = BCM281XX_PIN_TYPE_STD;
 static enum bcm281xx_pin_type i2c_pin = BCM281XX_PIN_TYPE_I2C;
 static enum bcm281xx_pin_type hdmi_pin = BCM281XX_PIN_TYPE_HDMI;
 
-/**
+/*
  * bcm281xx_pin_function- define pin function
  */
 struct bcm281xx_pin_function {
@@ -82,7 +82,7 @@ struct bcm281xx_pin_function {
 	const unsigned ngroups;
 };
 
-/**
+/*
  * bcm281xx_pinctrl_data - Broadcom-specific pinctrl data
  * @reg_base - base of pinctrl registers
  */
-- 
2.25.1

