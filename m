Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EDC2D0A8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8FF2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E7Jlqwq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgIIIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:10:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14002 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgIIIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:10:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588d810000>; Wed, 09 Sep 2020 01:08:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:10:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 01:10:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:10:45 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:10:45 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e030000>; Wed, 09 Sep 2020 01:10:44 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 00/15] Tegra XHCI controller ELPG support
Date:   Wed, 9 Sep 2020 16:10:26 +0800
Message-ID: <20200909081041.3190157-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599638913; bh=OnE1M57BnQjNFIR97nMj22Gyn8Dt1hz3QZatowFVODA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=E7Jlqwq5oHFMQou6t7BQOp4HY7WXDW84tEsUIvUbgchzf5L97+sgXIOn8WEgS4heL
         WpxzoAYkZUGO8UF/r3ZMzeWRIgOZZDnjyvmiMG55u9e27nTFhm1nDxGoayUxedlAAN
         HCGt5E44AC92ACMNiIFLZarNYG30o808rXuGBIlzhf5SHZZ7dH51t0vk9IJHUvKGb0
         EJKFTnVqXrd7QogM5zEMukNjEMCX7TZ9pDDGetXdLoO1til+C3cLbFcqatteZh9eVA
         Pxu0Lw6CP5jmDy5ZtHwmxLd9jaoRUrH9sL6gtjJTop+zW9t/7HUJ0UUB8PLAmFHft4
         brPE8YnJ1cQ5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra XHCI controler can be placed in ELPG (Engine Level PowerGated)
state for power saving when all of the connected USB devices are in
suspended state. This patch series includes clk, phy and pmc changes
that are required for properly place controller in ELPG and bring
controller out of ELPG.

JC Kuo (15):
  clk: tegra: Add PLLE HW power sequencer control
  clk: tegra: Don't enable PLLE HW sequencer at init
  phy: tegra: xusb: Move usb3 port init for Tegra210
  phy: tegra: xusb: tegra210: Do not reset UPHY PLL
  phy: tegra: xusb: Rearrange UPHY init on Tegra210
  phy: tegra: xusb: Add Tegra210 lane_iddq operation
  phy: tegra: xusb: Add sleepwalk and suspend/resume
  soc/tegra: pmc: Provide usb sleepwalk register map
  arm64: tegra210: XUSB PADCTL add "nvidia,pmc" prop
  phy: tegra: xusb: Add wake/sleepwalk for Tegra210
  phy: tegra: xusb: Tegra210 host mode VBUS control
  phy: tegra: xusb: Add wake/sleepwalk for Tegra186
  arm64: tegra210/tegra186/tegra194: XUSB PADCTL irq
  usb: host: xhci-tegra: Unlink power domain devices
  xhci: tegra: Enable ELPG for runtime/system PM

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |    1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |    1 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |    2 +
 drivers/clk/tegra/clk-pll.c              |   12 -
 drivers/clk/tegra/clk-tegra210.c         |   51 +
 drivers/phy/tegra/xusb-tegra186.c        |  626 +++++++
 drivers/phy/tegra/xusb-tegra210.c        | 1968 +++++++++++++++++-----
 drivers/phy/tegra/xusb.c                 |   81 +-
 drivers/phy/tegra/xusb.h                 |   21 +-
 drivers/soc/tegra/pmc.c                  |   95 ++
 drivers/usb/host/xhci-tegra.c            |  572 +++++--
 include/linux/clk/tegra.h                |    2 +
 include/linux/phy/tegra/xusb.h           |    8 +
 13 files changed, 2907 insertions(+), 533 deletions(-)

--=20
2.25.1

