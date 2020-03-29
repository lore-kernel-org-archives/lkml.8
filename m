Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D139C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C16A20784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgC2U2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:28:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56922 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgC2U0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVU-0001KW-Oc; Sun, 29 Mar 2020 22:26:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5E3841C0450;
        Sun, 29 Mar 2020 22:26:08 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:08 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-11-maz@kernel.org>
References: <20200304203330.4967-11-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551356804.28353.15755655132659131079.tip-bot2@tip-bot2>
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

Commit-ID:     b4e8d644ec623cbb66f192a7fefbd0a66e314be8
Gitweb:        https://git.kernel.org/tip/b4e8d644ec623cbb66f192a7fefbd0a66e314be8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:17 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 24 Mar 2020 12:05:09 

irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks

Implement mask/unmask for virtual SGIs by calling into the
configuration helper.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20200304203330.4967-11-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 28c856a..bc6666a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3944,6 +3944,22 @@ static void its_configure_sgi(struct irq_data *d, bool clear)
 	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
 }
 
+static void its_sgi_mask_irq(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = false;
+	its_configure_sgi(d, false);
+}
+
+static void its_sgi_unmask_irq(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = true;
+	its_configure_sgi(d, false);
+}
+
 static int its_sgi_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3958,6 +3974,8 @@ static int its_sgi_set_affinity(struct irq_data *d,
 
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
+	.irq_mask		= its_sgi_mask_irq,
+	.irq_unmask		= its_sgi_unmask_irq,
 	.irq_set_affinity	= its_sgi_set_affinity,
 };
 
