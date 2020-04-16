Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D18EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F531206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olCBXJW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506553AbgDPLo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633920AbgDPLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:41:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+GygNOnPKA0P+z0keb2ILChOZ1myuhqsGF2+amCw6AU=; b=olCBXJW5Cv/S939vcqqqGO0Lon
        77AV+zJRzU/txLp8myHFoaY4Z7hIAgrD7T4YaUAR153QVSE82n/X/Ndw/g+ialRlEeUPjxNzvpkZh
        rYd2HU6BRotUJeh8vuRHT4eo+dXPbbxLmfzoiXJ1kMLkIQm7OF7R8JCwKnidyG88FztZo0F6vIH7z
        6vJKFt3kwRRucglJ/0Nd4663np59XTh3nsh01rCcBdCH0YaNbA33jDXjctd9kjoFWTLGsztRM+AoY
        R1uQPVcG37TlBGhwhBWjc9n7EpzR6OyyrzBds1FsTOFa3v4YIsUQJT1+5xJIz9GXfin9b8jv6wj5w
        vgWstdeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP2th-0004vV-QA; Thu, 16 Apr 2020 11:41:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F2BF30477A;
        Thu, 16 Apr 2020 13:41:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 638052B0DE48C; Thu, 16 Apr 2020 13:41:31 +0200 (CEST)
Date:   Thu, 16 Apr 2020 13:41:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200416114131.GO20730@hirez.programming.kicks-ass.net>
References: <20200416085956.217587-1-qperret@google.com>
 <cf82cb73-b837-2365-9178-d56589c3ad44@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf82cb73-b837-2365-9178-d56589c3ad44@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 01:03:16PM +0200, Dietmar Eggemann wrote:
> On 16.04.20 10:59, Quentin Perret wrote:
> > uclamp_fork() resets the uclamp values to their default when the
> > reset-on-fork flag is set. It also checks whether the task has a RT
> > policy, and sets its uclamp.min to 1024 accordingly. However, during
> > reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> > hence leading to an erroneous uclamp.min setting for the new task if it
> > was forked from RT.
> > 
> > Fix this by removing the unnecessary check on rt_task() in
> > uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> > set.
> > 
> > Fixes: 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks")
> > Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> > Reviewed-by: Patrick Bellasi <patrick.bellasi@matbug.net>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> > Changes in v2:
> >  - Added missing 'Fixes:' tag (Patrick)
> >  - Removed unnecessary local variable (Doug, Patrick)
> > ---
> >  kernel/sched/core.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3a61a3b8eaa9..9a2fbf98fd6f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1232,13 +1232,8 @@ static void uclamp_fork(struct task_struct *p)
> >  		return;
> >  
> >  	for_each_clamp_id(clamp_id) {
> > -		unsigned int clamp_value = uclamp_none(clamp_id);
> > -
> > -		/* By default, RT tasks always get 100% boost */
> > -		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > -			clamp_value = uclamp_none(UCLAMP_MAX);
> > -
> > -		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> > +		uclamp_se_set(&p->uclamp_req[clamp_id],
> > +			      uclamp_none(clamp_id), false);
> >  	}
> >  }
> 
> LGTM.
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks guys!
