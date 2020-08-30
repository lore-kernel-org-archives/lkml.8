Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA71C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C1F20714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598781723;
	bh=ntiH5pY0+trPBOlc2VfgKdHGrgt4PdF2TY/6wUPDaY0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iZCl52109UH7k3m05ddFekIeuT74fXbpHIAZwxLPcbnYjwbuF0o8MV9lIiOF42lws
	 w0K6I92AYl7EnWqSq26XWNyc4b6AffWsTRoeOIgusBVwDPdQGMxHkCls3aWOztFEaQ
	 dU21VX9Q6d//hLsDRHciMu2kGmSApYHwtS4kb7/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgH3KCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgH3KCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 06:02:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801AF20714;
        Sun, 30 Aug 2020 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598781719;
        bh=ntiH5pY0+trPBOlc2VfgKdHGrgt4PdF2TY/6wUPDaY0=;
        h=Date:From:To:Cc:Subject:From;
        b=umOly9TxkyK1nC6M+btK6xSzQjdZa3GwtK4W5HB75ND1WEr5C3LEyrb9U3AQqwUgH
         oVJQCUO0DegK95zxJxRSgCtSqnJkeG6ZUESTK/9W1XncFxiAb/UTAk9dmflCbN41xG
         vMQokkCYEE8uuNu+9MF26Nr8cf8yYFU3QzjR62UE=
Date:   Sun, 30 Aug 2020 12:01:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.9-rc3 - take 2
Message-ID: <20200830100156.GA129097@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3

for you to fetch changes up to 20934c0de13b49a072fb1e0ca79fe0fe0e40eae5:

  usb: storage: Add unusual_uas entry for Sony PSZ drives (2020-08-28 09:23:16 +0200)

----------------------------------------------------------------
USB fixes for 5.9-rc3 - take 2

Let's try this again...  Here are some USB fixes for 5.9-rc3.

This differs from the previous pull request for this release in that:
	- the usb gadget patch now does not break some systems, and
	  actually does what it was intended to do.  Many thanks to
	  Marek Szyprowski for quickly noticing and testing the patch
	  from Andy Shevchenko to resolve this issue.
	- some more new USB quirks have been added to get some new
	  devices to work properly based on user reports.

Other than that, the original pull request patches are all here, and
they contain:
	- usb gadget driver fixes
	- xhci driver fixes
	- typec fixes
	- new quirks and ids
	- fixes for USB patches that went into 5.9-rc1.

All of these have been tested in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: yurex: Fix bad gfp argument
      USB: quirks: Ignore duplicate endpoint on Sound Devices MixPre-D
      usb: storage: Add unusual_uas entry for Sony PSZ drives

Andy Shevchenko (2):
      usb: hcd: Fix use after free in usb_hcd_pci_remove()
      USB: gadget: u_f: Unbreak offset calculation in VLAs

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures

Bastien Nocera (2):
      USB: Also match device drivers using the ->match vfunc
      USB: Fix device driver race

Brooke Basile (2):
      USB: gadget: u_f: add overflow checks to VLA macros
      USB: gadget: f_ncm: add bounds checks to ncm_unwrap_ntb()

Christophe JAILLET (1):
      usb: gadget: f_tcm: Fix some resource leaks in some error paths

Cyril Roelandt (1):
      USB: Ignore UAS for JMicron JMS567 ATA/ATAPI Bridge

Ding Hui (1):
      xhci: Always restore EP_SOFT_CLEAR_TOGGLE even if ep reset failed

Evgeny Novikov (1):
      USB: lvtest: return proper error code in probe

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v5.9-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Hans de Goede (4):
      usb: typec: ucsi: Fix AB BA lock inversion
      usb: typec: ucsi: Fix 2 unlocked ucsi_run_command calls
      usb: typec: ucsi: Rework ppm_lock handling
      usb: typec: ucsi: Hold con->lock for the entire duration of ucsi_register_port()

Heikki Krogerus (1):
      tools: usb: move to tools buildsystem

JC Kuo (2):
      usb: host: xhci-tegra: otg usb2/usb3 port init
      usb: host: xhci-tegra: fix tegra_xusb_get_phy()

Kai-Heng Feng (2):
      USB: quirks: Add no-lpm quirk for another Raydium touchscreen
      xhci: Do warm-reset when both CAS and XDEV_RESUME are set

Li Jun (1):
      usb: host: xhci: fix ep context print mismatch in debugfs

M. Vefa Bicakci (1):
      usbip: Implement a match function to fix usbip

Tang Bin (1):
      usb: host: ohci-exynos: Fix error handling in exynos_ohci_probe()

Thinh Nguyen (4):
      usb: dwc3: gadget: Don't setup more than requested
      usb: dwc3: gadget: Fix handling ZLP
      usb: dwc3: gadget: Handle ZLP for sg requests
      usb: uas: Add quirk for PNY Pro Elite

Tom Rix (1):
      USB: cdc-acm: rework notification_buffer resizing

Vinod Koul (1):
      usb: renesas-xhci: remove version check

周琰杰 (Zhou Yanjie) (1):
      USB: PHY: JZ4770: Fix static checker warning.

 drivers/usb/class/cdc-acm.c          |  22 ++++---
 drivers/usb/core/driver.c            |  40 ++++++++++++-
 drivers/usb/core/generic.c           |   5 +-
 drivers/usb/core/hcd-pci.c           |   5 +-
 drivers/usb/core/quirks.c            |   7 +++
 drivers/usb/dwc3/gadget.c            | 107 +++++++++++++++++++++++++++++------
 drivers/usb/gadget/function/f_ncm.c  |  81 ++++++++++++++++++++++----
 drivers/usb/gadget/function/f_tcm.c  |   7 ++-
 drivers/usb/gadget/u_f.h             |  38 +++++++++----
 drivers/usb/host/ohci-exynos.c       |   5 +-
 drivers/usb/host/xhci-debugfs.c      |   8 +--
 drivers/usb/host/xhci-hub.c          |  19 ++++---
 drivers/usb/host/xhci-pci-renesas.c  |  19 +------
 drivers/usb/host/xhci-tegra.c        |   4 +-
 drivers/usb/host/xhci.c              |   3 +-
 drivers/usb/misc/lvstest.c           |   2 +-
 drivers/usb/misc/yurex.c             |   2 +-
 drivers/usb/phy/phy-jz4770.c         |   1 +
 drivers/usb/storage/unusual_devs.h   |   2 +-
 drivers/usb/storage/unusual_uas.h    |  14 +++++
 drivers/usb/typec/tcpm/tcpm.c        |  28 ++++++++-
 drivers/usb/typec/ucsi/displayport.c |   9 +--
 drivers/usb/typec/ucsi/ucsi.c        | 103 +++++++++++++++++----------------
 drivers/usb/usbip/stub_dev.c         |   6 ++
 tools/usb/Build                      |   2 +
 tools/usb/Makefile                   |  53 ++++++++++++++---
 26 files changed, 423 insertions(+), 169 deletions(-)
 create mode 100644 tools/usb/Build
