Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0594C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B430E206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgFASnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbgFASmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE5C0A88B4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:25:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfp7l-001X9U-0O; Mon, 01 Jun 2020 18:25:25 +0000
Date:   Mon, 1 Jun 2020 19:25:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] uaccess access_ok()
Message-ID: <20200601182524.GB23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Removals of trivially pointless access_ok() calls.  Note: fiemap
stuff removed from the series, since they are duplicates with part of
ext4 series carried in Ted's tree

The following changes since commit 3815f1be546e752327b5868af103ccdddcc4db77:

  dlmfs_file_write(): fix the bogosity in handling non-zero *ppos (2020-04-23 13:45:27 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.access_ok

for you to fetch changes up to 87c233b8158a20a9c9ab1da96cb5cb1734d9006e:

  vmci_host: get rid of pointless access_ok() (2020-05-29 11:06:38 -0400)

----------------------------------------------------------------
Al Viro (19):
      dlmfs_file_write(): get rid of pointless access_ok()
      fat_dir_ioctl(): hadn't needed that access_ok() for more than a decade...
      btrfs_ioctl_send(): don't bother with access_ok()
      tomoyo_write_control(): get rid of pointless access_ok()
      n_hdlc_tty_read(): remove pointless access_ok()
      nvram: drop useless access_ok()
      cm4000_cs.c cmm_ioctl(): get rid of pointless access_ok()
      drivers/fpga/dfl-fme-pr.c: get rid of pointless access_ok()
      drivers/fpga/dfl-afu-dma-region.c: get rid of pointless access_ok()
      amifb: get rid of pointless access_ok() calls
      omapfb: get rid of pointless access_ok() calls
      drivers/crypto/ccp/sev-dev.c: get rid of pointless access_ok()
      via-pmu: don't bother with access_ok()
      drm_read(): get rid of pointless access_ok()
      efi_test: get rid of pointless access_ok()
      lpfc_debugfs: get rid of pointless access_ok()
      usb: get rid of pointless access_ok() calls
      hfi1: get rid of pointless access_ok()
      vmci_host: get rid of pointless access_ok()

 drivers/char/nvram.c                            |  4 ----
 drivers/char/pcmcia/cm4000_cs.c                 | 14 --------------
 drivers/crypto/ccp/sev-dev.c                    | 15 +++------------
 drivers/firmware/efi/test/efi_test.c            | 12 ------------
 drivers/fpga/dfl-afu-dma-region.c               |  4 ----
 drivers/fpga/dfl-fme-pr.c                       |  4 ----
 drivers/gpu/drm/drm_file.c                      |  3 ---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c       |  7 -------
 drivers/macintosh/via-pmu.c                     |  2 --
 drivers/misc/vmw_vmci/vmci_host.c               |  2 --
 drivers/scsi/lpfc/lpfc_debugfs.c                | 12 ------------
 drivers/tty/n_hdlc.c                            |  7 -------
 drivers/usb/core/devices.c                      |  2 --
 drivers/usb/core/devio.c                        |  9 ---------
 drivers/usb/gadget/function/f_hid.c             |  6 ------
 drivers/video/fbdev/amifb.c                     |  4 ----
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |  3 ---
 fs/btrfs/send.c                                 |  7 -------
 fs/fat/dir.c                                    |  4 ----
 fs/ocfs2/dlmfs/dlmfs.c                          |  3 ---
 security/tomoyo/common.c                        |  2 --
 21 files changed, 3 insertions(+), 123 deletions(-)
