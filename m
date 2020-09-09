Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6953C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A013A218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="q8tRc+rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIIIyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:54:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB5C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:54:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so2015933wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ge+LjYBvfrPR/6z1eGAAmD+KiWvreg+tXjIgUs0btU=;
        b=q8tRc+rU8QeroDtIWNLDBOL7Agmfjh51hQKjf49eFv3+n5GlODrSJopzzbOq9DLd8c
         CC3Q651wyFUH0A4OoOF/DyS8hzBbBOpGv52huurWK8FPRP8YHmvTcp5jA4FsmmZOZy5P
         yb57ng9AXG1SlNsC7WiI8TcRkWW0+E6HmsJvap8jb4C73AnG/bXpTDXs6k/RG88ZieUc
         VRKkf3YuSKSyZjW4mQt1aQXYSF0YhZv3W7N0KR/iHQ56C1bGZ+CkhvfUmMH97g2uNSaR
         TYe3Lg6uz5Yjs96QMJi+/Fu2vDFWYS70UNXtZp4GhHfaB8LF+K9qNqGlBpzho/nnxVUq
         AKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ge+LjYBvfrPR/6z1eGAAmD+KiWvreg+tXjIgUs0btU=;
        b=YxXuuZK/YsmQJnBhcH42Go/qYeT6url30ZWbXEb5JIFGqZVJEeSsqBf9KRUD/1Ntrq
         hOMWnF8pFDjqLheXBu/mfQqQEa+xImW8Mj6pHEE6wvTtLbZ5KEiBOcqLGSHNgYYvusTb
         SmJdVhK1TuUdMhDMfSO/vUhMk0jg1vfN7rw9FKS/DttOLaAR6zVfg436tmvqSmp7lQec
         AyC/9ULzWtnGIHXm4k2ZEfGIhHKNO7KnB/+eshn29Rr9jyK99cIDFvg1MS96PB53OUDs
         VX3qCCH5KeQtAUCr5/f6dCl53RtZH3GUUQeJF4IJHJP9mFM5XXhPeQZc7BjTm4fiy8/N
         8TPA==
X-Gm-Message-State: AOAM531q1TwO2rwbAZcH+BCYy/kV1+mCHnZRh8kTG8TnBJ8LKXWJLEb3
        MIFcfriRFRdUuZ9JcnZuTuoi3Q==
X-Google-Smtp-Source: ABdhPJwzDEHKLjOwS9evMvXAKBTZ65IQav9hZYJOaGRhp8jhiQvjJGKJ4Qp9YoxUuuDLlZGHFpXwzA==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr2860751wru.423.1599641672353;
        Wed, 09 Sep 2020 01:54:32 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/3] gpiolib: generalize GPIO line names property
Date:   Wed,  9 Sep 2020 10:54:23 +0200
Message-Id: <20200909085426.19862-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I initially sent this as part of the gpio-mockup overhaul but since
these patches are indepentent and the work on gpio-mockup may become
more complicated - I'm sending these separately.

The only change is adding additional property helpers to count strings
in array.

v1 -> v2:
- actually remove the previous devprop source file in patch 3
- rename the string counting functions to something more explicit

Bartosz Golaszewski (3):
  device: property: add helpers to count items in string arrays
  gpiolib: generalize devprop_gpiochip_set_names() for device properties
  gpiolib: unexport devprop_gpiochip_set_names()

 drivers/gpio/Makefile          |  1 -
 drivers/gpio/gpiolib-acpi.c    |  3 --
 drivers/gpio/gpiolib-devprop.c | 63 ----------------------------------
 drivers/gpio/gpiolib-of.c      |  5 ---
 drivers/gpio/gpiolib.c         | 55 ++++++++++++++++++++++++++---
 include/linux/gpio/driver.h    |  3 --
 include/linux/property.h       | 13 +++++++
 7 files changed, 64 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/gpio/gpiolib-devprop.c

-- 
2.26.1

