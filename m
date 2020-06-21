Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 18:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6367225222
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 18:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkrN1LKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgFUSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgFUSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 14:24:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70944C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 11:24:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so16831514ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YBgsvtuV1+FGKsiCwr3BVYB/Gcp58aRuWaU/DnoMIcg=;
        b=EkrN1LKZNMwqOTBRdx0cPhdlbCgUWu6nUUT4RBZigTrqcYvvEPs1OBGy72xFs6Xv3T
         QSi69AOmPIRTEHcR12DxXw+uy5lLmb73+mqdVxpnAoMRclKm+SvibAAAKhqkcPf2b9oz
         GuMMA5QUC8qmClY21eZLHLOsjrW4vui/GC6geS93z2QZimCfS6oXlI8S9CpXVfglMDAc
         fEyTF1BwBticNvWlXJCDVEtOXbEYy+kso1YkQ/rrAyfafslqTQ2yMUCASXIqvLVeqiUG
         /wyr3g7tUIwVF506zDvFUOWA9E8fiCG52qttn43KBpN21rv2foB6ikCrrJbKLVGhvsEv
         Wu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YBgsvtuV1+FGKsiCwr3BVYB/Gcp58aRuWaU/DnoMIcg=;
        b=gvvLaf+GZOb2fgxNDqRnC5x0ckhXPUYBwJeBB8jHKoCuhlqbUcwgeF8HHGJHC8BqXF
         9BZ5NU9HwHyYm9sdDxJyyjjSqFUsbq9xyyyq2Y49cm68HGORUO8SycDSc2fepcC1kybA
         T/GnLCSGvRyOIR4yYbRNP6d4FW7BM+MOlCNipCrypND7GVM2bqH6910AUNrHhh6CJ5LV
         58IBDfkPipHZaZh+nZ23+VOXdJl9A5r3Cy2SOWg58+x4lToIKBMqx/UXMrG0kFprY3xI
         N05xQCwcwqTe3MuFHCCfuEWcPrM+JzBG4gsHplUHyUrf79D74aVuuw9LKqog9Cly+oFM
         xNKw==
X-Gm-Message-State: AOAM530X7/7gsx0pJqeI2s9AmiQsvb0AHEdJ4rjAumYXBnaId+8ojRmo
        HgOIR12jC6ZDFCJ4wWzJpWSjP8fkFBg5oVfjJSnSkQ==
X-Google-Smtp-Source: ABdhPJxLZa8trPAUnCmC8L02O+Nk0zCWm3TEEurkUZceBNWISBjeHa1Igv4FklL/+ZCxx9vuteCBMDkrjby+Gs54Zz4=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr7169685ljc.100.1592763891900;
 Sun, 21 Jun 2020 11:24:51 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 21 Jun 2020 20:24:40 +0200
Message-ID: <CACRpkdasTF7DLFejjC005vuBfcv2upbNjd5Cw9j_d-CUnHOMDg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

these are some early fixes collected during the first week after the merge
window, all pretty self-evident, with the details in the signed tag. The revert
is the crucial thing.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.8-2

for you to fetch changes up to 25fae752156db7253471347df08a2700501eafde:

  pinctrl: single: fix function name in documentation (2020-06-20
22:41:32 +0200)

----------------------------------------------------------------
Pin control fixes for the v5.8 cycle, first take:

- Fix a warning on the Qualcomm SPMI GPIO chip being instatiated
  twice without a unique irqchip struct.
- Use the noirq variants of the suspend and resume callbacks in
  the Tegra driver.
- Clean up the errorpath on the MCP23s08 driver.
- Revert the use of devm_of_iomap() in the Freescale driver as
  it was regressing the platform.
- Add some missing pins in the Qualcomm IPQ6018 driver.
- Fix a simple documentation bug in the pinctrl-single driver.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      pinctrl: qcom: spmi-gpio: fix warning about irq chip reusage

Drew Fustini (1):
      pinctrl: single: fix function name in documentation

Haibo Chen (1):
      Revert "pinctrl: freescale: imx: Use 'devm_of_iomap()' to avoid
a resource leak in case of error in 'imx_pinctrl_probe()'"

Sivaprakash Murugesan (1):
      pinctrl: qcom: ipq6018 Add missing pins in qpic pin group

Vidya Sagar (1):
      pinctrl: tegra: Use noirq suspend/resume callbacks

kernel test robot (1):
      pinctrl: mcp23s08: Split to three parts: fix ptr_ret.cocci warnings

 drivers/pinctrl/freescale/pinctrl-imx.c  |  7 +++----
 drivers/pinctrl/pinctrl-mcp23s08_spi.c   |  5 +----
 drivers/pinctrl/pinctrl-single.c         |  2 +-
 drivers/pinctrl/qcom/pinctrl-ipq6018.c   |  3 ++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 21 ++++++++++-----------
 drivers/pinctrl/tegra/pinctrl-tegra.c    |  4 ++--
 6 files changed, 19 insertions(+), 23 deletions(-)
