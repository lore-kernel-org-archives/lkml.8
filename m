Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967FC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167822076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594912964;
	bh=DwVHfGGJTGv6nAmHEhHPiFSRol8+UO9qWC7oNMEKASg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jGyet58AgAA4E2tgSMyCEVLyTXNUyg8jzF9ta9VqKV3zshRkBYtdrRdgNch45H4tD
	 GzPehB+u9lLWw8lYKmRYHVCiIzrQqE2sJZ0a2HghP7xtrGsNusSlcPE8DfzaxPOskR
	 xnx+khwfdfxTJ78e2oJm8Exhc03fJPSbx/EBTz1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgGPPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgGPPWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:22:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A1A2063A;
        Thu, 16 Jul 2020 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594912959;
        bh=DwVHfGGJTGv6nAmHEhHPiFSRol8+UO9qWC7oNMEKASg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0VJ/hAd4vqcwztpNEBI3+gu2X6XCIMlXEJqmrcrsPfef0Gk2HJlpLz49T9DjFoxT
         afouBzBFOrke2t2bJceDxRxXTSlVVpRIYkoU+JTRDF3J5SLykzFiDnOfOvr/TwiePL
         lQoK62C/7yEmeDabLGtumJMMR8+2ypo8oQbpJ+ds=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 369E4403C7; Thu, 16 Jul 2020 12:22:37 -0300 (-03)
Date:   Thu, 16 Jul 2020 12:22:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
Subject: Re: [PATCH v3 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Message-ID: <20200716152237.GC373728@kernel.org>
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716094216.1418659-1-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 16, 2020 at 03:12:11PM +0530, Kajol Jain escreveu:
> Patchset enhance current runtime parameter support. It introduces new
> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> used to specify perpkg events. 
> 
> The "PerCore" and "PerChip" specifies whether its core or chip events.
> Based on which we can decide which runtime parameter user want to
> access. Now character  '?' can refers different parameter based on user
> requirement.
> 
> Initially, every time we want to add new terms like chip, core, thread
> etc, we need to create corrsponding fields in pmu_events and event
> struct.
> This patchset adds an enum called 'aggr_mode_class' which store all these
> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined. I try to test it with  my current setup.
> 
> I also need to replace PerPkg field to AggregationMode in all the
> x86 uncore json files. It will great if Andi and team can test it
> and let me know if they have any concerns.
> 
> Changelog:
> v2 -> v3:
> - Did some nits changes suggested by Jiri include correction of
>   indentation, and making PerCore/PerChip values forward after
>   PerPkg as 1 in the enum.
> - Rebase the patchset on Arnaldo's tmp.perf/core branch.
> - Change RFC tag

Hey, have anybody provided Acked-by/Reviewed-by for previous revisions
of this patchset? If so you could have collected them for patches
without changes, was that the case?

- Arnaldo
 
> v1 -> v2:
> - Rather then adding new field as PerCore/PerChip, created a new enum
>   to get these fields. And new field as "AggregationMode" which can
>   be used to capture these fields from json file.
>   - Suggested By Ian Rogers
> 
> 
> Kajol Jain (5):
>   perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
>   pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86
>     json files
>   perf jevents: Add support for parsing perchip/percore events
>   perf/tools: Pass pmu_event structure as a parameter for
>     arch_get_runtimeparam
>   perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
> 
>  tools/perf/arch/powerpc/util/header.c         |   7 +-
>  .../arch/powerpc/power9/nest_metrics.json     |  27 +-
>  .../arch/x86/broadwellde/uncore-cache.json    |  62 ++--
>  .../arch/x86/broadwellde/uncore-memory.json   |  18 +-
>  .../arch/x86/broadwellde/uncore-power.json    |  18 +-
>  .../arch/x86/broadwellx/uncore-cache.json     |  62 ++--
>  .../x86/broadwellx/uncore-interconnect.json   |   6 +-
>  .../arch/x86/broadwellx/uncore-memory.json    |  18 +-
>  .../arch/x86/broadwellx/uncore-power.json     |  18 +-
>  .../arch/x86/cascadelakex/uncore-memory.json  |  64 ++--
>  .../arch/x86/cascadelakex/uncore-other.json   | 332 +++++++++---------
>  .../arch/x86/haswellx/uncore-cache.json       |  62 ++--
>  .../x86/haswellx/uncore-interconnect.json     |   6 +-
>  .../arch/x86/haswellx/uncore-memory.json      |  18 +-
>  .../arch/x86/haswellx/uncore-power.json       |  18 +-
>  .../arch/x86/ivytown/uncore-cache.json        |  62 ++--
>  .../arch/x86/ivytown/uncore-interconnect.json |  10 +-
>  .../arch/x86/ivytown/uncore-memory.json       |  16 +-
>  .../arch/x86/ivytown/uncore-power.json        |  52 +--
>  .../arch/x86/jaketown/uncore-cache.json       |  40 +--
>  .../x86/jaketown/uncore-interconnect.json     |  10 +-
>  .../arch/x86/jaketown/uncore-memory.json      |  18 +-
>  .../arch/x86/jaketown/uncore-power.json       |  52 +--
>  .../x86/knightslanding/uncore-memory.json     |   8 +-
>  .../arch/x86/skylakex/uncore-memory.json      |  36 +-
>  .../arch/x86/skylakex/uncore-other.json       | 220 ++++++------
>  .../arch/x86/tremontx/uncore-memory.json      |  14 +-
>  .../arch/x86/tremontx/uncore-other.json       |  70 ++--
>  .../arch/x86/tremontx/uncore-power.json       |   2 +-
>  tools/perf/pmu-events/jevents.c               |  45 ++-
>  tools/perf/pmu-events/jevents.h               |   2 +-
>  tools/perf/pmu-events/pmu-events.h            |   8 +-
>  tools/perf/tests/pmu-events.c                 |   8 +-
>  tools/perf/util/metricgroup.c                 |   5 +-
>  tools/perf/util/metricgroup.h                 |   3 +-
>  tools/perf/util/pmu.c                         |   6 +-
>  36 files changed, 729 insertions(+), 694 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 

- Arnaldo
