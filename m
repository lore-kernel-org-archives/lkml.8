Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECBBC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EEA2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvHWMCRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAQPJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:09:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34015 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAQPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:09:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so26838443ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3JzqJCtTjEIWA4ajF5t2u9dR2tsl69Sfhdd/Wg8osE=;
        b=DvHWMCRkloeYc2K+zGpBjUveN7quhIye5EUx9C7Nw3QaP4aHmgS47656bo+4nA4fwQ
         kazKbrEcEn94RqhLdBet0gKBPDtXUHqu07YSlZmLP6AP0UmMNk4d1Ac3zuXxeRstvIzt
         tvLNVFU+tSJTN1Wz7vtUwWVrJ7FsJXGu1tqcqObAJ849KQdjLhSY8PUFIrafURi5Xcp1
         SzyJSY5oMercLl+qB2B9WGIs3o+kt9cl2yN2Eed/JO32U/NyjjBzyxU34XBkTbRIN5DM
         OpoYsPwFKNumPozNkcE/8E2gK1pWCZETrXOfDiWEsNAWTNmQlrOKJqf540ckkdvxrR+I
         6VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3JzqJCtTjEIWA4ajF5t2u9dR2tsl69Sfhdd/Wg8osE=;
        b=Uval8L9Z35FJoFcZDRrYBNbNttjcGE/Y05j/Rs5irWHd075pvmkpfAUkqo6vYfHvfs
         05XY/IpCoq0MQqMONMpOnGq4s0E/YYCbYxfo/rw0mYq1bdpKezkY17nxPilQmwxAvrYj
         lVFZPLDpEECsPVqsXY2hnuWkuES22Btw9mhMfdzxfyFwhybqE8/c2G4I3Tm4gPM/Kq56
         g+l1MWzZsxHmCZ1xhQTFZrhV8vjGXgI51nNioLZWc/PjkaK7dGGJsev5HKU4lROjMvjF
         MVsrpyUjr5HsQ84tierhq5XdYUsK2t4HN3BO+0Vi2NbI9v2UZRq6b5xUYMMRGF86zkHf
         FZzw==
X-Gm-Message-State: APjAAAWTU0FoDo3EqWtH+XwA5uRgB9C6Vg9ZGa47TbRbHLBUpEbvi2Jk
        asOLonOnLGH23X/JcQQ67OVKfRy4kF8C54orsPvxBw==
X-Google-Smtp-Source: APXvYqxpPT3fs02LGlprIaqb1fa4GNv3B59xS4h0atnEcCG7KeBOp6euiglZizqpVXggQ9ADtrEDRE65ygkYgzBJsPI=
X-Received: by 2002:a2e:3309:: with SMTP id d9mr5870857ljc.262.1579273784825;
 Fri, 17 Jan 2020 07:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20200114101319.GO3466@techsingularity.net>
In-Reply-To: <20200114101319.GO3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jan 2020 16:09:33 +0100
Message-ID: <CAKfTPtC7zuvWym8tSxXx6d+FhiSsedrS5sRZZagR5B7pXgZewA@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
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

