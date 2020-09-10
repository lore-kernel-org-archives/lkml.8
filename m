Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2685AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63A420C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9mE3rMr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5CY65Hom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgIJQyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:54:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIJQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:38:17 -0400
Date:   Thu, 10 Sep 2020 16:37:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599755865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swb/GFKEUcMl6eydIdfu3mru6VX/JUoaSCA+xSouJ7s=;
        b=S9mE3rMrc8Z3kBHoiyH7BoB8Zk88rtZHKQZ3a15WutxsLGhNIpuz3GUAawtoE8XVn8kErc
        mNUaDeNQPyvqKThFGIs5AUK/OxtPp9DtWZ7S5LrWI2hAtfsOdQnqbgkSg1zTZfCV1ic5Rv
        36DIao8oSl5nUoBxlqTaY6vgsPCHG+BBTHo12AzRKlUKH4p6eygnVb/Qfp4RiV8O02ozRB
        KXqpsYRG2V3rX5C8ilyrgOQgU7TFgeH7g1QwLG8SmuCfCK3F8H8Izclvl9+gHs/9gPHViI
        7UcjwMsE3tPiXAeT53qvqI84jSaTMivaGuWudtIsyw2lYK96RHZia0RcS7NecQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599755865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swb/GFKEUcMl6eydIdfu3mru6VX/JUoaSCA+xSouJ7s=;
        b=5CY65HomqyX89UGxBYP8iJh8OmbmlITyl+hJRf88LcTDg71O/mzotiq//KZiTBPqgkf9AC
        68jcz3hacJbNdIAw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Allow multiple bits in clearcpuid= parameter
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907213919.2423441-1-nivedita@alum.mit.edu>
References: <20200907213919.2423441-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159975586380.20229.16836491177743031748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0a4bb5e5507a585532cc413125b921c8546fc39f
Gitweb:        https://git.kernel.org/tip/0a4bb5e5507a585532cc413125b921c8546fc39f
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 07 Sep 2020 17:39:19 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Sep 2020 18:32:05 +02:00

x86/fpu: Allow multiple bits in clearcpuid= parameter

Commit

  0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE argument")

changed clearcpuid parsing from __setup() to cmdline_find_option().
While the __setup() function would have been called for each clearcpuid=
parameter on the command line, cmdline_find_option() will only return
the last one, so the change effectively made it impossible to disable
more than one bit.

Allow a comma-separated list of bit numbers as the argument for
clearcpuid to allow multiple bits to be disabled again. Log the bits
being disabled for informational purposes.

Also fix the check on the return value of cmdline_find_option(). It
returns -1 when the option is not found, so testing as a boolean is
incorrect.

Fixes: 0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE argument")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907213919.2423441-1-nivedita@alum.mit.edu
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/kernel/fpu/init.c                      | 30 +++++++++++-----
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a106874..ffe8643 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -577,7 +577,7 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clearcpuid=BITNUM [X86]
+	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
 			numbers. Note the Linux specific bits are not necessarily
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 61ddc3a..f8ff895 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -243,9 +243,9 @@ static void __init fpu__init_system_ctx_switch(void)
  */
 static void __init fpu__init_parse_early_param(void)
 {
-	char arg[32];
+	char arg[128];
 	char *argptr = arg;
-	int bit;
+	int arglen, res, bit;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -268,12 +268,26 @@ static void __init fpu__init_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
-	if (cmdline_find_option(boot_command_line, "clearcpuid", arg,
-				sizeof(arg)) &&
-	    get_option(&argptr, &bit) &&
-	    bit >= 0 &&
-	    bit < NCAPINTS * 32)
-		setup_clear_cpu_cap(bit);
+	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
+	if (arglen <= 0)
+		return;
+
+	pr_info("Clearing CPUID bits:");
+	do {
+		res = get_option(&argptr, &bit);
+		if (res == 0 || res == 3)
+			break;
+
+		/* If the argument was too long, the last bit may be cut off */
+		if (res == 1 && arglen >= sizeof(arg))
+			break;
+
+		if (bit >= 0 && bit < NCAPINTS * 32) {
+			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			setup_clear_cpu_cap(bit);
+		}
+	} while (res == 2);
+	pr_cont("\n");
 }
 
 /*
