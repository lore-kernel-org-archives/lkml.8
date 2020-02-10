Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B001BC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796E020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DiSiJcnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJD3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:29:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgBJD3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+E02DlxrewhlmGMQoDgXvOR5ZVG9viZsN3fJM9Lh4RI=; b=DiSiJcnTihfUKqE9sr4xfGtshl
        OkasKgdid8m68DnjRQSv3tOz472+GrMMiPIOzUH02PlJe5SFwo+Qra8US7VHfMPIntYmSVky0WRiK
        RL6tj7ZrrypwvzQLKtpE2TODPPnkHp6cG8UenJeKzbPXnI3iU4AjpumBNQ1j+6bmVm0g3p0DJpmXX
        gUjO/8p1HI7MUtOoOwEf/nUjnuEgCmFbmGANVWrTpS7H8FS75E13YTJtZRNgJjoBfXouM9SgfwI8F
        5FHS1kV+9ZxxmJ8dE+piT7XtpDChGFoDObVmu+4O4Hj/4XLC6cCgvhaOlYVuVXXn8LeFxsJ40Xai5
        xR0uyuVA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0zl3-0000L8-7v; Mon, 10 Feb 2020 03:29:13 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RESEND] sched: fix kernel-doc warning in
 attach_entity_load_avg()
Message-ID: <cbe964e4-6879-fd08-41c9-ef1917414af4@infradead.org>
Date:   Sun, 9 Feb 2020 19:29:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in kernel/sched/fair.c, caused by a recent
function parameter removal:

../kernel/sched/fair.c:3526: warning: Excess function parameter 'flags' description in 'attach_entity_load_avg'

Fixes: a4f9a0e51bbf ("sched/fair: Remove redundant call to cpufreq_update_util()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
---
 kernel/sched/fair.c |    1 -
 1 file changed, 1 deletion(-)

--- lnx-56-rc1.orig/kernel/sched/fair.c
+++ lnx-56-rc1/kernel/sched/fair.c
@@ -3516,7 +3516,6 @@ update_cfs_rq_load_avg(u64 now, struct c
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
- * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.


