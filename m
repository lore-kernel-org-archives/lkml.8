Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50518C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15563207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597323933;
	bh=kfSetElbgMBkxQZyL22p71hAbVs3OEvthsPtbsTmWlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=10841bZsTiFSxIQRjRQGj2WfAxB9lWlFfEEyn49gDLkhSDd9brTrt+pTdVD4E7stk
	 w9SX7fWrSwp4FzpKs0eFJkUPCI/mVEbKOwrEC8IOaEh0sjl5AHOMK8SGTxeAwa3vVY
	 JjqbPm8/WJ06h05ikc3OuE+RvTNOtFcUOZZsQFD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHMNFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMNF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:05:27 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A8B20716;
        Thu, 13 Aug 2020 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597323926;
        bh=kfSetElbgMBkxQZyL22p71hAbVs3OEvthsPtbsTmWlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGHiRHWPoQ+X3V9EWI27sXGyOhvvVbZy379cWFKIqyHjTRt/9EVG4VDx43F//eSly
         msREHGzF+nV4mjmvgPpFUNK8uNRCaJEjxkPlOop+E38sHkH7EfUDhvgP+DUrqcAKTG
         m2GGX4w1Xmo8DMGLlMw8JMVmdItSJl9D7Jhl2kfg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 591F64097F; Thu, 13 Aug 2020 10:05:23 -0300 (-03)
Date:   Thu, 13 Aug 2020 10:05:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
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
Message-ID: <20200813130523.GR13995@kernel.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
 <20200812185334.GN13995@kernel.org>
 <20200813095901.GB9894@willie-the-truck>
 <20200813111833.GA10098@willie-the-truck>
 <f3cbe339-0daa-054b-4c28-d8f130206a44@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3cbe339-0daa-054b-4c28-d8f130206a44@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 13, 2020 at 01:08:02PM +0100, John Garry escreveu:
> On 13/08/2020 12:18, Will Deacon wrote:
> > [ Adding John, as I only just realised he wasn't on CC and we were talking
> >    about him! ]
> > 
> > On Thu, Aug 13, 2020 at 10:59:01AM +0100, Will Deacon wrote:
> > > On Wed, Aug 12, 2020 at 03:53:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
> > > > > The ARM SPE perf tools code is orphan and I don't have the cycles to
> > > > > pick it up.  Leo has spent a lot of time in that code and as such I
> > > > > suggest that he starts maintaining it, probably following the same
> > > > > kind of arrangement you and I have for coresight.
> > > > 
> > > > Thats ok with me, I think we should reflect that on the MAINTAINERS
> > > > file, right?
> > > > 
> > > > We have this already:
> > > > 
> > > > PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> > > > R:      John Garry <john.garry@huawei.com>
> > > > R:      Will Deacon <will@kernel.org>
> > > > L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > > S:      Supported
> > > > F:      tools/perf/pmu-events/arch/arm64/
> > > > 
> > > > I think we should have entries for CoreSight and ARM SPE, one listing
> > > > you as the maintainer and the other listing Leo, right?
> > > 
> > > Fine by me. I'll continue to maintain the in-kernel SPE driver, but I'd love
> > > to see somebody step up to looking after the userspace code. It's seriously
> > > unloved on arm64 :(
> > > 
> > > I'd even be happy to see one or two M: entries added for
> > > tools/perf/pmu-events/arch/arm64/. I realistically don't have the time to
> > > take that on, but I'd be thrilled if any/all of John, Mathieu and Leo were
> > > to be listed there if they are willing to do so and can spare the time to
> > > look after it. Even just silly things like making sure the thing
> > > cross-compiles have been broken in the recent past, so it's not necessarily
> > > about handling huge amounts of incoming patches.
> > > 
> > > In other words, rather than slice up the arm64 parts of the perf tool, I'd
> > > argue in favour of a joint maintainership model for all the arm64 bits, if
> > > we have a few willing volunteers.
> 
> Right, it makes sense not to chop up too much, so happy to see "PERFORMANCE
> EVENTS SUBSYSTEM ARM64 PMU EVENTS" expanded in terms of scope and
> membership.

Discuss this as long as you need and then send me a patch for the
MAINTAINERS file with your conclusion.

Great to see this happening,

- Arnaldo
