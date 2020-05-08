Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3ACC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B7224958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942582;
	bh=f0xr2TAEkyL4kye8GmlZwNW+yvmgzpgCK7AqH3ydBQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXC2ub3B8B/zeIFRz7dXPAMOVXkC+xzZZ2g1uxIWFXm1mcYc+M3lG/2F5Nk0PTRnB
	 yhnFBdogXXTxN9UmyQ//BCyPN8jzSKssNWoWts41v1S9Xm+NwNP1aclCL5t62dzSXm
	 Xux6JgadDYXjO5ucou/UdO6TG5yc7a9mbcRHyBtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgEHM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgEHM4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE32224969;
        Fri,  8 May 2020 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942577;
        bh=f0xr2TAEkyL4kye8GmlZwNW+yvmgzpgCK7AqH3ydBQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZ6ZNUBlW6T58Dg1C/oXzpBwUS162kInjlfB4KNAaTEVB8JsDPLdHC5McdWmyRw/H
         +ea90G8hxyPxVDfoCiv56nWKDLxsMEgd2jYcB+TkCS9yeNUSdQfHVl9NQ9ECBRVlTn
         XHfDm30INKPWEjG96GPjILXzhdef6FD+FeGEVGoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.6 49/49] mm/mremap: Add comment explaining the untagging behaviour of mremap()
Date:   Fri,  8 May 2020 14:36:06 +0200
Message-Id: <20200508123049.580997355@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit b2a84de2a2deb76a6a51609845341f508c518c03 upstream.

Commit dcde237319e6 ("mm: Avoid creating virtual address aliases in
brk()/mmap()/mremap()") changed mremap() so that only the 'old' address
is untagged, leaving the 'new' address in the form it was passed from
userspace. This prevents the unexpected creation of aliasing virtual
mappings in userspace, but looks a bit odd when you read the code.

Add a comment justifying the untagging behaviour in mremap().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mremap.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -606,6 +606,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, a
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	/*
+	 * There is a deliberate asymmetry here: we strip the pointer tag
+	 * from the old address but leave the new address alone. This is
+	 * for consistency with mmap(), where we prevent the creation of
+	 * aliasing mappings in userspace by leaving the tag bits of the
+	 * mapping address intact. A non-zero tag will cause the subsequent
+	 * range checks to reject the address as invalid.
+	 *
+	 * See Documentation/arm64/tagged-address-abi.rst for more information.
+	 */
 	addr = untagged_addr(addr);
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))


