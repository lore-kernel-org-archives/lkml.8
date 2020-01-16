Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE41C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FC120661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FICHmaE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgAPJsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:48:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgAPJsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579168114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jQUfRvThpvCpmExVhDXPSctOGTZhMUj3J1KVohZFS0U=;
        b=FICHmaE1tkP5fY72HeY8dDMrn7CzlPvIJxTW8+p6QQr8QoMjEzwgxywDUYbVuQDB6a+cJG
        RGxoHD7QbXVja1uJj/1i6Xz0HZeU1vky/rdMRscPtTC+hsE2ekRmqVpaeLniBGffYZEmwW
        adK6yeWwx2JldDsRfVytmsWXu4QuqrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-fRAPxkJKN5KLUUn6k_w3xQ-1; Thu, 16 Jan 2020 04:48:32 -0500
X-MC-Unique: fRAPxkJKN5KLUUn6k_w3xQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259D8107ACC5;
        Thu, 16 Jan 2020 09:48:31 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3955784333;
        Thu, 16 Jan 2020 09:48:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/isolation: isolate from handling managed interrupt
Date:   Thu, 16 Jan 2020 17:48:06 +0800
Message-Id: <20200116094806.25372-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can't change managed interrupt's affinity via /proc interface,
however application often requires the specified isolated CPUs not
disturbed by interrupts.

Add sub-parameter 'managed_irq' for 'isolcpus', so that we can isolate
from handling managed interrupt.

Not select isolated CPU as effective CPU if the interupt affinity include=
s
at least one housekeeping CPU. This way guarantees that isolated CPUs won=
't
be interrupted by managed irq if IO isn't submitted from any isolated CPU=
.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++++
 include/linux/sched/isolation.h               |  1 +
 kernel/irq/manage.c                           | 22 ++++++++++++++++++-
 kernel/sched/isolation.c                      |  6 +++++
 4 files changed, 37 insertions(+), 1 deletion(-)

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
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..9cc972d28d3c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/sched/isolation.h>
=20
 #include "internals.h"
=20
@@ -212,12 +213,29 @@ int irq_do_set_affinity(struct irq_data *data, cons=
t struct cpumask *mask,
 {
 	struct irq_desc *desc =3D irq_data_to_desc(data);
 	struct irq_chip *chip =3D irq_data_get_irq_chip(data);
+	const struct cpumask *housekeeping_mask =3D
+		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
 	int ret;
+	cpumask_var_t tmp_mask =3D (struct cpumask *)mask;
=20
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
=20
-	ret =3D chip->irq_set_affinity(data, mask, force);
+	zalloc_cpumask_var(&tmp_mask, GFP_ATOMIC);
+
+	/*
+	 * Userspace can't change managed irq's affinity, make sure that
+	 * isolated CPU won't be selected as the effective CPU if this
+	 * irq's affinity includes at least one housekeeping CPU.
+	 *
+	 * This way guarantees that isolated CPU won't be interrupted if
+	 * IO isn't submitted from isolated CPU.
+	 */
+	if (irqd_affinity_is_managed(data) && tmp_mask &&
+			cpumask_intersects(mask, housekeeping_mask))
+		cpumask_and(tmp_mask, mask, housekeeping_mask);
+
+	ret =3D chip->irq_set_affinity(data, tmp_mask, force);
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
@@ -229,6 +247,8 @@ int irq_do_set_affinity(struct irq_data *data, const =
struct cpumask *mask,
 		ret =3D 0;
 	}
=20
+	free_cpumask_var(tmp_mask);
+
 	return ret;
 }
=20
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

