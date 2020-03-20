Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10870C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ECE2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584714463;
	bh=ZMV8PC35BsbyE5rkXVZ62gtO1IW15NGYTzww9GsH/Aw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=laIn2cut/wPdpQC6KB0b+G0cwK2seV2KzX9xSHyFzMpol8lvvYEIG/47Z1P2ZXion
	 9xsz1eT/x5PKyBOwEDD6kHjIGhUV191Yxic6SnMWAknnnbisKUZuMEZv9Q5Jhx2jaF
	 tBWRB4zlYa/E0++EPachmh40YhYuUx7UQOIGolTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCTO1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCTO1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:27:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074EA2070A;
        Fri, 20 Mar 2020 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714461;
        bh=ZMV8PC35BsbyE5rkXVZ62gtO1IW15NGYTzww9GsH/Aw=;
        h=Date:From:To:Cc:Subject:From;
        b=QcAH3tuD3oD4fJDXPwdP+1Cu9Jb6gEGSBZFIsvE9kfeMm4du2wd9wl/OsXf2wlmn7
         Ma15ocxuYyO+yqFmqRFUyNTd9uzgQlqoT65wEk/3DC7Uzp38lflDeRN+4Yw6yPUO0M
         TAHWEmPsNtYO5Ta0NNe7S8Dp3IBlCf2I+pYev2DU=
Date:   Fri, 20 Mar 2020 15:27:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.6-rc7
Message-ID: <20200320142739.GA760409@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc7

for you to fetch changes up to 2866ce8696167de300e27d50d521b5f671bab5d4:

  Merge tag 'usb-serial-5.6-rc7' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2020-03-18 10:42:57 +0100)

----------------------------------------------------------------
USB fixes for 5.6-rc7

Here are some small USB fixes for 5.6-rc7.  And there's a thunderbolt
driver fix thrown in for good measure as well.

These fixes are:
	- new device ids for usb-serial drivers
	- thunderbolt error code fix
	- xhci driver fixes
	- typec fixes
	- cdc-acm driver fixes
	- chipidea driver fix
	- more USB quirks added for devices that need them.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alberto Mattea (1):
      usb: xhci: apply XHCI_SUSPEND_DELAY to AMD XHCI controller 1022:145c

Anthony Mallet (2):
      USB: cdc-acm: fix close_delay and closing_wait units in TIOCSSERIAL
      USB: cdc-acm: fix rounding error in TIOCSSERIAL

Dan Carpenter (1):
      thunderbolt: Fix error code in tb_port_is_width_supported()

Daniele Palmas (1):
      USB: serial: option: add ME910G1 ECM composition 0x110b

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-fix-for-v5.6-rc6' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-5.6-rc7' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Hans de Goede (1):
      usb: quirks: add NO_LPM quirk for RTL8153 based ethernet adapters

Heikki Krogerus (2):
      usb: typec: ucsi: displayport: Fix NULL pointer dereference
      usb: typec: ucsi: displayport: Fix a potential race during registration

Kai-Heng Feng (1):
      USB: Disable LPM on WD19's Realtek Hub

Peter Chen (1):
      usb: chipidea: udc: fix sleeping function called from invalid context

Ran Wang (1):
      usb: host: xhci-plat: add a shutdown

Scott Chen (1):
      USB: serial: pl2303: add device-id for HP LD381

Steven Rostedt (VMware) (1):
      xhci: Do not open code __print_symbolic() in xhci trace events

 drivers/thunderbolt/switch.c         |  2 +-
 drivers/usb/chipidea/udc.c           |  7 ++++---
 drivers/usb/class/cdc-acm.c          | 34 +++++++++++++++++++++-------------
 drivers/usb/core/quirks.c            |  6 ++++++
 drivers/usb/host/xhci-pci.c          |  3 ++-
 drivers/usb/host/xhci-plat.c         |  1 +
 drivers/usb/host/xhci-trace.h        | 23 ++++++-----------------
 drivers/usb/serial/option.c          |  2 ++
 drivers/usb/serial/pl2303.c          |  1 +
 drivers/usb/serial/pl2303.h          |  1 +
 drivers/usb/typec/ucsi/displayport.c | 12 +++++++++++-
 11 files changed, 56 insertions(+), 36 deletions(-)
