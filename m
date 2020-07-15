Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D2F20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BF2RTKCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGOPGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGOPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFCC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so6184292wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRvTJfssab5Y/CSiD8kCb/7tb1fC8xBCKdijnh6hB8k=;
        b=BF2RTKCOfZ8Rm9yLgkbNV8cuXjX4Jeia930iQEPzWmJSLrXa4ySqNPOZ1SZz4xt/LD
         KtyCw36bQyMkTViQB37YRaG9s8XWqdNaH3DzV5nfALDDqeD+uz2U0Z5puu6c+SIOsIS6
         T4CeAZfLRfYMweBso/ZdIIeChrdXnM6f/1tIsYSKko6xBs+ELXTc3cSvr/pwntM4x7ji
         zSPz1uk5l0CqbpvmSkslxtlZJDET5F74ICRin0AAwGEmgLC3CZtlVcbMu8PybMUfxI/U
         5U0+aPOXQRuY6AY8fDavAvui4v5zUTpZSKUpKc7YVKaeAwOVjPXh5SeKH2NfEkcqNw86
         +Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gRvTJfssab5Y/CSiD8kCb/7tb1fC8xBCKdijnh6hB8k=;
        b=AxVQm5ItnyOoH7oYRUS2VV6WQ3IyZ/yujG9vHx33Hheo00PfmHlhzOAC4mLr+IRe4p
         5nguEGWdV4e3yBGt3p/x2yrXYotNHZHofiFIORmu4x1mWYC9pnnwjzcIxvQM2T18BuDg
         e1sZpsWf4FOAohVDl2atoPLEiQPZB8XvfF94qAc7jGwpNAb+jyuj7X+OB7MiZjw2pUI9
         ia1QeArbzQoMpwCvORABnoQa2a3qEjkwTKQURulU7tUqsJeTekTXCIhg6x9OfX+DZn3t
         UWVN66yUW3244G7i2bdf10JXfY1lgljg96O+26eLQN6WTz+7QCDMoT/MSkcVa/OknTcc
         zFOQ==
X-Gm-Message-State: AOAM533PRY2jLT/gBt4p8aG+JwF1AVH5GYYpIMPOEADGlZuOXYugbRit
        kccOkGjajQoRCqjkxxofYpYjAw==
X-Google-Smtp-Source: ABdhPJzOoFptPuUiAhy7TR/n4BljiYkEMvNeuBQSWGiNufyADYxFeRx7E2+ui19Bo+DZlamOpSm8kw==
X-Received: by 2002:a7b:c18f:: with SMTP id y15mr9263475wmi.85.1594825595356;
        Wed, 15 Jul 2020 08:06:35 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/14] Rid W=1 warnings in SPI
Date:   Wed, 15 Jul 2020 16:06:18 +0100
Message-Id: <20200715150632.409077-1-lee.jones@linaro.org>
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

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/spi.

Hurrah!

Lee Jones (14):
  spi: spi-loopback-test: Fix formatting issues in function header
    blocks
  spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard
    comment blocks
  spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
  spi: spi-ep93xx: Fix API slippage
  spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct
    meson_spifc'
  spi: spi-meson-spicc: Remove set but never used variable 'data' from
    meson_spicc_reset_fifo()
  spi: spi-s3c64xx: Add missing entries for structs
    's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
  spi: spi-pl022: Provide missing struct attribute/function param docs
  spi: spi-zynq-qspi: Add description for 2 missing
    attributes/parameters
  spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
  spi: spi-topcliff-pch: Add missing descriptions to 'struct
    pch_spi_data'
  spi: spi-at91-usart: Make use of the defined 'struct of_device_id'
  spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when
  spi: spi-amd: Do not define 'struct acpi_device_id' when

 drivers/spi/spi-amd.c           |  2 ++
 drivers/spi/spi-at91-usart.c    |  1 +
 drivers/spi/spi-bitbang.c       |  6 +++---
 drivers/spi/spi-davinci.c       |  7 ++++---
 drivers/spi/spi-ep93xx.c        |  2 +-
 drivers/spi/spi-loopback-test.c | 16 ++++++++--------
 drivers/spi/spi-meson-spicc.c   |  4 +---
 drivers/spi/spi-meson-spifc.c   |  2 +-
 drivers/spi/spi-pl022.c         | 14 ++++++++++----
 drivers/spi/spi-pxa2xx.c        |  2 ++
 drivers/spi/spi-s3c64xx.c       |  9 ++++++++-
 drivers/spi/spi-topcliff-pch.c  |  8 ++++++--
 drivers/spi/spi-zynq-qspi.c     |  3 ++-
 drivers/spi/spi-zynqmp-gqspi.c  |  6 +++---
 14 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.25.1

