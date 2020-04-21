Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3DBC55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D204206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488107;
	bh=D8slo2AUpDm68B9njFif/+P52JyjqenIucYmhJxmOIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFoOB1W86crn7S7hg+miqKR/kItwx9GCeyJz1H7EgH5zKKILjJb6KfRuhPHhKBUsk
	 trxVA/GPLfNswVCzMhXgf1n9I4EP5Cxd/X6owsoowXmYNrkkJwzAO/i0qIL7XA0I3o
	 B/eNpbzWIy+9n/AZSM8u89MEhKkp8lyJ8DEt7kxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgDUQzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgDUQyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:50 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971322168B;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=D8slo2AUpDm68B9njFif/+P52JyjqenIucYmhJxmOIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYpuGPKl4QR+bG8j6wPQkBqK+OkD75SBF1Z3hRVUB+w9IvbzyI+OuECKlr+Q9uSYb
         Q/kZ6+73UzbTp4iY2hvxmbwNGV8Bx0NktOg30kxbkcqPlIV5AQ4+Ahs7yDB9qJkBHg
         0Zolr3+Z+tI978gj6e0mZht8IRjb27TWrRKB3/nw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmF5-Pk; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 22/29] docs: filesystems: split spufs.txt into 3 separate files
Date:   Tue, 21 Apr 2020 18:54:33 +0200
Message-Id: <bb60146e08adb64f93b148e83debf6fe4ed046c5.1587487612.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587487612.git.mchehab+huawei@kernel.org>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has manpages for 3 different things. As we'll
be converting it to ReST, let's fist split it into their
individual components.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/spufs/spu_create.txt          | 119 +++++++++
 Documentation/filesystems/spufs/spu_run.txt   | 121 +++++++++
 .../filesystems/{ => spufs}/spufs.txt         | 245 ------------------
 3 files changed, 240 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/filesystems/spufs/spu_create.txt
 create mode 100644 Documentation/filesystems/spufs/spu_run.txt
 rename Documentation/filesystems/{ => spufs}/spufs.txt (59%)

