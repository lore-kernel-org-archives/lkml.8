Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD50DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876672070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939421;
	bh=v8OyGHvwcaVwQUPlpZODqMKib42pN567OiPyFaDNYHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/KbDNsqGBwK0//SH1ZQus4QMFG9NddLUJhsMdYcMaH5QU2fbkVRdgHayBVCnyMgn
	 O9GyRkDHJU47xewNcMRUmVK2o9Lj8XRolGpt0dCnEauW+ZD1aBvcD6FRdeDDWeUDIm
	 OIPcB9bnlIS4j9L/2k1LuJu912pOCNeyYLBHyakU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgG1MaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbgG1MaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:30:18 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682F8206D4;
        Tue, 28 Jul 2020 12:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939417;
        bh=v8OyGHvwcaVwQUPlpZODqMKib42pN567OiPyFaDNYHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StaZaT/YPoK3hQtS6jjRHtHvDsufAx+6TCFL5iCRJvEu7qEP3i0qx+zPMLdpuGibY
         LlagSnbqiIjBA7Ck1GrHNUpY4CilLGLtZdMVi/E71wIxAiKtrpBmR4e6M90hYXUV7p
         gRaDD0NPN4SnxO9NUqVSXTC0sxl6oA75adpZbPQY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7865B404B1; Tue, 28 Jul 2020 09:30:15 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:30:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 06/19] perf metric: Add add_metric function
Message-ID: <20200728123015.GM40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-7-jolsa@kernel.org>
 <f1b7bcb2-2dda-2ff8-79fa-62c831ba0d61@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b7bcb2-2dda-2ff8-79fa-62c831ba0d61@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:47:53PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Decouple metric adding logging into add_metric function,
> > so it can be used from other places in following changes.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> >  tools/perf/util/metricgroup.c | 62 ++++++++++++++++++++---------------
> >  1 file changed, 36 insertions(+), 26 deletions(-)
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index b37008fc253c..4096be7a7a9e 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -625,6 +625,39 @@ static int __metricgroup__add_metric(struct list_head *group_list,
> >  		    (match_metric(__pe->metric_group, __metric) ||	\
> >  		     match_metric(__pe->metric_name, __metric)))
> >  
> > +static int add_metric(struct list_head *group_list,
> > +		      struct pmu_event *pe,
> > +		      bool metric_no_group)
> > +{
> > +	int ret = 0;
> > +
> > +	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> > +
> > +	if (!strstr(pe->metric_expr, "?")) {
> > +		ret = __metricgroup__add_metric(group_list,
> > +						pe,
> > +						metric_no_group,
> > +						1);
> > +	} else {
> > +		int j, count;
> > +
> > +		count = arch_get_runtimeparam();
> > +
> > +		/* This loop is added to create multiple
> > +		 * events depend on count value and add
> > +		 * those events to group_list.
> > +		 */
> > +
> > +		for (j = 0; j < count && !ret; j++) {
> > +			ret = __metricgroup__add_metric(
> > +				group_list, pe,
> > +				metric_no_group, j);
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >  				   struct strbuf *events,
> >  				   struct list_head *group_list,
> > @@ -636,34 +669,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >  	bool has_match = false;
> >  
> >  	map_for_each_metric(pe, i, map, metric) {
> > -		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> >  		has_match = true;
> >  
> > -		if (!strstr(pe->metric_expr, "?")) {
> > -			ret = __metricgroup__add_metric(group_list,
> > -							pe,
> > -							metric_no_group,
> > -							1);
> > -			if (ret)
> > -				return ret;
> > -		} else {
> > -			int j, count;
> > -
> > -			count = arch_get_runtimeparam();
> > -
> > -			/* This loop is added to create multiple
> > -			 * events depend on count value and add
> > -			 * those events to group_list.
> > -			 */
> > -
> > -			for (j = 0; j < count; j++) {
> > -				ret = __metricgroup__add_metric(
> > -					group_list, pe,
> > -					metric_no_group, j);
> > -				if (ret)
> > -					return ret;
> > -			}
> > -		}
> > +		ret = add_metric(group_list, pe, metric_no_group);
> > +		if (ret)
> > +			return ret;
> >  	}
> >  
> >  	/* End of pmu events. */
> > 

-- 

- Arnaldo
