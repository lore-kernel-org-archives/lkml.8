Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C5BC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E48A207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpyS5KUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGJPku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:40:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FFC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:40:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so3462832lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=p4c4RaUrI+TqMaMS0f5jfDieCGnmujxFfWD54tCErWQ=;
        b=OpyS5KUSNYXSIZIrtYSYeQlgu/tLNtvlojblx8984l8e5WEC2dkHJocvGoITQHbUKq
         +BPjXsxelcYuKnCn5xoP1A6xLkWC5lsZEsz5BCMD++lE1is5BHxIhV12k6VyxQNZjjYz
         xkBN8CE5hUkcFODrgFTBdempmHI+eJljIybsYgPseGnqcGA7vVY20jsV8xwPmsz55KOp
         n8Db9TddbsaN9V/Jjay5Jt+vlv3S61n1rvHAJjeEd6/bAjGoBqLt6Tu09Jteb5vvhntM
         rYUqAfTddI2UFmWuvOjPBDh8ty6IRPRmt0E+HNnO5JxgC8wwXN956DRiMB9M3uTu3irp
         stjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=p4c4RaUrI+TqMaMS0f5jfDieCGnmujxFfWD54tCErWQ=;
        b=W4phsjjzwi78QgW/UpZHZfpXfE+2li3e9GQJaXQy54g+7u0dNlm877Axu+YwB7x1Px
         3WpXuQ02Ze2If0G5o+KNVrcInjbGgVMn/Cjaa8AdRodHH3tqqgo6bSTkRg97jp15csgR
         d9/2SZeSErM+XktLZTqilnbP5Uz6T06wsGmAPX1Kyy+YAmXCdHb2I4vIikIo8R9mb4Xi
         YYqMG7Ir8+Sbo5xjC/xLhDhMsSGmrBFoUOCLPS+178rBqVZwUG1Z2BYkAdZ224S+tuHT
         NbKkJhYQRo205mihOQ2aOICGzn8ynwY7alffCeaBQEm9VdhZd++LA3nFc+mXuUJh+HWT
         uhhA==
X-Gm-Message-State: AOAM532/MocxLT1625JwJv45hmleuzeH6XuZTAlRz2WRBVuheKzJ7pI+
        ukmWnCBIwO+4skwrGYldYdXb3jzKb/Bt19/I7i6/4w==
X-Google-Smtp-Source: ABdhPJxBKln6OW5CUh+p8XVdWCrNFIlmaG0qW/jYrglDw2icgQ+C4/nwExMNw/bBptmH18VPUdtZsJCmxrVwZ2fSK1s=
X-Received: by 2002:a05:6512:3150:: with SMTP id s16mr32987083lfi.47.1594395647667;
 Fri, 10 Jul 2020 08:40:47 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Jul 2020 17:40:37 +0200
Message-ID: <CACRpkda48QqW7P9wKghFTk6T9B74drHLSxjQSANgfEFxmgm=Dw@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for the v5.8 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some two pin control fixes for the v5.8
series.

Nothing special about them, please pull them in!

Yours,
Linus Walleij

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.8-3

for you to fetch changes up to f8e99dde21995d185e2379e34ea2b96acf85702b:

  Merge tag 'intel-pinctrl-v5.8-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into fixes
(2020-06-28 01:08:21 +0200)

----------------------------------------------------------------
Pin control fixes for the v5.8 series:

- Fix an issue in the AMD driver for the UART0 group.

- Fix a glitch issue in the Baytrail pin controller.

----------------------------------------------------------------
Hans de Goede (1):
      pinctrl: baytrail: Fix pin being driven low for a while on
gpiod_get(..., GPIOD_OUT_HIGH)

Jacky Hu (1):
      pinctrl: amd: fix npins for uart0 in kerncz_groups

Linus Walleij (1):
      Merge tag 'intel-pinctrl-v5.8-2' of
git://git.kernel.org/.../pinctrl/intel into fixes

 drivers/pinctrl/intel/pinctrl-baytrail.c | 67 +++++++++++++++++++++++++-------
 drivers/pinctrl/pinctrl-amd.h            |  2 +-
 2 files changed, 54 insertions(+), 15 deletions(-)
