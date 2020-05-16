Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A550C20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJVu792v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgEPJQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgEPJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:16:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7622C05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:16:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so4718111ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3OMzvoIzOVMGXlSU32P6AgStJJg7OOz1afav8/9GlUI=;
        b=wJVu792vI3DxogDPuooiWiSSa6AzfDSXnXw6AxYsrK+Tm1hEGefCbJxazgd0unWGBa
         BBO1CzX25E0UO2wY7vpPtE1PEY+SB1uP6nR1aRNpmqmeJkgSLOxmV1CCayO0pifkGenB
         wDBv9JXICVOaEyzNNT1vPqbU7kHNZR4/5KTCizUg+NCo2KbpWfL/Be6uvXQ/pHJLEtrK
         Tvvu2NvDorPAbX5VDi4yovRtMK4EYMW2co6pOG38J2qgkHnEW1GO4c9LHVyBBXQIekes
         Io0gYvCWt4hOv91BVkbK5e/FM6ChdtG8qjye196FqX6yCz4/msbujDSsp92YMCF66KDv
         CE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3OMzvoIzOVMGXlSU32P6AgStJJg7OOz1afav8/9GlUI=;
        b=CeCTrT7gDc2vlLsOb9Eo8tgwiQ6liP00A3v4Ysbgem37+ES3zHNbqqj258dmj+lCvz
         t8ik4a4/p1tin2j/RyUKpXP9PPpu6QmJcEiQ8vJC+m1qrXopsC70e+gF7iIJoxu2emdG
         zO5XgApjJ3dO9X2Zr5hytHyiUAy4VW3ZOduudoYs6B6VDAWvPQoFqriIJlPxlzn4RzpO
         g1KTw+1Vn86fnsl2jjuywlwpbKnXlcnnk8slMftyJ4Tep9Pl2QYiZeJGtG83PnWLB7yk
         yuwIjLNtAkSTAEs7nn0C2dceOLlb8MlX0aHwd8Q1U6L4bXamnaoil9GCe/trVbJueA2g
         qeSQ==
X-Gm-Message-State: AOAM530/NEN2ZZg2v+VoYUxShTA7Y2pZz2hNfUNon9HQZFIvJiWe8pyd
        DdqtCgKW/epSUapg/y9MsizfKPCkNzQ/3sR72obRuw==
X-Google-Smtp-Source: ABdhPJy8VvW1xMAskKNAns4f8nl5TxuiYq/93NQMcuuJDMpjpLMD4eYhZI5ZCzPWBzPCvAWHKxlpTYcMgz32a+4BLDM=
X-Received: by 2002:a2e:a209:: with SMTP id h9mr4983504ljm.39.1589620591858;
 Sat, 16 May 2020 02:16:31 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:16:21 +0200
Message-ID: <CACRpkdbpt9GGegm1TZSQ1-ohDB6682cLpQbipHT24dpuKHLBvQ@mail.gmail.com>
Subject: [GIT PULL] Pin control fixes for the v5.7 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a bunch of pin control fixes, some a bit overly ripe,
sorry about that. We have important systems like Intel
laptops and Qualcomm mobile chips covered.

Details in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.7-2

for you to fetch changes up to dca4f40742e09ec5d908a7fc2862498e6cf9d911:

  pinctrl: qcom: Add affinity callbacks to msmgpio IRQ chip
(2020-05-12 14:29:29 +0200)

----------------------------------------------------------------
Pin control fixes for the v5.7 series:

- Pad lock register on Intel Sunrisepoint had the wrong offset.
- Fix pin config setting for the Baytrail GPIO chip.
- Fix a compilation warning in the Mediatek driver.
- Fix a function group name in the Actions driver.
- Fix a behaviour bug in the edge polarity code in the Qualcomm
  driver.
- Add a missing spinlock in the Intel Cherryview driver.
- Add affinity callbacks to the Qualcomm MSMGPIO chip.

----------------------------------------------------------------
Amit Singh Tomar (1):
      pinctrl: actions: fix function group name for i2c0_group

Andy Shevchenko (2):
      pinctrl: sunrisepoint: Fix PAD lock register offset for SPT-H
      pinctrl: baytrail: Enable pin configuration setting for GPIO chip

Ansuel Smith (1):
      pinctrl: qcom: fix wrong write in update_dual_edge

Grace Kao (1):
      pinctrl: cherryview: Add missing spinlock usage in chv_gpio_irq_handler

Light Hsieh (1):
      pinctrl: mediatek: remove shadow variable declaration

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.7-2' of
git://git.kernel.org/.../pinctrl/intel into fixes

Venkata Narendra Kumar Gutta (1):
      pinctrl: qcom: Add affinity callbacks to msmgpio IRQ chip

 drivers/pinctrl/actions/pinctrl-s700.c       |  2 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c     |  1 +
 drivers/pinctrl/intel/pinctrl-cherryview.c   |  4 ++++
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 15 ++++++++-------
 drivers/pinctrl/mediatek/pinctrl-paris.c     |  2 --
 drivers/pinctrl/qcom/pinctrl-msm.c           | 27 ++++++++++++++++++++++++++-
 6 files changed, 40 insertions(+), 11 deletions(-)
