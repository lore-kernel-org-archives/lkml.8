Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CC5C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AD424672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="J1SA/EVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgANPDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:03:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45767 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgANPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:03:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so12452745wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIqjqYnUNYC6xaFfZJXPmBMgwbD3vdDEMlsV0H3SJ/M=;
        b=J1SA/EVXpekAUyQtQL9GA9mqROIbfPpkW2dVRKXu7EoIolIojcPxdnUis5zZ2jjfkP
         /iNE42kjv311m4HWlgCaIxzvQN+o2Ew56lWvyScq5D6nhkMXBctcLaKcJHTWkKCIhjWK
         H4fVZlbDix9InRhQ8uWkjj4H/zo1B0mcxbJOV654w+KOxY4Jfr22ZLhdW9gw3CMESFgg
         oYolVqoi5klUmBlN9VrzoodLh+i2kumyEfCaLam1pwS8nmwACNz9QzeahS8e2hzwm0ER
         GjxnIKakA6oO0iymakRbrfWQ8772gAyf9HfGUwuwZo6kXrbNHU93lpI5ER7eyEcnhqQU
         cjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIqjqYnUNYC6xaFfZJXPmBMgwbD3vdDEMlsV0H3SJ/M=;
        b=FHhIqaj2cbT3kfJOUKgsfyKsbptJjWs3IswMTp7RoTHVn9xhnHi1zQNRWJz8tJf/iy
         LW53B529MNPoubzjmlw9IM/6h0OO49ITTHVWI2xSfYGvVahCy3WZ7tgftJvA+uQjd4MY
         5GA7N2CIqD/K3wFIl7/iWdA+GJkHti/Hr/XV1FibjdF/oeKy9F+Q8mpQtT0rbJ0anvnP
         WppU+BessbX5KJO2X8AERm2RnpchmVymi3vLoUSvtjljhsmeh0GdbvTH9yu5w0CrDVy+
         dLDD6AM+HoA5Fw4pklm5pLnlJqEO1OLn6MGwhWEUxFZJaGaEEjqCR3AeYm5cmNrqcA6W
         IiUQ==
X-Gm-Message-State: APjAAAXv8lqJhKaN9BA3t7vqUa3HQGAv4EEpH+d/Xycm6pEDjC2bMiWu
        hzfZhPOGca36w9GrF3WquFsvNg==
X-Google-Smtp-Source: APXvYqzQYZXZmnCuYM9hZZtxSNdRMUvX/Yf4k/r6u64zSyCjXNZDZGHB7BnEJM7mRRzhv8OqBBSLqw==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr26535796wrm.262.1579014179025;
        Tue, 14 Jan 2020 07:02:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i10sm20311539wru.16.2020.01.14.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:02:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] gpio: mockup: sort headers alphabetically
Date:   Tue, 14 Jan 2020 16:02:53 +0100
Message-Id: <20200114150253.28716-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200114150253.28716-1-brgl@bgdev.pl>
References: <20200114150253.28716-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

For consistency and easier maintenance: sort the headers alphabetically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 5f81f087103f..7d343bea784a 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -7,18 +7,18 @@
  * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/gpio/driver.h>
+#include <linux/debugfs.h>
 #include <linux/gpio/consumer.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
-#include <linux/debugfs.h>
-#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
 
 #include "gpiolib.h"
 
-- 
2.23.0

