Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEDBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72722078D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WJb/lkj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHaEkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:40:37 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9133 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaEkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:40:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7f360000>; Sun, 30 Aug 2020 21:40:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:40:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 30 Aug 2020 21:40:36 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:32 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:32 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f3d0005>; Sun, 30 Aug 2020 21:40:31 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 00/12] Tegra XHCI controller ELPG support
Date:   Mon, 31 Aug 2020 12:40:31 +0800
Message-ID: <20200831044043.1561074-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848822; bh=tnr9pFmvEq3TGh/ebyqKw+h1hK7Qx2jmIi3xZleiZoU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=WJb/lkj1ltsnX0PctjHsZvDVN2uZDaHiFCtenZE1vhXXCD/IOp4u01wmjEHetHDw5
         prH+Pe9+8ppjO2HG/E446QX/p2WX9RIDysdr5moAgJyfvmFxRH/W78G/QUpwhud2I1
         yfLQX1FYO0522WEXNCHz0r35EfYc7J+5gT+9lJL5WWObSvvWokBUfTvZv/nJwgFerX
         yoZ0YqO3khvlZFnIJGwMAQ1uVL4lSv0TanmGANE7GzaPqSK0PMS2+ezUe2fFwMAG8+
         VER9XnbeO7k4khA5wDoiTmvCJKa54TWWeBIrSVlBZtUoG0kRik7C1cBzqnVqJ/UxjJ
         1M9w404Wi+NCw==
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
     v2: no change
  clk: tegra: don't enable PLLE HW sequencer at init
     v2: no change
  phy: tegra: xusb: t210: rearrange UPHY init
     v2: no change
  phy: tegra: xusb: t210: add lane_iddq operations
     v2: no change
  phy: tegra: xusb: add sleepwalk and suspend/resume
     v2: no change
  soc/tegra: pmc: provide usb sleepwalk register map
     v2: make tegra_pmc_regmap_readl() and tegra_pmc_regmap_writel()
         static
  arm64: tegra210: XUSB PADCTL add "nvidia,pmc" prop
     v2: no change
  phy: tegra: xusb: t210: support wake and sleepwalk
     v2: no change
  phy: tegra: xusb: t186: support wake and sleepwalk
     v2: no change
  arm64: tegra210/tegra186/tegra194: XUSB PADCTL irq
     v2: no change
  usb: host: xhci-tegra: unlink power domain devices
     v2: no change
  xhci: tegra: enable ELPG for runtime/system PM
     v2: no change

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

