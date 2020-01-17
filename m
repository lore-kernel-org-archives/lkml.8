Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F642C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B71520684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djKQVSH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAQDxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:53:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60471 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729110AbgAQDxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579233222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LVghNsjkwzZgb//eJukU2qlgWLDg3WtK8FvODGeUu0Q=;
        b=djKQVSH/5GNKtDckKD6G8UHzR6wcPzwv8HZ2/7SBqqk8XRv7DZlsbGNAo9FVJBr0fI2DP9
        9aCr9rZlRAiD7ce/blkn6DjwafKAcCmHyK72k4HHy2nwgatgL2rtSTm1pbEu4Zi7KzjGyC
        ybZWDa/X8f5XgxH5aVKl86F7eBg7WFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-jZ8McRMOOKGR6bV5FNeOmA-1; Thu, 16 Jan 2020 22:53:41 -0500
X-MC-Unique: jZ8McRMOOKGR6bV5FNeOmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5161005510;
        Fri, 17 Jan 2020 03:53:40 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B57B488872;
        Fri, 17 Jan 2020 03:53:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH V2] sched/isolation: isolate from handling managed interrupt
Date:   Fri, 17 Jan 2020 11:53:26 +0800
Message-Id: <20200117035326.20659-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can't change managed interrupt's affinity via /proc interface,
however, applications often require the specified isolated CPUs not
disturbed by interrupts.

Add sub-parameter 'managed_irq' for 'isolcpus', so that we can isolate
from handling managed interrupt.

Not select irq effective CPU from isolated CPUs if the interrupt affinity
includes at least one housekeeping CPU. This way guarantees that isolated
CPUs won't be interrupted by managed irq if IO isn't submitted from any
isolated CPU.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- not allocate cpumask in context with irq_desc::lock held
	- deal with cpu hotplug race with new flag of IRQD_MANAGED_FORCE_MIGRATE
	- use comment doc from Thomas


 .../admin-guide/kernel-parameters.txt         |  9 +++++
 include/linux/irq.h                           |  8 ++++
 include/linux/sched/isolation.h               |  1 +
 kernel/irq/cpuhotplug.c                       |  6 ++-
 kernel/irq/manage.c                           | 37 ++++++++++++++++++-
 kernel/sched/isolation.c                      |  6 +++
 6 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..e0f18ac866d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1933,6 +1933,15 @@
 			  <cpu number> begins at 0 and the maximum value is
 			  "number of CPUs in system - 1".
=20
+			managed_irq
+			  Isolate from handling managed interrupt. Userspace can't
+			  change managed interrupt's affinity via /proc interface,
+			  however application often requires the specified isolated
+			  CPUs not disturbed by interrupts. This way guarantees that
+			  isolated CPU won't be interrupted if IO isn't submitted
+			  from isolated CPU when managed interrupt is used by IO
+			  drivers.
+
 			The format of <cpu-list> is described above.
=20
=20
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7853eb9301f2..0a6bd1c56205 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -209,6 +209,8 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
+ * IRQD_MANAGED_FORCE_MIGRATE	- Force to migrate irq after one CPU in it=
s
+ *				  affinity becomes online
  */
 enum {
 	IRQD_TRIGGER_MASK		=3D 0xf,
@@ -231,6 +233,7 @@ enum {
 	IRQD_SINGLE_TARGET		=3D (1 << 24),
 	IRQD_DEFAULT_TRIGGER_SET	=3D (1 << 25),
 	IRQD_CAN_RESERVE		=3D (1 << 26),
+	IRQD_MANAGED_FORCE_MIGRATE	=3D (1 << 27),
 };
=20
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accesso=
rs)
@@ -390,6 +393,11 @@ static inline bool irqd_can_reserve(struct irq_data =
*d)
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
=20
+static inline bool irqd_managed_force_migrate(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_MANAGED_FORCE_MIGRATE;
+}
+
 #undef __irqd_to_state
=20
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolat=
ion.h
index 6c8512d3be88..0fbcbacd1b29 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -13,6 +13,7 @@ enum hk_flags {
 	HK_FLAG_TICK		=3D (1 << 4),
 	HK_FLAG_DOMAIN		=3D (1 << 5),
 	HK_FLAG_WQ		=3D (1 << 6),
+	HK_FLAG_MANAGED_IRQ	=3D (1 << 7),
 };
=20
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 6c7ca2e983a5..20c7704ce019 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -77,7 +77,8 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * Note: Do not check desc->action as this might be a chained
 	 * interrupt.
 	 */
-	if (irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d)) {
+	if ((irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d))
+			&& !irqd_managed_force_migrate(d)) {
 		/*
 		 * If an irq move is pending, abort it if the dying CPU is
 		 * the sole target.
@@ -192,6 +193,9 @@ static void irq_restore_affinity_of_irq(struct irq_de=
sc *desc, unsigned int cpu)
 	 */
 	if (!irqd_is_single_target(data))
 		irq_set_affinity_locked(data, affinity, false);
+
+	if (irqd_managed_force_migrate(data))
+		migrate_one_irq(desc);
 }
=20
 /**
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..046329f2d39a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
+#include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
=20
@@ -213,11 +214,45 @@ int irq_do_set_affinity(struct irq_data *data, cons=
t struct cpumask *mask,
 	struct irq_desc *desc =3D irq_data_to_desc(data);
 	struct irq_chip *chip =3D irq_data_get_irq_chip(data);
 	int ret;
+	const struct cpumask *mask_to_set =3D mask;
=20
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
=20
-	ret =3D chip->irq_set_affinity(data, mask, force);
+	/*
+	 * If this is a managed interrupt check whether the requested
+	 * affinity mask intersects with a housekeeping CPU. If so, then
+	 * remove the isolated CPUs from the mask and just keep the
+	 * housekeeping CPU(s). This prevents the affinity setter from
+	 * routing the interrupt to an isolated CPU to avoid that I/O
+	 * submitted from a housekeeping CPU causes interrupts on an
+	 * isolated one.
+	 *
+	 * If the masks do not intersect or include online CPU(s) then
+	 * keep the requested mask. The isolated target CPUs are only
+	 * receiving interrupts when the I/O operation was submitted
+	 * directly from them.
+	 *
+	 * If all housekeeping CPUs are offline, 'FORCE_MIGRATE' is set
+	 * so that we can migrate the irq from isolate CPU when any
+	 * housekeeping CPU becomes online.
+	 */
+	if (irqd_affinity_is_managed(data)) {
+		static struct cpumask tmp_mask;
+		const struct cpumask *housekeeping =3D
+			housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+
+		if (cpumask_intersects(mask, housekeeping)) {
+			cpumask_and(&tmp_mask, mask, housekeeping);
+			if (cpumask_intersects(&tmp_mask, cpu_online_mask)) {
+				mask_to_set =3D &tmp_mask;
+				irqd_clear(data, IRQD_MANAGED_FORCE_MIGRATE);
+			} else {
+				irqd_set(data, IRQD_MANAGED_FORCE_MIGRATE);
+			}
+		}
+	}
+	ret =3D chip->irq_set_affinity(data, mask_to_set, force);
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 9fcb2a695a41..008d6ac2342b 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -163,6 +163,12 @@ static int __init housekeeping_isolcpus_setup(char *=
str)
 			continue;
 		}
=20
+		if (!strncmp(str, "managed_irq,", 12)) {
+			str +=3D 12;
+			flags |=3D HK_FLAG_MANAGED_IRQ;
+			continue;
+		}
+
 		pr_warn("isolcpus: Error, unknown flag\n");
 		return 0;
 	}
--=20
2.20.1

