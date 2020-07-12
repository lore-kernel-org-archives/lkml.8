Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81AC433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B320702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560438;
	bh=BDH3oq/4Oxj9BlUI+hTP+JS4m5d++Q/bVHqNBLLP+7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NdsKv1j0WZKtIMTquxpX2AQGni1M1mJBpdUacG+70TzyihLLUHPkXPMADgd+lC+jx
	 1IuvB0ziDUZZWNWZET384sukrnm/cYOrgnHQkHVbIlh3hsBG/NpuA5zto32LvuPbvn
	 zuk2TAonXaTk+CFy8JARINEuejDjGfVEGznQ44uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgGLN1R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48532 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728962AbgGLN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-XjabLmmhPTucXv677aou0w-1; Sun, 12 Jul 2020 09:27:07 -0400
X-MC-Unique: XjabLmmhPTucXv677aou0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD651009440;
        Sun, 12 Jul 2020 13:27:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A30D71944D;
        Sun, 12 Jul 2020 13:27:02 +0000 (UTC)
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
Subject: [PATCH 08/18] perf metric: Rename __metricgroup__add_metric to __add_metric
Date:   Sun, 12 Jul 2020 15:26:24 +0200
Message-Id: <20200712132634.138901-9-jolsa@kernel.org>
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

Renaming __metricgroup__add_metric to __add_metric
to fit in the current function names.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9a168f3df7a4..f0b0a053bfd2 100644
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
 
@@ -643,10 +643,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __metricgroup__add_metric(group_list,
-						pe,
-						metric_no_group,
-						1);
+		ret = __add_metric(group_list, pe, metric_no_group, 1);
 	} else {
 		int j, count;
 
@@ -658,9 +655,7 @@ static int add_metric(struct list_head *group_list,
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

