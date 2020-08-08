Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0CCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A5F20716
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa5KBSWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHHQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHHQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:06:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409EC061756;
        Sat,  8 Aug 2020 09:06:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so5171996ejc.2;
        Sat, 08 Aug 2020 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yV0nxDJVpKaDI8NMLiY0hoFo/m2FGLWPL6IB8rVSdIc=;
        b=Sa5KBSWnEhK0L9uO837LP+k2wvdXuZ0c+eR9tnhbAFtSPptlZk3Rc60UxtDxV+elTb
         7FGodum6ZSrKruZXfs/OckbWDgtEu2Rz9TNnRVF3iT1nvsxuHzGM2RwVmaVQkpLHAz7X
         QJMXFXYpMMSfxnOteMI0EauPJSHnamcPsp3+mWzfYowD3pZEwgO3zht7OPp4UBLj622c
         63OSM8tFX1D7dJkWXp1gV0XsAiIn1hk5Wqfwf9wXHDhgkKnaDch1SwWDWkJILt4iR/o5
         9KHKlqUGhIF0E1dCOMtxl4/UIsNceUbhbxFb+CCLTenRFvld4WTCn3jRh22sIBK42P0o
         Atuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yV0nxDJVpKaDI8NMLiY0hoFo/m2FGLWPL6IB8rVSdIc=;
        b=IylN3FCWf1Zocut3KKAifsfKk07HmsgAD/gNWYEwZhs8WC4h7wScZlja61rqkSsjoj
         0mMw2XMhTv6sCMKggPHyGy03bBybePixN1Rzc3E0ct3KKpj5fUoFeVyANS9bI7GLpvzH
         PlpQqDmTOybn9zctxUNKd0bxg3yv5WiVerAhTUPhy0RYN5Fn1K3H4HAaGqiusPuLqDOA
         VypIrXUUj8aLEMNuJYu7hKwF5Un+k6AXM4bVYXYMSU7SoX6SBCshyoCaOakT/o9veIGR
         qvpE85voOXGguKWE0+dgs0YM2bSFGaZv+AVTHueJ494P3+XO+blREPIs2cxmTSzXq7z9
         Bxpw==
X-Gm-Message-State: AOAM532c+SF+7Jkxre2fXdOV+FyHN0DbtORH6cHrNaglRvFM7VWQj8k4
        wf3uvWT0X9dzibkZaR41hKk=
X-Google-Smtp-Source: ABdhPJz/AR9tGTIS1ckJIHI/lnu5rdm81ZYbf5UqmBiK8JlZ9JatrM4qM5Q6zj5GJDhUbohzS2Kblg==
X-Received: by 2002:a17:906:b248:: with SMTP id ce8mr14013718ejb.85.1596902786508;
        Sat, 08 Aug 2020 09:06:26 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k24sm8404338ejz.102.2020.08.08.09.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 09:06:26 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] rk3318 A95X Z2 board
Date:   Sat,  8 Aug 2020 18:06:15 +0200
Message-Id: <20200808160618.15445-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rk3318 A95X Z2 board.

What works:
 adc key
 emmc
 ethernet
 hdmi
 gpu
 ir
 mmc
 sd card
 vop
 usb2
 uart2

Not tested:
 av
 uart0 / bt
 spdif
 wifi

No support in mainline:
 usb3 (works with manufacturer driver)
 front display (works with custom gpio driver AD1628/HT1628)

Problems:
 U-boot only starts on emmc, then loads kernel from sd card or emmc.

 Hdmi hotplug detects DVI modes, but marks them all BAD.
 The dw-hdmi driver needs more pre_pll_cfg_table entries.
 Slow boot behavior. Screen available way after boot. (no penguins)

 GPU support for Debian is not up to date. (old version)
 Use Github version instead.
 Test with glmark2-es2-drm gives glmark2 Score: 29
 Kernel log:
  lima ff300000.gpu: pp pp0 reset time out
  lima ff300000.gpu: pp pp1 reset time out
 No mainline support for GPU thermal and voltage to frequency.
 PWM1 supply connected to DMC, GPU and vcodec.

 The box only has a model name. Vendor prefix not verified.

 Etc.

Changed V3:
  add acked by
  change adc-keys
  change regulator
  change SPDIF
  rebase
  remove disable-wp
  remove pinctrl-names
  remove vcc_phy
  use label u2phy

Changed V2:
  add vendor prefix
  changed compatible string
  changed led active high to active low
  removed usb3 regulator node
  restyle

Johan Jonker (3):
  dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co.,
    Ltd.
  dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
  arm64: dts: rockchip: add rk3318 A95X Z2 board

Johan Jonker (3):
  dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co.,
    Ltd.
  dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
  arm64: dts: rockchip: add rk3318 A95X Z2 board

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    | 374 +++++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts

--
2.11.0

