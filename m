Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF3C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CFD208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgCXWce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgCXWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5v-0006ud-2P; Tue, 24 Mar 2020 23:32:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB64F1C0470;
        Tue, 24 Mar 2020 23:32:17 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:17 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] thermal: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.967017771@linutronix.de>
References: <20200320131509.967017771@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913735.28353.7806943171505413477.tip-bot2@tip-bot2>
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

Commit-ID:     9c51044cbc5fe9bb2c3bf71cb0dbcbd96ed03301
Gitweb:        https://git.kernel.org/tip/9c51044cbc5fe9bb2c3bf71cb0dbcbd96ed03301
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:58 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:33:53 +01:00

thermal: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local QUARK defines and use the proper ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.967017771@linutronix.de
---
 drivers/thermal/intel/intel_powerclamp.c        | 2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c | 5 +----
 drivers/thermal/intel/intel_soc_dts_thermal.c   | 3 +--
 drivers/thermal/intel/x86_pkg_temp_thermal.c    | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 53216dc..f74b247 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -651,7 +651,7 @@ static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 };
 
 static const struct x86_cpu_id __initconst intel_powerclamp_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_MWAIT, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 5d33b35..d704fc1 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -64,9 +64,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/iosf_mbi.h>
 
-#define X86_FAMILY_QUARK	0x5
-#define X86_MODEL_QUARK_X1000	0x9
-
 /* DTS reset is programmed via QRK_MBI_UNIT_SOC */
 #define QRK_DTS_REG_OFFSET_RESET	0x34
 #define QRK_DTS_RESET_BIT		BIT(0)
@@ -433,7 +430,7 @@ err_ret:
 }
 
 static const struct x86_cpu_id qrk_thermal_ids[] __initconst  = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_QUARK, X86_MODEL_QUARK_X1000 },
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, qrk_thermal_ids);
diff --git a/drivers/thermal/intel/intel_soc_dts_thermal.c b/drivers/thermal/intel/intel_soc_dts_thermal.c
index f4be9c1..92e5c19 100644
--- a/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -36,8 +36,7 @@ static irqreturn_t soc_irq_thread_fn(int irq, void *dev_data)
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT, 0,
-		BYT_SOC_DTS_APIC_IRQ},
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index ddb4a97..23d9990 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -478,7 +478,7 @@ static int pkg_thermal_cpu_online(unsigned int cpu)
 }
 
 static const struct x86_cpu_id __initconst pkg_temp_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_PTS },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_PTS, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);
