Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A5C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CD120732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgCTNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgCTNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:31 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVl-00049C-9m
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2D2C0100375
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:27 +0100 (CET)
Message-Id: <20200320131509.859324598@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:57 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
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
Subject: [patch 12/22] hwmon: Convert to new X86 CPU match macros
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/coretemp.c    |    2 +-
 drivers/hwmon/via-cputemp.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -709,7 +709,7 @@ static int coretemp_cpu_offline(unsigned
 	return 0;
 }
 static const struct x86_cpu_id __initconst coretemp_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_DTHERM },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_DTHERM, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, coretemp_ids);
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -270,10 +270,10 @@ static int via_cputemp_down_prep(unsigne
 }
 
 static const struct x86_cpu_id __initconst cputemp_ids[] = {
-	{ X86_VENDOR_CENTAUR, 6, 0xa, }, /* C7 A */
-	{ X86_VENDOR_CENTAUR, 6, 0xd, }, /* C7 D */
-	{ X86_VENDOR_CENTAUR, 6, 0xf, }, /* Nano */
-	{ X86_VENDOR_CENTAUR, 7, X86_MODEL_ANY, },
+	X86_MATCH_VENDOR_FAM_MODEL(CENTAUR, 6, X86_CENTAUR_FAM6_C7_A,	NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(CENTAUR, 6, X86_CENTAUR_FAM6_C7_D,	NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(CENTAUR, 6, X86_CENTAUR_FAM6_NANO,	NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(CENTAUR, 7, X86_MODEL_ANY,		NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, cputemp_ids);

