Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1920C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF292206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R6hORFB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgF2TQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbgF2TOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F037EC0D941A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:01:03 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 71B32299;
        Mon, 29 Jun 2020 14:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593432061;
        bh=yIy9K+7ClpA1ADDfcNgfiybjcgQ2b9XnHSux5FHyNrg=;
        h=From:To:Cc:Subject:Date:From;
        b=R6hORFB6IlYoIM6WiTxrcE+/H9GvEpPxjoMUP0ua7h/6mnge6hZ2aPLlOhX3rVRVg
         UurJeXX44wOVhT/nJ5bJFxTN1FOOV432pdw6xeFsGbnTuvc4CDBc//PfZprh0F9EJH
         qRMMc7B+lmBtYUMZSpFQoR9C8JrgAxidElBx2boA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v9 0/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver
Date:   Mon, 29 Jun 2020 15:00:51 +0300
Message-Id: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
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

Compared to v8, the series has been rebased on phy/next, and a minor
issue in MAINTAINERS has been fixed.

[1] https://patchwork.kernel.org/cover/10735681/

Anurag Kumar Vulisha (2):
  dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
  phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver

Laurent Pinchart (1):
  arm64: dts: zynqmp: Add GTR transceivers

 .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++
 MAINTAINERS                                   |   9 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  10 +
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   3 +-
 drivers/phy/xilinx/Kconfig                    |  13 +
 drivers/phy/xilinx/Makefile                   |   3 +
 drivers/phy/xilinx/phy-zynqmp.c               | 995 ++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |   1 +
 9 files changed, 1139 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 create mode 100644 drivers/phy/xilinx/Kconfig
 create mode 100644 drivers/phy/xilinx/Makefile
 create mode 100644 drivers/phy/xilinx/phy-zynqmp.c

-- 
Regards,

Laurent Pinchart

