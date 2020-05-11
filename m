Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F478C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABCD2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="L5aiqI7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgEKBz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:55:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16772 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728681AbgEKBz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:55:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589162157; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=3sCZnKSzC5YcZB4TkEIrPmQc3i0c9O9DItwcFQpgAnI=; b=L5aiqI7mQKCgLyMLzWguyWa8NgAhxevzUaORexT2b502WjSy1v91DwkvkTMI5oBV1n7+vrRg
 G1hPGCqpAwyoYIgTLbLkrr1eMwtn9LxOh3LYvkGxmsUh+7JqHysmCpItsN1rCRvxP3qnmBAA
 c+/eLSdeu7nI4MUUuE8uxR+wrns=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb8b0ac.7fd1c913e378-smtp-out-n05;
 Mon, 11 May 2020 01:55:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11E51C433BA; Mon, 11 May 2020 01:55:56 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46093C433F2;
        Mon, 11 May 2020 01:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46093C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 11 May 2020 07:25:47 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/debug: Fix requested task uclamp values shown in
 procfs
Message-ID: <20200511015547.GP19464@codeaurora.org>
References: <1589115401-26391-1-git-send-email-pkondeti@codeaurora.org>
 <jhjblmvu5nn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjblmvu5nn.mognet@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 05:16:28PM +0100, Valentin Schneider wrote:
> 
> On 10/05/20 13:56, Pavankumar Kondeti wrote:
> > The intention of commit 96e74ebf8d59 ("sched/debug: Add task uclamp
> > values to SCHED_DEBUG procfs") was to print requested and effective
> > task uclamp values. The requested values printed are read from p->uclamp,
> > which holds the last effective values. Fix this by printing the values
> > from p->uclamp_req.
> >
> > Fixes: 96e74ebf8d59 ("sched/debug: Add task uclamp values to SCHED_DEBUG procfs")
> > Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> 
> Argh, Qais pointed this out to me ~ a week ago, and I left this in my todo
> stack. I goofed up, sorry!
> 
> As Pavan points out, p->uclamp[foo] is just a cache of uclamp_eff_value(p,
> foo) from the last time p was enqueued and runnable - what we are
> interested in is indeed comparing this with the *requested* value.
> 
> I wanted to send an example along with a patch, I guess that's the kick I
> needed!
> 
> 
> My setup is a busy loop, its per-task clamps are set to (256, 768) via
> sched_setattr(), and it's shoved in a cpu cgroup with uclamp settings of
> (50%, 50%)
> 
> On the current master (e99332e7b4cd ("gcc-10: mark more functions __init to
> avoid section mismatch warnings")), this gives me:
> 
>   $ uclamp-get $PID # via sched_getattr()
>   uclamp.min=256 uclamp.max=768
> 
>   $ cat /proc/$PID/sched | grep uclamp
>   uclamp.min                                   :                  256
>   uclamp.max                                   :                  512
>   effective uclamp.min                         :                  256
>   effective uclamp.max                         :                  512
> 
> With Pavan's patch, I get:
> 
>   $ uclamp-get $PID # via sched_getattr()
>   uclamp.min=256 uclamp.max=768
> 
>   $ cat /proc/$PID/sched | grep uclamp
>   uclamp.min                                   :                  256
>   uclamp.max                                   :                  768
>   effective uclamp.min                         :                  256
>   effective uclamp.max                         :                  512
> 
> 
> Minor print nit below, otherwise:
> Tested-and-reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> Peter/Ingo, any chance this can go to sched/urgent? I know it's a debug
> interface, but I'd rather have it land in a shape that makes sense. Again,
> apologies for the goof.
> 
> > ---
> >  kernel/sched/debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index a562df5..239970b 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
> >       P(se.avg.util_est.enqueued);
> >  #endif
> >  #ifdef CONFIG_UCLAMP_TASK
> > -	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
> > -	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
> > +	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
> > +	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
> 
> While we're at it, I'd prepend this with "requested".
> 
> >       __PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
> >       __PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
> >  #endif

Thanks Valentin for taking a look. I have added "requested" prefix and sent
the patch.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
