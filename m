Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3902078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939903;
	bh=yQekcwP+RJYE+KktmGKnwektbXWPsuCnFIsjKA17590=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jHEt0pDkq1rcpeqLfIZiEqoXPVjIannlDj86HaKKiUtFEoOyPnFnrzIujAHSKBUI5
	 rYhejsH5iraVvtoUY6WGp6m1hcCN4fNyhavB0FEEzowD9MDF8sEX6nmvibNogYvrqe
	 ZOCvUJ5lbCVZBZ7ojBuzzOkF/LHlFyviPaUki+BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgG1MiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgG1MiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:38:21 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD872074F;
        Tue, 28 Jul 2020 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939901;
        bh=yQekcwP+RJYE+KktmGKnwektbXWPsuCnFIsjKA17590=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAhaFoBen5nh0isQ7YwkPxvwFIf4cdavXozGi3BWliA2Z7kjDKTx5sDHZxY0fzr+y
         j3wWiM5GscFqePOb4fDkzICbpUcz8lBEcn72Wwv3Wbat/AKOjf5keX1/fnk/g+W+94
         iwQBTJ5p4mXml3awW38Peu3j3eQ40PALgytt8wmM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F248404B1; Tue, 28 Jul 2020 09:38:18 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:38:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 19/19] perf metric: Rename group_list to metric_list
Message-ID: <20200728123818.GY40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-20-jolsa@kernel.org>
 <edc5dfc3-1fd3-754d-396b-a02601a1f8bd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc5dfc3-1fd3-754d-396b-a02601a1f8bd@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:51:19PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Following the previous change that rename egroup
> > to metric, there's no reason to call the list
> > 'group_list' anymore, renaming it to metric_list.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
 
