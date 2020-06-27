Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63735C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41230206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593258028;
	bh=qmq9szqi1jr/mcGG6TCH1ke/JbSAHIzsfibraGAd27A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=F07dtDZr7+DQzBjKuX5Rh+TcmI5lsywJaBBPjVX+/8YvnuHFXzJHT109504sACmtj
	 tB+j+a2h0QuAzQXxVXhdx3m5+xZlRB0N+Z7/BHmBm4w3dMkmfAt0l6ZwbKIeecQidA
	 A7HLOBdKbUHWQEmUjfrPCjyeuEAdcN1qenoRSUAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgF0Lj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgF0Lj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:39:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EB621473;
        Sat, 27 Jun 2020 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593257998;
        bh=qmq9szqi1jr/mcGG6TCH1ke/JbSAHIzsfibraGAd27A=;
        h=Date:From:To:Cc:Subject:From;
        b=gDyU1Wn1/yWoisDQXPOh7JV3q1ZA2ifp5mzyf6PoUjqPhSX5XAsGfbxCGULe+DKh1
         5FjXai9ZhQgL6A3ljav95lAZRNnT0mCKVyYhP9B5SZYlYuAxn9Flsqma1IvGicyq3Q
         RFk33kpU+PuOljHnE9caqqHzCxhnb8psXoD8tRiU=
Date:   Sat, 27 Jun 2020 13:39:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.8-rc3
Message-ID: <20200627113952.GA1636771@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc3

for you to fetch changes up to 70b23b87b2d32e608f97e06425853331f17fbda9:

  Merge tag 'fpga-fixes-for-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-next (2020-06-26 17:26:31 +0200)

----------------------------------------------------------------
Char/Misc fixes for 5.8-rc3

Some tiny char/misc driver fixes for 5.8-rc3.

"largest" changes are in the mei driver, to resolve some reported
problems and add some new device ids.  There's also a binder bugfix, an
fpga driver build fix, and some assorted habanalabs fixes.

All of these, except for the habanalabs fixes, have been in linux-next
with no reported issues.  The habanalabs driver changes showed up in my
tree on Friday, but as they are totally self-contained, all should be
good there.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: me: add tiger lake point device ids for H platforms.

Arnd Bergmann (1):
      fpga: zynqmp: fix modular build

Greg Kroah-Hartman (2):
      Merge tag 'misc-habanalabs-fixes-2020-06-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus
      Merge tag 'fpga-fixes-for-5.8' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next

Oded Gabbay (3):
      habanalabs: block scalar load_and_exe on external queue
      habanalabs: rename mmu_write() to mmu_asid_va_write()
      habanalabs: increase GAUDI QMAN ARB WDT timeout

Ofir Bitton (1):
      habanalabs: Correct handling when failing to enqueue CB

Omer Shpigelman (2):
      habanalabs: use PI in MMU cache invalidation
      habanalabs: increase h/w timer when checking idle

Todd Kjos (1):
      binder: fix null deref of proc->context

Tomas Winkler (1):
      mei: me: disable mei interface on Mehlow server platforms

 drivers/android/binder.c                           | 14 ++---
 drivers/fpga/Kconfig                               |  2 +-
 drivers/misc/habanalabs/command_submission.c       | 13 ++++
 drivers/misc/habanalabs/debugfs.c                  |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 37 +++++++++++-
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  3 +
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |  3 +
 drivers/misc/mei/hw-me-regs.h                      |  3 +
 drivers/misc/mei/hw-me.c                           | 70 ++++++++++++++++++++--
 drivers/misc/mei/hw-me.h                           | 17 ++++--
 drivers/misc/mei/pci-me.c                          | 17 +++---
 11 files changed, 153 insertions(+), 30 deletions(-)
