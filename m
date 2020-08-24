Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66A0206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262559;
	bh=tOaViDPcAlbFFhlCe2v6AH43I/cQ+cScArTjcJLcswM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJxrdLOISyvf7TnTgGmWmKDLx+2L3xKEAODTg2QKLwjnCDCf8d61t6jXIiftNdM7h
	 uCUiP1Rb/+zl0lM0kq94Dp+9K7V+8XHSQ7YgxrBZ0Oy/hTx5j4fixx50iAZf/zlsPn
	 lFsp4vy6grXVCTeJSKQyoqt9vFKZIx9Htz6Vy1wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHXIkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgHXIkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:40:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D747C2177B;
        Mon, 24 Aug 2020 08:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258399;
        bh=tOaViDPcAlbFFhlCe2v6AH43I/cQ+cScArTjcJLcswM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q06LqRk1TpG7X/n2ZjWFhcyiYgGZ6FHAmV1ALqQTmlDkny1W6ru++TVsVq95ssDzW
         yOyDlvnm+EbtncYL3oHujFpR0DtftVG/edlXJO6aoB1p3+I95Q6QaVfE5y0IoOeP3r
         +HU+HuaMEDX4Na5D4Yg7CexkdeJDEHZeU5s9uQQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 004/124] khugepaged: adjust VM_BUG_ON_MM() in __khugepaged_enter()
Date:   Mon, 24 Aug 2020 10:28:58 +0200
Message-Id: <20200824082409.605505185@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

[ Upstream commit f3f99d63a8156c7a4a6b20aac22b53c5579c7dc1 ]

syzbot crashes on the VM_BUG_ON_MM(khugepaged_test_exit(mm), mm) in
__khugepaged_enter(): yes, when one thread is about to dump core, has set
core_state, and is waiting for others, another might do something calling
__khugepaged_enter(), which now crashes because I lumped the core_state
test (known as "mmget_still_valid") into khugepaged_test_exit().  I still
think it's best to lump them together, so just in this exceptional case,
check mm->mm_users directly instead of khugepaged_test_exit().

Fixes: bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Yang Shi <shy828301@gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: <stable@vger.kernel.org>	[4.8+]
Link: http://lkml.kernel.org/r/alpine.LSU.2.11.2008141503370.18085@eggly.anvils
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9e7cec2840927..cb17091d0a202 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -435,7 +435,7 @@ int __khugepaged_enter(struct mm_struct *mm)
 		return -ENOMEM;
 
 	/* __khugepaged_exit() must not run from under us */
-	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
+	VM_BUG_ON_MM(atomic_read(&mm->mm_users) == 0, mm);
 	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
 		free_mm_slot(mm_slot);
 		return 0;
-- 
2.25.1



