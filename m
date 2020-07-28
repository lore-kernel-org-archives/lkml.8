Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291BF2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939450;
	bh=43mwNFKrBfQFwNUsRw9YoyEgkUyxlAH9TgQXEewn/wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHE9Fe5vpNfr056AXBPMEyU2DraE4DsK0XWuX6HcnNgebuCrZzHaL6tXx4FUv9BtN
	 utiykRH2WxEQLJoN2ScK+c+pVJmklezgMM5nW0Ij1GgNlXXVIqakM2E1wUJdeYanvv
	 XL3ZdrsETeZEp3727NchxAIOAG9qpHdCKapYW+8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgG1Mat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgG1Mas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:30:48 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A229D206D4;
        Tue, 28 Jul 2020 12:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939447;
        bh=43mwNFKrBfQFwNUsRw9YoyEgkUyxlAH9TgQXEewn/wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbnp72bVK73jHGODCZUJE/GofsNw/M4d/+VmgFLUIqJ2HfWnYhO5Z4NcJC7fwOjYA
         WnI5BbwlvO0/bZX3ipyI5mKzrDDvBV4M75a1vabYSWcnBsLhx2z9AbN3lQp+vBh39o
         ZMo7dCHH8b7JqByYXXnITVgMW5fjGa4eXr/bzD0w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A872404B1; Tue, 28 Jul 2020 09:30:45 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:30:45 -0300
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
Subject: Re: [PATCH 07/19] perf metric: Rename __metricgroup__add_metric to
 __add_metric
Message-ID: <20200728123045.GN40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-8-jolsa@kernel.org>
 <f45b307f-fa85-51db-f71f-3ab0f7aaf4a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f45b307f-fa85-51db-f71f-3ab0f7aaf4a1@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:48:05PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Renaming __metricgroup__add_metric to __add_metric
> > to fit in the current function names.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>
 

Thanks, applied.

- Arnaldo
> Thanks,
> Kajol Jain
> > ---
> >  tools/perf/util/metricgroup.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 4096be7a7a9e..ccd80538a6ae 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -571,10 +571,10 @@ int __weak arch_get_runtimeparam(void)
> >  	return 1;
> >  }
> >  
> > -static int __metricgroup__add_metric(struct list_head *group_list,
> > -				     struct pmu_event *pe,
> > -				     bool metric_no_group,
> > -				     int runtime)
> > +static int __add_metric(struct list_head *group_list,
> > +			struct pmu_event *pe,
> > +			bool metric_no_group,
> > +			int runtime)
> >  {
> >  	struct egroup *eg;
> >  
> > @@ -634,10 +634,7 @@ static int add_metric(struct list_head *group_list,
> >  	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> >  
> >  	if (!strstr(pe->metric_expr, "?")) {
> > -		ret = __metricgroup__add_metric(group_list,
> > -						pe,
> > -						metric_no_group,
> > -						1);
> > +		ret = __add_metric(group_list, pe, metric_no_group, 1);
> >  	} else {
> >  		int j, count;
> >  
> > @@ -649,9 +646,7 @@ static int add_metric(struct list_head *group_list,
> >  		 */
> >  
> >  		for (j = 0; j < count && !ret; j++) {
> > -			ret = __metricgroup__add_metric(
> > -				group_list, pe,
> > -				metric_no_group, j);
> > +			ret = __add_metric(group_list, pe, metric_no_group, j);
> >  		}
> >  	}
> >  
> > 

-- 

- Arnaldo
