Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AF0C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8932080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="afu1PiIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgH1BMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:12:03 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9893 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgH1BL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:11:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4859640002>; Thu, 27 Aug 2020 18:09:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 18:11:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 18:11:58 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 01:11:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 01:11:52 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4859d60000>; Thu, 27 Aug 2020 18:11:52 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 00/12] Tegra XHCI controller ELPG support
Date:   Fri, 28 Aug 2020 09:10:44 +0800
Message-ID: <20200828011056.1067559-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598576996; bh=zHk/gmZD4eSr6JQv9iLVCWl9mVamcVePIcQeKB7Z3IU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=afu1PiIA5PKZBjngZb1mFFtLs5HPjn28pn4cDLjjaRYboKqEu0eDFpGdalaV/0RO7
         /x4xWWwUxa/t/nXo3ZbijXixpFOjMAFXbSJhncWboISdZE0pg9od2PlGWYCHxXlQtX
         I/EnL1t3hTgG5Pgg9kQ+cFOIgHbGdfrLgAcmsMtqTORIlWrQ2lYcm3OHBMkHZazk/R
         Mv/hDxUAjKolXlvFIOSJrZUTgR5Wqrk0AdCii0FWNQdmUIofNpzJlSjkusopaH6C3l
         0WDBsJj6Lkm73x7oUKaeUspuz081hgvTBdqPKeCrbNxGCkOANIbb6I5GQchIGQQKiT
         HQw7OxltZHgsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra XHCI controler can be placed in ELPG (Engine Level PowerGated)
state for power saving when all of the connected USB devices are in
suspended state. This patch series includes clk, phy and pmc changes
that are required for properly place controller in ELPG and bring
controller out of ELPG.

JC Kuo (12):
  clk: tegra: Add PLLE HW power sequencer control
  clk: tegra: don't enable PLLE HW sequencer at init
  phy: tegra: xusb: t210: rearrange UPHY init
  phy: tegra: xusb: t210: add lane_iddq operations
  phy: tegra: xusb: add sleepwalk and suspend/resume
  soc/tegra: pmc: provide usb sleepwalk register map
  arm64: tegra210: XUSB PADCTL add "nvidia,pmc" prop
  phy: tegra: xusb: t210: support wake and sleepwalk
  phy: tegra: xusb: t186: support wake and sleepwalk
  arm64: tegra210/tegra186/tegra194: XUSB PADCTL irq
  usb: host: xhci-tegra: unlink power domain devices
  xhci: tegra: enable ELPG for runtime/system PM

 arch/arm64/boot/dts/nvidia/tegra186.dtsi |    1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi |    1 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |    2 +
 drivers/clk/tegra/clk-pll.c              |   12 -
 drivers/clk/tegra/clk-tegra210.c         |   51 +
 drivers/phy/tegra/xusb-tegra186.c        |  656 ++++++++
 drivers/phy/tegra/xusb-tegra210.c        | 1953 +++++++++++++++++-----
 drivers/phy/tegra/xusb.c                 |   86 +-
 drivers/phy/tegra/xusb.h                 |   23 +-
 drivers/soc/tegra/pmc.c                  |   89 +
 drivers/usb/host/xhci-tegra.c            |  577 +++++--
 include/linux/clk/tegra.h                |    2 +
 include/linux/phy/tegra/xusb.h           |   13 +
 13 files changed, 2957 insertions(+), 509 deletions(-)

--=20
2.25.1

