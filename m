Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F94120853
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823982;
	bh=wTaUMCm6MSW1jvD4dj3eMAa7vjgtXNySyMYn6acQZQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDbsnJYTvbj9EaZEtOqDFF+Ge37wHsG0ZqzKh1lYNBV0AXJDvpgx/fALbBT4efiVn
	 Y7bftor8rM46yCJMGoDC3zxb5fFsqXBpQC8Qn9IL8Y8n7VvPfHY7X8l1fLmrFOgTyK
	 tRuHpR/59mzDKGNbAcpn9COj4pa4HTQ2QbtigxOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgERRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbgERRqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:46:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC66020657;
        Mon, 18 May 2020 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823977;
        bh=wTaUMCm6MSW1jvD4dj3eMAa7vjgtXNySyMYn6acQZQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zd+jYGiwomCwE0cDytHRdEpyg6nzkkqLdrunLBuWSRC/mWmePTSHWjXSs0sb9fKgW
         +ntmE+FHuSYYvPUnPOGV1SKOZC/G9LbiryFGCY4reQI1BGSjUCdtow57yN4Zk73ty7
         85s1tQdv7eLr0+CDBDCG+zZ5H8nK4SPSmCkqDCzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 021/114] tracing: Add a vmalloc_sync_mappings() for safe measure
Date:   Mon, 18 May 2020 19:35:53 +0200
Message-Id: <20200518173507.540177073@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 11f5efc3ab66284f7aaacc926e9351d658e2577b upstream.

x86_64 lazily maps in the vmalloc pages, and the way this works with per_cpu
areas can be complex, to say the least. Mappings may happen at boot up, and
if nothing synchronizes the page tables, those page mappings may not be
synced till they are used. This causes issues for anything that might touch
one of those mappings in the path of the page fault handler. When one of
those unmapped mappings is touched in the page fault handler, it will cause
another page fault, which in turn will cause a page fault, and leave us in
a loop of page faults.

Commit 763802b53a42 ("x86/mm: split vmalloc_sync_all()") split
vmalloc_sync_all() into vmalloc_sync_unmappings() and
vmalloc_sync_mappings(), as on system exit, it did not need to do a full
sync on x86_64 (although it still needed to be done on x86_32). By chance,
the vmalloc_sync_all() would synchronize the page mappings done at boot up
and prevent the per cpu area from being a problem for tracing in the page
fault handler. But when that synchronization in the exit of a task became a
nop, it caused the problem to appear.

Link: https://lore.kernel.org/r/20200429054857.66e8e333@oasis.local.home

Cc: stable@vger.kernel.org
Fixes: 737223fbca3b1 ("tracing: Consolidate buffer allocation code")
Reported-by: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7666,6 +7666,19 @@ static int allocate_trace_buffers(struct
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
+	 * event. Oh, and we need to audit all other alloc_percpu() and vmalloc()
+	 * calls in tracing, because something might get triggered within a
+	 * page fault trace event!
+	 */
+	vmalloc_sync_mappings();
+
 	return 0;
 }
 


