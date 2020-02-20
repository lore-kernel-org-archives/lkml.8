Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F1C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5CE24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wzgL+FZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBTKBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:01:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50310 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgBTKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:01:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so1316224wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tb5z2UeOLZl/UqO+U9twmLjCGpyhePDzuQ8mmkofF+4=;
        b=wzgL+FZrc/X+hzZaF7lsn0YjEKYkeepxbRUqFbY9Zuc606QNHiesAFPsYD9Xxt+yZl
         SPBY4XkW/FfQcIvxmma6uJss/8oIaVkzApUSRkJm/JAb5s+KPtsn59hl+QQPRdIWnmF4
         U5BO+JM99SUUZy2CZG5B8NH04hBL1LIFBNejeo11Z831wsS7Kvxi/TG65UXiPwoH13wO
         fJyIIbSPRb3MtgwU8+b3vTSaxrZQQwxK5P8Vw75xJ6LosdFx/TbcjBe2eVnh+VRXt30P
         xFFo93zGWPSmBBoSq/v358GAMQo1S7mdUwpBDNQVjasa5Jlur6rEA6ncf9gB0UIibDPe
         URhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tb5z2UeOLZl/UqO+U9twmLjCGpyhePDzuQ8mmkofF+4=;
        b=CtCi+794cUZ2tSL7bCBlVN+lC/7A3RZnr0IjUe7JA60E7TOsdfuciJhhz5kFUmXFkR
         DQ0gZj6Zdzg4gCXnliqLK/N4DbFvfYZSPyrmohiFZS0aLT6YmbYDlqUt8Sz6fB7KKiGR
         VTA9KOxNYGIHVNKoFu6svKHp6hsRHMlbLdX97sesVwWeCSuTjdngNyujA5YpPfYVRlNe
         z6616czJWycJvKTNbHxJizOUgQrdY7pNG/y4h1Y6v2pXnT4T7lVG0GVbkdFNtIpEGH0E
         rC4sMQuvmOMj3kSgNu3y4kQ/Oeu0WUl9gh7MiJqSknoIIr4Od5tyEw5z53FNizz7//Yy
         sYaA==
X-Gm-Message-State: APjAAAV46KM96zKS6yKQB8BGOKvqcf2r/rZFGQKSI18KG2zh5zFosFSP
        2J8NMeKHFg+X7bhKQkhi1OZXbA==
X-Google-Smtp-Source: APXvYqw0fTH4sWjn5ENuK3wMDJ5nqpMfOAHhHpEdjOffi/ADk7auSN+FgFBOXvarTSOCZvKpHY3whw==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr3399912wmf.113.1582192906765;
        Thu, 20 Feb 2020 02:01:46 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id z1sm3663496wmf.42.2020.02.20.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:01:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/4] nvmem: fix memory leak in error path
Date:   Thu, 20 Feb 2020 11:01:38 +0100
Message-Id: <20200220100141.5905-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220100141.5905-1-brgl@bgdev.pl>
References: <20200220100141.5905-1-brgl@bgdev.pl>
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
 drivers/nvmem/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 503da67dde06..948c7ebce340 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,8 +353,11 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	else
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(nvmem->wp_gpio))
+	if (IS_ERR(nvmem->wp_gpio)) {
+		ida_simple_remove(&nvmem_ida, nvmem->id);
+		kfree(nvmem);
 		return ERR_CAST(nvmem->wp_gpio);
+	}
 
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
-- 
2.25.0

