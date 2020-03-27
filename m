Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3EBC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C9720705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgC0K0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:26:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgC0K0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:26:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RA21iw071747
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:26:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7h14d0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:26:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Fri, 27 Mar 2020 10:25:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 10:25:47 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RAPpAQ44761282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 10:25:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DADFFA405F;
        Fri, 27 Mar 2020 10:25:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E0F3A405B;
        Fri, 27 Mar 2020 10:25:46 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.180.159])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 10:25:45 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v7 2/6] perf expr: Add expr_scanner_ctx object
Date:   Fri, 27 Mar 2020 15:55:24 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327102528.4267-1-kjain@linux.ibm.com>
References: <20200327102528.4267-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032710-4275-0000-0000-000003B45054
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032710-4276-0000-0000-000038C99746
Message-Id: <20200327102528.4267-3-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_02:2020-03-26,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=578
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding expr_scanner_ctx object to hold user data
for the expr scanner. Currently it holds only
start_token, Kajol Jain will use it to hold 24x7
runtime param.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c |  6 ++++--
 tools/perf/util/expr.h |  4 ++++
 tools/perf/util/expr.l | 10 +++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c8ccc548a585..c3382d58cf40 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -3,7 +3,6 @@
 #include <assert.h>
 #include "expr.h"
 #include "expr-bison.h"
-#define YY_EXTRA_TYPE int
 #include "expr-flex.h"
 
 #ifdef PARSER_DEBUG
@@ -30,11 +29,14 @@ static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	      int start)
 {
+	struct expr_scanner_ctx scanner_ctx = {
+		.start_token = start,
+	};
 	YY_BUFFER_STATE buffer;
 	void *scanner;
 	int ret;
 
-	ret = expr_lex_init_extra(start, &scanner);
+	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
 	if (ret)
 		return ret;
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index b9e53f2b5844..0938ad166ece 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -15,6 +15,10 @@ struct expr_parse_ctx {
 	struct expr_parse_id ids[MAX_PARSE_ID];
 };
 
+struct expr_scanner_ctx {
+	int start_token;
+};
+
 void expr__ctx_init(struct expr_parse_ctx *ctx);
 void expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
 int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr);
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index eaad29243c23..2582c2464938 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -76,13 +76,13 @@ sym		[0-9a-zA-Z_\.:@]+
 symbol		{spec}*{sym}*{spec}*{sym}*
 
 %%
-	{
-		int start_token;
+	struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
 
-		start_token = expr_get_extra(yyscanner);
+	{
+		int start_token = sctx->start_token;
 
-		if (start_token) {
-			expr_set_extra(NULL, yyscanner);
+		if (sctx->start_token) {
+			sctx->start_token = 0;
 			return start_token;
 		}
 	}
-- 
2.18.1

