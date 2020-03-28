Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D3C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CE8207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKSBMGAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC1P2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:28:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55947 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbgC1P17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585409278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E6R+2cTMmywbuz7qW69vCKU2mmpRr6JrLiKhWYDI1s4=;
        b=UKSBMGAL87KrMZkaeqVojTE6n3bFMBmGDTS+qLkxV62Xxhq0oRzhOMZzy1dxewR+zP4fAD
        rk99gWUIQC5s19G8lzRVBnisQsK4VDmjAbc1UxyAZf8M4VOjbazaqof1KcKA1YPiBnQRw3
        OSj4T8HY63kHfkr/x31JJqOr0f/LkMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-IXy0Z7PNPC-1q_oLVLtVgQ-1; Sat, 28 Mar 2020 11:27:54 -0400
X-MC-Unique: IXy0Z7PNPC-1q_oLVLtVgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFACC800D5C;
        Sat, 28 Mar 2020 15:27:52 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ACB819C7F;
        Sat, 28 Mar 2020 15:27:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 511314198B3C; Sat, 28 Mar 2020 12:27:27 -0300 (-03)
Message-ID: <20200328152503.225876188@redhat.com>
User-Agent: quilt/0.66
Date:   Sat, 28 Mar 2020 12:21:19 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/3] isolcpus: affine kernel threads to specified cpumask
References: <20200328152117.881555226@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel enhancement to configure the cpu affinity of kernel threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>

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
 Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
 include/linux/sched/isolation.h                 |    1 +
 kernel/kthread.c                                |    6 ++++--
 kernel/sched/isolation.c                        |    6 ++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
@@ -1959,6 +1959,14 @@
 			  the CPU affinity syscalls or cpuset.
 			  <cpu number> begins at 0 and the maximum value is
 			  "number of CPUs in system - 1".
+			  When using cpusets, use the isolcpus option "kthread"
+			  to avoid creation of kernel threads on isolated CPUs.
+
+			kthread
+			  Adjust the CPU affinity mask of unbound kernel threads to
+			  not contain CPUs on the isolated list. This complements
+			  the isolation provided by the cpusets mechanism described
+			  above and by managed_irq option.
 
 			managed_irq
 
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
@@ -169,6 +169,12 @@ static int __init housekeeping_isolcpus_
 			continue;
 		}
 
+		if (!strncmp(str, "kthread,", 8)) {
+			str += 8;
+			flags |= HK_FLAG_KTHREAD;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}


