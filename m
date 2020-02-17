Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD9C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C0206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Wp87GGdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgBQTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbgBQTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so19261958wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nG7/CsSYEjJAJuvHDKY3X2jyLTeRabTAHO5K7wLe+ss=;
        b=Wp87GGdFrmFk3U/BZkSkkgGt/sjUYCkspxOgsVivKDbqdAWSJuc3rEaXm43AIwdpUh
         93/5GDxj8IWKuwTuMovC/U8+voqHbS69hKMSu8CWLA0CSi6JoeNJ2YECnBskVhYxIcuY
         ZKQHYTBWYwuoGihOTyTMlODqMi6EPmIWLgE4JHAosyiowDpZhg5NH6f/vkb65poh/z9u
         hKL5WylgKaKh07RqdR6+KOAHoEG4fqK7qxMzODPuA8luvcm/YUTmbNdv4/lIs1SHGUB8
         xYuDDXwvN5DxbizuG5kcpyNG3m0ZKrI8wgnhhnhK+rvLpiUfoDOzVYsR4InsqRGAFxNU
         sZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nG7/CsSYEjJAJuvHDKY3X2jyLTeRabTAHO5K7wLe+ss=;
        b=D/UDudcmU07SxnnS2takbq0HzYkNQSnD7e0yj1DnA0IUb/xky7yORgxeYzRufCvSu4
         aMUDtGEEXbj8S3whv17BBAaJBlIB/v0FV3U8LDQTFSOpbAal4PacKiNwYqkF2/w/ZsTU
         l/BlFIv4EQOALi9rqep//sABqYVOlT81rCTHtED3QtK1+AWIcDbhLnLehkl+VBKeCCrf
         cj1GFnYjnHCIleGBHrEwZDWDchMMTKJAuGysA406OiXgmWJcGPgxMKIEueu4remcqeX+
         jVN60O7iNmj1CQVPQyDnTQv2QzCVTYHenhCNw47FHkcDJLxmo62lVs6vLADx/PuQKmAp
         fQCA==
X-Gm-Message-State: APjAAAXojkVlNAt199RDu5REizF10PkxffD9HsUBlrwHTr7deL03BiJT
        XEkGNI6rDTrRJgKmCnsosoTarA==
X-Google-Smtp-Source: APXvYqyDRdQYeKWizyeEAiB+mDqqQRWrstWkrMThxrx53IRWtzydHMBCpPOCbtyEP6VXja+uLFHrtA==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr23606937wrt.408.1581969287003;
        Mon, 17 Feb 2020 11:54:47 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/6] nvmem: increase the reference count of a gpio passed over config
Date:   Mon, 17 Feb 2020 20:54:35 +0100
Message-Id: <20200217195435.9309-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217195435.9309-1-brgl@bgdev.pl>
References: <20200217195435.9309-1-brgl@bgdev.pl>
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
 drivers/nvmem/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 096c7bae9e74..b7b1e3194453 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -349,11 +349,13 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 
-	if (config->wp_gpio)
+	if (config->wp_gpio) {
 		nvmem->wp_gpio = config->wp_gpio;
-	else
+		gpiod_ref(config->wp_gpio);
+	} else {
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
+	}
 	if (IS_ERR(nvmem->wp_gpio))
 		goto err_ida_remove;
 
-- 
2.25.0

