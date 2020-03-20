Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C20C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1611320732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCTNQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgCTNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:27 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVh-00048A-If
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:25 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id BB49B100375
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:24 +0100 (CET)
Message-Id: <20200320131508.736205164@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 01/22] x86/devicetable: Move x86 specific macro out of generic
 code
References: <20200320131345.635023594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason that this gunk is in a generic header file. The wildcard
defines need to stay as they are required by file2alias.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu_device_id.h   |   13 ++++++++++++-
 arch/x86/kvm/svm.c                     |    1 +
 arch/x86/kvm/vmx/vmx.c                 |    1 +
 drivers/cpufreq/acpi-cpufreq.c         |    1 +
 drivers/cpufreq/amd_freq_sensitivity.c |    1 +
 include/linux/mod_devicetable.h        |    4 +---
 6 files changed, 17 insertions(+), 4 deletions(-)

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
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -48,6 +48,7 @@
 #include <asm/kvm_para.h>
 #include <asm/irq_remapping.h>
 #include <asm/spec-ctrl.h>
+#include <asm/cpu_device_id.h>
 
 #include <asm/virtext.h>
 #include "trace.h"
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
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -30,6 +30,7 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 
 MODULE_AUTHOR("Paul Diefenbaugh, Dominik Brodowski");
 MODULE_DESCRIPTION("ACPI Processor P-States Driver");
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -18,6 +18,7 @@
 
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 
 #include "cpufreq_ondemand.h"
 
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

