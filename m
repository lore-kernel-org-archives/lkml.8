Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D08C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82A21973
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgDDImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41734 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDDImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNT-0001I6-2o; Sat, 04 Apr 2020 10:42:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B41ED1C07A5;
        Sat,  4 Apr 2020 10:42:00 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:42:00 -0000
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Cc:     Kajol Jain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200221101121.28920-1-kjain@linux.ibm.com>
References: <20200221101121.28920-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158598972036.28353.16143166623073607650.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     58fc90fda0cc983c11c5290c7a9e992b08ac4a5c
Gitweb:        https://git.kernel.org/tip/58fc90fda0cc983c11c5290c7a9e992b08ac4a5c
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Fri, 21 Feb 2020 15:41:21 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 09:37:27 -03:00

perf metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events

Commit f01642e4912b ("perf metricgroup: Support multiple events for
metricgroup") introduced support for multiple events in a metric group.
But with the current upstream, metric events names are not printed
properly incase we try to run multiple metric groups with overlapping
event.

With current upstream version, incase of overlapping metric events issue
is, we always start our comparision logic from start.  So, the events
which already matched with some metric group also take part in
comparision logic. Because of that when we have overlapping events, we
end up matching current metric group event with already matched one.

For example, in skylake machine we have metric event CoreIPC and
Instructions. Both of them need 'inst_retired.any' event value.  As
events in Instructions is subset of events in CoreIPC, they endup in
pointing to same 'inst_retired.any' value.

In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

     1,254,992,790      inst_retired.any          # 1254992790.0
                                                    Instructions
                                                  #      1.3 CoreIPC
       977,172,805      cycles
     1,254,992,756      inst_retired.any

       1.000802596 seconds time elapsed

command:# sudo ./perf stat -M UPI,IPC sleep 1

   Performance counter stats for 'sleep 1':
           948,650      uops_retired.retire_slots
           866,182      inst_retired.any          #      0.7 IPC
           866,182      inst_retired.any
         1,175,671      cpu_clk_unhalted.thread

Patch fixes the issue by adding a new bool pointer 'evlist_used' to keep
track of events which already matched with some group by setting it
true.  So, we skip all used events in list when we start comparision
logic.  Patch also make some changes in comparision logic, incase we get
a match miss, we discard the whole match and start again with first
event id in metric event.

With this patch:

In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

         3,348,415      inst_retired.any          #      0.3 CoreIPC
        11,779,026      cycles
         3,348,381      inst_retired.any          # 3348381.0
                                                    Instructions

       1.001649056 seconds time elapsed

command:# ./perf stat -M UPI,IPC sleep 1

 Performance counter stats for 'sleep 1':

         1,023,148      uops_retired.retire_slots #      1.1 UPI
           924,976      inst_retired.any
           924,976      inst_retired.any          #      0.6 IPC
         1,489,414      cpu_clk_unhalted.thread

       1.003064672 seconds time elapsed

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200221101121.28920-1-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c3a8c70..926449a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -95,13 +95,16 @@ struct egroup {
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
-				      struct evsel **metric_events)
+				      struct evsel **metric_events,
+				      bool *evlist_used)
 {
 	struct evsel *ev;
-	int i = 0;
+	int i = 0, j = 0;
 	bool leader_found;
 
 	evlist__for_each_entry (perf_evlist, ev) {
+		if (evlist_used[j++])
+			continue;
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
@@ -109,22 +112,17 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			if (i == idnum)
 				break;
 		} else {
-			if (i + 1 == idnum) {
-				/* Discard the whole match and start again */
-				i = 0;
-				memset(metric_events, 0,
-				       sizeof(struct evsel *) * idnum);
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
+			/* Discard the whole match and start again */
+			i = 0;
+			memset(metric_events, 0,
+				sizeof(struct evsel *) * idnum);
+
+			if (!strcmp(ev->name, ids[i])) {
+				if (!metric_events[i])
+					metric_events[i] = ev;
+				i++;
+				if (i == idnum)
+					break;
 			}
 		}
 	}
@@ -146,7 +144,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			    !strcmp(ev->name, metric_events[i]->name)) {
 				ev->metric_leader = metric_events[i];
 			}
+			j++;
 		}
+		ev = metric_events[i];
+		evlist_used[ev->idx] = true;
 	}
 
 	return metric_events[0];
@@ -162,6 +163,13 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int ret = 0;
 	struct egroup *eg;
 	struct evsel *evsel;
+	bool *evlist_used;
+
+	evlist_used = calloc(perf_evlist->core.nr_entries, sizeof(bool));
+	if (!evlist_used) {
+		ret = -ENOMEM;
+		return ret;
+	}
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
@@ -172,7 +180,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			break;
 		}
 		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
-					 metric_events);
+					 metric_events, evlist_used);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
@@ -196,6 +204,9 @@ static int metricgroup__setup_events(struct list_head *groups,
 		expr->metric_events = metric_events;
 		list_add(&expr->nd, &me->head);
 	}
+
+	free(evlist_used);
+
 	return ret;
 }
 
