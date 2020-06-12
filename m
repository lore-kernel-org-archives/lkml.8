Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B51C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A9A206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCLTilb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFLKSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:18:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED00C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:18:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so3939768pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iOkJqi7aCMYM9LukTx1mTmPwI0a9w/kRf9osBcBZvIc=;
        b=JCLTilb/KzC4qQpnHpewmcVqa2dz/z1DYUIZGzZAi6BQhulMANqhXWRNn0a7S6LwX2
         MPpC5wjLCA4pAPGXgrEan8v5RmP3taIXMHDvtwyFhlEuZbDqyR/gDZ1+igFuYar460vB
         oxY1VN3r62rPv4gK3xsX/Nt+/C+M6vGDsmWS+N3FPUpqO6gnYSDuXQQGVoIOaqzXKMt/
         TvWXrFaBvXPbxe0MznrYQVzyG3sxrIG9+A61ljbAzY9A4GMRi/VulHlzNNSor+/t/mn/
         OX68fkXy2atEzWIzfn0+3fYoF+Gz2t4HG87HVJJHAubbwYUnM5MqIGAw3WiAoRL4QKD1
         Hyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iOkJqi7aCMYM9LukTx1mTmPwI0a9w/kRf9osBcBZvIc=;
        b=EdK9eC1mZAyPES3D54RuugFRXCdH3gSuC2e+Enrds5mtVA2Xi/dLAvVEIf7kn5AdNl
         YJq74ldyop+ewg82yMjyXAZMqHW7i83CL8POi3F3wCKECIqBDScTT+sn/ovM/BetNtXk
         CoHTvGn16kc6bGQGr7zxT1kihXGtsxJbJR+8jt/3mG1tuGH5xLNU2Qj+5geFFvaCjKeD
         L4HiHf9SbblphlbkHwte6g31+xIxHNJegyOT791a4Tt+TmEgAX9cmObtwD0yZrFsufow
         yJmR2TCnMQvaul6cKSzbK5n7QzYLyVbNznASI7VjDywvRSf1OkJU4hRjrdb2WWml7Yvv
         lO0g==
X-Gm-Message-State: AOAM531ihq/pyIo5BihitpH8uYGmBRpeDG7IYgzBf0TRAcO7uzKwpy6Y
        sZqBcCwWotH2NuWFLIds70Y=
X-Google-Smtp-Source: ABdhPJyQ4G7taIkYWfJdZloLfXRLDNzwUxjsopQSlmjgh9PAu+FDu65ozs6TceY1j0TL35KGEQcJ4Q==
X-Received: by 2002:a63:f804:: with SMTP id n4mr9157746pgh.302.1591957092495;
        Fri, 12 Jun 2020 03:18:12 -0700 (PDT)
Received: from localhost ([49.205.222.116])
        by smtp.gmail.com with ESMTPSA id d3sm5482512pfh.157.2020.06.12.03.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 03:18:12 -0700 (PDT)
Date:   Fri, 12 Jun 2020 15:48:10 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 2/3] ARM: uaccess: let UACCESS_GUP_KMAP_MEMCPY enabling
Message-ID: <cdbc3ca8921c88c9e31df0664fe1ea7269e9c59d.1591885760.git.afzal.mohd.ma@gmail.com>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn off existing raw_copy_{from,to}_user() using
arm_copy_{from,to}_user() when CONFIG_UACCESS_GUP_KMAP_MEMCPY is
enabled.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/include/asm/uaccess.h | 20 ++++++++++++++++++++
 arch/arm/kernel/armksyms.c     |  2 ++
 arch/arm/lib/Makefile          |  7 +++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 98c6b91be4a8a..4a16ae52d4978 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -512,6 +512,15 @@ do {									\
 extern unsigned long __must_check
 arm_copy_from_user(void *to, const void __user *from, unsigned long n);
 
+#ifdef CONFIG_UACCESS_GUP_KMAP_MEMCPY
+extern unsigned long __must_check
+gup_kmap_copy_from_user(void *to, const void __user *from, unsigned long n);
+static inline __must_check unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return gup_kmap_copy_from_user(to, from, n);
+}
+#else
 static inline unsigned long __must_check
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
@@ -522,12 +531,22 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 	uaccess_restore(__ua_flags);
 	return n;
 }
+#endif
 
 extern unsigned long __must_check
 arm_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __must_check
 __copy_to_user_std(void __user *to, const void *from, unsigned long n);
 
+#ifdef CONFIG_UACCESS_GUP_KMAP_MEMCPY
+extern unsigned long __must_check
+gup_kmap_copy_to_user(void __user *to, const void *from, unsigned long n);
+static inline __must_check unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return gup_kmap_copy_to_user(to, from, n);
+}
+#else
 static inline unsigned long __must_check
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
@@ -541,6 +560,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return arm_copy_to_user(to, from, n);
 #endif
 }
+#endif
 
 extern unsigned long __must_check
 arm_clear_user(void __user *addr, unsigned long n);
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 98bdea51089d5..8c92fe30d1559 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -96,8 +96,10 @@ EXPORT_SYMBOL(mmiocpy);
 #ifdef CONFIG_MMU
 EXPORT_SYMBOL(copy_page);
 
+#ifndef CONFIG_UACCESS_GUP_KMAP_MEMCPY
 EXPORT_SYMBOL(arm_copy_from_user);
 EXPORT_SYMBOL(arm_copy_to_user);
+#endif
 EXPORT_SYMBOL(arm_clear_user);
 
 EXPORT_SYMBOL(__get_user_1);
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 6d2ba454f25b6..1aeff2cd7b4b3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -16,8 +16,11 @@ lib-y		:= changebit.o csumipv6.o csumpartial.o               \
 		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
 		   call_with_stack.o bswapsdi2.o
 
-mmu-y		:= clear_user.o copy_page.o getuser.o putuser.o       \
-		   copy_from_user.o copy_to_user.o
+mmu-y		:= clear_user.o copy_page.o getuser.o putuser.o
+
+ifndef CONFIG_UACCESS_GUP_KMAP_MEMCPY
+  mmu-y		+= copy_from_user.o copy_to_user.o
+endif
 
 ifdef CONFIG_CC_IS_CLANG
   lib-y	+= backtrace-clang.o
-- 
2.26.2

