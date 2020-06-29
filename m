Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768A1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MFHsR5ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgF2TNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbgF2TN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5AC08EC44
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so15335749wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FbmkW7UOcYY7LkyFQeYD+n43SXMQXYjstj7AfGPBFY=;
        b=MFHsR5IDjPY0E1cBnmOdDmaaexsDnuGaeCom8ugM6D2bx/csHHWIKc48ZfoIzQ1WnQ
         wH2T1DsKev7yAD8X37BfHZeGwcp165BuatzBqWpk9PKAHPFguntRaNcNM+9ylDmq1Njl
         NVuN0ckQWhi9I84VLdztbSBWb2IQ1+HBDHXb622lxqQpwfrwmNWd9Mkyxhm4TdXQF1a6
         Qu7nv7GnKuaQtAdamC+YNXe2VGuqkZAdM7PXqkyxRPuNL0QCsk4OeEyOd44jJct2xsgz
         /DRypuk9B9Sua+ocxb2STpKn4HHeSpfcsjEMcVSUlGI2ghJFdvn2DzB6bgnCgXysJtma
         CCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FbmkW7UOcYY7LkyFQeYD+n43SXMQXYjstj7AfGPBFY=;
        b=T/XOTaHssCwlmPTSPzm0byM1SVC0ob87lFWMCOmq4MOR7YqvM7dGhnosb79d2V+Mc7
         sDH9NnLdKceyQBDsCH1/Hyl3/ITB+Ib4tVETwAJhEUcbX9Bwv8oIh7xQBTDkx+k26I12
         DBVr0nE06QUy1Kr0yEL6/h7GfwxZQbYiTvD//rhShEIJ5Xl4OQjkmAlJIn6P3K0A9j/x
         ucl9gmrIVDWg6LBaEtRkM8tajBvX4qj8xqxNk9WOSxZmiZYjkG2NUh0X19NdaLtvJIPi
         ijJKPSYKS5NuSa9ifHLp79ampobjOGX8+NZS5bjZY184zUnIYNrV7sctTMAX92JySQbA
         rxUA==
X-Gm-Message-State: AOAM5303toebn2Vw6jNz9WOBHIFFhdB0T4nhiG32PibsDszGJso4gOS/
        +qMHIrCXs3Mu2FKmFcHjwUfuxsoYrag=
X-Google-Smtp-Source: ABdhPJxSUzNN1zV4gXxXOT8r64Q07nF/D8nrR8lGdd7yU4bCgcU0Q04rNUK9eOM5Le0U05BUn4D0PA==
X-Received: by 2002:a5d:4ec7:: with SMTP id s7mr15362311wrv.400.1593413413900;
        Sun, 28 Jun 2020 23:50:13 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id z25sm26400850wmk.28.2020.06.28.23.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:50:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/6] devres: provide and use devm_krealloc()
Date:   Mon, 29 Jun 2020 08:50:02 +0200
Message-Id: <20200629065008.27620-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds the first user with hope that this
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

Bartosz Golaszewski (6):
  devres: remove stray space from devm_kmalloc() definition
  devres: move the size check from alloc_dr() into a separate function
  device: remove 'extern' attribute from function prototypes in device.h
  devres: handle zero size in devm_kmalloc()
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers

 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/base/devres.c                         |  75 +++++-
 drivers/hwmon/pmbus/pmbus_core.c              |  28 +--
 include/linux/device.h                        | 225 +++++++++---------
 4 files changed, 187 insertions(+), 142 deletions(-)

-- 
2.26.1

