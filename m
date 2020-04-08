Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E6C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8072076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360820;
	bh=qyvpmE8CRWmyIjgvEe6bJz2RiR+UcsP4YX7xatfe0jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2dzpPtZKeZFI7q9+b+AyUdxNq97pdABXas2OrO0hG1WU4Nm+Jpd6Kc1cQ33+680Bi
	 SAsWKwjtRLe8Fff1oMAq+6uB60FmdecwC8QBDsYi4XTZq/yZQ4Kp3CvSqdxdri0Zkc
	 cLk12uYD9gBiIyqmO6P1ytnqjifcLU5GYT+EM+ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgDHPq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbgDHPqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:34 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8B521D91;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=qyvpmE8CRWmyIjgvEe6bJz2RiR+UcsP4YX7xatfe0jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeY+LJw8WmGhyJYOgM+XcuLEcWlg+eNnd/zhBTdRJ65pOHaM+lO+vFYmWTolI/dGs
         2gXFhLk/ZLlleRsu57Ead9Cm5hHOq7q+UgQsPdo5/VTppmiWrKoiCIWU6wzHuqjgkP
         h7j5AXJaJCAzLFTVu1Z9FQxJHFHvfiEOV7fw5Mgc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCF-0B; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 25/35] docs mm: userfaultfd.rst: use ``foo`` for literals
Date:   Wed,  8 Apr 2020 17:46:17 +0200
Message-Id: <1c664b01737943e70e351eb59c754131b8d3c56e.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several parts of this document define literals: ioctl names,
function calls, directory patches, etc. Mark those as literal
blocks, in order to improve its readability (both at text mode
and after parsed by Sphinx.

This fixes those two warnings:

	Documentation/admin-guide/mm/userfaultfd.rst:139: WARNING: Inline emphasis start-string without end-string.
	Documentation/admin-guide/mm/userfaultfd.rst:139: WARNING: Inline emphasis start-string without end-string.

produced during documentation build.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 207 ++++++++++---------
 1 file changed, 104 insertions(+), 103 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index c30176e67900..740d111faf1c 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -12,107 +12,107 @@ and more generally they allow userland to take control of various
 memory page faults, something otherwise only the kernel code could do.
 
 For example userfaults allows a proper and more optimal implementation
-of the PROT_NONE+SIGSEGV trick.
+of the ``PROT_NONE+SIGSEGV`` trick.
 
 Design
 ======
 
-Userfaults are delivered and resolved through the userfaultfd syscall.
+Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
 
-The userfaultfd (aside from registering and unregistering virtual
+The ``userfaultfd`` (aside from registering and unregistering virtual
 memory ranges) provides two primary functionalities:
 
-1) read/POLLIN protocol to notify a userland thread of the faults
+1) ``read/POLLIN`` protocol to notify a userland thread of the faults
    happening
 
-2) various UFFDIO_* ioctls that can manage the virtual memory regions
-   registered in the userfaultfd that allows userland to efficiently
+2) various ``UFFDIO_*`` ioctls that can manage the virtual memory regions
+   registered in the ``userfaultfd`` that allows userland to efficiently
    resolve the userfaults it receives via 1) or to manage the virtual
    memory in the background
 
 The real advantage of userfaults if compared to regular virtual memory
 management of mremap/mprotect is that the userfaults in all their
 operations never involve heavyweight structures like vmas (in fact the
-userfaultfd runtime load never takes the mmap_sem for writing).
+``userfaultfd`` runtime load never takes the mmap_sem for writing).
 
 Vmas are not suitable for page- (or hugepage) granular fault tracking
 when dealing with virtual address spaces that could span
 Terabytes. Too many vmas would be needed for that.
 
-The userfaultfd once opened by invoking the syscall, can also be
+The ``userfaultfd`` once opened by invoking the syscall, can also be
 passed using unix domain sockets to a manager process, so the same
 manager process could handle the userfaults of a multitude of
 different processes without them being aware about what is going on
-(well of course unless they later try to use the userfaultfd
+(well of course unless they later try to use the ``userfaultfd``
 themselves on the same region the manager is already tracking, which
-is a corner case that would currently return -EBUSY).
+is a corner case that would currently return ``-EBUSY``).
 
 API
 ===
 
