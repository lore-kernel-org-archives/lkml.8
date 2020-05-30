Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ADDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09D5207D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgE3Hqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgE3Hqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F2C03E969;
        Sat, 30 May 2020 00:46:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCb-0001tR-SN; Sat, 30 May 2020 09:46:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64D6E1C04DD;
        Sat, 30 May 2020 09:46:39 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:39 -0000
From:   "tip-bot2 for Wesley W. Terpstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Remove incorrect requirement
 about number of irq contexts
Cc:     Atish Patra <atish.patra@wdc.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512172636.96299-1-atish.patra@wdc.com>
References: <20200512172636.96299-1-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <159082479927.17951.3725006513982997123.tip-bot2@tip-bot2>
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

Commit-ID:     82f2202ddc97490994fad0dbfec04a014fa5163d
Gitweb:        https://git.kernel.org/tip/82f2202ddc97490994fad0dbfec04a014fa5163d
Author:        Wesley W. Terpstra <wesley@sifive.com>
AuthorDate:    Tue, 12 May 2020 10:26:36 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 18 May 2020 10:28:30 +01:00

irqchip/sifive-plic: Remove incorrect requirement about number of irq contexts

A PLIC may not be connected to all the cores. In that case, nr_contexts
may be less than num_possible_cpus. This requirement is only valid a single
PLIC is the only interrupt controller for the whole system.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: "Wesley W. Terpstra" <wesley@sifive.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200512172636.96299-1-atish.patra@wdc.com

[Atish: Modified the commit text]
---
 drivers/irqchip/irq-sifive-plic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d0a71fe..822e074 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -301,8 +301,6 @@ static int __init plic_init(struct device_node *node,
 	nr_contexts = of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_contexts < num_possible_cpus()))
-		goto out_iounmap;
 
 	error = -ENOMEM;
 	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
