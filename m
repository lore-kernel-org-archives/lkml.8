Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E781920776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgE3HrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgE3Hqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5FC03E969;
        Sat, 30 May 2020 00:46:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCS-0001s6-Pb; Sat, 30 May 2020 09:46:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FB981C0481;
        Sat, 30 May 2020 09:46:36 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:36 -0000
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Make __irq_domain_add() less OF-dependent
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
References: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159082479624.17951.12396123200576489042.tip-bot2@tip-bot2>
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

Commit-ID:     181e9d4efaf6aa8d1e7d510aeb7114c0f276fad7
Gitweb:        https://git.kernel.org/tip/181e9d4efaf6aa8d1e7d510aeb7114c0f276fad7
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Wed, 20 May 2020 19:49:25 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 21 May 2020 10:50:30 +01:00

irqdomain: Make __irq_domain_add() less OF-dependent

__irq_domain_add() relies in some places on the fact that the fwnode
can be only of type OF. This prevents refactoring of the code to support
other types of fwnode. Make it less OF-dependent by switching it
to use the fwnode directly where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200520164927.39090-1-andriy.shevchenko@linux.intel.com
---
 kernel/irq/irqdomain.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e2aa128..7649f38 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -132,14 +132,13 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
-	struct device_node *of_node = to_of_node(fwnode);
 	struct irqchip_fwid *fwid;
 	struct irq_domain *domain;
 
 	static atomic_t unknown_domains;
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
-			      GFP_KERNEL, of_node_to_nid(of_node));
+			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
 		return NULL;
 
@@ -177,15 +176,15 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 		domain->fwnode = fwnode;
 #endif
-	} else if (of_node) {
+	} else if (is_of_node(fwnode)) {
 		char *name;
 
 		/*
-		 * DT paths contain '/', which debugfs is legitimately
+		 * fwnode paths contain '/', which debugfs is legitimately
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kasprintf(GFP_KERNEL, "%pOF", of_node);
+		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
 		if (!name) {
 			kfree(domain);
 			return NULL;
@@ -210,7 +209,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	of_node_get(of_node);
+	fwnode_handle_get(fwnode);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
@@ -259,7 +258,7 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	pr_debug("Removed domain %s\n", domain->name);
 
-	of_node_put(irq_domain_get_of_node(domain));
+	fwnode_handle_put(domain->fwnode);
 	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
 		kfree(domain->name);
 	kfree(domain);
