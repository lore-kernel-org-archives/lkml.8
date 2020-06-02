Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441A0206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098679;
	bh=yVj5jOyqy+k9awvUQmSE2PoBLCVE53w9pBWdoJmZUws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4ikaIRpwshzNBOYPSoucOZiOMq2UFKRIdX0GmHuyRcUfpL4KTiVFxe7R4ngHrp/u
	 d1RA+uVW6GGK7hVvh1ThlMx2eiJfT/4vVUrXq+BrTp5bWSAwbKuZulnBo5AFWtcsfX
	 2DZYiHuWItK5cnEaW0QAnRV9pHVBuHGs+ySOPItI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFBLvS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727795AbgFBLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-Ubw32I_2PZqfPDCcwadeZA-1; Tue, 02 Jun 2020 07:51:09 -0400
X-MC-Unique: Ubw32I_2PZqfPDCcwadeZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650FEBFC0;
        Tue,  2 Jun 2020 11:51:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FDAB10013D7;
        Tue,  2 Jun 2020 11:51:04 +0000 (UTC)
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
Subject: [PATCH 03/13] perf tests: Factor check_parse_id function
Date:   Tue,  2 Jun 2020 13:50:45 +0200
Message-Id: <20200602115055.1168446-4-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
References: <20200602115055.1168446-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating the generic part of check_parse_id function,
so it can be used in following changes for the new test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/pmu-events.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 894282be073f..f65380d2066f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -390,9 +390,8 @@ static bool is_number(const char *str)
 	return errno == 0 && end_ptr != str;
 }
 
-static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
+static int check_parse_id(const char *id, struct parse_events_error *error)
 {
-	struct parse_events_error error;
 	struct evlist *evlist;
 	int ret;
 
@@ -401,8 +400,19 @@ static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
 		return 0;
 
 	evlist = evlist__new();
-	memset(&error, 0, sizeof(error));
-	ret = parse_events(evlist, id, &error, false);
+	if (!evlist)
+		return -ENOMEM;
+	memset(error, 0, sizeof(*error));
+	ret = parse_events(evlist, id, error, false);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
+{
+	struct parse_events_error error;
+
+	int ret = check_parse_id(id, &error);
 	if (ret && same_cpu) {
 		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
 			pe->metric_name, id, pe->metric_expr);
@@ -413,7 +423,6 @@ static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
 			  id, pe->metric_name, pe->metric_expr);
 		ret = 0;
 	}
-	evlist__delete(evlist);
 	free(error.str);
 	free(error.help);
 	free(error.first_str);
@@ -474,7 +483,7 @@ static int test_parsing(void)
 				expr__add_id(&ctx, strdup(cur->key), k++);
 
 			hashmap__for_each_entry((&ctx.ids), cur, bkt) {
-				if (check_parse_id(cur->key, map == cpus_map,
+				if (check_parse_cpu(cur->key, map == cpus_map,
 						   pe))
 					ret++;
 			}
-- 
2.25.4

