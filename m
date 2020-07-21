Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD46C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5180A2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgGULXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:23:23 -0400
Received: from 8bytes.org ([81.169.241.247]:58390 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgGULXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:23:22 -0400
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 5B0B51AD;
        Tue, 21 Jul 2020 13:23:20 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] csky: Fix build with upstream gcc
Date:   Tue, 21 Jul 2020 13:23:14 +0200
Message-Id: <20200721112314.1162-1-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Building a kernel for the CSKY architecture with CONFIG_FRAME_POINTER
set requires a gcc supporting the non-upstream '-mbacktrace' option.
Check for the '-mbacktrace' option before enabling CONFIG_FRAMEPOINTER
and fix building CSKY with an upstream gcc compiler.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/csky/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index bd31ab12f77d..1622e1c56026 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,7 +8,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
-	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
+	select ARCH_WANT_FRAME_POINTERS if (!CPU_CK610 && STACKTRACE_SUPPORT)
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CSKY_MPINTC if CPU_CK860
@@ -125,7 +125,7 @@ config MMU
 	def_bool y
 
 config STACKTRACE_SUPPORT
-	def_bool y
+	def_bool $(success,echo 'int foo(void) { return 0; }' | $(CC) -mbacktrace -x c - -c -o /dev/null)
 
 config TIME_LOW_RES
 	def_bool y
-- 
2.27.0

