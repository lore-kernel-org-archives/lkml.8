Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E098BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21372073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgFASiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbgFASho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:37:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B420DC008639
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:32:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfpE7-001XGJ-76; Mon, 01 Jun 2020 18:31:59 +0000
Date:   Mon, 1 Jun 2020 19:31:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] uaccess __copy_to_user
Message-ID: <20200601183159.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Getting rid of __copy_to_user() callers - stuff that
doesn't fit into other series.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__copy_to_user

for you to fetch changes up to 0702e4f39034f15855def3165fe7213c7c2c0163:

  dlmfs: convert dlmfs_file_read() to copy_to_user() (2020-04-23 14:02:49 -0400)

----------------------------------------------------------------
Al Viro (2):
      esas2r: don't bother with __copy_to_user()
      dlmfs: convert dlmfs_file_read() to copy_to_user()

 drivers/scsi/esas2r/esas2r_ioctl.c |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c             | 33 ++++++++++++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)
