Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MENTIONS_GIT_HOSTING,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org ([198.145.29.99]:52340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgCKQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:27:36 -0400
Date: Wed, 11 Mar 2020 09:27:35 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.6-rc6
Message-ID: <20200311162735.GA152176@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

Sorry for late pull request. Could you please consider this?

Thanks,

The following changes since commit b19e8c68470385dd2c5440876591fddb02c8c402:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2020-02-13 14:36:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6-rc6

for you to fetch changes up to 2536ac6872e5265b4d9d263122cee02e3d5cae1d:

  f2fs: allow to clear F2FS_COMPR_FL flag (2020-03-11 08:25:38 -0700)

----------------------------------------------------------------
f2fs-for-5.6-rc6

Some major bug fixes wrt compression:
- compressed block count
- memory access and leak
- remove obsolete fields
- flag controls

And some others:
- replace rwsem with spinlock
- potential deadlock

----------------------------------------------------------------
Chao Yu (14):
      f2fs: fix to wait all node page writeback
      f2fs: fix to avoid NULL pointer dereference
      f2fs: recycle unused compress_data.chksum feild
      f2fs: add missing function name in kernel message
      f2fs: fix to avoid potential deadlock
      f2fs: fix to check i_compr_blocks correctly
      f2fs: cover last_disk_size update with spinlock
      f2fs: remove i_sem lock coverage in f2fs_setxattr()
      f2fs: fix inconsistent comments
      f2fs: fix to avoid using uninitialized variable
      f2fs: fix to avoid use-after-free in f2fs_write_multi_pages()
      f2fs: fix to account compressed inode correctly
      f2fs: fix to check dirty pages during compressed inode conversion
      f2fs: allow to clear F2FS_COMPR_FL flag

Eric Biggers (1):
      f2fs: fix leaking uninitialized memory in compressed clusters

Jaegeuk Kim (1):
      f2fs: fix wrong check on F2FS_IOC_FSSETXATTR

Sahitya Tummala (1):
      f2fs: fix the panic in do_checkpoint()

 fs/f2fs/checkpoint.c | 34 +++++++++++-----------------------
 fs/f2fs/compress.c   | 24 ++++++++++++++----------
 fs/f2fs/data.c       | 23 ++++++++---------------
 fs/f2fs/f2fs.h       | 18 ++++++++++--------
 fs/f2fs/file.c       | 40 +++++++++++++++++++++++++---------------
 fs/f2fs/gc.c         |  5 ++++-
 fs/f2fs/inode.c      | 25 +++++++++++++++++++++----
 fs/f2fs/namei.c      |  2 +-
 fs/f2fs/node.c       | 18 ++++++++----------
 fs/f2fs/shrinker.c   |  2 +-
 fs/f2fs/super.c      |  7 ++++---
 fs/f2fs/xattr.c      |  3 ---
 12 files changed, 107 insertions(+), 94 deletions(-)

