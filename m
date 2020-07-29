Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618AAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386EC22BEA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014392;
	bh=v0edAUJ5hKPRf740U7HPAdldSwFnmJb3d7VDP7mkbpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTvP0iuwUEGBG4nDWjjIY7OuWTESKBxE2IzYqEDiqI64zVtTkf+QP8zsyGoq4hnT+
	 XFXbQFV+2W1xrulvdrhUUtlvNtkMTdXeg5Q2/hEAzE/FbqA44AIe/0S1rTNK9BGqNg
	 Af7115MKkfXFhH/8TeTx/b5uuwxBXKiaS2lMyoYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgG2JTv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:19:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727794AbgG2JTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:50 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-a-VYB4izNZa9Cs_YQYPqRA-1; Wed, 29 Jul 2020 05:19:44 -0400
X-MC-Unique: a-VYB4izNZa9Cs_YQYPqRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8020E18C63C0;
        Wed, 29 Jul 2020 09:19:40 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B05B469328;
        Wed, 29 Jul 2020 09:19:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 07/19] perf metric: Rename __metricgroup__add_metric to __add_metric
Date:   Wed, 29 Jul 2020 11:18:56 +0200
Message-Id: <20200729091908.1378911-8-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming __metricgroup__add_metric to __add_metric to fit in the current
function names.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4096be7a7a9e..ccd80538a6ae 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -571,10 +571,10 @@ int __weak arch_get_runtimeparam(void)
 	return 1;
 }
 
-static int __metricgroup__add_metric(struct list_head *group_list,
-				     struct pmu_event *pe,
-				     bool metric_no_group,
-				     int runtime)
+static int __add_metric(struct list_head *group_list,
+			struct pmu_event *pe,
+			bool metric_no_group,
+			int runtime)
 {
 	struct egroup *eg;
 
@@ -634,10 +634,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __metricgroup__add_metric(group_list,
-						pe,
-						metric_no_group,
-						1);
+		ret = __add_metric(group_list, pe, metric_no_group, 1);
 	} else {
 		int j, count;
 
@@ -649,9 +646,7 @@ static int add_metric(struct list_head *group_list,
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __metricgroup__add_metric(
-				group_list, pe,
-				metric_no_group, j);
+			ret = __add_metric(group_list, pe, metric_no_group, j);
 		}
 	}
 
-- 
2.25.4

