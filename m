Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8801C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0302467D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695483;
	bh=YHz7O6G/jmkaVCvMuEpPsNeQD/iCyedN0ScyPG8tI5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DTi3bHnFhGjNcK8599eZABjR04pRXU+W0eeJe8Z3AKspLSeOh4yVAbt6Njndd+Nok
	 sHj1GV/oLm7/ePkZavELGrhHi4vpO6h2R8taZhCacQfF1FTGouYtb45exb8ngfd00l
	 mWXEKsAaWJuP2X/csN5NXzv3miOyIvW8+6XPRQv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgBNPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730686AbgBNPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01CC824682;
        Fri, 14 Feb 2020 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695470;
        bh=YHz7O6G/jmkaVCvMuEpPsNeQD/iCyedN0ScyPG8tI5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ml+pGZkWvBexceUZ2azyw9+5UOmMu6+rhY8Y/EkqY1sDwokk5HHQBK+OnBW2rm91F
         +cbkKknvKWYr4munvYRmO7B7tusDlTfSzy2/I3KUTs3fThcAZ3o6SUVNc2bpSMXkij
         3AZQl45fq9CU4VTeVYLW5cLpnBJwl0zi2Ki7ctnM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 105/542] ARM: 8952/1: Disable kmemleak on XIP kernels
Date:   Fri, 14 Feb 2020 10:41:37 -0500
Message-Id: <20200214154854.6746-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

[ Upstream commit bc420c6ceefbb86cbbc8c00061bd779c17fa6997 ]

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

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96dab76da3b39..2c3a9fd05f571 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -74,7 +74,7 @@ config ARM
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
-	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
-- 
2.20.1

