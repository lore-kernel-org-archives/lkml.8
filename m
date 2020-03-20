Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9158FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE7220776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCTNQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35749 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgCTNQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:39 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVt-0004Ba-Eh
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:37 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5D80B1040CD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:29 +0100 (CET)
Message-Id: <20200320131510.900226233@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:14:07 +0100
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
Subject: [patch 22/22] x86/cpu: Cleanup the now unused CPU match macros
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

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu_device_id.h |    3 ---
 arch/x86/include/asm/intel-family.h  |   13 -------------
 2 files changed, 16 deletions(-)

--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -89,9 +89,6 @@
 #define X86_MATCH_FEATURE(feature, data)				\
 	X86_MATCH_VENDOR_FEATURE(ANY, feature, data)
 
-/* Transitional to keep the existing code working */
-#define X86_FEATURE_MATCH(feature)	X86_MATCH_FEATURE(feature, NULL)
-
 /**
  * X86_MATCH_VENDOR_FAM_MODEL - Match vendor, family and model
  * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -124,17 +124,4 @@
 /* Family 5 */
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 
-/* Useful macros */
-#define INTEL_CPU_FAM_ANY(_family, _model, _driver_data)	\
-{								\
-	.vendor		= X86_VENDOR_INTEL,			\
-	.family		= _family,				\
-	.model		= _model,				\
-	.feature	= X86_FEATURE_ANY,			\
-	.driver_data	= (kernel_ulong_t)&_driver_data		\
-}
-
-#define INTEL_CPU_FAM6(_model, _driver_data)			\
-	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
-
 #endif /* _ASM_X86_INTEL_FAMILY_H */

