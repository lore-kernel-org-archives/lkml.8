Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34CC20723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgE3HrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgE3Hqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE3C03E969;
        Sat, 30 May 2020 00:46:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCX-0001rr-78; Sat, 30 May 2020 09:46:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E057F1C032F;
        Sat, 30 May 2020 09:46:35 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:35 -0000
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Get rid of special treatment for ACPI in
 __irq_domain_add()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520164927.39090-2-andriy.shevchenko@linux.intel.com>
References: <20200520164927.39090-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159082479578.17951.14349375342830434794.tip-bot2@tip-bot2>
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

Commit-ID:     87526603c89256e18ad2c23821fdaf376b072fc8
Gitweb:        https://git.kernel.org/tip/87526603c89256e18ad2c23821fdaf376b072fc8
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Wed, 20 May 2020 19:49:26 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 21 May 2020 10:51:50 +01:00

irqdomain: Get rid of special treatment for ACPI in __irq_domain_add()

Now that __irq_domain_add() is able to better deals with generic
fwnodes, there is no need to special-case ACPI anymore.

Get rid of the special treatment for ACPI.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200520164927.39090-2-andriy.shevchenko@linux.intel.com
---
 kernel/irq/irqdomain.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7649f38..5d14d91 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -161,22 +161,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 			domain->name = fwid->name;
 			break;
 		}
-#ifdef CONFIG_ACPI
-	} else if (is_acpi_device_node(fwnode)) {
-		struct acpi_buffer buf = {
-			.length = ACPI_ALLOCATE_BUFFER,
-		};
-		acpi_handle handle;
-
-		handle = acpi_device_handle(to_acpi_device_node(fwnode));
-		if (acpi_get_name(handle, ACPI_FULL_PATHNAME, &buf) == AE_OK) {
-			domain->name = buf.pointer;
-			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-		}
-
-		domain->fwnode = fwnode;
-#endif
-	} else if (is_of_node(fwnode)) {
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode)) {
 		char *name;
 
 		/*
