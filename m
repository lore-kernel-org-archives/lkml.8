Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB06C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE02207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFLQrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:47:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:58896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:47:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1210FACD0;
        Fri, 12 Jun 2020 16:47:26 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 0/5] usb: xhci: Load Raspberry Pi 4 VL805's firmware
Date:   Fri, 12 Jun 2020 18:46:28 +0200
Message-Id: <20200612164632.25648-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to be
loaded explicitly. Earlier versions didn't need that as they where using
an EEPROM for that purpose. This series takes care of setting up the
relevant infrastructure and run the firmware loading routine at the
right moment.

Note that this builds on top of Sylwester Nawrocki's "USB host support
for Raspberry Pi 4 board" series.

This works hand in hand with a series of device tree changes on the
Linux device tree that are still being reviewed:
https://patchwork.kernel.org/patch/11596403/
https://patchwork.kernel.org/patch/11596409/

---

Changes since v3:
 - Use reset controller

Changes since v2:
 - Correct comment on patch #1
 - Address Matthias' comments

Changes since v1:
 - Rename function
 - Use callback in xhci-pci.c

Nicolas Saenz Julienne (5):
  arm: rpi: Add function to trigger VL805's firmware load
  reset: Add Raspberry Pi 4 firmware reset controller
  configs: Enable support for reset controllers on RPi4
  dm: pci: Assign controller device node to root bridge
  usb: xhci-pci: Add reset controller support

 arch/arm/mach-bcm283x/include/mach/mbox.h     | 13 ++++
 arch/arm/mach-bcm283x/include/mach/msg.h      |  7 +++
 arch/arm/mach-bcm283x/msg.c                   | 46 ++++++++++++++
 configs/rpi_4_32b_defconfig                   |  1 +
 configs/rpi_4_defconfig                       |  1 +
 configs/rpi_arm64_defconfig                   |  1 +
 drivers/pci/pci-uclass.c                      | 15 ++++-
 drivers/reset/Kconfig                         | 10 ++++
 drivers/reset/Makefile                        |  1 +
 drivers/reset/reset-raspberrypi.c             | 60 +++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   | 38 +++++++++++-
 .../reset/raspberrypi,firmware-reset.h        | 13 ++++
 12 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 drivers/reset/reset-raspberrypi.c
 create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h

-- 
2.26.2

