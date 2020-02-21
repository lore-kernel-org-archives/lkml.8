Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D07C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE81206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bc468FVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgBUPsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:48:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54243 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgBUPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:48:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so2272799wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeI4uUAherKB7oCfyMKmC8mC9Xr3shtEsETnkdo6NKY=;
        b=bc468FVjR0O2HzM4iW+Zet93uxru6fygwMokZnjsN4Z3+QauJeJgq3arXlVh56HWeZ
         A5uIl36pE23TiUBNM7b9+bDJ85xe4zJtG+NoFQvuOXFPFp6oigTsxBosuCYShHjrDvzg
         BcrOE7FV91S71wNKkhx6+2Rt2tD13s1SHZdHRfrdfNJALCTcoWsNhaK4BKGx95WoW65T
         v82GGJ2l5ITDblA9SU5pJylgyjR0f9nsQYgtBDXc+oAtYKtOxKXTn8Lwi+b3hIDzXrT0
         cS0CcEMHwqM3MJHCig0urM4lO3tc1/Oxa+RTBMuDvDS6of7qDUssIFruEBY2l4BzWH94
         azxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeI4uUAherKB7oCfyMKmC8mC9Xr3shtEsETnkdo6NKY=;
        b=Eo+da3NWO8Dkj5cthOaFdu1UbSDvxFGyaylPCMOsmJihemDzPEpNU6wLF8sDukAq1u
         eS6t0wlPuZYMKM3ssCrVQ7M/1FAyNW2UqrrCIS/OIX8LwEq0vHFI+6CFo8dWbLHuSp93
         96iUGVeT0f/6Cam0NYK4rUiUdS3fTlkQ+Xth3wJ+L0zzQt0KM8YSs1opC/YF7DOJhKI+
         zKjvvrbXnySHPPtdZQVYAzO89qGLN+sEE/wlqWXFnOcqjBkTzL6F6j2kaCPSxuXbuEsy
         kUbmNHWQ1xFNX/RuwwKf8vYuMfyOIYLjnUeJteKCNwQ8oVmuis0twq2E5kteQ/bXVx2J
         SOAQ==
X-Gm-Message-State: APjAAAV38usQFCJE9GqUNalnRV3zv27mWaCd+2ERthDrgFgD/z8JGJxq
        jjQOq3wAj7NTwRV9WPIbaV5dlAQkt04=
X-Google-Smtp-Source: APXvYqxsLHrfDYzPsFWvn6is40yGLcNWGK+wdV+4cbAuhPNyi72AV/LyUrw6n6gSPS65K5YTI6GjRA==
X-Received: by 2002:a1c:a1c3:: with SMTP id k186mr4502020wme.179.1582300124029;
        Fri, 21 Feb 2020 07:48:44 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h10sm4267947wml.18.2020.02.21.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:48:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/5] nvmem/gpio: fix resource management
Date:   Fri, 21 Feb 2020 16:48:32 +0100
Message-Id: <20200221154837.18845-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Srinivas,

sorry for the lack of proper QA last time. This time the code is tested
on real HW (Beagle Bone Black with an ACME cape) including the error
path.

--

This series addresses a couple problems with memory management in nvmem
core.

First we fix a memory leak introduced in this release cycle. Next we extend
the GPIO framework to use reference counting for GPIO descriptors. We then
use it to fix the resource management problem with the write-protect pin.

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

v4 -> v5:
- don't reference nvmem once it's freed
- add GPIO descriptor validation in gpiod_ref()

Bartosz Golaszewski (4):
  nvmem: fix memory leak in error path
  gpiolib: provide VALIDATE_DESC_PTR() macro
  gpiolib: use kref in gpio_desc
  nvmem: increase the reference count of a gpio passed over config

Khouloud Touil (1):
  nvmem: release the write-protect pin

 drivers/gpio/gpiolib.c        | 46 ++++++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  1 +
 drivers/nvmem/core.c          | 11 ++++++---
 include/linux/gpio/consumer.h |  1 +
 4 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.25.0

