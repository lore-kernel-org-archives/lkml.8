Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF78C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326E320BED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TCZFEv3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDITgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:47112 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgDITf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:35:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4140E28097A;
        Thu,  9 Apr 2020 15:35:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IE779iNZWAwn; Thu,  9 Apr 2020 15:35:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DFA12280E4B;
        Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DFA12280E4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460957;
        bh=0dePxRXcfutRxle9mYRPSErG+aeuVue92CDCEU7DCD8=;
        h=From:To:Date:Message-Id;
        b=TCZFEv3eAEJL+N2h18QkDUzQbP6X6tKngFQwxeFruCoqwE/NbEhHhvvcLlyEGWsMz
         NQAb96Tw2CajvC/BMamNPsJBNOuAyZTA4yxwKVAfboF0n3lEcNbtlLHBDHwf98J8Fp
         sO9pvzz2+EYOYJwfhFwve5cqm7VzcxFghn5SR/8O0hfrp5kke/IcuOvGbc0WYtlJRp
         525UxHuVxnT+iJ21xk7kjpTgRJJnm3ESL4Rdiu6pJKZUIVFQhZ9UQQqQKOLBTy1BOV
         4BIUAPoGIzrBDsFMsKUKuoevo1XElXPgTm5YMwYsEJwbrOjVUWYU2l/XXDGs87GAC2
         z7fJVwRF4GJ3g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4U-igWP0RGtR; Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 84FFB280F50;
        Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH 1/9] tracepoint: call vmalloc_sync_mappings() on registration
Date:   Thu,  9 Apr 2020 15:35:35 -0400
Message-Id: <20200409193543.18115-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to register_die_notifier(), tracepoints register callbacks
which can be invoked from execution contexts such as the page fault
handler and NMIs which should not generate a page fault. Those callbacks
can access virtual mappings and can be implemented in modules.

Calling vmalloc_sync_mappings() before registering a tracepoint callback
ensures that the virtual mappings are synchronized within each process
page tables, thus ensuring that no page fault will be triggered by the
callback.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/tracepoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 73956eaff8a9..82191a89c72e 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -14,6 +14,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
+#include <linux/vmalloc.h>
 
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
@@ -308,6 +309,7 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 	struct tracepoint_func tp_func;
 	int ret;
 
+	vmalloc_sync_mappings();
 	mutex_lock(&tracepoints_mutex);
 	tp_func.func = probe;
 	tp_func.data = data;
-- 
2.17.1

