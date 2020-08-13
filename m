Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C062C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166E620768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597312759;
	bh=9uAcNPLQMMfdhu1kSoheqUccrUp42qpRd1/Qp3sSzQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bsj7sD+M8/EACaua3M1Wxu8U5MvMZisMJ23lcQxLzYc7+abKBiQ4kE4ok99b3ZT2D
	 yE67pEu1Mv53cAP64OgyXeWZZq/CjrOWDkYuUL64wSu5YKjfwzje7mRyV+swsHFkkW
	 yvWmeg/kiVCa/SU1vo7ZBHe6hgZcu5YZKB9RSu9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMJ7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJ7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:59:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938CC206A4;
        Thu, 13 Aug 2020 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597312747;
        bh=9uAcNPLQMMfdhu1kSoheqUccrUp42qpRd1/Qp3sSzQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GagChgLtqAYBIup9XZ+sXs8Rq9Lxj2FTlmGNNR1/+/+EaTc8FVxYmdrk4SHzk+VRh
         rQ5m1kNzK10OFoX+udpztvdkQDxQveQ8XjvrH1bJP3PhZEW93FY7l1FVdczixNwzpO
         X+x24i/RXaSKJ7f+rbqTX70KaHSIURyYbwj1rVKo=
Date:   Thu, 13 Aug 2020 10:59:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
Message-ID: <20200813095901.GB9894@willie-the-truck>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
 <20200812185334.GN13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812185334.GN13995@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 03:53:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
> > On Fri, 7 Aug 2020 at 01:16, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > This patch set is to enable Arm arch timer counter and Arm SPE is the
> > > first customer to use arch timer counter for its timestamp.
> > >
> > > Patches 01 ~ 03 enables Arm arch timer counter in Perf tool; patch 01 is
> > > to retrieve arch timer's parameters from mmaped page; patch 02 provides
> > > APIs for the conversion between arch timer's counter and time; patch 03
> > > adds a test for patches 01 and 02.
> > >
> > > As the first customer to use Arm arch timer counter in perf tool, patch
> > > 04 is to generate sample's timestamp for ARM SPE AUX trace data.
> > >
> > > This patch set has been rebased on perf/core branch with the latest
> > > commit c4735d990268 ("perf evsel: Don't set
> > > sample_regs_intr/sample_regs_user for dummy event").
> > 
> > The ARM SPE perf tools code is orphan and I don't have the cycles to
> > pick it up.  Leo has spent a lot of time in that code and as such I
> > suggest that he starts maintaining it, probably following the same
> > kind of arrangement you and I have for coresight.
> 
> Thats ok with me, I think we should reflect that on the MAINTAINERS
> file, right?
> 
> We have this already:
> 
> PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> R:      John Garry <john.garry@huawei.com>
> R:      Will Deacon <will@kernel.org>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Supported
> F:      tools/perf/pmu-events/arch/arm64/
> 
> I think we should have entries for CoreSight and ARM SPE, one listing
> you as the maintainer and the other listing Leo, right?

Fine by me. I'll continue to maintain the in-kernel SPE driver, but I'd love
to see somebody step up to looking after the userspace code. It's seriously
unloved on arm64 :(

I'd even be happy to see one or two M: entries added for
tools/perf/pmu-events/arch/arm64/. I realistically don't have the time to
take that on, but I'd be thrilled if any/all of John, Mathieu and Leo were
to be listed there if they are willing to do so and can spare the time to
look after it. Even just silly things like making sure the thing
cross-compiles have been broken in the recent past, so it's not necessarily
about handling huge amounts of incoming patches.

In other words, rather than slice up the arm64 parts of the perf tool, I'd
argue in favour of a joint maintainership model for all the arm64 bits, if
we have a few willing volunteers.

Will
