Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C36C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7C206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgFJLFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:05:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60286 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgFJLFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:05:33 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jiyXh-0000N0-OA; Wed, 10 Jun 2020 21:05:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2020 21:05:13 +1000
Date:   Wed, 10 Jun 2020 21:05:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [v2 PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610110513.GA22897@gondor.apana.org.au>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
 <20200610102851.GA22584@gondor.apana.org.au>
 <20200610103418.GE14118@zn.tnic>
 <20200610104113.GA22678@gondor.apana.org.au>
 <20200610104845.GF14118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610104845.GF14118@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:48:45PM +0200, Borislav Petkov wrote:
>
> Why isn't *this* in your commit message?

Sure, here it is.

---8<---
The x86 microcode support works just fine without FW_LOADER.  In
fact these days most people load them early in boot so FW_LOADER
never gets into the picture anyway.

As almost everyone on x86 needs to enable MICROCODE this by extension
means that FW_LOADER is always built into the kernel even if nothing
uses it.  The FW_LOADER system is about two thousand lines long and
contains user-space facing interfaces that could potentially provide
an entry point into the kernel (or beyond).

This patch removes the unnecessary select of FW_LOADER by MICROCODE.
People who need the FW_LOADER capability can still enable it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104ea8af0..8aac7a65bfbb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1296,7 +1296,6 @@ config MICROCODE
 	bool "CPU microcode loading support"
 	default y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
-	select FW_LOADER
 	---help---
 	  If you say Y here, you will be able to update the microcode on
 	  Intel and AMD processors. The Intel support is for the IA32 family,
@@ -1318,7 +1317,6 @@ config MICROCODE_INTEL
 	bool "Intel microcode loading support"
 	depends on MICROCODE
 	default MICROCODE
-	select FW_LOADER
 	---help---
 	  This options enables microcode patch loading support for Intel
 	  processors.
@@ -1330,7 +1328,6 @@ config MICROCODE_INTEL
 config MICROCODE_AMD
 	bool "AMD microcode loading support"
 	depends on MICROCODE
-	select FW_LOADER
 	---help---
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b2df0c..5524ea15b3df 100644
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
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
