Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9905CC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764D420728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuLVk7tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDWUej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgDWUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:34:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B4C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:34:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so2810010plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6QHYAQNJk/r7RcX2egg9QjNYJDfZ7VPfp2pyf+zOWQ=;
        b=iuLVk7tU3P3H5Mb1U3zBU4nWhOhIRU5F/zHi9uFNWmfJsHIbXcw1Fq8YtaDEcAOuR3
         JPhKTcSr8mLnmintaxTFgbNsVH/uXvrg8cNfE/krwGJFmsJlsqYeRV7sr6oqMdseMFSQ
         Qd39yC6MzTDdmRRmpM+96KY4wn8Z7GUwGDU9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6QHYAQNJk/r7RcX2egg9QjNYJDfZ7VPfp2pyf+zOWQ=;
        b=CrAchp5d+DbuXP6ACItWLucjtmvxQo0zKbc1gfFi8YD8YU53MrELGsFVgeZ9oqh9L3
         vUgrrETUbRXM1uRt6njbC0oSMxhA2mwTMp7Roqzduc6w9s4ZLajLt3an5Cv+9RJonBYP
         9I2jz4D+8EZdmZ9eKbH9Veczi4Npilo2ddguR5QzHC6l2JZMVs77OJYcZsW//B1uEeAp
         17HDQr9rPDQSrf3g064V7M8A3ru8eycL+9c56KUQwRAOojiAqI8636OG2PBBQmsYB+X7
         yTc6h9HNSXEDy2mwN/zRTwVg0jhK+1uQnuhFa7QbVNt3RL98kQd/Q1oufTryAanbwTxl
         OD/g==
X-Gm-Message-State: AGi0PuY4yxyMN3x6vuDhipDSJqYu6EneVfjxnuAG0+010qk9PggII13w
        mdCCwYMnmv3cRD4k25R/5ydKXDIo4J0=
X-Google-Smtp-Source: APiQypJXeojnpJa/3rx7LWMgNYonCQfG+V/x3GE+RkoYxeMue+ICy0iF43qe2z6K+6WZkzhatKZVpg==
X-Received: by 2002:a17:902:8688:: with SMTP id g8mr5781326plo.268.1587674075346;
        Thu, 23 Apr 2020 13:34:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c3sm3391925pfa.160.2020.04.23.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:34:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH] gpiolib: devprop: Warn if gpio-line-names is too long
Date:   Thu, 23 Apr 2020 13:34:16 -0700
Message-Id: <20200423203416.133274-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DT authors (including myself) have messed up the length of
gpio-line-names and made it longer than it should be. Add a warning here
so that developers can figure out that they've messed up their DT and
should fix it.

Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib-devprop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-devprop.c b/drivers/gpio/gpiolib-devprop.c
index 53781b253986..26741032fa9e 100644
--- a/drivers/gpio/gpiolib-devprop.c
+++ b/drivers/gpio/gpiolib-devprop.c
@@ -37,8 +37,11 @@ void devprop_gpiochip_set_names(struct gpio_chip *chip,
 	if (count < 0)
 		return;
 
-	if (count > gdev->ngpio)
+	if (count > gdev->ngpio) {
+		dev_warn(&gdev->dev, "gpio-line-names is length %d but should be at most length %d",
+			 count, gdev->ngpio);
 		count = gdev->ngpio;
+	}
 
 	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
 	if (!names)
-- 
Sent by a computer, using git, on the internet

