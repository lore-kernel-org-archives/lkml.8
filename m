Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4711120738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgFVNjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:39:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:37606 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgFVNjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:39:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D23292C8;
        Mon, 22 Jun 2020 13:39:08 +0000 (UTC)
Date:   Mon, 22 Jun 2020 07:39:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "Reviewed-by: Theodore Ts'o" <tytso@mit.edu>,
        "Acked-by: Jaegeuk Kim" <jaegeuk@kernel.org>
Subject: [PATCH] docs: f2fs: fix a broken table
Message-ID: <20200622073907.7608a73a@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed318a6cc0b6 ("fscrypt: support test_dummy_encryption=v2") added an
entry to the massive option table in Documentation/filesystems/f2fs.txt.
The option was too wide for the formatting of the table, though, leading to
a verbose and ugly docs-build warning starting with:

    Documentation/filesystems/f2fs.rst:229: WARNING: Malformed table.
    Text in column margin in table line 126.

Fixing this requires formatting the whole table; let's hear it for Emacs
query-replace-regexp.  No changes were made to the actual text.

Fixes: ed318a6cc0b6 ("fscrypt: support test_dummy_encryption=v2")
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/filesystems/f2fs.rst | 312 ++++++++++++++---------------
 1 file changed, 156 insertions(+), 156 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 099d45ac8d8f7..1e7dade24a199 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -101,164 +101,164 @@ Mount Options
 =============
 
 
