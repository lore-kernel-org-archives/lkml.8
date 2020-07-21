Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70B02068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooNSH1+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgGUOud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:50:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95745C061794;
        Tue, 21 Jul 2020 07:50:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so3174592wmo.1;
        Tue, 21 Jul 2020 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WAz9CrA6VM2lt/YzS90QYjAMDygH81Yy4CpTUtHqIs=;
        b=ooNSH1+EyoBSEcOjbxy/eRIZpb/OqMwK63tsWN/QEYc/3FQleHpzIO5eOU9yokqpGg
         ywN/isb5ltYl/cyiI7iIpvBZYveDTwwnZwXx9hb3wcI9BbucALloYpkD+bUziEZBPOET
         9V246Y2oY7mkE8tc+Kjwl7Tck/KoYoPPCR2OGm3pl9asUBFTsPXR2S9GM8FDg8eDeoos
         uJPEEdfM75vRIbWvgtP8V1+4hDdRNfFDgoR1mv8W7LZ+wsh5jf5oiMCfU6AnY9ndvZCW
         PsZOxXgk1rLTGb4unA/AsA/qgvB+EO+JrsmfDtkxoXM3wLgzayygbhWOgaasXjz4+PMj
         XZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WAz9CrA6VM2lt/YzS90QYjAMDygH81Yy4CpTUtHqIs=;
        b=smFUUoR2jXT6ASjkYyJR7I3rMpwjU+Gb8k1X1T+E43qvqsJB9Q0cnElTmYPJAfJcL3
         H1fs4sXG8l5UwXz5IR4RwuY8hGSwBg1dLUWrKPBC1eWICHHQFG35Vh6HTQ9pohNhVLAm
         658Zt5GVffBK7nulHoAtDE/NdaQ8ZvUMC7B/tUJhphwnDicV5Hw2jMgsUp/UIdP8wKYc
         XUU+DCGYK/fxtgAB/yY8RvjTpIepOU1srrbldBb/VCH0vnz/oM4TMxTNDp0s4V9etpQl
         ZL6CStJykutMtQeODTRNs6J5v2VRfZfy2w4XCmWEJEGCKNZYZEOV8aSMYAt40TELbB4u
         QFOA==
X-Gm-Message-State: AOAM531zK+W6RnpzanmH12+vaAbuNIAlzDfgocS6IjJALfQAwnDOajQ2
        KnR1eLpdZ9e/+ESYV18NPvbsNoQs7Sk=
X-Google-Smtp-Source: ABdhPJxLC5UhD5tjoVuHarN2kK0BlHA9iyzF1bCRgdZ2BnEDvXj4xnu/nZ0KqOS7vdDU7arZxtLoHg==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr4328641wmb.60.1595343029386;
        Tue, 21 Jul 2020 07:50:29 -0700 (PDT)
Received: from localhost ([156.204.74.63])
        by smtp.gmail.com with ESMTPSA id 12sm3574031wmg.6.2020.07.21.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:50:29 -0700 (PDT)
From:   Abanoub Sameh <abanoubsameh8@gmail.com>
X-Google-Original-From: Abanoub Sameh <abanoubsameh@protonmail.com>
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abanoub Sameh <abanoubsameh@protonmail.com>
Subject: [PATCH 2/2] gpio: gpio-ml-ioh.c: fixed a coding style issue
Date:   Tue, 21 Jul 2020 16:50:12 +0200
Message-Id: <20200721145012.767722-2-abanoubsameh@protonmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20200721145012.767722-1-abanoubsameh@protonmail.com>
References: <20200721145012.767722-1-abanoubsameh@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a line after a declaration to fix a coding style issue.

Signed-off-by: Abanoub Sameh <abanoubsameh@protonmail.com>
---
 drivers/gpio/gpio-ml-ioh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index f1b754b60413..7007621a5b55 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -212,6 +212,7 @@ static void ioh_gpio_restore_reg_conf(struct ioh_gpio *chip)
 static int ioh_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct ioh_gpio *chip = gpiochip_get_data(gpio);
+
 	return chip->irq_base + offset;
 }
 
-- 
2.28.0.rc0

