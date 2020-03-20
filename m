Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F083C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514412072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzIcSbhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCTPIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:08:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57870 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCTPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584716930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JgxL2fyUADCsgaHZ7X7Ut7jNkOwliSXCeh9HnkMVo0=;
        b=gzIcSbhcsUHd+E0hljwxUNa0KWi1gfOhendS77a1TtzqgTRWC3xxk9M2lVzBHI2T/q0Lg1
        iDt3r1wYO0Hk+mULqQ+3Rhwq4DKdbh5bTW+8QcPdU5XnjtXriqZF2NwWiF8njFkkO32r+n
        xtTZwhbzq41+yb/CRnk4u8TXRGCvKpQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-rQo21KI1P8SikuDtJR4q6g-1; Fri, 20 Mar 2020 11:08:49 -0400
X-MC-Unique: rQo21KI1P8SikuDtJR4q6g-1
Received: by mail-wm1-f71.google.com with SMTP id z26so3487385wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/JgxL2fyUADCsgaHZ7X7Ut7jNkOwliSXCeh9HnkMVo0=;
        b=KyNc73WeW8QeUMGToWuNr73YegQ9kM3eO/GArWsmfM1pW7lJJTc8bPrxhvJ3sIMYtD
         iV08aqaq7WFuglXf+t81LsfJKRz/sLVV0r52kBPYe9kiWtBX4PowEWtml78v6YorY0bH
         BeZq7cdUsF63pKy4lavJh4Qs1NP/AERvg6rdiNj0m6EAU7ykG4p9IHX8o6R0G1es0bU0
         lAz+MKnKqmPf/9BGWns/dHr9ab0X1fuXOOqsOm4mxLgSUlUt5KhwHC4BGpnANjrwp9cY
         dJQh/4jrnCYEQcFOfp1iYFfrTOHSt2d4plg23zgg66YWMJRLlzKiQkFR9m4ERQTfEXfE
         pb5w==
X-Gm-Message-State: ANhLgQ0N5JRBMtsB1RmZMD4gfAGNDKT7wR356l6tL2JcCM+P4TNWSR37
        1jQ/03vQ7Z7SavyTTEuR4hRoJvhNSSVZqUFAzXaDp0x39C2NlnzXJo3hNARm5VxiciA0JM742od
        4drlvCPKSp5FulVfXcXfyvgztHnctwWlfEYF/vJzW
X-Received: by 2002:adf:f68a:: with SMTP id v10mr7103171wrp.80.1584716927386;
        Fri, 20 Mar 2020 08:08:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsZAvBgF8EWHv1Bxi/Eer1q0/R4qGCw6IQqveAa4hmnouwRIiXIUshKa11J/R0TsK0Og4v9BeX1W/qMoZHapXA=
X-Received: by 2002:adf:f68a:: with SMTP id v10mr7103138wrp.80.1584716927037;
 Fri, 20 Mar 2020 08:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb> <20200309203625.GU3818@techsingularity.net>
 <20200312095432.GW3818@techsingularity.net> <CAE4VaGA4q4_qfC5qe3zaLRfiJhvMaSb2WADgOcQeTwmPvNat+A@mail.gmail.com>
 <20200312155640.GX3818@techsingularity.net> <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
In-Reply-To: <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 20 Mar 2020 16:08:35 +0100
Message-ID: <CAE4VaGCOKzZ-oq6YCmqC7ZbpjLKJQGZ2aYbJc1_Name9Qs5mfQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

just a quick update. I have increased the testing coverage and other
tests from the NAS shows a big performance drop for the low number of
threads as well:

sp_C_x - show still the biggest drop upto 50%
bt_C_x - performance drop upto 40%
ua_C_x - performance drop upto 30%

My point is that the performance drop for the low number of threads is
more common than we have initially thought.

Let me know what you need more data.

Thanks!
Jirka


