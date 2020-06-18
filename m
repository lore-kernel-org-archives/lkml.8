Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EDA2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgFRNvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgFRNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFECC0613EF;
        Thu, 18 Jun 2020 06:51:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwT-0002ik-PU; Thu, 18 Jun 2020 15:50:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5D15D1C0087;
        Thu, 18 Jun 2020 15:50:56 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:56 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/cpu: Enable FSGSBASE on 64bit by default and
 add a chicken bit
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-17-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-17-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825616.16989.4749372730818266021.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     b745cfba44c152c34363eea9e052367b6b1d652b
Gitweb:        https://git.kernel.org/tip/b745cfba44c152c34363eea9e052367b6b1d652b
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 28 May 2020 16:13:58 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:05 +02:00

x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit

Now that FSGSBASE is fully supported, remove unsafe_fsgsbase, enable
FSGSBASE by default, and add nofsgsbase to disable it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1557309753-24073-17-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-13-sashal@kernel.org


---
 Documentation/admin-guide/kernel-parameters.txt |  3 +--
 arch/x86/kernel/cpu/common.c                    | 32 +++++++---------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7308db7..8c0d045 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3079,8 +3079,7 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
-			replaced with a nofsgsbase flag.
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
 	no_console_suspend
 			[HW] Never suspend the console
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7438a31..18857ce 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -441,21 +441,21 @@ static void __init setup_cr_pinning(void)
 	static_key_enable(&cr_pinning.key);
 }
 
-/*
- * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
- * updated. This allows us to get the kernel ready incrementally.
- *
- * Once all the pieces are in place, these will go away and be replaced with
- * a nofsgsbase chicken flag.
- */
-static bool unsafe_fsgsbase;
-
-static __init int setup_unsafe_fsgsbase(char *arg)
+static __init int x86_nofsgsbase_setup(char *arg)
 {
-	unsafe_fsgsbase = true;
+	/* Require an exact match without trailing characters. */
+	if (strlen(arg))
+		return 0;
+
+	/* Do not emit a message if the feature is not present. */
+	if (!boot_cpu_has(X86_FEATURE_FSGSBASE))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+	pr_info("FSGSBASE disabled via kernel command line\n");
 	return 1;
 }
-__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+__setup("nofsgsbase", x86_nofsgsbase_setup);
 
 /*
  * Protection Keys are not available in 32-bit mode.
@@ -1512,12 +1512,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		if (unsafe_fsgsbase)
-			cr4_set_bits(X86_CR4_FSGSBASE);
-		else
-			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
-	}
+	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+		cr4_set_bits(X86_CR4_FSGSBASE);
 
 	/*
 	 * The vendor-specific functions might have changed features.
