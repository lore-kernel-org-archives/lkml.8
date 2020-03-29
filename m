Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA920C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B873A20784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgC2U1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgC2U0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVe-0001Pc-Le; Sun, 29 Mar 2020 22:26:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 26C9D1C04E3;
        Sun, 29 Mar 2020 22:26:15 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:14 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Advertise support v4.1 to KVM
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-7-maz@kernel.org>
References: <20200304203330.4967-7-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551357472.28353.8586602825466065584.tip-bot2@tip-bot2>
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

Commit-ID:     3c40706d05fdea421e991da50e72a29d41131a66
Gitweb:        https://git.kernel.org/tip/3c40706d05fdea421e991da50e72a29d41131a66
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:13 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 20 Mar 2020 17:48:38 

irqchip/gic-v4.1: Advertise support v4.1 to KVM

Tell KVM that we support v4.1. Nothing uses this information so far.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20200304203330.4967-7-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c       |  9 ++++++++-
 drivers/irqchip/irq-gic-v3.c           |  2 ++
 include/linux/irqchip/arm-gic-common.h |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fc57885..bcc1a09 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4870,6 +4870,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	struct device_node *of_node;
 	struct its_node *its;
 	bool has_v4 = false;
+	bool has_v4_1 = false;
 	int err;
 
 	gic_rdists = rdists;
@@ -4890,8 +4891,14 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (err)
 		return err;
 
-	list_for_each_entry(its, &its_nodes, entry)
+	list_for_each_entry(its, &its_nodes, entry) {
 		has_v4 |= is_v4(its);
+		has_v4_1 |= is_v4_1(its);
+	}
+
+	/* Don't bother with inconsistent systems */
+	if (WARN_ON(!has_v4_1 && rdists->has_rvpeid))
+		rdists->has_rvpeid = false;
 
 	if (has_v4 & rdists->has_vlpis) {
 		if (its_init_vpe_domain() ||
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0f716c2..8c5de59 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1764,6 +1764,7 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 		gic_v3_kvm_info.vcpu = r;
 
 	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
+	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
@@ -2079,6 +2080,7 @@ static void __init gic_acpi_setup_kvm_info(void)
 	}
 
 	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
+	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index b9850f5..fa8c045 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -32,6 +32,8 @@ struct gic_kvm_info {
 	struct resource vctrl;
 	/* vlpi support */
 	bool		has_v4;
+	/* rvpeid support */
+	bool		has_v4_1;
 };
 
 const struct gic_kvm_info *gic_get_kvm_info(void);
