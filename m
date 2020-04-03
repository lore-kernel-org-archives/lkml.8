Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF1C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB162145D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585942288;
	bh=UbwkGgIx1V/qEm1bT7o6rAF6DYc/Tk64iXHZaF0sZXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=T5QTt6nskHgV8OPRuzZO+KLSjmyPVEn71RUBm5Aew3P/6x0ziYNPSvFVkeTPO5rdZ
	 TMrZBvuslo0mZm6uwWxJHDds7LNWNlCcPERFOOXJKheMWVzHYERwzEeyFedZZXzJZi
	 lvKaX6Whd6skaLUkZdt1hOSRXM7SYBhPBXR83k5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391056AbgDCTb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgDCTb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:31:26 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F05206E9;
        Fri,  3 Apr 2020 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585942285;
        bh=UbwkGgIx1V/qEm1bT7o6rAF6DYc/Tk64iXHZaF0sZXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JnHTCCwbnQ4pmq+hwEZWjF6HC+tvllu1WWz8Sm8UFIPoRABu/rTJqRJayuoKqg8rG
         to61zNoXb8Z/nFT7EIG/EtGW18fKkfmzoO9bBgyvdFrpXSFuhRoxY7+/+AqL/RZXTP
         lSCbEujP+BlfTJE7CkRT7r65L021aZHyX2XcZL98=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing: Check state.disabled in synth event trace functions
Date:   Fri,  3 Apr 2020 14:31:19 -0500
Message-Id: <87315c3889af870e8370e82b76cf48b426d70130.1585941485.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585941485.git.zanussi@kernel.org>
References: <cover.1585941485.git.zanussi@kernel.org>
In-Reply-To: <cover.1585941485.git.zanussi@kernel.org>
References: <cover.1585941485.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since trace_state.disabled is set in __synth_event_trace_start() at
the same time -ENOENT is returned, don't bother returning -ENOENT -
just have callers check trace_state.disabled instead, and avoid the
extra return val munging.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f6834a2bf41..1bb61c217a4a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1845,7 +1845,6 @@ __synth_event_trace_start(struct trace_event_file *file,
 	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
 	    trace_trigger_soft_disabled(file)) {
 		trace_state->disabled = true;
-		ret = -ENOENT;
 		goto out;
 	}
 
@@ -1907,11 +1906,8 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	int ret;
 
 	ret = __synth_event_trace_start(file, &state);
-	if (ret) {
-		if (ret == -ENOENT)
-			ret = 0; /* just disabled, not really an error */
+	if (ret || state.disabled)
 		return ret;
-	}
 
 	if (n_vals != state.event->n_fields) {
 		ret = -EINVAL;
@@ -1987,11 +1983,8 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	int ret;
 
 	ret = __synth_event_trace_start(file, &state);
-	if (ret) {
-		if (ret == -ENOENT)
-			ret = 0; /* just disabled, not really an error */
+	if (ret || state.disabled)
 		return ret;
-	}
 
 	if (n_vals != state.event->n_fields) {
 		ret = -EINVAL;
@@ -2067,16 +2060,10 @@ EXPORT_SYMBOL_GPL(synth_event_trace_array);
 int synth_event_trace_start(struct trace_event_file *file,
 			    struct synth_event_trace_state *trace_state)
 {
-	int ret;
-
 	if (!trace_state)
 		return -EINVAL;
 
-	ret = __synth_event_trace_start(file, trace_state);
-	if (ret == -ENOENT)
-		ret = 0; /* just disabled, not really an error */
-
-	return ret;
+	return __synth_event_trace_start(file, trace_state);
 }
 EXPORT_SYMBOL_GPL(synth_event_trace_start);
 
-- 
2.17.1

