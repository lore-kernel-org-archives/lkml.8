Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC90AC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7802075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="D3z2EgQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGJQPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgGJQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:15:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E0C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:15:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so6524773wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vPUXxzXeGlnq1ZiHx0yDQxVggNKEEBwatkvINr5b3U=;
        b=D3z2EgQ3LfL5O6tfLeHTEAqFU/QuxHc6dLUveKrSeu8pCTk+DWU6wwowhGSwcqSp17
         dlID+mPfggDJRpNSdp8sc5scypx9H/ZEBg4tJDxgqU/1DTnIWG0KQdiD+Uimo2y5oCQh
         sK5aK2/Trj4yQ1DII0Xfwvg4xdV8wry9DUVHbkMecPKDM7DUR+fPj/un/E0yHCOcXs5y
         Tywdj2iQNcP+DFk2boREchX3VQUrdtI/5tVGRKhu7tH/xsT6TBHOsght5Swb4n+cVGvr
         5ST8ht05dAa+6WYeqYhg4KXYy2nLPKeQlY9jGKH22SYQGq0ORluCE6oy4DMRpk2baJU/
         irPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vPUXxzXeGlnq1ZiHx0yDQxVggNKEEBwatkvINr5b3U=;
        b=j2nE2eKh4AhyxUDPUm5Xuuxwh6PAJn3KagQDlUS76NCeLSH7X/NExbBSMy8QOwqlLL
         nJ7cDlIY116yKCzrrBVMrJFvn55oKSBW22QmWIY6RJXSEjVoUf3FI3JkDAAy4ctM/YEP
         sYsVyPJBMVMq53WOcmTb44KmGJDUXzUn+b6mCYHP/fjN8DWFEPA6Mlv0KoJ7vBXIACL2
         IRFYad2V89zsybqWbxc+1/ABs9yNuCGPzXIAkv056VHlaZm9L6TuL7O41ieifRC13D2G
         wgiKyvWEMKx0E7NC75pN5RAYkwujkuvWTqPmQ9bls+POMCykYsaCL49xgx+CcnBxyNzo
         Yv+w==
X-Gm-Message-State: AOAM532m2hwbY+Z4XKcVGCfXB1aGgs8f1MfZBxTnrHbEli7ZZVCsACox
        +rZ30+SPzQ5pJ+9GLpHxec31xw==
X-Google-Smtp-Source: ABdhPJzyp5bJ8ltFB6zHj7EKTwCY5Eopz4BIDAohnS82UPKO8R6qn1ZyOecy2+fAN4nrQX5rouwPAw==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr73581485wrn.392.1594397720362;
        Fri, 10 Jul 2020 09:15:20 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id e8sm11179359wrp.26.2020.07.10.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:15:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/3] devres: provide and use devm_krealloc()
Date:   Fri, 10 Jul 2020 18:15:13 +0200
Message-Id: <20200710161516.11625-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Greg,

As discussed, resending the remaining devm_krealloc() patches.

===

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

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 50 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 ++++-------
 drivers/iio/adc/xilinx-xadc-core.c            | 16 +++---
 include/linux/device.h                        |  2 +
 5 files changed, 70 insertions(+), 27 deletions(-)

-- 
2.26.1

