Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C551AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9951B24673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgAXPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbgAXPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD1520718;
        Fri, 24 Jan 2020 15:17:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i4-000qBH-IO; Fri, 24 Jan 2020 10:17:24 -0500
Message-Id: <20200124151724.452734427@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fabian Frederick <fabf@skynet.be>
Subject: [for-next][PATCH 01/14] ring-bufer: kernel-doc warning fixes
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>

Also fixes a couple of typos

Link: http://lkml.kernel.org/r/1401992525-10417-1-git-send-email-fabf@skynet.be

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
[ Found this deep in the abyss of my INBOX ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f846de2aa435..46d67ff68795 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1368,6 +1368,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
  * __ring_buffer_alloc - allocate a new ring_buffer
  * @size: the size in bytes per cpu that is needed.
  * @flags: attributes to set for the ring buffer.
+ * @key: ring buffer reader_lock_key.
  *
  * Currently the only flag that is available is the RB_FL_OVERWRITE
  * flag. This flag means that the buffer will overwrite old data
@@ -4331,6 +4332,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read);
 /**
  * ring_buffer_size - return the size of the ring buffer (in bytes)
  * @buffer: The ring buffer.
+ * @cpu: The CPU to get ring buffer size from.
  */
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 {
@@ -4504,6 +4506,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_empty_cpu);
  * ring_buffer_swap_cpu - swap a CPU buffer between two ring buffers
  * @buffer_a: One buffer to swap with
  * @buffer_b: The other buffer to swap with
+ * @cpu: the CPU of the buffers to swap
  *
  * This function is useful for tracers that want to take a "snapshot"
  * of a CPU buffer and has another back up buffer lying around.
-- 
2.24.1


