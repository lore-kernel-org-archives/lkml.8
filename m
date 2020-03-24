Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29526C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC4A208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgCXWdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:33:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgCXWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5s-0006vp-93; Tue, 24 Mar 2020 23:32:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C96001C0451;
        Tue, 24 Mar 2020 23:32:19 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] ACPI: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.467730627@linutronix.de>
References: <20200320131509.467730627@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913943.28353.15124523012453063581.tip-bot2@tip-bot2>
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

Commit-ID:     e36cf2f768467cff824e7da87aedc4e99e4c8396
Gitweb:        https://git.kernel.org/tip/e36cf2f768467cff824e7da87aedc4e99e4c8396
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:53 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:30:50 +01:00

ACPI: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Rename the local macro wrapper to X86_MATCH for consistency. It stays for
readability sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.467730627@linutronix.de
---
 drivers/acpi/acpi_lpss.c |  6 ++----
 drivers/acpi/x86/utils.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index db18df6..dee9999 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -306,11 +306,9 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
 	.setup = lpss_deassert_reset,
 };
 
-#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */
-	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
 	{}
 };
 
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 697a6b1..bdc1ba0 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -37,7 +37,7 @@ struct always_present_id {
 	const char *uid;
 };
 
-#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+#define X86_MATCH(model)	X86_MATCH_INTEL_FAM6_MODEL(model, NULL)
 
 #define ENTRY(hid, uid, cpu_models, dmi...) {				\
 	{ { hid, }, {} },						\
@@ -51,29 +51,29 @@ static const struct always_present_id always_present_ids[] = {
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	ENTRY("80860F09", "1", ICPU(INTEL_FAM6_ATOM_SILVERMONT), {}),
-	ENTRY("80862288", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
+	ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
+	ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
 
 	/* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
-	ENTRY("80862289", "2", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
 		}),
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
-	ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {}),
+	ENTRY("INT0002", "1", X86_MATCH(ATOM_AIRMONT), {}),
 	/*
 	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
 	 * the touchscreen ACPI device until a certain time
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_L), {
+	ENTRY("SYNA7500", "1", X86_MATCH(HASWELL_L), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	ENTRY("SYNA7500", "1", ICPU(INTEL_FAM6_HASWELL_L), {
+	ENTRY("SYNA7500", "1", X86_MATCH(HASWELL_L), {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
@@ -89,19 +89,19 @@ static const struct always_present_id always_present_ids[] = {
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
 	 * node which we should not enable, thus we also check the BIOS date.
 	 */
-	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
 	      }),
-	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
-	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
+	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
