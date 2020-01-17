Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21786C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AD22083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxkcf3TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgAQNI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:08:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42133 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAQNI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:08:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so26406473ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkEYaSle2JXv+HIaW7TQmEwpjoa1M8+VdpzumuZ886A=;
        b=cxkcf3TPH3rUD3X3ib8YlngkOJLOIMMSBDwzoNr1YjCka2aHgi37CKRMoXIkflAWe+
         F4pDsNLfoeI+DRGSpVWdR6eJ2YQuzIXcEZWhkgoA0TYaxm76NPzKNDjEb9D5QW5AS+M1
         Ly3u60WDuw9m4lrWdVD03Wf4ANiQEK/Qbbc3HsuPE/jI5TToyZbTI8BN9N4QCSxytsRe
         LSaQhdZfqs1gF8sSAsMJk1oDDoihZMegBoOp+WfZDRXzsHoLCkNUQZFUla4qL6gx+oZ4
         joc2z21VIT2rk0VSdaMDEupKdebQj3qCrPWln9R/5i9dQxRFh7c0yYFBnnLL8VGSxnEk
         FeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkEYaSle2JXv+HIaW7TQmEwpjoa1M8+VdpzumuZ886A=;
        b=fO0HIuG74LN7HduVyvW4Qr3MTDNyFmC9JWDNFPCOW+t5jiP2ti8P3Stc1kgTOwIMGT
         qgJAB/bXi2N/IAkhqJ8EqVQGWvyQen24cR2/mSGlhu4MrdLP1QLkPn6Nd1/oGVnzxqA4
         +o5q5tzzethIQLFI6jJVwP/Cc2kfU8aeymSh/iChcxYMZN2d/79rWp4oZ172DS87clA5
         KCpDZTKqjHWNyAZwhCPbcCeJ9hvHpnjgD6di/+M41mW6S5aE2Ht6pZZb8GijYtoGy1Dv
         3CTs3OiH+9hDaTdTbT+AfV6qQwojr6Bg5MKurrJdrgWrJ9HouyhSZHPM11Zf0zFHmTgx
         GYsA==
X-Gm-Message-State: APjAAAXANM9stG8W0qhOaZCitR8sqKlR0rIs2tlvOQlf0w9MIO5ZLzIm
        AnzrMuejrXQWyH4bxZTZaPJgIXeW0notN1czrplJEPyplTJfHw==
X-Google-Smtp-Source: APXvYqxcVXzs9+LAyiBiYyP3M65EJxWa+AYBrVwSPTnHmWscANOe892DtIVM0pEdSHRQHFsgIIEsvuKIjPi7JfiyBtg=
X-Received: by 2002:a2e:3309:: with SMTP id d9mr5556603ljc.262.1579266504976;
 Fri, 17 Jan 2020 05:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20200114101319.GO3466@techsingularity.net> <20200116163529.GP3466@techsingularity.net>
In-Reply-To: <20200116163529.GP3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jan 2020 14:08:13 +0100
Message-ID: <CAKfTPtBznUt20QFzeQBPELcmN6+F=BOx09oSqVMzSGvXF5ByHg@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
To:     Mel Gorman <mgorman@techsingularity.net>,
        Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,


On Thu, 16 Jan 2020 at 17:35, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Jan 14, 2020 at 10:13:20AM +0000, Mel Gorman wrote:
> > Changelog since V3
> > o Allow a fixed imbalance a basic comparison with 2 tasks. This turned out to
> >   be as good or better than allowing an imbalance based on the group weight
> >   without worrying about potential spillover of the lower scheduler domains.
> >
> > Changelog since V2
> > o Only allow a small imbalance when utilisation is low to address reports that
> >   higher utilisation workloads were hitting corner cases.
> >
> > Changelog since V1
> > o Alter code flow                                             vincent.guittot
> > o Use idle CPUs for comparison instead of sum_nr_running      vincent.guittot
> > o Note that the division is still in place. Without it and taking
> >   imbalance_adj into account before the cutoff, two NUMA domains
> >   do not converage as being equally balanced when the number of
> >   busy tasks equals the size of one domain (50% of the sum).
> >
> > The CPU load balancer balances between different domains to spread load
> > and strives to have equal balance everywhere. Communicating tasks can
> > migrate so they are topologically close to each other but these decisions
> > are independent. On a lightly loaded NUMA machine, two communicating tasks
> > pulled together at wakeup time can be pushed apart by the load balancer.
> > In isolation, the load balancer decision is fine but it ignores the tasks
> > data locality and the wakeup/LB paths continually conflict. NUMA balancing
> > is also a factor but it also simply conflicts with the load balancer.
> >
> > This patch allows a fixed degree of imbalance of two tasks to exist
> > between NUMA domains regardless of utilisation levels. In many cases,
> > this prevents communicating tasks being pulled apart. It was evaluated
> > whether the imbalance should be scaled to the domain size. However, no
> > additional benefit was measured across a range of workloads and machines
> > and scaling adds the risk that lower domains have to be rebalanced. While
> > this could change again in the future, such a change should specify the
> > use case and benefit.
> >
>
> Any thoughts on whether this is ok for tip or are there suggestions on
> an alternative approach?

I have just finished to run some tests on my system with your patch
and I haven't seen any noticeable any changes so far which was a bit
expected. The tests that I usually run, use more than 4 tasks on my 2
nodes system; the only exception is perf sched  pipe and the results
for this test stays the same with and without your patch. I'm curious
if this impacts Phil's tests which run LU.c benchmark with some
burning cpu tasks

>
> --
> Mel Gorman
> SUSE Labs
