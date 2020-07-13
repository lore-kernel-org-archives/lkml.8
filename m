Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA78C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135D720771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rSp1ckUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgGMO7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgGMO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:59:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so16909233wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiVSo3xlj6ss4Z1I13IdfwQU+nfjMMT6+mU8Bg5YKmM=;
        b=rSp1ckUHPmHljClMQoIDDSw1ZCB7+ygalxtu5lHGTlN5T3q2RVoH60LPL6a4oxo/ty
         z0HQV95Z9mU86Vd/A/IUFtH/uJjLYmNuqYNKD2NYrejOVpNvFarZV+J0Ec+pnQT/Abgb
         HpclKpTNjEG/gl3XYssuh1rDjk5AjdDUrI8OuRabw5IccTvCHZGuWSTAi6tGsC2/FQVF
         nEBBDzZbPQXKqoIyz6Ltu3poOOlhxF3n8CguwS4Q8Xc0MSO0dHDE9sNxR/Y3ADBUUksn
         pu6EXZbVF4tml637IPR+2tIrGMvndreNuw6dnTpm28gZLa9qxm/+P+SfiwGENPndp3P4
         AiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiVSo3xlj6ss4Z1I13IdfwQU+nfjMMT6+mU8Bg5YKmM=;
        b=NhhLhLkFlWSn+vEPjjgBSlBBfcnL/oo4H7N6Wq6WpVeFF9/8v1bgUn6zn3gQQAjJ7Y
         WUNeFMUDXGN4EYqcBeKzwbpqr1fsidLxgrZdvjkmyLydkW/hVQ01MDdZUHU1jcJd1IcT
         T5geAMiKcuIPn6N85lcQMzCgvTM8T5iEpyDUZ5ek+/wfSSiu6JtpYw52VWYrcamYEKAP
         OKGwzZ48yj3paL6x0cOUsdY1ZNtebx76MnL/nyBZXvrS8t99tgDvswaA7+U382AHNeHc
         nYR0HUooNSXvBOmZS8tBsSI6bIL8ufuymG03lEQUIwQh6WozVdkzCuUsdGqGq4YNrEx1
         Uq+w==
X-Gm-Message-State: AOAM533YfvquHhC2jKVngGY8b2/d9ZdQzo1zeH6En+BvWG3NoTTHdiTi
        Ml996T6iosQrQvkK35NymcEQOQ==
X-Google-Smtp-Source: ABdhPJzJvIhOZM1tW3JbhqV6XyxG2YJWfklQ1nvdDw0QVKBI2giA+0EpuZ7a9S9IT9ipoa2QgtDwsQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr82938978wrq.189.1594652385764;
        Mon, 13 Jul 2020 07:59:45 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u20sm21991145wmm.15.2020.07.13.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:59:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/3] devres: provide and use devm_krealloc()
Date:   Mon, 13 Jul 2020 16:59:31 +0200
Message-Id: <20200713145934.18243-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds the first users with hope that this
helper will be adopted by other drivers currently using non-managed
krealloc().

Some additional changes to the code modified by main patches are included.

v1 -> v2:
- remove leftover call to hwmon_device_unregister() from pmbus_core.c
- add a patch extending devm_kmalloc() to handle zero size case
- use WARN_ON() instead of WARN_ONCE() in devm_krealloc() when passed
  a pointer to non-managed memory
- correctly handle the case when devm_krealloc() is passed a pointer to
  memory in .rodata (potentially returned by devm_kstrdup_const())
- correctly handle ZERO_SIZE_PTR passed as the ptr argument in devm_krealloc()

v2 -> v3:
- drop already applied patches
- collect Acks
- add an additional user in iio

v3 -> v4:
- add the kerneldoc for devm_krealloc()
- WARN() outside of spinlock
- rename local variable

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 67 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 +++-----
 drivers/iio/adc/xilinx-xadc-core.c            | 16 ++---
 include/linux/device.h                        |  2 +
 5 files changed, 87 insertions(+), 27 deletions(-)

-- 
2.26.1

