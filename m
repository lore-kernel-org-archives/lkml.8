Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EC320769
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586228566;
	bh=H8kMi72CQfJQI3ITFQxHLoqUXy4N5fipuw3W/neWU/E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NVGSTBbuh8V32JzFQ6FOyYQMcjC++2Zi/cx9M34p+KalpWu0jplE3EQKfRtmXCQpP
	 DzLJqvWLbj5r2+p+K1l4O7KOMhhFuatajQZLOk8cYDXQFf1gb+TBrGCGixf2RjlKf6
	 kYR0KPHLX0ZShyLoG9hSdd7gbECWkLEslfDLBDWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGDCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDGDCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:02:44 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F72B2074F;
        Tue,  7 Apr 2020 03:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586228563;
        bh=H8kMi72CQfJQI3ITFQxHLoqUXy4N5fipuw3W/neWU/E=;
        h=Date:From:To:Cc:Subject:From;
        b=U3JBEfQqwuXNuc7cm7z6/c/FrmxW0K+4gW67st351yTGJ4cM9qd5fimXezXoPobt2
         7sQgO2h4eqsPY6r577qME7U3afEDbqwj6OnFWlWHSMg9UJFM8OPXeXYJVsLqh7NmDU
         toSL9NgNkXarKTwmHTS7Ps+d2YXdIOFLumBanL6s=
Date:   Mon, 6 Apr 2020 20:02:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>, kernel-team@android.com
Subject: [GIT PULL] f2fs-5.7-rc1
Message-ID: <20200407030242.GA139449@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thank you,

The following changes since commit b19e8c68470385dd2c5440876591fddb02c8c402:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2020-02-13 14:36:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.7-rc1

for you to fetch changes up to 531dfae52e8c386f72fc4935b97486409291fdb1:

  f2fs: keep inline_data when compression conversion (2020-04-03 10:21:32 -0700)

----------------------------------------------------------------
f2fs-for-5.7-rc1

In this round, we've mainly focused on fixing bugs and addressing issues in
recently introduced compression support.

Enhancement:
- add zstd support, and set LZ4 by default
- add ioctl() to show # of compressed blocks
- show mount time in debugfs
- replace rwsem with spinlock
- avoid lock contention in DIO reads

Some major bug fixes wrt compression:
- compressed block count
- memory access and leak
- remove obsolete fields
- flag controls

Other bug fixes and clean ups:
- fix overflow when handling .flags in inode_info
- fix SPO issue during resize FS flow
- fix compression with fsverity enabled
- potential deadlock when writing compressed pages
- show missing mount options

----------------------------------------------------------------
Chao Yu (53):
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
      f2fs: clean up codes with {f2fs_,}data_blkaddr()
      f2fs: clean up parameter of macro XATTR_SIZE()
      f2fs: fix to show norecovery mount option
      f2fs: clean up lfs/adaptive mount option
      f2fs: clean up bggc mount option
      f2fs: introduce DEFAULT_IO_TIMEOUT
      f2fs: add prefix for f2fs slab cache name
      f2fs: fix to avoid triggering IO in write path
      f2fs: introduce F2FS_IOC_GET_COMPRESS_BLOCKS
      f2fs: avoid __GFP_NOFAIL in f2fs_bio_alloc
      f2fs: fix to show tracepoint correctly
      f2fs: use kmem_cache pool during inline xattr lookups
      f2fs: fix to update f2fs_super_block fields under sb_lock
      f2fs: fix to account compressed blocks in f2fs_compressed_blocks()
      f2fs: don't mark compressed inode dirty during f2fs_iget()
      f2fs: fix potential deadlock on compressed quota file
      f2fs: don't change inode status under page lock
      f2fs: fix to avoid potential deadlock
      f2fs: clean up f2fs_may_encrypt()
      f2fs: fix NULL pointer dereference in f2fs_write_begin()
      f2fs: don't trigger data flush in foreground operation
      f2fs: don't call fscrypt_get_encryption_info() explicitly in f2fs_tmpfile()
      f2fs: fix to clear PG_error if fsverity failed
      f2fs: fix NULL pointer dereference in f2fs_verity_work()
      f2fs: fix potential .flags overflow on 32bit architecture
      f2fs: fix to avoid double unlock
      f2fs: fix to use f2fs_readpage_limit() in f2fs_read_multi_pages()
      f2fs: clean up {cic,dic}.ref handling
      f2fs: change default compression algorithm
      f2fs: compress: fix to call missing destroy_compress_ctx()
      f2fs: compress: add .{init,destroy}_decompress_ctx callback
      f2fs: compress: support zstd compress algorithm
      f2fs: clean up dic->tpages assignment
      f2fs: show compression in statx
      f2fs: fix to verify tpage before releasing in f2fs_free_dic()
      f2fs: switch discard_policy.timeout to bool type
      f2fs: add missing CONFIG_F2FS_FS_COMPRESSION
      f2fs: fix to disable compression on directory
      f2fs: keep inline_data when compression conversion

DongDongJu (1):
      f2fs: delete DIO read lock

Eric Biggers (1):
      f2fs: fix leaking uninitialized memory in compressed clusters

Gustavo A. R. Silva (1):
      f2fs: xattr.h: Replace zero-length array with flexible-array member

Jaegeuk Kim (5):
      f2fs: fix wrong check on F2FS_IOC_FSSETXATTR
      f2fs: show mounted time
      f2fs: add migration count iff migration happens
      f2fs: skip GC when section is full
      f2fs: skip migration only when BG_GC is called

Sahitya Tummala (3):
      f2fs: fix the panic in do_checkpoint()
      f2fs: Fix mount failure due to SPO after a successful online resize FS
      f2fs: Add a new CP flag to help fsck fix resize SPO issues

Takashi Iwai (1):
      f2fs: Use scnprintf() for avoiding potential buffer overflow

YueHaibing (1):
      f2fs: xattr.h: Make stub helpers inline

 Documentation/ABI/testing/sysfs-fs-f2fs |   5 +
 Documentation/filesystems/f2fs.txt      |   4 +-
 fs/f2fs/Kconfig                         |   9 +
 fs/f2fs/checkpoint.c                    |  42 ++---
 fs/f2fs/compress.c                      | 317 ++++++++++++++++++++++++++------
 fs/f2fs/data.c                          | 141 ++++++++------
 fs/f2fs/debug.c                         |   3 +
 fs/f2fs/dir.c                           |  16 +-
 fs/f2fs/f2fs.h                          | 206 ++++++++++++---------
 fs/f2fs/file.c                          |  91 +++++----
 fs/f2fs/gc.c                            |  51 +++--
 fs/f2fs/inode.c                         |  29 ++-
 fs/f2fs/namei.c                         |  12 +-
 fs/f2fs/node.c                          |  33 ++--
 fs/f2fs/recovery.c                      |  12 +-
 fs/f2fs/segment.c                       |  54 +++---
 fs/f2fs/segment.h                       |   2 +-
 fs/f2fs/shrinker.c                      |   2 +-
 fs/f2fs/super.c                         |  89 +++++----
 fs/f2fs/sysfs.c                         |  50 +++--
 fs/f2fs/xattr.c                         |  67 +++++--
 fs/f2fs/xattr.h                         |   9 +-
 include/linux/f2fs_fs.h                 |   1 +
 include/trace/events/f2fs.h             |   3 +-
 24 files changed, 820 insertions(+), 428 deletions(-)
