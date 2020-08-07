Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721912086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHGX03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:26:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F862C061756;
        Fri,  7 Aug 2020 16:26:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4Bkp-00BQKJ-4u; Fri, 07 Aug 2020 23:26:27 +0000
Date:   Sat, 8 Aug 2020 00:26:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] assorted vfs patches
Message-ID: <20200807232627.GY1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	misc pile; there's more locally, but the rest hadn't sat in -next,
so...  No common topic whatsoever in those, sorry.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 6414e9b09ffd197803f8e86ce2fafdaf1de4e8e4:

  fs: define inode flags using bit numbers (2020-07-27 14:39:53 -0400)

----------------------------------------------------------------
Al Viro (1):
      dlmfs: clean up dlmfs_file_{read,write}() a bit

Eric Biggers (1):
      fs: define inode flags using bit numbers

Herbert Xu (1):
      iov_iter: Move unnecessary inclusion of crypto/hash.h

 arch/s390/lib/test_unwind.c                    |  1 +
 drivers/dma/sf-pdma/sf-pdma.c                  |  1 +
 drivers/dma/st_fdma.c                          |  1 +
 drivers/dma/uniphier-xdmac.c                   |  1 +
 drivers/misc/uacce/uacce.c                     |  1 +
 drivers/mtd/mtdpstore.c                        |  1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c |  1 +
 drivers/remoteproc/qcom_q6v5_mss.c             |  1 +
 drivers/soc/qcom/pdr_interface.c               |  1 +
 fs/btrfs/inode.c                               |  1 +
 fs/ocfs2/dlmfs/dlmfs.c                         | 52 ++++----------------------
 fs/ocfs2/dlmfs/userdlm.c                       | 12 ++----
 fs/ocfs2/dlmfs/userdlm.h                       |  4 +-
 include/linux/fs.h                             | 36 +++++++++---------
 include/linux/skbuff.h                         |  1 +
 include/linux/socket.h                         |  1 +
 include/linux/uio.h                            |  1 -
 lib/iov_iter.c                                 |  3 +-
 18 files changed, 45 insertions(+), 75 deletions(-)
