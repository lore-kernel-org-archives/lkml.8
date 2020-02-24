Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF67C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC7420828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BNsXSLGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBXQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:04:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49982 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbgBXQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:04:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582560296; h=Content-Type: Cc: To: Subject: Message-ID:
 Date: From: In-Reply-To: References: MIME-Version: Sender;
 bh=hONwJDRPPASCJa7NuZbPYpImYBsMqPVL5iKoRqF+ugQ=; b=BNsXSLGwwEh7u7GgkkuBnpAvkLlTzb5yytLtMhMQtBH9Gg0wATDj0NHkhHKVZ9Z63otRltIh
 ioCGvzH5E31eq2E8uMx7CbHFj/QJR86wRM+BtL/whxtGUx6KLJnPB16vVcXeOXmDCNT/xG0M
 rclQ/SlsxOFr/z4IG0ehQN4Fl3E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e53f428.7f27a5696110-smtp-out-n03;
 Mon, 24 Feb 2020 16:04:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F17EC43383; Mon, 24 Feb 2020 16:04:55 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0ED0C447A9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0ED0C447A9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Received: by mail-ed1-f52.google.com with SMTP id g19so12451725eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:04:53 -0800 (PST)
X-Gm-Message-State: APjAAAUqp0YAyD9O04yTxTY9sU5lShzy6o09Ks313Zwmo8Ph1uWXr276
        ywfLUky0GlgK9NemyUKvbR3DMsnWTEr0+IiyEw0=
X-Google-Smtp-Source: APXvYqzPbAbrSOMiSdDnH+Vt7T6YYylICz+sTLYjALdjb/80+cuLv5NEGzQY62chIwqu+PlYeIeruLnWvQyumTNvRQc=
X-Received: by 2002:a05:6402:a49:: with SMTP id bt9mr45817212edb.144.1582560292603;
 Mon, 24 Feb 2020 08:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20200223184001.14248-1-qais.yousef@arm.com> <20200223184001.14248-6-qais.yousef@arm.com>
 <20200224061004.GH28029@codeaurora.org> <20200224121139.cbz2dt5heiouknif@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200224121139.cbz2dt5heiouknif@e107158-lin.cambridge.arm.com>
From:   Pavan Kondeti <pkondeti@codeaurora.org>
Date:   Mon, 24 Feb 2020 21:34:41 +0530
X-Gmail-Original-Message-ID: <CAEU1=PncyV=-vqjkDHSJ4hUhhTfYUgVN-HAe4zXMHtFx1oc5XA@mail.gmail.com>
Message-ID: <CAEU1=PncyV=-vqjkDHSJ4hUhhTfYUgVN-HAe4zXMHtFx1oc5XA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] sched/rt: Better manage pushing unfit tasks on wakeup
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Mon, Feb 24, 2020 at 5:42 PM Qais Yousef <qais.yousef@arm.com> wrote:
[...]
> We could do, temporarily, to get these fixes into 5.6. But I do think
> select_task_rq_rt() doesn't do a good enough job into pushing unfit tasks to
> the right CPUs.
>
> I don't understand the reasons behind your objection. It seems you think that
> select_task_rq_rt() should be enough, but not AFAICS. Can you be a bit more
> detailed please?
>
> FWIW, here's a screenshot of what I see
>
>         https://imgur.com/a/peV27nE
>
> After the first activation, select_task_rq_rt() fails to find the right CPU
> (due to the same move all tasks to the cpumask_fist()) - but when the task
> wakes up on 4, the logic I put causes it to migrate to CPU2, which is the 2nd
> big core. CPU1 and CPU2 are the big cores on Juno.
>
> Now maybe we should fix select_task_rq_rt() to better balance tasks, but not
> sure how easy is that.
>

Thanks for the trace. Now things are clear to me. Two RT tasks woke up
simultaneously and the first task got its previous CPU i.e CPU#1. The next task
goes through find_lowest_rq() and got the same CPU#1. Since this task priority
is not more than the just queued task (already queued on CPU#1), it is sent
to its previous CPU i.e CPU#4 in your case.

From task_woken_rt() path, CPU#4 attempts push_rt_tasks(). CPU#4 is
not overloaded,
but we have rt_task_fits_capacity() check which forces the push. Since the CPU
is not overloaded, your has_unfit_tasks() comes to rescue and push the
task. Since
the task has not scheduled in yet, it is eligible for push. You added checks
to skip resched_curr() in push_rt_tasks() otherwise the push won't happen.

Finally, I understood your patch. Obviously this is not clear to me
before. I am not
sure if this patch is the right approach to solve this race. I will
think a bit more.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
