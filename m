Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA26C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D6920575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgCKVmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:42:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgCKVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:42:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jC977-0000vp-RB; Wed, 11 Mar 2020 22:42:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FB171C2246;
        Wed, 11 Mar 2020 22:42:05 +0100 (CET)
Date:   Wed, 11 Mar 2020 21:42:05 -0000
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200123210242.53367-1-hdegoede@redhat.com>
References: <20200123210242.53367-1-hdegoede@redhat.com>
MIME-Version: 1.0
Message-ID: <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
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

Commit-ID:     17e5888e4e180b45af7bafe7f3a86440d42717f3
Gitweb:        https://git.kernel.org/tip/17e5888e4e180b45af7bafe7f3a86440d42717f3
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Thu, 23 Jan 2020 22:02:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Mar 2020 22:39:39 +01:00

x86: Select HARDIRQS_SW_RESEND on x86

Modern x86 laptops are starting to use GPIO pins as interrupts more
and more, e.g. touchpads and touchscreens have almost all moved away
from PS/2 and USB to using I2C with a GPIO pin as interrupt.
Modern x86 laptops also have almost all moved to using s2idle instead
of using the system S3 ACPI power state to suspend.

The Intel and AMD pinctrl drivers do not define irq_retrigger handlers
for the irqchips they register, this is causing edge triggered interrupts
which happen while suspended using s2idle to get lost.

One specific example of this is the lid switch on some devices, lid
switches used to be handled by the embedded-controller, but now the
lid open/closed sensor is sometimes directly connected to a GPIO pin.
On most devices the ACPI code for this looks like this:

Method (_E00, ...) {
	Notify (LID0, 0x80) // Status Change
}

Where _E00 is an ACPI event handler for changes on both edges of the GPIO
connected to the lid sensor, this event handler is then combined with an
_LID method which directly reads the pin. When the device is resumed by
opening the lid, the GPIO interrupt will wake the system, but because the
pinctrl irqchip doesn't have an irq_retrigger handler, the Notify will not
happen. This is not a problem in the case the _LID method directly reads
the GPIO, because the drivers/acpi/button.c code will call _LID on resume
anyways.

But some devices have an event handler for the GPIO connected to the
lid sensor which looks like this:

Method (_E00, ...) {
	if (LID_GPIO == One)
		LIDS = One
	else
		LIDS = Zero
	Notify (LID0, 0x80) // Status Change
}

And the _LID method returns the cached LIDS value, since on open we
do not re-run the edge-interrupt handler when we re-enable IRQS on resume
(because of the missing irq_retrigger handler), _LID now will keep
reporting closed, as LIDS was never changed to reflect the open status,
this causes userspace to re-resume the laptop again shortly after opening
the lid.

The Intel GPIO controllers do not allow implementing irq_retrigger without
emulating it in software, at which point we are better of just using the
generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
emulation for this separately in aprox. 14 different pinctrl drivers.

Select HARDIRQS_SW_RESEND to solve the problem of edge-triggered GPIO
interrupts not being re-triggered on resume when they were triggered during
suspend (s2idle) and/or when they were the cause of the wakeup.

This requires

 008f1d60fe25 ("x86/apic/vector: Force interupt handler invocation to irq context")
 c16816acd086 ("genirq: Add protection against unsafe usage of generic_handle_irq()")

to protect the APIC based interrupts from being wreckaged by a software
resend.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200123210242.53367-1-hdegoede@redhat.com

---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea770..9128932 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -128,6 +128,7 @@ config X86
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
+	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
