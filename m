Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9759AC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED38206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEEMbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:31:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:45912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgEEMbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:31:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD465AB89;
        Tue,  5 May 2020 12:31:49 +0000 (UTC)
Date:   Tue, 5 May 2020 14:31:44 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [PATCH] tracing: Call vmalloc_sync_mappings() after alloc_percpu()
Message-ID: <20200505123144.GM8135@suse.de>
References: <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
 <20200504151236.GI8135@suse.de>
 <20200504134042.178409c3@gandalf.local.home>
 <20200504183832.GL8135@suse.de>
 <20200504151006.69d2a16c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504151006.69d2a16c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 03:10:06PM -0400, Steven Rostedt wrote:
> I'm fine with adding it to the tracing code (with that ridiculous
> comment! ;-)
> 
> I'll even tag is as stable, but again, it's uncertain what commit that it
> "fixes".

Okay, so here it is. It fixes the issue for me and doesn't cause any
lockdep splats on my machine. I am not sure how far this needs to be
backported via stable, so I didn't specify it. Same with a Fixes tag.
Oh, and I added your comment :-) (which makes up most of the added
lines, so feel free to change authorship to you).

Regards,

	Joerg

From a265290761dc9d87d35892dc821fd0f5c99f8b34 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Tue, 5 May 2020 14:17:57 +0200
Subject: [PATCH] tracing: Call vmalloc_sync_mappings() after alloc_percpu()

Tracing code allocates percpu memory which is touched when trace events
happen. When the events happen in the page-fault handler and per-cpu
memory needs to be faulted in, the page-fault on per-cpu memory might
never complete.

Call vmalloc_sync_mappings() after allocating the runtime per-cpu
buffers to make sure they are mapped when the page-fault handler tries
to access them.

This is not a nice solution, but the best fix until the
vmalloc_sync_mappings/unmappings() interface can be ripped out of the
kernel.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 kernel/trace/trace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d2b98812625..0fc56063fcca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8525,6 +8525,19 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	 */
 	allocate_snapshot = false;
 #endif
+
+	/*
+	 * Because of some magic with the way alloc_percpu() works on
+	 * x86_64, we need to synchronize the pgd of all the tables,
+	 * otherwise the trace events that happen in x86_64 page fault
+	 * handlers can't cope with accessing the chance that a
+	 * alloc_percpu()'d memory might be touched in the page fault trace
+	 * event. Oh, and we need to audit all alloc_percpu() and vmalloc()
+	 * calls in tracing, because something might get triggered within a
+	 * page fault trace event!
+	 */
+	vmalloc_sync_mappings();
+
 	return 0;
 }
 
-- 
2.12.3



