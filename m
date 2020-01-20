Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5DC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6447020684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JucvU8Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATJQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:16:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgATJQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579511803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3nhshWWLkpieH3MHa4qSdIugCEnwJsw24nQRATXXfLM=;
        b=JucvU8Cm5SLvH8bMKn1s1aVGYaRIYuZlr/BRqXAVZwxZslQBkIvPjZErXEKgyZV4dISab+
        ND654V7+dU4LrItFQy+l4qBjQ5+YyuSPESwOrlGHroVFfk6pALYgLYR6AA9h0EY06j+uKc
        E8tDdozc0IjAx4XBOMyEwcKpFbVuNFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ry2Ty5UwNyimnwwrZy6U9w-1; Mon, 20 Jan 2020 04:16:39 -0500
X-MC-Unique: ry2Ty5UwNyimnwwrZy6U9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE148800D4E;
        Mon, 20 Jan 2020 09:16:38 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529085D9D6;
        Mon, 20 Jan 2020 09:16:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH V4] sched/isolation: isolate from handling managed interrupt
Date:   Mon, 20 Jan 2020 17:16:25 +0800
Message-Id: <20200120091625.17912-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
V4:
	- patch style fix
	- avoid unnecessary checks in hk_should_isolate()
V3:
	- add global lock to protect the global temporary cpumask
	- use delayed irq migration as suggested by Thomas=20
V2:
	- not allocate cpumask in context with irq_desc::lock held
	- deal with cpu hotplug race with new flag of IRQD_MANAGED_FORCE_MIGRATE
	- use comment doc from Thomas

 .../admin-guide/kernel-parameters.txt         |  9 +++++
 include/linux/sched/isolation.h               |  1 +
 kernel/irq/cpuhotplug.c                       | 19 ++++++++-
 kernel/irq/manage.c                           | 39 ++++++++++++++++++-
 kernel/sched/isolation.c                      |  6 +++
 5 files changed, 72 insertions(+), 2 deletions(-)

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
index 6c7ca2e983a5..fbcba938a771 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/ratelimit.h>
 #include <linux/irq.h>
+#include <linux/sched/isolation.h>
=20
 #include "internals.h"
=20
@@ -171,6 +172,21 @@ void irq_migrate_all_off_this_cpu(void)
 	}
 }
=20
+static bool hk_should_isolate(struct irq_data *data,
+			      const struct cpumask *affinity, unsigned int cpu)
+{
+	const struct cpumask *hk_mask;
+
+	if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
+		return false;
+
+	hk_mask =3D housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+	if (cpumask_subset(irq_data_get_effective_affinity_mask(data), hk_mask)=
)
+		return false;
+
+	return cpumask_test_cpu(cpu, hk_mask);
+}
+
 static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned =
int cpu)
 {
 	struct irq_data *data =3D irq_desc_get_irq_data(desc);
@@ -190,7 +206,8 @@ static void irq_restore_affinity_of_irq(struct irq_de=
sc *desc, unsigned int cpu)
 	 * CPU then it is already assigned to a CPU in the affinity
 	 * mask. No point in trying to move it around.
 	 */
-	if (!irqd_is_single_target(data))
+	if (!irqd_is_single_target(data) ||
+	    hk_should_isolate(data, affinity, cpu))
 		irq_set_affinity_locked(data, affinity, false);
 }
=20
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..6c0e06c0d6d8 100644
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
@@ -217,7 +218,43 @@ int irq_do_set_affinity(struct irq_data *data, const=
 struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
=20
-	ret =3D chip->irq_set_affinity(data, mask, force);
+	/*
+	 * If this is a managed interrupt and housekeeping is enabled on
+	 * it check whether the requested affinity mask intersects with
+	 * a housekeeping CPU. If so, then remove the isolated CPUs from
+	 * the mask and just keep the housekeeping CPU(s). This prevents
+	 * the affinity setter from routing the interrupt to an isolated
+	 * CPU to avoid that I/O submitted from a housekeeping CPU causes
+	 * interrupts on an isolated one.
+	 *
+	 * If the masks do not intersect or include online CPU(s) then
+	 * keep the requested mask. The isolated target CPUs are only
+	 * receiving interrupts when the I/O operation was submitted
+	 * directly from them.
+	 *
+	 * If all housekeeping CPUs in the affinity mask are offline,
+	 * we will migrate the irq from isolate CPU when any housekeeping
+	 * CPU in the mask becomes online.
+	 */
+	if (irqd_affinity_is_managed(data) &&
+	    housekeeping_enabled(HK_FLAG_MANAGED_IRQ)) {
+		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
+		static struct cpumask tmp_mask;
+		const struct cpumask *hk_mask, *prog_mask;
+
+		hk_mask =3D housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
+
+		raw_spin_lock(&tmp_mask_lock);
+		cpumask_and(&tmp_mask, mask, hk_mask);
+		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
+			prog_mask =3D mask;
+		else
+			prog_mask =3D &tmp_mask;
+		ret =3D chip->irq_set_affinity(data, prog_mask, force);
+		raw_spin_unlock(&tmp_mask_lock);
+	} else {
+		ret =3D chip->irq_set_affinity(data, mask, force);
+	}
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

