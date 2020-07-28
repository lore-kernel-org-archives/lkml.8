Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C38C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7C0206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595937747;
	bh=z7dxA462LUJmKJCg4mlS1dCd4LQHrxLL33U5tk+KTEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=codwNhN07uj3HSLKwEcFYbtCREjnaC2xRuxCCRbLe1PAeauhP8dGeC/ir9XULMGlY
	 BMrA40LJWA5t/mTBSz0xIJpUWu4ujiuqEAOQV+KyKjD46heowQ60ZK6cXKhPeXtg4c
	 WKCu96GfpZ/klKJSS/3JaG0d0B/IszPQTNBL+REU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgG1MC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgG1MCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:02:24 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF98206D7;
        Tue, 28 Jul 2020 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595937743;
        bh=z7dxA462LUJmKJCg4mlS1dCd4LQHrxLL33U5tk+KTEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3phOatux/vKD8LZ21wzdt+/+Cdwsmvxttx0oVHFyBWaC4i8Fr4KK36MWB+avrnEO
         AJT8DXTu1gCdIQjHXn2C7vmuTpZL3/hvYMP8oirHnV9qx/wYchc4Liq0XOrXwBotuG
         s1Cixun6RsoAfgZTravgz+2+XWb2P4RLybyMniGI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A875404B1; Tue, 28 Jul 2020 09:02:21 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:02:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Wei Li <liwei391@huawei.com>, leo.yan@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, guohanjun@huawei.com
Subject: Re: [PATCH v2 2/2] perf tools: ARM SPE code cleanup
Message-ID: <20200728120220.GA40195@kernel.org>
References: <20200724071111.35593-1-liwei391@huawei.com>
 <20200724071111.35593-3-liwei391@huawei.com>
 <20200727203436.GC2381376@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727203436.GC2381376@xps15>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 27, 2020 at 02:34:36PM -0600, Mathieu Poirier escreveu:
> On Fri, Jul 24, 2020 at 03:11:11PM +0800, Wei Li wrote:
> > - Firstly, the function auxtrace_record__init() will be invoked only
> >   once, the variable "arm_spe_pmus" will not be used afterwards, thus
> >   we don't need to check "arm_spe_pmus" is NULL or not;
> > - Another reason is, even though SPE is micro-architecture dependent,
> >   but so far it only supports "statistical-profiling-extension-v1" and
> >   we have no chance to use multiple SPE's PMU events in Perf command.
> 
> I find the above changelog somewhat out of touch with the patch itself.  The
> only thing that is happening here is the removal of a useless check and a fix
> for a memory leak.

Humm, I think the original intent of that code was to cache the results
of find_all_arm_spe_pmus(), as the variable it is assigned to is static.

So not a leak, as there was that static reference to it to reuse it
later, but that is strange in a function named "__init()" which usually
is called only once, anyway, so I think that the paragraph with
"Firstly" is kinda ok, but confusing, I think it should read:

- auxtrace_record__init() is called only once, so there is no point in
  using a static variable to cache the results of
  find_all_arm_spe_pmus(), make it local and free the results after use.

The second paragraph is SPE specific, so I'm not qualified to judge on
it.

I'm replacing the first paragraph with the version I wrote and keep it
in my local branch, please holler if you think I misunderstood.

- Arnaldo
 
> Once again whether Arnaldo wants to make the changes by hand or not you may have
> to resubmit.
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> > 
> > So remove the useless check code to make it clear.
> > 
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > ---
> >  tools/perf/arch/arm/util/auxtrace.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > index 28a5d0c18b1d..b187bddbd01a 100644
> > --- a/tools/perf/arch/arm/util/auxtrace.c
> > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > @@ -57,17 +57,15 @@ struct auxtrace_record
> >  	struct evsel *evsel;
> >  	bool found_etm = false;
> >  	struct perf_pmu *found_spe = NULL;
> > -	static struct perf_pmu **arm_spe_pmus = NULL;
> > -	static int nr_spes = 0;
> > +	struct perf_pmu **arm_spe_pmus = NULL;
> > +	int nr_spes = 0;
> >  	int i = 0;
> >  
> >  	if (!evlist)
> >  		return NULL;
> >  
> >  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> > -
> > -	if (!arm_spe_pmus)
> > -		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> > +	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> >  
> >  	evlist__for_each_entry(evlist, evsel) {
> >  		if (cs_etm_pmu &&
> > @@ -84,6 +82,7 @@ struct auxtrace_record
> >  			}
> >  		}
> >  	}
> > +	free(arm_spe_pmus);
> >  
> >  	if (found_etm && found_spe) {
> >  		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
