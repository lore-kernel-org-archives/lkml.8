Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CACBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA832067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203741;
	bh=BHlSoLGVs0QcizEsZUsco5GvY7YCZCyE5twv2MDbsmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUE+SmABqgAQ/0SoCBj8ujgMgsARLWrgRuU34jNqBzm9QWSSaFWwDNovGgpe5icIu
	 0Y6ey0oAA3/T+ZW6ymbqChEW0QHF0aDf497CkRjgjvzF232iMFWT0jmbIiyyKURXg3
	 wM0rWsuMV/IbXjVlG1ygjWo+XlUMcF1askUyzIOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgFOGs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E152078E;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=BHlSoLGVs0QcizEsZUsco5GvY7YCZCyE5twv2MDbsmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByrgkqLPbRhlDGP9MDCIlwmCBdYuh6JtBj/VCInOKCZpzWiS1q/hXu8QTJ3Eauq8k
         9W6fQzh6gIMfHf3uqnZYr8PZ6rzdcKAoP040NiYB74CcIkRVcm0AMOzhz1i3e0Z8tP
         1xZqKPtfaj2wh0vu73SXyyzJs4pfXl206oC6//XA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmf-Mw; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 11/29] fs: docs: f2fs.rst: fix a broken table
Date:   Mon, 15 Jun 2020 08:46:50 +0200
Message-Id: <a29fe589dad31738f65690e997f41c6727e23abc.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Sphinx:

	Documentation/filesystems/f2fs.rst:229: WARNING: Malformed table.
	Text in column margin in table line 126.

	====================== ============================================================
	background_gc=%s       Turn on/off cleaning operations, namely garbage
...
	test_dummy_encryption
	test_dummy_encryption=%s
	                       Enable dummy encryption, which provides a fake fscrypt
	                       context. The fake fscrypt context is used by xfstests.
	                       The argument may be either "v1" or "v2", in order to
	                       select the corresponding fscrypt policy version.

This table is now broken, as some texts are bigger than a
column. While it would be feasible to fix it by adding two extra
positions at the table, it would still output something wrong,
as "test_dummy_encryption" would appear on a separate row.

So, the best solution here seems to remove the table markup.

The html and PDF output won't be as nice as a table, but it will
still be reasonable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 150 +++++++++++++++++++----------
 1 file changed, 98 insertions(+), 52 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 099d45ac8d8f..0c166716e4ba 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -101,8 +101,8 @@ Mount Options
 =============
 
 
-====================== ============================================================
-background_gc=%s       Turn on/off cleaning operations, namely garbage
+background_gc=%s
+                       Turn on/off cleaning operations, namely garbage
                        collection, triggered in background when I/O subsystem is
                        idle. If background_gc=on, it will turn on the garbage
                        collection and if background_gc=off, garbage collection
@@ -110,65 +110,91 @@ background_gc=%s       Turn on/off cleaning operations, namely garbage
                        on synchronous garbage collection running in background.
                        Default value for this option is on. So garbage
                        collection is on by default.
-disable_roll_forward   Disable the roll-forward recovery routine
-norecovery             Disable the roll-forward recovery routine, mounted read-
+disable_roll_forward
+                       Disable the roll-forward recovery routine
+norecovery
+                       Disable the roll-forward recovery routine, mounted read-
                        only (i.e., -o ro,disable_roll_forward)
-discard/nodiscard      Enable/disable real-time discard in f2fs, if discard is
+discard/nodiscard
+                       Enable/disable real-time discard in f2fs, if discard is
                        enabled, f2fs will issue discard/TRIM commands when a
 		       segment is cleaned.
-no_heap                Disable heap-style segment allocation which finds free
+no_heap
+                       Disable heap-style segment allocation which finds free
                        segments for data from the beginning of main area, while
 		       for node from the end of main area.
-nouser_xattr           Disable Extended User Attributes. Note: xattr is enabled
+nouser_xattr
+                       Disable Extended User Attributes. Note: xattr is enabled
                        by default if CONFIG_F2FS_FS_XATTR is selected.
