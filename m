Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F379222CBE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ActzAYL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgH0NUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:20:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727780AbgH0NNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:13:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RD31Kt023588;
        Thu, 27 Aug 2020 09:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hPwyMlvvmBwMzPPXtaOo1sxMfBSLRdWeG1Pej1RHa9Q=;
 b=ActzAYL9rh54iwkIL76ZuzXXbcPozuIwKIBKFNFycLlisU/mTgoa+yZVh9HfG0kuTeaD
 hzkWI+yJWMglrwGg0Ouf7N13NUk37g/brx/y/09JJsfyqzpDcsiIPkQy287fKHJulN4C
 CMI86TTBpZuuNMPr5NG8v5S1G5RlXgQrj5LOoWGIDtqsu/8gMEmpL4Zh16z48rq/U1Tb
 F3vQD4l8Tp4jKk2cGLk5DV1xEshTVdLEA8oejDJIa+BUefFLjXRcr8B5SF8JGZix8i9g
 PXyLfT+JpI/IAGs2cTtXQ7f40hyWeGWlADY7tRFG+Z1A201Dm+VTHBYI0vB0ooI8VopY VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336bakm8tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:12:11 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RD3C24024848;
        Thu, 27 Aug 2020 09:12:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336bakm8t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:12:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RD8Wea006999;
        Thu, 27 Aug 2020 13:12:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 336buh03fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:12:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RDAa5C59965848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:10:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DBFEA4062;
        Thu, 27 Aug 2020 13:12:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72754A4054;
        Thu, 27 Aug 2020 13:11:00 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.210.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 13:11:00 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v6 4/5] perf/tools: Pass pmu_event structure as a parameter for arch_get_runtimeparam
Date:   Thu, 27 Aug 2020 18:39:57 +0530
Message-Id: <20200827130958.189146-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827130958.189146-1-kjain@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270094
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

