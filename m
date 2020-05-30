Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915CA20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgE3HrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgE3Hqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C0CC08C5CA;
        Sat, 30 May 2020 00:46:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCW-0001rn-Q6; Sat, 30 May 2020 09:46:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 71C9E1C0093;
        Sat, 30 May 2020 09:46:35 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:35 -0000
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Allow software nodes for IRQ domain creation
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520164927.39090-3-andriy.shevchenko@linux.intel.com>
References: <20200520164927.39090-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159082479533.17951.10171522789484978911.tip-bot2@tip-bot2>
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

Commit-ID:     9ed78b05f998050784ae863bd5ba4aea2e2141ed
Gitweb:        https://git.kernel.org/tip/9ed78b05f998050784ae863bd5ba4aea2e2141ed
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Wed, 20 May 2020 19:49:27 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 21 May 2020 10:53:17 +01:00

irqdomain: Allow software nodes for IRQ domain creation

In some cases we need to have an IRQ domain created out of software node.

One of such cases is DesignWare GPIO driver when it's instantiated from
half-baked ACPI table (alas, we can't fix it for devices which are few years
on market) and thus using software nodes to quirk this. But the driver
is using IRQ domains based on per GPIO port firmware nodes, which are in
the above case software ones. This brings a warning message to be printed

  [   73.957183] irq: Invalid fwnode type for irqdomain

and creates an anonymous IRQ domain without a debugfs entry.

Allowing software nodes to be valid for IRQ domains rids us of the warning
and debugs gets correctly populated.

  % ls -1 /sys/kernel/debug/irq/domains/
  ...
  intel-quark-dw-apb-gpio:portA

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[maz: refactored commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200520164927.39090-3-andriy.shevchenko@linux.intel.com
---
 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5d14d91..a4c2c91 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -161,7 +161,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 			domain->name = fwid->name;
 			break;
 		}
-	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode)) {
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
+		   is_software_node(fwnode)) {
 		char *name;
 
 		/*
