Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DFAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA27F208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579906595;
	bh=rzJutOgCikMQAt+SBbA5zBLBKkKMSIx8QMR50bpyZxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=A+e9XBMKFyS4RjV86OAHY5tCaXayF2KPj2k7jMEz8pvLU7Pp2AjKtKFU5DHV+V55T
	 OzJN49oxnX2APMzu3iYNY2hPsepxUo4WCu8yTQUURG/dp8XV3gpYMd05A+ltOkpvta
	 JASaWwpWkCSNF3h3QKE3usfOfgKtsv8hBQuEsbgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgAXW4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgAXW4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:56:32 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0682071E;
        Fri, 24 Jan 2020 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579906592;
        bh=rzJutOgCikMQAt+SBbA5zBLBKkKMSIx8QMR50bpyZxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=mOOP97id9kGK8Gr4WmGSinauOWbmdtAjRk0bwdN1LIkLPVGOQWx/Bx/zBdAyaGwvZ
         iof5D0kuyB7uBbmlkRwjqco/8njOILg80rKNQGGcuTNKwX/mfkpAiYUflnbfBB/g01
         wwleEuj1cPu29822m/rH7uawWEMJ7mSl/3d7Xink=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH v3 01/12] tracing: Add trace_array_find/_get() to find instance trace arrays
Date:   Fri, 24 Jan 2020 16:56:12 -0600
Message-Id: <86b6e41dead78052083cc228f9a71378ff3c5752.1579904761.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
In-Reply-To: <cover.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new trace_array_find() function that can be used to find a trace
array given the instance name, and replace existing code that does the
same thing with it.  Also add trace_array_find_get() which does the
same but returns the trace array after upping its refcount.

Also make both available for use outside of trace.c.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c | 43 +++++++++++++++++++++++++++++++++----------
 kernel/trace/trace.h |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1410b4462ac..2d4b70bd85a2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8501,6 +8501,34 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+/* Must have trace_types_lock held */
+struct trace_array *trace_array_find(const char *instance)
+{
+	struct trace_array *tr, *found = NULL;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, instance) == 0) {
+			found = tr;
+			break;
+		}
+	}
+
+	return found;
+}
+
+struct trace_array *trace_array_find_get(const char *instance)
+{
+	struct trace_array *tr;
+
+	mutex_lock(&trace_types_lock);
+	tr = trace_array_find(instance);
+	if (tr)
+		tr->ref++;
+	mutex_unlock(&trace_types_lock);
+
+	return tr;
+}
+
 static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8577,10 +8605,8 @@ static int instance_mkdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -EEXIST;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
-	}
+	if (trace_array_find(name))
+		goto out_unlock;
 
 	tr = trace_array_create(name);
 
@@ -8704,12 +8730,9 @@ static int instance_rmdir(const char *name)
 	mutex_lock(&trace_types_lock);
 
 	ret = -ENODEV;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0) {
-			ret = __remove_instance(tr);
-			break;
-		}
-	}
+	tr = trace_array_find(name);
+	if (tr)
+		ret = __remove_instance(tr);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4812a36affac..8fe3b16c8cec 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -346,6 +346,8 @@ extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
+extern struct trace_array *trace_array_find(const char *instance);
+extern struct trace_array *trace_array_find_get(const char *instance);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
-- 
2.14.1

