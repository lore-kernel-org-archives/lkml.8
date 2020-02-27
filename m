Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4AC52D41
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4E92468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812955;
	bh=gVc8LzbmeflKySr2f01bEmAA/rwDu/AxdarDgJjYY2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eZdSnCxM5ieXvah2ikzmrc77rYCD9uIAedlsggUYfyvk7x+5g7VdhImMyKRCs2FXY
	 Obyucp+2ccVbAaYWYKdO0r8KLZcRH/HVTUWkIFQjMaU22qUg2WMtqI32IgwaZrxCbu
	 c2SZuSQTStUN+WAMUjZ+IctXpMN4CTH4SpeF5MWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389383AbgB0OPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389369AbgB0OPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:15:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B167C20578;
        Thu, 27 Feb 2020 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812950;
        bh=gVc8LzbmeflKySr2f01bEmAA/rwDu/AxdarDgJjYY2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvRGjfsHFSmqfw8sbH0fiHEpnADofzfUkULQkXqNB0vvjkZCA++mPP3yM1RXHA2xr
         qz4bNURAjk+9mu1zE+Mz2UUPQ6xYSc+W2G/SCIZAaW4DCRCVVmz9u8SAY2V3DUpXhB
         cF8xxieaRjAQgoQxuathN9ksF6T+T2794Jk3TXF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Victor Stinner <vstinner@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.5 079/150] mm: Avoid creating virtual address aliases in brk()/mmap()/mremap()
Date:   Thu, 27 Feb 2020 14:36:56 +0100
Message-Id: <20200227132244.518067408@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

commit dcde237319e626d1ec3c9d8b7613032f0fd4663a upstream.

Currently the arm64 kernel ignores the top address byte passed to brk(),
mmap() and mremap(). When the user is not aware of the 56-bit address
limit or relies on the kernel to return an error, untagging such
pointers has the potential to create address aliases in user-space.
Passing a tagged address to munmap(), madvise() is permitted since the
tagged pointer is expected to be inside an existing mapping.

The current behaviour breaks the existing glibc malloc() implementation
which relies on brk() with an address beyond 56-bit to be rejected by
the kernel.

Remove untagging in the above functions by partially reverting commit
ce18d171cb73 ("mm: untag user pointers in mmap/munmap/mremap/brk"). In
addition, update the arm64 tagged-address-abi.rst document accordingly.

Link: https://bugzilla.redhat.com/1797052
Fixes: ce18d171cb73 ("mm: untag user pointers in mmap/munmap/mremap/brk")
Cc: <stable@vger.kernel.org> # 5.4.x-
Cc: Florian Weimer <fweimer@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Victor Stinner <vstinner@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/arm64/tagged-address-abi.rst |   11 +++++++++--
 mm/mmap.c                                  |    4 ----
 mm/mremap.c                                |    1 -
 3 files changed, 9 insertions(+), 7 deletions(-)

--- a/Documentation/arm64/tagged-address-abi.rst
+++ b/Documentation/arm64/tagged-address-abi.rst
@@ -44,8 +44,15 @@ The AArch64 Tagged Address ABI has two s
 how the user addresses are used by the kernel:
 
 1. User addresses not accessed by the kernel but used for address space
-   management (e.g. ``mmap()``, ``mprotect()``, ``madvise()``). The use
-   of valid tagged pointers in this context is always allowed.
+   management (e.g. ``mprotect()``, ``madvise()``). The use of valid
+   tagged pointers in this context is allowed with the exception of
+   ``brk()``, ``mmap()`` and the ``new_address`` argument to
+   ``mremap()`` as these have the potential to alias with existing
+   user addresses.
+
+   NOTE: This behaviour changed in v5.6 and so some earlier kernels may
+   incorrectly accept valid tagged pointers for the ``brk()``,
+   ``mmap()`` and ``mremap()`` system calls.
 
 2. User addresses accessed by the kernel (e.g. ``write()``). This ABI
    relaxation is disabled by default and the application thread needs to
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -195,8 +195,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded = false;
 	LIST_HEAD(uf);
 
-	brk = untagged_addr(brk);
-
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
@@ -1561,8 +1559,6 @@ unsigned long ksys_mmap_pgoff(unsigned l
 	struct file *file = NULL;
 	unsigned long retval;
 
-	addr = untagged_addr(addr);
-
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -607,7 +607,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, a
 	LIST_HEAD(uf_unmap);
 
 	addr = untagged_addr(addr);
-	new_addr = untagged_addr(new_addr);
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;


