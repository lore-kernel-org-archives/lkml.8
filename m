Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBF1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492EA21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449438;
	bh=MQx/+pcESt0M2O0VHxn1QIOJuotT12ugSC5HBwX/f9U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bF2/RK0hzOE3EO6pH3aSrTAt4/u0kCQ9ULQFIM4Q+a1s+cNsfFdeitBjNCOCqbWo/
	 yIXrsEdhBwj2cFpnGOwOQT7N+q0kGQHIqq8r9Q9PzH2mRHrCS+RE3UwFnH7fYagksT
	 HOECKIcdaecI4GhWoxqwxPsrd/z01BfrTq5lBoAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgHZNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbgHZNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:43:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E583C21741;
        Wed, 26 Aug 2020 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449380;
        bh=MQx/+pcESt0M2O0VHxn1QIOJuotT12ugSC5HBwX/f9U=;
        h=Date:From:To:Cc:Subject:From;
        b=p1XZcPvEewpwhfCYF34BU6TplCWPARuwRG9CdyI60OLDJ1UbnkUJud8MPB9io4thh
         dJz+6zhuROlq+4onefEvuSTkq7JMBMVd20igLDKjhB1k89WlVygEZ88OYiUdCP6iw9
         M6wh1OupsdLdTnD1uElVHx+zpSWisu6G8TkKWUVg=
Date:   Wed, 26 Aug 2020 15:43:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.9-rc3
Message-ID: <20200826134315.GA3882506@kroah.com>
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

for you to fetch changes up to 23e26d0577535f5ffe4ff8ed6d06e009553c0bca:

  usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures (2020-08-25 16:02:35 +0200)

----------------------------------------------------------------
USB fixes for 5.9-rc3

Here are a small set of USB fixes for 5.9-rc3.

Like most set of USB bugfixes, they include the usual:
	- usb gadget driver fixes
	- xhci driver fixes
	- typec fixes
	- new qurks and ids
	- fixes for USB patches merged in 5.9-rc1

Nothing huge, all of these have been in linux-next with no reported
issues:

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: yurex: Fix bad gfp argument

Andy Shevchenko (1):
      usb: hcd: Fix use after free in usb_hcd_pci_remove()

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
 drivers/usb/core/quirks.c            |   2 +
 drivers/usb/dwc3/gadget.c            | 107 +++++++++++++++++++++++++++++------
 drivers/usb/gadget/function/f_ncm.c  |  81 ++++++++++++++++++++++----
 drivers/usb/gadget/function/f_tcm.c  |   7 ++-
 drivers/usb/gadget/u_f.h             |  38 +++++++++----
 drivers/usb/host/xhci-debugfs.c      |   8 +--
 drivers/usb/host/xhci-hub.c          |  19 ++++---
 drivers/usb/host/xhci-pci-renesas.c  |  19 +------
 drivers/usb/host/xhci-tegra.c        |   4 +-
 drivers/usb/host/xhci.c              |   3 +-
 drivers/usb/misc/lvstest.c           |   2 +-
 drivers/usb/misc/yurex.c             |   2 +-
 drivers/usb/phy/phy-jz4770.c         |   1 +
 drivers/usb/storage/unusual_uas.h    |   7 +++
 drivers/usb/typec/tcpm/tcpm.c        |  28 ++++++++-
 drivers/usb/typec/ucsi/displayport.c |   9 +--
 drivers/usb/typec/ucsi/ucsi.c        | 103 +++++++++++++++++----------------
 drivers/usb/usbip/stub_dev.c         |   6 ++
 tools/usb/Build                      |   2 +
 tools/usb/Makefile                   |  53 ++++++++++++++---
 24 files changed, 408 insertions(+), 165 deletions(-)
 create mode 100644 tools/usb/Build