On Tue, 14 Jan 2020 at 11:13, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Changelog since V3
> o Allow a fixed imbalance a basic comparison with 2 tasks. This turned out to
>   be as good or better than allowing an imbalance based on the group weight
>   without worrying about potential spillover of the lower scheduler domains.
>
> Changelog since V2
> o Only allow a small imbalance when utilisation is low to address reports that
>   higher utilisation workloads were hitting corner cases.
>
> Changelog since V1
> o Alter code flow                                               vincent.guittot
> o Use idle CPUs for comparison instead of sum_nr_running        vincent.guittot
> o Note that the division is still in place. Without it and taking
>   imbalance_adj into account before the cutoff, two NUMA domains
>   do not converage as being equally balanced when the number of
>   busy tasks equals the size of one domain (50% of the sum).
>
> The CPU load balancer balances between different domains to spread load
> and strives to have equal balance everywhere. Communicating tasks can
> migrate so they are topologically close to each other but these decisions
> are independent. On a lightly loaded NUMA machine, two communicating tasks
> pulled together at wakeup time can be pushed apart by the load balancer.
> In isolation, the load balancer decision is fine but it ignores the tasks
> data locality and the wakeup/LB paths continually conflict. NUMA balancing
> is also a factor but it also simply conflicts with the load balancer.
>
> This patch allows a fixed degree of imbalance of two tasks to exist
> between NUMA domains regardless of utilisation levels. In many cases,
> this prevents communicating tasks being pulled apart. It was evaluated
> whether the imbalance should be scaled to the domain size. However, no
> additional benefit was measured across a range of workloads and machines
> and scaling adds the risk that lower domains have to be rebalanced. While
> this could change again in the future, such a change should specify the
> use case and benefit.
>
> The most obvious impact is on netperf TCP_STREAM -- two simple
> communicating tasks with some softirq offload depending on the
> transmission rate.
>
> 2-socket Haswell machine 48 core, HT enabled
> netperf-tcp -- mmtests config config-network-netperf-unbound
>                               baseline              lbnuma-v3
> Hmean     64         568.73 (   0.00%)      577.56 *   1.55%*
> Hmean     128       1089.98 (   0.00%)     1128.06 *   3.49%*
> Hmean     256       2061.72 (   0.00%)     2104.39 *   2.07%*
> Hmean     1024      7254.27 (   0.00%)     7557.52 *   4.18%*
> Hmean     2048     11729.20 (   0.00%)    13350.67 *  13.82%*
> Hmean     3312     15309.08 (   0.00%)    18058.95 *  17.96%*
> Hmean     4096     17338.75 (   0.00%)    20483.66 *  18.14%*
> Hmean     8192     25047.12 (   0.00%)    27806.84 *  11.02%*
> Hmean     16384    27359.55 (   0.00%)    33071.88 *  20.88%*
> Stddev    64           2.16 (   0.00%)        2.02 (   6.53%)
> Stddev    128          2.31 (   0.00%)        2.19 (   5.05%)
> Stddev    256         11.88 (   0.00%)        3.22 (  72.88%)
> Stddev    1024        23.68 (   0.00%)        7.24 (  69.43%)
> Stddev    2048        79.46 (   0.00%)       71.49 (  10.03%)
> Stddev    3312        26.71 (   0.00%)       57.80 (-116.41%)
> Stddev    4096       185.57 (   0.00%)       96.15 (  48.19%)
> Stddev    8192       245.80 (   0.00%)      100.73 (  59.02%)
> Stddev    16384      207.31 (   0.00%)      141.65 (  31.67%)
>
> In this case, there was a sizable improvement to performance and
> a general reduction in variance. However, this is not univeral.
> For most machines, the impact was roughly a 3% performance gain.
>
> Ops NUMA base-page range updates       19796.00         292.00
> Ops NUMA PTE updates                   19796.00         292.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                   16113.00         143.00
> Ops NUMA hint local faults %            8407.00         142.00
> Ops NUMA hint local percent               52.18          99.30
> Ops NUMA pages migrated                 4244.00           1.00
>
> Without the patch, only 52.18% of sampled accesses are local.  In an
> earlier changelog, 100% of sampled accesses are local and indeed on
> most machines, this was still the case. In this specific case, the
> local sampled rates was 99.3% but note the "base-page range updates"
> and "PTE updates".  The activity with the patch is negligible as were
> the number of faults. The small number of pages migrated were related to
> shared libraries.  A 2-socket Broadwell showed better results on average
> but are not presented for brevity as the performance was similar except
> it showed 100% of the sampled NUMA hints were local. The patch holds up
> for a 4-socket Haswell, an AMD EPYC and AMD Epyc 2 machine.
>
> For dbench, the impact depends on the filesystem used and the number of
> clients. On XFS, there is little difference as the clients typically
> communicate with workqueues which have a separate class of scheduler
> problem at the moment. For ext4, performance is generally better,
> particularly for small numbers of clients as NUMA balancing activity is
> negligible with the patch applied.
>
> A more interesting example is the Facebook schbench which uses a
> number of messaging threads to communicate with worker threads. In this
> configuration, one messaging thread is used per NUMA node and the number of
> worker threads is varied. The 50, 75, 90, 95, 99, 99.5 and 99.9 percentiles
> for response latency is then reported.
>
> Lat 50.00th-qrtle-1        44.00 (   0.00%)       37.00 (  15.91%)
> Lat 75.00th-qrtle-1        53.00 (   0.00%)       41.00 (  22.64%)
> Lat 90.00th-qrtle-1        57.00 (   0.00%)       42.00 (  26.32%)
> Lat 95.00th-qrtle-1        63.00 (   0.00%)       43.00 (  31.75%)
> Lat 99.00th-qrtle-1        76.00 (   0.00%)       51.00 (  32.89%)
> Lat 99.50th-qrtle-1        89.00 (   0.00%)       52.00 (  41.57%)
> Lat 99.90th-qrtle-1        98.00 (   0.00%)       55.00 (  43.88%)
> Lat 50.00th-qrtle-2        42.00 (   0.00%)       42.00 (   0.00%)
> Lat 75.00th-qrtle-2        48.00 (   0.00%)       47.00 (   2.08%)
> Lat 90.00th-qrtle-2        53.00 (   0.00%)       52.00 (   1.89%)
> Lat 95.00th-qrtle-2        55.00 (   0.00%)       53.00 (   3.64%)
> Lat 99.00th-qrtle-2        62.00 (   0.00%)       60.00 (   3.23%)
> Lat 99.50th-qrtle-2        63.00 (   0.00%)       63.00 (   0.00%)
> Lat 99.90th-qrtle-2        68.00 (   0.00%)       66.00 (   2.94%
>
> For higher worker threads, the differences become negligible but it's
> interesting to note the difference in wakeup latency at low utilisation
> and mpstat confirms that activity was almost all on one node until
> the number of worker threads increase.
>
> Hackbench generally showed neutral results across a range of machines.
> This is different to earlier versions of the patch which allowed imbalances
> for higher degrees of utilisation. perf bench pipe showed negligible
> differences in overall performance as the differences are very close to
> the noise.
>
> An earlier prototype of the patch showed major regressions for NAS C-class
> when running with only half of the available CPUs -- 20-30% performance
> hits were measured at the time. With this version of the patch, the impact
> is negligible with small gains/losses within the noise measured. This is
> because the number of threads far exceeds the small imbalance the aptch
> cares about. Similarly, there were report of regressions for the autonuma
> benchmark against earlier versions but again, normal load balancing now
> applies for that workload.
>
> In general, the patch simply seeks to avoid unnecessary cross-node
> migrations in the basic case where imbalances are very small.  For low
> utilisation communicating workloads, this patch generally behaves better
> with less NUMA balancing activity. For high utilisation, there is no
> change in behaviour.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
