Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA4DC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8B6206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF5+CXBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgAaCME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:12:04 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34222 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgAaCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:12:03 -0500
Received: by mail-yw1-f65.google.com with SMTP id b186so3238549ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 18:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Huel3zFKgNIhqpbw2Xk27XJrJ68skwtEJsm+LSUkbX8=;
        b=pF5+CXBCyELbrWbAjEiWE+iO5Sp8EwimN3IRJWeXlaFSEPPs1Up5Jjlqhr43/0saRf
         bh7omFofTHTKPYA6cUtmv6OexLG+yLnwjOLCaOQox78m9yHhfArmopWhjqNMKadAy5Iq
         udC4I/4vOUwBIc4iEy7wxrjTuYTIYlJTvyeV5o/wF6WCb+vRGctiHA8Ff1rqrSxMa+cF
         vU5xPBXK+6wK2ICIa5T56LzdkKk1e6jBCUdhRxeE6+1Ha10SRWagULLhdwIIFpsBZywp
         fu8At9Cd2KT2xMLRJs1JlqYX+u7pbHLFbNUF/0g+YWwXQPAhK56cSDyEK85c7sa+pQJd
         WSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Huel3zFKgNIhqpbw2Xk27XJrJ68skwtEJsm+LSUkbX8=;
        b=keXnC58rBvG6YMYal1WWoqfuxSKLE2FZ3PaZ2pH5aK79/gri3BT5jzbgHl9oZ4TxnU
         g40duwbVEwgj8QShEBIVXUGJwQlgvcCyBXR/9azJjCLuSdph0+2cqNNB0AsPYR71kD7T
         N9WM4xa9nLUNjgBj6xWRVs8vK39dIufZge2gqYWiFnZ00dW01Wd+vZB325wdflK/5cDi
         Gxarg4h4G6B0dQ9HcSoOGNHfB4Jtb6nGhMS7hqEHnHIqHIpDeu/BraDpEtKwLoxKv5wj
         /2dat5KIwpPZ5EOktpNVwUT28LKJlwsooO9u9cRgdSWZYryvDpOXcFCpLT+6CMNaqs7c
         s5xw==
X-Gm-Message-State: APjAAAUuv+tlrhj5+LgypYFCWFUWFrBJHyv5LUFoGnmGd/Wy3/HnE7HE
        NW7p2ASrGBUMBa7oT71DrsI=
X-Google-Smtp-Source: APXvYqx+bdlF25sone00aZxJdABrs8lY0EG9CsH4rUgzJuPW4fRAqqn9WndwryRJCKj3CRrNk5ZJkQ==
X-Received: by 2002:a81:4e0f:: with SMTP id c15mr5839406ywb.131.1580436722780;
        Thu, 30 Jan 2020 18:12:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o189sm3523524ywe.15.2020.01.30.18.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jan 2020 18:12:02 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] x86: Fix static memory detection
Date:   Thu, 30 Jan 2020 18:11:59 -0800
Message-Id: <20200131021159.9178-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting x86 images in qemu, the following warning is seen
randomly if DEBUG_LOCKDEP is enabled.

WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1119
	lockdep_register_key+0xc0/0x100

static_obj() returns true if an address is between _stext and _end.
On x86, this includes the brk memory space. Problem is that this
memory block is not static on x86; its unused portions are released
after init and can be allocated. This results in the observed warning
if a lockdep object is allocated from this memory.

Solve the problem by implementing arch_is_kernel_initmem_freed()
for x86 and have it return true if an address is within the released
memory range.

The same problem was solved for s390 with commit 7a5da02de8d6e
("locking/lockdep: check for freed initmem in static_obj()"), which
introduced arch_is_kernel_initmem_freed().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/include/asm/sections.h | 20 ++++++++++++++++++++
 arch/x86/kernel/setup.c         |  1 -
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 036c360910c5..a6e8373a5170 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SECTIONS_H
 #define _ASM_X86_SECTIONS_H
 
+#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
+
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
@@ -14,4 +16,22 @@ extern char __end_rodata_hpage_align[];
 
 extern char __end_of_kernel_reserve[];
 
+extern unsigned long _brk_start, _brk_end;
+
+static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
+{
+	/*
+	 * If _brk_start has not been cleared, brk allocation is incomplete,
+	 * and we can not make assumptions about its use.
+	 */
+	if (_brk_start)
+		return 0;
+
+	/*
+	 * After brk allocation is complete, space between _brk_end and _end
+	 * is available for allocation.
+	 */
+	return addr >= _brk_end && addr < (unsigned long)&_end;
+}
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1e4c20a1efec..08f5ceed70e0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -64,7 +64,6 @@ RESERVE_BRK(dmi_alloc, 65536);
  * at link time, with RESERVE_BRK*() facility reserving additional
  * chunks.
  */
-static __initdata
 unsigned long _brk_start = (unsigned long)__brk_base;
 unsigned long _brk_end   = (unsigned long)__brk_base;
 
-- 
2.17.1

