Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD5C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1942207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428762;
	bh=/sOLfcB78ooPON9tkDzlMoGzEbOGHBf9o0sHqQL4E74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5fZeF2lxVQ/fXE8/rVIQHwShmzFbvI6mo9BFAWbGnO7CgTUEn23vEwGknRK4yziL
	 LgzP2oqZ1cnTVCX6pw0CRTmRG/ykdxdED5Nzv5GlHXCO+QNhlWZHprlStJwVeIcQxZ
	 V+U+WJJxYJoKqcC9kxc/mzHZiOYonAY2oekj7OPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCERPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgCEROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F23F24679;
        Thu,  5 Mar 2020 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428484;
        bh=/sOLfcB78ooPON9tkDzlMoGzEbOGHBf9o0sHqQL4E74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIa2Uofiw+7xACOskNAWADNzmI69JwYUzX5tiKPgEib/7u0IEULcNv7tqslC8RCvj
         7kiRa9QYRaBEurh9nPYG2xkv/co7chM9v35ACgwtRUAc9yR09UvHhnngXhdCA5bwfH
         F+HHkETdD7LhAAH3yM2TvIErPvLJ2A6ABeNVtpfI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 19/58] tracing: Fix number printing bug in print_synth_event()
Date:   Thu,  5 Mar 2020 12:13:40 -0500
Message-Id: <20200305171420.29595-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171420.29595-1-sashal@kernel.org>
References: <20200305171420.29595-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

[ Upstream commit 784bd0847eda032ed2f3522f87250655a18c0190 ]

Fix a varargs-related bug in print_synth_event() which resulted in
strange output and oopses on 32-bit x86 systems. The problem is that
trace_seq_printf() expects the varargs to match the format string, but
print_synth_event() was always passing u64 values regardless.  This
results in unspecified behavior when unpacking with va_arg() in
trace_seq_printf().

Add a function that takes the size into account when calling
trace_seq_printf().

Before:

  modprobe-1731  [003] ....   919.039758: gen_synth_test: next_pid_field=777(null)next_comm_field=hula hoops ts_ns=1000000 ts_ms=1000 cpu=3(null)my_string_field=thneed my_int_field=598(null)

After:

 insmod-1136  [001] ....    36.634590: gen_synth_test: next_pid_field=777 next_comm_field=hula hoops ts_ns=1000000 ts_ms=1000 cpu=1 my_string_field=thneed my_int_field=598

Link: http://lkml.kernel.org/r/a9b59eb515dbbd7d4abe53b347dccf7a8e285657.1581720155.git.zanussi@kernel.org

Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a31be3fce3e8e..6495800fb92a1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -811,6 +811,29 @@ static const char *synth_field_fmt(char *type)
 	return fmt;
 }
 
+static void print_synth_event_num_val(struct trace_seq *s,
+				      char *print_fmt, char *name,
+				      int size, u64 val, char *space)
+{
+	switch (size) {
+	case 1:
+		trace_seq_printf(s, print_fmt, name, (u8)val, space);
+		break;
+
+	case 2:
+		trace_seq_printf(s, print_fmt, name, (u16)val, space);
+		break;
+
+	case 4:
+		trace_seq_printf(s, print_fmt, name, (u32)val, space);
+		break;
+
+	default:
+		trace_seq_printf(s, print_fmt, name, val, space);
+		break;
+	}
+}
+
 static enum print_line_t print_synth_event(struct trace_iterator *iter,
 					   int flags,
 					   struct trace_event *event)
@@ -849,10 +872,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
+			char *space = (i == se->n_fields - 1 ? "" : " ");
 
-			trace_seq_printf(s, print_fmt, se->fields[i]->name,
-					 entry->fields[n_u64],
-					 i == se->n_fields - 1 ? "" : " ");
+			print_synth_event_num_val(s, print_fmt,
+						  se->fields[i]->name,
+						  se->fields[i]->size,
+						  entry->fields[n_u64],
+						  space);
 
 			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
 				trace_seq_puts(s, " (");
-- 
2.20.1

