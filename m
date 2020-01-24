Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B25AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9EA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbgAXTLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:11:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391871AbgAXTLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MG-0007a6-Pd; Fri, 24 Jan 2020 20:11:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBDCE1C1A5F;
        Fri, 24 Jan 2020 20:11:07 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:07 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Add mask/unmask doorbell callbacks
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224111055.11836-11-maz@kernel.org>
References: <20191224111055.11836-11-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157989306760.396.2641770526812253234.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d97c97baa214486cc3d64c996a2214475f6cc83c
Gitweb:        https://git.kernel.org/tip/d97c97baa214486cc3d64c996a2214475f6cc83c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 24 Dec 2019 11:10:33 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Jan 2020 14:22:20 

irqchip/gic-v4.1: Add mask/unmask doorbell callbacks

masking/unmasking doorbells on GICv4.1 relies on a new INVDB command,
which broadcasts the invalidation to all RDs.

Implement the new command as well as the masking callbacks, and plug
the whole thing into the v4.1 VPE irqchip.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191224111055.11836-11-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 73 +++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h |  3 +-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2b477e2..5ef706e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -333,6 +333,10 @@ struct its_cmd_desc {
 			u16 seq_num;
 			u16 its_list;
 		} its_vmovp_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+		} its_invdb_cmd;
 	};
 };
 
@@ -831,6 +835,21 @@ static struct its_vpe *its_build_vclear_cmd(struct its_node *its,
 	return valid_vpe(its, map->vpe);
 }
 
+static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
+					   struct its_cmd_block *cmd,
+					   struct its_cmd_desc *desc)
+{
+	if (WARN_ON(!is_v4_1(its)))
+		return NULL;
+
+	its_encode_cmd(cmd, GITS_CMD_INVDB);
+	its_encode_vpeid(cmd, desc->its_invdb_cmd.vpe->vpe_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, desc->its_invdb_cmd.vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -1239,6 +1258,14 @@ static void its_send_vclear(struct its_device *dev, u32 event_id)
 	its_send_single_vcommand(dev->its, its_build_vclear_cmd, &desc);
 }
 
+static void its_send_invdb(struct its_node *its, struct its_vpe *vpe)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_invdb_cmd.vpe = vpe;
+	its_send_single_vcommand(its, its_build_invdb_cmd, &desc);
+}
+
 /*
  * irqchip functions - assumes MSI, mostly.
  */
@@ -3553,6 +3580,50 @@ static struct irq_chip its_vpe_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
 
+static struct its_node *find_4_1_its(void)
+{
+	static struct its_node *its = NULL;
+
+	if (!its) {
+		list_for_each_entry(its, &its_nodes, entry) {
+			if (is_v4_1(its))
+				return its;
+		}
+
+		/* Oops? */
+		its = NULL;
+	}
+
+	return its;
+}
+
+static void its_vpe_4_1_send_inv(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_node *its;
+
+	/*
+	 * GICv4.1 wants doorbells to be invalidated using the
+	 * INVDB command in order to be broadcast to all RDs. Send
+	 * it to the first valid ITS, and let the HW do its magic.
+	 */
+	its = find_4_1_its();
+	if (its)
+		its_send_invdb(its, vpe);
+}
+
+static void its_vpe_4_1_mask_irq(struct irq_data *d)
+{
+	lpi_write_config(d->parent_data, LPI_PROP_ENABLED, 0);
+	its_vpe_4_1_send_inv(d);
+}
+
+static void its_vpe_4_1_unmask_irq(struct irq_data *d)
+{
+	lpi_write_config(d->parent_data, 0, LPI_PROP_ENABLED);
+	its_vpe_4_1_send_inv(d);
+}
+
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_cmd_info *info = vcpu_info;
@@ -3574,6 +3645,8 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 
 static struct irq_chip its_vpe_4_1_irq_chip = {
 	.name			= "GICv4.1-vpe",
+	.irq_mask		= its_vpe_4_1_mask_irq,
+	.irq_unmask		= its_vpe_4_1_unmask_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_vpe_set_affinity,
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index db0a111..1f17181 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -484,8 +484,9 @@
 #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
 #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
 #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
-/* VMOVP is the odd one, as it doesn't have a physical counterpart */
+/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
 #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+#define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
 
 /*
  * ITS error numbers
