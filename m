Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB3C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F592072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfqRvgnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgCWNyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:54:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35589 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728423AbgCWNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584971691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=h/N1Tz5UvHY+DtE4D6y3RBtUqHZKCHB4T/g1xCk5vG4=;
        b=HfqRvgnbU8diG68+P4Mk4nMS6yZwo50lVnSN0GT2dtQgL2biHhBmtRl/8ONv8dXHffo5VZ
        wIGMBaScEVOoXIH9fHHfvvo5Y8QlR3vEkB9RJ8+94K6ZkJDeE4myYH5NP+CxKAfZXv9xzm
        2JYAA7lghWL5IJ/TjQfBB53VEeT4jnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-dLrcXMpwNK-QTDhNMOedMQ-1; Mon, 23 Mar 2020 09:54:47 -0400
X-MC-Unique: dLrcXMpwNK-QTDhNMOedMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21CB4800D54;
        Mon, 23 Mar 2020 13:54:46 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-9.gru2.redhat.com [10.97.116.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 789CA10027AE;
        Mon, 23 Mar 2020 13:54:45 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EB5AC416C887; Mon, 23 Mar 2020 10:54:14 -0300 (-03)
Date:   Mon, 23 Mar 2020 10:54:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>, Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] affine kernel threads to specified cpumask
Message-ID: <20200323135414.GA28634@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a kernel enhancement to configure the cpu affinity of kernel
threads via kernel boot option kthread_cpus=<cpulist>.

With kthread_cpus specified, the cpumask is immediately applied upon
thread launch. This does not affect kernel threads that specify cpu
and node.

This allows CPU isolation (that is not allowing certain threads
to execute on certain CPUs) without using the isolcpus= parameter,
making it possible to enable load balancing on such CPUs 
during runtime.

Note-1: this is based off on MontaVista's patch at
https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

Difference being that this patch is limited to modifying
kernel thread cpumask: Behaviour of other threads can 
be controlled via cgroups or sched_setaffinity.

Note-2: MontaVista's patch was based off Christoph Lameter's patch at
https://lwn.net/Articles/565932/ with the only difference being
the kernel parameter changed from kthread to kthread_cpus.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

 Documentation/admin-guide/kernel-parameters.txt |    6 +++++
 include/linux/cpumask.h                         |    5 ++++
 init/main.c                                     |    1 
 kernel/cpu.c                                    |   26 ++++++++++++++++++++++++
 kernel/kthread.c                                |    4 +--
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..c434c7dac5e4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2103,6 +2103,12 @@
 			0: force disabled
 			1: force enabled
 
+	kthread_cpus=	[KNL, SMP] Only run kernel threads on the specified
+			list of processors. The kernel will start threads
+			on the indicated processors only (unless there
+			are specific reasons to run a thread with
+			different affinities).
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d5cc88514aee..a0dc4b12e048 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -55,6 +55,7 @@ extern unsigned int nr_cpu_ids;
  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
+ *     cpu_kthread_mask - has bit 'cpu' set iff general kernel threads allowed
  *
  *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
  *
@@ -91,10 +92,12 @@ extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
+extern struct cpumask __cpu_kthread_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
+#define cpu_kthread_mask  ((const struct cpumask *)&__cpu_kthread_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -145,6 +148,8 @@ static inline unsigned int cpumask_check(unsigned int cpu)
 	return cpu;
 }
 
+int __init init_kthread_cpumask(void);
+
 #if NR_CPUS == 1
 /* Uniprocessor.  Assume all masks are "1". */
 static inline unsigned int cpumask_first(const struct cpumask *srcp)
diff --git a/init/main.c b/init/main.c
index ee4947af823f..69f528ddc477 100644
--- a/init/main.c
+++ b/init/main.c
@@ -618,6 +618,7 @@ noinline void __ref rest_init(void)
 	int pid;
 
 	rcu_scheduler_starting();
+	init_kthread_cpumask();
 	/*
 	 * We need to spawn init first so that it obtains pid 1, however
 	 * the init task will end up wanting to create kthreads, which, if
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..c521ea82b76f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2311,9 +2311,35 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+struct cpumask __cpu_kthread_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_kthread_mask);
+
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
+static struct cpumask user_cpu_kthread_mask __read_mostly;
+static int user_cpu_kthread_mask_valid __read_mostly;
+
+int __init init_kthread_cpumask(void)
+{
+	if (user_cpu_kthread_mask_valid == 1)
+		cpumask_copy(&__cpu_kthread_mask, &user_cpu_kthread_mask);
+	else
+		cpumask_copy(&__cpu_kthread_mask, cpu_all_mask);
+
+	return 0;
+}
+
+static int __init kthread_setup(char *str)
+{
+	cpulist_parse(str, &user_cpu_kthread_mask);
+	if (!cpumask_empty(&user_cpu_kthread_mask))
+		user_cpu_kthread_mask_valid = 1;
+
+	return 1;
+}
+__setup("kthread_cpus=", kthread_setup);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f47046ca..be9c8d53a986 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -347,7 +347,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_all_mask);
+		set_cpus_allowed_ptr(task, cpu_kthread_mask);
 	}
 	kfree(create);
 	return task;
@@ -572,7 +572,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_all_mask);
+	set_cpus_allowed_ptr(tsk, cpu_kthread_mask);
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;

