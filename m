Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A3C206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgt19lMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgF3NeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388168AbgF3Ndz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAFC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so19613268wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVRFyI7gMPSCpFThQPOO71zLy3/PBdN3qWCTPbMiXks=;
        b=qgt19lMGK+EwYSjtxdGtnfQI+W4/0k5CuiIuR80c/9n/twpmcJ6PiG2Uu1mz5GFFkK
         AUTe0bdiZWK0juZgx80T2vbTxbfPXM+cjTrYjRQbjmsbmhbS9C0U6/shpZXE6Z5V5DqD
         KGdB2MA/Ap0lBLfXKNkTY/YevFiJ0KdsreHz/dM9+h2/Gntcfo7AhMM9o4Qb2RLQYdwj
         1lfjqrZazfSzDW2nHscL+gd/e+98e4KmtSfApChaUTKTxwYIIDjTGbfIa+VDaUrRtsT5
         F9Qv0dpXUaovM1dIRPgj9VJdlruRfLYko0xsY+TucjB+K42meBmljWjWADwwB4WClmzT
         O8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVRFyI7gMPSCpFThQPOO71zLy3/PBdN3qWCTPbMiXks=;
        b=gJ7KgFlTJpaiuwL0eHQvozWx2zrZLfL3dSpgqLI1VaZtL5/IyzEElLHcLcKOAGri20
         ihNhG07FQawA5Oh91b7kv+kxL82XT2bswy49OOlf9WDP/KcpbGpWC3Qh8awofFFAz/27
         moK//7S+cI6ddEfmhNmKzXSLPFEJGB/KQ66UxJ4/nkW/XxTWVLKrTOOi0zvZ3zvRBNVP
         KAbBSRyvUjwsQ3kG7ar450zaeTXAZY4Tr+p+t2JPRKX9o7K4fW+bVWrRXFtUsAodudaC
         jV6RGe9j6MRtCsYBeC/G+AlUVtuw733Dp7hT/6u+tqUaTfrxxm5jVZ6iSN0jP7BWyRW9
         oXeA==
X-Gm-Message-State: AOAM531kWmYzDjb5YC+9EQ2YWFcOzCvVp5fVx0tPuvX1tuG2s7tn9jGN
        a0MNYy8al7ep11RMl4pzfaG/3g==
X-Google-Smtp-Source: ABdhPJwtQjgdwmmsWj1j8nXmCgvlDtGtfE76f3lplQO2CPaJKrzNdygk9VxYczxqVvfWrMamk5G93Q==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr20601830wmn.167.1593524034128;
        Tue, 30 Jun 2020 06:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>
Subject: [PATCH 05/10] gpio: gpio-sama5d2-piobu: Demote all kerneldoc headers to basic comment blocks
Date:   Tue, 30 Jun 2020 14:33:40 +0100
Message-Id: <20200630133345.2232932-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to provide proper descriptions for each of
the function arguments throughout the file.  Simply demote all
kerneldoc headers to basic function headers.

