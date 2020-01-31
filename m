Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA44C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703C320705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAaFZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:25:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgAaFZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:25:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00V5P1CM064806
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 00:25:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xv7b4ssbc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 00:25:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Fri, 31 Jan 2020 05:25:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 Jan 2020 05:25:35 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00V5PYCk46399490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:25:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB3BCA405C;
        Fri, 31 Jan 2020 05:25:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0AA4A405B;
        Fri, 31 Jan 2020 05:25:31 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.123])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jan 2020 05:25:31 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kjain@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v3] tools/perf/metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events
Date:   Fri, 31 Jan 2020 10:55:22 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013105-0020-0000-0000-000003A5B97C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013105-0021-0000-0000-000021FD71D9
Message-Id: <20200131052522.7267-1-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_09:2020-01-30,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f01642e4912b ("perf metricgroup: Support multiple
events for metricgroup") introduced support for multiple events
in a metric group. But with the current upstream, metric events
names are not printed properly incase we try to run multiple
metric groups with overlapping event.

With current upstream version, incase of overlapping metric events
issue is, we always start our comparision logic from start.
So, the events which already matched with some metric group also
take part in comparision logic. Because of that when we have overlapping
events, we end up matching current metric group event with already matched
one.

For example, in skylake machine we have metric event CoreIPC and
Instructions. Both of them need 'inst_retired.any' event value.
As events in Instructions is subset of events in CoreIPC, they
endup in pointing to same 'inst_retired.any' value.

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

Patch fixes the issue by adding a new array 'evlist_used' to keep track of
events which already matched with some group by setting it true.
So, we skip all used events in list when we start comparision logic.
Patch also make some changes in comparision logic, incase we get a match
miss, we discard the whole match and start again with first event id in
metric event.

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
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 42 +++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

---
Changelog:

v2 -> v3
- Add array in place of variable to keep track of matched events.
  Because incase we miss match in previous approach, all events will
  be rolled over in next condition. So, rather we add array and set  
  it incase that variable already match with some group.
  - Suggested by Jiri Olsa

v1 -> v2
- Rather then adding static variable in metricgroup.c,
  add a new variable in evlist itself with name 'evlist_iter'
---
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee946b6c1..e9d9fbaa2160 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -93,13 +93,16 @@ struct egroup {
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
-				      struct evsel **metric_events)
+				      struct evsel **metric_events,
+				      bool evlist_used[])
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
@@ -107,22 +110,17 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
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
@@ -144,7 +142,10 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			    !strcmp(ev->name, metric_events[i]->name)) {
 				ev->metric_leader = metric_events[i];
 			}
+			j++;
 		}
+		ev = metric_events[i];
+		evlist_used[ev->idx] = true;
 	}
 
 	return metric_events[0];
@@ -160,6 +161,9 @@ static int metricgroup__setup_events(struct list_head *groups,
 	int ret = 0;
 	struct egroup *eg;
 	struct evsel *evsel;
+	bool evlist_used[perf_evlist->core.nr_entries];
+
+	memset(evlist_used, 0, perf_evlist->core.nr_entries);
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
@@ -170,7 +174,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			break;
 		}
 		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
-					 metric_events);
+					 metric_events, evlist_used);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
-- 
2.21.0

