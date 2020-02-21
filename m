Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A368C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51C1206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Y3lDq82o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgBUPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:48:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgBUPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:48:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so5456294wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKMOxyJCt3REeokpewoFxr3MprF3IwK5sef8rIuxxMQ=;
        b=Y3lDq82otxFk1dqt1cCgRQ641wPz1qeZ6rtNOzeXPPi1P+MMOApvLh2jT/xp5t1Toj
         LtwRWOBZ91kldJcLeIqjFwAJD4oiMfh/L2qR5mR0Qk3yde0F7krR6PGl+9NYmzmfsW1M
         r1YgcVbob6eXGRs4jzn89WTOl0ZUoj4IsWKFFc+/S43BuPdn+QXPHaezhxFFCzj74GEB
         f+WcuH1RQoP959hR99K+WKUxgUexYFrZQDm2OwbqFRJEQQUuu7oh2KrMXKgIDpWea57N
         54qE/YozafBvJxOLrvPYAqwhOL+bSDozuoo1DcX10Au46MlKlRDp9+dGQZ+6ngQLcRiK
         ZGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKMOxyJCt3REeokpewoFxr3MprF3IwK5sef8rIuxxMQ=;
        b=GwHmWJHZL0Hczh975QNAM4teLkI+w3FduixezxwyX/uHlx0bAdk3BOWv0o4YtcrvUx
         sVRYA84Pk14agd9gh6mdh1OwGR0cTUpw9NxBApQlOtozAlma+lyVqXb2wg3QJsChKFQD
         HOGnM5aDyoPeqnm7gd8303+2EvWg989VQvlhLWdHhkZBsQdY6iNgPXjqFNu16e5f4AYo
         axBRGDx8X5nu9TCcI6+Q4jxCCkS+380lAVZsSg732h1XF2yzU4T8No18mDrReyQK0HWB
         zhFkAH+yU+TxM2HFOGZxfSRaYH2h7lT0YJWKblKqqfWnF5icbUo/YMstZ6hCQPZK7oIE
         yylw==
X-Gm-Message-State: APjAAAVmBKh0jWoxPydTCZJkK9dgp3WrMsInCLECNQm1hLoNx13KopLv
        qgLmBeEDqwXSd+iQ8kp8w5bLeA==
X-Google-Smtp-Source: APXvYqygWqoO4iocVUnQ7IG/n/AV4BRCEYimoh/V9meXwbtdzSH072KLZAihSncKmBgLc0oh+YrICg==
X-Received: by 2002:a1c:a1c3:: with SMTP id k186mr4502548wme.179.1582300132694;
        Fri, 21 Feb 2020 07:48:52 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h10sm4267947wml.18.2020.02.21.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:48:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 4/5] nvmem: increase the reference count of a gpio passed over config
Date:   Fri, 21 Feb 2020 16:48:36 +0100
Message-Id: <20200221154837.18845-5-brgl@bgdev.pl>
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

We can obtain the write-protect GPIO in nvmem_register() by requesting
it ourselves or by storing the gpio_desc passed in nvmem_config. In the
latter case we need to increase the reference count so that it gets
freed correctly.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2758d90d63b7..4a4ef2049022 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -349,7 +349,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	if (config->wp_gpio)
-		nvmem->wp_gpio = config->wp_gpio;
+		nvmem->wp_gpio = gpiod_ref(config->wp_gpio);
 	else
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-- 
2.25.0

