Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25357C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1AC24658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KpoSKje5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgBSJWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:22:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:22:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so27262384wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMlKs3gdMW7rebTvPaScGcRlGsgZL18WOqlk6TNbQb8=;
        b=KpoSKje5FfiNu98vsu3r/t8Upv3HIMO9i1nVhxa+Sd3Mu5v1TJnar7lyRIaUbETrL/
         eLtxANb7hwJ8zsqD+zcaBbbeoT4oc+Q0tnVw5lUlqYyXAGqjV9dK7lHnY9cSsEPh5qq9
         P2b4iq42CJbo6EaHh8sQ2CCTnzGZOhTEgYWl+m1Su5rIx9Qn9nTZuZj8zM/ZzRax1Fr7
         nHCR+Wx3lqATFeNDooSoHXKemaFHfWVhNV7KR9SSzFN3KclbQeHBrDProJwIUKYlxR/V
         iWbtIESBuV02150x/zsEYTMk0ELD5diwtIv56IDtgLWBnA7r10qPkmTyj2/up9OwaJNJ
         0UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMlKs3gdMW7rebTvPaScGcRlGsgZL18WOqlk6TNbQb8=;
        b=WxdbUYx3OqK7gqdYKkwaFAAz4C8phf0t/otGVx+YtBh+c8bvPGm+ZIjJ0u56b1FPK/
         7MAtVngCiA37bcjdvFcwPEBhAXFIIBpOEM74AHl5aaBwmjvGs+bYOVcRBV0nV+rpEX7X
         PKf0C1L5s88p1qFDREApe3jhhWmrCjfkxvF+9P5zrl/fPOCCPj0nBRvtEGZEvw2aWxPb
         8n/DZmZB75F5vyWQ3kvcpHBaMPuz1JGrMX3ZkQL1dMojejZCdH1ynmM3WJbJayURWS2I
         jEIfUCkPp+8YURCHtt+HOtdOtPAy2xonhDSdgHUw5AmJ9q1s0mi2kVqIDsqDiegZlw14
         P3YQ==
X-Gm-Message-State: APjAAAXLI8niNCeQiL8smNlgs6crnNNZh97wVdM3HsXz9EUITZKghPIy
        P4t6DR+JBNsOGJrWqXPcR03wxQ==
X-Google-Smtp-Source: APXvYqz3fDhxnnxXVRK/PmTQxrfOqU0TOGJCeO//rRk9wrbyO4IeR/cNhnPEUW9TjFTxzWyITxyIdA==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr36565929wrx.210.1582104144696;
        Wed, 19 Feb 2020 01:22:24 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id s65sm2172296wmf.48.2020.02.19.01.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 01:22:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 3/7] nvmem: increase the reference count of a gpio passed over config
Date:   Wed, 19 Feb 2020 10:22:14 +0100
Message-Id: <20200219092218.18143-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219092218.18143-1-brgl@bgdev.pl>
References: <20200219092218.18143-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can obtain the write-protect GPIO in nvmem_register() by requesting
it ourselves or by storing the gpio_desc passed in nvmem_config. In the
latter case we need to increase the reference count so that it gets
freed correctly.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 89974e40d250..4e6daaa2b0f6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -348,7 +348,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 	if (config->wp_gpio)
-		nvmem->wp_gpio = config->wp_gpio;
+		nvmem->wp_gpio = gpiod_ref(config->wp_gpio);
 	else
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-- 
2.25.0

