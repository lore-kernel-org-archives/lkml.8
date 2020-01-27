Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA384C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917AF21739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKIlB675"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgA0PlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:41:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26923 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729133AbgA0PlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580139684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KMe88JVc9tII7Am1Y71dlrWYDD8KJ+sccLJZDP0Ma9A=;
        b=NKIlB6757hulJ1Dkv3drMYQWuEMlE4kKkPnGsgCRQ+9yCBZ3u/pas0tplNn9kZgOfJaGan
        rEJ9vNj7WWepC8sQM4uFrbcgt48E/6dqscAxSKMCaLtNj8I5YTn/gNwX5g5RGHgJ3uRbX5
        sfHiQEY0HSDnhymQlxwCEjmFyXeai7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-tohGEYqBN1OjUY8RQUwvfA-1; Mon, 27 Jan 2020 10:41:18 -0500
X-MC-Unique: tohGEYqBN1OjUY8RQUwvfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89F48017CC;
        Mon, 27 Jan 2020 15:41:16 +0000 (UTC)
Received: from krava (ovpn-205-125.brq.redhat.com [10.40.205.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 946FD5C21A;
        Mon, 27 Jan 2020 15:41:13 +0000 (UTC)
Date:   Mon, 27 Jan 2020 16:41:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200127154110.GF1114818@krava>
References: <20200122064721.24276-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122064721.24276-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:17:21PM +0530, Kajol Jain wrote:

SNIP

> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/evlist.h      |  1 +
>  tools/perf/util/metricgroup.c | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> ---
> Changelog:
> v1 -> v2
> - Rather then adding static variable in metricgroup.c,
>   add a new variable in evlist itself with name 'evlist_iter'
> ---
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index f5bd5c386df1..255f872aee92 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -54,6 +54,7 @@ struct evlist {
>  	bool		 enabled;
>  	int		 id_pos;
>  	int		 is_pos;
> +	int		 evlist_iter;
>  	u64		 combined_sample_type;
>  	enum bkw_mmap_state bkw_mmap_state;
>  	struct {
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 02aee946b6c1..911fab4ac04b 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -96,10 +96,13 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>  				      struct evsel **metric_events)
>  {
>  	struct evsel *ev;
> -	int i = 0;
> +	int i = 0, j = 0;
>  	bool leader_found;
>  
>  	evlist__for_each_entry (perf_evlist, ev) {
> +		j++;
> +		if (j <= perf_evlist->evlist_iter)
> +			continue;

hm, but that won't work when event does not match and all
is rolled over in th next condition, no?

how about something like below.. I only checked I got same
results as you did in the changelog, but haven't tested
otherwise.. especially I think that the check I removed
is redundant

could you please also add test for this testcase?

thanks,
jirka


---
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee946b6c1..c12f3efccec8 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -93,13 +93,16 @@ struct egroup {
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
-				      struct evsel **metric_events)
+				      struct evsel **metric_events,
+				      bool used[])
 {
 	struct evsel *ev;
-	int i = 0;
+	int i = 0, j = 0;
 	bool leader_found;
 
 	evlist__for_each_entry (perf_evlist, ev) {
+		if (used[j++])
+			continue;
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
@@ -107,22 +110,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			if (i == idnum)
 				break;
 		} else {
-			if (i + 1 == idnum) {
+			if (i) {
 				/* Discard the whole match and start again */
 				i = 0;
 				memset(metric_events, 0,
 				       sizeof(struct evsel *) * idnum);
-				continue;
-			}
-
-			if (!strcmp(ev->name, ids[i]))
-				metric_events[i] = ev;
-			else {
-				/* Discard the whole match and start again */
-				i = 0;
-				memset(metric_events, 0,
-				       sizeof(struct evsel *) * idnum);
-				continue;
 			}
 		}
 	}
@@ -144,9 +136,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			    !strcmp(ev->name, metric_events[i]->name)) {
 				ev->metric_leader = metric_events[i];
 			}
+			j++;
 		}
+		ev = metric_events[i];
+		used[ev->idx] = true;
 	}
-
 	return metric_events[0];
 }
 
@@ -160,6 +154,9 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int ret = 0;
 	struct egroup *eg;
 	struct evsel *evsel;
+	bool used[perf_evlist->core.nr_entries];
+
+	memset(used, 0, perf_evlist->core.nr_entries);
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
@@ -170,7 +167,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			break;
 		}
 		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
-					 metric_events);
+					 metric_events, used);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);

