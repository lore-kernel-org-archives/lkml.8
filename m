Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AE5C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC212087C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o/3H6u3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgIFLXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:23:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728704AbgIFLVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:21:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 086B2AP3120890;
        Sun, 6 Sep 2020 07:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hPwyMlvvmBwMzPPXtaOo1sxMfBSLRdWeG1Pej1RHa9Q=;
 b=o/3H6u3hvyObqS/4OGoqyZzUADcchYCx0NHp5v5c/5N2zmU/XHXYIsQNfjjLD16eN9ai
 bok5z8ZEpwuIWGOsRzY9UhZI1WpnwqRPsGSYDNJgFNA+aDXFKrGo8YYeHTfI0UgtgP7L
 jEjZBTU97lr1dj+c5m/sQxnYdtjIv7bEEIAVnqmYfuiFMPF9N7kDFn2NCkp+Y06BfC1f
 XhitPpmhrpmgcgO5RyB2T5ppjm/ppIK9b5jZy+dmRbZP1lQNmhSv2hck+/Y+WiP/ZIHk
 83wWEbPMo+jrFXc39GBaRu5ByfcTH3DSzztr/1DfvrkC1JQzzX+zFfH+BikElWKIFvgj 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33cwj1s9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:21:03 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 086B3LiQ123796;
        Sun, 6 Sep 2020 07:21:03 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33cwj1s9tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:21:02 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 086BIZMo018631;
        Sun, 6 Sep 2020 11:21:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 33c2a88qes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 11:21:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 086BKvwm51380638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Sep 2020 11:20:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97428AE055;
        Sun,  6 Sep 2020 11:20:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E0E5AE04D;
        Sun,  6 Sep 2020 11:20:50 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.216.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Sep 2020 11:20:50 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v8 4/5] perf/tools: Pass pmu_event structure as a parameter for arch_get_runtimeparam
Date:   Sun,  6 Sep 2020 16:50:03 +0530
Message-Id: <20200906112004.49574-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200906112004.49574-1-kjain@linux.ibm.com>
References: <20200906112004.49574-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-06_07:2020-09-04,2020-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=1 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds passing of  pmu_event as a parameter in function
'arch_get_runtimeparam' which can be used to get details like
if the event is percore/perchip.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/header.c | 7 +++++--
 tools/perf/util/metricgroup.c         | 5 ++---
 tools/perf/util/metricgroup.h         | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 1a950171a66f..58b2d610aadb 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -40,8 +40,11 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 	return bufp;
 }
 
-int arch_get_runtimeparam(void)
+int arch_get_runtimeparam(struct pmu_event *pe)
 {
 	int count;
-	return sysfs__read_int("/devices/hv_24x7/interface/sockets", &count) < 0 ? 1 : count;
+	char path[PATH_MAX] = "/devices/hv_24x7/interface/";
+
+	atoi(pe->aggr_mode) == PerChip ? strcat(path, "sockets") : strcat(path, "coresperchip");
+	return sysfs__read_int(path, &count) < 0 ? 1 : count;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..c387aa1615ba 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -15,7 +15,6 @@
 #include "rblist.h"
 #include <string.h>
 #include <errno.h>
-#include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
@@ -634,7 +633,7 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
 	return false;
 }
 
-int __weak arch_get_runtimeparam(void)
+int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
 {
 	return 1;
 }
@@ -902,7 +901,7 @@ static int add_metric(struct list_head *metric_list,
 	} else {
 		int j, count;
 
-		count = arch_get_runtimeparam();
+		count = arch_get_runtimeparam(pe);
 
 		/* This loop is added to create multiple
 		 * events depend on count value and add
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 62623a39cbec..491a5d78252d 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdbool.h>
+#include "pmu-events/pmu-events.h"
 
 struct evsel;
 struct evlist;
@@ -52,6 +53,6 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
-int arch_get_runtimeparam(void);
+int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
 #endif
-- 
2.26.2

