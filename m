Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD07C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C9220723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgE3HrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgE3Hqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C91C08C5CB;
        Sat, 30 May 2020 00:46:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCX-0001u2-Gn; Sat, 30 May 2020 09:46:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D536A1C070D;
        Sat, 30 May 2020 09:46:39 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:39 -0000
From:   "tip-bot2 for Ingo Rohloff" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Fix missing "__init" for gic_smp_init()
Cc:     Ingo Rohloff <ingo.rohloff@lauterbach.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422112857.4300-1-ingo.rohloff@lauterbach.com>
References: <20200422112857.4300-1-ingo.rohloff@lauterbach.com>
MIME-Version: 1.0
Message-ID: <159082479973.17951.9993643934969577423.tip-bot2@tip-bot2>
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

Commit-ID:     8a94c1ab34d53476617f83610521cfb6674db8d4
Gitweb:        https://git.kernel.org/tip/8a94c1ab34d53476617f83610521cfb6674db8d4
Author:        Ingo Rohloff <ingo.rohloff@lauterbach.com>
AuthorDate:    Wed, 22 Apr 2020 13:28:57 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 18 May 2020 10:28:30 +01:00

irqchip/gic-v3: Fix missing "__init" for gic_smp_init()

With an SMP configuration, gic_smp_init() calls set_smp_cross_call().
set_smp_cross_call() is marked with "__init".
So gic_smp_init() should also be marked with "__init".
gic_smp_init() is only called from gic_init_bases().
gic_init_bases() is also marked with "__init";
So marking gic_smp_init() with "__init" is fine.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200422112857.4300-1-ingo.rohloff@lauterbach.com
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef..98c886d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1150,7 +1150,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	isb();
 }
 
-static void gic_smp_init(void)
+static void __init gic_smp_init(void)
 {
 	set_smp_cross_call(gic_raise_softirq);
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
