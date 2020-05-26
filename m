Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F87C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840872078C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEZPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgEZPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:14:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E823C03E96D;
        Tue, 26 May 2020 08:14:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdbHD-0004uA-PJ; Tue, 26 May 2020 17:13:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4491B1C00FA;
        Tue, 26 May 2020 17:13:59 +0200 (CEST)
Date:   Tue, 26 May 2020 15:13:59 -0000
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/io_apic: Remove unused function mp_init_irq_at_boot()
Cc:     YueHaibing <yuehaibing@huawei.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200508140808.49428-1-yuehaibing@huawei.com>
References: <20200508140808.49428-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <159050603911.17951.11028887642635728430.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     fd52a75ca3545c965ff58a78b6ff0b0dc7d8d228
Gitweb:        https://git.kernel.org/tip/fd52a75ca3545c965ff58a78b6ff0b0dc7d8d228
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Fri, 08 May 2020 22:08:08 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 May 2020 17:01:20 +02:00

x86/io_apic: Remove unused function mp_init_irq_at_boot()

There are no callers in-tree anymore since

  ef9e56d894ea ("x86/ioapic: Remove obsolete post hotplug update")

so remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200508140808.49428-1-yuehaibing@huawei.com
---
 arch/x86/kernel/apic/io_apic.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 913c886..ce61e3e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -154,19 +154,6 @@ static inline bool mp_is_legacy_irq(int irq)
 	return irq >= 0 && irq < nr_legacy_irqs();
 }
 
-/*
- * Initialize all legacy IRQs and all pins on the first IOAPIC
- * if we have legacy interrupt controller. Kernel boot option "pirq="
- * may rely on non-legacy pins on the first IOAPIC.
- */
-static inline int mp_init_irq_at_boot(int ioapic, int irq)
-{
-	if (!nr_legacy_irqs())
-		return 0;
-
-	return ioapic == 0 || mp_is_legacy_irq(irq);
-}
-
 static inline struct irq_domain *mp_ioapic_irqdomain(int ioapic)
 {
 	return ioapics[ioapic].irqdomain;