Fixes the following W=1 kernel build warnings:

 drivers/gpio/gpio-sama5d2-piobu.c:59: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_setup_pin'
 drivers/gpio/gpio-sama5d2-piobu.c:59: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_setup_pin'
 drivers/gpio/gpio-sama5d2-piobu.c:81: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_write_value'
 drivers/gpio/gpio-sama5d2-piobu.c:81: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_write_value'
 drivers/gpio/gpio-sama5d2-piobu.c:81: warning: Function parameter or member 'mask' not described in 'sama5d2_piobu_write_value'
 drivers/gpio/gpio-sama5d2-piobu.c:81: warning: Function parameter or member 'value' not described in 'sama5d2_piobu_write_value'
 drivers/gpio/gpio-sama5d2-piobu.c:97: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_read_value'
 drivers/gpio/gpio-sama5d2-piobu.c:97: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_read_value'
 drivers/gpio/gpio-sama5d2-piobu.c:97: warning: Function parameter or member 'mask' not described in 'sama5d2_piobu_read_value'
 drivers/gpio/gpio-sama5d2-piobu.c:116: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_get_direction'
 drivers/gpio/gpio-sama5d2-piobu.c:116: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_get_direction'
 drivers/gpio/gpio-sama5d2-piobu.c:131: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_direction_input'
 drivers/gpio/gpio-sama5d2-piobu.c:131: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_direction_input'
 drivers/gpio/gpio-sama5d2-piobu.c:140: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_direction_output'
 drivers/gpio/gpio-sama5d2-piobu.c:140: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_direction_output'
 drivers/gpio/gpio-sama5d2-piobu.c:140: warning: Function parameter or member 'value' not described in 'sama5d2_piobu_direction_output'
 drivers/gpio/gpio-sama5d2-piobu.c:154: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_get'
 drivers/gpio/gpio-sama5d2-piobu.c:154: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_get'
 drivers/gpio/gpio-sama5d2-piobu.c:174: warning: Function parameter or member 'chip' not described in 'sama5d2_piobu_set'
 drivers/gpio/gpio-sama5d2-piobu.c:174: warning: Function parameter or member 'pin' not described in 'sama5d2_piobu_set'
 drivers/gpio/gpio-sama5d2-piobu.c:174: warning: Function parameter or member 'value' not described in 'sama5d2_piobu_set'

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Andrei Stefanescu <andrei.stefanescu@microchip.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-sama5d2-piobu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index 4d47b2c411868..b7c9506581701 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -49,7 +49,7 @@ struct sama5d2_piobu {
 	struct regmap *regmap;
 };
 
-/**
+/*
  * sama5d2_piobu_setup_pin() - prepares a pin for set_direction call
  *
  * Do not consider pin for tamper detection (normal and backup modes)
@@ -73,7 +73,7 @@ static int sama5d2_piobu_setup_pin(struct gpio_chip *chip, unsigned int pin)
 	return regmap_update_bits(piobu->regmap, PIOBU_WKPR, mask, 0);
 }
 
-/**
+/*
  * sama5d2_piobu_write_value() - writes value & mask at the pin's PIOBU register
  */
 static int sama5d2_piobu_write_value(struct gpio_chip *chip, unsigned int pin,
@@ -88,7 +88,7 @@ static int sama5d2_piobu_write_value(struct gpio_chip *chip, unsigned int pin,
 	return regmap_update_bits(piobu->regmap, reg, mask, value);
 }
 
-/**
+/*
  * sama5d2_piobu_read_value() - read the value with masking from the pin's PIOBU
  *			      register
  */
@@ -108,7 +108,7 @@ static int sama5d2_piobu_read_value(struct gpio_chip *chip, unsigned int pin,
 	return val & mask;
 }
 
-/**
+/*
  * sama5d2_piobu_get_direction() - gpiochip get_direction
  */
 static int sama5d2_piobu_get_direction(struct gpio_chip *chip,
@@ -123,7 +123,7 @@ static int sama5d2_piobu_get_direction(struct gpio_chip *chip,
 				   GPIO_LINE_DIRECTION_OUT;
 }
 
-/**
+/*
  * sama5d2_piobu_direction_input() - gpiochip direction_input
  */
 static int sama5d2_piobu_direction_input(struct gpio_chip *chip,
@@ -132,7 +132,7 @@ static int sama5d2_piobu_direction_input(struct gpio_chip *chip,
 	return sama5d2_piobu_write_value(chip, pin, PIOBU_DIRECTION, PIOBU_IN);
 }
 
-/**
+/*
  * sama5d2_piobu_direction_output() - gpiochip direction_output
  */
 static int sama5d2_piobu_direction_output(struct gpio_chip *chip,
@@ -147,7 +147,7 @@ static int sama5d2_piobu_direction_output(struct gpio_chip *chip,
 					 val);
 }
 
-/**
+/*
  * sama5d2_piobu_get() - gpiochip get
  */
 static int sama5d2_piobu_get(struct gpio_chip *chip, unsigned int pin)
@@ -166,7 +166,7 @@ static int sama5d2_piobu_get(struct gpio_chip *chip, unsigned int pin)
 	return !!ret;
 }
 
-/**
+/*
  * sama5d2_piobu_set() - gpiochip set
  */
 static void sama5d2_piobu_set(struct gpio_chip *chip, unsigned int pin,
-- 
2.25.1

