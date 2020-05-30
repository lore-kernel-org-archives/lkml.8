Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B314C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5049C207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="it9ROSDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgE3LKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3LKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 07:10:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B72C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 04:10:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z22so1229221lfd.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3zCIMZZqOkqtw8tYA7qkkVDOJkyv5YdgBPoC2XudPdo=;
        b=it9ROSDwskKiDLT8YE6GR5gmZO8qRiITGXfHU/8Y/YtDR7zpIqW1zmT4HHgCbW5Ie2
         1h/HhNqlM5Bqmz2fpdSjaY/gkamEIHk9ZvO+Mb+tUW9xg3Fe+tYEcemsUhJ/Ub7cOGtP
         y/zwwUE0tfGTOGFgrEHUeJlWcBrt8U/da/UUe2e5m3QiTkkoFasegdc4ropGuJuD+tF2
         hZCGg+x3jRWtEPrflfgbKKQibvxKc/vLFoe8rEaD5pHqGeiP6mC7VCp3ohKmV5G4OEyG
         ACwkC2iPHiVU2P9o0PymSyVZbtn84lAzUv2hH9N4jiRQRZNewCPfgrLKHRbzL+WekjHg
         80xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3zCIMZZqOkqtw8tYA7qkkVDOJkyv5YdgBPoC2XudPdo=;
        b=Zj9qYi6khRyLxRMbfx0Yxp5ku/bJit34HDf1mjZRhWtZum4V6/KQ1r3AHW7PkEWKLQ
         WGFlZh9LhVlCjNCxVHd6Rk+dcr77mBzH8MxTGB4JuS8JDnQBmVa7h7jrQKCtyt8WT/WT
         Sm/FVt9yIEGlmx4PaRUdRWHUKZG34RlzewpJaH7CmAkWIiSdxLxIW6/0wkVEWpfRWMNO
         7/nYe7s4ol46YuskNJ9qSd9+j/YnSvKCd0W8c5L6gR4+yFNcpDXYHsX8Sj1wIJ8p1Fbt
         nn8D+njiY5u75ziiTTXtXQ1TiHo/eATR3e/HNMe+PN9TsxEgF82GoREaCGp14EW7Fvsa
         GNaw==
X-Gm-Message-State: AOAM532igE5M4edwGTYOCoRvXWmrTwgwquKUG4W1OfaVDklvNOtgtl5q
        PBs1DfWEddxnMpek1tlHnDA69jK3Ymlp7vuolk4hPQ==
X-Google-Smtp-Source: ABdhPJzOXC4tWnBw9pLoCQCIx1Vcb9BdODA2t/626/hppIuTdlPL29VLS4IMkMnbcyrZJXuTlrDQ2EfFj6hbHa+qmcI=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr6557879lft.194.1590837007857;
 Sat, 30 May 2020 04:10:07 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 30 May 2020 13:09:56 +0200
Message-ID: <CACRpkdY0are=TC79q_4vP9R1tzSjRU4aiqOGd1-5CXDbhpMj0A@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some (very) late fixes for GPIO, none of them very
serious except the one tagged for stable for enabling IRQ on
open drain lines.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.7-3

for you to fetch changes up to e9bdf7e655b9ee81ee912fae1d59df48ce7311b6:

  gpio: fix locking open drain IRQ lines (2020-05-29 14:01:49 +0200)

----------------------------------------------------------------
GPIO fixes for the v5.7 series:
- Fix proving of mvebu chips without PWM
- Fix errorpath on ida_get_simple() on the exar driver
- Notify userspace properly about line status changes
  when flags are changed on lines.
- Fix a sleeping while holding spinlock in the mellanox
  driver.
- Fix return value of the PXA and Kona probe calls.
- Fix IRQ locking of open drain lines, it is fine to
  have IRQs on open drain lines flagged for output.

----------------------------------------------------------------
Axel Lin (1):
      gpio: mlxbf2: Fix sleeping while holding spinlock

Bartosz Golaszewski (1):
      gpiolib: notify user-space about line status changes after flags are set

Linus Walleij (3):
      Merge tag 'gpio-fixes-for-v5.7-rc6' of
git://git.kernel.org/.../brgl/linux into fixes
      Merge tag 'gpio-fixes-for-v5.7' of
git://git.kernel.org/.../brgl/linux into fixes
      gpio: fix locking open drain IRQ lines

Sascha Hauer (1):
      gpio: mvebu: Fix probing for chips without PWM

Takashi Iwai (1):
      gpio: exar: Fix bad handling for ida_simple_get error path

Tiezhu Yang (2):
      gpio: pxa: Fix return value of pxa_gpio_probe()
      gpio: bcm-kona: Fix return value of bcm_kona_gpio_probe()

 drivers/gpio/gpio-bcm-kona.c |  2 +-
 drivers/gpio/gpio-exar.c     |  7 +++++--
 drivers/gpio/gpio-mlxbf2.c   |  6 +++---
 drivers/gpio/gpio-mvebu.c    | 15 +++++++++------
 drivers/gpio/gpio-pxa.c      |  4 ++--
 drivers/gpio/gpiolib.c       | 26 ++++++++++++++++++++++----
 6 files changed, 42 insertions(+), 18 deletions(-)
