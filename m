Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A22C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2775A2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWAQBlI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGZOaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:30:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD2C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:30:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so1746945pju.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vY769z+hU0QNq3umNJsU8fhPq3Sqpqlbk02TbhcKHjI=;
        b=cWAQBlI/3sejcpihgKQeEUtBW0SfLHOhHjN+SYmjI98TBcmVR4kfyR3e3CaD/u4JBr
         rsc2Up5C/9eSFEdcav6J0vroMH+V4dMLCaVL2uJDaDWAshsKy8LBZuSWHXIkBGCtQLrf
         j3gxNrOIXGUwgON0438ejF1ELONgPcHpa++5CMddLF629DfMiwISY9FFl6SjyT3Mf/KY
         gvsj/n5c3Sisj67nDFz5oX66Q+2FePl1QN0ggoUQ7oUd9DjI8PgpbA8juJnVy9ub9TK2
         L3WQf30cg7zMu/xDnO2gjo5cjNAIMjR6d6hInMiF2KvPBBPc3nW0cfdKSALFuR0lBFn+
         TvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vY769z+hU0QNq3umNJsU8fhPq3Sqpqlbk02TbhcKHjI=;
        b=lA5dHfCd3JRrsNE2TIWoCBNziegPTxOY6u5c8gLtQtGUrO7sao1NXHe1rW7poo0Vcj
         3QaCGcrv+i3v0vakk2YADJxNO2dIE5Uk9OxcRokIKEc7tc36FveGfvIzBKHkp0ldb7zv
         Cm5UAL7NyCNdF+TfuPuyQhBHUHS5k2BCcyJ+z8foCGkCUNXNnfR+1ZVUIOKPbNREPPVd
         DCtfw53x2VaZNysGl+yd9pJ6LX3P/tNql/uRAgCsR+xCG/rGCdyJxFDnfo0cVOizRsUM
         3cHA0Stp3HfLUwAHZSfQnL/NWpVCd2Y1y5q2uBRlw3F2qgNYou8UGsOZoHsVzF2XwIcS
         Ei+g==
X-Gm-Message-State: AOAM531g/LclMKKIVsGNh12iZVOEcFD59zRzMYK9mEuhITY6OaAvzSjK
        e+C8j/79I1YkaeFmKrpwi6M=
X-Google-Smtp-Source: ABdhPJyNUYiRjXp71swjfyhQNddaolDBWjehpwsPjT/w3ym9VtIcIDmriDLAOHWboXZFNkLu6xs+rw==
X-Received: by 2002:a17:90b:247:: with SMTP id fz7mr14153120pjb.17.1595773817986;
        Sun, 26 Jul 2020 07:30:17 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id e124sm4855513pfe.176.2020.07.26.07.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 07:30:17 -0700 (PDT)
Date:   Sun, 26 Jul 2020 22:30:13 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: dome some cleanup for push_dl_task()
Message-ID: <20200726143013.GA15138@iZj6chx1xj0e0buvshuecpZ>
References: <20200706160442.GA19741@iZj6chx1xj0e0buvshuecpZ>
 <20200724071426.GD14912@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724071426.GD14912@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:14:26AM +0200, Juri Lelli wrote:
> Hi,
> 
> On 07/07/20 00:04, Peng Liu wrote:
> > 'commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq when pushing a task")'
> > introduced the update_rq_clock() to fix the "used-before-update" bug.
> > 
> > 'commit f4904815f97a ("sched/deadline: Fix double accounting of rq/running bw in push & pull")'
> > took away the bug source(add_running_bw()).
> > 
> > We no longer need to update rq_clock in advance, let activate_task()
> > worry about that.
> > 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > ---
> >  kernel/sched/deadline.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 504d2f51b0d6..c3fa11f84d93 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2104,13 +2104,7 @@ static int push_dl_task(struct rq *rq)
> >  
> >  	deactivate_task(rq, next_task, 0);
> >  	set_task_cpu(next_task, later_rq->cpu);
> > -
> > -	/*
> > -	 * Update the later_rq clock here, because the clock is used
> > -	 * by the cpufreq_update_util() inside __add_running_bw().
> > -	 */
> > -	update_rq_clock(later_rq);
> > -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> > +	activate_task(later_rq, next_task, 0);
> >  	ret = 1;
> 
> The change looks good to me, since now add_running_bw() is called later
> by enqueue_task_dl(), but rq_clock has already been updated by core's
> enqueue_task().
> 

Thanks for your time.

> Daniel, Dietmar, a second pair of eyes (since you authored the commits
> above)?
> 
> I'd chage subject to something like "sched/deadline: Stop updating
> rq_clock before pushing a task".
> 
> Thanks,
> 
> Juri
> 
