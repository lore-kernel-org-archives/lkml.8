Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A72EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70EAF2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlpbg4mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGXJM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:12:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC0C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LA2le4RbbpTcfXb2KkOId+3V/JxOvXwhrnbrA+H+QzQ=; b=qlpbg4mtS95i3Bn9W84++t7PF9
        3H5X8Pc5LC7q7UpGpslr2u05AmeXWew8lUsPFXVOz9pnTJwtlhtHJruFc+hkvRoIkUtV0q/XAG+Ez
        a/u3BZkfF9W2MVN+cCN3gz14RGUv7IhZ7474rgOJNG+/4ughpwSlfBKAYR2QOV/Rv9Z2E7hGQg0kw
        JKmQiJUtLoEXdO1js/hqqOrxRMV3Z+TCpIMQ1aF3kZn4NOaXGIJm4fO7BojDsyZ5Sv6gb8PtcnZ9E
        Abdxyt4X95aekJzTNQQQxHVnhsqgG0s0ZsOZMAmWn5X+d0p/9GVyem2rufcMIJvKlEYu103urexO7
        Gm0Fkg8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jytl0-0007PZ-0c; Fri, 24 Jul 2020 09:12:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76BAF301A7A;
        Fri, 24 Jul 2020 11:12:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D136236FC58B; Fri, 24 Jul 2020 11:12:44 +0200 (CEST)
Date:   Fri, 24 Jul 2020 11:12:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] sched/uclamp: Fix a deadlock when enabling uclamp
 static key
Message-ID: <20200724091244.GX10769@hirez.programming.kicks-ass.net>
References: <20200716110347.19553-1-qais.yousef@arm.com>
 <20200716110347.19553-4-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716110347.19553-4-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:03:47PM +0100, Qais Yousef wrote:

I've trimmed the Changelog to read like:

---
Subject: sched/uclamp: Fix a deadlock when enabling uclamp static key
From: Qais Yousef <qais.yousef@arm.com>
Date: Thu, 16 Jul 2020 12:03:47 +0100

From: Qais Yousef <qais.yousef@arm.com>

The following splat was caught when setting uclamp value of a task:

  BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49

   cpus_read_lock+0x68/0x130
   static_key_enable+0x1c/0x38
   __sched_setscheduler+0x900/0xad8

Fix by ensuring we enable the key outside of the critical section in
__sched_setscheduler()

Fixes: 46609ce22703 ("sched/uclamp: Protect uclamp fast path code with static key")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200716110347.19553-4-qais.yousef@arm.com
---

And placed this patch first in the series

That said; don't we have a slight problem with enabling the key late
like this? It means the uclamp will not actually take effect immediately
and we'll have to wait for the next context switch ... whenever that
might be.

Should we not have enabled the key early, instead of late?

something like so perhaps?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2a244af9a53..c6499b2696f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1282,8 +1282,6 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
-	static_branch_enable(&sched_uclamp_used);
-
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
@@ -5074,6 +5072,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		retval = uclamp_validate(p, attr);
 		if (retval)
 			return retval;
+		static_branch_enable(&sched_uclamp_used);
 	}
 
 	if (pi)
