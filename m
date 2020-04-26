Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03136C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEBF2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587898159;
	bh=qYciFqm9A2mHqdOl9z5rqOecRchvTFDbHdrpz3YIxgQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kXc5aHE/JYQ+JTeMNDo6BCroE/94TSTsWhl6nlD84QMtR8eo17yTHGobC/UmrRYVo
	 k0oYmdCrKyfBRi4n8oS1Eca6DhCrUpvMn/HlV5vZoKCetRKXK4LVaRIvoi/saOjOI+
	 1Z2zUXgG4ZKlwvLtwRy1DL8WrjH6EYVKilzCj8JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgDZKtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgDZKtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:49:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434C92071C;
        Sun, 26 Apr 2020 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587898157;
        bh=qYciFqm9A2mHqdOl9z5rqOecRchvTFDbHdrpz3YIxgQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ugyVltQ8Nu2syxbsAEgpUTbQzrM56SNQxUFM511q4W6laCdocVnEtqbVkRFQM1b2X
         OxpL7b19mWufrHFOx6yNRF5fklbxVUOqmxUIy/OlhbPBO9W+IfIYz+ib1HIxuuw7Z7
         LjyBU7+SuMITBSgojPqw0LsTbmH5TYpD10F9I92g=
Date:   Sun, 26 Apr 2020 12:49:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.7-rc3
Message-ID: <20200426104915.GA2121124@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc3

for you to fetch changes up to 2df7405f79ce1674d73c2786fe1a8727c905d65b:

  USB: sisusbvga: Change port variable from signed to unsigned (2020-04-23 15:26:17 +0200)

----------------------------------------------------------------
USB fixes for 5.7-rc3

Here are a number of USB driver fixes for 5.7-rc3.

Nothing huge, just the usual collection of:
	- xhci fixes
	- gadget driver fixes
	- syzkaller fuzzing fixes
	- new device ids and DT bindings
	- new quirks added for broken devices

A few of the gadget driver fixes show up twice here as they were applied
to my branch, and also by Felipe to his branch which I then pulled in as
we got out of sync a bit.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (4):
      USB: core: Fix free-while-in-use bug in the USB S-Glibrary
      USB: hub: Fix handling of connect changes during sleep
      USB: hub: Revert commit bd0e6c9614b9 ("usb: hub: try old enumeration scheme first for high speed devices")
      usb-storage: Add unusual_devs entry for JMicron JMS566

Andrey Konovalov (2):
      usb: raw-gadget: fix raw_event_queue_fetch locking
      usb: raw-gadget: fix raw_event_queue_fetch locking

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Ignore CC and vbus changes in PORT_RESET change

Changming Liu (1):
      USB: sisusbvga: Change port variable from signed to unsigned

Cristian Birsan (1):
      usb: gadget: udc: atmel: Fix vbus disconnect handling

Dan Carpenter (2):
      usb: raw-gadget: Fix copy_to/from_user() checks
      usb: raw-gadget: Fix copy_to/from_user() checks

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v5.7-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Hans de Goede (1):
      usb: typec: pi3usb30532: Set switch_ / mux_desc name field to NULL

Jann Horn (1):
      USB: early: Handle AMD's spec-compliant identifiers, too

Jonathan Cox (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG and USB_QUIRK_DELAY_INIT for Corsair K70 RGB RAPIDFIRE

Mathias Nyman (3):
      xhci: Fix handling halted endpoint even if endpoint ring appears empty
      xhci: prevent bus suspend if a roothub port detected a over-current condition
      xhci: Don't clear hub TT buffer on ep0 protocol stall

Mauro Carvalho Chehab (1):
      docs: dt: qcom,dwc3.txt: fix cross-reference for a converted file

Naoki Kiryu (1):
      usb: typec: altmode: Fix typec_altmode_get_partner sometimes returning an invalid pointer

Nathan Chancellor (1):
      usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete

Oliver Neukum (4):
      UAS: no use logging any details in case of ENODEV
      UAS: fix deadlock in error handling and PM flushing work
      cdc-acm: close race betrween suspend() and acm_softint
      cdc-acm: introduce a cool down

Thierry Reding (1):
      phy: tegra: Select USB_COMMON for usb_get_maximum_speed()

Thinh Nguyen (4):
      usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name
      usb: dwc3: gadget: Properly set maxpacket limit
      usb: dwc3: gadget: Do link recovery for SS and SSP
      usb: dwc3: gadget: Fix request completion check

Udipto Goswami (1):
      usb: f_fs: Clear OS Extended descriptor counts to zero in ffs_data_reset()

Yoshihiro Shimoda (3):
      dt-bindings: usb: usb-xhci: add r8a77961 support
      dt-bindings: usb: renesas,usbhs: add r8a77961 support
      dt-bindings: usb: renesas,usb3-peri: add r8a77961 support

 Documentation/admin-guide/kernel-parameters.txt    |  3 +-
 .../devicetree/bindings/usb/qcom,dwc3.txt          |  4 +-
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |  1 +
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |  1 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  3 +-
 drivers/phy/tegra/Kconfig                          |  3 +-
 drivers/usb/class/cdc-acm.c                        | 36 ++++++++--
 drivers/usb/class/cdc-acm.h                        |  5 +-
 drivers/usb/core/hub.c                             | 18 ++++-
 drivers/usb/core/message.c                         |  9 ++-
 drivers/usb/core/quirks.c                          |  4 ++
 drivers/usb/dwc3/core.h                            |  8 ++-
 drivers/usb/dwc3/gadget.c                          | 76 +++++++++++++---------
 drivers/usb/early/xhci-dbc.c                       |  8 +--
 drivers/usb/early/xhci-dbc.h                       | 18 ++++-
 drivers/usb/gadget/function/f_fs.c                 |  4 ++
 drivers/usb/gadget/legacy/raw_gadget.c             | 71 +++++++++++---------
 drivers/usb/gadget/udc/atmel_usba_udc.c            |  4 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c                |  2 +-
 drivers/usb/host/xhci-hub.c                        |  9 +++
 drivers/usb/host/xhci-ring.c                       | 46 +++++++++++--
 drivers/usb/host/xhci.c                            | 14 ++--
 drivers/usb/host/xhci.h                            |  5 +-
 drivers/usb/misc/sisusbvga/sisusb.c                | 20 +++---
 drivers/usb/misc/sisusbvga/sisusb_init.h           | 14 ++--
 drivers/usb/storage/uas.c                          | 46 ++++++++++++-
 drivers/usb/storage/unusual_devs.h                 |  7 ++
 drivers/usb/typec/bus.c                            |  5 +-
 drivers/usb/typec/mux/pi3usb30532.c                |  4 +-
 drivers/usb/typec/tcpm/tcpm.c                      | 26 ++++++++
 30 files changed, 351 insertions(+), 123 deletions(-)
