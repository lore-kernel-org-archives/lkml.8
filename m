Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C2C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F5320720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBGOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:37:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:37:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j04l3-0005Ho-QT; Fri, 07 Feb 2020 15:37:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 676671C1A0E;
        Fri,  7 Feb 2020 15:37:25 +0100 (CET)
Date:   Fri, 07 Feb 2020 14:37:25 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Mask IOAPIC entries when disabling the local APIC
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1579076539-7267-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1579076539-7267-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <158108624517.411.12215803760859503260.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0f378d73d429d5f73fe2f00be4c9a15dbe9779ee
Gitweb:        https://git.kernel.org/tip/0f378d73d429d5f73fe2f00be4c9a15dbe9779ee
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Wed, 15 Jan 2020 16:22:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Feb 2020 15:32:16 +01:00

x86/apic: Mask IOAPIC entries when disabling the local APIC

When a system suspends, the local APIC is disabled in the suspend sequence,
but the IOAPIC is left in the current state. This means unmasked interrupt
lines stay unmasked. This is usually the case for IOAPIC pin 9 to which the
ACPI interrupt is connected.

That means that in suspended state the IOAPIC can respond to an external
interrupt, e.g. the wakeup via keyboard/RTC/ACPI, but the interrupt message
cannot be handled by the disabled local APIC. As a consequence the Remote
IRR bit is set, but the local APIC does not send an EOI to acknowledge
it. This causes the affected interrupt line to become stale and the stale
Remote IRR bit will cause a hang when __synchronize_hardirq() is invoked
for that interrupt line.

To prevent this, mask all IOAPIC entries before disabling the local
APIC. The resume code already has the unmask operation inside.

[ tglx: Massaged changelog ]

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1579076539-7267-1-git-send-email-TonyWWang-oc@zhaoxin.com

---
 arch/x86/kernel/apic/apic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4b0f911..5f973fe 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2639,6 +2639,13 @@ static int lapic_suspend(void)
 #endif
 
 	local_irq_save(flags);
+
+	/*
+	 * Mask IOAPIC before disabling the local APIC to prevent stale IRR
+	 * entries on some implementations.
+	 */
+	mask_ioapic_entries();
+
 	disable_local_APIC();
 
 	irq_remapping_disable();
