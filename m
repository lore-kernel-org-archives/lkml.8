Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D4C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA420740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knqpvRSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:00:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44150 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgCYTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:00:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so3687421lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 12:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zlA6YBylA5M0mOiSW9L4RZATO8uQW1547KHnBaE+ghE=;
        b=knqpvRSgG9yGm0bcVOsMEg3LvVRUbyXthnu83i4ti20kLguZ/KlzQkdTfjqia6bIDH
         RqmJAe/OyUbdof6Ow8OxSSoOQzMiY4DGsWxQB65pNrqfxeUNzYsSVgQoJawSSjs9De+V
         PuDskXXM6Iz+hplJaWkpRXl6GJI0o8Y4HzpHQrUOoTKuHA9Q55T8ulUKTSrSRL2hTuZq
         +PmnqOgkf4QH36m6JaQ+rl2dQ64wkVJMANXDA7BBpm9RD9l5c17ORPRuLKOIIywYd9RX
         e7EWrwiv8CmRvN3qKfFI39QafKyjFAB/p+bE0T6BzgjT2o5YeRq8aTZt+GoTbzdHHVxx
         rWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zlA6YBylA5M0mOiSW9L4RZATO8uQW1547KHnBaE+ghE=;
        b=Rzbn3RmMsx5GMwexng78hWpLXjnSLaVUS+fkY+hIG7xJ4M/1c0mMxnp+rBYMLAOa3q
         3/ByK1ruN95LQ0+HJwp3PrJMOZuw8IZ8eq6AkP8SJGEcQNuZPOpA8D/8sz8oa/4D+iFd
         PkMHJoWcq6qgYn1d2knTT+hBlGiqePwChsoqZg2pq0vhY7eXU2mpEkrrQkyjgeWcmFZV
         pyxW8BPQowy7Qp4gemwUjD8J+5z3gxEZ9RGC8hv4hG41LDghqaZeIxRULiCE6RSBPUDU
         mmoH8MRdD+2bbmFRmtrf0qXPMx2wnE02gTxdU9wTwOghlKuMuiPEHOrr7+lez1NG/MT+
         Sasg==
X-Gm-Message-State: AGi0PubT1G9k2DFMnYEtRz3/h9lhQeqF9EDq5mKdUPMzHsFD7hOSLi4k
        mZ7nJeIQ6ORj9nuSADTvkzAdTBS87C2IFaY6fTHJAw==
X-Google-Smtp-Source: ADFU+vu0U/GoBhKGNLp7JbO4SycFKqeluj/hk+w11ceallgxqj/4DRnGJYVsYhboVT3+cb41AjXCTc6AVCyjPssN6vg=
X-Received: by 2002:a05:651c:1026:: with SMTP id w6mr2801452ljm.168.1585162825609;
 Wed, 25 Mar 2020 12:00:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Mar 2020 20:00:14 +0100
Message-ID: <CACRpkdY8d=zG-z0Ju7k3Suj+seiexAdyQezcMxWV5rKHJhE3+Q@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some additional GPIO fixes for the v5.6 series.

Sorry that it is coming in late, we had some issues with retagging
one of the patches due to problems in -next but overall it is just
bad timing and me being a bit snowed under.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.6-3

for you to fetch changes up to 0c625ccfe6f754d0896b8881f5c85bcb81699f1f:

  gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 CHT +
AXP288 model (2020-03-24 10:06:54 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.6 series:

- One core quirk by myself to fix the .irq_disable()
  semantics when the gpiolib core takes over this callback.

- The rest is an elaborate series of 4 patches fixing Intel
  laptop ACPI wakeup quirks.

----------------------------------------------------------------
Hans de Goede (4):
      gpiolib: acpi: Correct comment for HP x2 10 honor_wakeup quirk
      gpiolib: acpi: Rework honor_wakeup option into an ignore_wake option
      gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 BYT +
AXP288 model
      gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 CHT +
AXP288 model

Linus Walleij (1):
      gpiolib: Fix irq_disable() semantics

 drivers/gpio/gpiolib-acpi.c | 140 ++++++++++++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.c      |   9 ++-
 2 files changed, 122 insertions(+), 27 deletions(-)
