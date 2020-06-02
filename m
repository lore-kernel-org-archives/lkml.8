Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FAAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A563820772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098703;
	bh=QPvwJBEng8QT+oqHe3Ym/cqMPdcWd4p8VQgTTi85inU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iP8dRpSO/3RNPT6xcS10lhWtQWiD00skylOOKQDw8lfDmPxxqg+LdI9lHt8gNXYQl
	 Bn93+vgNlPDRqZE0YpSS+mdnsbk5MRlJ4W1yf9Pa3OoJyKeocDbbZLC/HmMtiplOTh
	 a6oUH/H82VLfFdJXIaIwPEd3PybYzwoB4wi6HOD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFBLvm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728273AbgFBLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-NNEkWOMfM42oLFXHcpnO8A-1; Tue, 02 Jun 2020 07:51:35 -0400
X-MC-Unique: NNEkWOMfM42oLFXHcpnO8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDCD61800D42;
        Tue,  2 Jun 2020 11:51:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 790DF10013D7;
        Tue,  2 Jun 2020 11:51:31 +0000 (UTC)
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
Subject: [PATCH 13/13] perf tests: Add parse metric test for frontend metric
Date:   Tue,  2 Jun 2020 13:50:55 +0200
Message-Id: <20200602115055.1168446-14-jolsa@kernel.org>
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

Adding new metri test for frontend metric. It's stolen
from x86 pmu events.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 717a73fa7446..1939e567a8b3 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -17,6 +17,11 @@ static struct pmu_event pme_test[] = {
 	.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
 	.metric_name	= "IPC",
 },
+{
+	.metric_expr	= "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
+			  "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
+	.metric_name	= "Frontend_Bound_SMT",
+},
 };
 
 static struct pmu_events_map map = {
@@ -138,8 +143,28 @@ static int test_ipc(void)
 	return 0;
 }
 
+static int test_frontend(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "idq_uops_not_delivered.core",        .val = 300 },
+		{ .event = "cpu_clk_unhalted.thread",            .val = 200 },
+		{ .event = "cpu_clk_unhalted.one_thread_active", .val = 400 },
+		{ .event = "cpu_clk_unhalted.ref_xclk",          .val = 600 },
+		{ 0 },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("Frontend_Bound_SMT", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("Frontend_Bound_SMT failed, wrong ratio",
+			ratio == 0.45);
+	return 0;
+}
+
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
+	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
 	return 0;
 }
-- 
2.25.4

