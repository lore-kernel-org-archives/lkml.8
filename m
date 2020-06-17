Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9191C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F98212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PryyyjFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgFQIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:32:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7AC061573;
        Wed, 17 Jun 2020 01:32:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so989370wmh.2;
        Wed, 17 Jun 2020 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYXfB59fPQDlFcXuo8zxtQHZv3hIurEgpslwSQ3bg0g=;
        b=PryyyjFbDAS9EzmjVI41kpyATdPbHhz/0JmJofQpBQq+ZaopE7G1PnmpFncA6Be7Kp
         PBRBDnciHIJwnTaTHhlzKtDtFJubXYmuqXatwNpZSiSPcOAFtMt6ZIksKbSQSfMhopoX
         XfguOfs231Az8gfEpqLs2VhR2JvajVay06s6bVLggdsQ8C7AaenmxhAoIlqCnHf/+4iI
         IBHRmJjSIxJ3QISbyoMc1QMbEyVENOUmAm5lkDWeWBp2mawFkPIWoNEmuApJTC3/z2RT
         F2zWMdXM7AUk3v8iF9nZMhpUnNl5lytCWH878yHh/5daFvYI12mCiMNt1Ilpu1hi9ExD
         NW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYXfB59fPQDlFcXuo8zxtQHZv3hIurEgpslwSQ3bg0g=;
        b=KhYMcc3UPBm7GwKaC7D2IZXvCidQihQ4KQkmAySdk3Itkay9ELT2TC96aKEVA3LOVz
         aN5elyLF3c4pv3zt4siQ1mZbbFVbsxqdfPhSBsQyN+UU6favuusYT2oBvvQhmL2syyru
         Msu4JHa/KyttMs024hELBLTUpumEzfatFCxXm2ARTQX1AjjTxjvtpvXI5GxqtD4ieTGI
         HrI49bLEIV6wEOBg3qGxwUhzEQkX+ltqIkslpcBk4xH+a3aT7W6keQ7GSuNJomehGHvw
         isaO16b27dVeIT5/Ed2SwY4o68WljjH2mnJJkVuNVt+42+MPm8/DefOJRYePN0F7edDc
         RW+g==
X-Gm-Message-State: AOAM532D851/IP5zQOou7nmFw/KCynXY7tgYeCcnAEqNaNsS1bE754Xx
        33nsMISkQqcMjWc9WvWkFI+WdsrTUiU=
X-Google-Smtp-Source: ABdhPJwLhUdAfemFl7EvEQyVvi2yWMNNLPTUeIKLd+yg61FmsFRwqZA0IJpB6XubODJXNO9EpTBrIQ==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr7197016wmi.0.1592382755991;
        Wed, 17 Jun 2020 01:32:35 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a16sm32596863wrx.8.2020.06.17.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:32:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v6 0/9] bmips: add bcm6345 reset controller support
Date:   Wed, 17 Jun 2020 10:32:22 +0200
Message-Id: <20200617083231.3699090-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6: fix BCM6318_RST_HOSTMIPS value (12 vs 11).
    driver improvements:
      - use devm_platform_ioremap_resource.
      - simplify bcm6345_reset_probe return.
      - introduce and use to_bcm6345_reset function.
v5: fix kbuild robot error (drop __init).
v4: fix device tree bindings documentation.
v3: using reset-simple isn't possible since sleeping after performing the
    reset is also needed.
    Add BCM63268 and BCM6318 support.
v2: add compatibility to reset-simple instead of adding a new driver.

Álvaro Fernández Rojas (9):
  mips: bmips: select ARCH_HAS_RESET_CONTROLLER
  dt-bindings: reset: add BCM6345 reset controller bindings
  reset: add BCM6345 reset controller driver
  mips: bmips: dts: add BCM6328 reset controller support
  mips: bmips: dts: add BCM6358 reset controller support
  mips: bmips: dts: add BCM6362 reset controller support
  mips: bmips: dts: add BCM6368 reset controller support
  mips: bmips: dts: add BCM63268 reset controller support
  mips: bmips: add BCM6318 reset controller definitions

 .../bindings/reset/brcm,bcm6345-reset.yaml    |  37 +++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi         |   6 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi          |   6 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi          |   6 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi          |   6 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi          |   6 +
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-bcm6345.c                 | 132 ++++++++++++++++++
 include/dt-bindings/reset/bcm6318-reset.h     |  20 +++
 include/dt-bindings/reset/bcm63268-reset.h    |  26 ++++
 include/dt-bindings/reset/bcm6328-reset.h     |  18 +++
 include/dt-bindings/reset/bcm6358-reset.h     |  15 ++
 include/dt-bindings/reset/bcm6362-reset.h     |  22 +++
 include/dt-bindings/reset/bcm6368-reset.h     |  16 +++
 16 files changed, 325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
 create mode 100644 drivers/reset/reset-bcm6345.c
 create mode 100644 include/dt-bindings/reset/bcm6318-reset.h
 create mode 100644 include/dt-bindings/reset/bcm63268-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6328-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6358-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6362-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6368-reset.h

-- 
2.27.0

