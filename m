Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE9FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843F62065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589708446;
	bh=39EXHpNSdWNjjMtj/vp27M8IQbirDJAzBquVu1o5sDk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PKmigTmcT4FzWL3EK2nF9F7b8wqIo0QH5Qn3O0E5ngiShmzwuUfUEK/zY8aVOU6Gc
	 pakAqBRLxHYrkIyw+SXt7pC/KYKI1HVaWpR04faTJO/vtBa7XGwlgc6+HX5EcbPPjs
	 RinxdwDyxk7I/eCnAi3Vj4HtxhKvjYu/8B9VcssM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgEQJkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgEQJkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE792065F;
        Sun, 17 May 2020 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589708443;
        bh=39EXHpNSdWNjjMtj/vp27M8IQbirDJAzBquVu1o5sDk=;
        h=Date:From:To:Cc:Subject:From;
        b=VbmCACrRhYus1jCQDkTsAEbe13GfRJShQe5Ks4Pv4yhhmxjdximk+6ksw9JCo8fNP
         BSF+wHtSsyesGai7WKK+U73e2+oBQ/YKOqtd14caEVrBGBsan1pk0LpQmrDBC/klyQ
         oAAMbQLcCp05rI5jRTjG8UYFWAuBbWyZsIHsEbwA=
Date:   Sun, 17 May 2020 11:40:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.7-rc6
Message-ID: <20200517094041.GA3392057@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc6

for you to fetch changes up to 15753588bcd4bbffae1cca33c8ced5722477fe1f:

  USB: gadget: fix illegal array access in binding with UDC (2020-05-15 15:42:17 +0200)

----------------------------------------------------------------
USB fixes for 5.7-rc6

Here are a number of USB fixes for 5.7-rc6

The "largest" in here is a bunch of raw-gadget fixes and api changes as
the driver just showed up in -rc1 and work has been done to fix up some
uapi issues found with the original submission, before it shows up in a
-final release.

Other than that, a bunch of other small USB gadget fixes, xhci fixes,
some quirks, andother tiny fixes for reported issues.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrey Konovalov (6):
      usb: raw-gadget: fix return value of ep read ioctls
      usb: raw-gadget: improve uapi headers comments
      usb: raw-gadget: fix gadget endpoint selection
      usb: raw-gadget: support stalling/halting/wedging endpoints
      usb: raw-gadget: documentation updates
      usb: raw-gadget: fix null-ptr-deref when reenabling endpoints

Andy Shevchenko (1):
      usb: dwc3: pci: Enable extcon driver for Intel Merrifield

Arnd Bergmann (1):
      usb: dwc3: select USB_ROLE_SWITCH

Christophe JAILLET (3):
      usb: gadget: audio: Fix a missing error return value in audio_bind()
      usb: phy: twl6030-usb: Fix a resource leak in an error handling path in 'twl6030_usb_probe()'
      usb: gadget: net2272: Fix a memory leak in an error handling path in 'net2272_plat_probe()'

Eugeniu Rosca (1):
      usb: core: hub: limit HUB_QUIRK_DISABLE_AUTOSUSPEND to USB5534B

Greg Kroah-Hartman (3):
      Merge tag 'fixes-for-v5.7-rc5' of git://git.kernel.org/.../balbi/usb into usb-linus
      USB: usbfs: fix mmap dma mismatch
      Merge tag 'fixes-for-v5.7-rc6' of git://git.kernel.org/.../balbi/usb into usb-linus

Jason Yan (1):
      usb: cdns3: gadget: make a bunch of functions static

John Stultz (1):
      dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()

Kyungtae Kim (1):
      USB: gadget: fix illegal array access in binding with UDC

Li Jun (1):
      usb: host: xhci-plat: keep runtime active when removing host

Masahiro Yamada (1):
      usb: gadget: legacy: fix redundant initialization warnings

Peter Chen (1):
      usb: cdns3: gadget: prev_req->trb is NULL for ep0

Prashant Malani (1):
      usb: typec: mux: intel: Fix DP_HPD_LVL bit field

Rikard Falkeborn (1):
      usb: mtu3: constify struct debugfs_reg32

Samuel Zou (1):
      usb: gadget: udc: atmel: Make some symbols static

Sriharsha Allenki (1):
      usb: xhci: Fix NULL pointer dereference when enqueuing trbs from urb sg list

Thierry Reding (1):
      usb: gadget: tegra-xudc: Fix idle suspend/resume

Wei Yongjun (2):
      usb: gadget: legacy: fix error return code in cdc_bind()
      usb: gadget: legacy: fix error return code in gncm_bind()

 Documentation/usb/raw-gadget.rst        |  37 +++-
 drivers/usb/cdns3/gadget.c              |  22 +--
 drivers/usb/core/devio.c                |  16 +-
 drivers/usb/core/hub.c                  |   6 +-
 drivers/usb/dwc3/Kconfig                |   1 +
 drivers/usb/dwc3/dwc3-pci.c             |   1 +
 drivers/usb/dwc3/gadget.c               |   3 -
 drivers/usb/gadget/configfs.c           |   3 +
 drivers/usb/gadget/legacy/audio.c       |   4 +-
 drivers/usb/gadget/legacy/cdc2.c        |   4 +-
 drivers/usb/gadget/legacy/inode.c       |   3 +-
 drivers/usb/gadget/legacy/ncm.c         |   4 +-
 drivers/usb/gadget/legacy/raw_gadget.c  | 315 +++++++++++++++++++++++++-------
 drivers/usb/gadget/udc/atmel_usba_udc.c |   4 +-
 drivers/usb/gadget/udc/net2272.c        |   2 +
 drivers/usb/gadget/udc/tegra-xudc.c     |   8 +-
 drivers/usb/host/xhci-plat.c            |   4 +-
 drivers/usb/host/xhci-ring.c            |   4 +-
 drivers/usb/mtu3/mtu3_debugfs.c         |   4 +-
 drivers/usb/phy/phy-twl6030-usb.c       |  12 +-
 drivers/usb/typec/mux/intel_pmc_mux.c   |   6 +-
 include/uapi/linux/usb/raw_gadget.h     | 108 +++++++++--
 22 files changed, 448 insertions(+), 123 deletions(-)
