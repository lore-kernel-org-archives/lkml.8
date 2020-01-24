Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43CC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38E420838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392174AbgAXTMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:12:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391877AbgAXTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MK-0007cl-Ri; Fri, 24 Jan 2020 20:11:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 245F11C1A65;
        Fri, 24 Jan 2020 20:11:10 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:09 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Fix get_vlpi_map() breakage with
 doorbells
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200122085609.658-1-yuzenghui@huawei.com>
References: <20200122085609.658-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <157989306987.396.7210470882766081674.tip-bot2@tip-bot2>
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

Commit-ID:     093bf439fee0d40ade7e309c1288b409cdc3b38f
Gitweb:        https://git.kernel.org/tip/093bf439fee0d40ade7e309c1288b409cdc3b38f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 22 Jan 2020 13:53:44 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Jan 2020 14:21:07 

irqchip/gic-v3-its: Fix get_vlpi_map() breakage with doorbells

When updating an LPI configuration, get_vlpi_map() may be passed a
irq_data structure relative to an ITS domain (the normal case) or one
that is relative to the core GICv3 domain in the case of a GICv4
doorbell.

In the latter case, special care must be take not to dereference
the irq_chip data as an its_dev structure, as that isn't what is
stored there. Instead, check *first* whether the IRQ is forwarded
to a vcpu, and only then try to obtain the vlpi mapping.

Fixes: c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200122085609.658-1-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e05673b..b704214 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1170,13 +1170,14 @@ static void its_send_vclear(struct its_device *dev, u32 event_id)
  */
 static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
 {
-	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	u32 event = its_get_event_id(d);
+	if (irqd_is_forwarded_to_vcpu(d)) {
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+		u32 event = its_get_event_id(d);
 
-	if (!irqd_is_forwarded_to_vcpu(d))
-		return NULL;
+		return dev_event_to_vlpi_map(its_dev, event);
+	}
 
-	return dev_event_to_vlpi_map(its_dev, event);
+	return NULL;
 }
 
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
