Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B80C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F66220725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560457;
	bh=wzG8OKqlOiTPyB+rtJYpxGfo4AxboYoCJhN9z5nq4Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVVf2AWohE9uLO0+BoQeOCzkRoK5rL8ffPSnbYG2gUoQmtSKYi0yhcsITkHr7NZdf
	 OjicnxD2PAxI3F17amUF0xKEiSf965CFePGnnVimVAH7ziGLKXlV3nDKdFCcu0suoq
	 Jv720q3HAicvCKAc1sxoNCUUc72v9zuPOqsC86aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGLN1g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58464 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729014AbgGLN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-rCekTrbHN5i0W6XDnTojmQ-1; Sun, 12 Jul 2020 09:27:23 -0400
X-MC-Unique: rCekTrbHN5i0W6XDnTojmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA6531083;
        Sun, 12 Jul 2020 13:27:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E840D1944D;
        Sun, 12 Jul 2020 13:27:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 13/18] perf metric: Add events for the current group
Date:   Sun, 12 Jul 2020 15:26:29 +0200
Message-Id: <20200712132634.138901-14-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
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

There's no need to iterate the whole list of groups,
when adding new events. The currently created group
is the one we want to add.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8cbcc5e05fef..66f25362702d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -811,17 +811,19 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	if (ret)
 		return ret;
 
-	list_for_each_entry(eg, group_list, nd) {
-		if (events->len > 0)
-			strbuf_addf(events, ",");
+	if (events->len > 0)
+		strbuf_addf(events, ",");
 
-		if (eg->has_constraint) {
-			metricgroup__add_metric_non_group(events,
-							  &eg->pctx);
-		} else {
-			metricgroup__add_metric_weak_group(events,
-							   &eg->pctx);
-		}
+	/*
+	 * Even if we add multiple groups through the runtime
+	 * param, they share same events.
+	 */
+	if (eg->has_constraint) {
+		metricgroup__add_metric_non_group(events,
+						  &eg->pctx);
+	} else {
+		metricgroup__add_metric_weak_group(events,
+						   &eg->pctx);
 	}
 	return 0;
 }
-- 
2.25.4

