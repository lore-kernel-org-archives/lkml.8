Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FEC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5E0206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436607AbgDNIXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407128AbgDNIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07EC00860A;
        Tue, 14 Apr 2020 01:20:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoN-0006I5-8z; Tue, 14 Apr 2020 10:20:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD84C1C0450;
        Tue, 14 Apr 2020 10:20:50 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:50 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/arm: Deal with ADR going out of range in
 efi_enter_kernel()
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200409130434.6736-6-ardb@kernel.org>
References: <20200409130434.6736-6-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158685245053.28353.8781169269960396594.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     a94691680bace7e1404e4f235badb74e30467e86
Gitweb:        https://git.kernel.org/tip/a94691680bace7e1404e4f235badb74e30467e86
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 15:04:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:14 +02:00

efi/arm: Deal with ADR going out of range in efi_enter_kernel()

Commit

  0698fac4ac2a ("efi/arm: Clean EFI stub exit code from cache instead of avoiding it")

introduced a PC-relative reference to 'call_cache_fn' into
efi_enter_kernel(), which lives way at the end of head.S. In some cases,
the ARM version of the ADR instruction does not have sufficient range,
resulting in a build error:

  arch/arm/boot/compressed/head.S:1453: Error: invalid constant (fffffffffffffbe4) after fixup

ARM defines an alternative with a wider range, called ADRL, but this does
not exist for Thumb-2. At the same time, the ADR instruction in Thumb-2
has a wider range, and so it does not suffer from the same issue.

So let's switch to ADRL for ARM builds, and keep the ADR for Thumb-2 builds.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200409130434.6736-6-ardb@kernel.org
---
 arch/arm/boot/compressed/head.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index cabdd8f..e8e1c86 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1450,7 +1450,8 @@ ENTRY(efi_enter_kernel)
 		@ running beyond the PoU, and so calling cache_off below from
 		@ inside the PE/COFF loader allocated region is unsafe unless
 		@ we explicitly clean it to the PoC.
-		adr	r0, call_cache_fn		@ region of code we will
+ ARM(		adrl	r0, call_cache_fn	)
+ THUMB(		adr	r0, call_cache_fn	)	@ region of code we will
 		adr	r1, 0f				@ run with MMU off
 		bl	cache_clean_flush
 		bl	cache_off
