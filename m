Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC3B2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598972025;
	bh=HpWZik1j9+sfkS0/wxDG2E/McFvOr29VTlfELilXyDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u5nnMndLT1bbnW1oLT2fL1+D6w8/71ELOpnRhLjDn4OOQlbjVYywJfPn2GHXq2bKn
	 3o4tv598ccGul+x6AQztXy3CUwTVfLc29Gql3PeBWGB/SWLcfTqvf2PRIrh8ftEk0M
	 POmRlT8eMntbv9HtkM+nVlQUNBiEhFc0LmMyn0nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgIAOxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgIAOxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:53:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF05B206FA;
        Tue,  1 Sep 2020 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598972014;
        bh=HpWZik1j9+sfkS0/wxDG2E/McFvOr29VTlfELilXyDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2M6tw5X2FLoO+ZaIl4ZPFNPkHUGNWOZL/zyWY1eneiNGh28OmxjMRbVMiAcof+Vu
         soAAVcPhNf9jBLHjBnIkLm7/FpfSyEQbLb5MSfeXD1GZDCA9LOU6C50kbyo4bVmRds
         gUQavtUt0yb/rahYnLHiF2bYNhddSHACmA+oW5A4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4446840D3D; Tue,  1 Sep 2020 11:53:31 -0300 (-03)
Date:   Tue, 1 Sep 2020 11:53:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AAl Grant <al.grant@arm.com>
Subject: Re: [PATCH 2/2] perf intel-pt: Fix corrupt data after perf inject
 from
Message-ID: <20200901145331.GA1422817@kernel.org>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200819084751.17686-2-leo.yan@linaro.org>
 <20200831203832.GA120995@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831203832.GA120995@xps15>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 31, 2020 at 02:38:32PM -0600, Mathieu Poirier escreveu:
> On Wed, Aug 19, 2020 at 04:47:51PM +0800, Leo Yan wrote:
> > From: Al Grant <al.grant@arm.com>
> > 
> > Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > changed the format of branch stacks in perf samples. When samples use
> > this new format, a flag must be set in the corresponding event.
> > Synthesized branch stacks generated from Intel PT were using the new
> > format, but not setting the event attribute, leading to consumers
> > seeing corrupt data. This patch fixes the issue by setting the event
> > attribute to indicate use of the new format.
> > 
> > Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> > Signed-off-by: Al Grant <al.grant@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Arnaldo, please consider.
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied, and 1/2 too.

- Arnaldo
 
> > ---
> >  tools/perf/util/intel-pt.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index 2a8d245351e7..0af4e81c46e2 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -3017,8 +3017,15 @@ static int intel_pt_synth_events(struct intel_pt *pt,
> >  
> >  	if (pt->synth_opts.callchain)
> >  		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
> > -	if (pt->synth_opts.last_branch)
> > +	if (pt->synth_opts.last_branch) {
> >  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> > +		/*
> > +		 * We don't use the hardware index, but the sample generation
> > +		 * code uses the new format branch_stack with this field,
> > +		 * so the event attributes must indicate that it's present.
> > +		 */
> > +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> > +	}
> >  
> >  	if (pt->synth_opts.instructions) {
> >  		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
