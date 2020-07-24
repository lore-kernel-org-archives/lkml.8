Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4A4C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8002074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N7W1YeX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXKlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgGXKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:41:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A3C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FldjSuaYgsda6J4qQh4t1AAP693GlnRUaBrzzoUB0Ss=; b=N7W1YeX7gw/k9lv0xeD9WdryTk
        ETaMxtK88rkYpPoCLB23XfBwovS0UBElddMuj/FOepst9fii/Ea+u7Jo/AF2GZ0viF35KkHJOXZZ3
        GFp6rCZSbq1n7n4FtYC6JD0KGhVqquYFTPM3cA8uhoFOYJHZIMcpxTir150UdRhmKDRVQ4U8KlzyF
        ZgNfRv4bnOgLu6/QrRkE6cTabPskx/x64PP6tT1t7o/H3WAYR+u9pvg8FopFB2YEIjOP+VUZhsirQ
        JsHZlwP73q/awaz8S2Osijh0OeD9nG/gOuRmqkqll/0qSkR1z21S91We+30llBEpl+6iIsYPeY8qz
        U4FE2DVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyv8m-0007tR-S2; Fri, 24 Jul 2020 10:41:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 059973003E5;
        Fri, 24 Jul 2020 12:41:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E58832B7C0261; Fri, 24 Jul 2020 12:41:20 +0200 (CEST)
Date:   Fri, 24 Jul 2020 12:41:20 +0200
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
Message-ID: <20200724104120.GY10769@hirez.programming.kicks-ass.net>
References: <20200716110347.19553-1-qais.yousef@arm.com>
 <20200716110347.19553-4-qais.yousef@arm.com>
 <20200724091244.GX10769@hirez.programming.kicks-ass.net>
 <20200724094650.hgya5j7i7lbhrocy@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724094650.hgya5j7i7lbhrocy@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:46:50AM +0100, Qais Yousef wrote:
> On 07/24/20 11:12, Peter Zijlstra wrote:
> > On Thu, Jul 16, 2020 at 12:03:47PM +0100, Qais Yousef wrote:
> > 
> > I've trimmed the Changelog to read like:
> 
> +1
> 
> Should we mention the ordering issue too? Or maybe I misinterpreted the
> 'Possible unsafe locking scenario' part?

The lock inversion was, imo, secondary. It only existed because of the
impossible lock ordering -- taking a blocking lock inside an atomic
lock. Fixing the first, avoids the second etc.. So I left it out.

> This should work, but you'll need to sprinkle ifdef around the key. Or move it
> to uclamp_validate()

Indeed, the patch now reads like:

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
 kernel/sched/core.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1252,6 +1252,15 @@ static int uclamp_validate(struct task_s
 	if (upper_bound > SCHED_CAPACITY_SCALE)
 		return -EINVAL;
 
+	/*
+	 * We have valid uclamp attributes; make sure uclamp is enabled.
+	 *
+	 * We need to do that here, because enabling static branches is a
+	 * blocking operation which obviously cannot be done while holding
+	 * scheduler locks.
+	 */
+	static_branch_enable(&sched_uclamp_used);
+
 	return 0;
 }
 
@@ -1282,8 +1291,6 @@ static void __setscheduler_uclamp(struct
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
-	static_branch_enable(&sched_uclamp_used);
-
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
