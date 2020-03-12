Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF63C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248A620637
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+/ITpjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCLWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:24:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726621AbgCLWYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584051883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bpupobxRF3hx7fAwy8nqRUHW9GglCl8DazgzCAB+Nfs=;
        b=Z+/ITpjc/92/qrn8sz6BiVYrcWIycmrwZ01UnY76Qun8fl5sTwtoAIyPtOvuSxvAasIcwI
        Nb6bLzDIoOi/p065JPO6Z+ldDxInbZoBeZsEQRGhLcmLo+Kx7ZpN8nwTJ3i66q3DAPYeNg
        g35qGRjMJKtn87iMt2zvrC13Yin6JuM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-y3n5Gr3pN5aAQVsjHnzDGw-1; Thu, 12 Mar 2020 18:24:42 -0400
X-MC-Unique: y3n5Gr3pN5aAQVsjHnzDGw-1
Received: by mail-wr1-f71.google.com with SMTP id j17so3279776wru.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpupobxRF3hx7fAwy8nqRUHW9GglCl8DazgzCAB+Nfs=;
        b=hLazGkRA91V3R0yUOLCqsBPfTtKvkuvZKnAzM70RACjsXXBVedScKUIFz7ttqvXm7q
         bTSyNP9Ry8uER+cu2BVPDsZkULbALXOgLht8gNMfe2YKkCHs8YwD4f4MbmT1hqYmgMB1
         5JzzCTtXRuwNzjKzpIklvcxzgfOBACu/jL7H6lNhnUDX3R4P3I0x5YMhwtQeJX5SSpjo
         qJE4JhSMcmO+rjcwplG9fr8Q+j+EIY/P2qZzekgK0Ma5cRUjFF0Se4m1OhQlO4M/7pfb
         h60YK3cTKxpsbE04jACy38nsNTjOyZH2xoKnzhFXxWG97vo/yEgy/uHqz4vBwaal7hV3
         Bd4Q==
X-Gm-Message-State: ANhLgQ3a30EkuREjV43d9/vwpTX3FwEOTt/gbPk/oWxChOESe8Rolt6S
        jn3KUfWCCM7bS8h8U8q0a3hQYg03oc8FnXoUQcAFqOvkmt+36SPA0zBZHu3Sc5AJF8n47pvpMXH
        5HLkk7H5krqszFpw9TPYwRrrahHM+whn8m/K8cweI
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr13039805wrs.272.1584051881158;
        Thu, 12 Mar 2020 15:24:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstn9gf/+BK/otI89IhYPwm2ycD7a/U4sJ+WG+RIIK9soeSGbPrem6/VaOE0m7/54auwNNCRCBnZOY00Qa0khM=
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr13039774wrs.272.1584051880862;
 Thu, 12 Mar 2020 15:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb> <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net> <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net> <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net>
In-Reply-To: <20200312214736.GA3818@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 12 Mar 2020 23:24:29 +0100
Message-ID: <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
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
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll continue thinking about it but whatever chance there is of
> improving it while keeping CPU balancing, NUMA balancing and wake affine
> consistent with each other, I think there is no chance with the
> inconsistent logic used in the vanilla code :(

Thank you, Mel!


On Thu, Mar 12, 2020 at 10:47 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Mar 12, 2020 at 05:54:29PM +0100, Jirka Hladky wrote:
> > >
> > > find it unlikely that is common because who acquires such a large machine
> > > and then uses a tiny percentage of it.
> >
> >
> > I generally agree, but I also want to make a point that AMD made these
> > large systems much more affordable with their EPYC CPUs. The 8 NUMA node
> > server we are using costs under $8k.
> >
> >
> >
> > > This is somewhat of a dilemma. Without the series, the load balancer and
> > > NUMA balancer use very different criteria on what should happen and
> > > results are not stable.
> >
> >
> > Unfortunately, I see instabilities also for the series. This is again for
> > the sp_C test with 8 threads executed on dual-socket AMD 7351 (EPYC Naples)
> > server with 8 NUMA nodes. With the series applied, the runtime varies from
> > 86 to 165 seconds! Could we do something about it? The runtime of 86
> > seconds would be acceptable. If we could stabilize this case and get
> > consistent runtime around 80 seconds, the problem would be gone.
> >
> > Do you experience the similar instability of results on your HW for sp_C
> > with low thread counts?
> >
>
> I saw something similar but observed that it depended on whether the
> worker tasks got spread wide or not which partially came down to luck.
> The question is if it's possible to pick a point where we spread wide
> and can recover quickly enough when tasks need to remain close without
> knowledge of the future. Putting a balancing limit on tasks that
> recently woke would be one option but that could also cause persistent
> improper balancing for tasks that wake frequently.
>
> > Runtime with this series applied:
> >  $ grep "Time in seconds" *log
> > sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
> >   125.73
> > sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
> >    87.54
> > sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
> >    86.93
> > sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
> >   165.98
> > sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
> >   114.78
> >
> > For comparison, here are vanilla kernel results:
> > $ grep "Time in seconds" *log
> > sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
> >    59.83
> > sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
> >    67.72
> > sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
> >    63.62
> > sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
> >    55.01
> > sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
> >    65.20
> >
> >
> >
> > > In *general*, I found that the series won a lot more than it lost across
> > > a spread of workloads and machines but unfortunately it's also an area
> > > where counter-examples can be found.
> >
> >
> > OK, fair enough. I understand that there will always be trade-offs when
> > making changes to scheduler like this. And I agree that cases with higher
> > system load (where is series is helpful) outweigh the performance drops for
> > low threads counts. I was hoping that it would be possible to improve the
> > small threads results while keeping the gains for other scenarios:-)  But
> > let's be realistic - I would be happy to fix the extreme case mentioned
> > above. The other issues where performance drop is about 20% are OK with me
> > and are outweighed by the gains for different scenarios.
> >
>
> I'll continue thinking about it but whatever chance there is of
> improving it while keeping CPU balancing, NUMA balancing and wake affine
> consistent with each other, I think there is no chance with the
> inconsistent logic used in the vanilla code :(
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

