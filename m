Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EF0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD145206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCWUDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:03:20 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:6105 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgCWUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:03:20 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 23 Mar 2020 13:03:18 -0700
Received: from localhost.localdomain (unknown [10.118.101.94])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 55D61400F1;
        Mon, 23 Mar 2020 13:03:19 -0700 (PDT)
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Alexey Makhalov <amakhalov@vmware.com>,
        Peng Tao <bergwolf@gmail.com>
Subject: [PATCH] fs/9p: file attributes caching support
Date:   Mon, 23 Mar 2020 20:02:46 +0000
Message-ID: <20200323200246.31385-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.14.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new mount option "cache=stat" for 9p filesystem.
It enables caching of file attributes.

The motivation behind this change is to support
open-unlink-fstat sequence from the client side:
  fd = open("file", O_RDONLY);
  remove("file");
  fstat(fd, &stat); /* fail with -ENOENT */

The idea of the implementation is to avoid sending GETATTR
command to the server if file attributes can be fetched
from the inode struct of dentry.

In other words, this is a minimalistic cache implementation
to store GETATTR/STAT metadata.

Here are snippets of open-unlink-fstat sequence translated
to 9P2000.L protocol:
With cache=none
  TWALK tag 0 fid 1 newfid 26 nwname 1 'file'
  TGETATTR tag 0 fid 26 request_mask 0x17ff
  TWALK tag 0 fid 26 newfid 27 nwname 0
  TLOPEN tag 0 fid 27 flags 0100000
  TUNLINKAT tag 0 dirfid 1 name 'file' flags 0
  TWALK tag 0 fid 26 newfid 28 nwname 0
  TREMOVE tag 0 fid 28
  TGETATTR tag 0 fid 26 request_mask 0x3fff
  RLERROR tag 0 ecode 2				<-- ENOENT error code
  TCLUNK tag 0 fid 27
  TCLUNK tag 0 fid 26

With cache=stat
  TWALK tag 0 fid 1 newfid 26 nwname 1 'file'
  TGETATTR tag 0 fid 26 request_mask 0x17ff	<-- save fid 26 stat here
  TWALK tag 0 fid 26 newfid 27 nwname 0
  TLOPEN tag 0 fid 27 flags 0100000
  TUNLINKAT tag 0 dirfid 1 name 'file' flags 0
  TWALK tag 0 fid 26 newfid 28 nwname 0
  TREMOVE tag 0 fid 28
  						<-- use saved fid 26 stat
  TCLUNK tag 0 fid 27
  TCLUNK tag 0 fid 26

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Co-developed-by: Peng Tao <bergwolf@gmail.com>
Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 Documentation/filesystems/9p.txt |  2 ++
 fs/9p/v9fs.c                     | 10 +++++++++-
 fs/9p/v9fs.h                     |  1 +
 fs/9p/vfs_inode.c                |  3 ++-
 fs/9p/vfs_inode_dotl.c           |  3 ++-
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/9p.txt b/Documentation/filesystems/9p.txt
index fec7144e817c..567e41ca5380 100644
--- a/Documentation/filesystems/9p.txt
+++ b/Documentation/filesystems/9p.txt
@@ -77,6 +77,9 @@ OPTIONS
 				cache backend.
                         mmap = minimal cache that is only used for read-write
                                 mmap.  Northing else is cached, like cache=none
+                        stat = minimal cache that is only used for file
+				attributes. Northing else is cached, like
+				cache=none
 
   debug=n	specifies debug level.  The debug level is a bitmask.
 			0x01  = display verbose error messages
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 15a99f9c7253..b780c8937441 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -43,7 +43,7 @@ enum {
 	/* Options that take no arguments */
 	Opt_nodevmap,
 	/* Cache options */
-	Opt_cache_loose, Opt_fscache, Opt_mmap,
+	Opt_cache_loose, Opt_fscache, Opt_stat, Opt_mmap,
 	/* Access options */
 	Opt_access, Opt_posixacl,
 	/* Lock timeout option */
@@ -63,6 +63,7 @@ static const match_table_t tokens = {
 	{Opt_cache, "cache=%s"},
 	{Opt_cache_loose, "loose"},
 	{Opt_fscache, "fscache"},
+	{Opt_stat, "stat"},
 	{Opt_mmap, "mmap"},
 	{Opt_cachetag, "cachetag=%s"},
 	{Opt_access, "access=%s"},
@@ -73,6 +74,7 @@ static const match_table_t tokens = {
 
 static const char *const v9fs_cache_modes[nr__p9_cache_modes] = {
 	[CACHE_NONE]	= "none",
+	[CACHE_STAT]	= "stat",
 	[CACHE_MMAP]	= "mmap",
 	[CACHE_LOOSE]	= "loose",
 	[CACHE_FSCACHE]	= "fscache",
@@ -92,6 +94,9 @@ static int get_cache_mode(char *s)
 	} else if (!strcmp(s, "mmap")) {
 		version = CACHE_MMAP;
 		p9_debug(P9_DEBUG_9P, "Cache mode: mmap\n");
+	} else if (!strcmp(s, "stat")) {
+		version = CACHE_STAT;
+		p9_debug(P9_DEBUG_9P, "Cache mode: stat\n");
 	} else if (!strcmp(s, "none")) {
 		version = CACHE_NONE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: none\n");
@@ -272,6 +277,9 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		case Opt_fscache:
 			v9ses->cache = CACHE_FSCACHE;
 			break;
+		case Opt_stat:
+			v9ses->cache = CACHE_STAT;
+			break;
 		case Opt_mmap:
 			v9ses->cache = CACHE_MMAP;
 			break;
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 7b763776306e..afa7a6803262 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -49,6 +49,7 @@ enum p9_session_flags {
 
 enum p9_cache_modes {
 	CACHE_NONE,
+	CACHE_STAT,
 	CACHE_MMAP,
 	CACHE_LOOSE,
 	CACHE_FSCACHE,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b82423a72f68..367a5e6f990d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1059,7 +1059,8 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE ||
+	    (v9ses->cache == CACHE_STAT && d_really_is_positive(dentry))) {
 		generic_fillattr(d_inode(dentry), stat);
 		return 0;
 	}
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..91826ce5647d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -465,7 +465,8 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE ||
+	    (v9ses->cache == CACHE_STAT && d_really_is_positive(dentry))) {
 		generic_fillattr(d_inode(dentry), stat);
 		return 0;
 	}
-- 
2.14.2

