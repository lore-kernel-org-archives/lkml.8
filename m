Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9178206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgEDPMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:12:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEDPMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:12:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14AF5ABBD;
        Mon,  4 May 2020 15:12:41 +0000 (UTC)
Date:   Mon, 4 May 2020 17:12:36 +0200
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
Subject: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504151236.GI8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200429105941.GQ30814@suse.de>
 <20200429082854.6e1796b5@oasis.local.home>
 <20200429100731.201312a9@gandalf.local.home>
 <20200430141120.GA8135@suse.de>
 <20200430121136.6d7aeb22@gandalf.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430223919.50861011@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:39:19PM -0400, Steven Rostedt wrote:
> What's so damn special about alloc_percpu()? It's definitely not a fast
> path. And it's not used often.

Okay, I fixed it in the percpu code. It is definitly not a nice
solution, but having to call vmalloc_sync_mappings/unmappings() is not a
nice solution at any place in the code. Here is the patch which fixes
this issue for me. I am also not sure what to put in the Fixes tag, as
it is related to tracing code accessing per-cpu data from the page-fault
handler, not sure when this got introduced. Maybe someone else can
provide a meaningful Fixes- or stable tag.

I also have an idea in mind how to make this all more robust and get rid
of the vmalloc_sync_mappings/unmappings() interface, will show more when
I know it works the way I think it does.

Regards,

	Joerg

From c616a9a09499f9c9d682775767d3de7db81fb2ed Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Mon, 4 May 2020 17:11:41 +0200
Subject: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()

Sync the vmalloc mappings for all page-tables in the system when
allocating and freeing per-cpu memory. This is necessary for
architectures which use page-faults on vmalloc areas.

The page-fault handlers accesses per-cpu data when tracing is enabled,
and fauling again in the page-fault handler on a vmalloc'ed per-cpu area
will result in a recursive fault.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 mm/percpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index d7e3bc649f4e..6ab035bc6977 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1710,6 +1710,20 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	trace_percpu_alloc_percpu(reserved, is_atomic, size, align,
 			chunk->base_addr, off, ptr);
 
+	/*
+	 * The per-cpu buffers might be allocated in the vmalloc area of the
+	 * address space. When the architecture allows faulting on the vmalloc
+	 * area and the memory allocated here is accessed in the page-fault
+	 * handler, the vmalloc area fault may be recursive and could never be
+	 * resolved.
+	 * This happens for example in the tracing code which allocates per-cpu
+	 * and accesses them when tracing page-faults.
+	 * To prevent this, make sure the per-cpu buffers allocated here are
+	 * mapped in all PGDs so that the page-fault handler will never fault
+	 * again on them.
+	 */
+	vmalloc_sync_mappings();
+
 	return ptr;
 
 fail_unlock:
@@ -1958,6 +1972,12 @@ void free_percpu(void __percpu *ptr)
 
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
 
+	/*
+	 * See comment at the vmalloc_sync_mappings() call in pcpu_alloc() for
+	 * why this is necessary.
+	 */
+	vmalloc_sync_unmappings();
+
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	if (need_balance)
-- 
2.12.3

