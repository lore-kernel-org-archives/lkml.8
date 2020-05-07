Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C075C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E573221F7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879060;
	bh=2vhh4CWf1qAP4IS40XgtchAprraO0Zj46YURZXgZFxA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cktsLF0yTPKxi9aU6cOEcH/GX2XB4+wfOSh3sVAfCJysTJiGw3E8qGhAcR4oOZ7nK
	 33TJFowpv8ZKmPmHuD+cn3cel/z/fy7745pC5iyS7clyXGZReLeWTuBCe8TOgzBFaF
	 TQC/WIUoiY49wCzJvUmR7U1v8BQ5jVu51tW+UQHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgEGTRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:17:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA96F21835;
        Thu,  7 May 2020 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879058;
        bh=2vhh4CWf1qAP4IS40XgtchAprraO0Zj46YURZXgZFxA=;
        h=Date:From:To:Cc:Subject:From;
        b=qtcvF+cDY/ipaTvvUakxHaYOOOaLgEwR9HV2QmMIlhIR8wkeEVlREwC4/m9YLnpft
         XUg3iDrYlcwaHkUM01QM7nxWmLwBhWKL3XSCKnQ7vLzN+RM4UHK7fkrd3MLhQu59Q5
         6/yuMeKWhbTEuuN8BZs5eR0etQ7bh6DWI1umxTsY=
Date:   Thu, 7 May 2020 14:22:04 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slab: Replace zero-length array with flexible-array
Message-ID: <20200507192204.GA16270@embeddedor>
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
 mm/slab.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 207c83ef6e06..815e4e9a94cd 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -34,7 +34,7 @@ struct kmem_cache {
 
 struct memcg_cache_array {
 	struct rcu_head rcu;
-	struct kmem_cache *entries[0];
+	struct kmem_cache *entries[];
 };
 
 /*

