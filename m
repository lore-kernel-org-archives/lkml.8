Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0254C20784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgC2U04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgC2U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVt-0001WN-0A; Sun, 29 Mar 2020 22:26:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 063F61C04D7;
        Sun, 29 Mar 2020 22:26:24 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:23 -0000
From:   "tip-bot2 for Heyi Guo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Fix access width for gicr_syncr
Cc:     Heyi Guo <guoheyi@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200225090023.28020-1-guoheyi@huawei.com>
References: <20200225090023.28020-1-guoheyi@huawei.com>
MIME-Version: 1.0
Message-ID: <158551358355.28353.15317619271465246875.tip-bot2@tip-bot2>
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

Commit-ID:     04d80dbe858d801efbecf3e5172b31b0a3757308
Gitweb:        https://git.kernel.org/tip/04d80dbe858d801efbecf3e5172b31b0a3757308
Author:        Heyi Guo <guoheyi@huawei.com>
AuthorDate:    Tue, 25 Feb 2020 17:00:23 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 08 Mar 2020 14:25:46 

irqchip/gic-v3-its: Fix access width for gicr_syncr

GICR_SYNCR is a 32bit register, so it is better to access it with
32bit access width, though we have not seen any real problem.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200225090023.28020-1-guoheyi@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 83b1186..6bb2bea 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1321,7 +1321,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 
 static void wait_for_syncr(void __iomem *rdbase)
 {
-	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
+	while (readl_relaxed(rdbase + GICR_SYNCR) & 1)
 		cpu_relax();
 }
 
