Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7718C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C029420888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbgE1ODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgE1ODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:03:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862DC05BD1E;
        Thu, 28 May 2020 07:03:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeJ8J-00015x-LB; Thu, 28 May 2020 16:03:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2AEC61C0051;
        Thu, 28 May 2020 16:03:43 +0200 (CEST)
Date:   Thu, 28 May 2020 14:03:42 -0000
From:   "tip-bot2 for Marek Vasut" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Check irq_data_get_irq_chip() return value before use
Cc:     Marek Vasut <marex@denx.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159067462294.17951.4575635791673961345.tip-bot2@tip-bot2>
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

Commit-ID:     1d0326f352bb094771df17f045bdbadff89a43e6
Gitweb:        https://git.kernel.org/tip/1d0326f352bb094771df17f045bdbadff89a43e6
Author:        Marek Vasut <marex@denx.de>
AuthorDate:    Thu, 14 May 2020 02:25:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 May 2020 15:58:04 +02:00

genirq: Check irq_data_get_irq_chip() return value before use

irq_data_get_irq_chip() can return NULL, however it is expected that this
never happens. If a buggy driver leads to NULL being returned from
irq_data_get_irq_chip(), warn about it instead of crashing the machine.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

To: linux-arm-kernel@lists.infradead.org
---
 kernel/irq/manage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 453a8a0..7619111 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2619,6 +2619,8 @@ int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
 
 	do {
 		chip = irq_data_get_irq_chip(data);
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
 		if (chip->irq_get_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -2696,6 +2698,8 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 	do {
 		chip = irq_data_get_irq_chip(data);
+		if (WARN_ON_ONCE(!chip))
+			return -ENODEV;
 		if (chip->irq_set_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
