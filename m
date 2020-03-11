Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F1CC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57042146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdd2sbdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgCKJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:22:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42946 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:22:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id t21so1046440lfe.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FFOIcJ8aA8MC+A81Xp31rj9IpZBEBuoyDecAuyY6Qf4=;
        b=xdd2sbdbLzlr/nvNeuw/etWKTZ9dXOgTeJCcBl/rDbC6k2BtGDtF4fya+FHqGrQSYj
         60GBpnSYiQxlY90g77NId/kKZ+IEUoVyUrd8JX74q2/23WaR+9bO6SsmhHVNYfqheaX2
         SJGWcZgFE4ec+R6wpl9vN10iOZzi9rJNS0z52CKHUEeew4gV1Evm00Un0ja38T4rS98s
         rmDlKEc49WyVAPiHevyCB+6Vw21w/zEEPBUhSVY+kB0198Yxox939yphpGS/Z+CkKuEa
         iyERpwXNh576qjRmgnGFKTr1iT+8obdmfCtq1RWcPpqqvFzvBBHf+WdgJx7WqUW3+OvK
         pqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FFOIcJ8aA8MC+A81Xp31rj9IpZBEBuoyDecAuyY6Qf4=;
        b=QGKJsE/jtBCTYJEZzIrNo43HLgeg+5culIIXw5WdrsJR+Y1FjGKfcfYjJB2PGdh6Zl
         jGY3I2uJq/6A6FMILg6/V+X0I582pehJXr7N3Dj/USg1WA0IvkYIP4m0IbVSYAKkPEDU
         PYDribogZIaBa+/Ufx5X4i9GgHC+eixcghnq3pZk8+5TkyJ3wZKM42xLeW3ukr60tZCU
         4PAx3tNju7bDaz6vWLEQVzMqSFDxVCIPBJNPt766U6LkKVvW/dvsYodx3zqgCSfhDF4l
         c0tHHhgI7ZGSJ71eZAIn/gfbGwcZXyXYlsiv+KuwSEOetP+BLy+ovZukp7q4GRUDmMBS
         /bvg==
X-Gm-Message-State: ANhLgQ1xQ+Dd2S6nWznerYC1XGJLc3L75NWhMoZNpcj4IQ12jhOl86uq
        oackbpyp8Aqje6V/Qqul0bdburHWCnRUCHtvEcsBcxE8Z2RK2g==
X-Google-Smtp-Source: ADFU+vtB2lW6BTUCdwkuQqNNimAuA5Ox6/OlefcUhjx2f4403d6W229KlOQE588qAuFLnoqg7laaGbEjv0ck85D61VY=
X-Received: by 2002:a19:c18e:: with SMTP id r136mr1524001lff.4.1583918573645;
 Wed, 11 Mar 2020 02:22:53 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Mar 2020 10:22:42 +0100
Message-ID: <CACRpkdYZbx_3AgtTYSwtBcr0G4PisWt8As=T7nqq60rTPXjYCA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some pin control fixes for the v5.6 series.
It comes down to memory leaks in the core and
driver fixes. Some should have been sent earlier
but they kept piling up and the world is just so full
of distractions these days.

Please pull it in.

Yours,
Linus Walleij

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.6-2

for you to fetch changes up to 1cada2f307665e208a486d7ac2294ed9a6f74a6f:

  pinctrl: qcom: Assign irq_eoi conditionally (2020-03-09 16:31:34 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.6 kernel series:

- Fix some inverted pins in the Meson GLX driver.

- Align the i.MX SC message structs causing warnings from
  KASan.

- Balance the kref in pinctrl hogs so they are actually free:d
  when removing a pin control module. We haven't seen it before
  as people don't use modules for pin control that much, I
  think.

- Add a missing call to pinctrl_unregister_mappings() another
  memory leak when using modules.

- Fix the fwspec parsing in the Qualcomm driver.

- Fix a syntax error in the Falcon driver.

- Assign .irq_eoi conditionally in the Qualcomm driver, fixing
  a bug affecting elder Qualcomm platforms.

----------------------------------------------------------------
Charles Keepax (2):
      pinctrl: core: Remove extra kref_get which blocks hogs being freed
      pinctrl: madera: Add missing call to pinctrl_unregister_mappings

Leonard Crestez (1):
      pinctrl: imx: scu: Align imx sc msg structs to 4

Linus Walleij (2):
      pinctrl: qcom: ssbi-gpio: Fix fwspec parsing bug
      pinctrl: qcom: Assign irq_eoi conditionally

Mathias Kresin (1):
      pinctrl: falcon: fix syntax error

Nicolas Belin (1):
      pinctrl: meson-gxl: fix GPIOX sdio pins

 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 13 +++++++++++++
 drivers/pinctrl/core.c                       |  1 -
 drivers/pinctrl/freescale/pinctrl-scu.c      |  4 ++--
 drivers/pinctrl/meson/pinctrl-meson-gxl.c    |  4 ++--
 drivers/pinctrl/pinctrl-falcon.c             |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c           |  3 +--
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c     |  2 +-
 7 files changed, 20 insertions(+), 9 deletions(-)
