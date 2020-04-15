Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE9EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07881208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961488;
	bh=YIRc9iyKpk3vP7JWjAgsMk2zE3Vu8SevHanHWSNLTyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QkBhp7nkAxwK4w2zY3Pk4b4eo9lBGNOi0GIR8sSafgOZ/8rsBXzC4lf5UsChdGDnd
	 9DA1UJXc7vQCck8FyYgzM5cT4Y45M6QPRXjxyB1H79bzaMuA8DRk04/6zw2iiwkkOX
	 qjtEqA8oRfJmxjsByfwZfkX69ag7JO73Hmd9BP1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636658AbgDOOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394088AbgDOOdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:05 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA95721775;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961172;
        bh=YIRc9iyKpk3vP7JWjAgsMk2zE3Vu8SevHanHWSNLTyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0/qQEAsXJ6FNaz7lXGDXWr1cREtlUjeLmhRDVgpHQ5AMAENTbDBRtG3/7rqPTo69
         gSfBC5FVgEZEoQ12I6wis3bkxX/+J9KGP86fC8YNcFtjUXCcT1bE6cUQvSuRgRzmpX
         Edx70BvzGRKoZT87fCx997Xh3BHB/tFN1VlZoq0o=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5u-006kQ0-2h; Wed, 15 Apr 2020 16:32:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 29/34] docs: filesystems: convert spufs/spufs.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:42 +0200
Message-Id: <868f3c1e3356459e1b6b7e8bfd620200c49452ab.1586960617.git.mchehab+huawei@kernel.org>
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
 Documentation/filesystems/spufs/index.rst     |  1 +
 .../spufs/{spufs.txt => spufs.rst}            | 59 +++++++++----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 30 insertions(+), 32 deletions(-)
 rename Documentation/filesystems/spufs/{spufs.txt => spufs.rst} (95%)

diff --git a/Documentation/filesystems/spufs/index.rst b/Documentation/filesystems/spufs/index.rst
index 39553c6ebefd..939cf59a7d9e 100644
--- a/Documentation/filesystems/spufs/index.rst
+++ b/Documentation/filesystems/spufs/index.rst
@@ -8,4 +8,5 @@ SPU Filesystem
 .. toctree::
    :maxdepth: 1
 
+   spufs
    spu_create
diff --git a/Documentation/filesystems/spufs/spufs.txt b/Documentation/filesystems/spufs/spufs.rst
similarity index 95%
rename from Documentation/filesystems/spufs/spufs.txt
rename to Documentation/filesystems/spufs/spufs.rst
index caf36aaae804..8a42859bb100 100644
--- a/Documentation/filesystems/spufs/spufs.txt
+++ b/Documentation/filesystems/spufs/spufs.rst
@@ -1,12 +1,18 @@
-SPUFS(2)                   Linux Programmer's Manual                  SPUFS(2)
+.. SPDX-License-Identifier: GPL-2.0
 
+=====
+spufs
+=====
 
+Name
+====
 
-NAME
        spufs - the SPU file system
 
 
-DESCRIPTION
+Description
+===========
+
        The SPU file system is used on PowerPC machines that implement the Cell
        Broadband Engine Architecture in order to access Synergistic  Processor
        Units (SPUs).
@@ -21,7 +27,9 @@ DESCRIPTION
        ally add or remove files.
 
 
-MOUNT OPTIONS
+Mount Options
+=============
+
        uid=<uid>
               set the user owning the mount point, the default is 0 (root).
 
@@ -29,7 +37,9 @@ MOUNT OPTIONS
               set the group owning the mount point, the default is 0 (root).
 
 
-FILES
+Files
+=====
+
        The files in spufs mostly follow the standard behavior for regular sys-
        tem  calls like read(2) or write(2), but often support only a subset of
        the operations supported on regular file systems. This list details the
@@ -125,14 +135,12 @@ FILES
               space is available for writing.
 
 
-   /mbox_stat
-   /ibox_stat
-   /wbox_stat
+   /mbox_stat, /ibox_stat, /wbox_stat
        Read-only files that contain the length of the current queue, i.e.  how
        many  words  can  be  read  from  mbox or ibox or how many words can be
        written to wbox without blocking.  The files can be read only in 4-byte
        units  and  return  a  big-endian  binary integer number.  The possible
-       operations on an open *box_stat file are:
+       operations on an open ``*box_stat`` file are:
 
        read(2)
               If a count smaller than four is requested, read returns  -1  and
@@ -143,12 +151,7 @@ FILES
               in EAGAIN.
 
 
-   /npc
-   /decr
-   /decr_status
-   /spu_tag_mask
-   /event_mask
-   /srr0
+   /npc, /decr, /decr_status, /spu_tag_mask, /event_mask, /srr0
        Internal  registers  of  the SPU. The representation is an ASCII string
        with the numeric value of the next instruction to  be  executed.  These
        can  be  used in read/write mode for debugging, but normal operation of
@@ -157,17 +160,14 @@ FILES
 
        The contents of these files are:
 
+       =================== ===================================
        npc                 Next Program Counter
-
        decr                SPU Decrementer
-
        decr_status         Decrementer Status
-
        spu_tag_mask        MFC tag mask for SPU DMA
-
        event_mask          Event mask for SPU interrupts
-
        srr0                Interrupt Return address register
+       =================== ===================================
 
 
        The   possible   operations   on   an   open  npc,  decr,  decr_status,
@@ -206,8 +206,7 @@ FILES
               from the data buffer, updating the value of the fpcr register.
 
 
-   /signal1
-   /signal2
+   /signal1, /signal2
        The two signal notification channels of an SPU.  These  are  read-write
        files  that  operate  on  a 32 bit word.  Writing to one of these files
        triggers an interrupt on the SPU.  The  value  written  to  the  signal
@@ -233,8 +232,7 @@ FILES
               file.
 
 
-   /signal1_type
-   /signal2_type
+   /signal1_type, /signal2_type
        These two files change the behavior of the signal1 and signal2  notifi-
        cation  files.  The  contain  a numerical ASCII string which is read as
        either "1" or "0".  In mode 0 (overwrite), the  hardware  replaces  the
@@ -259,18 +257,17 @@ FILES
               the previous setting.
 
 
-EXAMPLES
+Examples
+========
        /etc/fstab entry
               none      /spu      spufs     gid=spu   0    0
 
 
-AUTHORS
+Authors
+=======
        Arnd  Bergmann  <arndb@de.ibm.com>,  Mark  Nutter <mnutter@us.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
 
-SEE ALSO
+See Also
+========
        capabilities(7), close(2), spu_create(2), spu_run(2), spufs(7)
-
-
-
-Linux                             2005-09-28                          SPUFS(2)
diff --git a/MAINTAINERS b/MAINTAINERS
index 519f5d84adca..2ac15ec9ebf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15900,7 +15900,7 @@ M:	Jeremy Kerr <jk@ozlabs.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/power/cell/
-F:	Documentation/filesystems/spufs.txt
+F:	Documentation/filesystems/spufs/spufs.rst
 F:	arch/powerpc/platforms/cell/spufs/
 
 SQUASHFS FILE SYSTEM
-- 
2.25.2

