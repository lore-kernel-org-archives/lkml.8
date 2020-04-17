Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E1FC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE4221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgDQJ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgDQJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:56:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190FC061A0F;
        Fri, 17 Apr 2020 02:56:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPNjn-0005eJ-L4; Fri, 17 Apr 2020 11:56:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 37DA41C0072;
        Fri, 17 Apr 2020 11:56:43 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:56:42 -0000
From:   "tip-bot2 for Jason Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-bcm7038-l1: Make bcm7038_l1_of_init() static
Cc:     Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200417074036.46594-1-yanaijie@huawei.com>
References: <20200417074036.46594-1-yanaijie@huawei.com>
MIME-Version: 1.0
Message-ID: <158711740277.28353.2774114664559504088.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8f374923de1ced05db3c98b9e4e1ce21c5aede2c
Gitweb:        https://git.kernel.org/tip/8f374923de1ced05db3c98b9e4e1ce21c5aede2c
Author:        Jason Yan <yanaijie@huawei.com>
AuthorDate:    Fri, 17 Apr 2020 15:40:36 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 17 Apr 2020 08:59:30 +01:00

irqchip/irq-bcm7038-l1: Make bcm7038_l1_of_init() static

Fix the following sparse warning:

drivers/irqchip/irq-bcm7038-l1.c:419:12: warning: symbol
'bcm7038_l1_of_init' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200417074036.46594-1-yanaijie@huawei.com
---
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index eb9bce9..fd7c537 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -416,7 +416,7 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
 	.map			= bcm7038_l1_map,
 };
 
-int __init bcm7038_l1_of_init(struct device_node *dn,
+static int __init bcm7038_l1_of_init(struct device_node *dn,
 			      struct device_node *parent)
 {
 	struct bcm7038_l1_chip *intc;