diff --git a/Documentation/filesystems/spufs/spu_create.txt b/Documentation/filesystems/spufs/spu_create.txt
new file mode 100644
index 000000000000..8ede5a35340f
--- /dev/null
+++ b/Documentation/filesystems/spufs/spu_create.txt
@@ -0,0 +1,119 @@
+SPU_CREATE(2)              Linux Programmer's Manual             SPU_CREATE(2)
+
+
+
+NAME
+       spu_create - create a new spu context
+
+
+SYNOPSIS
+       #include <sys/types.h>
+       #include <sys/spu.h>
+
+       int spu_create(const char *pathname, int flags, mode_t mode);
+
+DESCRIPTION
+       The  spu_create  system call is used on PowerPC machines that implement
+       the Cell Broadband Engine Architecture in order to  access  Synergistic
+       Processor  Units (SPUs). It creates a new logical context for an SPU in
+       pathname and returns a handle to associated  with  it.   pathname  must
+       point  to  a  non-existing directory in the mount point of the SPU file
+       system (spufs).  When spu_create is successful, a directory  gets  cre-
+       ated on pathname and it is populated with files.
+
+       The  returned  file  handle can only be passed to spu_run(2) or closed,
+       other operations are not defined on it. When it is closed, all  associ-
+       ated  directory entries in spufs are removed. When the last file handle
+       pointing either inside  of  the  context  directory  or  to  this  file
+       descriptor is closed, the logical SPU context is destroyed.
+
+       The  parameter flags can be zero or any bitwise or'd combination of the
+       following constants:
+
+       SPU_RAWIO
+              Allow mapping of some of the hardware registers of the SPU  into
+              user space. This flag requires the CAP_SYS_RAWIO capability, see
+              capabilities(7).
+
+       The mode parameter specifies the permissions used for creating the  new
+       directory  in  spufs.   mode is modified with the user's umask(2) value
+       and then used for both the directory and the files contained in it. The
+       file permissions mask out some more bits of mode because they typically
+       support only read or write access. See stat(2) for a full list  of  the
+       possible mode values.
+
+
+RETURN VALUE
+       spu_create  returns a new file descriptor. It may return -1 to indicate
+       an error condition and set errno to  one  of  the  error  codes  listed
+       below.
+
+
+ERRORS
+       EACCES
+              The  current  user does not have write access on the spufs mount
+              point.
+
+       EEXIST An SPU context already exists at the given path name.
+
+       EFAULT pathname is not a valid string pointer in  the  current  address
+              space.
+
+       EINVAL pathname is not a directory in the spufs mount point.
+
+       ELOOP  Too many symlinks were found while resolving pathname.
+
+       EMFILE The process has reached its maximum open file limit.
+
+       ENAMETOOLONG
+              pathname was too long.
+
+       ENFILE The system has reached the global open file limit.
+
+       ENOENT Part of pathname could not be resolved.
+
+       ENOMEM The kernel could not allocate all resources required.
+
+       ENOSPC There  are  not  enough  SPU resources available to create a new
+              context or the user specific limit for the number  of  SPU  con-
+              texts has been reached.
+
+       ENOSYS the functionality is not provided by the current system, because
+              either the hardware does not provide SPUs or the spufs module is
+              not loaded.
+
+       ENOTDIR
+              A part of pathname is not a directory.
+
+
+
+NOTES
+       spu_create  is  meant  to  be used from libraries that implement a more
+       abstract interface to SPUs, not to be used from  regular  applications.
+       See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
+       ommended libraries.
+
+
+FILES
+       pathname must point to a location beneath the mount point of spufs.  By
+       convention, it gets mounted in /spu.
+
+
+CONFORMING TO
+       This call is Linux specific and only implemented by the ppc64 architec-
+       ture. Programs using this system call are not portable.
+
+
+BUGS
+       The code does not yet fully implement all features lined out here.
+
+
+AUTHOR
+       Arnd Bergmann <arndb@de.ibm.com>
+
+SEE ALSO
+       capabilities(7), close(2), spu_run(2), spufs(7)
+
+
+
+Linux                             2005-09-28                     SPU_CREATE(2)
diff --git a/Documentation/filesystems/spufs/spu_run.txt b/Documentation/filesystems/spufs/spu_run.txt
new file mode 100644
index 000000000000..d5c6a00d0f97
--- /dev/null
+++ b/Documentation/filesystems/spufs/spu_run.txt
@@ -0,0 +1,121 @@
+SPU_RUN(2)                 Linux Programmer's Manual                SPU_RUN(2)
+
+
+
+NAME
+       spu_run - execute an spu context
+
+
+SYNOPSIS
+       #include <sys/spu.h>
+
+       int spu_run(int fd, unsigned int *npc, unsigned int *event);
+
+DESCRIPTION
+       The  spu_run system call is used on PowerPC machines that implement the
+       Cell Broadband Engine Architecture in order to access Synergistic  Pro-
+       cessor  Units  (SPUs).  It  uses the fd that was returned from spu_cre-
+       ate(2) to address a specific SPU context. When the context gets  sched-
+       uled  to a physical SPU, it starts execution at the instruction pointer
+       passed in npc.
+
+       Execution of SPU code happens synchronously, meaning that spu_run  does
+       not  return  while the SPU is still running. If there is a need to exe-
+       cute SPU code in parallel with other code on either  the  main  CPU  or
+       other  SPUs,  you  need to create a new thread of execution first, e.g.
+       using the pthread_create(3) call.
+
+       When spu_run returns, the current value of the SPU instruction  pointer
+       is  written back to npc, so you can call spu_run again without updating
+       the pointers.
+
+       event can be a NULL pointer or point to an extended  status  code  that
+       gets  filled  when spu_run returns. It can be one of the following con-
+       stants:
+
+       SPE_EVENT_DMA_ALIGNMENT
+              A DMA alignment error
+
+       SPE_EVENT_SPE_DATA_SEGMENT
+              A DMA segmentation error
+
+       SPE_EVENT_SPE_DATA_STORAGE
+              A DMA storage error
+
+       If NULL is passed as the event argument, these errors will result in  a
+       signal delivered to the calling process.
+
+RETURN VALUE
+       spu_run  returns the value of the spu_status register or -1 to indicate
+       an error and set errno to one of the error  codes  listed  below.   The
+       spu_status  register  value  contains  a  bit  mask of status codes and
+       optionally a 14 bit code returned from the stop-and-signal  instruction
+       on the SPU. The bit masks for the status codes are:
+
+       0x02   SPU was stopped by stop-and-signal.
+
+       0x04   SPU was stopped by halt.
+
+       0x08   SPU is waiting for a channel.
+
+       0x10   SPU is in single-step mode.
+
+       0x20   SPU has tried to execute an invalid instruction.
+
+       0x40   SPU has tried to access an invalid channel.
+
+       0x3fff0000
+              The  bits  masked with this value contain the code returned from
+              stop-and-signal.
+
+       There are always one or more of the lower eight bits set  or  an  error
+       code is returned from spu_run.
+
+ERRORS
+       EAGAIN or EWOULDBLOCK
+              fd is in non-blocking mode and spu_run would block.
+
+       EBADF  fd is not a valid file descriptor.
+
+       EFAULT npc is not a valid pointer or status is neither NULL nor a valid
+              pointer.
+
+       EINTR  A signal occurred while spu_run was in progress.  The npc  value
+              has  been updated to the new program counter value if necessary.
+
+       EINVAL fd is not a file descriptor returned from spu_create(2).
+
+       ENOMEM Insufficient memory was available to handle a page fault result-
+              ing from an MFC direct memory access.
+
+       ENOSYS the functionality is not provided by the current system, because
+              either the hardware does not provide SPUs or the spufs module is
+              not loaded.
+
+
+NOTES
+       spu_run  is  meant  to  be  used  from  libraries that implement a more
+       abstract interface to SPUs, not to be used from  regular  applications.
+       See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
+       ommended libraries.
+
+
+CONFORMING TO
+       This call is Linux specific and only implemented by the ppc64 architec-
+       ture. Programs using this system call are not portable.
+
+
+BUGS
+       The code does not yet fully implement all features lined out here.
+
+
+AUTHOR
+       Arnd Bergmann <arndb@de.ibm.com>
+
+SEE ALSO
+       capabilities(7), close(2), spu_create(2), spufs(7)
+
+
+
+
+Linux                             2005-09-28                        SPU_RUN(2)
diff --git a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs/spufs.txt
similarity index 59%
rename from Documentation/filesystems/spufs.txt
rename to Documentation/filesystems/spufs/spufs.txt
index eb9e3aa63026..caf36aaae804 100644
--- a/Documentation/filesystems/spufs.txt
+++ b/Documentation/filesystems/spufs/spufs.txt
@@ -274,248 +274,3 @@ SEE ALSO
 
 
 Linux                             2005-09-28                          SPUFS(2)
