Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4BBC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35CE20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ErAwh6Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgAQARe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:17:34 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:56821 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgAQARd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:17:33 -0500
Received: from mxback9g.mail.yandex.net (mxback9g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:170])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id AAD1EF20AB6;
        Fri, 17 Jan 2020 03:17:30 +0300 (MSK)
Received: from sas2-e7f6fb703652.qloud-c.yandex.net (sas2-e7f6fb703652.qloud-c.yandex.net [2a02:6b8:c14:4fa6:0:640:e7f6:fb70])
        by mxback9g.mail.yandex.net (mxback/Yandex) with ESMTP id kHG5Zk7D85-HTl0Rqn6;
        Fri, 17 Jan 2020 03:17:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1579220250;
        bh=Pfx+pHybgqMVMwUaA91jNgYfd7P2+vnRjIP/4FXtJAY=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=ErAwh6Ib4M6NpHPAEtEkyA7HhTKSGubX+aaijYNtacmYvNRNPZq/cnJVRzMto5e8M
         lHK1DmHuz4rbFYC4WRC+ft8o+T8myws8aQ1HNaqanM138HXC0+6yg1c/nQqPYVPNT2
         Fb9HPTeV+eqzBR7bF7Ag7YytN1QuwkbUq8atKjgY=
Authentication-Results: mxback9g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by sas2-e7f6fb703652.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id g2NDK8KfXv-HMVOwWXe;
        Fri, 17 Jan 2020 03:17:28 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v1 1/2] genirq: Check for level based percpu irq
Date:   Fri, 17 Jan 2020 08:17:05 +0800
Message-Id: <20200117001706.40620-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113101251.37471-1-jiaxun.yang@flygoat.com>
References: <20200113101251.37471-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS processors implemented their IPI IRQ and CPU interrupt line
as level triggered IRQ. However, our current percpu_irq flow is trying
do it in a level triggered manner.

Thus we attempt to determine whether it is or not level triggered type by
checking if both ack and eoi operation not exist. And handle it in
mask/unmask way.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 kernel/irq/chip.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b3fa2d87d2f3..4fafe572d022 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -893,6 +893,7 @@ void handle_edge_eoi_irq(struct irq_desc *desc)
 void handle_percpu_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	bool is_level = !chip->irq_ack && !chip->irq_eoi;
 
 	/*
 	 * PER CPU interrupts are not serialized. Do not touch
@@ -900,12 +901,16 @@ void handle_percpu_irq(struct irq_desc *desc)
 	 */
 	__kstat_incr_irqs_this_cpu(desc);
 
-	if (chip->irq_ack)
+	if (is_level)
+		chip->irq_mask(&desc->irq_data);
+	else if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
 	handle_irq_event_percpu(desc);
 
-	if (chip->irq_eoi)
+	if (is_level)
+		chip->irq_unmask(&desc->irq_data);
+	else if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
 }
 
@@ -925,6 +930,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
+	bool is_level = !chip->irq_ack && !chip->irq_eoi;
 	irqreturn_t res;
 
 	/*
@@ -933,7 +939,9 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	 */
 	__kstat_incr_irqs_this_cpu(desc);
 
-	if (chip->irq_ack)
+	if (is_level)
+		chip->irq_mask(&desc->irq_data);
+	else if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
 	if (likely(action)) {
@@ -951,7 +959,9 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 			    enabled ? " and unmasked" : "", irq, cpu);
 	}
 
-	if (chip->irq_eoi)
+	if (is_level)
+		chip->irq_unmask(&desc->irq_data);
+	else if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-- 
2.24.1

