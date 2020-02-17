Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B10C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FCD206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QU3yhGzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgBQTyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgBQTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so21175312wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWr9d1ajXFj1+3i5dkAdmDb2mHo0visFJ3r0UjQmCPA=;
        b=QU3yhGzt1nI2tSShwBcrtbO8PsjxVzQf42Ad56dDCNe/2PndW4x+YwT43UAD+tMgSO
         x/Faym00HrVbq+9y63LY2lOz9PNpw0Zu+oMhLBFrwIXpCUIvLBuuuStlmcZoBVfS5osl
         GpWXToShF1Ny3an8qWLn57OPAX90d4JKpJpdx9XlNU2QCMXSed8qmKC5KzhwWAHtKHjC
         N87eK20TEDcRLCavoSm6UIL7b3z7zWLQsBCreQsMBIkwVPmG46i3rucA19h5kSDYHmq/
         4BbMwdTaOJCVW9CINC4aq/rfRGE2eR6VpkgK4VE2/vv/3TojugIhwJULOyS4W3VIPhGW
         y9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWr9d1ajXFj1+3i5dkAdmDb2mHo0visFJ3r0UjQmCPA=;
        b=ccuXPPTkepb3kGe9RhvIUnq5X3t1Tb9PXhCrLG9QDRaM2JFLlrqA8mqPoEzpkNGSWQ
         cq2vajdDc+X6bLhwU//o6Vn62uztpp9OlrSh6tY3EkJMVdA+5FY5RZIkA0IeBUV2A8tx
         fRe/um85GZJYc0trhhKYodNdZ3A6DR8joXQZC9sDqhJIaaH4N3MPyqd5JQpXZ5P+HX8N
         BoMcsma3sSgGDeWTQfxY+qKjXLm/NKiLGW4pzKO68RkBnp+DiR8s0iO19oPoB+uxHs1B
         MnCCRkPtLAYTCAqYgQGe62UxgQvn1D2X6/V78lf1/5wo9zakkplN3rDhiLUGHIOfEGPl
         7shg==
X-Gm-Message-State: APjAAAUu3eVq9N3cIWYcDfRPvA/XBIUsnpPK2Wk1tcWgMt8aaIG7aov5
        ZhYMO5doHYDmKRyBxW/oX9lftw==
X-Google-Smtp-Source: APXvYqywsM8jPQ7r6g46gIuEMB7OfnXrRlAZ0KPt3Y7Pl/+BOIWuy+or7jMvqVTQPx91QlvOxzKdEg==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr23384114wrq.284.1581969279536;
        Mon, 17 Feb 2020 11:54:39 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/6] nvmem/gpio: fix resource management
Date:   Mon, 17 Feb 2020 20:54:29 +0100
Message-Id: <20200217195435.9309-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series addresses a couple problems with memory management in nvmem
core. We fix an earlier memory leak in error path in patch 2/6. Patches
1/6, 5/6 & 6/6 add reference counting to gpio_desc structure and use it
to correctly free the write-protect GPIO. Patches 3/6 & 4/6 fix newline
problems.

Bartosz Golaszewski (5):
  gpiolib: use kref in gpio_desc
  nvmem: fix memory leak in error path
  nvmem: remove a stray newline in nvmem_register()
  nvmem: add a newline for readability
  nvmem: increase the reference count of a gpio passed over config

Khouloud Touil (1):
  nvmem: release the write-protect pin

 drivers/gpio/gpiolib.c        | 26 +++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  1 +
 drivers/nvmem/core.c          | 14 ++++++++++----
 include/linux/gpio/consumer.h |  1 +
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.25.0

