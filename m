Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1FC20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597317526;
	bh=7bP+WASRwWMl9CKAiOD+Bh8wlRVHiP3hbBmd+hvq9Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMpyOfjhC76bgfO2F/6uUirQ788SM5D6hVaWnz6hb6qRwN8D1OmI6l1T7YPRz4UpB
	 pkRuTXjr/8BgZvB2+X95z9ZPePkUnz+rkeAECoyMRt08Oo9uAjKUwe6H+SR1roX0eB
	 9iLgyldsb8fFUbBDdL/JfAFALoxJBPcx9RT4WwzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHMLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMLSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:18:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B75F20715;
        Thu, 13 Aug 2020 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597317520;
        bh=7bP+WASRwWMl9CKAiOD+Bh8wlRVHiP3hbBmd+hvq9Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3MYPTLonWpH1ZQAmeKqRJwjvD3JKpPlsR0lU7b6hqk2iIJXj7Ewn3myCzXCWLUTF
         iWHbTlHJUCYuSPKOAbK81QAjkPeTAHFKQmXa5I1M/eb4utd2IOWDRypQC7Xfc8u9NK
         2jbDREpzW6Y8dnCsjtoMFJ5eOY9xATPi+rVVrbgA=
Date:   Thu, 13 Aug 2020 12:18:34 +0100
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        john.garry@huawei.com
Subject: Re: [PATCH v2 0/4] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
Message-ID: <20200813111833.GA10098@willie-the-truck>
References: <20200807071620.11907-1-leo.yan@linaro.org>
 <CANLsYkzR+DSrss0dzPjMPKW+4ZGMbD9V23PLDSZAJM1-SQU0CQ@mail.gmail.com>
 <20200812185334.GN13995@kernel.org>
 <20200813095901.GB9894@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813095901.GB9894@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding John, as I only just realised he wasn't on CC and we were talking
  about him! ]

On Thu, Aug 13, 2020 at 10:59:01AM +0100, Will Deacon wrote:
> On Wed, Aug 12, 2020 at 03:53:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 12, 2020 at 10:06:53AM -0600, Mathieu Poirier escreveu:
> > > The ARM SPE perf tools code is orphan and I don't have the cycles to
> > > pick it up.  Leo has spent a lot of time in that code and as such I
> > > suggest that he starts maintaining it, probably following the same
> > > kind of arrangement you and I have for coresight.
> > 
> > Thats ok with me, I think we should reflect that on the MAINTAINERS
> > file, right?
> > 
> > We have this already:
> > 
> > PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> > R:      John Garry <john.garry@huawei.com>
> > R:      Will Deacon <will@kernel.org>
> > L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > S:      Supported
> > F:      tools/perf/pmu-events/arch/arm64/
> > 
> > I think we should have entries for CoreSight and ARM SPE, one listing
> > you as the maintainer and the other listing Leo, right?
> 
> Fine by me. I'll continue to maintain the in-kernel SPE driver, but I'd love
> to see somebody step up to looking after the userspace code. It's seriously
> unloved on arm64 :(
> 
> I'd even be happy to see one or two M: entries added for
> tools/perf/pmu-events/arch/arm64/. I realistically don't have the time to
> take that on, but I'd be thrilled if any/all of John, Mathieu and Leo were
> to be listed there if they are willing to do so and can spare the time to
> look after it. Even just silly things like making sure the thing
> cross-compiles have been broken in the recent past, so it's not necessarily
> about handling huge amounts of incoming patches.
> 
> In other words, rather than slice up the arm64 parts of the perf tool, I'd
> argue in favour of a joint maintainership model for all the arm64 bits, if
> we have a few willing volunteers.
> 
> Will
