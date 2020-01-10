Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B6C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FE82077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0fcbQT53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgAJIYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:24:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55981 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgAJIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:24:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so980123wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5r95wsWSJ0+Wj2lVXa2ctKKmZohPNzWuPlbe6SCwck8=;
        b=0fcbQT53VcbrdX8BNoj8Eety7F2Sa7j9T6cRJ+rDqlC4mCKtH38DRfSYlCdmI/rAoo
         zqvkECEklnoCVZ+fHOY/GOD9TEI0HXtGZqQj7h1AYc/SPWX1bRIg4PwZbEGws10HGvBn
         8nigUmb1XIWj9PMrYjjL+iIbklhQWXWY+3pvte+vO8S0eLx4FsH8dKI/m/aM/dOAtssc
         pimkN2rtnpy27iUAewntS0XZStSLjw/Xjr92F0gcKpXM3EtdHXNXanvr4LRsYlvY+SLz
         kyxO5xkYHA4qX7nMuVZio5XKLjPV+iMOQZwdeerjtRiKjfbXIlcAf9PlT+1fWh8QI6Cw
         jy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5r95wsWSJ0+Wj2lVXa2ctKKmZohPNzWuPlbe6SCwck8=;
        b=l7G1NFjYrZLMjF/JXTiTNp0dtueaoQUQTT46teg3q3IJfo2tEtNliiF8RKDKYfv9qQ
         kWgtQQAQudOhnXs5iE5EJhRAvPkqWig43E/zaq/GEJQQ00WwJlcbATaktPApYTeP1zMG
         Wam+Ynaf5tBohhEyFL1ebeXcTKtaCSiD2Xdmbs3Shz2P4B/8N6id6vVo9TbnVanrJdX1
         DditSxWjnEwuAy+OH3XHhLnJfQDwFXLUrZYpWScFUR0lUH0RLXi7MCexaOjUlWPMPmXL
         pJIstCSA0kIbHeV4wmQtLid+MOWratEIt0jgCrvj4vilRNyfA3tOU4WFhIJlxybrd8h1
         5daA==
X-Gm-Message-State: APjAAAWYa2ha00SM3NeBJD0eiwWXEY++irFyWXBJROzTwiY7uYIBKHCS
        32VVEd+6IQ9KZXBLaQWQvgbYtw==
X-Google-Smtp-Source: APXvYqxEPVuwV382kwEpXH8hv/UpL9dPzZM4qs1s2przY5cPhDpcysJwlwIIw6LHPdnEpv1f7CRfkQ==
X-Received: by 2002:a1c:6406:: with SMTP id y6mr2724113wmb.144.1578644683946;
        Fri, 10 Jan 2020 00:24:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x7sm1313416wrq.41.2020.01.10.00.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 00:24:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH -next] nvmem: fix a 'makes pointer from integer without a cast' build warning
Date:   Fri, 10 Jan 2020 09:24:41 +0100
Message-Id: <20200110082441.8300-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

nvmem_register() returns a pointer, not a long int. Use ERR_CAST() to
cast the struct gpio_desc pointer to struct nvmem_device.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3e1c94c4eee8..408ce702347e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -351,7 +351,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(nvmem->wp_gpio))
-		return PTR_ERR(nvmem->wp_gpio);
+		return ERR_CAST(nvmem->wp_gpio);
 
 
 	kref_init(&nvmem->refcnt);
-- 
2.23.0

