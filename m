Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F008620848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z5fsTmvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBLGLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:11:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8022 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLGLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:11:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e43970c0000>; Tue, 11 Feb 2020 22:11:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 11 Feb 2020 22:11:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 11 Feb 2020 22:11:38 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 06:11:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Feb 2020 06:11:38 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.125]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4397180000>; Tue, 11 Feb 2020 22:11:37 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v6 0/5] add Tegra194 XUSB host and pad controller support
Date:   Wed, 12 Feb 2020 14:11:28 +0800
Message-ID: <20200212061133.11665-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581487884; bh=JtGIEzqesheFOsXH1XBFeaqJD7RkaFvWmH//lN6CKYU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Z5fsTmvN+b2CxUnflZu3GJsG1IBlQfWUIxe/NQdAhCqQA6ITpzXFfinZYsZjgtvqK
         ApWVFOCZygdcWV5jabsa85Qi/2ON+MIlKQstbD5jmIwHkZsffj/cQEHLQqVYcfraGP
         N6rz3BCAmD6H/ksxaq+Dk38AbcktntbOdHrW5oI9N+ZUHHy7U08r3jJr9EBDxLeJAL
         EjEYPeBJjC9gZks3/nwWuGyRuS2yGIdFIfmfEaBoJuE2G6WVLobJtPyykxoM/Fo3yU
         DWQiARUkS5iVtedC1Qjyfrje1I0oMkH4A8545jlPKMq6hqRDhGYvyS79aP7mECfdTK
         TbPO/uh9UEv+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6:
  phy: tegra: xusb: Protect Tegra186 soc with config
   - no change

  phy: tegra: xusb: Add Tegra194 support
   - no change

  dt-bindings: phy: tegra: Add Tegra194 support
   - no change

  arm64: tegra: Add XUSB and pad controller on Tegra194
   - rebased

  arm64: tegra: Enable XUSB host in P2972-0000 board
   - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"

v5:
  phy: tegra: xusb: Protect Tegra186 soc with config
   - no change

  phy: tegra: xusb: Add Tegra194 support
   - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"

  dt-bindings: phy: tegra: Add Tegra194 support
   - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"

  arm64: tegra: Add XUSB and pad controller on Tegra194
   - no change

  arm64: tegra: Enable XUSB host in P2972-0000 board
   - no change

v3:
  add change log to cover latter

v2:
  xhci: tegra: Parameterize mailbox register addresses
   - no change

  usb: host: xhci-tegra: Add Tegra194 XHCI support
   - no change

  phy: tegra: xusb: Protect Tegra186 soc with config
   - new patch to protect Tegra186 soc data with config

  phy: tegra: xusb: Add Tegra194 support
   - removed unnecessary #if/#endif pairs
   - introduce new soc->supports_gen2 flag which indicate whether or not 
     a soc supports USB 3.1 Gen 2 speed

  dt-bindings: phy: tegra: Add Tegra194 support
   - fix a typo

  arm64: tegra: Add XUSB and pad controller on Tegra194
   - renamed xhci@3610000 with usb@3610000
   - moved padctl@3520000 and usb@3610000 inside /cbb
   - cleaned up "clocks" property of usb@3610000 node
   - added blanks lines to visually separate blocks

  arm64: tegra: Enable XUSB host in P2972-0000 board
   - use capitalization of regulator names
   - fix gpio property of VDD_5V_SATA regulator


JC Kuo (5):
  phy: tegra: xusb: Protect Tegra186 soc with config
  phy: tegra: xusb: Add Tegra194 support
  dt-bindings: phy: tegra: Add Tegra194 support
  arm64: tegra: Add XUSB and pad controller on Tegra194
  arm64: tegra: Enable XUSB host in P2972-0000 board

 .../phy/nvidia,tegra124-xusb-padctl.txt       |  18 +++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  36 ++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  63 ++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 139 +++++++++++++++++
 drivers/phy/tegra/Makefile                    |   1 +
 drivers/phy/tegra/xusb-tegra186.c             | 143 +++++++++++++-----
 drivers/phy/tegra/xusb.c                      |  17 +++
 drivers/phy/tegra/xusb.h                      |   5 +
 8 files changed, 387 insertions(+), 35 deletions(-)

-- 
2.17.1