-When first opened the userfaultfd must be enabled invoking the
-UFFDIO_API ioctl specifying a uffdio_api.api value set to UFFD_API (or
-a later API version) which will specify the read/POLLIN protocol
-userland intends to speak on the UFFD and the uffdio_api.features
-userland requires. The UFFDIO_API ioctl if successful (i.e. if the
-requested uffdio_api.api is spoken also by the running kernel and the
+When first opened the ``userfaultfd`` must be enabled invoking the
+``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
+a later API version) which will specify the ``read/POLLIN`` protocol
+userland intends to speak on the ``UFFD`` and the ``uffdio_api.features``
+userland requires. The ``UFFDIO_API`` ioctl if successful (i.e. if the
+requested ``uffdio_api.api`` is spoken also by the running kernel and the
 requested features are going to be enabled) will return into
-uffdio_api.features and uffdio_api.ioctls two 64bit bitmasks of
+``uffdio_api.features`` and ``uffdio_api.ioctls`` two 64bit bitmasks of
 respectively all the available features of the read(2) protocol and
 the generic ioctl available.
 
-The uffdio_api.features bitmask returned by the UFFDIO_API ioctl
-defines what memory types are supported by the userfaultfd and what
+The ``uffdio_api.features`` bitmask returned by the ``UFFDIO_API`` ioctl
+defines what memory types are supported by the ``userfaultfd`` and what
 events, except page fault notifications, may be generated.
 
-If the kernel supports registering userfaultfd ranges on hugetlbfs
-virtual memory areas, UFFD_FEATURE_MISSING_HUGETLBFS will be set in
-uffdio_api.features. Similarly, UFFD_FEATURE_MISSING_SHMEM will be
-set if the kernel supports registering userfaultfd ranges on shared
-memory (covering all shmem APIs, i.e. tmpfs, IPCSHM, /dev/zero
-MAP_SHARED, memfd_create, etc).
+If the kernel supports registering ``userfaultfd`` ranges on hugetlbfs
+virtual memory areas, ``UFFD_FEATURE_MISSING_HUGETLBFS`` will be set in
+``uffdio_api.features``. Similarly, ``UFFD_FEATURE_MISSING_SHMEM`` will be
+set if the kernel supports registering ``userfaultfd`` ranges on shared
+memory (covering all shmem APIs, i.e. tmpfs, ``IPCSHM``, ``/dev/zero``,
+``MAP_SHARED``, ``memfd_create``, etc).
 
-The userland application that wants to use userfaultfd with hugetlbfs
+The userland application that wants to use ``userfaultfd`` with hugetlbfs
 or shared memory need to set the corresponding flag in
-uffdio_api.features to enable those features.
+``uffdio_api.features`` to enable those features.
 
 If the userland desires to receive notifications for events other than
-page faults, it has to verify that uffdio_api.features has appropriate
-UFFD_FEATURE_EVENT_* bits set. These events are described in more
+page faults, it has to verify that ``uffdio_api.features`` has appropriate
+``UFFD_FEATURE_EVENT_*`` bits set. These events are described in more
 detail below in "Non-cooperative userfaultfd" section.
 
-Once the userfaultfd has been enabled the UFFDIO_REGISTER ioctl should
-be invoked (if present in the returned uffdio_api.ioctls bitmask) to
-register a memory range in the userfaultfd by setting the
-uffdio_register structure accordingly. The uffdio_register.mode
+Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
+be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
+register a memory range in the ``userfaultfd`` by setting the
+uffdio_register structure accordingly. The ``uffdio_register.mode``
 bitmask will specify to the kernel which kind of faults to track for
-the range (UFFDIO_REGISTER_MODE_MISSING would track missing
-pages). The UFFDIO_REGISTER ioctl will return the
-uffdio_register.ioctls bitmask of ioctls that are suitable to resolve
+the range (``UFFDIO_REGISTER_MODE_MISSING`` would track missing
+pages). The ``UFFDIO_REGISTER`` ioctl will return the
+``uffdio_register.ioctls`` bitmask of ioctls that are suitable to resolve
 userfaults on the range registered. Not all ioctls will necessarily be
 supported for all memory types depending on the underlying virtual
 memory backend (anonymous memory vs tmpfs vs real filebacked
 mappings).
 
-Userland can use the uffdio_register.ioctls to manage the virtual
+Userland can use the ``uffdio_register.ioctls`` to manage the virtual
 address space in the background (to add or potentially also remove
-memory from the userfaultfd registered range). This means a userfault
+memory from the ``userfaultfd`` registered range). This means a userfault
 could be triggering just before userland maps in the background the
 user-faulted page.
 
-The primary ioctl to resolve userfaults is UFFDIO_COPY. That
+The primary ioctl to resolve userfaults is ``UFFDIO_COPY``. That
 atomically copies a page into the userfault registered range and wakes
