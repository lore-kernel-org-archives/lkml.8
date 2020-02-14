Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4988C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A269720873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgBNHjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:39:01 -0500
Received: from mail.windriver.com ([147.11.1.11]:49580 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBNHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:39:01 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 01E7VTAM010691
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Feb 2020 23:31:29 -0800 (PST)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.468.0; Thu, 13 Feb 2020 23:31:28 -0800
From:   <zhe.he@windriver.com>
To:     <rostedt@goodmis.org>, <acme@redhat.com>, <tstoyanov@vmware.com>,
        <hewenliang4@huawei.com>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] tools lib traceevent: Take care of return value of asprintf
Date:   Fri, 14 Feb 2020 15:31:26 +0800
Message-ID: <1581665486-20386-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

According to the API, if memory allocation wasn't possible, or some other
error occurs, asprintf will return -1, and the contents of strp below are
undefined.

int asprintf(char **strp, const char *fmt, ...);

This patch takes care of return value of asprintf to make it less error
prone and prevent the following build warning.

ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/lib/traceevent/parse-filter.c | 42 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 20eed71..279b572 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1912,6 +1912,7 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 	int left_val = -1;
 	int right_val = -1;
 	int val;
+	int ret;
 
 	switch (arg->op.type) {
 	case TEP_FILTER_OP_AND:
@@ -1958,7 +1959,9 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 				default:
 					break;
 				}
-				asprintf(&str, val ? "TRUE" : "FALSE");
+				ret = asprintf(&str, val ? "TRUE" : "FALSE");
+				if (ret < 0)
+					str = NULL;
 				break;
 			}
 		}
@@ -1976,7 +1979,9 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 			break;
 		}
 
-		asprintf(&str, "(%s) %s (%s)", left, op, right);
+		ret = asprintf(&str, "(%s) %s (%s)", left, op, right);
+		if (ret < 0)
+			str = NULL;
 		break;
 
 	case TEP_FILTER_OP_NOT:
@@ -1992,10 +1997,14 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 			right_val = 0;
 		if (right_val >= 0) {
 			/* just return the opposite */
-			asprintf(&str, right_val ? "FALSE" : "TRUE");
+			ret = asprintf(&str, right_val ? "FALSE" : "TRUE");
+			if (ret < 0)
+				str = NULL;
 			break;
 		}
-		asprintf(&str, "%s(%s)", op, right);
+		ret = asprintf(&str, "%s(%s)", op, right);
+		if (ret < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2010,8 +2019,11 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *str = NULL;
+	int ret;
 
-	asprintf(&str, "%lld", arg->value.val);
+	ret = asprintf(&str, "%lld", arg->value.val);
+	if (ret < 0)
+		str = NULL;
 
 	return str;
 }
@@ -2027,6 +2039,7 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 	char *rstr;
 	char *op;
 	char *str = NULL;
+	int ret;
 
 	lstr = arg_to_str(filter, arg->exp.left);
 	rstr = arg_to_str(filter, arg->exp.right);
@@ -2069,7 +2082,9 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		break;
 	}
 
-	asprintf(&str, "%s %s %s", lstr, op, rstr);
+	ret = asprintf(&str, "%s %s %s", lstr, op, rstr);
+	if (ret < 0)
+		str = NULL;
 out:
 	free(lstr);
 	free(rstr);
@@ -2083,6 +2098,7 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 	char *rstr;
 	char *str = NULL;
 	char *op = NULL;
+	int ret;
 
 	lstr = arg_to_str(filter, arg->num.left);
 	rstr = arg_to_str(filter, arg->num.right);
@@ -2113,7 +2129,9 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		if (!op)
 			op = "<=";
 
-		asprintf(&str, "%s %s %s", lstr, op, rstr);
+		ret = asprintf(&str, "%s %s %s", lstr, op, rstr);
+		if (ret < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2131,6 +2149,7 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 {
 	char *str = NULL;
 	char *op = NULL;
+	int ret;
 
 	switch (arg->str.type) {
 	case TEP_FILTER_CMP_MATCH:
@@ -2148,8 +2167,10 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		if (!op)
 			op = "!~";
 
-		asprintf(&str, "%s %s \"%s\"",
+		ret = asprintf(&str, "%s %s \"%s\"",
 			 arg->str.field->name, op, arg->str.val);
+		if (ret < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2162,10 +2183,13 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *arg)
 {
 	char *str = NULL;
+	int ret;
 
 	switch (arg->type) {
 	case TEP_FILTER_ARG_BOOLEAN:
-		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
+		ret = asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
+		if (ret < 0)
+			str = NULL;
 		return str;
 
 	case TEP_FILTER_ARG_OP:
-- 
2.7.4

