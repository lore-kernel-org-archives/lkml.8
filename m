Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3A720737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgDMIkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:40:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39892 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgDMIkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:40:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jNudf-0007z6-5Z; Mon, 13 Apr 2020 10:40:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A61BB1C0092;
        Mon, 13 Apr 2020 10:40:18 +0200 (CEST)
Date:   Mon, 13 Apr 2020 08:40:18 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/smpboot: Remove the last ICPU() macro
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324185836.GI22931@zn.tnic>
References: <20200324185836.GI22931@zn.tnic>
MIME-Version: 1.0
Message-ID: <158676721824.28353.7844544584535496373.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2fa9a3cf3055db07a4835eb7bd48c648cb17ac26
Gitweb:        https://git.kernel.org/tip/2fa9a3cf3055db07a4835eb7bd48c648cb17ac26
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Tue, 24 Mar 2020 19:58:36 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Apr 2020 10:34:09 +02:00

x86/smpboot: Remove the last ICPU() macro

Now all is using the shiny new macros.

No code changed:

  # arch/x86/kernel/smpboot.o:

   text    data     bss     dec     hex filename
  16432    2649      40   19121    4ab1 smpboot.o.before
  16432    2649      40   19121    4ab1 smpboot.o.after

md5:
   a58104003b72c1de533095bc5a4c30a9  smpboot.o.before.asm
   a58104003b72c1de533095bc5a4c30a9  smpboot.o.after.asm

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200324185836.GI22931@zn.tnic
---
 arch/x86/kernel/smpboot.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab96..3b9bf8c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1849,24 +1849,25 @@ static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
-#define ICPU(model) \
-	{X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
+#define X86_MATCH(model)					\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
+		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
 
 static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
-	ICPU(INTEL_FAM6_XEON_PHI_KNL),
-	ICPU(INTEL_FAM6_XEON_PHI_KNM),
+	X86_MATCH(XEON_PHI_KNL),
+	X86_MATCH(XEON_PHI_KNM),
 	{}
 };
 
 static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_X),
+	X86_MATCH(SKYLAKE_X),
 	{}
 };
 
 static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
+	X86_MATCH(ATOM_GOLDMONT),
+	X86_MATCH(ATOM_GOLDMONT_D),
+	X86_MATCH(ATOM_GOLDMONT_PLUS),
 	{}
 };
 
