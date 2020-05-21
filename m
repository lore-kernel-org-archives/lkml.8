Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4D620823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgEUVI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgEUVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:08:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65728C061A0E;
        Thu, 21 May 2020 14:08:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jbsQv-0001kN-O1; Thu, 21 May 2020 23:08:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2ECFA1C010B;
        Thu, 21 May 2020 23:08:53 +0200 (CEST)
Date:   Thu, 21 May 2020 21:08:53 -0000
From:   "tip-bot2 for Krzysztof Piecuch" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/tsc: Add tsc_early_khz command line parameter
Cc:     Krzysztof Piecuch <piecuch@protonmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3CO2CpIOrqLZHgNRkfjRpz=5FLGqnc1ix=5FseNIiOCvHY4RHoul?=
 =?utf-8?q?OVRo6kMXKuLOfBVTi0SMMevg6Go1uZ=5FcL9fLYtYdTRNH78ChaFaZyG3VAyY?=
 =?utf-8?q?z8=3D=40protonmail=2Ecom=3E?=
References: =?utf-8?q?=3CO2CpIOrqLZHgNRkfjRpz=5FLGqnc1ix=5FseNIiOCvHY4RHoulO?=
 =?utf-8?q?VRo6kMXKuLOfBVTi0SMMevg6Go1uZ=5FcL9fLYtYdTRNH78ChaFaZyG3VAyYz?=
 =?utf-8?q?8=3D=40protonmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <159009533302.17951.12414541965465458126.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     bd35c77e32e4359580207891c0f7a438ad4b42df
Gitweb:        https://git.kernel.org/tip/bd35c77e32e4359580207891c0f7a438ad4b42df
Author:        Krzysztof Piecuch <piecuch@protonmail.com>
AuthorDate:    Thu, 23 Jan 2020 16:09:26 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 21 May 2020 23:07:00 +02:00

x86/tsc: Add tsc_early_khz command line parameter

Changing base clock frequency directly impacts TSC Hz but not CPUID.16h
value. An overclocked CPU supporting CPUID.16h and with partial CPUID.15h
support will set TSC KHZ according to "best guess" given by CPUID.16h
relying on tsc_refine_calibration_work to give better numbers later.
tsc_refine_calibration_work will refuse to do its work when the outcome is
off the early TSC KHZ value by more than 1% which is certain to happen on
an overclocked system.

Fix this by adding a tsc_early_khz command line parameter that makes the
kernel skip early TSC calibration and use the given value instead.

This allows the user to provide the expected TSC frequency that is closer
to reality than the one reported by the hardware, enabling
tsc_refine_calibration_work to do meaningful error checking.

[ tglx: Made the variable __initdata as it's only used on init and
        removed the error checking in the argument parser because
	kstrto*() only stores to the variable if the string is valid ]

Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com

---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/x86/kernel/tsc.c                           | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3..409ee4a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5067,6 +5067,12 @@
 			interruptions from clocksource watchdog are not
 			acceptable).
 
+	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
+			value instead. Useful when the early TSC frequency discovery
+			procedure is not reliable, such as on overclocked systems
+			with CPUID.16h support and partial CPUID.15h support.
+			Format: <unsigned int>
+
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
 			support TSX control.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fdd4c10..49d9250 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -41,6 +41,7 @@ EXPORT_SYMBOL(tsc_khz);
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
  */
 static int __read_mostly tsc_unstable;
+static unsigned int __initdata tsc_early_khz;
 
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
@@ -59,6 +60,12 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
+static int __init tsc_early_khz_setup(char *buf)
+{
+	return kstrtouint(buf, 0, &tsc_early_khz);
+}
+early_param("tsc_early_khz", tsc_early_khz_setup);
+
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
@@ -1412,7 +1419,10 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		tsc_khz = x86_platform.calibrate_tsc();
+		if (tsc_early_khz)
+			tsc_khz = tsc_early_khz;
+		else
+			tsc_khz = x86_platform.calibrate_tsc();
 	} else {
 		/* We should not be here with non-native cpu calibration */
 		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
