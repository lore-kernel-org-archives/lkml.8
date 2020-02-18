Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FE8C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBD0206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fsu1Sr51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRJm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:42:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36800 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgBRJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:42:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so23099169wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waac/W6URRBuGIR7jL67/WOXUw483M/6QXKK8+dDCbU=;
        b=Fsu1Sr51tqbL1dgNFsyf3MMny9okBD14oykYFEJfQFdXTZQsO1IFrmkF75+LNto+Ya
         sdpS+Ohl9w6zxtlaL+hQIbbIEqjLu2kAXe2kPJ6JtbtdhUKEFfeHNKWHR5VeLC4k0LiM
         g7OVG//ibmuyjpiFwJ3MRgQ3hcNysQjLPqKENz1h9fzPhqvHrOJqlaFj1yWMYriPzn6A
         WSVPZcLW1eLqZSXyP6M288Gpi9/QM1kvXnnyeVlUxqyQlv0Eni2c+NWAPl/e3caO+dg4
         OHkep5YDgOAHHaqBQ+lOF0U8NvqEy9jaOXIqoo/1ZfEMqyuGILvFP1/OUDqDeQlL0ZbA
         pkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waac/W6URRBuGIR7jL67/WOXUw483M/6QXKK8+dDCbU=;
        b=tz1pG9Jyft9G/ELhYIBorr+KVvLqXjAF07NAGDnoW0R9ke6AVs472NNKJ8n+1nmieU
         ARP42S/tQQ3NYqXAFpYh8obJi7tW2O1rUzxg4xAlITdUeEVljFpkVYlnk7SG9V3kgxoA
         UXJjBDMtstZgh8OLWPMd3DJniR1ULRkZcBQIxFNO5QwNMR9b67HQ1r7FjNFa5tWRe8Hu
         cSNlP6Wa0TYfC7dxbugFPFe2s+cQoUNW3MMbLYBD45rWe8+SNxlHmvLs3BxWUY5SWyfK
         fgUmFxYpx1/nb4QrtVom+OtqBMMXI2PWy6SqUJwPfnV6kStg/YS5Db2xGWSAmPEmccgL
         buOg==
X-Gm-Message-State: APjAAAXIk4YriLG748ozVh5A/+SoFn1RNyPfUg09foseBJnDt82h3kEn
        er6zEZB17zPfGQITFH87CXfCgQ==
X-Google-Smtp-Source: APXvYqyDnPY3FSpPFblahKI761byO1rRgj4JUGCjnBEWIdUSc09GCXNAoj/Q8jDDVxhS3lCFGMlPvg==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr27385763wrf.174.1582018976653;
        Tue, 18 Feb 2020 01:42:56 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id s23sm5351095wra.15.2020.02.18.01.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:42:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/7] nvmem/gpio: fix resource management
Date:   Tue, 18 Feb 2020 10:42:27 +0100
Message-Id: <20200218094234.23896-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series addresses a couple problems with memory management in nvmem
core.

First we fix two earlier memory leaks - this is obvious stable material.
Next we extend the GPIO framework to use reference counting for GPIO
descriptors. We then use it to fix the resource management problem with
the write-protect pin.

Finally we add some readability tweaks.

While the memory leak with wp-gpios is now in mainline - I'm not sure how
to go about applying the kref patch. This is theoretically a new feature
but it's also the cleanest way of fixing the problem.

v1 -> v2:
- make gpiod_ref() helper return 
- reorganize the series for easier merging
- fix another memory leak

Bartosz Golaszewski (6):
  nvmem: fix memory leak in error path
  nvmem: fix another memory leak in error path
  gpiolib: use kref in gpio_desc
  nvmem: increase the reference count of a gpio passed over config
  nvmem: remove a stray newline in nvmem_register()
  nvmem: add a newline for readability

Khouloud Touil (1):
  nvmem: release the write-protect pin

 drivers/gpio/gpiolib.c        | 30 +++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  1 +
 drivers/nvmem/core.c          | 18 +++++++++++-------
 include/linux/gpio/consumer.h |  1 +
 4 files changed, 40 insertions(+), 10 deletions(-)

-- 
2.25.0

