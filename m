Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A96820720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I/eaN9xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgFVJl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFVJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:41:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3AC061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so2480358wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JOFF+Nl1qiIhM1iOj4oCorX86E5B7hR8kg9WCnzUnw=;
        b=I/eaN9xrQqwwgmhuM+4CqaeHsY6aV60kH8mKn4OebmUYtK7pNQK0wVGunsLFglKTAy
         eUfthcd2EIQ1C+6upxc/23ua64/60kfHPQMRmNReX5PP2rqNblnCuw0jNW6ITtVZgxqW
         JMjW13bHUWbsnkuYKGTXldz63/aT5JAfKOHfJsdcPLDI6CaCjZlEVCVN1/cNK9IA3bVM
         sWSBmTqNhgt/nNmxR0EvpDrZ4oceKA+bx2hJY0Lo1o/pDYzIwKGHfLU+2NxtIdO7LXgx
         9KJhrZfL7yYB7s5BDFwVOlo/2O7aGyMMJ8C/qk+ipYeZOh/5oEPkN+TeTC0+JThrTbg7
         00hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JOFF+Nl1qiIhM1iOj4oCorX86E5B7hR8kg9WCnzUnw=;
        b=Fj/WCk+v/B4CXrXls+PiuSGf14IREVYnmxWt3kU7aV58U9o9yzW3/mtafwza1n58hN
         OiWLDFUckUbzDtOaLEEfvekWu2A5pZXiyrhlw5qdBoaDnXNpGFydVQlVf6t6hWX5avGt
         IIFpsx6MX0mY6lK2nXR8vnsw/aSjtJ9nDxPpcJ4ILqJ1QygiO7yiSWtZpY0DfeoVkn4a
         FwdRzfYjIlr2GbBV0jbwlDy9NCzL5OLElbg5ulcN0Jk+KZ2IEpr61r6g4GMYtuNq0MVe
         EF0I0WZ59SCxfKTa0Y7rFHBFmk4RQPPZf2QW0Vm22DZIPVIRQ28spv2ZBGsbrgHIvmT0
         ROBg==
X-Gm-Message-State: AOAM530w3qNlLj5zIt1UMmBy2f7fDoYBGfARcpO41Z9Eab0OnLSvxI8U
        5BBk5xhfyatXmSCJt4Q/OUsXDA==
X-Google-Smtp-Source: ABdhPJwbib6BkarNo+K48caVL1EEcMyD4P1NjsZ159e2tdZhAydKdMgyxCTWdsPKQgIV/5CqbPqSBg==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr17628133wmh.150.1592818881779;
        Mon, 22 Jun 2020 02:41:21 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id j24sm14392652wrd.43.2020.06.22.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:41:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/15] net: phy: correctly model the PHY voltage supply in DT
Date:   Mon, 22 Jun 2020 11:37:29 +0200
Message-Id: <20200622093744.13685-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

PHY devices on an MDIO bus can have their own regulators. This is currently
mostly modeled using the semi-standard phy-supply property on the MAC node.
This seems to be conceptually wrong though, as the MAC shouldn't need to
care about enabling the PHY regulator explicitly. Instead this should be
done by the core PHY/MDIO code.

This series introduces a new DT property at the PHY node level in mdio.yaml
and adds support for PHY regulator, then uses the new property on pumpkin
boards. It also addresses several issues I noticed when working on this
feature.

First four patches are just cosmetic improvements in source files we'll
modify later in this series.

Patches 5 and 6 modify the way PHY reset handling works. Currently the
probe() callback needs to be implemented to take the PHY out of reset but
PHY drivers without probe() can have resets defined as well.

Patches 7-11 address an issue where we probe the PHY for ID without
deasserting its reset signal. We delay the ID read until after the logical
device is created and resets have been configured.

Last four patches add the new DT property, implement support for PHY
regulator in phy and mdio code and set the new property in the DT file
for MediaTek's pumpkin boards.

Bartosz Golaszewski (15):
  net: phy: arrange headers in mdio_bus.c alphabetically
  net: phy: arrange headers in mdio_device.c alphabetically
  net: phy: arrange headers in phy_device.c alphabetically
  net: mdio: add a forward declaration for reset_control to mdio.h
  net: phy: reset the PHY even if probe() is not implemented
  net: phy: mdio: reset MDIO devices even if probe() is not implemented
  net: phy: split out the PHY driver request out of phy_device_create()
  net: phy: check the PHY presence in get_phy_id()
  net: phy: delay PHY driver probe until PHY registration
  net: phy: simplify phy_device_create()
  net: phy: drop get_phy_device()
  dt-bindings: mdio: add phy-supply property to ethernet phy node
  net: phy: mdio: add support for PHY supply regulator
  net: phy: add PHY regulator support
  ARM64: dts: mediatek: add a phy regulator to pumpkin-common.dtsi

 .../devicetree/bindings/net/mdio.yaml         |   4 +
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   1 +
 drivers/net/dsa/ocelot/felix_vsc9959.c        |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c   |   5 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c |   2 +-
 drivers/net/ethernet/socionext/netsec.c       |   3 +-
 drivers/net/phy/fixed_phy.c                   |   2 +-
 drivers/net/phy/mdio-xgene.c                  |   2 +-
 drivers/net/phy/mdio_bus.c                    |  55 +++--
 drivers/net/phy/mdio_device.c                 |  51 ++++-
 drivers/net/phy/nxp-tja11xx.c                 |   2 +-
 drivers/net/phy/phy_device.c                  | 216 ++++++++++--------
 drivers/net/phy/sfp.c                         |   2 +-
 drivers/of/of_mdio.c                          |  11 +-
 include/linux/mdio.h                          |   4 +
 include/linux/phy.h                           |  21 +-
 16 files changed, 240 insertions(+), 144 deletions(-)

-- 
2.26.1

