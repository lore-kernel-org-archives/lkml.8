Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22202C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DA1206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgCHKOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:14:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgCHKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:14:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAsx5-0004nY-On; Sun, 08 Mar 2020 11:14:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0670B1C1A3C;
        Sun,  8 Mar 2020 11:14:29 +0100 (CET)
Date:   Sun, 08 Mar 2020 10:14:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/AER: Fix the broken interrupt injection
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306130624.098374457@linutronix.de>
References: <20200306130624.098374457@linutronix.de>
MIME-Version: 1.0
Message-ID: <158366246863.28353.13934427079680586268.tip-bot2@tip-bot2>
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

Commit-ID:     9ae0522537852408f0f48af888e44d6876777463
Gitweb:        https://git.kernel.org/tip/9ae0522537852408f0f48af888e44d6876777463
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Mar 2020 14:03:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Mar 2020 11:07:12 +01:00

PCI/AER: Fix the broken interrupt injection

The AER error injection mechanism just blindly abuses generic_handle_irq()
which is really not meant for consumption by random drivers. The include of
linux/irq.h should have been a red flag in the first place. Driver code,
unless implementing interrupt chips or low level hypervisor functionality
has absolutely no business with that.

Invoking generic_handle_irq() from non interrupt handling context can have
nasty side effects at least on x86 due to the hardware trainwreck which
makes interrupt affinity changes a fragile beast. Sathyanarayanan triggered
a NULL pointer dereference in the low level APIC code that way. While the
particular pointer could be checked this would only paper over the issue
because there are other ways to trigger warnings or silently corrupt state.

Invoke the new irq_inject_interrupt() mechanism, which has the necessary
sanity checks in place and injects the interrupt via the irq_retrigger()
mechanism, which is at least halfways safe vs. the fragile x86 affinity
change mechanics.

It's safe on x86 as it does not corrupt state, but it still can cause a
premature completion of an interrupt affinity change causing the interrupt
line to become stale. Very unlikely, but possible.

For regular operations this is a non issue as AER error injection is meant
for debugging and testing and not for usage on production systems. People
using this should better know what they are doing.

Fixes: 390e2db82480 ("PCI/AER: Abstract AER interrupt handling")
Reported-by: sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/20200306130624.098374457@linutronix.de
---
 drivers/pci/pcie/Kconfig      | 1 +
 drivers/pci/pcie/aer_inject.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 6e3c04b..7876dc4 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -34,6 +34,7 @@ config PCIEAER
 config PCIEAER_INJECT
 	tristate "PCI Express error injection support"
 	depends on PCIEAER
+	select GENERIC_IRQ_INJECTION
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
 	  (AER) software error injector.
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 6988fe7..21cc3d3 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -16,7 +16,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/miscdevice.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -468,9 +468,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		}
 		pci_info(edev->port, "Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
-		local_irq_disable();
-		generic_handle_irq(edev->irq);
-		local_irq_enable();
+		ret = irq_inject_interrupt(edev->irq);
 	} else {
 		pci_err(rpdev, "AER device not found\n");
 		ret = -ENODEV;
