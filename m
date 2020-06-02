Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83143C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D28B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098711;
	bh=VReR2drN6y4SKBN7oAEp/cWOpf7CudZ0lVum8txk9L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O43/IJI0hYks44nDH0TjCNVk1JZGjduPm8ulG1xsRrM5KeBtDXxv+OlJqO4CT5HM+
	 nkkzv1xQ+xApIjj/9vvQw8WOugsA8soJTkmTnwyZf5guyZptzQhJESHCFYy1UI2WF8
	 lhXgdYftaTogDawXR36xWvYtOFYYRk/srjlgJyQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgFBLvu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728170AbgFBLvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-AzP_FFAjPiWdXO7c3OwAMg-1; Tue, 02 Jun 2020 07:51:27 -0400
X-MC-Unique: AzP_FFAjPiWdXO7c3OwAMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59281030980;
        Tue,  2 Jun 2020 11:51:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 911A210013D7;
        Tue,  2 Jun 2020 11:51:23 +0000 (UTC)
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
Subject: [PATCH 10/13] perf tools: Release metric_events rblist
Date:   Tue,  2 Jun 2020 13:50:52 +0200
Message-Id: <20200602115055.1168446-11-jolsa@kernel.org>
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

We don't release metric_events rblist, add the missing
delete hook and call the release before leaving cmd_stat.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c     |  1 +
 tools/perf/util/metricgroup.c | 19 +++++++++++++++++++
 tools/perf/util/metricgroup.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a0c470dd92b..6d45b9783b73 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2252,6 +2252,7 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__delete(evsel_list);
 
+	metricgroup__rblist_exit(&stat_config.metric_events);
 	runtime_stat_delete(&stat_config);
 
 	return status;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fe33fee7f6ad..1b80a7901388 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -76,11 +76,30 @@ static struct rb_node *metric_event_new(struct rblist *rblist __maybe_unused,
 	return &me->nd;
 }
 
+static void metric_event_delete(struct rblist *rblist __maybe_unused,
+				struct rb_node *rb_node)
+{
+	struct metric_event *me = container_of(rb_node, struct metric_event, nd);
+	struct metric_expr *expr, *tmp;
+
+	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
+		free(expr);
+	}
+
+	free(me);
+}
+
 static void metricgroup__rblist_init(struct rblist *metric_events)
 {
 	rblist__init(metric_events);
 	metric_events->node_cmp = metric_event_cmp;
 	metric_events->node_new = metric_event_new;
+	metric_events->node_delete = metric_event_delete;
+}
+
+void metricgroup__rblist_exit(struct rblist *metric_events)
+{
+	rblist__exit(metric_events);
 }
 
 struct egroup {
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 426c824e20bf..8315bd1a7da4 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -47,4 +47,5 @@ void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
 int arch_get_runtimeparam(void);
+void metricgroup__rblist_exit(struct rblist *metric_events);
 #endif
-- 
2.25.4

