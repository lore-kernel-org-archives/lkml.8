Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E078C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A84F21739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DEAlrHjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCCJed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:34:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38599 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:34:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id q9so1182286pfs.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5P/sXCt+Hcyg97LrwDdr2AsDly6MFOqsSfN+YS/Fo8=;
        b=DEAlrHjPpfkDZ1GFpKfd52+aJ/CpFOGFzxUfw37HY/MAMOigptw+lpk9xlOpuvYAeS
         sP8pDvXLauQA/0ioqbpmfpKwqeMgiUzWXtpFWAuAQ718Rnqo1VoiRv8bRjzWOpzAddVa
         GCTNJVLrEPAG06joILqqFsLMzL8zwsAz7extcXguQGdXFbRvG9WTXx4wImdywkXc2M7n
         q9AAVwXw83RACTsaqGJudufydYPkFeRtOC5rEfZNKU+W96FL+ZpUT/1JR3DXoeCFJsQ7
         HnR+BTM7+60RMH1WuAandpNvid2CUrNPB/+vRmbq/ro9mT1e59qF4Cg/hYf/IoaZOLVx
         S99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5P/sXCt+Hcyg97LrwDdr2AsDly6MFOqsSfN+YS/Fo8=;
        b=GfOCcukpbhYfZCWLr+FVKFE8rLYkmn7qlXZWxx/KZ1Q8G79mAQbtJqbxE1vMa5VGpV
         Fm3YKjyhiirobSZwnHUig2I4idvWlFPNa7tEocuBRx1z3f6sLVGz204uQnSZZoweSDSq
         CxTZBYdwvKCn3HY20/CQ57Rdq90UifRZZh9+A/xd3c1Sori6Fr81xyb66xLYchq9BTns
         7IAvHnU4hCbHgipt0pbFIFeuZc0n/zsDTxK4HkNYVo+bwf55YWuP23A/vyXUI3sUZJWe
         lnrV/DxAosddyFANvHCUGbfp66eQ/y8DLhxR9tujWSr9XxRT9aoPi3weWaIy5uc8wnPe
         m3TQ==
X-Gm-Message-State: ANhLgQ27PA7tamzC9oCT4vTIAgxIi9Q+rylFMf3HaHgp4IrW574rDs9n
        PPWrgrDHS8BbOLp+szZmOWMZjA==
X-Google-Smtp-Source: ADFU+vvPQc7v6VSOhwFELUaAz1Wui3zlaBOCPuw/5vUSQYVlQZ2XMZVxbq5R00srsSTRpJyhEgLfww==
X-Received: by 2002:a62:1889:: with SMTP id 131mr3272701pfy.250.1583228071690;
        Tue, 03 Mar 2020 01:34:31 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s5sm1494745pfh.47.2020.03.03.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:34:31 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 1/2] riscv: uaccess should be used in nommu mode
Date:   Tue,  3 Mar 2020 17:34:17 +0800
Message-Id: <20200303093418.9180-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might have the unaligned access exception when trying to exchange data
with user space program. In this case, it failed in tty_ioctl(). Therefore
we should enable uaccess.S for NOMMU mode since the generic code doesn't
handle the unaligned access cases.

   0x8013a212 <tty_ioctl+462>:  ld      a5,460(s1)

[    0.115279] Oops - load address misaligned [#1]
[    0.115284] CPU: 0 PID: 29 Comm: sh Not tainted 5.4.0-rc5-00020-gb4c27160d562-dirty #36
[    0.115294] epc: 000000008013a212 ra : 000000008013a212 sp : 000000008f48dd50
[    0.115303]  gp : 00000000801cac28 tp : 000000008fb80000 t0 : 00000000000000e8
[    0.115312]  t1 : 000000008f58f108 t2 : 0000000000000009 s0 : 000000008f48ddf0
[    0.115321]  s1 : 000000008f8c6220 a0 : 0000000000000001 a1 : 000000008f48dd28
[    0.115330]  a2 : 000000008fb80000 a3 : 00000000801a7398 a4 : 0000000000000000
[    0.115339]  a5 : 0000000000000000 a6 : 000000008f58f0c6 a7 : 000000000000001d
[    0.115348]  s2 : 000000008f8c6308 s3 : 000000008f78b7c8 s4 : 000000008fb834c0
[    0.115357]  s5 : 0000000000005413 s6 : 0000000000000000 s7 : 000000008f58f2b0
[    0.115366]  s8 : 000000008f858008 s9 : 000000008f776818 s10: 000000008f776830
[    0.115375]  s11: 000000008fb840a8 t3 : 1999999999999999 t4 : 000000008f78704c
[    0.115384]  t5 : 0000000000000005 t6 : 0000000000000002
[    0.115391] status: 0000000200001880 badaddr: 000000008f8c63ec cause: 0000000000000004
[    0.115401] ---[ end trace 00d490c6a8b6c9ac ]---

This failure could be fixed after this patch applied.

[    0.002282] Run /init as init process
Initializing random number generator... [    0.005573] random: dd: uninitialized urandom read (512 bytes read)
done.

Welcome to Buildroot
buildroot login: root
Password:
Jan  1 00:00:00 login[62]: root login on 'ttySIF0'
~ #

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig               |  1 -
 arch/riscv/include/asm/uaccess.h | 36 ++++++++++++++++----------------
 arch/riscv/lib/Makefile          |  2 +-
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 73f029eae0cc..92d63a63aec8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,7 +50,6 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_TIMER
-	select UACCESS_MEMCPY if !MMU
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index f462a183a9c2..8ce9d607b53d 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -11,6 +11,24 @@
 /*
  * User space memory access functions
  */
+
+extern unsigned long __must_check __asm_copy_to_user(void __user *to,
+	const void *from, unsigned long n);
+extern unsigned long __must_check __asm_copy_from_user(void *to,
+	const void __user *from, unsigned long n);
+
+static inline unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return __asm_copy_from_user(to, from, n);
+}
+
+static inline unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return __asm_copy_to_user(to, from, n);
+}
+
 #ifdef CONFIG_MMU
 #include <linux/errno.h>
 #include <linux/compiler.h>
@@ -367,24 +385,6 @@ do {								\
 		-EFAULT;					\
 })
 
-
-extern unsigned long __must_check __asm_copy_to_user(void __user *to,
-	const void *from, unsigned long n);
-extern unsigned long __must_check __asm_copy_from_user(void *to,
-	const void __user *from, unsigned long n);
-
-static inline unsigned long
-raw_copy_from_user(void *to, const void __user *from, unsigned long n)
-{
-	return __asm_copy_from_user(to, from, n);
-}
-
-static inline unsigned long
-raw_copy_to_user(void __user *to, const void *from, unsigned long n)
-{
-	return __asm_copy_to_user(to, from, n);
-}
-
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 extern long __must_check strlen_user(const char __user *str);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 47e7a8204460..0d0db80800c4 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -2,5 +2,5 @@
 lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
-lib-$(CONFIG_MMU)	+= uaccess.o
+lib-y			+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
-- 
2.25.1

