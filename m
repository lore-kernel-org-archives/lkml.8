Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A13E21D7A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGBV6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgGBV6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73904217D9;
        Thu,  2 Jul 2020 21:58:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E2-004Bm9-9i; Thu, 02 Jul 2020 17:58:34 -0400
Message-ID: <20200702215834.181070395@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 18/18] ring-buffer: Do not trigger a WARN if clock going backwards is
 detected
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

After tweaking the ring buffer to be a bit faster, a warning is triggering
on one of my machines, and causing my tests to fail. This warning is caused
when the delta (current time stamp minus previous time stamp), is larger
than the max time held by the ring buffer (59 bits).

If the clock were to go backwards slightly, this would then easily trigger
this warning. The machine that it triggered on, the clock did go backwards
by around 450 nanoseconds, and this happened after a recalibration of the
TSC clock. Now that the ring buffer is faster, it detects this, and the
delta that is used larger than the max, the warning is triggered and my test
fails.

To handle the clock going backwards, look at the saved before and after time
stamps. If they are the same, it means that the current event did not
interrupt another event, and that those timestamp are of a previous event
that was recorded. If the max delta is triggered, look at those time stamps,
make sure they are the same, then use them to compare with the current
timestamp. If the current timestamp is less than the before/after time
stamps, then that means the clock being used went backward.

Print out a message that this has happened, but do not warn about it (and
only print the message once).

Still do the warning if the delta is indeed larger than what can be used.

Also remove the unneeded KERN_WARNING from the WARN_ONCE() print.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2bb96ee80120..c3a2e7509527 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2642,8 +2642,7 @@ rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	u64 write_stamp;
 
-	WARN_ONCE(info->delta > (1ULL << 59),
-		  KERN_WARNING "Delta way too big! %llu ts=%llu before=%llu after=%llu write stamp=%llu\n%s",
+	WARN_ONCE(1, "Delta way too big! %llu ts=%llu before=%llu after=%llu write stamp=%llu\n%s",
 		  (unsigned long long)info->delta,
 		  (unsigned long long)info->ts,
 		  (unsigned long long)info->before,
@@ -2665,7 +2664,26 @@ static void rb_add_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 	bool abs = info->add_timestamp &
 		(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
 
-	rb_check_timestamp(cpu_buffer, info);
+	if (unlikely(info->delta > (1ULL << 59))) {
+		/* did the clock go backwards */
+		if (info->before == info->after && info->before > info->ts) {
+			/* not interrupted */
+			static int once;
+
+			/*
+			 * This is possible with a recalibrating of the TSC.
+			 * Do not produce a call stack, but just report it.
+			 */
+			if (!once) {
+				once++;
+				pr_warn("Ring buffer clock went backwards: %llu -> %llu\n",
+					info->before, info->ts);
+			}
+		} else
+			rb_check_timestamp(cpu_buffer, info);
+		if (!abs)
+			info->delta = 0;
+	}
 	*event = rb_add_time_stamp(*event, info->delta, abs);
 	*length -= RB_LEN_TIME_EXTEND;
 	*delta = 0;
-- 
2.26.2


