Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1E9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9520714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfuaRNpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgBLIRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:17:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47096 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:17:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id z26so902564lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/COCMq4kYFQwNo7dlt3pNHSHIao5E30WwbJduAMidN0=;
        b=WfuaRNpb70x5eSlaoUfejW1VyAe6RaZsiXlwuoILOQ0Z8gnhYEjVbMQJGFIZO8SzNB
         L4ciNfM6V50vF4WmFr0ppfMDFy81LwPI7uBTFYpnHK0ldFgLnwY5kLS3ylMhgkefUrTV
         Zb3mGwKx3wbJMtjmJgv1yw/zjkYE0xIJqE+buP+S9BwbKxaB8ihOo2V+KiV+hnlHaIjV
         n//Gr5aozFqilmIttVTXKpkf3nDfJ5rSgYPp1Hwmw+4UONOzQOfD4i6u8BwovQefpI+6
         e9HPveCWnrLgnRr0v7hAG+GSFYlneTh3Jajrm6fdA/RlfU2XsG0hojvv2IJhx6lFEDgF
         EcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/COCMq4kYFQwNo7dlt3pNHSHIao5E30WwbJduAMidN0=;
        b=VzNMnVnee8Vx7JCHRtkSk5xQYComUOyey65F8G6/DDHebW9wFZth2pYzGx2XLhlhLP
         3o2nI4zGbp0K0hCA7gDfJVW/DH73o1QtCDhNbv0Z6Wof+2Y/9vZuFBefA7heN408JnMr
         6SphwD/MACYqO8uogLBwBixyXH65V35Uz5VehJ9NxZrsz9UEvdLSGKQ8fvEswGYUZqXb
         XLxHY7YZ7eB4FdFP7xsXfY3gP3BjT0gqim25or1KNh2fvBSN15V6YADM8eqHtRYm/uPL
         2NuhqxNAGGxr56/LOkn3OVFEg4FKfboq280AHebhASGp1iqRiz8UuQQun6ERP/JW6+JW
         Pnpg==
X-Gm-Message-State: APjAAAWTGJKO5rMCnfQyZGcYC7wgoGp5ZfUOgSy0wRTdUSrC7PMO2sL2
        u5L+uTkKsm2oFD6/v0f/C8XWW2LSy78QWVK5y7gx3A==
X-Google-Smtp-Source: APXvYqzbG/yWM/z2IpqImJFwDg1cFh1yyL/6hnywv6K8VG3vc2DbOhecH/DbLkvL9bSTymb9pLMctq01XV4ykLbdjUU=
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr5973459lfn.95.1581495425465;
 Wed, 12 Feb 2020 00:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org> <20200211210439.GS3420@suse.de>
In-Reply-To: <20200211210439.GS3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Feb 2020 09:16:53 +0100
Message-ID: <CAKfTPtA4h4FQoAEDjVeT4nWJCs5Lk5=9w4VnKq2wgpgJui7Y8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] remove runnable_load_avg and improve group_classify
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 at 22:04, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Feb 11, 2020 at 06:46:47PM +0100, Vincent Guittot wrote:
> > NUMA load balancing is the last remaining piece of code that uses the
> > runnable_load_avg of PELT to balance tasks between nodes. The normal
> > load_balance has replaced it by a better description of the current state
> > of the group of cpus.  The same policy can be applied to the numa
> > balancing.
> >
> > Once unused, runnable_load_avg can be replaced by a simpler runnable_avg
> > signal that tracks the waiting time of tasks on rq. Currently, the state
> > of a group of CPUs is defined thanks to the number of running task and the
> > level of utilization of rq. But the utilization can be temporarly low
> > after the migration of a task whereas the rq is still overloaded with
> > tasks. In such case where tasks were competing for the rq, the
> > runnable_avg will stay high after the migration.
> >
> > Some hackbench results:
> >
> > - small arm64 dual quad cores system
> > hackbench -l (2560/#grp) -g #grp
> >
> > grp    tip/sched/core         +patchset              improvement
> > 1       1,327(+/-10,06 %)     1,247(+/-5,45 %)       5,97 %
> > 4       1,250(+/- 2,55 %)     1,207(+/-2,12 %)       3,42 %
> > 8       1,189(+/- 1,47 %)     1,179(+/-1,93 %)       0,90 %
> > 16      1,221(+/- 3,25 %)     1,219(+/-2,44 %)       0,16 %
> >
> > - large arm64 2 nodes / 224 cores system
> > hackbench -l (256000/#grp) -g #grp
> >
> > grp    tip/sched/core         +patchset              improvement
> > 1      14,197(+/- 2,73 %)     13,917(+/- 2,19 %)     1,98 %
> > 4       6,817(+/- 1,27 %)      6,523(+/-11,96 %)     4,31 %
> > 16      2,930(+/- 1,07 %)      2,911(+/- 1,08 %)     0,66 %
> > 32      2,735(+/- 1,71 %)      2,725(+/- 1,53 %)     0,37 %
> > 64      2,702(+/- 0,32 %)      2,717(+/- 1,07 %)    -0,53 %
> > 128     3,533(+/-14,66 %)     3,123(+/-12,47 %)     11,59 %
> > 256     3,918(+/-19,93 %)     3,390(+/- 5,93 %)     13,47 %
> >
>
> I haven't reviewed this yet because by co-incidence I'm finalising a
> series that tries to reconcile the load balancer with the NUMA balancer

That's interesting !
This series has been pending for a while and I have finally been able
to send it for review.*

> and it has been very tricky to get right.  One aspect though is that

I have been quite conservative in the policy as my main goal was not
to change all numa policy but mainly to remove the last user of
runnable_load_avg and i don't expect much behavior changes

> hackbench is generally not long-running enough to detect any performance
> regressions in NUMA balancing. At least I've never observed it to be a
> good evaluation for NUMA balancing.
>
> > Without the patchset, there is a significant number of time that a CPU has
> > spare capacity with more than 1 running task. Although this is a valid
> > case, this is not a state that should often happen when 160 tasks are
> > competing on 8 cores like for this test. The patchset fixes the situation
> > by taking into account the runnable_avg, which stays high after the
> > migration of a task on another CPU.
> >
>
> FWIW, during the rewrite, I ended up moving away from runnable_load to
> get the load balancer and NUMA balancer to use the same metrics.
>
> --
> Mel Gorman
> SUSE Labs
