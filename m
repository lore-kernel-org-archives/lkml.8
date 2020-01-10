Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834BDC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5055A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578691084;
	bh=FNVSCUnW06HgAkUyxcEdLPUSR02Pqf5qLuXtJBW+LhI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tIwsb6dWdTuD7ufAcHLyJtFVy78ldDnAVWWjvWIva9rtnP9JlIhJFQy/Z7uCA7biu
	 +sDu8jQlTGnsiaTJtf2GUboSPcerCrQOLgMt7FZGJKLCsovOrpaaPmheZH5G843rw7
	 YmLWiaO5rYmxtkLyvNAZH6dhneJ5gbCNxriPwdiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAJVSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgAJVSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:18:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB29F20842;
        Fri, 10 Jan 2020 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578691081;
        bh=FNVSCUnW06HgAkUyxcEdLPUSR02Pqf5qLuXtJBW+LhI=;
        h=Date:From:To:Cc:Subject:From;
        b=2GLzSYzkBF4XieyHnlzoZDMwTSqFiKNKW7gYwAZ3jirBd4KeUKvyazYs0F0A/Th/Z
         kAS4+pBpvTl6wL3YHlEG7HZ2ZH24JaW2IfQYBhc6HZbQFQKXcf2F7avpames4v54Ri
         g2XrEOe9DgVT5/PW3zkScJbxoILEJb94UgMwqd7k=
Date:   Fri, 10 Jan 2020 22:17:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.5-rc6
Message-ID: <20200110211758.GA1872534@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc6

for you to fetch changes up to 1530f6f5f5806b2abbf2a9276c0db313ae9a0e09:

  usb: missing parentheses in USE_NEW_SCHEME (2020-01-08 17:44:11 +0100)

----------------------------------------------------------------
USB/PHY fixes for 5.5-rc6

Here are a number of USB and PHY driver fixes for 5.5-rc6

Nothing all that unusual, just the a bunch of small fixes for a lot of
different reported issues.  The PHY driver fixes are in here as they
interacted with the usb drivers.

Full details of the patches are in the shortlog, and all of these have
been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: Fix: Don't skip endpoint descriptors with maxpacket=0

Arnd Bergmann (1):
      usb: udc: tegra: select USB_ROLE_SWITCH

Bjorn Andersson (1):
      phy: qcom-qmp: Increase PHY ready timeout

Colin Ian King (1):
      usb: ohci-da8xx: ensure error return on variable error is set

Daniele Palmas (2):
      USB: serial: option: add Telit ME910G1 0x110a composition
      USB: serial: option: add ZLP support for 0x1bc7/0x9010

Douglas Gilbert (1):
      USB-PD tcpm: bad warning+size, PPS adapters

Greg Kroah-Hartman (2):
      Merge tag 'phy-for-5.5-rc' of git://git.kernel.org/.../kishon/linux-phy into usb-linus
      Merge tag 'usb-serial-5.5-rc5' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Guenter Roeck (1):
      usb: chipidea: host: Disable port power only if previously enabled

Heikki Krogerus (1):
      usb: typec: ucsi: Fix the notification bit offsets

Johan Hovold (1):
      USB: core: fix check for duplicate endpoints

Jonas Karlman (1):
      phy/rockchip: inno-hdmi: round clock rate down to closest 1000 Hz

Paul Cercueil (3):
      usb: musb: jz4740: Silence error if code is -EPROBE_DEFER
      usb: musb: dma: Correct parameter passed to IRQ handler
      usb: musb: Disable pullup at init

Peter Chen (1):
      usb: cdns3: should not use the same dev_id for shared interrupt handler

Qi Zhou (1):
      usb: missing parentheses in USE_NEW_SCHEME

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix request complete check

Tony Lindgren (7):
      phy: cpcap-usb: Fix error path when no host driver is loaded
      phy: cpcap-usb: Fix flakey host idling and enumerating of devices
      phy: mapphone-mdm6600: Fix uninitialized status value regression
      phy: cpcap-usb: Prevent USB line glitches from waking up modem
      phy: cpcap-usb: Improve host vs docked mode detection
      phy: cpcap-usb: Drop extra write to usb2 register
      usb: musb: fix idling for suspend after disconnect interrupt

 drivers/phy/motorola/phy-cpcap-usb.c          | 128 ++++++++++++++++++--------
 drivers/phy/motorola/phy-mapphone-mdm6600.c   |  11 +--
 drivers/phy/qualcomm/phy-qcom-qmp.c           |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c |   4 +
 drivers/usb/cdns3/gadget.c                    |  14 +--
 drivers/usb/chipidea/host.c                   |   4 +-
 drivers/usb/core/config.c                     |  82 +++++++++++++----
 drivers/usb/core/hub.c                        |   2 +-
 drivers/usb/dwc3/gadget.c                     |   7 ++
 drivers/usb/gadget/udc/Kconfig                |   1 +
 drivers/usb/host/ohci-da8xx.c                 |   8 +-
 drivers/usb/musb/jz4740.c                     |   7 +-
 drivers/usb/musb/musb_core.c                  |  11 +++
 drivers/usb/musb/musbhsdma.c                  |   2 +-
 drivers/usb/serial/option.c                   |  10 ++
 drivers/usb/serial/usb-wwan.h                 |   1 +
 drivers/usb/serial/usb_wwan.c                 |   4 +
 drivers/usb/typec/tcpm/tcpci.c                |  20 +++-
 drivers/usb/typec/ucsi/ucsi.h                 |  18 ++--
 19 files changed, 243 insertions(+), 93 deletions(-)
