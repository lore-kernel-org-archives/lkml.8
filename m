Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509EDC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D32208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AfUrW2gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgBQTzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:55:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgBQTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so21185049wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ibj9ygukPb9JYTU3mvyTkp2n0e9w9M7BBgYCc3RsiE0=;
        b=AfUrW2gbRewzH09iwIz4mOgbGI6xRBf9V9DBjRYX99k7rC43NLrIJeL6iJOtP29bzB
         XCOotyERZgjri2cgQbwB4/Xo+gvADjygCIZtn+ulJDnkKEj4NAwMK5r1IX0RYRQSwLve
         7kxRgQI6sHIb0PzQ5N8S/BuHDaQ4vkSwMm5wASgU/fuzdt7pY6b52pbEA92AZc/sI+0A
         mcwUlZB5A/LUknqRjE0c/UFaDX4boKsYsSjzLplgC/LBi17NNk5lWG11u5m0oBrTCoe4
         WLUWqiiC1tiNhiMhs3bf0+mvd9Hd6ZQemDM8+sGDb5uKBs9miGLRl065Hzb1zNdfuAIY
         XrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ibj9ygukPb9JYTU3mvyTkp2n0e9w9M7BBgYCc3RsiE0=;
        b=I2i61wF/Olno9BC3JTqTpDFIJ/8ArMTheG+NSZXkO+6/HmeDlLB1VKhKOo4OsRNtaC
         H4CKqibtB6wsHH/SrPXtoqhF+SUw6AH7KYaBTvC/PkJWXZWBEJa+DdFfHpx6eQ/G84aV
         MSjhaHMdF8hxVqO+1xb3GT1/EvJfPKs6BZxTFY7EaprO8WHkw8o/1wdZ8uW4wgXmMbDL
         GNzQM9jyR2xMpx8+hOOiLhr9QRLYMEKGnULs3vS0H3xmMbXqidbyJmz/HnpYqSzUj8lx
         4HVRm9zH6LX2QNZ6RJKuNV3g9qY5iQEjM3IhhEScOOVCRibFYRy7Y+GHZpEVVCPC+4v/
         0Sfw==
X-Gm-Message-State: APjAAAX2OPbhfL40XllWuqENEq1+vT174Nd+AbO/qwszeAsAftu1qYAZ
        hfFgtKjJ0AsUnd/UBfNDi4/v4w==
X-Google-Smtp-Source: APXvYqwlWIo4hBNxAnsgARfbUQqYYsyWocS3dL48hvcsR9M5AfzTmKuPqXmaiVFdJ0j+MGV16uBXqg==
X-Received: by 2002:adf:93c1:: with SMTP id 59mr24275455wrp.399.1581969284441;
        Mon, 17 Feb 2020 11:54:44 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/6] nvmem: add a newline for readability
Date:   Mon, 17 Feb 2020 20:54:33 +0100
Message-Id: <20200217195435.9309-5-brgl@bgdev.pl>
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

Visibly separate the GPIO request from the previous operation in the
code with a newline.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 12e2991cdeef..07af9edea9cf 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -347,6 +347,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		kfree(nvmem);
 		return ERR_PTR(rval);
 	}
+
 	if (config->wp_gpio)
 		nvmem->wp_gpio = config->wp_gpio;
 	else
-- 
2.25.0

