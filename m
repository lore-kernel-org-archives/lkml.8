Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE5C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD13A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCTNQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCTNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:35 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVp-0004A6-5z
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:33 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 477D21040C7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:28 +0100 (CET)
Message-Id: <20200320131510.393113444@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:14:02 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
        linux-mmc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 17/22] PCI: intel-mid: Convert to new X86 CPU match macros
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

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-mid.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -55,15 +55,13 @@ static const struct pci_platform_pm_ops
 	.need_resume	= mid_pci_need_resume,
 };
 
-#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 /*
  * This table should be in sync with the one in
  * arch/x86/platform/intel-mid/pwr.c.
  */
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SALTWELL_MID),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 

