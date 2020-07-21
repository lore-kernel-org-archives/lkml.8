Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BC022482
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jcikc/I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgGUJni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:43:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8EBC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TRTMDDFEgrmSAnZpI2Hc+5uHBWK5HET4nVD4hrtfBVI=; b=jcikc/I7T0xy3tl9ihui+RH/D5
        qNAGWlagLfD2J8uG+IqFIdX7HaK8hQAbQ+BbQsbJlddZVYVi43hbFeH3ekQvF1D+3skLa+/D1/RXE
        g1A+BadqhMjv3qVFHyN2kQ8VggArBf6Xg3cYsywu7YcYOthL9032ub9t8dD992ae79PGUwpXBjAzO
        zYG7vj4IZVyyWIEyTijon7qNNcGrTeypj7/FGGel2yy2z2CmBXCSNlcnQqv1wny/093kPRBpNOxf2
        Afn78Y/EuIf73L9I+K07/Y/48siYWlUaRlDIIssLoQT1fUvXbIS2b6nSpjoSqW2PJG1ySblwpeA0/
        0KwDG6XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxoo5-0000hr-Io; Tue, 21 Jul 2020 09:43:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FC86304E03;
        Tue, 21 Jul 2020 11:43:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B8002025C12F; Tue, 21 Jul 2020 11:43:28 +0200 (CEST)
Date:   Tue, 21 Jul 2020 11:43:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 07/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
Message-ID: <20200721094327.GW10769@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717140554.22863-8-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:05:47AM -0700, kan.liang@linux.intel.com wrote:
> @@ -1031,6 +1034,35 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>  	return unsched ? -EINVAL : 0;
>  }
>  
> +static int add_nr_metric_event(struct cpu_hw_events *cpuc,
> +			       struct perf_event *event,
> +			       int *max_count, bool sibling)
> +{
> +	/* The TopDown metrics events cannot be shared. */
> +	if (is_metric_event(event) &&
> +	    (++cpuc->n_metric_event > INTEL_TD_METRIC_NUM)) {
> +		cpuc->n_metric_event--;
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Take the accepted metrics events into account for leader event.
> +	 */
> +	if (!sibling)
> +		*max_count += cpuc->n_metric_event;
> +	else if (is_metric_event(event))
> +		(*max_count)++;
> +
> +	return 0;
> +}
> +
> +static void del_nr_metric_event(struct cpu_hw_events *cpuc,
> +				struct perf_event *event)
> +{
> +	if (is_metric_event(event))
> +		cpuc->n_metric_event--;
> +}
> +
>  /*
>   * dogrp: true if must collect siblings events (group)
>   * returns total number of events and error code
> @@ -1066,6 +1098,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>  		cpuc->pebs_output = is_pebs_pt(leader) + 1;
>  	}
>  
> +	if (x86_pmu.intel_cap.perf_metrics &&
> +	    add_nr_metric_event(cpuc, leader, &max_count, false))
> +		return -EINVAL;
> +
>  	if (is_x86_event(leader)) {
>  		if (n >= max_count)
>  			return -EINVAL;
> @@ -1082,6 +1118,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>  		    event->state <= PERF_EVENT_STATE_OFF)
>  			continue;
>  
> +		if (x86_pmu.intel_cap.perf_metrics &&
> +		    add_nr_metric_event(cpuc, event, &max_count, true))
> +			return -EINVAL;
> +
>  		if (n >= max_count)
>  			return -EINVAL;
>  

Something like so perhaps ?

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1035,24 +1035,14 @@ int x86_schedule_events(struct cpu_hw_ev
 }
 
 static int add_nr_metric_event(struct cpu_hw_events *cpuc,
-			       struct perf_event *event,
-			       int *max_count, bool sibling)
+			       struct perf_event *event)
 {
-	/* The TopDown metrics events cannot be shared. */
-	if (is_metric_event(event) &&
-	    (++cpuc->n_metric_event > INTEL_TD_METRIC_NUM)) {
-		cpuc->n_metric_event--;
-		return -EINVAL;
+	if (is_metric_event(event)) {
+		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
+			return -EINVAL;
+		cpuc->n_metric++;
 	}
 
-	/*
-	 * Take the accepted metrics events into account for leader event.
-	 */
-	if (!sibling)
-		*max_count += cpuc->n_metric_event;
-	else if (is_metric_event(event))
-		(*max_count)++;
-
 	return 0;
 }
 
@@ -1060,7 +1050,24 @@ static void del_nr_metric_event(struct c
 				struct perf_event *event)
 {
 	if (is_metric_event(event))
-		cpuc->n_metric_event--;
+		cpuc->n_metric--;
+}
+
+static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
+			 int max_count, int n)
+{
+
+	if (x86_pmu.intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
+		return -EINVAL;
+
+	if (n >= max_count + cpuc->n_metric)
+		return -EINVAL;
+
+	cpuc->event_list[n] = event;
+	if (is_counter_pair(&event->hw))
+		cpuc->n_pair++;
+
+	return 0;
 }
 
 /*
@@ -1098,37 +1105,20 @@ static int collect_events(struct cpu_hw_
 		cpuc->pebs_output = is_pebs_pt(leader) + 1;
 	}
 
-	if (x86_pmu.intel_cap.perf_metrics &&
-	    add_nr_metric_event(cpuc, leader, &max_count, false))
+	if (is_x86_event(leader) && collect_event(cpuc, leader, max_count, n))
 		return -EINVAL;
+	n++;
 
-	if (is_x86_event(leader)) {
-		if (n >= max_count)
-			return -EINVAL;
-		cpuc->event_list[n] = leader;
-		n++;
-		if (is_counter_pair(&leader->hw))
-			cpuc->n_pair++;
-	}
 	if (!dogrp)
 		return n;
 
 	for_each_sibling_event(event, leader) {
-		if (!is_x86_event(event) ||
-		    event->state <= PERF_EVENT_STATE_OFF)
+		if (!is_x86_event(event) || event->state <= PERF_EVENT_STATE_OFF)
 			continue;
 
-		if (x86_pmu.intel_cap.perf_metrics &&
-		    add_nr_metric_event(cpuc, event, &max_count, true))
-			return -EINVAL;
-
-		if (n >= max_count)
+		if (collect_event(cpuc, event, max_count, n))
 			return -EINVAL;
-
-		cpuc->event_list[n] = event;
 		n++;
-		if (is_counter_pair(&event->hw))
-			cpuc->n_pair++;
 	}
 	return n;
 }
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -313,7 +313,7 @@ struct cpu_hw_events {
 	 * Perf Metrics
 	 */
 	/* number of accepted metrics events */
-	int				n_metric_event;
+	int				n_metric;
 
 	/*
 	 * AMD specific bits
