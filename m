Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C956AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D5C207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS8IFkOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEGPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:24:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgEGPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588865072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sn9B/qCw+xpzKNwJiRuoyqmSFb/C0PGWUZvow5J7q/k=;
        b=JS8IFkOVg/6yXU4U9Z7JcFYVOuS6XWOrQTGBREerh2Qfy6k34MYPSabSuZzYrg4qDd2PRQ
        UQithILD4PkJyiKAYDhPefABa4GrFKoT+FawcTvELfHCsCEME8Il1yfRRVaVOuZofGXNIo
        bqt3w62cDbvWcpPEq2CjFH0tnVSjHRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-D4OWCLL6OceLGxamw0vD-Q-1; Thu, 07 May 2020 11:24:31 -0400
X-MC-Unique: D4OWCLL6OceLGxamw0vD-Q-1
Received: by mail-ed1-f69.google.com with SMTP id x14so2513135edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 08:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sn9B/qCw+xpzKNwJiRuoyqmSFb/C0PGWUZvow5J7q/k=;
        b=IERoxY4spzv9gcPt2mRLkbK+r6As4DNQJZFIBqexd5FkPsUh1aSnDcDDpbs5+8E8h+
         fipvH48n4MyPmaep9ccWgK5N3XyvjifzvToi2E4KSt9aZ+7bkzpLpJIVy/dACi+v2DFC
         lugGC59/cnj+/CfcABPnk5BOC1rYeu+vNY1hlMrHromC+q0pP8x46wbeVTdXudxNUO5Y
         vz9pQang1mT7lrzzXHydPRh9/QHhPldo/OwQ/nBvdQvmUxF8ypBvXWj7WZmA6jVrlELC
         T8lDkVn7TyBLU/tbUZ0XkORJtuF1FgRDvneeReKqFZAcRgVP1jR1HaE04QiOlPpQMceu
         348w==
X-Gm-Message-State: AGi0PuZcYwAMAoPl1HSlkE/6+jdQFtG9DMqdCY57fxdBl6S8F4Xo00Kd
        SE25VACDB+DMVt+rEnU6M29U8lZ8kmeSPrK+enRszNZWsgGp3ttc/hsXvt0OOzcYA0uS4c6gJE7
        /xerb1aJjhd7iitclDd3RLcsD1P8JAipvHPS1FJ79
X-Received: by 2002:a50:b202:: with SMTP id o2mr12106059edd.251.1588865068129;
        Thu, 07 May 2020 08:24:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEdo0z1FMbemZIeYfk0pgVs2Moj6IEK2/CBnvEhiujCY+pZsq62nKX9xxlKRNIQs5Iwk38/qsoq3c1fxUaAFM=
X-Received: by 2002:a50:b202:: with SMTP id o2mr12106041edd.251.1588865067934;
 Thu, 07 May 2020 08:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200309203625.GU3818@techsingularity.net> <20200312095432.GW3818@techsingularity.net>
 <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net> <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
In-Reply-To: <20200320163843.GD3818@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 7 May 2020 17:24:17 +0200
Message-ID: <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

> > Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> > NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> > servers).
>
> Ok, so we know it's within the imbalance threshold where a NUMA node can
> be left idle.

we have discussed today with my colleagues the performance drop for
some workloads for low threads counts (roughly up to 2x number of NUMA
nodes). We are worried that it can be a severe issue for some use
cases, which require a full memory bandwidth even when only part of
CPUs is used.

We understand that scheduler cannot distinguish this type of workload
from others automatically. However, there was an idea for a * new
kernel tunable to control the imbalance threshold *. Based on the
purpose of the server, users could set this tunable. See the tuned
project, which allows creating performance profiles [1].

What do you think about this approach?

Thanks a lot!
Jirka

[1] https://tuned-project.org


On Fri, Mar 20, 2020 at 5:38 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Mar 20, 2020 at 04:30:08PM +0100, Jirka Hladky wrote:
> > >
> > > MPI or OMP and what is a low thread count? For MPI at least, I saw a 0.4%
> > > gain on an 4-node machine for bt_C and a 3.88% regression on 8-nodes. I
> > > think it must be OMP you are using because I found I had to disable UA
> > > for MPI at some point in the past for reasons I no longer remember.
> >
> >
> > Yes, it's indeed OMP.  With low threads count, I mean up to 2x number of
> > NUMA nodes (8 threads on 4 NUMA node servers, 16 threads on 8 NUMA node
> > servers).
> >
>
> Ok, so we know it's within the imbalance threshold where a NUMA node can
> be left idle.
>
> > One possibility would be to spread wide always at clone time and assume
> > > wake_affine will pull related tasks but it's fragile because it breaks
> > > if the cloned task execs and then allocates memory from a remote node
> > > only to migrate to a local node immediately.
> >
> >
> > I think the only way to find out how it performs is to test it. If you
> > could prepare a patch like that, I'm more than happy to give it a try!
> >
>
> When the initial spreading was prevented, it was for pipelines mainly --
> even basic shell scripts. In that case it was observed that a shell would
> fork/exec two tasks connected via pipe that started on separate nodes and
> had allocated remote data before being pulled close. The processes were
> typically too short lived for NUMA balancing to fix it up by exec time
> the information on where the fork happened was lost.  See 2c83362734da
> ("sched/fair: Consider SD_NUMA when selecting the most idle group to
> schedule on"). Now the logic has probably been partially broken since
> because of how SD_NUMA is now treated but the concern about spreading
> wide prematurely remains.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