On Thu, Mar 12, 2020 at 11:24 PM Jirka Hladky <jhladky@redhat.com> wrote:
>
> > I'll continue thinking about it but whatever chance there is of
> > improving it while keeping CPU balancing, NUMA balancing and wake affine
> > consistent with each other, I think there is no chance with the
> > inconsistent logic used in the vanilla code :(
>
> Thank you, Mel!
>
>
> On Thu, Mar 12, 2020 at 10:47 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Mar 12, 2020 at 05:54:29PM +0100, Jirka Hladky wrote:
> > > >
> > > > find it unlikely that is common because who acquires such a large machine
> > > > and then uses a tiny percentage of it.
> > >
> > >
> > > I generally agree, but I also want to make a point that AMD made these
> > > large systems much more affordable with their EPYC CPUs. The 8 NUMA node
> > > server we are using costs under $8k.
> > >
> > >
> > >
> > > > This is somewhat of a dilemma. Without the series, the load balancer and
> > > > NUMA balancer use very different criteria on what should happen and
> > > > results are not stable.
> > >
> > >
> > > Unfortunately, I see instabilities also for the series. This is again for
> > > the sp_C test with 8 threads executed on dual-socket AMD 7351 (EPYC Naples)
> > > server with 8 NUMA nodes. With the series applied, the runtime varies from
> > > 86 to 165 seconds! Could we do something about it? The runtime of 86
> > > seconds would be acceptable. If we could stabilize this case and get
> > > consistent runtime around 80 seconds, the problem would be gone.
> > >
> > > Do you experience the similar instability of results on your HW for sp_C
> > > with low thread counts?
> > >
> >
> > I saw something similar but observed that it depended on whether the
> > worker tasks got spread wide or not which partially came down to luck.
> > The question is if it's possible to pick a point where we spread wide
> > and can recover quickly enough when tasks need to remain close without
> > knowledge of the future. Putting a balancing limit on tasks that
> > recently woke would be one option but that could also cause persistent
> > improper balancing for tasks that wake frequently.
> >
> > > Runtime with this series applied:
> > >  $ grep "Time in seconds" *log
> > > sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
> > >   125.73
> > > sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
> > >    87.54
> > > sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
> > >    86.93
> > > sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
> > >   165.98
> > > sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
> > >   114.78
> > >
> > > For comparison, here are vanilla kernel results:
> > > $ grep "Time in seconds" *log
> > > sp.C.x.defaultRun.008threads.loop01.log: Time in seconds =
> > >    59.83
> > > sp.C.x.defaultRun.008threads.loop02.log: Time in seconds =
> > >    67.72
> > > sp.C.x.defaultRun.008threads.loop03.log: Time in seconds =
> > >    63.62
> > > sp.C.x.defaultRun.008threads.loop04.log: Time in seconds =
> > >    55.01
> > > sp.C.x.defaultRun.008threads.loop05.log: Time in seconds =
> > >    65.20
> > >
> > >
> > >
> > > > In *general*, I found that the series won a lot more than it lost across
> > > > a spread of workloads and machines but unfortunately it's also an area
> > > > where counter-examples can be found.
> > >
> > >
> > > OK, fair enough. I understand that there will always be trade-offs when
> > > making changes to scheduler like this. And I agree that cases with higher
> > > system load (where is series is helpful) outweigh the performance drops for
> > > low threads counts. I was hoping that it would be possible to improve the
> > > small threads results while keeping the gains for other scenarios:-)  But
> > > let's be realistic - I would be happy to fix the extreme case mentioned
> > > above. The other issues where performance drop is about 20% are OK with me
> > > and are outweighed by the gains for different scenarios.
> > >
> >
> > I'll continue thinking about it but whatever chance there is of
> > improving it while keeping CPU balancing, NUMA balancing and wake affine
> > consistent with each other, I think there is no chance with the
> > inconsistent logic used in the vanilla code :(
> >
> > --
> > Mel Gorman
> > SUSE Labs
> >
>
>
> --
> -Jirka



-- 
-Jirka

