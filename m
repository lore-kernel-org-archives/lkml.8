Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7630CC35653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE6F222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285146;
	bh=3VbA/6IynnwAPZnk3kedddXUiGueUIj2LdQ/mwiF/xo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mSr40/791w7KmfWb0pVZYBvc//EigMIjIoKHEGc2bpFAa2fPpoMh5NgstY8t8ynmK
	 pMjcvjH/cJmzZVTiYE3Xg/P7wTIsDrC8L84ftKPnVncxogjd8/v5CwMCjD+VnFkIvv
	 2FWvJ55Ra/bt3wBLT+k7KPvfo+XrOOCdaca1b314=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBULjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgBULjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:39:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE26B222C4;
        Fri, 21 Feb 2020 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285143;
        bh=3VbA/6IynnwAPZnk3kedddXUiGueUIj2LdQ/mwiF/xo=;
        h=Date:From:To:Cc:Subject:From;
        b=MuRnZAq2frRfCGDw1SSCqIaE5VYoHhEUEVLvtXQ24hfaEOfbO3/gZHraQLv4XLC+R
         /hbxT45o1EWL+WxZzV4In8c4M9SRNHiuQ4GG7+aYeWfF6jTDnK3fO1GpkAdLpRHDZW
         t/SrSdKvBUaoc48jTTJKhkZLx/tGJD21DwlvKmHE=
Date:   Fri, 21 Feb 2020 12:39:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt fixes for 5.6-rc3
Message-ID: <20200221113901.GA114136@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc3

for you to fetch changes up to 8b978be8d067f58b29cbbf0579e88bb4a2d4350a:

  Merge tag 'thunderbolt-fix-for-v5.6-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus (2020-02-18 19:39:29 +0100)

----------------------------------------------------------------
USB fixes for 5.6-rc3

Here are a number of small USB driver fixes for 5.6-rc3.

Included in here are:
  - MAINTAINER file updates
  - USB gadget driver fixes
  - usb core quirk additions and fixes for regressions
  - xhci driver fixes
  - usb serial driver id additions and fixes
  - thunderbolt bugfix

Thunderbolt patches come in through here now that USB4 is really
thunderbolt.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: hub: Don't record a connect-change event during reset-resume

Andy Shevchenko (2):
      MAINTAINERS: Sort entries in database for USB TYPEC
      MAINTAINERS: Sort entries in database for THUNDERBOLT

Anurag Kumar Vulisha (1):
      usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields

Colin Ian King (2):
      usb: dwc3: debug: fix string position formatting mixup with ret and len
      usb: dwc3: debug: fix string position formatting mixup with ret and len

Dan Carpenter (1):
      USB: serial: ir-usb: Silence harmless uninitialized variable warning

Dmitry Osipenko (1):
      usb: phy: tegra: Add clarifying comments about the shared registers

EJ Hsu (1):
      usb: uas: fix a plug & unplug racing

Greg Kroah-Hartman (7):
      Revert "xhci: Fix memory leak when caching protocol extended capability PSI tables"
      USB: misc: iowarrior: add support for 2 OEMed devices
      USB: misc: iowarrior: add support for the 28 and 28L devices
      Merge tag 'usb-serial-5.6-rc2' of https://git.kernel.org/.../johan/usb-serial into usb-linus
      Merge tag 'fixes-for-v5.6-rc1' of git://git.kernel.org/.../balbi/usb into usb-linus
      USB: misc: iowarrior: add support for the 100 device
      Merge tag 'thunderbolt-fix-for-v5.6-rc3' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus

Hardik Gajjar (1):
      USB: hub: Fix the broken detection of USB3 device in SMSC hub

Jack Pham (2):
      usb: gadget: composite: Fix bMaxPower for SuperSpeedPlus
      usb: gadget: composite: Support more than 500mA MaxPower

Johan Hovold (4):
      USB: serial: ch341: fix receiver regression
      USB: core: add endpoint-blacklist quirk
      USB: quirks: blacklist duplicate ep on Sound Devices USBPre2
      USB: core: clean up endpoint-descriptor parsing

John Keeping (1):
      usb: gadget: u_audio: Fix high-speed max packet size

Lars-Peter Clausen (1):
      usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ flags

Mathias Nyman (5):
      xhci: Force Maximum Packet size for Full-speed bulk devices to valid range.
      xhci: Fix memory leak when caching protocol extended capability PSI tables
      xhci: fix runtime pm enabling for quirky Intel hosts
      xhci: apply XHCI_PME_STUCK_QUIRK to Intel Comet Lake platforms
      xhci: Fix memory leak when caching protocol extended capability PSI tables - take 2

Michal Simek (1):
      usb: gadget: udc-xilinx: Fix xudc_stop() kernel-doc format

Mika Westerberg (1):
      thunderbolt: Prevent crash if non-active NVMem file is read

Minas Harutyunyan (2):
      usb: dwc2: Fix in ISOC request length checking
      usb: dwc2: Fix SET/CLEAR_FEATURE and GET_STATUS flows

Peter Chen (1):
      usb: charger: assign specific number for enum value

Richard Dodd (1):
      USB: Fix novation SourceControl XL after suspend

Sergey Organov (1):
      usb: gadget: serial: fix Tx stall after buffer overflow

 MAINTAINERS                            | 20 +++++-----
 drivers/thunderbolt/switch.c           |  7 ++++
 drivers/usb/core/config.c              | 31 +++++++++------
 drivers/usb/core/hub.c                 | 20 +++++++---
 drivers/usb/core/hub.h                 |  1 +
 drivers/usb/core/quirks.c              | 40 +++++++++++++++++++
 drivers/usb/core/usb.h                 |  3 ++
 drivers/usb/dwc2/gadget.c              | 40 +++++++++++--------
 drivers/usb/dwc3/debug.h               | 39 +++++++------------
 drivers/usb/dwc3/gadget.c              |  3 +-
 drivers/usb/gadget/composite.c         | 30 +++++++++-----
 drivers/usb/gadget/function/f_fs.c     |  5 ++-
 drivers/usb/gadget/function/u_audio.c  | 10 ++---
 drivers/usb/gadget/function/u_serial.c |  4 +-
 drivers/usb/gadget/udc/udc-xilinx.c    |  1 -
 drivers/usb/host/xhci-hub.c            | 25 ++++++++----
 drivers/usb/host/xhci-mem.c            | 71 ++++++++++++++++++++++------------
 drivers/usb/host/xhci-pci.c            | 10 +++--
 drivers/usb/host/xhci.h                | 14 +++++--
 drivers/usb/misc/iowarrior.c           | 31 ++++++++++++++-
 drivers/usb/phy/phy-tegra-usb.c        |  8 ++++
 drivers/usb/serial/ch341.c             | 10 +++++
 drivers/usb/serial/ir-usb.c            |  2 +-
 drivers/usb/storage/uas.c              | 23 ++++++++++-
 include/linux/usb/quirks.h             |  3 ++
 include/uapi/linux/usb/charger.h       | 16 ++++----
 26 files changed, 327 insertions(+), 140 deletions(-)
