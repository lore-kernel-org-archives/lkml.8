Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0501DC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67AE2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961517;
	bh=3gPN9Xck86OU0Nu/wpUSjP1/DfTI3IuhV4IZrrb8T8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XV7qyKsIa9Id2OqA2G2xz1/8PBeHqVxjtVdjt73S8KpHa+ObJ7/9zwqpstpRRyceW
	 LqFwbdvruMlsP1yFH2FSHy+R+I9h0Mm6LBR+xAuwWQ9aYhM5longWWfxZWJ9aEQPUt
	 GAImSSlR2OB4zlTfFs75cxwzBq2eFbLUb2gCaCww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636681AbgDOOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394085AbgDOOdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6EF221E8;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=3gPN9Xck86OU0Nu/wpUSjP1/DfTI3IuhV4IZrrb8T8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/QFBdH4SyWLelpOz14uSERyAL0yOwIewPDy/s4Jika537o27bQgeLeDdYANVeXF/
         QSnlQIY8IPEjXMd7/xJkxdizhkbyfHhzuNzZ3Mog76MSBfnpIne5EGXUI2dR278tMk
         uGmvGteerQH+JTt55XCQcTx3jKVArcRORJnXoMWg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5u-006kPv-1Y; Wed, 15 Apr 2020 16:32:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 28/34] docs: filesystems: convert spufs/spu_create.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:41 +0200
Message-Id: <d272eb5cb43ae078466e5d570ef978bd4bc14194.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
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
index b65f288366f0..6c5c312b8188 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -109,6 +109,7 @@ Documentation for filesystem implementations.
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

