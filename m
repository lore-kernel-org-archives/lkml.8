Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF6C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3850212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490783;
	bh=JtG7o5h48XOzSVX3DUWhC8Yos/wnFX6Hq89NJDx6q9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+oFfFapGqZ73WLCtYwECRw+CJvQB+q5fxsYhkROJp5/B6HwakSwFb5QrV0x12z3e
	 kTNJHl1cBVuxHf4TeVN3bOqr/c8FFE8QgktWaPHsbOvWwVnVlP/Ij6epO2XUmute0m
	 u21r3QRwCvLQelyB4QWZbMmOfIzJ4hP6JhB2ltKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgDJDxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgDJDvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:51:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6141E2192A;
        Fri, 10 Apr 2020 03:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490660;
        bh=JtG7o5h48XOzSVX3DUWhC8Yos/wnFX6Hq89NJDx6q9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aW4ROpaaCOLCs8Ftwv8EFqpEmiVQq/hPk7ocYsMV03EwPxDdVGC9bfUr3KR/cFOn4
         gM69Xm/cIyzZ/DKrIMxN3brFzUidN57vjgbdIkFIdwpoE1nH9Kmj6r4ViuOVvAF5Nq
         JLW3gduTfF+S6i2evBG1tvwmMGZtcWxjmxQDjfkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/22] genirq/irqdomain: Check pointer in irq_domain_alloc_irqs_hierarchy()
Date:   Thu,  9 Apr 2020 23:50:36 -0400
Message-Id: <20200410035044.9698-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035044.9698-1-sashal@kernel.org>
References: <20200410035044.9698-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index b269ae16b10cd..0d54f8256b9f4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1372,6 +1372,11 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
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
 
@@ -1409,11 +1414,6 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
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