-up the blocked userfaults (unless uffdio_copy.mode &
-UFFDIO_COPY_MODE_DONTWAKE is set). Other ioctl works similarly to
-UFFDIO_COPY. They're atomic as in guaranteeing that nothing can see an
-half copied page since it'll keep userfaulting until the copy has
-finished.
+up the blocked userfaults
+(unless ``uffdio_copy.mode & UFFDIO_COPY_MODE_DONTWAKE`` is set).
+Other ioctl works similarly to ``UFFDIO_COPY``. They're atomic as in
+guaranteeing that nothing can see an half copied page since it'll
+keep userfaulting until the copy has finished.
 
 Notes:
 
-- If you requested UFFDIO_REGISTER_MODE_MISSING when registering then
+- If you requested ``UFFDIO_REGISTER_MODE_MISSING`` when registering then
   you must provide some kind of page in your thread after reading from
-  the uffd.  You must provide either UFFDIO_COPY or UFFDIO_ZEROPAGE.
+  the uffd.  You must provide either ``UFFDIO_COPY`` or ``UFFDIO_ZEROPAGE``.
   The normal behavior of the OS automatically providing a zero page on
   an annonymous mmaping is not in place.
 
@@ -122,13 +122,13 @@ Notes:
 
 - You get the address of the access that triggered the missing page
   event out of a struct uffd_msg that you read in the thread from the
-  uffd.  You can supply as many pages as you want with UFFDIO_COPY or
-  UFFDIO_ZEROPAGE.  Keep in mind that unless you used DONTWAKE then
+  uffd.  You can supply as many pages as you want with ``UFFDIO_COPY`` or
+  ``UFFDIO_ZEROPAGE``.  Keep in mind that unless you used DONTWAKE then
   the first of any of those IOCTLs wakes up the faulting thread.
 
-- Be sure to test for all errors including (pollfd[0].revents &
-  POLLERR).  This can happen, e.g. when ranges supplied were
-  incorrect.
+- Be sure to test for all errors including
+  (``pollfd[0].revents & POLLERR``).  This can happen, e.g. when ranges
+  supplied were incorrect.
 
 Write Protect Notifications
 ---------------------------
@@ -136,41 +136,42 @@ Write Protect Notifications
 This is equivalent to (but faster than) using mprotect and a SIGSEGV
 signal handler.
 
-Firstly you need to register a range with UFFDIO_REGISTER_MODE_WP.
-Instead of using mprotect(2) you use ioctl(uffd, UFFDIO_WRITEPROTECT,
-struct *uffdio_writeprotect) while mode = UFFDIO_WRITEPROTECT_MODE_WP
+Firstly you need to register a range with ``UFFDIO_REGISTER_MODE_WP``.
+Instead of using mprotect(2) you use
+``ioctl(uffd, UFFDIO_WRITEPROTECT, struct *uffdio_writeprotect)``
+while ``mode = UFFDIO_WRITEPROTECT_MODE_WP``
 in the struct passed in.  The range does not default to and does not
 have to be identical to the range you registered with.  You can write
 protect as many ranges as you like (inside the registered range).
 Then, in the thread reading from uffd the struct will have
-msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP set. Now you send
-ioctl(uffd, UFFDIO_WRITEPROTECT, struct *uffdio_writeprotect) again
-while pagefault.mode does not have UFFDIO_WRITEPROTECT_MODE_WP set.
-This wakes up the thread which will continue to run with writes. This
+``msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP`` set. Now you send
+``ioctl(uffd, UFFDIO_WRITEPROTECT, struct *uffdio_writeprotect)``
+again while ``pagefault.mode`` does not have ``UFFDIO_WRITEPROTECT_MODE_WP``
+set. This wakes up the thread which will continue to run with writes. This
 allows you to do the bookkeeping about the write in the uffd reading
 thread before the ioctl.
 
-If you registered with both UFFDIO_REGISTER_MODE_MISSING and
-UFFDIO_REGISTER_MODE_WP then you need to think about the sequence in
+If you registered with both ``UFFDIO_REGISTER_MODE_MISSING`` and
+``UFFDIO_REGISTER_MODE_WP`` then you need to think about the sequence in
 which you supply a page and undo write protect.  Note that there is a
 difference between writes into a WP area and into a !WP area.  The
-former will have UFFD_PAGEFAULT_FLAG_WP set, the latter
-UFFD_PAGEFAULT_FLAG_WRITE.  The latter did not fail on protection but
-you still need to supply a page when UFFDIO_REGISTER_MODE_MISSING was
+former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
+``UFFD_PAGEFAULT_FLAG_WRITE``.  The latter did not fail on protection but
+you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
 used.
 
 QEMU/KVM
 ========
 
