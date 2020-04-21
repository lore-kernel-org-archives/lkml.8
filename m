Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D48C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CE92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488166;
	bh=KsoaNwgIS/FbS/tQMuw9JxqzFKt+s5yExdop2Zs3cCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZefp+MGZaxq6ROw76D+EArdvKPQisYjdPDhQXL3FWJYKSyMeA5zOvDEMTBhmaegr
	 QYRK62SbHXGOZHgXBQhAVHg5/FPbE/ajFYt+jQWQLvaP9ahLo8sr/bQUGJF6QR5LX1
	 lgccCOvDrROeZSfPzN+yOK7Q+Bk3aGKHJ0IK9Qyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgDUQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgDUQyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:47 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9190D2166E;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=KsoaNwgIS/FbS/tQMuw9JxqzFKt+s5yExdop2Zs3cCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9FEnG+eWDchYmB/irYq2m/ChCSWoeBWqEUCy7l7mBxOFWPxzPvBTXb+W+eSTa39Q
         7mfcXPgKSCWlW+xDA2xaAwndbFj+c/kJMc1se9McuWksojSkjt4qq57cK5ZjaRwSXm
         +xs903OGR08LqozjMvKHOuhi6B9w4dWmMg1xsMSA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmFA-Qp; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 23/29] docs: filesystems: convert spufs/spu_create.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:34 +0200
Message-Id: <dc48536e964ecd8074271f15ccadb8920bb17a04.1587487612.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587487612.git.mchehab+huawei@kernel.org>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is at groff output format. Manually convert it to
ReST format, trying to preserve a similar output after parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 Documentation/filesystems/spufs/index.rst     | 11 ++++
 .../spufs/{spu_create.txt => spu_create.rst}  | 52 ++++++++++++-------
 3 files changed, 44 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/filesystems/spufs/index.rst
 rename Documentation/filesystems/spufs/{spu_create.txt => spu_create.rst} (90%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 56fd515af5ef..74b1e18af37e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -107,6 +107,7 @@ Documentation for filesystem implementations.
    ramfs-rootfs-initramfs
    relay
    romfs
+   spufs/index
    squashfs
    sysfs
    sysv-fs
diff --git a/Documentation/filesystems/spufs/index.rst b/Documentation/filesystems/spufs/index.rst
new file mode 100644
index 000000000000..39553c6ebefd
--- /dev/null
+++ b/Documentation/filesystems/spufs/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+SPU Filesystem
+==============
+
+
+.. toctree::
+   :maxdepth: 1
+
+   spu_create
diff --git a/Documentation/filesystems/spufs/spu_create.txt b/Documentation/filesystems/spufs/spu_create.rst
similarity index 90%
rename from Documentation/filesystems/spufs/spu_create.txt
rename to Documentation/filesystems/spufs/spu_create.rst
index 8ede5a35340f..83108c099696 100644
--- a/Documentation/filesystems/spufs/spu_create.txt
+++ b/Documentation/filesystems/spufs/spu_create.rst
@@ -1,18 +1,26 @@
-SPU_CREATE(2)              Linux Programmer's Manual             SPU_CREATE(2)
+.. SPDX-License-Identifier: GPL-2.0
 
+==========
+spu_create
+==========
 
-
-NAME
+Name
+====
        spu_create - create a new spu context
 
 
-SYNOPSIS
-       #include <sys/types.h>
-       #include <sys/spu.h>
+Synopsis
+========
 
-       int spu_create(const char *pathname, int flags, mode_t mode);
+       ::
 
-DESCRIPTION
+         #include <sys/types.h>
+         #include <sys/spu.h>
+
+         int spu_create(const char *pathname, int flags, mode_t mode);
+
+Description
+===========
        The  spu_create  system call is used on PowerPC machines that implement
        the Cell Broadband Engine Architecture in order to  access  Synergistic
        Processor  Units (SPUs). It creates a new logical context for an SPU in
@@ -43,13 +51,15 @@ DESCRIPTION
        possible mode values.
 
 
-RETURN VALUE
+Return Value
+============
        spu_create  returns a new file descriptor. It may return -1 to indicate
        an error condition and set errno to  one  of  the  error  codes  listed
        below.
 
 
-ERRORS
+Errors
+======
        EACCES
               The  current  user does not have write access on the spufs mount
               point.
@@ -87,33 +97,35 @@ ERRORS
 
 
 
-NOTES
+Notes
+=====
        spu_create  is  meant  to  be used from libraries that implement a more
        abstract interface to SPUs, not to be used from  regular  applications.
        See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
        ommended libraries.
 
 
-FILES
+Files
+=====
        pathname must point to a location beneath the mount point of spufs.  By
        convention, it gets mounted in /spu.
 
 
-CONFORMING TO
+Conforming to
+=============
        This call is Linux specific and only implemented by the ppc64 architec-
        ture. Programs using this system call are not portable.
 
 
-BUGS
+Bugs
+====
        The code does not yet fully implement all features lined out here.
 
 
-AUTHOR
+Author
+======
        Arnd Bergmann <arndb@de.ibm.com>
 
-SEE ALSO
+See Also
+========
        capabilities(7), close(2), spu_run(2), spufs(7)
-
-
-
-Linux                             2005-09-28                     SPU_CREATE(2)
-- 
2.25.2

