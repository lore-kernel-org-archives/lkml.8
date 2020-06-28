Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F58206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 20:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgF1UCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 16:02:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgF1UCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 16:02:16 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MirX2-1jCypv0NTo-00esnp for <linux-kernel@vger.kernel.org>; Sun, 28 Jun
 2020 22:02:15 +0200
Received: by mail-qk1-f176.google.com with SMTP id e11so13570146qkm.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 13:02:14 -0700 (PDT)
X-Gm-Message-State: AOAM530EbxYN3zHWl1o+/zk2MmxO5kSxx46ZCD466K6ZD4RiDLFmeiY/
        9eRylSlCkOkP4E3b2q8reoyIql+0IcYMr96SHIY=
X-Google-Smtp-Source: ABdhPJzBCIjRvmQIbtbEh2g4dH0/7a+XjzxTkT8QElHw7HsO824oSarvDU+GzI20QY5soDruBzWUXc8JniRCY6FQ2Qo=
X-Received: by 2002:a37:a496:: with SMTP id n144mr12189581qke.286.1593374533846;
 Sun, 28 Jun 2020 13:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1rUGkoHanEGfc+o8bjgZO=T-40-e-wy+ECLxuU_pT97A@mail.gmail.com>
 <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
In-Reply-To: <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Jun 2020 22:01:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
Message-ID: <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
Subject: [GIT PULL 2/2] ARM: OMAP fixes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:daNrC5pYgMjHx5Z8ebhm/LP9VLZNgR3/jT9YhWtk5r+WJYJSxLb
 eQAtuR7I22AA8Op2qrg4KHRvoFbaYqZB81WYimtHeVr3J6DP/nfmM1bFiTwPjelqUF68zZp
 srMNkTEx92i8CBYIMDINN+u1OJKNb0jS9wq9/gwQz9h9lEioF0ID/U6wYdnTvhxyjabyXMW
 wWzE5sSxdy6kf8XXyfmIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bbaUj8/yYwA=:yx7ZXhw5e7KaDZZH9ajqTu
 BEwSlIfoDxW9VCmZz9VKSWIX3uK+41V/kgYZxrNurp2ndVyLf0AahS72Bvg1qVK81dzwQXzzT
 kCwf1Ua+71c4hqWTnmoMwENgOKeFK5ftvNQgPccldLTVDS9aqce8UzTvMA4BT/hG2E9Ft0Xg1
 npHpCMKvfW+myR+5nwJRAkYKOB26sP/M97q2VtL5IYZ7IRDv860+dlLCPdqFAdX7itIh5qToM
 v4hPVoQ6jl88ix+gUVVrUNk7+kLz+RQul8bESr3c8k0J5PxRP7fBEmokLeGY7+c2mi86Gttyt
 xn1u/Dh1qwCWTbh8OFLoBdWx1YLaUD/tmXbViJrKe8udPKRN7O/QzTrrPumFuRV9r9AA0bih1
 VDLgDuWW9DqT3G6oH/owh6LPXuxH2s9oouz8Y0lD8X5u6q9niUGsGV7oOHtbnAGMRjs+/yJrU
 q6sr0EOK/HKqFejLdtjlEIFbqZt79Js8yMzz3OSPo0aVlxc5mZtmIX86ou7bSHxh3O3E2Qh0J
 CI/beHzRXrP8nE+9owr4oevP5YWaQ0jlk0yC/9DJVOWbs63h0FRBJb63VX3gfb7qTGsOO/W/P
 lDhZb4sxIUjZ1hfE9aXJqpUpYt3DMRNSBhNCNGlhBAN9S7dEQ0DXOtc9NDoPBLPYRMDztNNrM
 p1KjyGkqPt3uctfiPck+vRm8SG/1LwtZUi1jdpOg7RA3fMFL5YXu57848B0zfuKWTNyd51hs0
 7mtRq9ZJ+ut4l6wv8YdQB8SU3sSZr/PpWzMUQGPl1+kCHlkbc4FlIbCvr+ViDA7xz3QVxaREy
 z87jm0qjzTxG+Y2AysiWfgeIN6+vw+nFTJRCMtEtER2uQ5irMg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/arm-omap-fixes-5.8-1

for you to fetch changes up to d528945d7762be94beca4c111bb95dcc9a9f39c0:

  Merge tag 'omap-for-v5.8/fixes-rc1-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/omap-fixes (2020-06-28 14:45:08 +0200)

----------------------------------------------------------------
ARM: OMAP fixes for v5.8

The OMAP developers are particularly active at hunting down regressions,
so this is a separate branch with OMAP specific fixes for the v5.8:

As Tony explains
 "The recent display subsystem (DSS) related platform data changes
  caused display related regressions for suspend and resume. Looks like
  I only tested suspend and resume before dropping the legacy platform
  data, and forgot to test it after dropping it. Turns out the main issue
  was that we no longer have platform code calling pm_runtime_suspend
  for DSS like we did for the legacy platform data case, and that fix
  is still being discussed on the dri-devel list and will get merged
  separately. The DSS related testing exposed a pile other other display
  related issues that also need fixing though":

 - Fix ti-sysc optional clock handling and reset status checks
   for devices that reset automatically in idle like DSS

 - Ignore ti-sysc clockactivity bit unless separately requested
   to avoid unexpected performance issues

 - Init ti-sysc framedonetv_irq to true and disable for am4

 - Avoid duplicate DSS reset for legacy mode with dts data

 - Remove LCD timings for am4 as they cause warnings now that we're
   using generic panels

