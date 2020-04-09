Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E0FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FB020757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="V6uA8uRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgDITgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:47216 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgDITgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4943728109F;
        Thu,  9 Apr 2020 15:36:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JnZREeYoa-WA; Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 81984280F61;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 81984280F61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460959;
        bh=N8TR0WBVz7Tv+O6fhb3AiUPKDYJHpnVQhxqixbF58TU=;
        h=From:To:Date:Message-Id;
        b=V6uA8uRMceSCMBYKENb90JPRfqzw+pAhRrJSTH1B7mUvzXjb60PSnvoHZQRRPsnJq
         Puwc2IwMmgWG0QhVXxHb6nRrUzL8mxkVK0yrD+Ad4xk7Eurb2a5HPCu5D/kfB6vR+4
         bx1Z7cjUa7poTL37OmnmQyZpvXZHFxc+LgM1xVlofD9/r8569/WvoMbbEI1v+zkzDX
         AhOJfAK7oQ9WnvQk26HiD3g+ECKdn1ohG+zzuPDdMfkeGxzMDJWh7Zf+N9dVcPFpdh
         uVoUVAm6hQvdWF6Q+iGXr+q3gGWIxTLduIxFhRXcToOENnlyWZlc2EZ/iddmAIQ5An
         8hhd8eatcr8eg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LIQbuK6txhh7; Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id B57DA280CC0;
        Thu,  9 Apr 2020 15:35:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 5/9] sched: export-GPL task_prio
Date:   Thu,  9 Apr 2020 15:35:39 -0400
Message-Id: <20200409193543.18115-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting the task_prio() symbol to GPL modules is useful for kernel
tracers implemented as kernel modules. It exports information which is
already available through /proc in a way which allows it to be sampled
by kernel tracers with low overhead.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2694ba82874..f87cffef317a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4629,6 +4629,7 @@ int task_prio(const struct task_struct *p)
 {
 	return p->prio - MAX_RT_PRIO;
 }
+EXPORT_SYMBOL_GPL(task_prio);
 
 /**
  * idle_cpu - is a given CPU idle currently?
-- 
2.17.1

