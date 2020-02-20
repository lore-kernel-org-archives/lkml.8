Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10943C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB22224672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j34veHsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgBTKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:01:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgBTKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:01:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so3901503wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvimdiptQxKDwgQGPEXuEUNnfR7qYGCLv3MPPaAy0kA=;
        b=j34veHsgeEP9V3VPUbpkAjRZISXxpHyWJTvxtIALoZSHgpeJ8zA9ickBx3e4t4dR7n
         lb9BM+0n9nfVIgPE5N5XCFydtb8pTJNoyR607zOr5q9mFSh+Dw6ZG4PVsLSAp3e5xYvr
         5QvNpR48O9c7er4InM8KmUlGVRdYoMoeiaF0/zac1Kj+SkkTnUk59I28UjlutQzZOJJC
         PJR5AEGY0zGTo5t91a6d7xV6dPxX6Onx/07lMJP8Xgr1M66WQ3NAS8QK0N5jb2q3ifL2
         YiZugFv/Tw/NDyeKmpgWy4kJsrHgLo7JbEbYqfHvR1tvDS7N6ko4duJL38waMjSQxHIK
         Y/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvimdiptQxKDwgQGPEXuEUNnfR7qYGCLv3MPPaAy0kA=;
        b=GLYQm9NcqLNdX2fyE6sc6pKfFFolLVfUzzZ3ebrInkCpJOwcyGCpXhiw6g9ZrSr2Pf
         7elPVPMEkn2ijlKFZ3MLomLIk0tz2hk48WnsnHjviZXMsEUQjuf85WG5Y3EX4E7/+81R
         TFnqxERUGa67sSER5NU4oVlnZuL87uMR87uv8KOxdixDMlQXRU1xEhiPf3VfT6LSp9f5
         Fhz1qrnTzqtQq6cjZtP3vHsM8kokgUgqBOFAIL7C0UKcTUDlXdKKZkP5BGRY+mT1itnq
         uv9pTxMfOAvmhA8FmX4GU/AIsw57O1nbaZOF56elQWCIrgOIJMkp5TsxafHr42xrDPz5
         mD5A==
X-Gm-Message-State: APjAAAW8t3rJw0LnS5NCupPa/5PA0XgbOgV1fiahA7VsHIkDoVD6p2Gu
        YMqQb1qXihM5bw7+RoETUKjZcA==
X-Google-Smtp-Source: APXvYqwwSVOXXtD8UnqpM0Ic92z5D37Wle2fwxSSRNd8498TLjsxd6QdmGSPTTwewn2G3lwHzjsjSQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr13755154wrn.139.1582192905489;
        Thu, 20 Feb 2020 02:01:45 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id z1sm3663496wmf.42.2020.02.20.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:01:44 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/4] nvmem/gpio: fix resource management
Date:   Thu, 20 Feb 2020 11:01:37 +0100
Message-Id: <20200220100141.5905-1-brgl@bgdev.pl>
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

First we fix a memory leak introduced in this release cycle. Next we extend
the GPIO framework to use reference counting for GPIO descriptors. We then
use it to fix the resource management problem with the write-protect pin.

Finally we add some readability tweaks and a comment clearing up some
confusion about resource management.

While the memory leak with wp-gpios is now in mainline - I'm not sure how
to go about applying the kref patch. This is theoretically a new feature
but it's also the cleanest way of fixing the problem.

v1 -> v2:
- make gpiod_ref() helper return
- reorganize the series for easier merging
- fix another memory leak

v2 -> v3:
- drop incorrect patches
- add a patch adding a comment about resource management
- extend the GPIO kref patch: only increment the reference count if the
  descriptor is associated with a requested line

v3 -> v4:
- fixed the return value in error path in nvmem_register()
- dropped patches already applied to the nvmem tree
- dropped the patch adding the comment about resource management

Bartosz Golaszewski (3):
  nvmem: fix memory leak in error path
  gpiolib: use kref in gpio_desc
  nvmem: increase the reference count of a gpio passed over config

Khouloud Touil (1):
  nvmem: release the write-protect pin

 drivers/gpio/gpiolib.c        | 36 ++++++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  1 +
 drivers/nvmem/core.c          |  8 ++++++--
 include/linux/gpio/consumer.h |  1 +
 4 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.25.0

