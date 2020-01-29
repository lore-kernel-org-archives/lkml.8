Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1597C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21E9206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgA2Oim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgA2Oib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:38:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D929D24687;
        Wed, 29 Jan 2020 14:38:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iwoU9-0019lZ-PS; Wed, 29 Jan 2020 09:38:29 -0500
Message-Id: <20200129143829.668048138@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 09:38:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 3/5] tracing: Add hist trigger error messages for sort specification
References: <20200129143802.971887038@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add error codes and messages for all the error paths leading to sort
specification parsing errors.

Link: http://lkml.kernel.org/r/237830dc05e583fbb53664d817a784297bf961be.1561743018.git.zanussi@kernel.org

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index bf2bcb8d7725..23458ba9e5f5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -66,7 +66,12 @@
 	C(INVALID_SUBSYS_EVENT,	"Invalid subsystem or event name"),	\
 	C(INVALID_REF_KEY,	"Using variable references in keys not supported"), \
 	C(VAR_NOT_FOUND,	"Couldn't find variable"),		\
-	C(FIELD_NOT_FOUND,	"Couldn't find field"),
+	C(FIELD_NOT_FOUND,	"Couldn't find field"),			\
+	C(EMPTY_ASSIGNMENT,	"Empty assignment"),			\
+	C(INVALID_SORT_MODIFIER,"Invalid sort modifier"),		\
+	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
+	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
+	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -2183,6 +2188,7 @@ parse_hist_trigger_attrs(struct trace_array *tr, char *trigger_str)
 		if (rhs) {
 			if (!strlen(++rhs)) {
 				ret = -EINVAL;
+				hist_err(tr, HIST_ERR_EMPTY_ASSIGNMENT, errpos(str));
 				goto free;
 			}
 			ret = parse_assignment(tr, str, attrs);
@@ -4743,7 +4749,7 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 	return ret;
 }
 
-static int is_descending(const char *str)
+static int is_descending(struct trace_array *tr, const char *str)
 {
 	if (!str)
 		return 0;
@@ -4754,11 +4760,14 @@ static int is_descending(const char *str)
 	if (strcmp(str, "ascending") == 0)
 		return 0;
 
+	hist_err(tr, HIST_ERR_INVALID_SORT_MODIFIER, errpos((char *)str));
+
 	return -EINVAL;
 }
 
 static int create_sort_keys(struct hist_trigger_data *hist_data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	char *fields_str = hist_data->attrs->sort_key_str;
 	struct tracing_map_sort_key *sort_key;
 	int descending, ret = 0;
@@ -4782,10 +4791,12 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 
 		if (!*field_str) {
 			ret = -EINVAL;
+			hist_err(tr, HIST_ERR_EMPTY_SORT_FIELD, errpos("sort="));
 			break;
 		}
 
 		if ((i == TRACING_MAP_SORT_KEYS_MAX - 1) && fields_str) {
+			hist_err(tr, HIST_ERR_TOO_MANY_SORT_FIELDS, errpos("sort="));
 			ret = -EINVAL;
 			break;
 		}
@@ -4793,11 +4804,12 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 		field_name = strsep(&field_str, ".");
 		if (!field_name || !*field_name) {
 			ret = -EINVAL;
+			hist_err(tr, HIST_ERR_EMPTY_SORT_FIELD, errpos("sort="));
 			break;
 		}
 
 		if (strcmp(field_name, "hitcount") == 0) {
-			descending = is_descending(field_str);
+			descending = is_descending(tr, field_str);
 			if (descending < 0) {
 				ret = descending;
 				break;
@@ -4819,7 +4831,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 
 			if (strcmp(field_name, test_name) == 0) {
 				sort_key->field_idx = idx;
-				descending = is_descending(field_str);
+				descending = is_descending(tr, field_str);
 				if (descending < 0) {
 					ret = descending;
 					goto out;
@@ -4830,6 +4842,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 		}
 		if (j == hist_data->n_fields) {
 			ret = -EINVAL;
+			hist_err(tr, HIST_ERR_INVALID_SORT_FIELD, errpos(field_name));
 			break;
 		}
 	}
-- 
2.24.1


