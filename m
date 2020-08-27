Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9751AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD6022B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgH0Ovs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgH0N0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:26:23 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512F6C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:25:52 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id LdRp2300S4C55Sk01dRp4H; Thu, 27 Aug 2020 15:25:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kBHuX-0000iY-9L; Thu, 27 Aug 2020 15:25:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kBHuX-0006Wh-7e; Thu, 27 Aug 2020 15:25:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] c6x: Remove unused <asm/procinfo.h>
Date:   Thu, 27 Aug 2020 15:25:48 +0200
Message-Id: <20200827132548.25045-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C6X never used <asm/procinfo.h>, which was presumably opied from ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/c6x/include/asm/procinfo.h | 24 ------------------------
 arch/c6x/kernel/asm-offsets.c   |  1 -
 2 files changed, 25 deletions(-)
 delete mode 100644 arch/c6x/include/asm/procinfo.h

diff --git a/arch/c6x/include/asm/procinfo.h b/arch/c6x/include/asm/procinfo.h
deleted file mode 100644
index aaa3cb902c43fdb9..0000000000000000
--- a/arch/c6x/include/asm/procinfo.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Copyright (C) 2010 Texas Instruments Incorporated
- *  Author: Mark Salter (msalter@redhat.com)
- */
-#ifndef _ASM_C6X_PROCINFO_H
-#define _ASM_C6X_PROCINFO_H
-
-#ifdef __KERNEL__
-
-struct proc_info_list {
-	unsigned int		cpu_val;
-	unsigned int		cpu_mask;
-	const char		*arch_name;
-	const char		*elf_name;
-	unsigned int		elf_hwcap;
-};
-
-#else	/* __KERNEL__ */
-#include <asm/elf.h>
-#warning "Please include asm/elf.h instead"
-#endif	/* __KERNEL__ */
-
-#endif	/* _ASM_C6X_PROCINFO_H */
diff --git a/arch/c6x/kernel/asm-offsets.c b/arch/c6x/kernel/asm-offsets.c
index 0f8fde494875edd3..42eb3b185f617051 100644
--- a/arch/c6x/kernel/asm-offsets.c
+++ b/arch/c6x/kernel/asm-offsets.c
@@ -7,7 +7,6 @@
 
 #include <linux/sched.h>
 #include <linux/thread_info.h>
-#include <asm/procinfo.h>
 #include <linux/kbuild.h>
 #include <linux/unistd.h>
 
-- 
2.17.1

