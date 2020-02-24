Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C4C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68EC20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBXRX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgBXRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC2D21927;
        Mon, 24 Feb 2020 17:21:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPw-001AcP-7v; Mon, 24 Feb 2020 12:21:16 -0500
Message-Id: <20200224172116.107383968@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 02/15] tracing: Make synth_event trace functions endian-correct
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

synth_event_trace(), synth_event_trace_array() and
__synth_event_add_val() write directly into the trace buffer and need
to take endianness into account, like trace_event_raw_event_synth()
does.

Link: http://lkml.kernel.org/r/2011354355e405af9c9d28abba430d1f5ff7771a.1581720155.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 62 +++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 65b54d6a1422..6a380fb83864 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1891,7 +1891,25 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			state.entry->fields[n_u64] = val;
+			struct synth_field *field = state.event->fields[i];
+
+			switch (field->size) {
+			case 1:
+				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				break;
+
+			case 2:
+				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				break;
+
+			case 4:
+				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				break;
+
+			default:
+				state.entry->fields[n_u64] = val;
+				break;
+			}
 			n_u64++;
 		}
 	}
@@ -1943,7 +1961,26 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			state.entry->fields[n_u64] = vals[i];
+			struct synth_field *field = state.event->fields[i];
+			u64 val = vals[i];
+
+			switch (field->size) {
+			case 1:
+				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				break;
+
+			case 2:
+				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				break;
+
+			case 4:
+				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				break;
+
+			default:
+				state.entry->fields[n_u64] = val;
+				break;
+			}
 			n_u64++;
 		}
 	}
@@ -2062,8 +2099,25 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 
 		str_field = (char *)&entry->fields[field->offset];
 		strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-	} else
-		entry->fields[field->offset] = val;
+	} else {
+		switch (field->size) {
+		case 1:
+			*(u8 *)&trace_state->entry->fields[field->offset] = (u8)val;
+			break;
+
+		case 2:
+			*(u16 *)&trace_state->entry->fields[field->offset] = (u16)val;
+			break;
+
+		case 4:
+			*(u32 *)&trace_state->entry->fields[field->offset] = (u32)val;
+			break;
+
+		default:
+			trace_state->entry->fields[field->offset] = val;
+			break;
+		}
+	}
  out:
 	return ret;
 }
-- 
2.25.0


