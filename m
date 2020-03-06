Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ACC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C4320828
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="fgJdQRG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFC5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:57:09 -0500
Received: from ozlabs.org ([203.11.71.1]:50135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCFC5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:57:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48YXMl24Y3z9sPJ;
        Fri,  6 Mar 2020 13:57:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1583463427; bh=jpjw5OFah6kEPVNVvcpiQA3pv8k2QyMsCs3Mb1RKBHw=;
        h=Date:From:To:Cc:Subject:From;
        b=fgJdQRG80ReVgf4vrhLIVyV2vqusF1qUmsRm14QvvudCsNZqYp16J32jK9BtT2soI
         j3kPzEvgq9Afr8BClb+7cxoYky/YeF2nt/KvdSOrX/vSsYuO7o3W7p3Zt8lJo0G+S3
         8zhycTEKsbK2XOhY+M429vbC8x4ZbfcoWKEqteCbcy0dzRQAmkq4dPCStUKaMAe8qy
         JfFlFEaBDFlbFR3Y9PEGgJUPZvJa3XuyBhfrGtL1pAr2K2Jofda5X5iJxkZ9BFl4g/
         PnYXrV1xTT8IbppKpyhGjRKD/nkapjPX5eCMWD/oTK/D3KBOKlyRrA06JKxf6VIl3u
         t+nIoz5l2A96g==
Date:   Fri, 6 Mar 2020 13:57:05 +1100
From:   Anton Blanchard <anton@ozlabs.org>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@ozlabs.org
Subject: [PATCH] powerpc/vdso: Fix multiple issues with sys_call_table
Message-ID: <20200306135705.7f80fcad@kryten.localdomain>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VDSO exports a bitmap of valid syscalls. vdso_setup_syscall_map()
sets this up, but there are both little and big endian bugs. The issue
is with:

       if (sys_call_table[i] != sys_ni_syscall)

On little endian, instead of comparing pointers to the two functions,
we compare the first two instructions of each function. If a function
happens to have the same first two instructions as sys_ni_syscall, then
we have a spurious match and mark the instruction as not implemented.
Fix this by removing the inline declarations.

On big endian we have a further issue where sys_ni_syscall is a function
descriptor and sys_call_table[] holds pointers to the instruction text.
Fix this by using dereference_kernel_function_descriptor().

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@ozlabs.org>

---
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index b9a108411c0d..d186b729026e 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -17,6 +17,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/memblock.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -30,6 +31,7 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 #include <asm/setup.h>
+#include <asm/syscall.h>
 
 #undef DEBUG
 
@@ -644,19 +646,16 @@ static __init int vdso_setup(void)
 static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
-	extern unsigned long *sys_call_table;
-#ifdef CONFIG_PPC64
-	extern unsigned long *compat_sys_call_table;
-#endif
-	extern unsigned long sys_ni_syscall;
+	unsigned long ni_syscall;
 
+	ni_syscall = (unsigned long)dereference_kernel_function_descriptor(sys_ni_syscall);
 
 	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
-		if (sys_call_table[i] != sys_ni_syscall)
+		if (sys_call_table[i] != ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
-		if (compat_sys_call_table[i] != sys_ni_syscall)
+		if (compat_sys_call_table[i] != ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