> Thanks,
> Kajol Jain
> > ---
> >  tools/perf/util/metricgroup.c | 42 +++++++++++++++++------------------
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 9d5fff36042d..6f179b9903a0 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -639,7 +639,7 @@ int __weak arch_get_runtimeparam(void)
> >  	return 1;
> >  }
> >  
> > -static int __add_metric(struct list_head *group_list,
> > +static int __add_metric(struct list_head *metric_list,
> >  			struct pmu_event *pe,
> >  			bool metric_no_group,
> >  			int runtime,
> > @@ -726,13 +726,13 @@ static int __add_metric(struct list_head *group_list,
> >  	if (m->metric_refs_cnt)
> >  		return 0;
> >  
> > -	if (list_empty(group_list))
> > -		list_add(&m->nd, group_list);
> > +	if (list_empty(metric_list))
> > +		list_add(&m->nd, metric_list);
> >  	else {
> >  		struct list_head *pos;
> >  
> >  		/* Place the largest groups at the front. */
> > -		list_for_each_prev(pos, group_list) {
> > +		list_for_each_prev(pos, metric_list) {
> >  			struct metric *old = list_entry(pos, struct metric, nd);
> >  
> >  			if (hashmap__size(&m->pctx.ids) <=
> > @@ -813,7 +813,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
> >  	return p->id ? 0 : -ENOMEM;
> >  }
> >  
> > -static int add_metric(struct list_head *group_list,
> > +static int add_metric(struct list_head *metric_list,
> >  		      struct pmu_event *pe,
> >  		      bool metric_no_group,
> >  		      struct metric **mp,
> > @@ -822,7 +822,7 @@ static int add_metric(struct list_head *group_list,
> >  
> >  static int resolve_metric(struct metric *m,
> >  			  bool metric_no_group,
> > -			  struct list_head *group_list,
> > +			  struct list_head *metric_list,
> >  			  struct pmu_events_map *map,
> >  			  struct expr_ids *ids)
> >  {
> > @@ -854,7 +854,7 @@ static int resolve_metric(struct metric *m,
> >  			expr__del_id(&m->pctx, cur->key);
> >  
> >  			/* ... and it gets resolved to the parent context. */
> > -			ret = add_metric(group_list, pe, metric_no_group, &m, parent, ids);
> > +			ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
> >  			if (ret)
> >  				return ret;
> >  
> > @@ -869,7 +869,7 @@ static int resolve_metric(struct metric *m,
> >  	return 0;
> >  }
> >  
> > -static int add_metric(struct list_head *group_list,
> > +static int add_metric(struct list_head *metric_list,
> >  		      struct pmu_event *pe,
> >  		      bool metric_no_group,
> >  		      struct metric **m,
> > @@ -881,7 +881,7 @@ static int add_metric(struct list_head *group_list,
> >  	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> >  
> >  	if (!strstr(pe->metric_expr, "?")) {
> > -		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent, ids);
> > +		ret = __add_metric(metric_list, pe, metric_no_group, 1, m, parent, ids);
> >  	} else {
> >  		int j, count;
> >  
> > @@ -889,11 +889,11 @@ static int add_metric(struct list_head *group_list,
> >  
> >  		/* This loop is added to create multiple
> >  		 * events depend on count value and add
> > -		 * those events to group_list.
> > +		 * those events to metric_list.
> >  		 */
> >  
> >  		for (j = 0; j < count && !ret; j++) {
> > -			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent, ids);
> > +			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
> >  		}
> >  	}
> >  
> > @@ -902,7 +902,7 @@ static int add_metric(struct list_head *group_list,
> >  
> >  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >  				   struct strbuf *events,
> > -				   struct list_head *group_list,
> > +				   struct list_head *metric_list,
> >  				   struct pmu_events_map *map)
> >  
> >  {
> > @@ -948,14 +948,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >  		}
> >  	}
> >  
> > -	list_splice(&list, group_list);
> > +	list_splice(&list, metric_list);
> >  	expr_ids__exit(&ids);
> >  	return 0;
> >  }
> >  
> >  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
> >  					struct strbuf *events,
> > -					struct list_head *group_list,
> > +					struct list_head *metric_list,
> >  					struct pmu_events_map *map)
> >  {
> >  	char *llist, *nlist, *p;
> > @@ -971,7 +971,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
> >  
> >  	while ((p = strsep(&llist, ",")) != NULL) {
> >  		ret = metricgroup__add_metric(p, metric_no_group, events,
> > -					      group_list, map);
> > +					      metric_list, map);
> >  		if (ret == -EINVAL) {
> >  			fprintf(stderr, "Cannot find metric or group `%s'\n",
> >  					p);
> > @@ -996,11 +996,11 @@ static void metric__free_refs(struct metric *metric)
> >  	}
> >  }
> >  
> > -static void metricgroup__free_metrics(struct list_head *group_list)
> > +static void metricgroup__free_metrics(struct list_head *metric_list)
> >  {
> >  	struct metric *m, *tmp;
> >  
> > -	list_for_each_entry_safe (m, tmp, group_list, nd) {
> > +	list_for_each_entry_safe (m, tmp, metric_list, nd) {
> >  		metric__free_refs(m);
> >  		expr__ctx_clear(&m->pctx);
> >  		list_del_init(&m->nd);
> > @@ -1017,13 +1017,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> >  {
> >  	struct parse_events_error parse_error;
> >  	struct strbuf extra_events;
> > -	LIST_HEAD(group_list);
> > +	LIST_HEAD(metric_list);
> >  	int ret;
> >  
> >  	if (metric_events->nr_entries == 0)
> >  		metricgroup__rblist_init(metric_events);
> >  	ret = metricgroup__add_metric_list(str, metric_no_group,
> > -					   &extra_events, &group_list, map);
> > +					   &extra_events, &metric_list, map);
> >  	if (ret)
> >  		return ret;
> >  	pr_debug("adding %s\n", extra_events.buf);
> > @@ -1034,10 +1034,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> >  		goto out;
> >  	}
> >  	strbuf_release(&extra_events);
> > -	ret = metricgroup__setup_events(&group_list, metric_no_merge,
> > +	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
> >  					perf_evlist, metric_events);
> >  out:
> > -	metricgroup__free_metrics(&group_list);
> > +	metricgroup__free_metrics(&metric_list);
> >  	return ret;
> >  }
> >  
> > 

-- 

- Arnaldo
