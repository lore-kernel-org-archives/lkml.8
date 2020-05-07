Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C9C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A31924954
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877718;
	bh=dd1tg8D5OHCVId8oTy4YDKOQkz34ytpBDxTe3n03A5w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bHICeASqfcSWCZAZcCQ2g9eVoDOwIhaSWX815ZY4Bx/XpYFbqu33MgwuY4OtaKjvM
	 hLxUzZVlsGd16yD4uAASWFkU2Sye9Pk+vWSpROKpon1ePY24DW3DbNyRk7IBkm57C1
	 wY2R5A20yjAiZCIv8BUjRpNojVBIep4JTuoao4/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgEGSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgEGSzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:55:16 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21677221F7;
        Thu,  7 May 2020 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877715;
        bh=dd1tg8D5OHCVId8oTy4YDKOQkz34ytpBDxTe3n03A5w=;
        h=Date:From:To:Cc:Subject:From;
        b=E/S6rwWxvQ/dwNe8ctjaZopkyWPs7Lf5pBQRuFtUtqYB8CcatdbEFdzcrP9rV9Xik
         LCbqmFUErBbx9X8mNniW1gobQ5gNTep8MybRDfJiG2yiDPGkvIssMq0Djj2MjRzEMq
         m1IiqkQwIWXMZO7V29rv3X12QFFXwQQBLLgGJLpU=
Date:   Thu, 7 May 2020 13:59:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Replace zero-length array with flexible-array
Message-ID: <20200507185942.GA15193@embeddedor>
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
 include/linux/mm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..9831bb55caf3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1718,7 +1718,7 @@ struct frame_vector {
 	unsigned int nr_frames;	/* Number of frames stored in ptrs array */
 	bool got_ref;		/* Did we pin pages by getting page ref? */
 	bool is_pfns;		/* Does array contain pages or pfns? */
-	void *ptrs[0];		/* Array of pinned pfns / pages. Use
+	void *ptrs[];		/* Array of pinned pfns / pages. Use
 				 * pfns_vector_pages() or pfns_vector_pfns()
 				 * for access */
 };

