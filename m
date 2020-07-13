Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DD9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952892075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziDxCI60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgGMOtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1EFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so16864991wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6KODDu7f11jd3niq7W/zAdz/lhZIgV18jMn++N0dmk=;
        b=ziDxCI60DN39PM3RJGP30ojYL2Y3TGAxLsIq/FctTLe1wm269+IzqFClnsGIrxXzrZ
         jszWZM1RgKTZkNOqH1vdh/VgIjgb7ldg4fQ7OMXUormprt1oO+etW+BwEsPB1D0PNjkJ
         2BxkDLoCQJvbPQwi490dK2xEIPOHALdTYlVCBd6G3orMtcZEvSvf7nRev9xqxPGVm8Ww
         2rgJZDBJ8sbdaWZjmvzZEqzvcR8sXkeA4UYZPwu5X7rh4uQ7tBbKRVeYtib+PnBEgUpl
         9PFBRhn4Hk2PR/qK4CuNn6v8DN6cQuLghH75grBKX2cQW4Hje+mVPDP+jx0ESpvL3HTc
         +sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6KODDu7f11jd3niq7W/zAdz/lhZIgV18jMn++N0dmk=;
        b=D/MiYfdsOVcEyEVhLLJFl7istURwzp/iyThifIaY/or+tuD5QG4j5inZe/7gryxnMw
         TpQ0qF1BLxzIXsJlvuX2tD5BIPF/RjYELfEbUm9PExZGwnCVfxyxmvmhsU1vPtTQEXF8
         wPb8k2GB3GaEgQF/jbHuR0OGyym0L9YHSshaQ2xcodkoHViU0vVKqvz/+YltrjBufR8+
         JJ18tbLsQfPGVFGhgjf1hgIHxBwXWd8jWMG6n+rQ7rK4+WVWo8Vmr6XGp6QLHJ9z+6nC
         d+3fKMqf7ydSLNa0vac5JNeyFrOjz24L59zxZhob6TVcXlTaVFESZjaxefkaHLLVKItv
         v9+w==
X-Gm-Message-State: AOAM531VxedZd7a2X2zm1oB/FWGVXRGNm7AyJaFeP2IgDwJFcK7CwyE0
        oYOZ/tQvgaUeLkjGOiJ3YF3rVw==
X-Google-Smtp-Source: ABdhPJwBN+7FNRB5e10ikfDcEOXPB9oZvVzsMu9gdAu4L2NQ8gP1Yq1xz451vmi1hanVhy7AZxDirg==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr79196427wrr.42.1594651772925;
        Mon, 13 Jul 2020 07:49:32 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/25] Rid W=1 warnings in Pinctrl
Date:   Mon, 13 Jul 2020 15:49:05 +0100
Message-Id: <20200713144930.1034632-1-lee.jones@linaro.org>
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
complains about any W=0 nor W=1 level warnings in drivers/pinctrl.

Hurrah!

Lee Jones (25):
  pinctrl: actions: pinctrl-owl: Supply missing 'struct owl_pinctrl'
    attribute descriptions
  pinctrl: sirf: pinctrl-atlas7: Fix a bunch of documentation
    misdemeanours
  pinctrl: bcm: pinctrl-bcm281xx: Demote obvious misuse of kerneldoc to
    standard comment blocks
  pinctrl: bcm: pinctrl-iproc-gpio: Rename incorrectly documented
    function param
  pinctrl: qcom: pinctrl-msm: Complete 'struct msm_pinctrl'
    documentation
  pinctrl: samsung: pinctrl-samsung: Demote obvious misuse of kerneldoc
    to standard comment blocks
  pinctrl: samsung: pinctrl-s3c24xx: Fix formatting issues
  pinctrl: samsung: pinctrl-s3c64xx: Fix formatting issues
  pinctrl: qcom: pinctrl-msm8976: Remove unused variable
    'nav_tsync_groups'
  pinctrl: mediatek: pinctrl-mtk-common-v2: Mark
    'mtk_default_register_base_names' as __maybe_unused
  pinctrl: core: Fix a bunch of kerneldoc issues
  pinctrl: pinmux: Add some missing parameter descriptions
  pinctrl: devicetree: Add one new attribute description and rename
    another two
  pinctrl: pinconf-generic: Add function parameter description 'pctldev'
  pinctrl: pinctrl-at91-pio4: PM related attribute descriptions
  arch: arm: mach-at91: pm: Move prototypes to mutually included header
  pinctrl: pinctrl-at91: Demote non-kerneldoc header and complete
    another
  pinctrl: pinctrl-bm1880: Rename ill documented struct attribute
    entries
  pinctrl: pinctrl-rockchip: Fix a bunch of kerneldoc misdemeanours
  pinctrl: pinctrl-rza1: Demote some kerneldoc headers and fix others
  pinctrl: pinctrl-single: Fix struct/function documentation blocks
  pinctrl: tegra: pinctrl-tegra194: Do not initialise field twice
  pinctrl: meson: pinctrl-meson-a1: Remove unused const variable
    'i2c_slave_groups'
  pinctrl: mvebu: pinctrl-armada-37xx: Update documentation block for
    'struct armada_37xx_pin_group'
  pinctrl: pinctrl-amd: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI

 arch/arm/mach-at91/pm.c                       | 17 +++++--------
 drivers/pinctrl/actions/pinctrl-owl.c         |  4 ++++
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c        |  6 ++---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c      |  2 +-
 drivers/pinctrl/core.c                        | 12 +++++-----
 drivers/pinctrl/devicetree.c                  |  5 ++--
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.h  |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-a1.c      |  5 ----
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c   |  7 +++---
 drivers/pinctrl/pinconf-generic.c             |  3 ++-
 drivers/pinctrl/pinctrl-amd.c                 |  2 ++
 drivers/pinctrl/pinctrl-at91-pio4.c           |  2 ++
 drivers/pinctrl/pinctrl-at91.c                |  7 +++++-
 drivers/pinctrl/pinctrl-bm1880.c              |  4 ++--
 drivers/pinctrl/pinctrl-rockchip.c            | 22 +++++++++--------
 drivers/pinctrl/pinctrl-rza1.c                | 24 +++++++++----------
 drivers/pinctrl/pinctrl-single.c              | 13 +++++++---
 drivers/pinctrl/pinmux.c                      |  5 +++-
 drivers/pinctrl/qcom/pinctrl-msm.c            |  6 ++++-
 drivers/pinctrl/qcom/pinctrl-msm8976.c        |  3 ---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |  6 ++---
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |  6 ++---
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  4 ++--
 drivers/pinctrl/sirf/pinctrl-atlas7.c         | 21 +++++++---------
 drivers/pinctrl/tegra/pinctrl-tegra194.c      |  1 -
 include/linux/platform_data/atmel.h           |  5 ++++
 26 files changed, 107 insertions(+), 87 deletions(-)

-- 
2.25.1

