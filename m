Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19527C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3E9207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590001886;
	bh=xy+F+Xk6Eh27TpQwycM8KVFcBwkkldw7VDh+CKoRc4U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=m0RFfyo7DFOzfhW0F6p8IEB29DgZC7VFCYRf8QoEE7/bKIwA4lvHjA3Hvlxp3bT15
	 ZlHLCZr9oAanEKQriWSpZ95Y6ez1H9w8gok3tMFUi92EGusYa5MqHqkfPy4v5b4Y3W
	 Z4ciZft3BMjngHpPbDCfrtBqRlTRiWl1Nqvd1gAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgETTL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:11:25 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB1D206B6;
        Wed, 20 May 2020 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590001885;
        bh=xy+F+Xk6Eh27TpQwycM8KVFcBwkkldw7VDh+CKoRc4U=;
        h=Date:From:To:Cc:Subject:From;
        b=KeoSit7FEot91Av1rOcj3Y6AZne6zDmV1+pKSeffKQzno+1EiIAnhhGWSISar8/Pa
         iyW9G2sGEdej30zDTh+qWDjG+s1ZHjb0qpaBvJb5JrGH6zvJFw3U556+wlYe3qWca+
         qTTiWm7UY5NJeeWD2hRKxSRFH0Yxz5Zt5AaXvxys=
Date:   Wed, 20 May 2020 14:16:13 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH perf/core] perf branch: Replace zero-length array with
 flexible-array
Message-ID: <20200520191613.GA26869@embeddedor>
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

This issue was found with the help of Coccinelle and audited _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/perf/util/branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 4d3f02fa223df..17b2ccc61094b 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -46,7 +46,7 @@ struct branch_entry {
 struct branch_stack {
 	u64			nr;
 	u64			hw_idx;
-	struct branch_entry	entries[0];
+	struct branch_entry	entries[];
 };
 
 /*
-- 
2.26.2

