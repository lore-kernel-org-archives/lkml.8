Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A3C352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B66206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436593AbgDNIWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407129AbgDNIUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F85C00860B;
        Tue, 14 Apr 2020 01:20:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoL-0006Gl-1u; Tue, 14 Apr 2020 10:20:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9EFD61C0086;
        Tue, 14 Apr 2020 10:20:48 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:48 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Revert struct layout change to fix kexec
 boot regression
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Dave Young <dyoung@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158685244823.28353.9175276609347162511.tip-bot2@tip-bot2>
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

Commit-ID:     a088b858f16af85e3db359b6c6aaa92dd3bc0921
Gitweb:        https://git.kernel.org/tip/a088b858f16af85e3db359b6c6aaa92dd3bc0921
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 10 Apr 2020 09:43:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:17 +02:00

efi/x86: Revert struct layout change to fix kexec boot regression

Commit

  0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")

removed the code that retrieves the non-remapped UEFI runtime services
pointer from the data structure provided by kexec, as it was never really
needed on the kexec boot path: mapping the runtime services table at its
non-remapped address is only needed when calling SetVirtualAddressMap(),
which never happens during a kexec boot in the first place.

However, dropping the 'runtime' member from struct efi_setup_data was a
mistake. That struct is shared ABI between the kernel and the kexec tooling
for x86, and so we cannot simply change its layout. So let's put back the
removed field, but call it 'unused' to reflect the fact that we never look
at its contents. While at it, add a comment to remind our future selves
that the layout is external ABI.

Fixes: 0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Tested-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cdcf48d..8391c11 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -178,8 +178,10 @@ extern void efi_free_boot_services(void);
 extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
 extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
+/* kexec external ABI */
 struct efi_setup_data {
 	u64 fw_vendor;
+	u64 __unused;
 	u64 tables;
 	u64 smbios;
 	u64 reserved[8];
