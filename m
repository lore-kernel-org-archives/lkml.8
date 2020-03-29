Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16396C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99EF21841
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgC2U0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgC2U0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVZ-0001Lm-Ja; Sun, 29 Mar 2020 22:26:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AF8F1C0450;
        Sun, 29 Mar 2020 22:26:10 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:09 -0000
From:   "tip-bot2 for luanshi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Move irq_domain_update_bus_token to
 after checking for NULL domain
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583983255-44115-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1583983255-44115-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158551356984.28353.11059083385737598395.tip-bot2@tip-bot2>
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

Commit-ID:     eeaa4b24e5032707ee4286b6a2bcc5fb85eba4a4
Gitweb:        https://git.kernel.org/tip/eeaa4b24e5032707ee4286b6a2bcc5fb85eba4a4
Author:        luanshi <zhangliguang@linux.alibaba.com>
AuthorDate:    Thu, 12 Mar 2020 11:20:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Mar 2020 11:52:53 

irqchip/gic-v3: Move irq_domain_update_bus_token to after checking for NULL domain

irq_domain_update_bus_token should be called after checking for NULL
domain.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1583983255-44115-1-git-send-email-zhangliguang@linux.alibaba.com
---
 drivers/irqchip/irq-gic-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c1f7af9..8e5dd96 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1581,7 +1581,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
-	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
 	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
@@ -1592,6 +1591,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		goto out_free;
 	}
 
+	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
+
 	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
 	pr_info("Distributor has %sRange Selector support\n",
 		gic_data.has_rss ? "" : "no ");
