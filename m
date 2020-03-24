Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C6C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgCXWd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:33:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgCXWc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5x-0006zi-Jt; Tue, 24 Mar 2020 23:32:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CDF561C04CD;
        Tue, 24 Mar 2020 23:32:22 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/devicetable: Move x86 specific macro out of generic code
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131508.736205164@linutronix.de>
References: <20200320131508.736205164@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508914247.28353.5284085265968828309.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ba5bade4cc0d2013cdf5634dae554693c968a090
Gitweb:        https://git.kernel.org/tip/ba5bade4cc0d2013cdf5634dae554693c968a090
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:46 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:02:47 +01:00

x86/devicetable: Move x86 specific macro out of generic code

There is no reason that this gunk is in a generic header file. The wildcard
defines need to stay as they are required by file2alias.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131508.736205164@linutronix.de
---
 arch/x86/include/asm/cpu_device_id.h   | 13 ++++++++++++-
 arch/x86/kvm/svm.c                     |  1 +
 arch/x86/kvm/vmx/vmx.c                 |  1 +
 drivers/cpufreq/acpi-cpufreq.c         |  1 +
 drivers/cpufreq/amd_freq_sensitivity.c |  1 +
 include/linux/mod_devicetable.h        |  4 +---
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 31c379c..a28dc6b 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -6,10 +6,21 @@
  * Declare drivers belonging to specific x86 CPUs
  * Similar in spirit to pci_device_id and related PCI functions
  */
-
 #include <linux/mod_devicetable.h>
 
 /*
+ * The wildcard initializers are in mod_devicetable.h because
+ * file2alias needs them. Sigh.
+ */
+
+#define X86_FEATURE_MATCH(x) {			\
+	.vendor		= X86_VENDOR_ANY,	\
+	.family		= X86_FAMILY_ANY,	\
+	.model		= X86_MODEL_ANY,	\
+	.feature	= x,			\
+}
+
+/*
  * Match specific microcode revisions.
  *
  * vendor/family/model/stepping must be all set.
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index bef0ba3..5753fc3 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -48,6 +48,7 @@
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
 #include <asm/spec-ctrl.h>
+#include <asm/cpu_device_id.h>
 
 #include <asm/virtext.h>
 #include "trace.h"
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3be25ec..31c80fa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -31,6 +31,7 @@
 #include <asm/apic.h>
 #include <asm/asm.h>
 #include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
 #include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/fpu/internal.h>
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d6f7df3..7ff6595 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -30,6 +30,7 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 
 MODULE_AUTHOR("Paul Diefenbaugh, Dominik Brodowski");
 MODULE_DESCRIPTION("ACPI Processor P-States Driver");
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index e2df9d1..5107cbe 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -18,6 +18,7 @@
 
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 
 #include "cpufreq_ondemand.h"
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index e3596db..f8b66d4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -667,9 +667,7 @@ struct x86_cpu_id {
 	kernel_ulong_t driver_data;
 };
 
-#define X86_FEATURE_MATCH(x) \
-	{ X86_VENDOR_ANY, X86_FAMILY_ANY, X86_MODEL_ANY, x }
-
+/* Wild cards for x86_cpu_id::vendor, family, model and feature */
 #define X86_VENDOR_ANY 0xffff
 #define X86_FAMILY_ANY 0
 #define X86_MODEL_ANY  0
