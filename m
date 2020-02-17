Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B18C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DD92070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmgon99T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgBQNt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:49:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35332 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:49:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so18932666ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPeCiuS7ZbSixVVMpcUOXJcL6b0Z3O8EuHVbhuAi9x8=;
        b=rmgon99TU84behd3dIxMn9nFFLqqVOIRLelCjfxfeKhaniI4cKcQC+fmrmPPfHy70v
         fzNdoIPSHrb1gNBTA/d1X46JYMG5NCx9akEigo6AJURvZQwyftF94j7q8/rQA6j0TO1T
         zLrwz3SVq9CbbubvAvOWaWswd1RKMQRcWrG63hOWuhpoGx/iN0nWzb0NzSf0m691kEcg
         ztyTGxFEK1b6gVyyhb2mY7VoKWpie2/ioEklqMfEQLnNg2sGg0q2jhXaTG2ulQbijR16
         lt96yxXrjHORCPGZX8brmzptoil2xqFGq9JnnAs8QmXHxvC7AWBswgYEOwOrMHCoPlZ3
         6l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPeCiuS7ZbSixVVMpcUOXJcL6b0Z3O8EuHVbhuAi9x8=;
        b=r2wSByGshXDKDHSdgmrtMniVRTFz+UnOhNMNn8Svemu41q5SvHwTJ0O2fgNspRE5AI
         9vTj/ame8VRw2ncda9A/+7G91IB16Ve825xvGg+nF3bAzGKbWYMi2+INq40M2lTfOr1A
         2NDDj0ENXtGehTG2scE1PCWjbqoSlldgTb05t+tMKfR2Y1mz0dYO4jfff8gmA6xwB9rj
         F2ZKjC3g6/rmgZY2QryWcomQQCy03VK2eXT7vqnAFIOcYhQcOueX/NyHlunDMK4z2KQE
         zaEBtcrFVed7WdKYH8NEPoaSYExdYk66bKF7dpEaArwfOgloJngwhdW1p1XJ/B/Zr4/r
         YNgA==
X-Gm-Message-State: APjAAAV/50kohyV67O2zKhJJ0V/e8BYfpWoQN2kxLMws/TWy5TsldBdq
        ta2ejIvCMYqpbQtZ9pZNzKNDUOp13b9f46jAWdGc3w==
X-Google-Smtp-Source: APXvYqy3NeiDsZo0vf6kcWdGCkWJSDEQA8cHXcSYVuQsH4XZOhkoN7hvrRUGieGg61evCmPpec62DLOWo0/Kw0hVhww=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr9478240ljg.154.1581947364621;
 Mon, 17 Feb 2020 05:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20200217104402.11643-1-mgorman@techsingularity.net>
In-Reply-To: <20200217104402.11643-1-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 17 Feb 2020 14:49:11 +0100
Message-ID: <CAKfTPtBfV1QGi2utnmnR21MapKw1g2mTFA_aRxOxXvpWTRX+wA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v3
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 at 11:44, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Changelog since V2:
> o Rebase on top of Vincent's series again
> o Fix a missed rcu_read_unlock
> o Reduce overhead of tracepoint
>
> Changelog since V1:
> o Rebase on top of Vincent's series and rework
>
> Note: The baseline for this series is tip/sched/core as of February
>         12th rebased on top of v5.6-rc1. The series includes patches from
>         Vincent as I needed to add a fix and build on top of it. Vincent's
>         series on its own introduces performance regressions for *some*
>         but not *all* machines so it's easily missed. This series overall
>         is close to performance-neutral with some gains depending on the
>         machine. However, the end result does less work on NUMA balancing
>         and the fact that both the NUMA balancer and load balancer uses
>         similar logic makes it much easier to understand.
>
> The NUMA balancer makes placement decisions on tasks that partially
> take the load balancer into account and vice versa but there are
> inconsistencies. This can result in placement decisions that override
> each other leading to unnecessary migrations -- both task placement
> and page placement. This series reconciles many of the decisions --
> partially Vincent's work with some fixes and optimisations on top to
> merge our two series.
>
> The first patch is unrelated. It's picked up by tip but was not present in
> the tree at the time of the fork. I'm including it here because I tested
> with it.
>
> The second and third patches are tracing only and was needed to get
> sensible data out of ftrace with respect to task placement for NUMA
> balancing. The NUMA balancer is *far* easier to analyse with the
> patches and informed how the series should be developed.
>
> Patches 4-5 are Vincent's and use very similar code patterns and logic
> between NUMA and load balancer. Patch 6 is a fix to Vincent's work that
> is necessary to avoid serious imbalances being introduced by the NUMA

Yes the test added in load_too_imbalanced() by patch 5 doesn't seem to
be a good choice.
I haven't remove it as it was done by your patch 6 but it might worth
removing it directly if a new version is needed

> balancer. Patches 7-8 are also Vincents and while I have not reviewed
> them closely myself, others have.
>
> The rest of the series are a mix of optimisations and improvements, one
> of which stops the NUMA balancer fighting with itself.
>
> Note that this is not necessarily a universal performance win although
> performance results are generally ok (small gains/losses depending on
> the machine and workload). However, task migrations, page migrations,
> variability and overall overhead are generally reduced.
>
> The main reference workload I used was specjbb running one JVM per node
> which typically would be expected to split evenly. It's an interesting
> workload because the number of "warehouses" does not linearly related
> to the number of running tasks due to the creation of GC threads
> and other interfering activity. The mmtests configuration used is
> jvm-specjbb2005-multi with two runs -- one with ftrace enabling relevant
> scheduler tracepoints.
>
> An example of the headline performance of the series is below and the
> tested kernels are
>
> baseline-v3r1   Patches 1-3 for the tracing
> loadavg-v3      Patches 1-5 (Add half of Vincent's work)
> lbidle-v3       Patches 1-6 Vincent's work with a fix on top
> classify-v3     Patches 1-8 Rest of Vincent's work
> stopsearch-v3   All patches
>
