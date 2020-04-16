Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD70FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FEA214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052930;
	bh=A8vFarPiiiN5fEyJQtwwxUwgpvTAUNBhJo0Irej3s90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yn06kHbQJY7c/QXiXAqg8FOWYt11b1c6vmO0RnMT3dLeUXuyxtd+ioys3n6jS9Cyd
	 Q7UK8jjd7ehIz5lnfboicvJP3egJDvBtvOiEYB00UQYX1cfVDv0Ms9LXHPray8eEFG
	 4ehzRGmNuYRoohIggFUFPiyGpMjd2W50UeMaJ9S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636580AbgDPQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895174AbgDPN04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E343D206E9;
        Thu, 16 Apr 2020 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043615;
        bh=A8vFarPiiiN5fEyJQtwwxUwgpvTAUNBhJo0Irej3s90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2A75txl+buExNEpROHr/5n4KEArioHnp/FX5C++1spz1epK0bNLbRa83p+PMioyt
         xnFq+Unxfo25rKCc1K/tbMX82q9shS7tyB3VWosGWGS8emFOaZdIMwww5bv8kRRw28
         AzYLryP9WQOgJ8Y14cIxTyca4xiReu0nyaz6URiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/146] genirq/irqdomain: Check pointer in irq_domain_alloc_irqs_hierarchy()
Date:   Thu, 16 Apr 2020 15:22:50 +0200
Message-Id: <20200416131246.436793511@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

[ Upstream commit 87f2d1c662fa1761359fdf558246f97e484d177a ]

irq_domain_alloc_irqs_hierarchy() has 3 call sites in the compilation unit
but only one of them checks for the pointer which is being dereferenced
inside the called function. Move the check into the function. This allows
for catching the error instead of the following crash:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
PC is at 0x0
LR is at gpiochip_hierarchy_irq_domain_alloc+0x11f/0x140
...
[<c06c23ff>] (gpiochip_hierarchy_irq_domain_alloc)
[<c0462a89>] (__irq_domain_alloc_irqs)
[<c0462dad>] (irq_create_fwspec_mapping)
[<c06c2251>] (gpiochip_to_irq)
[<c06c1c9b>] (gpiod_to_irq)
[<bf973073>] (gpio_irqs_init [gpio_irqs])
[<bf974048>] (gpio_irqs_exit+0xecc/0xe84 [gpio_irqs])
Code: bad PC value

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200306174720.82604-1-alexander.sverdlin@nokia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/irqdomain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0eda2bd39753..0a76c44eb6b29 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1255,6 +1255,11 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
 				    unsigned int irq_base,
 				    unsigned int nr_irqs, void *arg)
 {
+	if (!domain->ops->alloc) {
+		pr_debug("domain->ops->alloc() is NULL\n");
+		return -ENOSYS;
+	}
+
 	return domain->ops->alloc(domain, irq_base, nr_irqs, arg);
 }
 
@@ -1292,11 +1297,6 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			return -EINVAL;
 	}
 
-	if (!domain->ops->alloc) {
-		pr_debug("domain->ops->alloc() is NULL\n");
-		return -ENOSYS;
-	}
-
 	if (realloc && irq_base >= 0) {
 		virq = irq_base;
 	} else {
-- 
2.20.1



