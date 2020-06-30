Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9219B2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOwYxgcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbgF3Ney (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbgF3Ndu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFDC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so18836112wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/OBCOZny1ndsw3tmtK3a2umBUo6+P4OiGX2ORUOTVo=;
        b=SOwYxgcVaWP69efaAXz9BhJcmlTyK1GZqGNK1MqJgMhuxbrP1cUHlsGK2XYPEVuoot
         KTtEe9qq6HGV8fCOc+8e5ors98U36q7Ke+yVpoP8mVeODUQU4Dqiojr2Lr68JuvxfcIT
         9u7cxUHcLRvtnCsd4woz3jbfJZ7xySd6MHAlwOphAAEb0h58APo9daYXwxoXL9yRDl9M
         HkKFTYCyGu/mFr9dVcsDrxBPS3yaAATySXjSSLERl93KVRUu2daqu4B988sR46gWzz1z
         T9HbXAn8MX+UcCVy8IcimypeXTMbCfyv1yFHF5YHpvWxE5T+N02+l6NAA5EsSo1+jBC4
         iUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/OBCOZny1ndsw3tmtK3a2umBUo6+P4OiGX2ORUOTVo=;
        b=QTUPd4FrjGolAdPEGwQHmOMdhm6shjZ0tgssbDkwtPIzbMiWy4EUzvarQFqJa7UgC4
         XPZMnSQXa/pwgrhdv0xxgpxqT1nWpBNCiOro1/SeD33tENrPRN60KeIdKSeScRwawmb3
         5QB6qGenXmNWpou7vahOIAmg9mT4ov/xjC1aHWpjdso4LUGHbVg5bbiH+Plvw+zM5Miu
         18UF5blyH10ms8k269fZn2UKwfRekDopA2RoYxm50ieBncQJQfRgClcOGHTBq7vlgbbp
         yPLza73H4TDih4Uc/jekfn8vbN0MzNxi3eYMTDz9HgkjxD1wUh9NrvRPIlgptf7823Yl
         hiNA==
X-Gm-Message-State: AOAM532RsobiQ6Jxpj9HKhV8ykuqYovzY6trpCmRvPNIl76oxvo2IWeY
        AL4nhX2MnEZ9IpD/VAdkK2todw==
X-Google-Smtp-Source: ABdhPJwIF8ribrbnToYRwN/u2AGBLiHFeuBSCLm3XU+lxTFxPc4lFfZzghG4zloc1akGtH8+Nhr4Pw==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr20301556wmh.96.1593524028491;
        Tue, 30 Jun 2020 06:33:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/10] Clean GPIO of W=1 warnings
Date:   Tue, 30 Jun 2020 14:33:35 +0100
Message-Id: <20200630133345.2232932-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (10):
  gpio: gpiolib-of: Provide documentation for of_gpio_spi_cs_get_count()
  gpio: gpio-altera: Add missing kerneldoc entry and demote comment
  gpio: gpio-ml-ioh: Fix missing ':' in 'struct ioh_gpio_reg_data
  gpio: gpio-pmic-eic-sprd: Fix incorrectly named property 'map'
  gpio: gpio-sama5d2-piobu: Demote all kerneldoc headers to basic
    comment blocks
  gpio: gpio-syscon: Fix formatting issues which confuse kerneldoc
  gpio: gpio-it87: Fix formatting issues which confuse kerneldoc
  gpio: gpio-mlxbf: Tell the compiler that ACPI functions may not be
    used
  gpio: gpio-mlxbf2: Tell the compiler that ACPI functions may not be
    use
  gpio: gpio-mlxbf2.c: Provide __releases() annotation to stop confusing
    Sparse

 drivers/gpio/gpio-altera.c        |  3 ++-
 drivers/gpio/gpio-it87.c          | 14 +++++++-------
 drivers/gpio/gpio-ml-ioh.c        |  2 +-
 drivers/gpio/gpio-mlxbf.c         |  2 +-
 drivers/gpio/gpio-mlxbf2.c        |  4 +++-
 drivers/gpio/gpio-pmic-eic-sprd.c |  2 +-
 drivers/gpio/gpio-sama5d2-piobu.c | 16 ++++++++--------
 drivers/gpio/gpio-syscon.c        | 12 ++++++------
 drivers/gpio/gpiolib-of.c         |  3 +++
 9 files changed, 32 insertions(+), 26 deletions(-)

-- 
2.25.1

