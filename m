Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C63C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374B62074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3dXwa5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCMTwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34788 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCMTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id 59so8645107qtb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4MuynrCluq7yH2fUxvvPhT+426Ye/ItTPShbrN6qL0=;
        b=W3dXwa5ADh6VzY0PENH/6FlCz/HOXIuFEHLN91rUNQ3Z50RoOM3r88OUj43tOuRp3k
         dWWhtWapd4w9kG/mP7CfZjFPDLJ/Z2VVii8r3NN6FNMHf7zQwFf39Ak3QNvtVrKSHyX3
         6ZLNzWkN51gDh4CopFasWbk+OsP5wrmajboNfoRrpJ+sv2PdLu7PAjK1TSLTzYsC4khN
         Wd4r/+wQH6wY8MYbJkZAC1/q74p7vKLF1+G1GlEn1+4fqSpCx6QdJPK/sITU9Rwp2vaj
         +toXLL5R/8D+izJpe72/0J6ZIYXTN59U30D8z3Z1xRXm+hCLtO/2a/xcLK6wzOJHj6uN
         5Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4MuynrCluq7yH2fUxvvPhT+426Ye/ItTPShbrN6qL0=;
        b=MD1uqin6QXakWxTP55OhaKDPhHduHxiOHVCz3KSeU+HL56hFxqri67xgNTsctS+Daa
         yumD83SPeadgihUSboWbQfKBy8pZzJILN5Lg0nT9pWvxdkz+Es7nK7Ov9/Qnv+xix0n7
         zJ1s2SLO+pWO24X8Uy7Po6Cfhz/GMyJ1n7biDE+MBqWBe25Y3cdzMl4b1BOSbbTChkGK
         lTOZJyoWnUnCyKS9Vk/3ua+4I9m/mqawMs1wbAqWLOMhl7dsUvT8yD9cpdiFQsfXivnn
         j8VpFzXc0WRaeA/hKKs28fLaKitdf04YMRwPC3UKM4m9Zxth85asQPu+WdBJdnK8+1F+
         QpfQ==
X-Gm-Message-State: ANhLgQ1s58yQJzPFpMXKWlKqowI8z1ul9WlaZxnmMP0uflY5NiDcXeb3
        hObOLjwi2e4QR85m/JDbQ1S7aR8=
X-Google-Smtp-Source: ADFU+vvNLguUcLNsHSAfIbypaQIIG7oNEQxOO5y92DQGVbq5pRE7YC8PoloexXz+qOZ+K84DZ63P0g==
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr14308607qtp.250.1584129154199;
        Fri, 13 Mar 2020 12:52:34 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:33 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 18/18] x86: Remove unneeded includes
Date:   Fri, 13 Mar 2020 15:51:44 -0400
Message-Id: <20200313195144.164260-19-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up includes of and in <asm/syscalls.h>

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscalls.h | 5 -----
 arch/x86/kernel/ldt.c           | 1 -
 arch/x86/kernel/process.c       | 1 -
 arch/x86/kernel/process_32.c    | 1 -
 arch/x86/kernel/process_64.c    | 1 -
 arch/x86/kernel/signal.c        | 2 --
 arch/x86/kernel/sys_x86_64.c    | 1 -
 7 files changed, 12 deletions(-)

diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index 06cbdca634d6..6714a358235d 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -8,11 +8,6 @@
 #ifndef _ASM_X86_SYSCALLS_H
 #define _ASM_X86_SYSCALLS_H
 
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <linux/signal.h>
-#include <linux/types.h>
-
 /* Common in X86_32 and X86_64 */
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index c57e1ca70fd1..84c3ba32f211 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -27,7 +27,6 @@
 #include <asm/tlb.h>
 #include <asm/desc.h>
 #include <asm/mmu_context.h>
-#include <asm/syscalls.h>
 #include <asm/pgtable_areas.h>
 
 /* This is a multiple of PAGE_SIZE. */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 070a2af7ce3d..9da70b279dad 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -28,7 +28,6 @@
 #include <linux/hw_breakpoint.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
-#include <asm/syscalls.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
 #include <asm/fpu/internal.h>
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5052ced43373..954b013cc585 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -49,7 +49,6 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
-#include <asm/syscalls.h>
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ffd497804dbc..5ef9d8f25b0e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -48,7 +48,6 @@
 #include <asm/desc.h>
 #include <asm/proto.h>
 #include <asm/ia32.h>
-#include <asm/syscalls.h>
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 860904990b26..0364f8c3bee3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -42,8 +42,6 @@
 #endif /* CONFIG_X86_64 */
 
 #include <asm/syscall.h>
-#include <asm/syscalls.h>
-
 #include <asm/sigframe.h>
 #include <asm/signal.h>
 
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index ca3c11a17b5a..504fa5425bce 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -21,7 +21,6 @@
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
-#include <asm/syscalls.h>
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
-- 
2.24.1

