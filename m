Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE12495F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877611;
	bh=kWpXTKUl5SLDwdL/OuCFJc8i4rRGOi1NqEX5H1qbazs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=i3JU7zy8RKS3gwvYVmb7tbgHoUJnQLrArJWOmy20QXXcRH13wAZslQXpbHefhQAfl
	 g4hS41jCKdA+NTbzdVGH8ROfz6gTqSjTuALAItKevYsfXqGEoF7Z1qAuDPRdzWPr2M
	 Gkpmfjz3D/w+ZgE3VmtI2FyL3boP7rLFdnAPSukw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgEGSxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgEGSx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:53:29 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679342495D;
        Thu,  7 May 2020 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877609;
        bh=kWpXTKUl5SLDwdL/OuCFJc8i4rRGOi1NqEX5H1qbazs=;
        h=Date:From:To:Cc:Subject:From;
        b=Xk4W14wM9ZxNeT3smEAGC+5SjWJOn6uUrsSZd77MFFQ0JkGXxQboJehLexrDxgU0X
         gF7QVPpjs8O7MYeLs+0nPdA6bUaYAJAd3MAP5MBZOjBoT/oktNB26hpms+EmtHiUMd
         C+fjEmsN04syZ/iEEdRVNXOYHARnQJS7I0taq/Cs=
Date:   Thu, 7 May 2020 13:57:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm: Replace zero-length array with flexible-array
Message-ID: <20200507185755.GA15014@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/powerpc/mm/hugetlbpage.c                   |    2 +-
 tools/testing/selftests/powerpc/pmu/ebb/trace.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 33b3461d91e8..d06efb946c7d 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -253,7 +253,7 @@ int __init alloc_bootmem_huge_page(struct hstate *h)
 struct hugepd_freelist {
 	struct rcu_head	rcu;
 	unsigned int index;
-	void *ptes[0];
+	void *ptes[];
 };
 
 static DEFINE_PER_CPU(struct hugepd_freelist *, hugepd_freelist_cur);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/trace.h b/tools/testing/selftests/powerpc/pmu/ebb/trace.h
index 7c0fb5d2bdb1..da2a3be5441f 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/trace.h
+++ b/tools/testing/selftests/powerpc/pmu/ebb/trace.h
@@ -18,7 +18,7 @@ struct trace_entry
 {
 	u8 type;
 	u8 length;
-	u8 data[0];
+	u8 data[];
 };
 
 struct trace_buffer
@@ -26,7 +26,7 @@ struct trace_buffer
 	u64  size;
 	bool overflow;
 	void *tail;
-	u8   data[0];
+	u8   data[];
 };
 
 struct trace_buffer *trace_buffer_allocate(u64 size);
-- 
2.26.2


