Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE8C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FBF20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWfDDso3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgEGRYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgEGRYq (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:24:46 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23AC05BD43
        for <Linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:24:46 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id q206so3332243ybg.1
        for <Linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qwi/mLzlnIWo6FMJsWVhJEnxBXCBJt31KahfK+nSC0Q=;
        b=LWfDDso3CgtTjnaJD88rEpOj8W0NhidIlYFA13IHjIvqkKcHU3ry454k5VeItAE2P0
         i7nLoQw3BYJQmC1qBsiJ3hgfTxAtqiXx4P4Pye740pQpOw/l4pJNy/AL6XD1L2SQIl6P
         P2C8uMrzJnyBGOuXoAg/GrZDECM0G7Nfgf7zJEXIG8UwNrRhPOT37rxv57KOXjrFoOCN
         Y9sl0Nr5mum724HV43BR7pO8TBoODmJuSzcIoreHlwZQfn4XIOSnqhe8G887JbZBTAIo
         Ni5jlNvC9+T0m3a9cZKNRFGRNSmZJedxkLiZ7EQddicxn2tMvaNgnmd9MiCObz044Ft0
         suJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qwi/mLzlnIWo6FMJsWVhJEnxBXCBJt31KahfK+nSC0Q=;
        b=GElBbarM5yGcYJK7mesmiP689XTOxXsHs1WaAfhe7JAEKqm+G+G7lRsSAZrEnhmk+9
         iEhO7RkSHdeExscYk9i/7mnNrTh+12b8JAlKHqQYbiVvK+DzaPj8cqqB0ZtyHm2vQGGG
         aOEhBdBDu47Z0ntyUgoszKMg7DZfyle2uF3ZSjc9psUhZooeiqwOBdELE7cv4o10tNW4
         eUz338C/mMzzEZ9XYvhQBN/rKgcHCSajkBAnalmmcH/bqUYQ/MM+z5XcJnSJmn1++7+o
         lfRRajlzM97FweFmAtobJIT3syByuvnQ3F32Nr/aCNlbKhvcs6xQky9J7ryNFcKgDQLY
         tWUA==
X-Gm-Message-State: AGi0PuZDSEjswc+WU3omqcnpQgx6hmXUWPRZWalFPvf3ScUnwt/mcVbh
        41p7NydGfGiKEATudFKS9I7wkwH/aza6XLWiUHQHTw==
X-Google-Smtp-Source: APiQypKtWuh1zSMJ8f5a6u4OOAmP+GM9mskpuX5ChgmSySL0OT40yI9ciCA+7aw90CVi7PC4qZhfgnwixv4lJmtQDDQ=
X-Received: by 2002:a25:4446:: with SMTP id r67mr3020164yba.41.1588872285289;
 Thu, 07 May 2020 10:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava> <66b84e3f-f7d8-bb65-616e-d159a509a439@huawei.com>
 <20200430111551.GC1694693@krava> <0195184b-0b43-f2fd-8d80-3b70d3f5a950@huawei.com>
 <8685d584-1d28-4648-8d85-2ea637f3c695@linux.intel.com> <20200507164642.GD31109@kernel.org>
In-Reply-To: <20200507164642.GD31109@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 May 2020 10:24:34 -0700
Message-ID: <CAP-5=fX21fHWAn8C7inhyfQhq7+qq2KL_8nbhZOPiJeo9NRCKw@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        yao.jin@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:46 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Apr 30, 2020 at 09:38:34PM +0800, Jin, Yao escreveu:
> > Hi John, Jiri,
> >
> > On 4/30/2020 7:48 PM, John Garry wrote:
> > > On 30/04/2020 12:15, Jiri Olsa wrote:
> > >
> > > +
> > >
> > > > On Thu, Apr 30, 2020 at 09:54:18AM +0100, John Garry wrote:
> > > > > On 30/04/2020 09:45, Jiri Olsa wrote:
> > > > > > On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> > > > > > > A big uncore event group is split into multiple small groups which
> > > > > > > only include the uncore events from the same PMU. This has been
> > > > > > > supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> > > > > > > uncore event aliases in small groups properly").
> > > > > > >
> > > > > > > If the event's PMU name starts to repeat, it must be a new event.
> > > > > > > That can be used to distinguish the leader from other members.
> > > > > > > But now it only compares the pointer of pmu_name
> > > > > > > (leader->pmu_name == evsel->pmu_name).
> > > > > > >
> > > > > > > If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> > > > > > > the event list is:
> > > > > > >
> > > > > > > evsel->name                    evsel->pmu_name
> > > > > > > ---------------------------------------------------------------
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_4 (as leader)
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_2
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_0
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_5
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_3
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_1
> > > > > > > unc_iio_data_req_of_cpu.mem_write.part1        uncore_iio_4
> > > > > > > ......
> > > > > > >
> > > > > > > For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> > > > > > > "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> > > > > > > It's not a new leader for this PMU.
> > > > > > >
> > > > > > > But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> > > > > > > would be failed and the event is stored to leaders[] as a new
> > > > > > > PMU leader.
> > > > > > >
> > > > > > > So this patch uses strcmp to compare the PMU name between events.
> > > > > > >
> > > > > > > Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore
> > > > > > > event aliases in small groups properly")
> > > > > > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > > > >
> > > > > > looks good, any chance we could have automated test
> > > > > > for this uncore leader setup logic? like maybe the way
> > > > > > John did the pmu-events tests? like test will trigger
> > > > > > only when there's the pmu/events in the system
> > > > > >
> > > > > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > > > >
> > > > > > thanks,
> > > > > > jirka
> > > > >
> > > > > Hi jirka,
> > > > >
> > > > > JFYI, this is effectively the same patch as I mentioned to you, which was a
> > > > > fix for the same WARN:
> > > > >
> > > > > https://lore.kernel.org/linux-arm-kernel/1587120084-18990-2-git-send-email-john.garry@huawei.com/
> > > > >
> > > > >
> > > > > but I found that it "fixed" d4953f7ef1a2 ("perf parse-events: Fix 3 use
> > > > > after frees found with clang ASANutil/parse-events.c"), based on bisect
> > > > > breakage
> > > >
> > > > hum right.. sorry I did not recalled that, there's
> > > > also the warn removal in here, could you guys also
> > > > plz sync on the fixes clauses?
> > >
> > > I just thought that it fixes d4953f7ef1a2, as I found that the pointer
> > > equality fails from that commit. I assume the parse-events code was
> > > sound before then (in that regard). That's all I know :)
> > >
> > > Thanks!
> > >
> >
> > For 3cdc5c2cb924a, I just think it should use strcmp for pmu_name comparison
> > rather than using pointer. But I'm OK to add d4953f7ef1a2 in fixes clauses.
> > :)
>
> So, I'm keeping Ian's patch, as I just applied it, and replaced the
> fixes clause to:
>
> Fixes: d4953f7ef1a2 ("perf parse-events: Fix 3 use after frees found with clang ASAN")
>
>
> Would this be ok? Or does John's fix has something else in it (I haven't
> checked).

It is great! This patch is the same as John's except it also removes a
warning that can now no longer happen. As such this patch is the
better and the Fixes is correct.

Thanks,
Ian

> - Arnaldo
