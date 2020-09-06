Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29481C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF28208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J103FcaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgIFL2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:28:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726342AbgIFLVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:21:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 086B29bt092420;
        Sun, 6 Sep 2020 07:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=shPgl51AhbjSal1+KDO20UTlVKAoBRwnYBs3Wv3zI+A=;
 b=J103FcaX7Z1PLLX3PxZMhuZgzRaNbi1nS5xRoZwOsm4/ltLppKnRW1nrnO8gFzVgT5bA
 lAVmY5WW3JsAiRJz8K6z8kuiL0QpRo0DsEt/5J20jlhoC0W14cEo9TflNFeygArzZ4I6
 DToZnGAzf69Qv7QCCwGcQE6UeLgIDuH1wei/V8ccRBz4gYeVLv4hPq9H05clro6I5J1x
 gZD0ktVJgpY0CbCc2dgQTAPYgLIvK492avz2dEjdHdDCRGNzZxDYmqWxP7vlp79lzn3q
 LnGih4kX2X7SjKSSTv9y2X2p49eRFkgCVZomHEb5QRq6loEBiYYDxy3yCSWUYmvvdqhB gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33cx9kgfun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:20:39 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 086BKcTm125564;
        Sun, 6 Sep 2020 07:20:38 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33cx9kgfu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:20:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 086BI1iS014066;
        Sun, 6 Sep 2020 11:20:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a896nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 11:20:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 086BKX0t37486944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Sep 2020 11:20:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214DAAE057;
        Sun,  6 Sep 2020 11:20:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73D3DAE04D;
        Sun,  6 Sep 2020 11:20:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.216.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Sep 2020 11:20:26 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v8 1/5] perf/jevents: Remove jevents.h file
Date:   Sun,  6 Sep 2020 16:50:00 +0530
Message-Id: <20200906112004.49574-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200906112004.49574-1-kjain@linux.ibm.com>
References: <20200906112004.49574-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-06_07:2020-09-04,2020-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes jevents.h file.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c |  3 +--
 tools/perf/pmu-events/jevents.h | 23 -----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.h

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..1b1c3606f62e 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -48,7 +48,6 @@
 #include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
-#include "jevents.h"
 
 int verbose;
 char *prog;
@@ -512,7 +511,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 }
 
 /* Call func with each event in the json file */
-int json_events(const char *fn,
+static int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
deleted file mode 100644
index 2afc8304529e..000000000000
--- a/tools/perf/pmu-events/jevents.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef JEVENTS_H
-#define JEVENTS_H 1
-
-int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc,
-				char *long_desc,
-				char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint),
-		void *data);
-char *get_cpu_str(void);
-
-#ifndef min
-#define min(x, y) ({                            \
-	typeof(x) _min1 = (x);                  \
-	typeof(y) _min2 = (y);                  \
-	(void) (&_min1 == &_min2);              \
-	_min1 < _min2 ? _min1 : _min2; })
-#endif
-
-#endif
-- 
2.26.2

