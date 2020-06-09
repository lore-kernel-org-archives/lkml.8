Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D432078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591714548;
	bh=BF+cXi+7DiXOmQtwIVkBHZHxL6wHaax5daopJSkGa3Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=B73Ck/mgMbhrwe0uMrYdz4dKvYhUww+SQeu3hSpmco5+Pye4W8qSOXTYKvcPp4YK3
	 bHl8N3wVTcmeaygIpRfeHwA8IxfoSUrlRZyn7MWxmCpxpU4pOtE6tCQ21Jx5DJrxnN
	 JFCaxGDBSRo18pNQs4bgkkK/bOTUcAQgmuR4Z0Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgFIOzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbgFIOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:55:46 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1ECC20774;
        Tue,  9 Jun 2020 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591714544;
        bh=BF+cXi+7DiXOmQtwIVkBHZHxL6wHaax5daopJSkGa3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=AqYMJ08ricRIRXWu3BTtYt3yol3i15YRh9yuYM8FuhDSeuOJxG+F++hlP2N8WVplQ
         B0ERDDEFE/skMbd4DxhiiXC9ll3yDqmI4VGPZDgEkrgY91vWQYqweEb5ou74H0usOc
         04q5P9YdfK3z+89Jb/A92tqzy8MVNi4hRDdwsjnw=
Date:   Tue, 9 Jun 2020 07:55:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.8-rc1
Message-ID: <20200609145544.GA171717@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 63bef48fd6c9d3f1ba4f0e23b4da1e007db6a3c0:

  Merge branch 'akpm' (patches from Andrew) (2020-04-07 14:11:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.8

for you to fetch changes up to b7b911d59dacb47511a1e604bbfa901beb108305:

  f2fs: attach IO flags to the missing cases (2020-06-08 20:37:54 -0700)

----------------------------------------------------------------
f2fs-for-5.8-rc1

In this round, we've added some knobs to enhance compression feature and harden
testing environment. In addition, we've fixed several bugs reported from Android
devices such as long discarding latency, device hanging during quota_sync, etc.

Enhancement:
- support lzo-rle algorithm
- add two ioctls to release and reserve blocks for compression
- support partial truncation/fiemap on compressed file
- introduce sysfs entries to attach IO flags explicitly
- add iostat trace point along with read io stat

Bug fix:
- fix long discard latency
- flush quota data by f2fs_quota_sync correctly
- fix to recover parent inode number for power-cut recovery
- fix lz4/zstd output buffer budget
- parse checkpoint mount option correctly
- avoid inifinite loop to wait for flushing node/meta pages
- manage discard space correctly

And some refactoring and clean up patches were added.

----------------------------------------------------------------
Chao Yu (23):
      f2fs: fix to handle error path of f2fs_ra_meta_pages()
      f2fs: support read iostat
      f2fs: remove redundant compress inode check
      f2fs: support partial truncation on compressed inode
      f2fs: support fiemap on compressed inode
      f2fs: introduce f2fs_bmap_compress()
      f2fs: introduce mempool for {,de}compress intermediate page allocation
      f2fs: compress: support lzo-rle compress algorithm
      f2fs: shrink spinlock coverage
      f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS
      f2fs: compress: let lz4 compressor handle output buffer budget properly
      f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS
      f2fs: use round_up to enhance calculation
      f2fs: compress: don't handle non-compressed data in workqueue
      f2fs: fix potential use-after-free issue
      f2fs: add compressed/gc data read IO stat
      f2fs: compress: fix zstd data corruption
      f2fs: fix wrong value of tracepoint parameter
      f2fs: remove unneeded return value of __insert_discard_tree()
      f2fs: compress: don't compress any datas after cp stop
      f2fs: fix wrong discard space
      f2fs: handle readonly filesystem in f2fs_ioc_shutdown()
      f2fs: remove unused parameter of f2fs_put_rpages_mapping()

Chengguang Xu (1):
      f2fs: code cleanup by removing ifdef macro surrounding

Colin Ian King (1):
      f2fs: remove redundant assignment to variable err

Daeho Jeong (2):
      f2fs: add tracepoint for f2fs iostat
      f2fs: protect new segment allocation in expand_inode_data

Eric Biggers (7):
      f2fs: use strcmp() in parse_options()
      f2fs: don't leak filename in f2fs_try_convert_inline_dir()
      f2fs: split f2fs_d_compare() from f2fs_match_name()
      f2fs: rework filename handling
      f2fs: correctly fix the parent inode number during fsync()
      f2fs: don't return vmalloc() memory from f2fs_kmalloc()
      f2fs: avoid utf8_strncasecmp() with unstable name

Jaegeuk Kim (9):
      f2fs: introduce sysfs/data_io_flag to attach REQ_META/FUA
      f2fs: fix quota_sync failure due to f2fs_lock_op
      f2fs: remove blk_plugging in block_operations
      f2fs: refactor resize_fs to avoid meta updates in progress
      f2fs: fix checkpoint=disable:%u%%
      f2fs: flush dirty meta pages when flushing them
      f2fs: avoid inifinite loop to wait for flushing node pages at cp_error
      f2fs: add node_io_flag for bio flags likewise data_io_flag
      f2fs: attach IO flags to the missing cases

Konstantin Khlebnikov (1):
      f2fs: report delalloc reserve as non-free in statfs for project quota

Nishad Kamdar (1):
      f2fs: Use the correct style for SPDX License Identifier

Sahitya Tummala (4):
      f2fs: fix long latency due to discard during umount
      f2fs: report the discard cmd errors properly
      f2fs: Fix the accounting of dcc->undiscard_blks
      f2fs: fix retry logic in f2fs_write_cache_pages()

Sayali Lokhande (1):
      f2fs: Avoid double lock for cp_rwsem during checkpoint

YueHaibing (1):
      f2fs: Fix wrong stub helper update_sit_info

 Documentation/ABI/testing/sysfs-fs-f2fs |  24 ++
 Documentation/filesystems/f2fs.rst      |   2 +-
 fs/f2fs/Kconfig                         |  10 +
 fs/f2fs/acl.h                           |   2 +-
 fs/f2fs/checkpoint.c                    |  37 +--
 fs/f2fs/compress.c                      | 182 ++++++++++++---
 fs/f2fs/data.c                          | 163 +++++++++++--
 fs/f2fs/dir.c                           | 374 ++++++++++++++++-------------
 fs/f2fs/f2fs.h                          | 171 ++++++++++----
 fs/f2fs/file.c                          | 401 +++++++++++++++++++++++++++++---
 fs/f2fs/gc.c                            | 125 ++++++----
 fs/f2fs/gc.h                            |   2 +-
 fs/f2fs/hash.c                          |  76 +++---
 fs/f2fs/inline.c                        |  49 ++--
 fs/f2fs/namei.c                         |  19 +-
 fs/f2fs/node.c                          | 101 ++++++--
 fs/f2fs/node.h                          |   5 +-
 fs/f2fs/recovery.c                      |  51 +++-
 fs/f2fs/segment.c                       |  40 +++-
 fs/f2fs/segment.h                       |   2 +-
 fs/f2fs/super.c                         |  88 ++++---
 fs/f2fs/sysfs.c                         |  97 ++++++--
 fs/f2fs/trace.h                         |   2 +-
 fs/f2fs/xattr.h                         |   8 +-
 include/trace/events/f2fs.h             |  83 ++++++-
 25 files changed, 1580 insertions(+), 534 deletions(-)
