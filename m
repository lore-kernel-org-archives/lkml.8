Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A3820702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LglfJeZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgGAMrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgGAMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48212C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so18178070wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7pxaqnC8CPn4gE0jGD/FCGO5xYoaEIWYvgDUdxPAhs=;
        b=LglfJeZnV20gty5aXMxAUOS/QKFCEYFVV9nciqj4VSAChUxyXt7SnrChBDDpFfYjB9
         cqz3h/5sOCJrdW0PXBidHvsMdwNy4R4Bacj5+fZr/D8ZyaU6/HuWtoeUdZCTaU1SOVBp
         cFEQZuhYXlDxv9yQMf9WRfWcis5ASFFdtdh7MVKQUPmL0CpoqHyXYkrxiJ7D8UND2Ujb
         4pSoPZlBO1snZ0JMDQHKz+WSidZAswQ7Vx+eGgb/nediD0UbBcNHP6N3RVXQE2pnmsKx
         OBy+bJFJBT1w+R8mIii7OgR7AWYJnNPAzsLzUSxjVfczbUJuVwab+dK1OBs9jcuh9amq
         CkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7pxaqnC8CPn4gE0jGD/FCGO5xYoaEIWYvgDUdxPAhs=;
        b=fOmNPGBXu38+m5GJOz3dHDW3nq162m7GQft5PqPshEQYaPEqgs+VSC5xYJYo3GqVEe
         tCj6tNdDM4sFELzx5WKXor3XgMfQY9UbjCuIWyIAwP62dSd/Yr1jgr4xUA6gN5SgzlMP
         a0XjSVdWeUvTt8Xf+m+QJjO1CAhGuJqfy6TT1L2SBQvyHInP986Ihd+YEfnXsg64p8Fl
         X4zHNhB0ph/rSNjJPUH9nMdhbZiUA7fNwz2k6jTJp7dcfyHJXP+Wo+JlBFJpm6zqCWJT
         IA0GMB6zoB+bkLw/vIhXFHU+qSCtnFxmvJHGQ13L6f1oW60MSsEgZCzoh3P5xbmw1wgz
         +RNQ==
X-Gm-Message-State: AOAM532zYqj1v7Knt38pRNhDXu6Q8LzuGjmbdDrU10Fdykn9EdO5fTH4
        uW0UtTrdeqScNw2vPdMRBbIxZOVnC2A=
X-Google-Smtp-Source: ABdhPJwEK3EqINZksClwQHgNzDMujwc/5CYYF1k6okVgHxF8SAFeTEi37FutbpVY+tZywK/uFGqb3w==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr26410678wmf.146.1593607626956;
        Wed, 01 Jul 2020 05:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/15] Clean-up MMC's W=1 build warnings
Date:   Wed,  1 Jul 2020 13:46:47 +0100
Message-Id: <20200701124702.908713-1-lee.jones@linaro.org>
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
complains about any W=0 nor W=1 level warnings in drivers/mmc.

Hurrah!

Lee Jones (15):
  mmc: core: quirks: Mark fixups as __maybe_unused
  mmc: core: sdio_io: Provide description for sdio_set_host_pm_flags()'s
    'flag' arg
  mmc: core: regulator: Add missing documetation for 'mmc' and 'ios'
  mmc: host: sdhci-s3c: Provide documentation for missing struct
    properties
  mmc: host: mtk-sd: Demote msdc_recheck_sdio_irq() function header
  mmc: host: atmel-mci: Provide 2 new and correct 1 existing property
    description
  mmc: core: queue: Correct misspelling of 'mq' in mmc_init_request()'s
    docs
  mmc: host: dw_mmc-exynos: Add kerneldoc descriptions of for 'dev' args
  mmc: host: rtsx_pci_sdmmc: Remove set but unused variable 'err'
  mmc: host: rtsx_usb_sdmmc: Remove set but unused variable 'err'
  mmc: host: sdhci-of-arasan: Correct formatting and provide missing
    function arg(s)
  mmc: host: sdhci-msm: Staticify local function
    sdhci_msm_dump_vendor_regs()
  mmc: host: sdhci-msm: Demote faux kerneldoc header down to basic
    comment block
  mmc: host: cqhci: Demote faux kerneldoc header down to basic comment
    block
  mmc: host: sdhci-iproc: Tell the compiler that ACPI functions may not
    be used

 drivers/mmc/core/queue.c           | 2 +-
 drivers/mmc/core/quirks.h          | 6 +++---
 drivers/mmc/core/regulator.c       | 2 ++
 drivers/mmc/core/sdio_io.c         | 1 +
 drivers/mmc/host/atmel-mci.c       | 4 +++-
 drivers/mmc/host/cqhci.c           | 2 +-
 drivers/mmc/host/dw_mmc-exynos.c   | 2 ++
 drivers/mmc/host/mtk-sd.c          | 3 +--
 drivers/mmc/host/rtsx_pci_sdmmc.c  | 4 ++--
 drivers/mmc/host/rtsx_usb_sdmmc.c  | 5 ++---
 drivers/mmc/host/sdhci-iproc.c     | 2 +-
 drivers/mmc/host/sdhci-msm.c       | 4 ++--
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 drivers/mmc/host/sdhci-s3c.c       | 4 ++++
 14 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.25.1

