Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C93C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B372020678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgAMQsp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:48:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:48:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir2tJ-0006Bx-7X; Mon, 13 Jan 2020 17:48:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 75C971C18D2;
        Mon, 13 Jan 2020 17:48:36 +0100 (CET)
Date:   Mon, 13 Jan 2020 16:48:36 -0000
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ingenic: Get rid of the legacy IRQ domain
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        zhouyanjie@wanyeetech.com, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200113163329.34282-2-paul@crapouillou.net>
References: <20200113163329.34282-2-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <157893411629.19145.7825622073651467564.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1fd224e35c1493e9f5d4d932c175616cccce8df9
Gitweb:        https://git.kernel.org/tip/1fd224e35c1493e9f5d4d932c175616cccce8df9
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Mon, 13 Jan 2020 13:33:29 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 17:45:23 +01:00

irqchip/ingenic: Get rid of the legacy IRQ domain

Get rid of the legacy IRQ domain and hardcoded IRQ base, since all the
Ingenic drivers and platform code have been updated to use devicetree.

This also fixes the kernel being flooded with messages like:

 irq: interrupt-controller@10001000 didn't like hwirq-0x0 to VIRQ8 mapping (rc=-19)

Fixes: 8bc7464b5140 ("irqchip: ingenic: Alloc generic chips from IRQ domain").
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200113163329.34282-2-paul@crapouillou.net
---
 drivers/irqchip/irq-ingenic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 01d18b3..c5589ee 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 
 #include <asm/io.h>
-#include <asm/mach-jz4740/irq.h>
 
 struct ingenic_intc_data {
 	void __iomem *base;
@@ -50,7 +49,7 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		while (pending) {
 			int bit = __fls(pending);
 
-			irq = irq_find_mapping(domain, bit + (i * 32));
+			irq = irq_linear_revmap(domain, bit + (i * 32));
 			generic_handle_irq(irq);
 			pending &= ~BIT(bit);
 		}
@@ -97,8 +96,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_irq;
 	}
 
-	domain = irq_domain_add_legacy(node, num_chips * 32,
-				       JZ4740_IRQ_BASE, 0,
+	domain = irq_domain_add_linear(node, num_chips * 32,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		err = -ENOMEM;