-QEMU/KVM is using the userfaultfd syscall to implement postcopy live
+QEMU/KVM is using the ``userfaultfd`` syscall to implement postcopy live
 migration. Postcopy live migration is one form of memory
 externalization consisting of a virtual machine running with part or
 all of its memory residing on a different node in the cloud. The
-userfaultfd abstraction is generic enough that not a single line of
+``userfaultfd`` abstraction is generic enough that not a single line of
 KVM kernel code had to be modified in order to add postcopy live
 migration to QEMU.
 
-Guest async page faults, FOLL_NOWAIT and all other GUP features work
+Guest async page faults, ``FOLL_NOWAIT`` and all other ``GUP*`` features work
 just fine in combination with userfaults. Userfaults trigger async
 page faults in the guest scheduler so those guest processes that
 aren't waiting for userfaults (i.e. network bound) can keep running in
@@ -183,19 +184,19 @@ generating userfaults for readonly guest regions.
 The implementation of postcopy live migration currently uses one
 single bidirectional socket but in the future two different sockets
 will be used (to reduce the latency of the userfaults to the minimum
-possible without having to decrease /proc/sys/net/ipv4/tcp_wmem).
+possible without having to decrease ``/proc/sys/net/ipv4/tcp_wmem``).
 
 The QEMU in the source node writes all pages that it knows are missing
 in the destination node, into the socket, and the migration thread of
-the QEMU running in the destination node runs UFFDIO_COPY|ZEROPAGE
-ioctls on the userfaultfd in order to map the received pages into the
-guest (UFFDIO_ZEROCOPY is used if the source page was a zero page).
+the QEMU running in the destination node runs ``UFFDIO_COPY|ZEROPAGE``
+ioctls on the ``userfaultfd`` in order to map the received pages into the
+guest (``UFFDIO_ZEROCOPY`` is used if the source page was a zero page).
 
 A different postcopy thread in the destination node listens with
-poll() to the userfaultfd in parallel. When a POLLIN event is
+poll() to the ``userfaultfd`` in parallel. When a ``POLLIN`` event is
 generated after a userfault triggers, the postcopy thread read() from
