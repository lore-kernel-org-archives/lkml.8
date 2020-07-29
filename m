Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E32083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEMTAmSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgG2OB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2OB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:01:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C612C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:01:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f18so2237826wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S3Q/pa7gsTzvCxWxv3cJhzM+dWaGRiyTH7DGwkkFbqg=;
        b=kEMTAmSPBJ4YqT1FtUt+9lTD5NQYda1kLIXjSHnBEKQvab5Ns03ekYHNonuRi2A1fC
         BMF7eZxP/FVwqbBfoyxumSs5NZpPVhdnF5+WQ21/4LoXy79KsSUm5tKqLKXI3OTyYaaw
         QzAW9fSP2y4eil14j8DYpcuEY4TptrGUpUvV9Cw8rXJfXILFGImfZr/INhWlOUYQCw9m
         AEwm/4bZnjpSfh14+vEQnHSg+seMoxL9/rCL4OxtrCqwbYTioCc57g8Qk2o6uH9Uk9zN
         ASE4fErNAX0ZwG7Br1t/c4WL3LzgjhOLVkENVIqs73zeVbyh7YMUE7NGiksIgtxRKPB0
         4yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3Q/pa7gsTzvCxWxv3cJhzM+dWaGRiyTH7DGwkkFbqg=;
        b=Cygoxhk+AmoAFCOtNhofTN19J2z7bt+qn4sqqSYR5BMXhyWCVj2+/OAqixQReEhKOk
         lK9LznsNOrHN6QegtjShdy4WaVIFA6wu2HmCnOphUmCHNMrFXedrcG5TobBZKuRqeUfO
         rwBVpzLnmKUQFxLclYjBHwDI4wnTQX2pg4m2eGoFgvefz4v+gE9UGGgqmArYKeent60f
         FleGvXB762wj3sBdRAWeqHW8OO5Q/BkTOb/DeHGl0qtvOVb2ZqO4KJaA0LN0diuCmdr6
         XwRB5mVGkDDiXPOBR4SjPtu4VKmEaz/0fDDsEefOt/JmYDvBF+1WZv0ucXBCHRK7MOkh
         4AAg==
X-Gm-Message-State: AOAM530Ry9AOYQlQxcWvPL9rVycM35ppKJYBipeVVa4e2Nf7nh6XzeB0
        9SyF2WX9N1hKcFT41Pkb5ad8BQ==
X-Google-Smtp-Source: ABdhPJwVF7l9peJsPebjdMmQ+dWcd/OjfsRzPDk6kyDbpI6QyOyDRJ96/ueT19VLZ/li3yaNkcKGRg==
X-Received: by 2002:a1c:81d1:: with SMTP id c200mr8776070wmd.162.1596031286746;
        Wed, 29 Jul 2020 07:01:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id j5sm5455686wmb.12.2020.07.29.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:01:25 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:01:21 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [SchedulerWakeupLatency] Skip energy aware task placement
Message-ID: <20200729140121.GB1075614@google.com>
References: <87v9kv2545.derkling@matbug.com>
 <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net>
 <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net>
 <87imfi2qbk.derkling@matbug.net>
 <2aa4b838-c298-ec7d-08f3-caa50cc87dc2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa4b838-c298-ec7d-08f3-caa50cc87dc2@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 Jul 2020 at 11:31:39 (+0200), Dietmar Eggemann wrote:
> The search for the most energy-efficient CPU over the Performance
> Domains (PDs) by consulting the Energy Model (EM), i.e. the estimation
> on how much energy a PD consumes if the task migrates to one of its
> CPUs, adds a certain amount of latency to task placement.
> 
> For some tasks this extra latency could be too high. A good example here
> are the Android display pipeline tasks, UIThread and RenderThread. They
> have to be placed on idle CPUs with a faster wakeup mechanism than the
> energy aware wakeup path (A) to guarantee the smallest amount of dropped
> or delayed frames (a.k.a. jank).
> 
> In Linux kernel mainline there is currently no mechanism for latency
> sensitive tasks to allow that the energy aware wakeup path (A) is
> skipped and the fast path (B) taken instead.

FWIW, Android has indeed been using a similar concept for many years
(the 'prefer-idle' flag you mentioned below) and that proved to be
critical to meet UI requirements on a number of devices. So +1 to have
this use case covered as part of the latency-nice work.

<...>
> > K) Task-Group tuning: which knobs are required
> 
> Currently Android uses the 'prefer idle' mechanism only on task-groups
> and not on individual tasks.

To add a little bit of context here, Android uses cgroups extensively
for task classification. The tasks of any currently used application are
placed in a cgroup based on their 'role'. For instance, all tasks that
belong to the currently visible application are classified as 'top-app',
and are grouped in a cgroup with 'prefer-idle' set (+ other attributes,
e.g. uclamp). The other tasks in the system are usually placed in other
cgroups (e.g. 'background'), with 'prefer-idle' cleared.

When the user switches from one app to the other, their roles are
swapped. At this point userspace needs to move all tasks of an app from
one cgroup to another, to reflect the change in role. But interestingly,
all tasks of the app belong to the same process, so userspace only needs
to write the PID of the parent task to the new cgroup to move all of
them at once. (Note: we're also experimenting having cgroups per-app
rather than per-role, and to change the cgroup parameters instead of
migrating between groups, but that doesn't change the conclusion below).

So, having 'only' a per-task API for latency-nice may not be sufficient
to cover the Android use-case, as that would force userspace to iterate
over all the tasks in an app when switching between roles, and that will
come at a certain cost (currently unknown). However, that will need to
be confirmed experimentally, and starting 'simple' with a per-task API
would definitely be a step in the right direction.

Thanks,
Quentin
