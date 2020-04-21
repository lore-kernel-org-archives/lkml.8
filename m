Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D6DC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EA8206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488158;
	bh=ca5DzOW49HF9V5uHabulUV53tWgt8H+LSNMlYLDm8xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WkntMTJ6OUAEIlUd0jBKBk3gP1hvu+5KR56z0xiUGVAkXCxYblOqzP4dQN9HCO5bl
	 4EO3ncvaUvDM/eWr0+mh8dcol4c9pMuePpRub5ZggjogZl8JpdP7KxD2zct15LnUYQ
	 4ykFrALcJsLqKkvFEVviC6qvcSMPisaxucO5T+Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgDUQz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgDUQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:48 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A293B21744;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=ca5DzOW49HF9V5uHabulUV53tWgt8H+LSNMlYLDm8xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nn2EUipuLq5hnB3Pis+axElJSkvRWfRCOhJvQuJNqYXm0sqWF35YObPlNJGl2W6yY
         N0XWk3+AjelNPj9pvZW1jbJfJk+4QDOPOMxRv2TO8Im4r6Fv9TLpuMVnBRoiDB0qNl
         /eBXOQntwSDMYD3ooblTL6SiTKW/mVju4rMsa0MM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmFF-Rv; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 24/29] docs: filesystems: convert spufs/spufs.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:35 +0200
Message-Id: <0d141b3f1aa9d1cc26508500f6778973fcd369f6.1587487612.git.mchehab+huawei@kernel.org>
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
index ac8ddd91928a..968c97eda352 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15955,7 +15955,7 @@ M:	Jeremy Kerr <jk@ozlabs.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/power/cell/
-F:	Documentation/filesystems/spufs.txt
+F:	Documentation/filesystems/spufs/spufs.rst
 F:	arch/powerpc/platforms/cell/spufs/
 
 SQUASHFS FILE SYSTEM
-- 
2.25.2

