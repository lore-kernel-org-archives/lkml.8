Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2D420CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgA2Oik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgA2Oib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:38:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090092468A;
        Wed, 29 Jan 2020 14:38:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iwoU9-0019m3-UG; Wed, 29 Jan 2020 09:38:29 -0500
Message-Id: <20200129143829.812645522@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 09:38:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 4/5] tracing: Add hist: to hist trigger error log error string
References: <20200129143802.971887038@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The 'hist:' prefix gets stripped from the command text during command
processing, but should be added back when displaying the command
during error processing.

Not only because it's what should be displayed but also because not
having it means the test cases fail because the caret is miscalculated
by the length of the prefix string.

Link: http://lkml.kernel.org/r/449df721f560042e22382f67574bcc5b4d830d3d.1561743018.git.zanussi@kernel.org

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 23458ba9e5f5..c322826e0726 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -612,7 +612,8 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 	if (!str)
 		return;
 
-	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+	strcpy(last_cmd, "hist:");
+	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1 - sizeof("hist:"));
 
 	if (file) {
 		call = file->event_call;
-- 
2.24.1