-the userfaultfd and receives the fault address (or -EAGAIN in case the
-userfault was already resolved and waken by a UFFDIO_COPY|ZEROPAGE run
+the ``userfaultfd`` and receives the fault address (or ``-EAGAIN`` in case the
+userfault was already resolved and waken by a ``UFFDIO_COPY|ZEROPAGE`` run
 by the parallel QEMU migration thread).
 
 After the QEMU postcopy thread (running in the destination node) gets
@@ -206,7 +207,7 @@ remaining missing pages from that new page offset. Soon after that
 (just the time to flush the tcp_wmem queue through the network) the
 migration thread in the QEMU running in the destination node will
 receive the page that triggered the userfault and it'll map it as
-usual with the UFFDIO_COPY|ZEROPAGE (without actually knowing if it
+usual with the ``UFFDIO_COPY|ZEROPAGE`` (without actually knowing if it
 was spontaneously sent by the source or if it was an urgent page
 requested through a userfault).
 
@@ -219,74 +220,74 @@ checked to find which missing pages to send in round robin and we seek
 over it when receiving incoming userfaults. After sending each page of
 course the bitmap is updated accordingly. It's also useful to avoid
 sending the same page twice (in case the userfault is read by the
-postcopy thread just before UFFDIO_COPY|ZEROPAGE runs in the migration
+postcopy thread just before ``UFFDIO_COPY|ZEROPAGE`` runs in the migration
 thread).
 
 Non-cooperative userfaultfd
 ===========================
 
-When the userfaultfd is monitored by an external manager, the manager
+When the ``userfaultfd`` is monitored by an external manager, the manager
 must be able to track changes in the process virtual memory
 layout. Userfaultfd can notify the manager about such changes using
 the same read(2) protocol as for the page fault notifications. The
 manager has to explicitly enable these events by setting appropriate
-bits in uffdio_api.features passed to UFFDIO_API ioctl:
+bits in ``uffdio_api.features`` passed to ``UFFDIO_API`` ioctl:
 
-UFFD_FEATURE_EVENT_FORK
-	enable userfaultfd hooks for fork(). When this feature is
-	enabled, the userfaultfd context of the parent process is
+``UFFD_FEATURE_EVENT_FORK``
+	enable ``userfaultfd`` hooks for fork(). When this feature is
+	enabled, the ``userfaultfd`` context of the parent process is
 	duplicated into the newly created process. The manager
-	receives UFFD_EVENT_FORK with file descriptor of the new
-	userfaultfd context in the uffd_msg.fork.
+	receives ``UFFD_EVENT_FORK`` with file descriptor of the new
+	``userfaultfd`` context in the ``uffd_msg.fork``.
 
-UFFD_FEATURE_EVENT_REMAP
+``UFFD_FEATURE_EVENT_REMAP``
 	enable notifications about mremap() calls. When the
 	non-cooperative process moves a virtual memory area to a
 	different location, the manager will receive
-	UFFD_EVENT_REMAP. The uffd_msg.remap will contain the old and
+	``UFFD_EVENT_REMAP``. The ``uffd_msg.remap`` will contain the old and
 	new addresses of the area and its original length.
 
-UFFD_FEATURE_EVENT_REMOVE
+``UFFD_FEATURE_EVENT_REMOVE``
 	enable notifications about madvise(MADV_REMOVE) and
-	madvise(MADV_DONTNEED) calls. The event UFFD_EVENT_REMOVE will
-	be generated upon these calls to madvise. The uffd_msg.remove
+	madvise(MADV_DONTNEED) calls. The event ``UFFD_EVENT_REMOVE`` will
+	be generated upon these calls to madvise(). The ``uffd_msg.remove``
 	will contain start and end addresses of the removed area.
 
-UFFD_FEATURE_EVENT_UNMAP
+``UFFD_FEATURE_EVENT_UNMAP``
 	enable notifications about memory unmapping. The manager will
-	get UFFD_EVENT_UNMAP with uffd_msg.remove containing start and
+	get ``UFFD_EVENT_UNMAP`` with ``uffd_msg.remove`` containing start and
 	end addresses of the unmapped area.
 
-Although the UFFD_FEATURE_EVENT_REMOVE and UFFD_FEATURE_EVENT_UNMAP
+Although the ``UFFD_FEATURE_EVENT_REMOVE`` and ``UFFD_FEATURE_EVENT_UNMAP``
 are pretty similar, they quite differ in the action expected from the
-userfaultfd manager. In the former case, the virtual memory is
+``userfaultfd`` manager. In the former case, the virtual memory is
 removed, but the area is not, the area remains monitored by the
-userfaultfd, and if a page fault occurs in that area it will be
+``userfaultfd``, and if a page fault occurs in that area it will be
 delivered to the manager. The proper resolution for such page fault is
 to zeromap the faulting address. However, in the latter case, when an
 area is unmapped, either explicitly (with munmap() system call), or
 implicitly (e.g. during mremap()), the area is removed and in turn the
-userfaultfd context for such area disappears too and the manager will
+``userfaultfd`` context for such area disappears too and the manager will
 not get further userland page faults from the removed area. Still, the
 notification is required in order to prevent manager from using
-UFFDIO_COPY on the unmapped area.
+``UFFDIO_COPY`` on the unmapped area.
 
 Unlike userland page faults which have to be synchronous and require
 explicit or implicit wakeup, all the events are delivered
 asynchronously and the non-cooperative process resumes execution as
-soon as manager executes read(). The userfaultfd manager should
-carefully synchronize calls to UFFDIO_COPY with the events
-processing. To aid the synchronization, the UFFDIO_COPY ioctl will
-return -ENOSPC when the monitored process exits at the time of
-UFFDIO_COPY, and -ENOENT, when the non-cooperative process has changed
-its virtual memory layout simultaneously with outstanding UFFDIO_COPY
+soon as manager executes read(). The ``userfaultfd`` manager should
+carefully synchronize calls to ``UFFDIO_COPY`` with the events
+processing. To aid the synchronization, the ``UFFDIO_COPY`` ioctl will
+return ``-ENOSPC`` when the monitored process exits at the time of
+``UFFDIO_COPY``, and ``-ENOENT``, when the non-cooperative process has changed
+its virtual memory layout simultaneously with outstanding ``UFFDIO_COPY``
 operation.
 
 The current asynchronous model of the event delivery is optimal for
-single threaded non-cooperative userfaultfd manager implementations. A
+single threaded non-cooperative ``userfaultfd`` manager implementations. A
 synchronous event delivery model can be added later as a new
-userfaultfd feature to facilitate multithreading enhancements of the
-non cooperative manager, for example to allow UFFDIO_COPY ioctls to
+``userfaultfd`` feature to facilitate multithreading enhancements of the
+non cooperative manager, for example to allow ``UFFDIO_COPY`` ioctls to
 run in parallel to the event reception. Single threaded
 implementations should continue to use the current async event
 delivery model instead.
-- 
2.25.2

