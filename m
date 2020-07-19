Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C9FC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B0920684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182437;
	bh=9HXGRo9zVhEipWdy8BGwv1LHFFsLWlJgoHVEcfMVm1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjvOhSnvXbSbqdTuF3XcNkqM84BGEIJzMCmOHlrcistWvQBkh+vYnYGDQoUvYqGWq
	 q8U/9aA+zr1rn0Xc3nLv0M7JZYK912mUSNklrIUaQ3Gk0kGhWINoXCGqkBipd5pS7F
	 3dGqxvF/puCrgOhTLJCmz6ANG7V4C4B82T/jnSKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGSSN4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:13:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726824AbgGSSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:54 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-xHmSve_LOseDeD1dzVAj_g-1; Sun, 19 Jul 2020 14:13:49 -0400
X-MC-Unique: xHmSve_LOseDeD1dzVAj_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2C1B1005504;
        Sun, 19 Jul 2020 18:13:47 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D50EC74F6C;
        Sun, 19 Jul 2020 18:13:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 07/19] perf metric: Rename __metricgroup__add_metric to __add_metric
Date:   Sun, 19 Jul 2020 20:13:08 +0200
Message-Id: <20200719181320.785305-8-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
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

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

