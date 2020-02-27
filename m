Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D048C3F369
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E272420801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811704;
	bh=9HLdkMMX77Gb8gmumIGYRs7r4xKA2witeWT225J7nKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G8HtasDdCsJpVw3tFmJYhYwI4zpBugJU6j19G8dmrLjjUKFCrA5HXf0m2/SHzRFhV
	 EfHAsbGlmg8p/22pyy0g/A5gZZnIBK6fuJidQQSLMxVm+CSi2kRmxJBPYcWRiF112l
	 +tNmShjomfr45TqeOWyeimF8V1Vif4kj7IFWOLv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgB0NzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731926AbgB0Ny5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:54:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF902084E;
        Thu, 27 Feb 2020 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811696;
        bh=9HLdkMMX77Gb8gmumIGYRs7r4xKA2witeWT225J7nKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpGqQmAGw8rJKsIAtT7l/d5L+GrRr3wFF0qicvv1B0IvgXF0dRnTcNgZPecm1yd5l
         N4aogUxI0rZSDSC4zVEwzQFeNXph4PMwsPd3vryO4CrKR9o0gEL6QQJIGbX3NXQXWa
         Ew4ZX2p5K/3qJq+mNzRa8soGTHcP+reafNvv4VY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luis Henriques <luis.henriques@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/237] tracing: Fix very unlikely race of registering two stat tracers
Date:   Thu, 27 Feb 2020 14:34:39 +0100
Message-Id: <20200227132301.821694547@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit dfb6cd1e654315168e36d947471bd2a0ccd834ae ]

Looking through old emails in my INBOX, I came across a patch from Luis
Henriques that attempted to fix a race of two stat tracers registering the
same stat trace (extremely unlikely, as this is done in the kernel, and
probably doesn't even exist). The submitted patch wasn't quite right as it
needed to deal with clean up a bit better (if two stat tracers were the
same, it would have the same files).

But to make the code cleaner, all we needed to do is to keep the
all_stat_sessions_mutex held for most of the registering function.

Link: http://lkml.kernel.org/r/1410299375-20068-1-git-send-email-luis.henriques@canonical.com

Fixes: 002bb86d8d42f ("tracing/ftrace: separate events tracing and stats tracing engine")
Reported-by: Luis Henriques <luis.henriques@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_stat.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index bf68af63538b4..92b76f9e25edd 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -306,7 +306,7 @@ static int init_stat_file(struct stat_session *session)
 int register_stat_tracer(struct tracer_stat *trace)
 {
 	struct stat_session *session, *node;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!trace)
 		return -EINVAL;
@@ -317,17 +317,15 @@ int register_stat_tracer(struct tracer_stat *trace)
 	/* Already registered? */
 	mutex_lock(&all_stat_sessions_mutex);
 	list_for_each_entry(node, &all_stat_sessions, session_list) {
-		if (node->ts == trace) {
-			mutex_unlock(&all_stat_sessions_mutex);
-			return -EINVAL;
-		}
+		if (node->ts == trace)
+			goto out;
 	}
-	mutex_unlock(&all_stat_sessions_mutex);
 
+	ret = -ENOMEM;
 	/* Init the session */
 	session = kzalloc(sizeof(*session), GFP_KERNEL);
 	if (!session)
-		return -ENOMEM;
+		goto out;
 
 	session->ts = trace;
 	INIT_LIST_HEAD(&session->session_list);
@@ -336,15 +334,16 @@ int register_stat_tracer(struct tracer_stat *trace)
 	ret = init_stat_file(session);
 	if (ret) {
 		destroy_session(session);
-		return ret;
+		goto out;
 	}
 
+	ret = 0;
 	/* Register */
-	mutex_lock(&all_stat_sessions_mutex);
 	list_add_tail(&session->session_list, &all_stat_sessions);
+ out:
 	mutex_unlock(&all_stat_sessions_mutex);
 
-	return 0;
+	return ret;
 }
 
 void unregister_stat_tracer(struct tracer_stat *trace)
-- 
2.20.1



