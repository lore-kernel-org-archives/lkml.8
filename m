Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D0BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34C420737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq8rCVzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbgDCKiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:38:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727774AbgDCKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585910293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVfyrQgIBYChI4abqRsONhhsSKmZj+091grZ9ZJHkjc=;
        b=Mq8rCVzkg/RSZbdhRGszswweMQi+1AhRqpWax41lpnzOI/SFOs13aAX45Dy6S5L6WqJy2h
        JQmansaqoX+MJbaPKh49/4CXy/TqAJWxPqDOPHyoiiX/4Eg0H3FpDM1wm9ZXuXmJ0RHMuE
        JrMTfUySIpFlm1eg3n2tGuwuQ6QNAVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-obREJ46jPRmRmkAngzWlZQ-1; Fri, 03 Apr 2020 06:38:09 -0400
X-MC-Unique: obREJ46jPRmRmkAngzWlZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C12107ACC7;
        Fri,  3 Apr 2020 10:38:08 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-209.gru2.redhat.com [10.97.116.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 923165C1D6;
        Fri,  3 Apr 2020 10:38:07 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 095F7416C88B; Fri,  3 Apr 2020 07:37:20 -0300 (-03)
Date:   Fri, 3 Apr 2020 07:37:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: [patch 3/4 v2] isolcpus: affine kernel threads to housekeeping cpus
Message-ID: <20200403103719.GA17016@fuller.cnet>
References: <20200401121018.104226700@redhat.com>
 <20200401121342.979811840@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401121342.979811840@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel enhancement that configures the cpu affinity of kernel
threads via kernel boot option nohz_full=.

When this option is specified, the cpumask is immediately applied upon
thread launch. This does not affect kernel threads that specify cpu
and node.

This allows CPU isolation (that is not allowing certain threads
to execute on certain CPUs) without using the isolcpus=domain parameter,
making it possible to enable load balancing on such CPUs
during runtime (see kernel-parameters.txt).

Note-1: this is based off on Wind River's patch at
https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

Difference being that this patch is limited to modifying
kernel thread cpumask: Behaviour of other threads can
be controlled via cgroups or sched_setaffinity.

Note-2: Wind River's patch was based off Christoph Lameter's patch at
https://lwn.net/Articles/565932/ with the only difference being
the kernel parameter changed from kthread to kthread_cpus.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/sched/isolation.h                 |    1 +
 kernel/kthread.c                                |    6 ++++--
 kernel/sched/isolation.c                        |    6 ++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/sched/isolation.h
===================================================================
--- linux-2.6.orig/include/linux/sched/isolation.h
+++ linux-2.6/include/linux/sched/isolation.h
@@ -14,6 +14,7 @@ enum hk_flags {
 	HK_FLAG_DOMAIN		= (1 << 5),
 	HK_FLAG_WQ		= (1 << 6),
 	HK_FLAG_MANAGED_IRQ	= (1 << 7),
+	HK_FLAG_KTHREAD		= (1 << 8),
 };
 
 #ifdef CONFIG_CPU_ISOLATION
Index: linux-2.6/kernel/kthread.c
===================================================================
--- linux-2.6.orig/kernel/kthread.c
+++ linux-2.6/kernel/kthread.c
@@ -23,6 +23,7 @@
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
 #include <linux/numa.h>
+#include <linux/sched/isolation.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -347,7 +348,8 @@ struct task_struct *__kthread_create_on_
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_possible_mask);
+		set_cpus_allowed_ptr(task,
+				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
@@ -572,7 +574,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
+	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
Index: linux-2.6/kernel/sched/isolation.c
===================================================================
--- linux-2.6.orig/kernel/sched/isolation.c
+++ linux-2.6/kernel/sched/isolation.c
@@ -141,7 +141,7 @@ static int __init housekeeping_nohz_full
 	unsigned int flags;
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_SCHED;
+		HK_FLAG_MISC | HK_FLAG_SCHED | HK_FLAG_KTHREAD;
 
 	return housekeeping_setup(str, flags);
 }

