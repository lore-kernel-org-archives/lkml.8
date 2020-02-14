Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE2C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86D022314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581721021;
	bh=MDMUy09PK4vU60vxIfNNBpzrbndQvvmmUdPTgYAQoxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=rXajTtdS2933GB/LVXzQqsd6fUNFIli60Q19xiammbaRUv47CBnBnrXzmpnZCMGBT
	 b4+TFYu0YZKxEfwWpIjp9EniSOoQ0O0kgUIIH+KYO45RHEXgpqwdApgbbSRBDdOjza
	 k/eGTR+7oqVSf+PRqLduet/m3/uOAh7xNzQSx2Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBNW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgBNW4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:56:52 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11098217F4;
        Fri, 14 Feb 2020 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581721011;
        bh=MDMUy09PK4vU60vxIfNNBpzrbndQvvmmUdPTgYAQoxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Halg2QR1SsP03GrcyYXjynF6UzPvVIKnFqKqFySYdf/iMJ05hazooSkIF0UzUKWgJ
         CJeHGQ7eUseZz1taF+Fw/RnJD+wGmLQX/KRTiUw+1B29xkOeR2nfpQ2b90WnJBXaAV
         rzqknUpkBRXG6/Zrgu9o6CC5vRpoZjZMWyBg/v2I=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] tracing: Check that number of vals matches number of synth event fields
Date:   Fri, 14 Feb 2020 16:56:40 -0600
Message-Id: <32819cac708714693669e0dfe10fe9d935e94a16.1581720155.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581720155.git.zanussi@kernel.org>
References: <cover.1581720155.git.zanussi@kernel.org>
In-Reply-To: <cover.1581720155.git.zanussi@kernel.org>
References: <cover.1581720155.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7276531d4036('tracing: Consolidate trace() functions')
inadvertently dropped the synth_event_trace() and
synth_event_trace_array() checks that verify the number of values
passed in matches the number of fields in the synthetic event being
traced, so add them back.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 913760d2d505..95d4c871f87b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1885,6 +1885,11 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		u64 val;
@@ -1921,7 +1926,7 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		}
 	}
 	va_end(args);
-
+out:
 	__synth_event_trace_end(&state);
 
 	return ret;
@@ -1960,6 +1965,11 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)vals[i];
@@ -1991,7 +2001,7 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			n_u64++;
 		}
 	}
-
+out:
 	__synth_event_trace_end(&state);
 
 	return ret;
-- 
2.14.1

