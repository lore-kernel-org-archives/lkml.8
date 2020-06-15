Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06E2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52C720707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgFOKDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgFOKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:03:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0595C061A0E;
        Mon, 15 Jun 2020 03:03:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jklxt-0006Uf-6S; Mon, 15 Jun 2020 12:03:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B40231C00ED;
        Mon, 15 Jun 2020 12:03:40 +0200 (CEST)
Date:   Mon, 15 Jun 2020 10:03:40 -0000
From:   "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Do not select FW_LOADER
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200610042911.GA20058@gondor.apana.org.au>
References: <20200610042911.GA20058@gondor.apana.org.au>
MIME-Version: 1.0
Message-ID: <159221542045.16989.5680100825839047126.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     c8a59a4d8e3c9e609fa915e39c3628c6dd08aeea
Gitweb:        https://git.kernel.org/tip/c8a59a4d8e3c9e609fa915e39c3628c6dd08aeea
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Wed, 10 Jun 2020 21:05:13 +10:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Jun 2020 11:59:19 +02:00

x86/microcode: Do not select FW_LOADER

The x86 microcode support works just fine without FW_LOADER. In fact,
these days most people load microcode early during boot so FW_LOADER
never gets into the picture anyway.

As almost everyone on x86 needs to enable MICROCODE, this by extension
means that FW_LOADER is always built into the kernel even if nothing
uses it. The FW_LOADER system is about two thousand lines long and
contains user-space facing interfaces that could potentially provide an
entry point into the kernel (or beyond).

Remove the unnecessary select of FW_LOADER by MICROCODE. People who need
the FW_LOADER capability can still enable it.

 [ bp: Massage a bit. ]

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200610042911.GA20058@gondor.apana.org.au
---
 arch/x86/Kconfig                     | 3 ---
 arch/x86/kernel/cpu/microcode/core.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc52..5c44eac 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1292,7 +1292,6 @@ config MICROCODE
 	bool "CPU microcode loading support"
 	default y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
-	select FW_LOADER
 	help
 	  If you say Y here, you will be able to update the microcode on
 	  Intel and AMD processors. The Intel support is for the IA32 family,
@@ -1314,7 +1313,6 @@ config MICROCODE_INTEL
 	bool "Intel microcode loading support"
 	depends on MICROCODE
 	default MICROCODE
-	select FW_LOADER
 	help
 	  This options enables microcode patch loading support for Intel
 	  processors.
@@ -1326,7 +1324,6 @@ config MICROCODE_INTEL
 config MICROCODE_AMD
 	bool "AMD microcode loading support"
 	depends on MICROCODE
-	select FW_LOADER
 	help
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index baec68b..ec6f041 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -145,7 +145,6 @@ extern struct builtin_fw __end_builtin_fw[];
 
 bool get_builtin_firmware(struct cpio_data *cd, const char *name)
 {
-#ifdef CONFIG_FW_LOADER
 	struct builtin_fw *b_fw;
 
 	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
@@ -155,7 +154,6 @@ bool get_builtin_firmware(struct cpio_data *cd, const char *name)
 			return true;
 		}
 	}
-#endif
 	return false;
 }
 