-====================== ============================================================
-background_gc=%s       Turn on/off cleaning operations, namely garbage
-                       collection, triggered in background when I/O subsystem is
-                       idle. If background_gc=on, it will turn on the garbage
-                       collection and if background_gc=off, garbage collection
-                       will be turned off. If background_gc=sync, it will turn
-                       on synchronous garbage collection running in background.
-                       Default value for this option is on. So garbage
-                       collection is on by default.
-disable_roll_forward   Disable the roll-forward recovery routine
-norecovery             Disable the roll-forward recovery routine, mounted read-
-                       only (i.e., -o ro,disable_roll_forward)
-discard/nodiscard      Enable/disable real-time discard in f2fs, if discard is
-                       enabled, f2fs will issue discard/TRIM commands when a
-		       segment is cleaned.
-no_heap                Disable heap-style segment allocation which finds free
-                       segments for data from the beginning of main area, while
-		       for node from the end of main area.
-nouser_xattr           Disable Extended User Attributes. Note: xattr is enabled
-                       by default if CONFIG_F2FS_FS_XATTR is selected.
-noacl                  Disable POSIX Access Control List. Note: acl is enabled
-                       by default if CONFIG_F2FS_FS_POSIX_ACL is selected.
-active_logs=%u         Support configuring the number of active logs. In the
-                       current design, f2fs supports only 2, 4, and 6 logs.
-                       Default number is 6.
-disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
-                       does not aware of cold files such as media files.
-inline_xattr           Enable the inline xattrs feature.
-noinline_xattr         Disable the inline xattrs feature.
-inline_xattr_size=%u   Support configuring inline xattr size, it depends on
-		       flexible inline xattr feature.
-inline_data            Enable the inline data feature: New created small(<~3.4k)
-                       files can be written into inode block.
-inline_dentry          Enable the inline dir feature: data in new created
-                       directory entries can be written into inode block. The
-                       space of inode block which is used to store inline
-                       dentries is limited to ~3.4k.
-noinline_dentry        Disable the inline dentry feature.
-flush_merge	       Merge concurrent cache_flush commands as much as possible
-                       to eliminate redundant command issues. If the underlying
-		       device handles the cache_flush command relatively slowly,
-		       recommend to enable this option.
-nobarrier              This option can be used if underlying storage guarantees
-                       its cached data should be written to the novolatile area.
-		       If this option is set, no cache_flush commands are issued
-		       but f2fs still guarantees the write ordering of all the
-		       data writes.
-fastboot               This option is used when a system wants to reduce mount
-                       time as much as possible, even though normal performance
-		       can be sacrificed.
-extent_cache           Enable an extent cache based on rb-tree, it can cache
-                       as many as extent which map between contiguous logical
-                       address and physical address per inode, resulting in
-                       increasing the cache hit ratio. Set by default.
-noextent_cache         Disable an extent cache based on rb-tree explicitly, see
-                       the above extent_cache mount option.
-noinline_data          Disable the inline data feature, inline data feature is
-                       enabled by default.
-data_flush             Enable data flushing before checkpoint in order to
-                       persist data of regular and symlink.
-reserve_root=%d        Support configuring reserved space which is used for
-                       allocation from a privileged user with specified uid or
-                       gid, unit: 4KB, the default limit is 0.2% of user blocks.
-resuid=%d              The user ID which may use the reserved blocks.
-resgid=%d              The group ID which may use the reserved blocks.
-fault_injection=%d     Enable fault injection in all supported types with
-                       specified injection rate.
-fault_type=%d          Support configuring fault injection type, should be
-                       enabled with fault_injection option, fault type value
-                       is shown below, it supports single or combined type.
-
-                       ===================	===========
-                       Type_Name		Type_Value
-                       ===================	===========
-                       FAULT_KMALLOC		0x000000001
-                       FAULT_KVMALLOC		0x000000002
-                       FAULT_PAGE_ALLOC		0x000000004
-                       FAULT_PAGE_GET		0x000000008
-                       FAULT_ALLOC_BIO		0x000000010
-                       FAULT_ALLOC_NID		0x000000020
-                       FAULT_ORPHAN		0x000000040
-                       FAULT_BLOCK		0x000000080
-                       FAULT_DIR_DEPTH		0x000000100
-                       FAULT_EVICT_INODE	0x000000200
-                       FAULT_TRUNCATE		0x000000400
-                       FAULT_READ_IO		0x000000800
-                       FAULT_CHECKPOINT		0x000001000
-                       FAULT_DISCARD		0x000002000
-                       FAULT_WRITE_IO		0x000004000
-                       ===================	===========
-mode=%s                Control block allocation mode which supports "adaptive"
-                       and "lfs". In "lfs" mode, there should be no random
-                       writes towards main area.
-io_bits=%u             Set the bit size of write IO requests. It should be set
-                       with "mode=lfs".
-usrquota               Enable plain user disk quota accounting.
-grpquota               Enable plain group disk quota accounting.
-prjquota               Enable plain project quota accounting.
-usrjquota=<file>       Appoint specified file and type during mount, so that quota
-grpjquota=<file>       information can be properly updated during recovery flow,
-prjjquota=<file>       <quota file>: must be in root directory;
-jqfmt=<quota type>     <quota type>: [vfsold,vfsv0,vfsv1].
-offusrjquota           Turn off user journelled quota.
-offgrpjquota           Turn off group journelled quota.
-offprjjquota           Turn off project journelled quota.
-quota                  Enable plain user disk quota accounting.
-noquota                Disable all plain disk quota option.
-whint_mode=%s          Control which write hints are passed down to block
-                       layer. This supports "off", "user-based", and
-                       "fs-based".  In "off" mode (default), f2fs does not pass
-                       down hints. In "user-based" mode, f2fs tries to pass
-                       down hints given by users. And in "fs-based" mode, f2fs
-                       passes down hints with its policy.
-alloc_mode=%s          Adjust block allocation policy, which supports "reuse"
-                       and "default".
-fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
-                       "strict", and "nobarrier". In "posix" mode, which is
-                       default, fsync will follow POSIX semantics and does a
-                       light operation to improve the filesystem performance.
-                       In "strict" mode, fsync will be heavy and behaves in line
-                       with xfs, ext4 and btrfs, where xfstest generic/342 will
-                       pass, but the performance will regress. "nobarrier" is
-                       based on "posix", but doesn't issue flush command for
-                       non-atomic files likewise "nobarrier" mount option.
+======================== ============================================================
+background_gc=%s	 Turn on/off cleaning operations, namely garbage
+			 collection, triggered in background when I/O subsystem is
+			 idle. If background_gc=on, it will turn on the garbage
+			 collection and if background_gc=off, garbage collection
+			 will be turned off. If background_gc=sync, it will turn
+			 on synchronous garbage collection running in background.
+			 Default value for this option is on. So garbage
+			 collection is on by default.
+disable_roll_forward	 Disable the roll-forward recovery routine
+norecovery		 Disable the roll-forward recovery routine, mounted read-
+			 only (i.e., -o ro,disable_roll_forward)
+discard/nodiscard	 Enable/disable real-time discard in f2fs, if discard is
+			 enabled, f2fs will issue discard/TRIM commands when a
+			 segment is cleaned.
+no_heap			 Disable heap-style segment allocation which finds free
+			 segments for data from the beginning of main area, while
+			 for node from the end of main area.
+nouser_xattr		 Disable Extended User Attributes. Note: xattr is enabled
+			 by default if CONFIG_F2FS_FS_XATTR is selected.
+noacl			 Disable POSIX Access Control List. Note: acl is enabled
+			 by default if CONFIG_F2FS_FS_POSIX_ACL is selected.
+active_logs=%u		 Support configuring the number of active logs. In the
+			 current design, f2fs supports only 2, 4, and 6 logs.
+			 Default number is 6.
+disable_ext_identify	 Disable the extension list configured by mkfs, so f2fs
+			 does not aware of cold files such as media files.
+inline_xattr		 Enable the inline xattrs feature.
+noinline_xattr		 Disable the inline xattrs feature.
+inline_xattr_size=%u	 Support configuring inline xattr size, it depends on
+			 flexible inline xattr feature.
+inline_data		 Enable the inline data feature: New created small(<~3.4k)
+			 files can be written into inode block.
+inline_dentry		 Enable the inline dir feature: data in new created
+			 directory entries can be written into inode block. The
+			 space of inode block which is used to store inline
+			 dentries is limited to ~3.4k.
+noinline_dentry		 Disable the inline dentry feature.
+flush_merge		 Merge concurrent cache_flush commands as much as possible
+			 to eliminate redundant command issues. If the underlying
+			 device handles the cache_flush command relatively slowly,
+			 recommend to enable this option.
+nobarrier		 This option can be used if underlying storage guarantees
+			 its cached data should be written to the novolatile area.
+			 If this option is set, no cache_flush commands are issued
+			 but f2fs still guarantees the write ordering of all the
+			 data writes.
+fastboot		 This option is used when a system wants to reduce mount
+			 time as much as possible, even though normal performance
+			 can be sacrificed.
+extent_cache		 Enable an extent cache based on rb-tree, it can cache
+			 as many as extent which map between contiguous logical
+			 address and physical address per inode, resulting in
+			 increasing the cache hit ratio. Set by default.
+noextent_cache		 Disable an extent cache based on rb-tree explicitly, see
+			 the above extent_cache mount option.
+noinline_data		 Disable the inline data feature, inline data feature is
+			 enabled by default.
+data_flush		 Enable data flushing before checkpoint in order to
+			 persist data of regular and symlink.
+reserve_root=%d		 Support configuring reserved space which is used for
+			 allocation from a privileged user with specified uid or
+			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
+resuid=%d		 The user ID which may use the reserved blocks.
+resgid=%d		 The group ID which may use the reserved blocks.
+fault_injection=%d	 Enable fault injection in all supported types with
+			 specified injection rate.
+fault_type=%d		 Support configuring fault injection type, should be
+			 enabled with fault_injection option, fault type value
+			 is shown below, it supports single or combined type.
+
+			 ===================	  ===========
+			 Type_Name		  Type_Value
+			 ===================	  ===========
+			 FAULT_KMALLOC		  0x000000001
+			 FAULT_KVMALLOC		  0x000000002
+			 FAULT_PAGE_ALLOC	  0x000000004
+			 FAULT_PAGE_GET		  0x000000008
+			 FAULT_ALLOC_BIO	  0x000000010
+			 FAULT_ALLOC_NID	  0x000000020
+			 FAULT_ORPHAN		  0x000000040
+			 FAULT_BLOCK		  0x000000080
+			 FAULT_DIR_DEPTH	  0x000000100
+			 FAULT_EVICT_INODE	  0x000000200
+			 FAULT_TRUNCATE		  0x000000400
+			 FAULT_READ_IO		  0x000000800
+			 FAULT_CHECKPOINT	  0x000001000
+			 FAULT_DISCARD		  0x000002000
+			 FAULT_WRITE_IO		  0x000004000
+			 ===================	  ===========
+mode=%s			 Control block allocation mode which supports "adaptive"
+			 and "lfs". In "lfs" mode, there should be no random
+			 writes towards main area.
+io_bits=%u		 Set the bit size of write IO requests. It should be set
+			 with "mode=lfs".
+usrquota		 Enable plain user disk quota accounting.
+grpquota		 Enable plain group disk quota accounting.
+prjquota		 Enable plain project quota accounting.
+usrjquota=<file>	 Appoint specified file and type during mount, so that quota
+grpjquota=<file>	 information can be properly updated during recovery flow,
+prjjquota=<file>	 <quota file>: must be in root directory;
+jqfmt=<quota type>	 <quota type>: [vfsold,vfsv0,vfsv1].
+offusrjquota		 Turn off user journelled quota.
+offgrpjquota		 Turn off group journelled quota.
+offprjjquota		 Turn off project journelled quota.
+quota			 Enable plain user disk quota accounting.
+noquota			 Disable all plain disk quota option.
+whint_mode=%s		 Control which write hints are passed down to block
+			 layer. This supports "off", "user-based", and
+			 "fs-based".  In "off" mode (default), f2fs does not pass
+			 down hints. In "user-based" mode, f2fs tries to pass
+			 down hints given by users. And in "fs-based" mode, f2fs
+			 passes down hints with its policy.
+alloc_mode=%s		 Adjust block allocation policy, which supports "reuse"
+			 and "default".
+fsync_mode=%s		 Control the policy of fsync. Currently supports "posix",
+			 "strict", and "nobarrier". In "posix" mode, which is
+			 default, fsync will follow POSIX semantics and does a
+			 light operation to improve the filesystem performance.
+			 In "strict" mode, fsync will be heavy and behaves in line
+			 with xfs, ext4 and btrfs, where xfstest generic/342 will
+			 pass, but the performance will regress. "nobarrier" is
+			 based on "posix", but doesn't issue flush command for
+			 non-atomic files likewise "nobarrier" mount option.
 test_dummy_encryption
 test_dummy_encryption=%s