Other OMAP changes from Tony include:

 - Fix omap_prm reset deassert as we still have drivers setting the
   pm_runtime_irq_safe() flag

 - Flush posted write for ti-sysc enable and disable

 - Fix droid4 spi related errors with spi flags

 - Fix am335x USB range and a typo for softreset

 - Fix dra7 timer nodes for clocks for IPU and DSP

 - Drop duplicate mailboxes after mismerge for dra7

 - Prevent pocketgeagle header line signal from accidentally setting
   micro-SD write protection signal by removing the default mux

 - Fix NFSroot flakeyness after resume for duover by switching the
   smsc911x gpio interrupt to back to level sensitive

 - Fix regression for omap4 clockevent source after recent system
   timer changes

 - Yet another ethernet regression fix for the "rgmii" vs "rgmii-rxid"
   phy-mode

 - One patch to convert am3/am4 DT files to use the regular sdhci-omap
   driver instead of the old hsmmc driver, this was meant for the
   merge window but got lost in the process.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (3):
      Merge tag 'omap-for-v5.8/fixes-merge-window-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'omap-for-v5.8/dt-missed-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/omap-fixes
      Merge tag 'omap-for-v5.8/fixes-rc1-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/omap-fixes

Drew Fustini (2):
      ARM: dts: am335x-pocketbeagle: Fix mmc0 Write Protect
      ARM: dts: am5729: beaglebone-ai: fix rgmii phy-mode

Faiz Abbas (1):
      ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver

Oskar Holmlund (2):
      ARM: dts: Fix am33xx.dtsi USB ranges length
      ARM: dts: Fix am33xx.dtsi ti,sysc-mask wrong softreset flag

Suman Anna (2):
      ARM: dts: dra7: Fix timer nodes properly for timer_sys_ck clocks
      ARM: dts: dra7-evm-common: Fix duplicate mailbox nodes

Tero Kristo (1):
      soc: ti: omap-prm: use atomic iopoll instead of sleeping one

Tomi Valkeinen (3):
      ARM: dts: am437x-sk-evm: remove lcd timings
      ARM: dts: am437x-gp-evm: remove lcd timings
      ARM: dts: am437x-epos-evm: remove lcd timings

Tony Lindgren (14):
      bus: ti-sysc: Flush posted write on enable and disable
      ARM: dts: omap4-droid4: Fix spi configuration and increase rate
      bus: ti-sysc: Use optional clocks on for enable and wait for softreset bit
      bus: ti-sysc: Ignore clockactivity unless specified as a quirk
      bus: ti-sysc: Fix uninitialized framedonetv_irq
      ARM: OMAP2+: Fix legacy mode dss_reset
      bus: ti-sysc: Increase max softreset wait
      Merge commit '5390130f3b288db7d67de5e6c29d0de70d327ff0' into fixes-v5.7
      Merge branch 'fixes-v5.7' into fixes
      Revert "bus: ti-sysc: Increase max softreset wait"
      ARM: dts: Fix duovero smsc interrupt for suspend
      ARM: dts: Fix omap4 system timer source clocks
      Merge tag 'v5.8-rc1' into fixes
      Merge branch 'omap-for-v5.8/fixes-rc1' into fixes

 arch/arm/boot/dts/am335x-baltos.dtsi              |  2 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi    |  1 +
 arch/arm/boot/dts/am335x-boneblack-wireless.dts   |  1 -
 arch/arm/boot/dts/am335x-boneblue.dts             |  1 -
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts   |  1 -
 arch/arm/boot/dts/am335x-evm.dts                  |  3 +-
 arch/arm/boot/dts/am335x-evmsk.dts                |  2 +-
 arch/arm/boot/dts/am335x-lxm.dts                  |  2 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi |  2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    |  2 +-
 arch/arm/boot/dts/am335x-pepper.dts               |  4 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |  2 +-
 arch/arm/boot/dts/am335x-pocketbeagle.dts         |  1 -
 arch/arm/boot/dts/am33xx-l4.dtsi                  |  6 +-
 arch/arm/boot/dts/am33xx.dtsi                     |  7 +-
 arch/arm/boot/dts/am4372.dtsi                     |  3 +-
 arch/arm/boot/dts/am437x-cm-t43.dts               |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               | 20 +----
 arch/arm/boot/dts/am437x-l4.dtsi                  |  5 +-
 arch/arm/boot/dts/am437x-sk-evm.dts               | 18 +----
 arch/arm/boot/dts/am43x-epos-evm.dts              | 16 ----
 arch/arm/boot/dts/am5729-beagleboneai.dts         |  2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi            | 20 -----
 arch/arm/boot/dts/dra7-l4.dtsi                    | 34 ++++----
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi    |  4 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts        |  2 +-
 arch/arm/boot/dts/omap4.dtsi                      |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c                  |  2 +-
 drivers/bus/ti-sysc.c                             | 98 +++++++++++++++++------
 drivers/soc/ti/omap_prm.c                         |  8 +-
 30 files changed, 125 insertions(+), 148 deletions(-)
