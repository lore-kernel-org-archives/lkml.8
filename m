Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA11CC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCE2222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581632223;
	bh=GEz2+lin0VRu87Ptt5fXE8dJXTA7/WGuVk2vdP20BZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=rMuDTOv5UTC6VlZVVLGp7t/DSnZCZhGE19rqan3CCRFb9kipFuZC+jd1Hv6IGvwQj
	 rmtBz/Oz1I2DjqRYspIG8478aVfE5/U8qhzqh84e9SDonNwoeP/HwdcgTwWltvkxRe
	 q+soIqu3tS6Owi0VplN0ukPdToQ2CBVO8WeNQxKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgBMWQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgBMWQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:16:56 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FACF217BA;
        Thu, 13 Feb 2020 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581632215;
        bh=GEz2+lin0VRu87Ptt5fXE8dJXTA7/WGuVk2vdP20BZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bcTtFA6nIVAxCVEAv8tzoSJodOLBc0sb7WY5bopOE8TEV9Mx9S2cGh4Hfnn43WJqe
         RCcybyDhlQnJ4gjwo9aT4r09FrozAAJMItqFcSPsil/+Tmk/2US2mfb5pye8GO6+XT
         NZbzXzuDW70vnav8rQBvTPYMOAEdbV4/J99j1dR8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: Make synth_event trace functions endian-correct
Date:   Thu, 13 Feb 2020 16:16:44 -0600
Message-Id: <2011354355e405af9c9d28abba430d1f5ff7771a.1581630377.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581630377.git.zanussi@kernel.org>
References: <cover.1581630377.git.zanussi@kernel.org>
In-Reply-To: <cover.1581630377.git.zanussi@kernel.org>
References: <cover.1581630377.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synth_event_trace(), synth_event_trace_array() and
__synth_event_add_val() write directly into the trace buffer and need
to take endianness into account, like trace_event_raw_event_synth()
does.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 62 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 483b3fd1094f..913760d2d505 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1898,7 +1898,25 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
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
@@ -1950,7 +1968,26 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
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
@@ -2069,8 +2106,25 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 
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
2.14.1