-
-------------------------------------------------------------------------------
-
-SPU_RUN(2)                 Linux Programmer's Manual                SPU_RUN(2)
-
-
-
-NAME
-       spu_run - execute an spu context
-
-
-SYNOPSIS
-       #include <sys/spu.h>
-
-       int spu_run(int fd, unsigned int *npc, unsigned int *event);
-
-DESCRIPTION
-       The  spu_run system call is used on PowerPC machines that implement the
-       Cell Broadband Engine Architecture in order to access Synergistic  Pro-
-       cessor  Units  (SPUs).  It  uses the fd that was returned from spu_cre-
-       ate(2) to address a specific SPU context. When the context gets  sched-
-       uled  to a physical SPU, it starts execution at the instruction pointer
-       passed in npc.
-
-       Execution of SPU code happens synchronously, meaning that spu_run  does
-       not  return  while the SPU is still running. If there is a need to exe-
-       cute SPU code in parallel with other code on either  the  main  CPU  or
-       other  SPUs,  you  need to create a new thread of execution first, e.g.
-       using the pthread_create(3) call.
-
-       When spu_run returns, the current value of the SPU instruction  pointer
-       is  written back to npc, so you can call spu_run again without updating
-       the pointers.
-
-       event can be a NULL pointer or point to an extended  status  code  that
-       gets  filled  when spu_run returns. It can be one of the following con-
-       stants:
-
-       SPE_EVENT_DMA_ALIGNMENT
-              A DMA alignment error
-
-       SPE_EVENT_SPE_DATA_SEGMENT
-              A DMA segmentation error
-
-       SPE_EVENT_SPE_DATA_STORAGE
-              A DMA storage error
-
-       If NULL is passed as the event argument, these errors will result in  a
-       signal delivered to the calling process.
-
-RETURN VALUE
-       spu_run  returns the value of the spu_status register or -1 to indicate
-       an error and set errno to one of the error  codes  listed  below.   The
-       spu_status  register  value  contains  a  bit  mask of status codes and
-       optionally a 14 bit code returned from the stop-and-signal  instruction
-       on the SPU. The bit masks for the status codes are:
-
-       0x02   SPU was stopped by stop-and-signal.
-
-       0x04   SPU was stopped by halt.
-
-       0x08   SPU is waiting for a channel.
-
-       0x10   SPU is in single-step mode.
-
-       0x20   SPU has tried to execute an invalid instruction.
-
-       0x40   SPU has tried to access an invalid channel.
-
-       0x3fff0000
-              The  bits  masked with this value contain the code returned from
-              stop-and-signal.
-
-       There are always one or more of the lower eight bits set  or  an  error
-       code is returned from spu_run.
-
-ERRORS
-       EAGAIN or EWOULDBLOCK
-              fd is in non-blocking mode and spu_run would block.
-
-       EBADF  fd is not a valid file descriptor.
-
-       EFAULT npc is not a valid pointer or status is neither NULL nor a valid
-              pointer.
-
-       EINTR  A signal occurred while spu_run was in progress.  The npc  value
-              has  been updated to the new program counter value if necessary.
-
-       EINVAL fd is not a file descriptor returned from spu_create(2).
-
-       ENOMEM Insufficient memory was available to handle a page fault result-
-              ing from an MFC direct memory access.
-
-       ENOSYS the functionality is not provided by the current system, because
-              either the hardware does not provide SPUs or the spufs module is
-              not loaded.
-
-
-NOTES
-       spu_run  is  meant  to  be  used  from  libraries that implement a more
-       abstract interface to SPUs, not to be used from  regular  applications.
-       See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
-       ommended libraries.
-
-
-CONFORMING TO
-       This call is Linux specific and only implemented by the ppc64 architec-
-       ture. Programs using this system call are not portable.
-
-
-BUGS
-       The code does not yet fully implement all features lined out here.
-
-
-AUTHOR
-       Arnd Bergmann <arndb@de.ibm.com>
-
-SEE ALSO
-       capabilities(7), close(2), spu_create(2), spufs(7)
-
-
-
-Linux                             2005-09-28                        SPU_RUN(2)
-
-------------------------------------------------------------------------------
-
-SPU_CREATE(2)              Linux Programmer's Manual             SPU_CREATE(2)
-
-
-
-NAME
-       spu_create - create a new spu context
-
-
-SYNOPSIS
-       #include <sys/types.h>
-       #include <sys/spu.h>
-
-       int spu_create(const char *pathname, int flags, mode_t mode);
-
-DESCRIPTION
-       The  spu_create  system call is used on PowerPC machines that implement
-       the Cell Broadband Engine Architecture in order to  access  Synergistic
-       Processor  Units (SPUs). It creates a new logical context for an SPU in
-       pathname and returns a handle to associated  with  it.   pathname  must
-       point  to  a  non-existing directory in the mount point of the SPU file
-       system (spufs).  When spu_create is successful, a directory  gets  cre-
-       ated on pathname and it is populated with files.
-
-       The  returned  file  handle can only be passed to spu_run(2) or closed,
-       other operations are not defined on it. When it is closed, all  associ-
-       ated  directory entries in spufs are removed. When the last file handle
-       pointing either inside  of  the  context  directory  or  to  this  file
-       descriptor is closed, the logical SPU context is destroyed.
-
-       The  parameter flags can be zero or any bitwise or'd combination of the
-       following constants:
-
-       SPU_RAWIO
-              Allow mapping of some of the hardware registers of the SPU  into
-              user space. This flag requires the CAP_SYS_RAWIO capability, see
-              capabilities(7).
-
-       The mode parameter specifies the permissions used for creating the  new
-       directory  in  spufs.   mode is modified with the user's umask(2) value
-       and then used for both the directory and the files contained in it. The
-       file permissions mask out some more bits of mode because they typically
-       support only read or write access. See stat(2) for a full list  of  the
-       possible mode values.
-
-
-RETURN VALUE
-       spu_create  returns a new file descriptor. It may return -1 to indicate
-       an error condition and set errno to  one  of  the  error  codes  listed
-       below.
-
-
-ERRORS
-       EACCES
-              The  current  user does not have write access on the spufs mount
-              point.
-
-       EEXIST An SPU context already exists at the given path name.
-
-       EFAULT pathname is not a valid string pointer in  the  current  address
-              space.
-
-       EINVAL pathname is not a directory in the spufs mount point.
-
-       ELOOP  Too many symlinks were found while resolving pathname.
-
-       EMFILE The process has reached its maximum open file limit.
-
-       ENAMETOOLONG
-              pathname was too long.
-
-       ENFILE The system has reached the global open file limit.
-
-       ENOENT Part of pathname could not be resolved.
-
-       ENOMEM The kernel could not allocate all resources required.
-
-       ENOSPC There  are  not  enough  SPU resources available to create a new
-              context or the user specific limit for the number  of  SPU  con-
-              texts has been reached.
-
-       ENOSYS the functionality is not provided by the current system, because
-              either the hardware does not provide SPUs or the spufs module is
-              not loaded.
-
-       ENOTDIR
-              A part of pathname is not a directory.
-
-
-
-NOTES
-       spu_create  is  meant  to  be used from libraries that implement a more
-       abstract interface to SPUs, not to be used from  regular  applications.
-       See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
-       ommended libraries.
-
-
-FILES
-       pathname must point to a location beneath the mount point of spufs.  By
-       convention, it gets mounted in /spu.
-
-
-CONFORMING TO
-       This call is Linux specific and only implemented by the ppc64 architec-
-       ture. Programs using this system call are not portable.
-
-
-BUGS
-       The code does not yet fully implement all features lined out here.
-
-
-AUTHOR
-       Arnd Bergmann <arndb@de.ibm.com>
-
-SEE ALSO
-       capabilities(7), close(2), spu_run(2), spufs(7)
-
-
-
-Linux                             2005-09-28                     SPU_CREATE(2)
-- 
2.25.2

