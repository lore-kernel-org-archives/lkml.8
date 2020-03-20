Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F5C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588C20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCTNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCTNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:31 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVh-00048B-Gb
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:25 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id F2B3E1039FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:24 +0100 (CET)
Message-Id: <20200320131508.826011988@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:47 +0100
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
Subject: [patch 02/22] x86/cpu: Add conistent CPU match macros
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

Finding all places which build x86_cpu_id match tables is tedious and the
logic is hidden in lots of differently named macro wrappers.

Most of these initializer macros use plain C89 initializers which rely on
the ordering of the struct members. So new members could only be added at
the end of the struct, but that's ugly as hell and C99 initializers are
really the right thing to use.

Provide a set of macros which:

  - Have a proper naming scheme, starting with X86_MATCH_

  - Use C99 initializers

The set of provided macros are all subsets of the base macro

    X86_MATCH_VENDOR_FAM_MODEL_FEATURE()

which allows to supply all possible selection criteria:

      vendor, family, model, feature

The other macros shorten this to avoid typing all arguments when they are
not needed and would require one of the _ANY constants. They have been
created due to the requirements of the existing usage sites.

Also a add a few model constants for Centaur CPUs and QUARK.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu_device_id.h |  140 ++++++++++++++++++++++++++++++++---
 arch/x86/include/asm/intel-family.h  |    6 +
 arch/x86/kernel/cpu/match.c          |   13 ++-
 3 files changed, 146 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -5,21 +5,143 @@
 /*
  * Declare drivers belonging to specific x86 CPUs
  * Similar in spirit to pci_device_id and related PCI functions
- */
-#include <linux/mod_devicetable.h>
-
-/*
+ *
  * The wildcard initializers are in mod_devicetable.h because
  * file2alias needs them. Sigh.
  */
+#include <linux/mod_devicetable.h>
+/* Get the INTEL_FAM* model defines */
+#include <asm/intel-family.h>
+/* And the X86_VENDOR_* ones */
+#include <asm/processor.h>
 
-#define X86_FEATURE_MATCH(x) {			\
-	.vendor		= X86_VENDOR_ANY,	\
-	.family		= X86_FAMILY_ANY,	\
-	.model		= X86_MODEL_ANY,	\
-	.feature	= x,			\
+/* Centaur FAM6 models */
+#define X86_CENTAUR_FAM6_C7_A		0xa
+#define X86_CENTAUR_FAM6_C7_D		0xd
+#define X86_CENTAUR_FAM6_NANO		0xf
+
+/**
+ * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Base macro for CPU matching
+ * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
+ *		The name is expanded to X86_VENDOR_@_vendor
+ * @_family:	The family number or X86_FAMILY_ANY
+ * @_model:	The model number, model constant or X86_MODEL_ANY
+ * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
+ * @_data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * Use only if you need all selectors. Otherwise use one of the shorter
+ * macros of the X86_MATCH_* family. If there is no matching shorthand
+ * macro, consider to add one. If you really need to wrap one of the macros
+ * into another macro at the usage site for good reasons, then please
+ * start this local macro with X86_MATCH to allow easy grepping.
+ */
+#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(_vendor, _family, _model,	\
+					   _feature, _data) {		\
+	.vendor		= X86_VENDOR_##_vendor,				\
+	.family		= _family,					\
+	.model		= _model,					\
+	.feature	= _feature,					\
+	.driver_data	= (unsigned long) _data				\
 }
 
