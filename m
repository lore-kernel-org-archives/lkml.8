Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9931C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961CA2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593416;
	bh=f6GXLjPnwDckJXfqaCiej5T99kNCaF2Wd8VaNkz/nI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FyhpxQDMS4hgChrVd5H4pW0uXMnv9fRQ5WFas75nhWEQtOFFLzt83nRsTrBVRCJ12
	 0YN3Q8muuGfZG8gi0NGLw9QrHG1i7/K8IGppJeD3QYRK4kk3UhcNMmIL5MoIQpv8O9
	 FYHJXOLX4tSPJJkmRJHutvuTTKiJPAfgw9yRGWv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbgIHTaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68449241A6;
        Tue,  8 Sep 2020 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579543;
        bh=f6GXLjPnwDckJXfqaCiej5T99kNCaF2Wd8VaNkz/nI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLc0lQvSB124mDWLv5nuVP2POi1qW/bzNB7Gw8+9mhMI0DbbPXLhyhK/pEyscjITT
         I5aabCSOEqffO/oqhCCbQzpp7CTNH74B+Lhc1kcQQOGloWnJ/wXkIn5SbUnPCV3Djm
         Hu3R5TBtgdnx/ovC3KzIBFG1qAcKddTGFnYB6Eb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.8 122/186] xfs: dont update mtime on COW faults
Date:   Tue,  8 Sep 2020 17:24:24 +0200
Message-Id: <20200908152247.550362107@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit b17164e258e3888d376a7434415013175d637377 upstream.

When running in a dax mode, if the user maps a page with MAP_PRIVATE and
PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
when the user hits a COW fault.

This breaks building of the Linux kernel.  How to reproduce:

 1. extract the Linux kernel tree on dax-mounted xfs filesystem
 2. run make clean
 3. run make -j12
 4. run make -j12

at step 4, make would incorrectly rebuild the whole kernel (although it
was already built in step 3).

The reason for the breakage is that almost all object files depend on
objtool.  When we run objtool, it takes COW page fault on its .data
section, and these faults will incorrectly update the timestamp of the
objtool binary.  The updated timestamp causes make to rebuild the whole
tree.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_file.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1220,6 +1220,14 @@ __xfs_filemap_fault(
 	return ret;
 }
 
+static inline bool
+xfs_is_write_fault(
+	struct vm_fault		*vmf)
+{
+	return (vmf->flags & FAULT_FLAG_WRITE) &&
+	       (vmf->vma->vm_flags & VM_SHARED);
+}
+
 static vm_fault_t
 xfs_filemap_fault(
 	struct vm_fault		*vmf)
@@ -1227,7 +1235,7 @@ xfs_filemap_fault(
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
 			IS_DAX(file_inode(vmf->vma->vm_file)) &&
-			(vmf->flags & FAULT_FLAG_WRITE));
+			xfs_is_write_fault(vmf));
 }
 
 static vm_fault_t
@@ -1240,7 +1248,7 @@ xfs_filemap_huge_fault(
 
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, pe_size,
-			(vmf->flags & FAULT_FLAG_WRITE));
+			xfs_is_write_fault(vmf));
 }
 
 static vm_fault_t


