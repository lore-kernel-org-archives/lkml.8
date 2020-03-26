Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A5C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F34E2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysHzBPwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgCZQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:03:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36772 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCZQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:03:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id s1so5302214lfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsryagRvVoFbMcFk5ndWvfGYfunGGRbmaGXhKdSiUek=;
        b=ysHzBPwOVcBR9JOSVKRcaDNPdGCt48vT1oXTkE1P488x04V0hIlMkHTQ9qFkuiIPDM
         lrDk+rsC+4cLeTMta7k5qsFJ9tncl2Y8xsP2sYnzW7ho8VIxanUrOOMQpaKHI/5PCASR
         md1D5YIB7GCjjADYz/KRetihwuEq3c65ZpgotYCzWyKSfCe2neCEUKe21oOOpjH46SwG
         XOixwF6KUlRbeOYhTPlmfJnaT9TjgSRhK0wy+/TH2nUYtE/UkUX+ISxm8xXvqPltYG2i
         62RsRFZhEDzBwwbI2NNxRmfj0kwnNRfHZmcFjNfFovXVRwMLZpW51clMVCxmIPTQptyN
         2Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsryagRvVoFbMcFk5ndWvfGYfunGGRbmaGXhKdSiUek=;
        b=d8NNbU7CflaF2N1DKrnUBmIbeHYft7u5kAJ2iZ8avwDsADgoKzmNc/CMCqfny06xiV
         oVroll5Dx57HD0+IeXw6IOa94YjQxFRUM426ZVTgrl230avaUTowKEYmRAv80hSlWJIX
         S5fZN1PoNHd1h3lTSUHb70h/R1zXr7Udcp4c9h+4FTl63i9im/Xs3PDQpwwC22wPG4mS
         IiUeJNGfqNPUMbLKmDHMyzuYZqrH8Xdrw5P4Xft+y72dfEK6fUiQ/6ZvqXBivqdTpzt0
         IvZO1E18jxniiYu4PuFIbyRU1kJqEVepC2Gpb9nCpqw9+7D40Gsw2bFgPIKKl4dLaaEc
         o8PA==
X-Gm-Message-State: ANhLgQ0XfrrmTgdNYXmT85AkUAS/34svUEKPGKUYDPnWUhMKyfSoCGTS
        gO4JiQMYGQDhlqj9og771Cmd1jadBGcuzckK/WtPEA==
X-Google-Smtp-Source: ADFU+vsPCjuvq+fZsWLA4/OXHd/Qhuz2rJukqcHy8gyX/twtEzJaEJhADKOK74SHMGwQc+BDJykgiPfIqS7GYrH3L50=
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr6293876lfq.149.1585238602095;
 Thu, 26 Mar 2020 09:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Mar 2020 17:03:10 +0100
Message-ID: <CAKfTPtBWQDkmkuxPTEC8QY1PXicZ51w7tjDPRm2rYM+8QN5rLQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix negative imbalance in imbalance calculation
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 06:53, Aubrey Li <aubrey.li@intel.com> wrote:
>
> A negative imbalance value was observed after imbalance calculation,
> this happens when the local sched group type is group_fully_busy,
> and the average load of local group is greater than the selected
> busiest group. Fix this problem by comparing the average load of the
> local and busiest group before imbalance calculation formula.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Phil Auld <pauld@redhat.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c1217bf..4a2ba3f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8761,6 +8761,14 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>
>                 sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
>                                 sds->total_capacity;
> +               /*
> +                * If the local group is more loaded than the selected
> +                * busiest group don't try to pull any tasks.
> +                */
> +               if (local->avg_load >= busiest->avg_load) {
> +                       env->imbalance = 0;
> +                       return;
> +               }
>         }
>
>         /*
> --
> 2.7.4
>
