Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECECAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46F420719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rCXecuMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgDAWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:10:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51676 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732687AbgDAWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:10:37 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53766A2A;
        Thu,  2 Apr 2020 00:10:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1585779035;
        bh=wHKLfpdAC0w82LZRBlafZmjxebP+MvOxfa8J/ja108w=;
        h=From:To:Cc:Subject:Date:From;
        b=rCXecuMI/ix20LqZsj2bFTryDX0XJrUqIjyfPAlUeWesdXyoFQTgP8e4lmPjNMS29
         gbT64zJKCHT0yfFVqJNBaZRQqoJkr77C0hteMQYppWsjtuzooVJxm37mVwWg0gjLcI
         SKA/3dY1YIFaR9tv7tIwgE+LQ2fVDaUoZZj0W6wA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v7 0/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver
Date:   Thu,  2 Apr 2020 01:10:22 +0300
Message-Id: <20200401221025.26087-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch series adds a PHY driver for the Xilinx ZynqMP gigabit serial
transceivers (PS-GTR). The PS-GTR is a set of 4 PHYs that can be used by
the PCIe, USB 3.0, DisplayPort, SATA and Ethernet controllers that are
part of the Serial I/O Unit (SIOU).

The code is based on a previous version sent by Anurag Kumar Vulisha and
available at [1]. The DT bindings have been converted to YAML, and both
the bindings and the driver have been considerably reworked (and
simplified). The most notable changes is the removal of manual handling
of the reset lines of the PHY users (which belongs to the PHY users
themselves), and moving to the standard PHY .power_on() and .configure()
operations to replace functions that were previously exported by the
driver. Please see individual patches for a more detailed changelog.

Compared to v6, review comments on the DT bindings have been taken into
account.

The code is based on v5.6 and has been tested with DisplayPort on the
Xilinx ZC106 board.

[1] https://patchwork.kernel.org/cover/10735681/

Anurag Kumar Vulisha (2):
  dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
  phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver

Laurent Pinchart (1):
  arm64: dts: zynqmp: Add GTR transceivers

 .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++
 MAINTAINERS                                   |   9 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  10 +
 drivers/phy/Kconfig                           |   8 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-zynqmp.c                      | 995 ++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |   1 +
 7 files changed, 1129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 create mode 100644 drivers/phy/phy-zynqmp.c

-- 
Regards,

Laurent Pinchart