-                       Enable dummy encryption, which provides a fake fscrypt
-                       context. The fake fscrypt context is used by xfstests.
-                       The argument may be either "v1" or "v2", in order to
-                       select the corresponding fscrypt policy version.
-checkpoint=%s[:%u[%]]  Set to "disable" to turn off checkpointing. Set to "enable"
-                       to reenable checkpointing. Is enabled by default. While
-                       disabled, any unmounting or unexpected shutdowns will cause
-                       the filesystem contents to appear as they did when the
-                       filesystem was mounted with that option.
-                       While mounting with checkpoint=disabled, the filesystem must
-                       run garbage collection to ensure that all available space can
-                       be used. If this takes too much time, the mount may return
-                       EAGAIN. You may optionally add a value to indicate how much
-                       of the disk you would be willing to temporarily give up to
-                       avoid additional garbage collection. This can be given as a
-                       number of blocks, or as a percent. For instance, mounting
-                       with checkpoint=disable:100% would always succeed, but it may
-                       hide up to all remaining free space. The actual space that
-                       would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
-                       This space is reclaimed once checkpoint=enable.
-compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo",
-                       "lz4", "zstd" and "lzo-rle" algorithm.
-compress_log_size=%u   Support configuring compress cluster size, the size will
-                       be 4KB * (1 << %u), 16KB is minimum size, also it's
-                       default size.
-compress_extension=%s  Support adding specified extension, so that f2fs can enable
-                       compression on those corresponding files, e.g. if all files
-                       with '.ext' has high compression rate, we can set the '.ext'
-                       on compression extension list and enable compression on
-                       these file by default rather than to enable it via ioctl.
-                       For other files, we can still enable compression via ioctl.
-====================== ============================================================
+			 Enable dummy encryption, which provides a fake fscrypt
+			 context. The fake fscrypt context is used by xfstests.
+			 The argument may be either "v1" or "v2", in order to
+			 select the corresponding fscrypt policy version.
+checkpoint=%s[:%u[%]]	 Set to "disable" to turn off checkpointing. Set to "enable"
+			 to reenable checkpointing. Is enabled by default. While
+			 disabled, any unmounting or unexpected shutdowns will cause
+			 the filesystem contents to appear as they did when the
+			 filesystem was mounted with that option.
+			 While mounting with checkpoint=disabled, the filesystem must
+			 run garbage collection to ensure that all available space can
+			 be used. If this takes too much time, the mount may return
+			 EAGAIN. You may optionally add a value to indicate how much
+			 of the disk you would be willing to temporarily give up to
+			 avoid additional garbage collection. This can be given as a
+			 number of blocks, or as a percent. For instance, mounting
+			 with checkpoint=disable:100% would always succeed, but it may
+			 hide up to all remaining free space. The actual space that
+			 would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
+			 This space is reclaimed once checkpoint=enable.
+compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo",
+			 "lz4", "zstd" and "lzo-rle" algorithm.
+compress_log_size=%u	 Support configuring compress cluster size, the size will
+			 be 4KB * (1 << %u), 16KB is minimum size, also it's
+			 default size.
+compress_extension=%s	 Support adding specified extension, so that f2fs can enable
+			 compression on those corresponding files, e.g. if all files
+			 with '.ext' has high compression rate, we can set the '.ext'
+			 on compression extension list and enable compression on
+			 these file by default rather than to enable it via ioctl.
+			 For other files, we can still enable compression via ioctl.
+======================== ============================================================
 
 Debugfs Entries
 ===============
-- 
2.26.2

