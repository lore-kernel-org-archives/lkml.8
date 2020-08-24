Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E19AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494412067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ua8GVG/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHXRjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgHXRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:39:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E93C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so8996335wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHqg/CRd3ImS5C9/z0529f/sgF1Y8XoJ8ekTa/Kbeao=;
        b=ua8GVG/wkZhFJ0nIz55IgC5mKz64cCXHEZh8OOq+bgoz7H1Jx6HwMl4N1S5vVT5wnd
         mno1udnNO1eRtrBmID3NCP+QZTMJBaA9kail1BX9zI42pqVXxqgOeUeLmdrUc61fF8UZ
         ZXUjrZ+W9pm2GwriQ3Gwfdbr3wYQKqGAsgh7CLuJJqCswrR0Kl3ZctHiDD9vGCLUZcA1
         Ctai4tRtrkCU5qZ+6GHuWGppBdzhu1cSWG4XtZv7xUghqrOajjhVCWRlBXmLGXNTIAgm
         Knw1sB06QFJU8qfzkuhkFoid/ptQrThXWttttA7kvk2NviUj9k6mBc01BxwBImLvlKwy
         bLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHqg/CRd3ImS5C9/z0529f/sgF1Y8XoJ8ekTa/Kbeao=;
        b=AQ+/99UuUDKpM7ASOw91tB8tAOIskWd3Lbt9tOGsWGjnluT/CbxxQGq381IUSLUcc8
         BB3nsO3klno4K84tRauNSXlOpE9VLdEBDNDIA518sz8rBSzjHWFRX4fEcqi9kyKYGj7X
         HEcOaFq55uoeXxzqMvmt488pkCGumtTVm6A9098ruZuCL22qAg4sDPq28V0nL9/sA9fZ
         +9lG/xNnYWCgOZzjGOt/etUdobqPbh64cOl1go1XXCHpXDaYg6dN6mQh3eR3+mzkcQxa
         b/DOB1rT/2hmfTlT42n27C66smMYSjG9Y6qK7Dqnz2IdFBZb9dY506Tbui4tLYf8uA8i
         4dmg==
X-Gm-Message-State: AOAM531PPn0cJ1FfwRm7Jlk7jXaMwQ9GlwrKv5x2VKncawkw+5HUwE11
        Gi89FnTMpRFWLcN8Zo1ipPsQaA==
X-Google-Smtp-Source: ABdhPJyzldmOEXlL6891aI7qL7sR+2Tl5GOk5HnmHxIL3oR6HsnWwls74S99vrVXQdme8MY2daqqOw==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr344446wmb.67.1598290743340;
        Mon, 24 Aug 2020 10:39:03 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:02 -0700 (PDT)
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
Subject: [PATCH v9 0/3] devres: provide and use devm_krealloc()
Date:   Mon, 24 Aug 2020 19:38:56 +0200
Message-Id: <20200824173859.4910-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds two first users with hope that this
helper will be adopted by other drivers currently using non-managed
krealloc().

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

v4 -> v5:
- tweak the kerneldoc

v5 -> v6:
- tweak the devres_lock handling in devm_krealloc()

v6 -> v7:
- rework devm_krealloc() to avoid calling krealloc() with spinlock taken

v7 -> v8:
- drop unnecessary explicit pointer casting in to_devres()
- check the return value of ksize() to make sure the pointer actually
  points to a dynamically allocated chunk
- add more comments to explain the locking strategy and resource handling

v8 -> v9:
- use container_of() and offsetoff() instead of manual offset calculations
- use kfree() instead of devres_free() in error path as the latter expects
  the pointer to devres data, not devres node

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/base/devres.c                         | 105 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              |  28 ++---
 drivers/iio/adc/xilinx-xadc-core.c            |  16 +--
 include/linux/device.h                        |   2 +
 5 files changed, 125 insertions(+), 27 deletions(-)

-- 
2.26.1

