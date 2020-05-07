Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EBB215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877619;
	bh=a3q7EVtRZYdws6ttRdc7CqZlAg4XEZKPq6gzkh3v70E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Kc4iPx/lyXOnBsCnXuXgzGc9HvCwoYBIw5IG0QPRp9Tix8yBZsiV18nceyI4Iw2iU
	 dmf5PHMAUXC+ExVGV9LQH6xDnpkW7l+/6gBAczXYgdoBB++KNAy/bR89QNPylOpbK3
	 +4Kk0ipF/Hyg29+CgB4v5dwFK/cDEHrswA4BQdXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgEGSxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgEGSxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:53:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4040920870;
        Thu,  7 May 2020 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877617;
        bh=a3q7EVtRZYdws6ttRdc7CqZlAg4XEZKPq6gzkh3v70E=;
        h=Date:From:To:Cc:Subject:From;
        b=pZFh6Bvivm/9yt4HEz1VmtQOTA0kAk4gl8f++6RwXmbw3ebMigsp5bxH3Ktj2+m+S
         Mvf9iMdh7xyfZHQETabnvLUgG2S1XKmjxuJ6XGf/tzEMTsghq7ggwvttufRps1M9G5
         Qqplf8sBda1op/dTYkK57zl8YNq7/bDs6gTIGxxY=
Date:   Thu, 7 May 2020 13:58:04 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/lockdep: Replace zero-length array with
 flexible-array
Message-ID: <20200507185804.GA15036@embeddedor>
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
 kernel/locking/lockdep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ac10db66cc63..cfdff122905b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -489,7 +489,7 @@ struct lock_trace {
 	struct hlist_node	hash_entry;
 	u32			hash;
 	u32			nr_entries;
-	unsigned long		entries[0] __aligned(sizeof(unsigned long));
+	unsigned long		entries[] __aligned(sizeof(unsigned long));
 };
 #define LOCK_TRACE_SIZE_IN_LONGS				\
 	(sizeof(struct lock_trace) / sizeof(unsigned long))

