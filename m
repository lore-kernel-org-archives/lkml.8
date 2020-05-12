Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C6C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A46C206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+TbK+SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgELI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729241AbgELI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:29:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B61C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:29:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g1so6702579ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yKjBrHMVrYH11njH9u5nD+okiu5q1SOdbCQwts/no00=;
        b=m+TbK+SZq+zPcB/7S4UMMKdG7yj1h8fj/nsg36jNwxcjebDpBPaO2Aa0Bq8kA69uLM
         63oV5O21HAJuCgAchgNuMmPC3hNa3RMLLE1sOEd8Dw49wRhENvrW6lqDWsY5BgIIXGzo
         F/LMFiFEL0qjnEPnnZjCYxabFo1TI5YDV04tgmglaC22X46owly1HwbO232aAeX6E8s3
         JSJnKe7kqt/UC2aFM3dTTjGJaBfSidGXxWZi8wTfTsqZJEHVXRAPDoC5md1q9driUmO2
         9l7/dZMC9uLOub23fVrqZwCHHB2lg1HAGF2zZbgMp1jCmG7zU0uVGEGNLHzlISGJRS60
         XV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yKjBrHMVrYH11njH9u5nD+okiu5q1SOdbCQwts/no00=;
        b=t1XDcTqNDnreRHoOTiI+hfhFEdr8aJsi+9NX6SwXeMQXv5UBeV4qc/F6orrks8VWs6
         z6Wk/m3pZzNjGbrrgeoKUM6Gdxr9Rb/CNlISD7OwRyHePIf4tlJrY4dcdhBe/tApcEFS
         hgKQeeMlwF1E+R3N9mKOl/awSJw5UFZshq10dcHyKigwFKzZJJmjcDf/bGXhXZ8aa1YV
         EgLothDWQGEkbgw8UU9wzt1KZILQdEpDrsO9bEej22o2f/O/wXDyAQ5dmg+s3LaiJ6pS
         CtMBM6LCt0ta8N8YGEn2FXAoYoIjsIyy5koOiyRAoH5knVxgT/mbXp7Il65AsQ2pwA+l
         W8Kw==
X-Gm-Message-State: AOAM530fxO5yDnIjg2eYJ+l3I+/jMzGXkgBwkC+sh+wkeCe4xZqs9WdW
        XUiTEYwi4vO/3TCQIttZh/2fFXCFb3Jo1Qh6cIhmug==
X-Google-Smtp-Source: ABdhPJyN3Q0EKdr+y6yVrRivbVl+fbwgrsuJQCdxpprQWH9cmGf+3VhzPRFPlhf9aER7AtwepwLVT1CnNjV6YBOqzrM=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr12698843ljg.258.1589272142969;
 Tue, 12 May 2020 01:29:02 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 10:28:50 +0200
Message-ID: <CACRpkdafEGdhvn9kgBp7SAXw=JwqWRRoHu9CmytcWGeOYoixzQ@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.7 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some GPIO fixes for v5.7, slightly overdue. Been learning
MMUs and KASan that is why it's late. Bartosz helped me
out, luckily!

Details are in the signed tag, please pull it in!

Yours,
Linus Walleij

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.7-2

for you to fetch changes up to 0cf253eed5d2bdf7bb3152457b38f39b012955f7:

  gpio: tegra: mask GPIO IRQs during IRQ shutdown (2020-04-28 16:22:33 +0200)

----------------------------------------------------------------
Some GPIO fixes for the v5.7 kernel:

- Fix pin configuration in the PCA953x driver.
- Ruggedize the watch/unwatch ioctl().
- Possible call to a sleeping function when holding a spinlock,
  avoid this.
- Fix UML builds with DT overlays.
- Mask Tegra GPIO IRQs during shutdown().

----------------------------------------------------------------
Adam Ford (1):
      gpio: pca953x: Fix pca953x_gpio_set_config

Bartosz Golaszewski (2):
      gpiolib: improve the robustness of watch/unwatch ioctl()
      gpiolib: don't call sleeping functions with a spinlock taken

David Gow (1):
      gpio: of: Build fails if CONFIG_OF_DYNAMIC enabled without CONFIG_OF_GPIO

Linus Walleij (1):
      Merge tag 'gpio-fixes-for-v5.7-rc3' of
git://git.kernel.org/.../brgl/linux into fixes

Stephen Warren (1):
      gpio: tegra: mask GPIO IRQs during IRQ shutdown

 drivers/gpio/gpio-pca953x.c |  2 +-
 drivers/gpio/gpio-tegra.c   |  1 +
 drivers/gpio/gpiolib.c      | 34 +++++++++++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 6 deletions(-)
