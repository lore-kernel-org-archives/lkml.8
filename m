Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BC5C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591372072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661085;
	bh=/4yYO4GgZbxmA0zei073nwkDkE9sDQW5NYyQ+MEZxFs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AlRTlPhwAmFO3wo3X7l9j2lsO9stmqSJ3XiGIt55lQHluj9RmoHgJtFk6ryJ33tcr
	 Npk/L8EMRDi1pg5LtgBpbNIAtE24rLf18RTzK6ivIhueuqa2ryNOfMPEioxvu9R30j
	 FK4DLl4zK/p/Y6P1DEqe3gvfgp8SHQ1B7gOUk2aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgCHJvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgCHJvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:51:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE63B2072A;
        Sun,  8 Mar 2020 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661080;
        bh=/4yYO4GgZbxmA0zei073nwkDkE9sDQW5NYyQ+MEZxFs=;
        h=Date:From:To:Cc:Subject:From;
        b=Q244NCGRIsDq5YUL2s33zrUFkb7EzboKf7F2rI9VgH4mPMpFsTmKqy4xOmYZou0jO
         UJEw5COrQnRlchYdMEi8Xo1aNjUekFU/0uU6wUhjb3Te0NdP6NmYSb3T9OEReNKpZH
         05+lS5rNAvBdKpD1yQ2kZV55+1oCB94tVSjlArRM=
Date:   Sun, 8 Mar 2020 10:51:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY fixes for 5.6-rc6
Message-ID: <20200308095118.GA4026918@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc5

for you to fetch changes up to 19f3c1e98bd1704fe22e5f8105c0677a1332cdef:

  Merge tag 'phy-for-5.6-rc_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy into usb-linus (2020-03-04 13:28:52 +0100)

----------------------------------------------------------------
USB/PHY fixes for 5.6-rc5

Here are some small USB and PHY driver fixes for reported issues for
5.6-rc5.

Included in here are:
	- phy driver fixes
	- new USB quirks
	- USB cdns3 gadget driver fixes
	- USB hub core fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Lazewatsky (1):
      usb: quirks: add NO_LPM quirk for Logitech Screen Share

Eugeniu Rosca (3):
      usb: core: hub: fix unhandled return by employing a void function
      usb: core: hub: do error out if usb_autopm_get_interface() fails
      usb: core: port: do error out if usb_autopm_get_interface() fails

Florian Fainelli (1):
      phy: brcm-sata: Correct MDIO operations for 40nm platforms

Greg Kroah-Hartman (1):
      Merge tag 'phy-for-5.6-rc_v2' of git://git.kernel.org/.../kishon/linux-phy into usb-linus

Grygorii Strashko (2):
      phy: ti: gmii-sel: fix set of copy-paste errors
      phy: ti: gmii-sel: do not fail in case of gmii

Jim Lin (1):
      usb: storage: Add quirk for Samsung Fit flash

Kishon Vijay Abraham I (1):
      phy: core: Fix phy_get() to not return error on link creation failure

Marco Felsch (1):
      usb: usb251xb: fix regulator probe and error handling

Peter Chen (2):
      usb: cdns3: gadget: link trb should point to next request
      usb: cdns3: gadget: toggle cycle bit before reset endpoint

Pratham Pratap (1):
      usb: dwc3: gadget: Update chain bit correctly when using sg list

Rikard Falkeborn (1):
      phy: allwinner: Fix GENMASK misuse

Tony Lindgren (2):
      phy: mapphone-mdm6600: Fix write timeouts with shorter GPIO toggle interval
      phy: mapphone-mdm6600: Fix timeouts by adding wake-up handling

 drivers/phy/allwinner/phy-sun50i-usb3.c     |   2 +-
 drivers/phy/broadcom/phy-brcm-sata.c        | 148 ++++++++++++----------------
 drivers/phy/motorola/phy-mapphone-mdm6600.c |  27 ++++-
 drivers/phy/phy-core.c                      |  18 ++--
 drivers/phy/ti/phy-gmii-sel.c               |  10 +-
 drivers/usb/cdns3/gadget.c                  |  19 +++-
 drivers/usb/core/hub.c                      |   8 +-
 drivers/usb/core/port.c                     |  10 +-
 drivers/usb/core/quirks.c                   |   3 +
 drivers/usb/dwc3/gadget.c                   |   9 +-
 drivers/usb/misc/usb251xb.c                 |  20 +++-
 drivers/usb/storage/unusual_devs.h          |   6 ++
 12 files changed, 163 insertions(+), 117 deletions(-)
