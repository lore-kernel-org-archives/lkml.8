Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0B9C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0962076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgD3NEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:04:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgD3NEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:04:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2F3CAC85;
        Thu, 30 Apr 2020 13:04:39 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 0/2] Raspberry Pi 4 VL805 firmware load
Date:   Thu, 30 Apr 2020 15:04:31 +0200
Message-Id: <20200430130433.11248-1-nsaenzjulienne@suse.de>
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

---

Changes since v1:
 - Rename function
 - Use callback in xhci-pci.c

Nicolas Saenz Julienne (2):
  arm: rpi: Add function to trigger VL805's firmware load
  usb: xhci: Load Raspberry Pi 4 VL805's firmware

 arch/arm/mach-bcm283x/include/mach/mbox.h | 13 +++++++
 arch/arm/mach-bcm283x/include/mach/msg.h  |  7 ++++
 arch/arm/mach-bcm283x/msg.c               | 43 +++++++++++++++++++++++
 board/raspberrypi/rpi/rpi.c               | 12 +++++++
 drivers/usb/host/xhci-pci.c               |  6 ++++
 include/usb/xhci.h                        |  3 ++
 6 files changed, 84 insertions(+)

-- 
2.26.2

