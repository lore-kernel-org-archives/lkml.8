Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68430C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBD920752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480803;
	bh=m0xo/W6GOQNpk/WU67K9ND/4DuO1vrli3QMy0AnI3rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VqIjWPDnaR61/jwGHL4CzIvZdBhIkVtznMIuCKhseaSs1+mrqM02Uttwi+K7jx6SR
	 OQVieVVxRmGHWG8h2erGas//BERjPAFYfAmSjCzRWrlio/26HlLsG9MsulgNrJYKXp
	 k3XDIJ1mUvPgU/K8CydUflOI1HN2Vp7GqQtLqUjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCQVdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgCQVdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:33:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F1020768;
        Tue, 17 Mar 2020 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480799;
        bh=m0xo/W6GOQNpk/WU67K9ND/4DuO1vrli3QMy0AnI3rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVjthmkeUp+Npw2YbI/EIWB5YPh/7mToFSe/G2yGuui/wxNHiTJl/PjoLVr8yQtET
         HrFpINaq+LT/duio+1JrdHN5V1hslfiavNr/7tcoqmlYcfsoakxRchtT9SzcY6jBCb
         DSBwOgLzjLLZq3nxZ4SG0rXWfMIJXYLlBZVtwbcY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/23] perf metricgroup: Factor out metricgroup__add_metric_weak_group()
Date:   Tue, 17 Mar 2020 18:32:39 -0300
Message-Id: <20200317213259.15494-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Factor out metricgroup__add_metric_weak_group() which add metrics into a
weak group. The change can improve code readability. Because following
patch will introduce a function which add standalone metrics.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 57 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee946b6c1..1cd042cb262e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -399,13 +399,42 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	strlist__delete(metriclist);
 }
 
+static void metricgroup__add_metric_weak_group(struct strbuf *events,
+					       const char **ids,
+					       int idnum)
+{
+	bool no_group = false;
+	int i;
+
+	for (i = 0; i < idnum; i++) {
+		pr_debug("found event %s\n", ids[i]);
+		/*
+		 * Duration time maps to a software event and can make
+		 * groups not count. Always use it outside a
+		 * group.
+		 */
+		if (!strcmp(ids[i], "duration_time")) {
+			if (i > 0)
+				strbuf_addf(events, "}:W,");
+			strbuf_addf(events, "duration_time");
+			no_group = true;
+			continue;
+		}
+		strbuf_addf(events, "%s%s",
+			i == 0 || no_group ? "{" : ",",
+			ids[i]);
+		no_group = false;
+	}
+	if (!no_group)
+		strbuf_addf(events, "}:W");
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
-	int ret = -EINVAL;
-	int i, j;
+	int i, ret = -EINVAL;
 
 	if (!map)
 		return 0;
@@ -422,7 +451,6 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			const char **ids;
 			int idnum;
 			struct egroup *eg;
-			bool no_group = false;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
@@ -431,27 +459,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				continue;
 			if (events->len > 0)
 				strbuf_addf(events, ",");
-			for (j = 0; j < idnum; j++) {
-				pr_debug("found event %s\n", ids[j]);
-				/*
-				 * Duration time maps to a software event and can make
-				 * groups not count. Always use it outside a
-				 * group.
-				 */
-				if (!strcmp(ids[j], "duration_time")) {
-					if (j > 0)
-						strbuf_addf(events, "}:W,");
-					strbuf_addf(events, "duration_time");
-					no_group = true;
-					continue;
-				}
-				strbuf_addf(events, "%s%s",
-					j == 0 || no_group ? "{" : ",",
-					ids[j]);
-				no_group = false;
-			}
-			if (!no_group)
-				strbuf_addf(events, "}:W");
+
+			metricgroup__add_metric_weak_group(events, ids, idnum);
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
-- 
2.21.1

