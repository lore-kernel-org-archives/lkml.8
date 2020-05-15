Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA86C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D9D20756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589561887;
	bh=QGBXpFt7viQ/s9CvwVxNUaRgPogVbc6WCoViHqmYZU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mr676Safit27uaImiS6AeFOUeavNstQRIl+fhc9kDeOTNo/rzwAifVYHFZUlHyjG8
	 lyN5ldEsSy2fFLJOV7DK9sJBqs05BNEBpICgzTDbEeEc7trE1sEGh3GGEzGUuh2Yny
	 f1EwvjCYVs6AvNp2bkYI1y3JYsDIxnJ++AZJW0bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgEOQ6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEOQ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:58:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9001120727;
        Fri, 15 May 2020 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589561883;
        bh=QGBXpFt7viQ/s9CvwVxNUaRgPogVbc6WCoViHqmYZU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hF8ISJmFrSr/NGrTOCireeO22o+TtoBSdBJBzBw0EjX3JpJcCewQrJM6nYKZP7Y0w
         +jzvWU2Nlp2lyhHWdqLwQ2iaUzNUIKpPhdjpCQQ5MWCrXcTskXuPfr2r8lna6IiRZj
         bh1UZ/Xzk79RwxvWNcQS2kTY6oGW2fCnoV4H6IkM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZder-00Cdec-VC; Fri, 15 May 2020 17:58:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     John Garry <john.garry@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: [PATCH v4 1/2] irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
Date:   Fri, 15 May 2020 17:57:51 +0100
Message-Id: <20200515165752.121296-2-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515165752.121296-1-maz@kernel.org>
References: <20200515165752.121296-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, john.garry@huawei.com, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve the distribution of LPIs among CPUs, let start by
tracking the number of LPIs assigned to CPUs, both for managed and
non-managed interrupts (as separate counters).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 49 ++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 124251b0ccba..4eb8441d0c2b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -174,6 +174,13 @@ static struct {
 	int			next_victim;
 } vpe_proxy;
 
+struct cpu_lpi_count {
+	atomic_t	managed;
+	atomic_t	unmanaged;
+};
+
+static DEFINE_PER_CPU(struct cpu_lpi_count, cpu_lpi_count);
+
 static LIST_HEAD(its_nodes);
 static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
@@ -1510,6 +1517,30 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
 
+static __maybe_unused u32 its_read_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+
+	return atomic_read(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static void its_inc_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+	else
+		atomic_inc(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
+static void its_dec_lpi_count(struct irq_data *d, int cpu)
+{
+	if (irqd_affinity_is_managed(d))
+		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->managed);
+	else
+		atomic_dec(&per_cpu_ptr(&cpu_lpi_count, cpu)->unmanaged);
+}
+
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
@@ -1518,34 +1549,44 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_collection *target_col;
 	u32 id = its_get_event_id(d);
+	int prev_cpu;
 
 	/* A forwarded interrupt should use irq_set_vcpu_affinity */
 	if (irqd_is_forwarded_to_vcpu(d))
 		return -EINVAL;
 
+	prev_cpu = its_dev->event_map.col_map[id];
+	its_dec_lpi_count(d, prev_cpu);
+
        /* lpi cannot be routed to a redistributor that is on a foreign node */
 	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
 		if (its_dev->its->numa_node >= 0) {
 			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 			if (!cpumask_intersects(mask_val, cpu_mask))
-				return -EINVAL;
+				goto err;
 		}
 	}
 
 	cpu = cpumask_any_and(mask_val, cpu_mask);
 
 	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+		goto err;
 
 	/* don't set the affinity when the target cpu is same as current one */
-	if (cpu != its_dev->event_map.col_map[id]) {
+	if (cpu != prev_cpu) {
 		target_col = &its_dev->its->collections[cpu];
 		its_send_movi(its_dev, target_col, id);
 		its_dev->event_map.col_map[id] = cpu;
 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	}
 
+	its_inc_lpi_count(d, cpu);
+
 	return IRQ_SET_MASK_OK_DONE;
+
+err:
+	its_inc_lpi_count(d, prev_cpu);
+	return -EINVAL;
 }
 
 static u64 its_irq_get_msi_base(struct its_device *its_dev)
@@ -3448,6 +3489,7 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu = cpumask_first(cpu_online_mask);
 	}
 
+	its_inc_lpi_count(d, cpu);
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -3462,6 +3504,7 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	its_dec_lpi_count(d, its_dev->event_map.col_map[event]);
 	/* Stop the delivery of interrupts */
 	its_send_discard(its_dev, event);
 }
-- 
2.26.2

