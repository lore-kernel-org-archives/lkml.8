Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422BCC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153FD24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285196;
	bh=f4ezhykKHcP/SWrvI48MdWlXIkNcS65/Djgm3IMolHs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ag2mlO4MlEXdxQOIl8Pg4Ne07m+UXxRbFbCGm1HnIY+5+rpI+0kfcG5ERMYTbRSt0
	 4e6XL6q7lO/k4mbYAGXlklWmv+Cynn5qtzwxlJRaslANlgYAY30DrdYXOBoXCDhoeI
	 p9DBLCiYXYge1RuhuIqOu8VcWHVC5sXCpW7dHyHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBULjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgBULjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:39:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02C5222C4;
        Fri, 21 Feb 2020 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285194;
        bh=f4ezhykKHcP/SWrvI48MdWlXIkNcS65/Djgm3IMolHs=;
        h=Date:From:To:Cc:Subject:From;
        b=XpQ1mAzlntRYGnrUF68ySE4KCPEBC/+uYg9yNfYw0VOmbL1dPBqT/mBlvFrR9M8sP
         rlUioMTfnMh4AauwauGJ49vou9YyvQAMsY9pu4Yu2ZBNXjPbgPHmKyA0UJUesgMSrI
         Y9ispbtswT0u+acLFe/43qxtPwnlwexsXTYPorKs=
Date:   Fri, 21 Feb 2020 12:39:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.6-rc3
Message-ID: <20200221113952.GA114312@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc3

for you to fetch changes up to 9a4556bd8f23209c29f152e6a930b6a893b0fc81:

  staging: rtl8723bs: Remove unneeded goto statements (2020-02-10 10:32:38 -0800)

----------------------------------------------------------------
Staging driver fixes for 5.6-rc3

Here are some small staging driver fixes for 5.6-rc3, along with the
removal of an unused/unneeded driver as well.

The android vsoc driver is not needed anymore by anyone, so it was
removed.

The other driver fixes are:
	- ashmem bugfixes
	- greybus audio driver bugfix
	- wireless driver bugfixes and tiny cleanups to error paths

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alistair Delva (1):
      staging: android: Delete the 'vsoc' driver

Colin Ian King (1):
      staging: rtl8723bs: fix copy of overlapping memory

Dan Carpenter (1):
      staging: greybus: use after free in gb_audio_manager_remove_all()

Larry Finger (6):
      staging: rtl8188eu: Fix potential security hole
      staging: rtl8723bs: Fix potential security hole
      staging: rtl8188eu: Fix potential overuse of kernel memory
      staging: rtl8723bs: Fix potential overuse of kernel memory
      staging: rtl8188eu: Remove some unneeded goto statements
      staging: rtl8723bs: Remove unneeded goto statements

Malcolm Priestley (1):
      staging: vt6656: fix sign of rx_dbm to bb_pre_ed_rssi.

Suren Baghdasaryan (1):
      staging: android: ashmem: Disallow ashmem memory from being remapped

 drivers/staging/android/Kconfig                |    8 -
 drivers/staging/android/Makefile               |    1 -
 drivers/staging/android/TODO                   |    9 -
 drivers/staging/android/ashmem.c               |   28 +
 drivers/staging/android/uapi/vsoc_shm.h        |  295 ------
 drivers/staging/android/vsoc.c                 | 1149 ------------------------
 drivers/staging/greybus/audio_manager.c        |    2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |   40 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c |    5 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c |   47 +-
 drivers/staging/vt6656/dpc.c                   |    2 +-
 11 files changed, 56 insertions(+), 1530 deletions(-)
 delete mode 100644 drivers/staging/android/uapi/vsoc_shm.h
 delete mode 100644 drivers/staging/android/vsoc.c