+/**
+ * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
+ * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
+ *		The name is expanded to X86_VENDOR_@vendor
+ * @family:	The family number or X86_FAMILY_ANY
+ * @feature:	A X86_FEATURE bit
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
+ * set to wildcards.
+ */
+#define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)	\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family,		\
+					   X86_MODEL_ANY, feature, data)
+
+/**
+ * X86_MATCH_VENDOR_FEATURE - Macro for matching vendor and CPU feature
+ * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
+ *		The name is expanded to X86_VENDOR_@vendor
+ * @feature:	A X86_FEATURE bit
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
+ * set to wildcards.
+ */
+#define X86_MATCH_VENDOR_FEATURE(vendor, feature, data)			\
+	X86_MATCH_VENDOR_FAM_FEATURE(vendor, X86_FAMILY_ANY, feature, data)
+
+/**
+ * X86_MATCH_FEATURE - Macro for matching a CPU feature
+ * @feature:	A X86_FEATURE bit
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
+ * set to wildcards.
+ */
+#define X86_MATCH_FEATURE(feature, data)				\
+	X86_MATCH_VENDOR_FEATURE(ANY, feature, data)
+
+/* Transitional to keep the existing code working */
+#define X86_FEATURE_MATCH(feature)	X86_MATCH_FEATURE(feature, NULL)
+
+/**
+ * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
+ * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
+ *		The name is expanded to X86_VENDOR_@vendor
+ * @family:	The family number or X86_FAMILY_ANY
+ * @model:	The model number, model constant or X86_MODEL_ANY
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * All other missing arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
+ * set to wildcards.
+ */
+#define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)		\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,	\
+					   X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VENDOR_FAM - Match vendor and family
+ * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
+ *		The name is expanded to X86_VENDOR_@vendor
+ * @family:	The family number or X86_FAMILY_ANY
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * All other missing arguments to X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are
+ * set of wildcards.
+ */
+#define X86_MATCH_VENDOR_FAM(vendor, family, data)			\
+	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, X86_MODEL_ANY, data)
+
+/**
+ * X86_MATCH_INTEL_FAM6_MODEL - Match vendor INTEL, family 6 and model
+ * @model:	The model name without the INTEL_FAM6_ prefix or ANY
+ *		The model name is expanded to INTEL_FAM6_@model internally
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is casted to unsigned long internally.
+ *
+ * The vendor is set to INTEL, the family to 6 and all other missing
+ * arguments of X86_MATCH_VENDOR_FAM_MODEL_FEATURE() are set to wildcards.
+ *
+ * See X86_MATCH_VENDOR_FAM_MODEL_FEATURE() for further information.
+ */
+#define X86_MATCH_INTEL_FAM6_MODEL(model, data)				\
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
+
 /*
  * Match specific microcode revisions.
  *
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -35,6 +35,9 @@
  * The #define line may optionally include a comment including platform names.
  */
 
+/* Wildcard match for FAM6 so X86_MATCH_INTEL_FAM6_MODEL(ANY) works */
+#define INTEL_FAM6_ANY			X86_MODEL_ANY
+
 #define INTEL_FAM6_CORE_YONAH		0x0E
 
 #define INTEL_FAM6_CORE2_MEROM		0x0F
@@ -118,6 +121,9 @@
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
 #define INTEL_FAM6_XEON_PHI_KNM		0x85 /* Knights Mill */
 
+/* Family 5 */
+#define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
+
 /* Useful macros */
 #define INTEL_CPU_FAM_ANY(_family, _model, _driver_data)	\
 {								\
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -16,12 +16,17 @@
  * respective wildcard entries.
  *
  * A typical table entry would be to match a specific CPU
- * { X86_VENDOR_INTEL, 6, 0x12 }
- * or to match a specific CPU feature
- * { X86_FEATURE_MATCH(X86_FEATURE_FOOBAR) }
+ *
+ * X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_BROADWELL,
+ *				      X86_FEATURE_ANY, NULL);
  *
  * Fields can be wildcarded with %X86_VENDOR_ANY, %X86_FAMILY_ANY,
- * %X86_MODEL_ANY, %X86_FEATURE_ANY or 0 (except for vendor)
+ * %X86_MODEL_ANY, %X86_FEATURE_ANY (except for vendor)
+ *
+ * asm/cpu_device_id.h contains a set of useful macros which are shortcuts
+ * for various common selections. The above can be shortened to:
+ *
+ * X86_MATCH_INTEL_FAM6_MODEL(BROADWELL, NULL);
  *
  * Arrays used to match for this should also be declared using
  * MODULE_DEVICE_TABLE(x86cpu, ...)

