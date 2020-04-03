Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22642C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC721208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888928;
	bh=KRNe9q7FDPUa62rf/7Q/Lg8JFNzSxpCm816ZYQQwJEU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qBzwY6YyCXoBvEuafsvRUCqr0yPREokZijciWFyKzNdft+1hV3f7N+aM5Zz5kH8rj
	 Pm2biALTOhNcSy20Z6HmKTPyORpEeSxN7N+KM0h4+RABNh851KeuPteUsHdBAuUyc6
	 3z9jjPPRAye/vIqsI+1K5r9bIdmnEXZcwlQaNZkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgDCEmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgDCEmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:06 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557DC2063A;
        Fri,  3 Apr 2020 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888925;
        bh=KRNe9q7FDPUa62rf/7Q/Lg8JFNzSxpCm816ZYQQwJEU=;
        h=From:To:Cc:Subject:Date:From;
        b=pTVooEFZ8FT+bny5X7MEEMizyl5NqtVVlc6ADiKHVeljOyH3P1aqEqTryj2LDQyrB
         Si6dGpbE6hOwd1JvFkvv9DzRURgY8EVioJOq4Y6vALntcEJcFyKXwW9/FToSwvKWlO
         vyXXPxzVFeKXOlpqs4Ppb6vZ2fxE27R+V/V3UbrU=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 01/11] csky: Fixup init_fpu compile warning with __init
Date:   Fri,  3 Apr 2020 12:41:40 +0800
Message-Id: <20200403044150.20562-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

WARNING: vmlinux.o(.text+0x2366): Section mismatch in reference from the
function csky_start_secondary() to the function .init.text:init_fpu()

The function csky_start_secondary() references
the function __init init_fpu().
This is often because csky_start_secondary lacks a __init
annotation or the annotation of init_fpu is wrong.

Reported-by: Lu Chongzhi <chongzhi.lcz@alibaba-inc.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv2/fpu.c         | 5 -----
 arch/csky/abiv2/inc/abi/fpu.h | 3 ++-
 arch/csky/kernel/smp.c        | 3 +++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/csky/abiv2/fpu.c b/arch/csky/abiv2/fpu.c
index 86d187d4e5af..5acc5c2e544e 100644
--- a/arch/csky/abiv2/fpu.c
+++ b/arch/csky/abiv2/fpu.c
@@ -10,11 +10,6 @@
 #define MTCR_DIST	0xC0006420
 #define MFCR_DIST	0xC0006020
 
-void __init init_fpu(void)
-{
-	mtcr("cr<1, 2>", 0);
-}
-
 /*
  * fpu_libc_helper() is to help libc to excute:
  *  - mfcr %a, cr<1, 2>
diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
index 22ca3cf2794a..09e2700a3693 100644
--- a/arch/csky/abiv2/inc/abi/fpu.h
+++ b/arch/csky/abiv2/inc/abi/fpu.h
@@ -9,7 +9,8 @@
 
 int fpu_libc_helper(struct pt_regs *regs);
 void fpu_fpe(struct pt_regs *regs);
-void __init init_fpu(void);
+
+static inline void init_fpu(void) { mtcr("cr<1, 2>", 0); }
 
 void save_to_user_fp(struct user_fp *user_fp);
 void restore_from_user_fp(struct user_fp *user_fp);
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 0bb0954d5570..df2e2174dbd0 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -22,6 +22,9 @@
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+#endif
 
 struct ipi_data_struct {
 	unsigned long bits ____cacheline_aligned;
-- 
2.17.0

