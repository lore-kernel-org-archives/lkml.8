Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A1C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A6206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593258028;
	bh=fz0wbjdILEJ+Bu6PJAJP5L16Ck/34PqrYhrCNwWdABw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dbzSS6N7a987veyGI8MI2trOu8xAjMxIb2Zv+/NhxtLFuJix/+MrHVtQgrqGesonF
	 csjBEmOPnMQLEsf+zdNwXd+96DbX1rJsb+zZjYuibNE0OodEUdHzXuOXTg/kmWkiWH
	 Yno43uJaml0XtppnJHNz2tqdm0iAwRFt3Qn1UKvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgF0LkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgF0LkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:40:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1C9206A1;
        Sat, 27 Jun 2020 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593258020;
        bh=fz0wbjdILEJ+Bu6PJAJP5L16Ck/34PqrYhrCNwWdABw=;
        h=Date:From:To:Cc:Subject:From;
        b=cQf1RpXrM1H72Yg03oehBFNL3+Xqk0NIqasOtAVWF4bON2LGbk8/XZ29tusymgiUT
         JZQxjmX8iImLOssbDbDKU+0UbzoYq1GCIrONjcyy1VtWouzkCp4NL5GFwCfMQL+urZ
         BU6wgLsZLybZn1bUaFEiIYiVtP8azhcA9lcOcWv8=
Date:   Sat, 27 Jun 2020 13:40:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.8-rc3
Message-ID: <20200627114013.GA1636882@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc3

for you to fetch changes up to ed8fa04243e22f7b8f470d08e5806c9f8c6a460a:

  Merge tag 'fixes-for-v5.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus (2020-06-26 17:16:52 +0200)

----------------------------------------------------------------
USB fixes for 5.8-rc3

Here are some small USB fixes for 5.8-rc3 to resolve some reported
issues.

Nothing major here:
	- gadget driver fixes
	- cdns3 driver fixes
	- xhci fixes
	- renesas_usbhs driver fixes
	- some new device support with ids
	- documentation update

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (1):
      usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work

Al Cooper (1):
      xhci: Fix enumeration issue when setting max packet size for FS devices.

Anand Moon (2):
      Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"
      Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"

Chuhong Yuan (1):
      USB: ohci-sm501: Add missed iounmap() in remove

Dan Carpenter (1):
      usb: gadget: udc: Potential Oops in error handling code

Fabio Estevam (1):
      Documentation: ABI: usb: chipidea: Update Li Jun's e-mail

Greg Kroah-Hartman (2):
      Merge 5.8-rc2 into usb-linus
      Merge tag 'fixes-for-v5.8-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Heikki Krogerus (1):
      usb: typec: mux: intel_pmc_mux: Fix DP alternate mode entry

Joakim Tjernlund (1):
      cdc-acm: Add DISABLE_ECHO quirk for Microchip/SMSC chip

Kai-Heng Feng (2):
      xhci: Return if xHCI doesn't support LPM
      xhci: Poll for U0 after disabling USB2 LPM

Li Jun (1):
      usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs

Longfang Liu (1):
      USB: ehci: reopen solution for Synopsys HC bug

Macpaul Lin (1):
      usb: host: xhci-mtk: avoid runtime suspend when removing hcd

Mathias Nyman (1):
      xhci: Fix incorrect EP_STATE_MASK

Minas Harutyunyan (1):
      usb: dwc2: Postponed gadget registration to the udc class driver

Peter Chen (6):
      usb: cdns3: ep0: fix the test mode set incorrectly
      usb: cdns3: trace: using correct dir value
      usb: cdns3: ep0: add spinlock for cdns3_check_new_setup
      usb: cdns3: ep0: fix the test mode set incorrectly
      usb: cdns3: trace: using correct dir value
      usb: cdns3: ep0: add spinlock for cdns3_check_new_setup

Tang Bin (2):
      usb: host: ehci-exynos: Fix error check in exynos_ehci_probe()
      usb: phy: tegra: Fix unnecessary check in tegra_usb_phy_probe()

Tomasz Meresiński (1):
      usb: add USB_QUIRK_DELAY_INIT for Logitech C922

Yoshihiro Shimoda (1):
      usb: renesas_usbhs: getting residue from callback_result

Zqiang (1):
      usb: usbtest: fix missing kfree(dev->buf) in usbtest_disconnect

 .../ABI/testing/sysfs-platform-chipidea-usb-otg    |  8 +++---
 drivers/usb/cdns3/ep0.c                            | 10 ++++---
 drivers/usb/cdns3/trace.h                          |  2 +-
 drivers/usb/class/cdc-acm.c                        |  2 ++
 drivers/usb/core/quirks.c                          |  3 ++-
 drivers/usb/dwc2/gadget.c                          |  6 -----
 drivers/usb/dwc2/platform.c                        | 11 ++++++++
 drivers/usb/dwc3/dwc3-exynos.c                     |  9 -------
 drivers/usb/dwc3/dwc3-pci.c                        |  4 ++-
 drivers/usb/gadget/udc/mv_udc_core.c               |  3 ++-
 drivers/usb/host/ehci-exynos.c                     |  5 ++--
 drivers/usb/host/ehci-pci.c                        |  7 +++++
 drivers/usb/host/ohci-sm501.c                      |  1 +
 drivers/usb/host/xhci-mtk.c                        |  5 ++--
 drivers/usb/host/xhci.c                            |  9 ++++++-
 drivers/usb/host/xhci.h                            |  2 +-
 drivers/usb/misc/usbtest.c                         |  1 +
 drivers/usb/phy/phy-tegra-usb.c                    |  6 +----
 drivers/usb/renesas_usbhs/fifo.c                   | 23 +++++++++-------
 drivers/usb/renesas_usbhs/fifo.h                   |  2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              | 13 +++++++--
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             | 31 +++++++---------------
 22 files changed, 90 insertions(+), 73 deletions(-)
