Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E7C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65A424671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBTCBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:01:03 -0500
Received: from mail5.windriver.com ([192.103.53.11]:36858 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgBTCBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:01:03 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 01K1x2kD023823
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 19 Feb 2020 17:59:13 -0800
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Wed, 19 Feb 2020 17:58:52 -0800
From:   <zhe.he@windriver.com>
To:     <rostedt@goodmis.org>, <acme@redhat.com>, <tstoyanov@vmware.com>,
        <hewenliang4@huawei.com>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH v3] tools lib traceevent: Take care of return value of asprintf
Date:   Thu, 20 Feb 2020 09:58:50 +0800
Message-ID: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
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
v2: directly check the return value without saving to a variable
v3: as asked, not remove those that already save the return value

 tools/lib/traceevent/parse-filter.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 20eed71..c271aee 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1958,7 +1958,8 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 				default:
 					break;
 				}
-				asprintf(&str, val ? "TRUE" : "FALSE");
+				if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
+					str = NULL;
 				break;
 			}
 		}
@@ -1976,7 +1977,8 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 			break;
 		}
 
-		asprintf(&str, "(%s) %s (%s)", left, op, right);
+		if (asprintf(&str, "(%s) %s (%s)", left, op, right) < 0)
+			str = NULL;
 		break;
 
 	case TEP_FILTER_OP_NOT:
@@ -1992,10 +1994,12 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 			right_val = 0;
 		if (right_val >= 0) {
 			/* just return the opposite */
-			asprintf(&str, right_val ? "FALSE" : "TRUE");
+			if (asprintf(&str, right_val ? "FALSE" : "TRUE") < 0)
+				str = NULL;
 			break;
 		}
-		asprintf(&str, "%s(%s)", op, right);
+		if (asprintf(&str, "%s(%s)", op, right) < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2011,7 +2015,8 @@ static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 {
 	char *str = NULL;
 
-	asprintf(&str, "%lld", arg->value.val);
+	if (asprintf(&str, "%lld", arg->value.val) < 0)
+		str = NULL;
 
 	return str;
 }
@@ -2069,7 +2074,8 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		break;
 	}
 
-	asprintf(&str, "%s %s %s", lstr, op, rstr);
+	if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
+		str = NULL;
 out:
 	free(lstr);
 	free(rstr);
@@ -2113,7 +2119,8 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		if (!op)
 			op = "<=";
 
-		asprintf(&str, "%s %s %s", lstr, op, rstr);
+		if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2148,8 +2155,9 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		if (!op)
 			op = "!~";
 
-		asprintf(&str, "%s %s \"%s\"",
-			 arg->str.field->name, op, arg->str.val);
+		if (asprintf(&str, "%s %s \"%s\"",
+			 arg->str.field->name, op, arg->str.val) < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2165,7 +2173,8 @@ static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 
 	switch (arg->type) {
 	case TEP_FILTER_ARG_BOOLEAN:
-		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
+		if (asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE") < 0)
+			str = NULL;
 		return str;
 
 	case TEP_FILTER_ARG_OP:
-- 
2.7.4

