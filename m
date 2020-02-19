Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A6C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3C724654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBSCEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:04:45 -0500
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:37802 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727208AbgBSCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:04:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 64FE31802DF6C;
        Wed, 19 Feb 2020 02:04:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mice82_807752c462551
X-Filterd-Recvd-Size: 5466
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 02:04:42 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] trace: Move data to new section _ftrace_data
Date:   Tue, 18 Feb 2020 18:03:17 -0800
Message-Id: <45725c93cb9bc3cf78e2c6304a9d04ee92eda2b4.1582077699.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582077698.git.joe@perches.com>
References: <cover.1582077698.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the data used by tracing to a separate section to
help identify and perhaps control access to tracing data.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/trace/trace_events.h | 31 ++++++++++++++++++++++---------
 kernel/trace/trace_export.c  | 10 +++++++---
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 502c7b..361999f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -369,7 +369,9 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 									\
 	return trace_handle_return(s);					\
 }									\
-static struct trace_event_functions trace_event_type_funcs_##call = {	\
+static struct trace_event_functions					\
+__attribute__((section("_ftrace_data")))				\
+trace_event_type_funcs_##call = {					\
 	.trace			= trace_raw_output_##call,		\
 };
 
@@ -439,9 +441,12 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
-static struct trace_event_fields trace_event_fields_##call[] = {	\
+static struct trace_event_fields					\
+__attribute__((section("_ftrace_data")))				\
+trace_event_fields_##call[] = {						\
 	tstruct								\
-	{} };
+	{}								\
+};
 
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
@@ -746,7 +751,8 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 _TRACE_PERF_PROTO(call, PARAMS(proto));					\
-static char print_fmt_##call[] = print;					\
+static char __attribute__((section("_ftrace_data")))			\
+print_fmt_##call[] = print;						\
 static struct trace_event_class __used __refdata event_class_##call = { \
 	.system			= TRACE_SYSTEM_STRING,			\
 	.fields_array		= trace_event_fields_##call,		\
@@ -760,7 +766,9 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
-static struct trace_event_call __used event_##call = {			\
+static struct trace_event_call __used					\
+__attribute__((section("_ftrace_data")))				\
+event_##call = {							\
 	.class			= &event_class_##template,		\
 	{								\
 		.tp			= &__tracepoint_##call,		\
@@ -770,14 +778,18 @@ static struct trace_event_call __used event_##call = {			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
 static struct trace_event_call __used					\
-__attribute__((section("_ftrace_events"))) *__event_##call = &event_##call
+__attribute__((section("_ftrace_events")))				\
+*__event_##call = &event_##call
 
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 									\
-static char print_fmt_##call[] = print;					\
+static char __attribute__((section("_ftrace_data")))			\
+print_fmt_##call[] = print;						\
 									\
-static struct trace_event_call __used event_##call = {			\
+static struct trace_event_call __used					\
+__attribute__((section("_ftrace_data")))				\
+event_##call = {							\
 	.class			= &event_class_##template,		\
 	{								\
 		.tp			= &__tracepoint_##call,		\
@@ -787,6 +799,7 @@ static struct trace_event_call __used event_##call = {			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
 static struct trace_event_call __used					\
-__attribute__((section("_ftrace_events"))) *__event_##call = &event_##call
+__attribute__((section("_ftrace_events")))				\
+*__event_##call = &event_##call
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 77ce5a..90af7c9 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -111,9 +111,12 @@ static void __always_unused ____ftrace_check_##name(void)		\
 
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
-static struct trace_event_fields ftrace_event_fields_##name[] = {	\
+static struct trace_event_fields					\
+__attribute__((section("_ftrace_data")))				\
+ftrace_event_fields_##name[] = {					\
 	tstruct								\
-	{} };
+	{}								\
+};
 
 #include "trace_entries.h"
 
@@ -150,7 +153,8 @@ static struct trace_event_class __refdata event_class_ftrace_##call = {	\
 	.reg			= regfn,				\
 };									\
 									\
-struct trace_event_call __used event_##call = {				\
+struct trace_event_call __used __attribute((section("_ftrace_data")))	\
+event_##call = {							\
 	.class			= &event_class_ftrace_##call,		\
 	{								\
 		.name			= #call,			\
-- 
2.24.0

