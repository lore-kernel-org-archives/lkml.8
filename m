Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C332FC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A508F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCZQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:37:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgCZQhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD63FACCE;
        Thu, 26 Mar 2020 16:37:48 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell Currey <ruscur@russell.cc>,
        Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64: Fix section mismatch warnings.
Date:   Thu, 26 Mar 2020 17:37:42 +0100
Message-Id: <20200326163742.28990-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

WARNING: vmlinux.o(.text+0x2d24): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init()
The function __boot_from_prom() references
the function __init prom_init().
This is often because __boot_from_prom lacks a __init
annotation or the annotation of prom_init is wrong.

WARNING: vmlinux.o(.text+0x2fd0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel()
The function start_here_common() references
the function __init start_kernel().
This is often because start_here_common lacks a __init
annotation or the annotation of start_kernel is wrong.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/head_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index ad79fddb974d..4afb82f1b7c7 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -537,6 +537,7 @@ __start_initialization_multiplatform:
 	b	__after_prom_start
 #endif /* CONFIG_PPC_BOOK3E */
 
+__REF
 __boot_from_prom:
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* Save parameters */
@@ -574,6 +575,7 @@ __boot_from_prom:
 	/* We never return. We also hit that trap if trying to boot
 	 * from OF while CONFIG_PPC_OF_BOOT_TRAMPOLINE isn't selected */
 	trap
+	.previous
 
 __after_prom_start:
 #ifdef CONFIG_RELOCATABLE
@@ -980,6 +982,7 @@ start_here_multiplatform:
 	.previous
 	/* This is where all platforms converge execution */
 
+__REF
 start_here_common:
 	/* relocation is on at this point */
 	std	r1,PACAKSAVE(r13)
@@ -1001,6 +1004,7 @@ start_here_common:
 	/* Not reached */
 	trap
 	EMIT_BUG_ENTRY 0b, __FILE__, __LINE__, 0
+	.previous
 
 /*
  * We put a few things here that have to be page-aligned.
-- 
2.16.4

