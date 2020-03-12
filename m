Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A488C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D22D20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCLWhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:37:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCLWhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:37:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCWRx-00APHt-9B; Thu, 12 Mar 2020 22:37:09 +0000
Date:   Thu, 12 Mar 2020 22:37:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20200312223709.GM23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	A couple of fixes for old crap in ->atomic_open() instances.

The following changes since commit bf4498ad3f9a0f7202cf90e52b5ce9bb31700b91:

  tmpfs: deny and force are not huge mount options (2020-02-18 15:07:30 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to d9a9f4849fe0c9d560851ab22a85a666cddfdd24:

  cifs_atomic_open(): fix double-put on late allocation failure (2020-03-12 18:25:20 -0400)

----------------------------------------------------------------
Al Viro (2):
      gfs2_atomic_open(): fix O_EXCL|O_CREAT handling on cold dcache
      cifs_atomic_open(): fix double-put on late allocation failure

 Documentation/filesystems/porting.rst | 8 ++++++++
 fs/cifs/dir.c                         | 1 -
 fs/gfs2/inode.c                       | 2 +-
 fs/open.c                             | 3 ---
 4 files changed, 9 insertions(+), 5 deletions(-)
