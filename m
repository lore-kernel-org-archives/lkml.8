Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6495C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 04:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED0A20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 04:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHHvm2+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgDAEsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:48:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36102 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDAEsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 00:48:09 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so21754039ilp.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yBNtDDyEZFLUMk99HIbSZunA51hK1hAXkAOVSNWlPhE=;
        b=gHHvm2+EYiTjiYnXL9ZQC35zh8qy4MzJo/SxFMKVeirEvOXDfWObiT+GJVmi2tHFH1
         qS8IWcfYxxcJRGfkUR/Tge7RS4pMc6LJa8zxcGgq+Go7O8BsToi+FjD7DQhoYtgWYuj3
         87S6JMzI1P4zTqoH9LUyQ7Od67OL6v6WqlhtnSdG+NGwxuBbWsp8jBqi17h+vvsWWNbv
         YRr5WP/8YHqN/S5Upjusaq+c5k80vXOXzw7/CfPf6a+VGT+6i8edQG0xDqoMLO1GC2wJ
         eleNmILDjveiVyFGQ7bYU5UumjrVsRw8Pd9Yw3T0AEmXh/KID0c12pInY0cynlGPvHwR
         SlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yBNtDDyEZFLUMk99HIbSZunA51hK1hAXkAOVSNWlPhE=;
        b=EMwJqrhVX9ihiguN+nVd+YGzE/+cSaazJtDGpUPw5TgLu7HQQ8n1biVBe0gLxZS/9c
         eq6GyBuOLUjhdL5KKLyL227ceSlHAuBxpfpiAvOglHn8jo94f2/LQ7+VCPJeQ3a4xrVr
         j/a5vSxzeAiocIGy9MET8w9xMmyfkeRcTklp90YSzn+7ahMHV1fZARw0QP37ljzZHj3T
         nCTX63uW2NW1tsWKovmlaRqTmhtGGEgqctPpTWhhRGaEMLBG3xZ3JPmSojA+MP+FObqX
         +BcbT1+g+UJPRJsRLklySv9acbfzYacETsmQXBgXxIDtyvwF17r36Alf+1aYpylvdubk
         49JQ==
X-Gm-Message-State: ANhLgQ217qHlVg7c6c7XYuwH1aw4BpdsLHMt3drILP6+OiLk2sg9m0sM
        hASfFujJSQPjtezgW6X9/ku8xkECXe6AA/A0rDg=
X-Google-Smtp-Source: ADFU+vv3ujcF3LXkt0pbsCBwIDFrWPnbm2URgmFYXVqHOeM458ygbF9LTJKfV6jzpTxLc86+wXzKR4a0/jckOotShuM=
X-Received: by 2002:a92:c787:: with SMTP id c7mr18189425ilk.87.1585716487274;
 Tue, 31 Mar 2020 21:48:07 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 31 Mar 2020 23:47:56 -0500
Message-ID: <CABb+yY0-q+5+pqP-rBHCYpw-LmT+h80+OU26XL34fTrXhO+T3Q@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6c90b86a745a446717fdf408c4a8a4631a5e8ee3:

  Merge tag 'mmc-v5.6-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2020-03-19
12:45:14 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.7

for you to fetch changes up to 0a67003b1985c79811160af1b01aca07cd5fbc53:

  mailbox: imx: add SCU MU support (2020-03-19 23:04:32 -0500)

----------------------------------------------------------------
- imx: add support for i.MX8/8X to existing driver
- mediatek: drop the atomix execution feature, add flush
- allwinner: new 'msgbox' controller driver
- armada: misc: drop redundant error print
- bcm: misc: catch error in probe and snprintf buffer overflow

----------------------------------------------------------------
Bibby Hsieh (3):
      dt-binding: gce: remove atomic_exec in mboxes property
      mailbox: mediatek: implement flush function
      mailbox: mediatek: remove implementation related to atomic_exec

Peng Fan (3):
      dt-bindings: mailbox: imx-mu: add SCU MU support
      mailbox: imx: restructure code to make easy for new MU
      mailbox: imx: add SCU MU support

Rayagonda Kokatanur (1):
      maillbox: bcm-flexrm-mailbox: handle cmpl_pool dma allocation failure

Samuel Holland (2):
      dt-bindings: mailbox: Add a binding for the sun6i msgbox
      mailbox: sun6i-msgbox: Add a new mailbox driver

Takashi Iwai (1):
      mailbox: bcm-pdc: Use scnprintf() for avoiding potential buffer overflow

Tang Bin (1):
      mailbox:armada-37xx-rwtm:remove duplicate print in
armada_37xx_mbox_probe()

 .../mailbox/allwinner,sun6i-a31-msgbox.yaml        |  80 +++++
 .../devicetree/bindings/mailbox/fsl,mu.txt         |   2 +
 .../devicetree/bindings/mailbox/mtk-gce.txt        |  10 +-
 drivers/mailbox/Kconfig                            |   9 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/armada-37xx-rwtm-mailbox.c         |   8 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   2 +
 drivers/mailbox/bcm-pdc-mailbox.c                  |  20 +-
 drivers/mailbox/imx-mailbox.c                      | 288 ++++++++++++++----
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 128 ++++----
 drivers/mailbox/sun6i-msgbox.c                     | 326 +++++++++++++++++++++
 11 files changed, 733 insertions(+), 142 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
 create mode 100644 drivers/mailbox/sun6i-msgbox.c
