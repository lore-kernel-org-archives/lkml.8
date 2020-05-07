Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C26C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49313208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879037;
	bh=xbpMeseLUa1F5bWVlyVbWAi8ZUs0iZRWzX8jkygXfNc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1VaFZF5z1ExOIJlYmNz35+J0rn0mJL5El8vjU0O3iVW/+A3L22DaoJV0EfRXBW7xN
	 FISuN/n0gX5pXiFG5htx5swJtri70Jd0V0lHLRvPF0jvKzlwFbp6QHrO8pbKcG2BXM
	 I++35fotx/MkxiHxsls/iYzuH9eyIRatvuRa5iWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgEGTRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgEGTRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:17:16 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9650208D6;
        Thu,  7 May 2020 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879035;
        bh=xbpMeseLUa1F5bWVlyVbWAi8ZUs0iZRWzX8jkygXfNc=;
        h=Date:From:To:Cc:Subject:From;
        b=mvRSHASPfFqkfHkORLgo1m+YyYGb1LcF/gEQyoL8JEnEGt9A8YcnjI1F/AnSzEcUE
         efHsTLZRvbaPWRuvXMWDt1j9xQiBoawncw9dBGpur8CV+APrgv97jta/YNYqUpfPB6
         va5oMiyAqUQ8k11b/n/n9reMGpAg4VUqCUcsOJpI=
Date:   Thu, 7 May 2020 14:21:41 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Replace zero-length array with flexible-array
Message-ID: <20200507192141.GA16183@embeddedor>
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
 kernel/sched/fair.c  |    2 +-
 kernel/sched/sched.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..b34549708ef4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1094,7 +1094,7 @@ struct numa_group {
 	 * more by CPU use than by memory faults.
 	 */
 	unsigned long *faults_cpu;
-	unsigned long faults[0];
+	unsigned long faults[];
 };
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..f504f3ac3967 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1461,7 +1461,7 @@ struct sched_group {
 	 * by attaching extra space to the end of the structure,
 	 * depending on how many CPUs the kernel has booted up with)
 	 */
-	unsigned long		cpumask[0];
+	unsigned long		cpumask[];
 };
 
 static inline struct cpumask *sched_group_span(struct sched_group *sg)

