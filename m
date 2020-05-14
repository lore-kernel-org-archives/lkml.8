Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFB020734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgENM6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENM6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:58:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0523C20748;
        Thu, 14 May 2020 12:58:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jZDRi-000GAk-Pn; Thu, 14 May 2020 08:58:42 -0400
Message-ID: <20200514125842.682466879@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 May 2020 08:58:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 3/3] ring-buffer: Remove all BUG() calls
References: <20200514125817.850882486@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's a lot of checks to make sure the ring buffer is working, and if an
anomaly is detected, it safely shuts itself down. But there's a few cases
that it will call BUG(), which defeats the point of being safe (it crashes
the kernel when an anomaly is found!). There's no reason for them. Switch
them all to either WARN_ON_ONCE() (when no ring buffer descriptor is present),
or to RB_WARN_ON() (when a ring buffer descriptor is present).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 448d5f528764..b8e1ca48be50 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -193,7 +193,7 @@ rb_event_length(struct ring_buffer_event *event)
 	case RINGBUF_TYPE_DATA:
 		return rb_event_data_length(event);
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
 	}
 	/* not hit */
 	return 0;
@@ -249,7 +249,7 @@ rb_event_data(struct ring_buffer_event *event)
 {
 	if (extended_time(event))
 		event = skip_time_extend(event);
-	BUG_ON(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
+	WARN_ON_ONCE(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 	/* If length is in len field, then array[0] has the data */
 	if (event->type_len)
 		return (void *)&event->array[0];
@@ -3727,7 +3727,7 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	default:
-		BUG();
+		RB_WARN_ON(cpu_buffer, 1);
 	}
 	return;
 }
@@ -3757,7 +3757,7 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 		return;
 
 	default:
-		BUG();
+		RB_WARN_ON(iter->cpu_buffer, 1);
 	}
 	return;
 }
@@ -4020,7 +4020,7 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 		return event;
 
 	default:
-		BUG();
+		RB_WARN_ON(cpu_buffer, 1);
 	}
 
 	return NULL;
@@ -4109,7 +4109,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		return event;
 
 	default:
-		BUG();
+		RB_WARN_ON(cpu_buffer, 1);
 	}
 
 	return NULL;
-- 
2.26.2


