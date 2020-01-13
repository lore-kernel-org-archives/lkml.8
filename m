Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E03C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC15B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578904824;
	bh=I265izXednaMD33cxtz9/CP1bziJa3bkaKS845VPu18=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CPEOd7xz3EXYE/62ru7d7FtnCvm3FLftxN08Sjuf0dDeWnIi2U1CuqP6RgvLd0jQf
	 xCZ89nQLaW5SRAeJ0c1BFBWCQSRBSCo/KBu8cKJiIhTj+sR4O59Ffes86MXIookw3h
	 McQO6IrudjCP2e0jVO2y2dGnj9FTpnX5B4SZ6Bh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAMIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgAMIkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:40:23 -0500
Received: from localhost.localdomain (unknown [106.200.247.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B84D207E0;
        Mon, 13 Jan 2020 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578904823;
        bh=I265izXednaMD33cxtz9/CP1bziJa3bkaKS845VPu18=;
        h=From:To:Cc:Subject:Date:From;
        b=AgI2hGFdETq7ptUYQUEBUAYYFnS/8sTZ3WnFanOHNyI+HKBDKrzfa21meKzyZhxbO
         /b80mScb4hLzUvV3xgMgm+7a9brBDCwKqfny9a2LZXCBTqlbqfZqQXFa02fleZnTtG
         zv909fiCr8zgRHxxyYx2x6Q3nZZfaJUzsL3nk6Uw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] usb: xhci: Add support for Renesas USB controllers
Date:   Mon, 13 Jan 2020 14:10:00 +0530
Message-Id: <20200113084005.849071-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for Renesas USB controllers uPD720201 and uPD720202.
These require firmware to be loaded and in case devices have ROM those can
also be programmed if empty. If ROM is programmed, it runs from ROM as well.

This includes two patches from Christian which supported these controllers
w/o ROM and later my patches for ROM support and multiple firmware versions,
debugfs hook for rom erase and export of xhci-pci functions.

Changes in v6:
 Move the renesas code into a seprate driver which invokes xhci-pci functions.

Changes in v5:
 Added a debugfs rom erase patch, helps in debugging
 Squashed patch 1 & 2 as requested by Mathias

Changes in v4:
 Rollback the delay values as we got device failures

Changes in v3:
  Dropped patch 2 as discussed with Christian
  Removed aligned 8 bytes check
  Change order for firware search from highest version to lowest
  Added entry for new firmware for device 0x14 as well
  Add tested by Christian

Changes in v2:
  used macros for timeout count and delay
  removed renesas_fw_alive_check
  cleaned renesas_fw_callback
  removed recurion for renesas_fw_download
  added MODULE_FIRMWARE
  added comment for multiple fw order

Christian Lamparter (1):
  usb: renesas-xhci: Add the renesas xhci driver

Vinod Koul (4):
  usb: xhci: export few functions
  usb: renesas-xhci: Add ROM loader for uPD720201
  usb: renesas-xhci: allow multiple firmware versions
  usb: xhci: provide a debugfs hook for erasing rom

 drivers/usb/host/Kconfig            |   9 +
 drivers/usb/host/Makefile           |   1 +
 drivers/usb/host/xhci-pci-renesas.c | 985 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci-pci.c         |  18 +-
 drivers/usb/host/xhci-pci.h         |  18 +
 5 files changed, 1024 insertions(+), 7 deletions(-)
 create mode 100644 drivers/usb/host/xhci-pci-renesas.c
 create mode 100644 drivers/usb/host/xhci-pci.h

-- 
2.24.1