-noacl                  Disable POSIX Access Control List. Note: acl is enabled
+noacl
+                       Disable POSIX Access Control List. Note: acl is enabled
                        by default if CONFIG_F2FS_FS_POSIX_ACL is selected.
-active_logs=%u         Support configuring the number of active logs. In the
+active_logs=%u
+                       Support configuring the number of active logs. In the
                        current design, f2fs supports only 2, 4, and 6 logs.
                        Default number is 6.
-disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
+disable_ext_identify
+                       Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
-inline_xattr           Enable the inline xattrs feature.
-noinline_xattr         Disable the inline xattrs feature.
-inline_xattr_size=%u   Support configuring inline xattr size, it depends on
+inline_xattr
+                       Enable the inline xattrs feature.
+noinline_xattr
+                       Disable the inline xattrs feature.
+inline_xattr_size=%u
+                       Support configuring inline xattr size, it depends on
 		       flexible inline xattr feature.
-inline_data            Enable the inline data feature: New created small(<~3.4k)
+inline_data
+                       Enable the inline data feature: New created small(<~3.4k)
                        files can be written into inode block.
-inline_dentry          Enable the inline dir feature: data in new created
+inline_dentry
+                       Enable the inline dir feature: data in new created
                        directory entries can be written into inode block. The
                        space of inode block which is used to store inline
                        dentries is limited to ~3.4k.
-noinline_dentry        Disable the inline dentry feature.
-flush_merge	       Merge concurrent cache_flush commands as much as possible
+noinline_dentry
+                       Disable the inline dentry feature.
+flush_merge
+                       Merge concurrent cache_flush commands as much as possible
                        to eliminate redundant command issues. If the underlying
 		       device handles the cache_flush command relatively slowly,
 		       recommend to enable this option.
-nobarrier              This option can be used if underlying storage guarantees
+nobarrier
+                       This option can be used if underlying storage guarantees
                        its cached data should be written to the novolatile area.
 		       If this option is set, no cache_flush commands are issued
 		       but f2fs still guarantees the write ordering of all the
 		       data writes.
-fastboot               This option is used when a system wants to reduce mount
+fastboot
+                       This option is used when a system wants to reduce mount
                        time as much as possible, even though normal performance
 		       can be sacrificed.
-extent_cache           Enable an extent cache based on rb-tree, it can cache
+extent_cache
+                       Enable an extent cache based on rb-tree, it can cache
                        as many as extent which map between contiguous logical
                        address and physical address per inode, resulting in
                        increasing the cache hit ratio. Set by default.
-noextent_cache         Disable an extent cache based on rb-tree explicitly, see
+noextent_cache
+                       Disable an extent cache based on rb-tree explicitly, see
                        the above extent_cache mount option.
-noinline_data          Disable the inline data feature, inline data feature is
+noinline_data
+                       Disable the inline data feature, inline data feature is
                        enabled by default.
-data_flush             Enable data flushing before checkpoint in order to
+data_flush
+                       Enable data flushing before checkpoint in order to
                        persist data of regular and symlink.
-reserve_root=%d        Support configuring reserved space which is used for
+reserve_root=%d
+                       Support configuring reserved space which is used for
                        allocation from a privileged user with specified uid or
                        gid, unit: 4KB, the default limit is 0.2% of user blocks.
-resuid=%d              The user ID which may use the reserved blocks.
-resgid=%d              The group ID which may use the reserved blocks.
-fault_injection=%d     Enable fault injection in all supported types with
+resuid=%d
+                       The user ID which may use the reserved blocks.
+resgid=%d
+                       The group ID which may use the reserved blocks.
+fault_injection=%d
+                       Enable fault injection in all supported types with
                        specified injection rate.
-fault_type=%d          Support configuring fault injection type, should be
+fault_type=%d
+                       Support configuring fault injection type, should be
                        enabled with fault_injection option, fault type value
                        is shown below, it supports single or combined type.
 
@@ -191,32 +217,49 @@ fault_type=%d          Support configuring fault injection type, should be
                        FAULT_DISCARD		0x000002000
                        FAULT_WRITE_IO		0x000004000
                        ===================	===========
