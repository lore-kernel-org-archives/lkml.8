Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E2C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA5522B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fApPH6HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgGTTQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:16:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726899AbgGTTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=udwHk4yQs9a7okbIGNpumR6e7TTud7FzGXDS4QXVwVQ=;
        b=fApPH6HUzbvR2+sEhUBzwOgbRzs3hZ9f6qvPvjEXEVIDEd0IhHXl/Nj3tIS0Eo5sMXEm7o
        qtqUwNuhVJmWtTToX6hovgoszV+3EtMaEiXQ+2aTee7oeFc0xxP1Y96wvvvkQRd+AVB612
        7M/upcJeT3vrOy68vqX5Vt3bkeEdH1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-egiFU7O3Opmkzy7FkJHPUA-1; Mon, 20 Jul 2020 15:16:33 -0400
X-MC-Unique: egiFU7O3Opmkzy7FkJHPUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA65E18C63C1;
        Mon, 20 Jul 2020 19:16:29 +0000 (UTC)
Received: from krava (unknown [10.40.194.11])
        by smtp.corp.redhat.com (Postfix) with SMTP id 193E076114;
        Mon, 20 Jul 2020 19:16:25 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:16:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200720191625.GL760733@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
 <20200720081943.GE760733@krava>
 <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 02:32:40PM +0530, kajoljain wrote:
> 
> 
> On 7/20/20 1:49 PM, Jiri Olsa wrote:
> > On Mon, Jul 20, 2020 at 01:39:24PM +0530, kajoljain wrote:
> > 
> > SNIP
> > 
> >> This is with your perf/metric branch:
> >> command# ./perf stat -M PowerBUS_Frequency -C 0 -I 1000
> >> assertion failed at util/metricgroup.c:709
> >> #           time             counts unit events
> >>      1.000054545          7,807,505      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
> >>      1.000054545          7,807,485      hv_24x7/pm_pb_cyc,chip=1/                                   
> >>      2.000232761          7,807,500      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
> >>      2.000232761          7,807,478      hv_24x7/pm_pb_cyc,chip=1/                                   
> >>      3.000363762          7,799,665      hv_24x7/pm_pb_cyc,chip=0/ #      1.9 GHz  PowerBUS_Frequency_0
> >>      3.000363762          7,807,502      hv_24x7/pm_pb_cyc,chip=1/                                   
> >> ^C     3.259418599          2,022,150      hv_24x7/pm_pb_cyc,chip=0/ #      0.5 GHz  PowerBUS_Frequency_0
> >>      3.259418599          2,022,164      hv_24x7/pm_pb_cyc,chip=1/                                   
> >>
> >>  Performance counter stats for 'CPU(s) 0':
> >>
> >>         25,436,820      hv_24x7/pm_pb_cyc,chip=0/ #      6.4 GHz  PowerBUS_Frequency_0
> >>         25,444,629      hv_24x7/pm_pb_cyc,chip=1/                                   
> >>
> >>        3.259505529 seconds time elapsed
> > 
> > I found the bug, we are not adding runtime metrics as standalone ones,
> > but as referenced metrics.. will fix and try to add test for that
> > 
> > as for testing.. do I need some special ppc server to have support for this? 
> 
> Hi jiri,
>     We need power9 lpar machine and need to make sure `CONFIG_HV_PERF_CTRS` is
> enabled.

could you please try with following patch on top?

thanks,
jirka


---
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6f179b9903a0..03aa4bd4a38b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -820,11 +820,11 @@ static int add_metric(struct list_head *metric_list,
 		      struct expr_id *parent,
 		      struct expr_ids *ids);
 
-static int resolve_metric(struct metric *m,
-			  bool metric_no_group,
-			  struct list_head *metric_list,
-			  struct pmu_events_map *map,
-			  struct expr_ids *ids)
+static int __resolve_metric(struct metric *m,
+			    bool metric_no_group,
+			    struct list_head *metric_list,
+			    struct pmu_events_map *map,
+			    struct expr_ids *ids)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -869,6 +869,23 @@ static int resolve_metric(struct metric *m,
 	return 0;
 }
 
+static int resolve_metric(bool metric_no_group,
+			  struct list_head *metric_list,
+			  struct pmu_events_map *map,
+			  struct expr_ids *ids)
+{
+	struct metric *m;
+	int err;
+
+	list_for_each_entry(m, metric_list, nd) {
+		err = __resolve_metric(m, metric_no_group, metric_list, map, ids);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int add_metric(struct list_head *metric_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
@@ -876,6 +893,7 @@ static int add_metric(struct list_head *metric_list,
 		      struct expr_id *parent,
 		      struct expr_ids *ids)
 {
+	struct metric *orig = *m;
 	int ret = 0;
 
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
@@ -892,7 +910,7 @@ static int add_metric(struct list_head *metric_list,
 		 * those events to metric_list.
 		 */
 
-		for (j = 0; j < count && !ret; j++) {
+		for (j = 0; j < count && !ret; j++, *m = orig) {
 			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
 		}
 	}
@@ -907,8 +925,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 {
 	struct expr_ids ids = { 0 };
+	struct metric *m = NULL;
 	struct pmu_event *pe;
-	struct metric *m;
 	LIST_HEAD(list);
 	int i, ret;
 	bool has_match = false;
@@ -925,7 +943,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		 * Process any possible referenced metrics
 		 * included in the expression.
 		 */
-		ret = resolve_metric(m, metric_no_group,
+		ret = resolve_metric(metric_no_group,
 				     &list, map, &ids);
 		if (ret)
 			return ret;

