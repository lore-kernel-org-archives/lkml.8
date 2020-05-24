Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922D620776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360171;
	bh=BmlR13ZkEYch1vVrkOkI0u57JU/7eL2lZQKglYIqS24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qj2cqPFbXrbuZwJdE/5+LyhO5nRarujk8i+xxMkEtpQYEB7jbGftDW1VJMV0VYIeB
	 fK0CE0gIyZon80Gh5n7M7LTu/Jq+MJEYajZT4Ei6Ea/+Ob2q00DwtZaPx8htGq+Vr7
	 UXNWbUuLrzx5va70UPloBeG8OZIYH1p8BGrsvPAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbgEXWmu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:42:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388521AbgEXWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:49 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-_sMYe6SQPlWCc_nssQ11zw-1; Sun, 24 May 2020 18:42:46 -0400
X-MC-Unique: _sMYe6SQPlWCc_nssQ11zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DB0BFC1;
        Sun, 24 May 2020 22:42:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFEE15D788;
        Sun, 24 May 2020 22:42:42 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/14] perf tools: Factor out parse_groups function
Date:   Mon, 25 May 2020 00:42:12 +0200
Message-Id: <20200524224219.234847-8-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the parse_groups function, it will be used
for new test interface coming in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9e21aa767e41..d72a565ec483 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -709,14 +709,12 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 	}
 }
 
-int metricgroup__parse_groups(const struct option *opt,
-			      const char *str,
-			      bool metric_no_group,
-			      bool metric_no_merge,
-			      struct rblist *metric_events)
+static int parse_groups(struct evlist *perf_evlist, const char *str,
+			bool metric_no_group,
+			bool metric_no_merge,
+			struct rblist *metric_events)
 {
 	struct parse_events_error parse_error;
-	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct strbuf extra_events;
 	LIST_HEAD(group_list);
 	int ret;
@@ -742,6 +740,18 @@ int metricgroup__parse_groups(const struct option *opt,
 	return ret;
 }
 
+int metricgroup__parse_groups(const struct option *opt,
+			      const char *str,
+			      bool metric_no_group,
+			      bool metric_no_merge,
+			      struct rblist *metric_events)
+{
+	struct evlist *perf_evlist = *(struct evlist **)opt->value;
+
+	return parse_groups(perf_evlist, str, metric_no_group,
+			    metric_no_merge, metric_events);
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
-- 
2.25.4

