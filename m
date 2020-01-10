Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D90C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DBA20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgAJMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:33:00 -0500
Received: from foss.arm.com ([217.140.110.172]:44016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgAJMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B08B1063;
        Fri, 10 Jan 2020 04:32:59 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBF583F534;
        Fri, 10 Jan 2020 04:32:58 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH] arm: Disable kmemleak on XIP kernels
Date:   Fri, 10 Jan 2020 12:32:40 +0000
Message-Id: <20200110123240.51722-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak relies on specific symbols to register the read only data
during init (e.g. __start_ro_after_init).
Trying to build an XIP kernel on arm results in the linking error
reported below because when this option is selected read only data
after init are not allowed since .data is read only (.rodata).

  arm-linux-gnueabihf-ld: mm/kmemleak.o: in function `kmemleak_init':
  kmemleak.c:(.init.text+0x148): undefined reference to `__end_ro_after_init'
  arm-linux-gnueabihf-ld: kmemleak.c:(.init.text+0x14c):
     undefined reference to `__end_ro_after_init'
  arm-linux-gnueabihf-ld: kmemleak.c:(.init.text+0x150):
     undefined reference to `__start_ro_after_init'
  arm-linux-gnueabihf-ld: kmemleak.c:(.init.text+0x156):
     undefined reference to `__start_ro_after_init'
  arm-linux-gnueabihf-ld: kmemleak.c:(.init.text+0x162):
     undefined reference to `__start_ro_after_init'
  arm-linux-gnueabihf-ld: kmemleak.c:(.init.text+0x16a):
     undefined reference to `__start_ro_after_init'
  linux/Makefile:1078: recipe for target 'vmlinux' failed

Fix the issue enabling kmemleak only on non XIP kernels.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bc99582bdc85..99a3e14e62bd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -73,7 +73,7 @@ config ARM
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
-	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
-- 
2.24.1

