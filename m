Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2A420A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593725968;
	bh=xe9nQIr35mMCn3c7wpvqZxc+cExtXSyGYE78Yrb49lw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FUC3X1KUAcWRYCFiUQZJMdlA6LZVGAo0W6pPXYT8EeubnjvSDVl69lxWIzHavwxkI
	 qHRmXCCIwu8XkZpXMtvSwkp6kQzu35PbJZe+TesEb+9NvzjoY8FVLOJfA7JhrMjs0R
	 VB8IrVaUJ4/nUgKcY4xs8YkfhqTlk59HaQ88IbqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGBVj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:39:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37166 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:39:27 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so16797463iob.4;
        Thu, 02 Jul 2020 14:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cnWwGTygPTxavzAiqzY7CKnWVGYSk3pYOsuHvvBZkC4=;
        b=tDfwzChmc4pTzqZWFNLofhX55tvv/H+HFFFVCCm26A0Cv6egEHGWJgIgHwQ15q1oGB
         Yo10PuhJZrYV+mZrbl1tCbF0jdix/rIRXoU0Mq7vIP4AKwOxd1glUGVXRIcDET++TKKI
         4v/LorEBJ7DFrz+lUcB8I0ks9Fk3kY4gUXdD/2ObUNVyvRyL1i9HaDD+DffbqVxfGl2g
         MBjKuTN/nHC5AmbJ59henf6m+LDqKv1DGYEK7oP3mR6zzLmyFc3HpXff11dDhm/dyv0Z
         qKOkvkObdX+clgE2rDnR/z5/YaBCOu4xXYZR/aebAWiFK2IfIQoQ0YyqZtUtC1GZSoMq
         BHfw==
X-Gm-Message-State: AOAM531nlUGqf4u+KVi1WFzRqbPDJMpS9VHnOcw4VHmkC+WvpHmB6fti
        Xf3K9u/bek1xhhwXw5I3Gw==
X-Google-Smtp-Source: ABdhPJz0EK4pTjFCKLhVkHQ9QaNkHSgPeH3K7fHMeNcyRu216PqAp/vuwsnj4NIgwMWaFKovnxTJ8A==
X-Received: by 2002:a05:6602:2f0f:: with SMTP id q15mr9550599iow.23.1593725966373;
        Thu, 02 Jul 2020 14:39:26 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v5sm4990834ios.54.2020.07.02.14.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 14:39:25 -0700 (PDT)
Received: (nullmailer pid 1769713 invoked by uid 1000);
        Thu, 02 Jul 2020 21:39:24 -0000
Date:   Thu, 2 Jul 2020 15:39:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.8, v2
Message-ID: <20200702213924.GA1763915@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.8. I wouldn't normally update dtc at this 
point in the cycle, but I've been waiting on fixes to land upstream for 
a while now.

Rob


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.8-2

for you to fetch changes up to 0115e6c98c22f3fc7ff7da2a41480483abe95b37:

  dt-bindings: clock: imx: Fix e-mail address (2020-07-01 16:29:11 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.8, take 2:

- Sync dtc to upstream to pick up fixes for I2C bus checks and quiet
  warnings

- Various fixes for DT binding check warnings

- A couple of build fixes/improvements for binding checks

- ReST formatting improvements for writing-schema.rst

- Document reference fixes

----------------------------------------------------------------
Fabio Estevam (5):
      dt-bindings: usb: aspeed: Remove the leading zeroes
      dt-bindings: display: arm: versatile: Pass the sysreg unit name
      dt-bindings: thermal: Remove soc unit address
      dt-bindings: thermal: k3: Fix the reg property
      dt-bindings: clock: imx: Fix e-mail address

Flavio Suligoi (1):
      doc: devicetree: bindings: fix spelling mistake

Kangmin Park (1):
      dt-bindings: mailbox: zynqmp_ipi: fix unit address

Masahiro Yamada (4):
      dt-bindings: bus: uniphier-system-bus: fix warning in example
      dt-bindings: fix error in 'make clean' after 'make dt_binding_check'
      dt-bindings: do not build processed-schema.yaml for 'make dt_binding_check'
      dt-bindings: copy process-schema-examples.yaml to process-schema.yaml

Mauro Carvalho Chehab (5):
      dt: update a reference for reneases pcar file renamed to yaml
      dt: fix broken links due to txt->yaml renames
      dt: Fix broken references to renamed docs
      dt: fix reference to olpc,xo1.75-ec.txt
      docs: dt: minor adjustments at writing-schema.rst

Rob Herring (1):
      scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c

 Documentation/devicetree/bindings/Makefile         | 38 +++++++++++++++------
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  2 +-
 .../bus/socionext,uniphier-system-bus.yaml         |  4 +--
 .../devicetree/bindings/clock/imx27-clock.yaml     |  2 +-
 .../devicetree/bindings/clock/imx31-clock.yaml     |  2 +-
 .../devicetree/bindings/clock/imx5-clock.yaml      |  2 +-
 .../devicetree/bindings/display/bridge/sii902x.txt |  2 +-
 .../bindings/display/imx/fsl-imx-drm.txt           |  4 +--
 .../devicetree/bindings/display/imx/ldb.txt        |  4 +--
 .../display/panel/arm,versatile-tft-panel.yaml     |  2 +-
 .../bindings/display/rockchip/rockchip-drm.yaml    |  2 +-
 .../bindings/gpio/mediatek,mt7621-gpio.txt         |  2 +-
 .../bindings/interrupt-controller/csky,mpintc.txt  |  2 +-
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   |  2 +-
 .../devicetree/bindings/misc/olpc,xo1.75-ec.txt    |  2 +-
 .../devicetree/bindings/net/mediatek-bluetooth.txt |  2 +-
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  2 +-
 .../devicetree/bindings/sound/audio-graph-card.txt |  2 +-
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  2 +-
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt |  2 +-
 .../bindings/thermal/thermal-sensor.yaml           |  2 +-
 .../devicetree/bindings/thermal/thermal-zones.yaml |  2 +-
 .../bindings/thermal/ti,am654-thermal.yaml         |  2 +-
 .../devicetree/bindings/timer/csky,mptimer.txt     |  2 +-
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   |  4 +--
 Documentation/devicetree/writing-schema.rst        |  9 +++--
 Documentation/mips/ingenic-tcu.rst                 |  2 +-
 MAINTAINERS                                        |  8 ++---
 scripts/Makefile.lib                               |  7 +++-
 scripts/dtc/checks.c                               | 39 ++++++++++++++++++++--
 scripts/dtc/dtc.h                                  | 31 +++++++++++++++++
 scripts/dtc/flattree.c                             |  2 +-
 scripts/dtc/libfdt/fdt_rw.c                        |  2 +-
 scripts/dtc/libfdt/fdt_sw.c                        |  2 +-
 scripts/dtc/libfdt/libfdt.h                        |  8 +++++
 scripts/dtc/treesource.c                           |  8 ++---
 scripts/dtc/version_gen.h                          |  2 +-
 scripts/dtc/yamltree.c                             |  6 ++--
 38 files changed, 159 insertions(+), 61 deletions(-)
