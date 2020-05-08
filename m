Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E73C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F3207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588947444;
	bh=bLwXedo8Z5RbxLvKHpXO3sLTNu62NYmH5D5djipUSns=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vJNNsyMRm4/kFHPehx5iTfboMxylKEhNPDUxVyAu+6Cu7z9Rrdidwu/gPnqnoD1tG
	 oqYPyBBMMi/cZf2mG3fblak10B87Xz/YG1ELUr77YNMTnmk7Qlt+oYYDoMqJNf80jP
	 YRBj1TpfE3Wz9/qMBlGTizO4eZq74Q78i5qbVKvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEHORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:17:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC56207DD;
        Fri,  8 May 2020 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947441;
        bh=bLwXedo8Z5RbxLvKHpXO3sLTNu62NYmH5D5djipUSns=;
        h=Date:From:To:Cc:Subject:From;
        b=0jFCGS9scSMtRpIqjL7EzhIO4qtP8m75EPrVlAh5Y/fTABf/AlFBpITooofCVAiVn
         e73q9n/U/KvROFZwoxXubTqLH6EtCkPVmO5yI4u+X5AQzTEHh+2uG/s10/mrehHEqZ
         Ia44HqKUlArJxCJMzIoHYBmWQkuSFtaKCnH906fM=
Date:   Fri, 8 May 2020 16:17:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.7-rc5
Message-ID: <20200508141718.GA324234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc5

for you to fetch changes up to 91edf63d5022bd0464788ffb4acc3d5febbaf81d:

  usb: chipidea: msm: Ensure proper controller reset using role switch API (2020-05-07 08:46:35 +0200)

----------------------------------------------------------------
USB fixes for 5.7-rc5

Here are some small USB fixes for 5.7-rc5 to resolve some reported
issues:
	- syzbot found problems fixed
	- usbfs dma mapping fix
	- typec bugfixs
	- chipidea bugfix
	- usb4/thunderbolt fix
	- new device ids/quirks

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: core: Fix misleading driver bug report

Bryan O'Donoghue (1):
      usb: chipidea: msm: Ensure proper controller reset using role switch API

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.7-rc5' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: typec: intel_pmc_mux: Fix the property names

Jeremy Linton (1):
      usb: usbfs: correct kernel->user page attribute mismatch

Matt Jolly (1):
      USB: serial: qcserial: Add DW5816e support

Mika Westerberg (1):
      thunderbolt: Check return value of tb_sw_read() in usb4_switch_op()

Oliver Neukum (2):
      USB: serial: garmin_gps: add sanity checking for data length
      USB: uas: add quirk for LaCie 2Big Quadra

Prashant Malani (1):
      usb: typec: mux: intel: Handle alt mode HPD_HIGH

 drivers/thunderbolt/usb4.c            | 3 +++
 drivers/usb/chipidea/ci_hdrc_msm.c    | 2 +-
 drivers/usb/core/devio.c              | 5 ++---
 drivers/usb/core/message.c            | 4 ++--
 drivers/usb/serial/garmin_gps.c       | 4 ++--
 drivers/usb/serial/qcserial.c         | 1 +
 drivers/usb/storage/unusual_uas.h     | 7 +++++++
 drivers/usb/typec/mux/intel_pmc_mux.c | 8 ++++++--
 8 files changed, 24 insertions(+), 10 deletions(-)