-mode=%s                Control block allocation mode which supports "adaptive"
+mode=%s
+                       Control block allocation mode which supports "adaptive"
                        and "lfs". In "lfs" mode, there should be no random
                        writes towards main area.
-io_bits=%u             Set the bit size of write IO requests. It should be set
+io_bits=%u
+                       Set the bit size of write IO requests. It should be set
                        with "mode=lfs".
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
+usrquota
+                       Enable plain user disk quota accounting.
+grpquota
+                       Enable plain group disk quota accounting.
+prjquota
+                       Enable plain project quota accounting.
+usrjquota=<file>
+                       Appoint specified file and type during mount, so that quota
+grpjquota=<file>
+                       information can be properly updated during recovery flow,
+prjjquota=<file>
+                       <quota file>: must be in root directory;
+jqfmt=<quota type>
+                       <quota type>: [vfsold,vfsv0,vfsv1].
+offusrjquota
+                       Turn off user journelled quota.
+offgrpjquota
+                       Turn off group journelled quota.
+offprjjquota
+                       Turn off project journelled quota.
+quota
+                       Enable plain user disk quota accounting.
+noquota
+                       Disable all plain disk quota option.
+whint_mode=%s
+                       Control which write hints are passed down to block
                        layer. This supports "off", "user-based", and
                        "fs-based".  In "off" mode (default), f2fs does not pass
                        down hints. In "user-based" mode, f2fs tries to pass
                        down hints given by users. And in "fs-based" mode, f2fs
                        passes down hints with its policy.
-alloc_mode=%s          Adjust block allocation policy, which supports "reuse"
+alloc_mode=%s
+                       Adjust block allocation policy, which supports "reuse"
                        and "default".
-fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
+fsync_mode=%s
+                       Control the policy of fsync. Currently supports "posix",
                        "strict", and "nobarrier". In "posix" mode, which is
                        default, fsync will follow POSIX semantics and does a
                        light operation to improve the filesystem performance.
@@ -225,13 +268,14 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
                        pass, but the performance will regress. "nobarrier" is
                        based on "posix", but doesn't issue flush command for
                        non-atomic files likewise "nobarrier" mount option.
-test_dummy_encryption
-test_dummy_encryption=%s
+
+test_dummy_encryption, test_dummy_encryption=%s
                        Enable dummy encryption, which provides a fake fscrypt
                        context. The fake fscrypt context is used by xfstests.
                        The argument may be either "v1" or "v2", in order to
                        select the corresponding fscrypt policy version.
-checkpoint=%s[:%u[%]]  Set to "disable" to turn off checkpointing. Set to "enable"
+checkpoint=%s[:%u[%]]
+                       Set to "disable" to turn off checkpointing. Set to "enable"
                        to reenable checkpointing. Is enabled by default. While
                        disabled, any unmounting or unexpected shutdowns will cause
                        the filesystem contents to appear as they did when the
@@ -247,18 +291,20 @@ checkpoint=%s[:%u[%]]  Set to "disable" to turn off checkpointing. Set to "enabl
                        hide up to all remaining free space. The actual space that
                        would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
                        This space is reclaimed once checkpoint=enable.
-compress_algorithm=%s  Control compress algorithm, currently f2fs supports "lzo",
+compress_algorithm=%s
+                       Control compress algorithm, currently f2fs supports "lzo",
                        "lz4", "zstd" and "lzo-rle" algorithm.
-compress_log_size=%u   Support configuring compress cluster size, the size will
+compress_log_size=%u
+                       Support configuring compress cluster size, the size will
                        be 4KB * (1 << %u), 16KB is minimum size, also it's
                        default size.
-compress_extension=%s  Support adding specified extension, so that f2fs can enable
+compress_extension=%s
+                       Support adding specified extension, so that f2fs can enable
                        compression on those corresponding files, e.g. if all files
                        with '.ext' has high compression rate, we can set the '.ext'
                        on compression extension list and enable compression on
                        these file by default rather than to enable it via ioctl.
                        For other files, we can still enable compression via ioctl.
-====================== ============================================================
 
 Debugfs Entries
 ===============
-- 
2.26.2

