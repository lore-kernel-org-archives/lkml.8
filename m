Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23934C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E535820639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258753;
	bh=bwJDBs57T0HWecCtTiQwXS+EX5zVLlTne8P+SfQfMyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kt5nab4K8A8cVcAXmrn/TVSPL3uHsx2u8PgaWhNpGfo81DVMAoYtGkv0k3p/Y6d6t
	 wcR86tq5u1x7cELZCTw/LL9/i1FMZ6GWmAlI54QHigU02QWZJF9HflUa1vqfOLZL9g
	 cZvPqA84CPf1w0qoruGK3hshTp13Ebgr4vVTfWuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgHXIpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgHXIpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46046206F0;
        Mon, 24 Aug 2020 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258742;
        bh=bwJDBs57T0HWecCtTiQwXS+EX5zVLlTne8P+SfQfMyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdRpS36dcc9bF5t18oQsFuU5X9ou0R1h9UCjkQAi3N9kp8KQqHaaGhK98efcVDGMu
         4OyUc/y1K09jVgWecheKcmL1TaNDUOX21b2m/8zPMxo27BJvhgZSMLlDyumvo9G247
         u4R+GJRCnkWFppUN1JHX86KCoIrPwpmv8uMve8Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 028/107] uprobes: __replace_page() avoid BUG in munlock_vma_page()
Date:   Mon, 24 Aug 2020 10:29:54 +0200
Message-Id: <20200824082406.505127550@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

commit c17c3dc9d08b9aad9a55a1e53f205187972f448e upstream.

syzbot crashed on the VM_BUG_ON_PAGE(PageTail) in munlock_vma_page(), when
called from uprobes __replace_page().  Which of many ways to fix it?
Settled on not calling when PageCompound (since Head and Tail are equals
in this context, PageCompound the usual check in uprobes.c, and the prior
use of FOLL_SPLIT_PMD will have cleared PageMlocked already).

Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>	[5.4+]
Link: http://lkml.kernel.org/r/alpine.LSU.2.11.2008161338360.20413@eggly.anvils
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/uprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -211,7 +211,7 @@ static int __replace_page(struct vm_area
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
 
-	if (vma->vm_flags & VM_LOCKED)
+	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
 		munlock_vma_page(old_page);
 	put_page(old_page);
 


