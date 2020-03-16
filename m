Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CDEC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C884206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584359692;
	bh=NfI3BjyZqVwwcNacOp4j+tGpjFbDZD6NEsPfxkTzkwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qTeAI4F53Uf4KPhLjZWpPo5NJGpralqUA3MALQkWPUrbSoLroL8cpbqzUnAVsfDWg
	 diQV5np+rxkM6Y/HMmVFvlXxBGD2iIZuLp8FhH2I1AshtvmcavE15vhZIyqwK0A8Vz
	 GlG9+RMNRVBnnpZcpyVwiwdSloIvevkcKXxn1Ceg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgCPLyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbgCPLyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:54:50 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EB720658;
        Mon, 16 Mar 2020 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584359689;
        bh=NfI3BjyZqVwwcNacOp4j+tGpjFbDZD6NEsPfxkTzkwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3i7qJ13JPDAH0/GwCgIZgYbxdEf7Hdpka8RFgsc777HhcNa+JHbxRKtjLa0ZMNBr
         MRI28OMFcagjEEAsAyVwiJ8nUHCdH5tlTIN9xzCwu7ZKaXPvqwPtJWZcTyrDSdRmpl
         lQ+JOg7dJFhoGLDDDhHgJA2R4/AqJiijEkpSfcLw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDoKV-00D45x-E6; Mon, 16 Mar 2020 11:54:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     John Garry <john.garry@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 1/2] irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
Date:   Mon, 16 Mar 2020 11:54:32 +0000
Message-Id: <20200316115433.9017-2-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316115433.9017-1-maz@kernel.org>
References: <20200316115433.9017-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, john.garry@huawei.com, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de
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
 drivers/irqchip/irq-gic-v3-its.c | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 34e5a06ec874..941786e1e8f7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -173,6 +173,13 @@ static struct {
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
@@ -1500,6 +1507,30 @@ static void its_unmask_irq(struct irq_data *d)
 	lpi_update_config(d, 0, LPI_PROP_ENABLED);
 }
 
+static u32 its_read_lpi_count(struct irq_data *d, int cpu)
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
@@ -1529,6 +1560,8 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 
 	/* don't set the affinity when the target cpu is same as current one */
 	if (cpu != its_dev->event_map.col_map[id]) {
+		its_inc_lpi_count(d, cpu);
+		its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
 		target_col = &its_dev->its->collections[cpu];
 		its_send_movi(its_dev, target_col, id);
 		its_dev->event_map.col_map[id] = cpu;
@@ -3438,6 +3471,7 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu = cpumask_first(cpu_online_mask);
 	}
 
+	its_inc_lpi_count(d, cpu);
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -3452,6 +3486,7 @@ static void its_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	its_dec_lpi_count(d, its_dev->event_map.col_map[event]);
 	/* Stop the delivery of interrupts */
 	its_send_discard(its_dev, event);
 }
-- 
2.20.1

