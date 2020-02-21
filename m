Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54130C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A8206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Qmd6KmmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgBUPsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:48:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39109 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgBUPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:48:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so2580238wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4BvL1ZlG+iRqlGHWziElUGj9TJcDWR1qYvsM7P0dRI=;
        b=Qmd6KmmROqKDsZsi7NX//sxRru6kte9rqCs1JCZoZPDg6LrdUwUHtPHDLMoRWV59Nn
         rWTaSliJhyzXfFw92h1vXLGr9A90J6tWZZrJGcIfFg7jZkfyyXJmp+ZgH6qPP4rR/7nA
         Ju7+8oJj8vfVqTyizIZLsk9Qq0DF+DZYOeQxB8TDqWpn1QKmXOLJXfO16MnriTDy+URC
         GqIxWKZeQ2Z2pmNeKOAx4ubkgi1BDEe/7I1KJXbJBeDqo7GXjHoFn6A3QxaaptD8jQp2
         n4A9UH0a/wjfilA88zTGpgAoeH/Agjgcpi7QK7BajjMUF7sqsKw43jjW1j+VMAikR8bF
         8fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4BvL1ZlG+iRqlGHWziElUGj9TJcDWR1qYvsM7P0dRI=;
        b=tkdnbA0EwdjsLNdVkCY0uE3ee85PJ/L2A6elKIEqoe6jo5WTkqC2BmaquTdafZmHpB
         A38jcDmoVo+Ibw9uySU7PtU5EHrIgpL8Gu/8HtLfHffDlyBnnevjNVPBPuBAARFJGXB7
         yZsPLC1ED46VHIYq5DjXb4Y7gd/pPAVf9Knb1qkQxvDHhPUgLgOf+YN2lK+kMWIglPwN
         IGPMt1puRZO+2gyVycZfZYQHUcl9spVd7pZj/i7XI9moNrNxAP+xsvJXfHYszF+3EUZd
         k36U/I8gifYPeRV++azSB0tNkdkANPrWPVblEGfMpnhxxzVkbBzdESGHsF66c1OF0+3N
         HT3g==
X-Gm-Message-State: APjAAAVNhT/wjyvd/QyogVtmKpelggV2qJtNlANiRfjsLTwNiRkANyxE
        IZkf/y7ZVqhFX0CFEOzHVOXJ/A==
X-Google-Smtp-Source: APXvYqzIbzesr3Ocn/5qxdLjpW6lcX41+ayfLH8l4XpNrxYb95wmn2ZXDGkHP8Jf0SReVu5RGEHR/g==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr48557796wrp.167.1582300127356;
        Fri, 21 Feb 2020 07:48:47 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h10sm4267947wml.18.2020.02.21.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:48:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/5] nvmem: fix memory leak in error path
Date:   Fri, 21 Feb 2020 16:48:33 +0100
Message-Id: <20200221154837.18845-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221154837.18845-1-brgl@bgdev.pl>
References: <20200221154837.18845-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to free the ida mapping and nvmem struct if the write-protect
GPIO lookup fails.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 503da67dde06..2758d90d63b7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,8 +353,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	else
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(nvmem->wp_gpio))
-		return ERR_CAST(nvmem->wp_gpio);
+	if (IS_ERR(nvmem->wp_gpio)) {
+		ida_simple_remove(&nvmem_ida, nvmem->id);
+		rval = PTR_ERR(nvmem->wp_gpio);
+		kfree(nvmem);
+		return ERR_PTR(rval);
+	}
 
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
-- 
2.25.0

