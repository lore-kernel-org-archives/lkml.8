Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4727BC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1971B206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="RkACzJyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgDZMno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:43:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgDZMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:43:44 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4996z14MFnz9sRf; Sun, 26 Apr 2020 22:43:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1587905021;
        bh=WQNSdgyUxYa+iM/mHe8uHI9BW4cVp5FLI37CyyizlKg=;
        h=From:To:Cc:Subject:Date:From;
        b=RkACzJyd8GsvZl/IdEMOOnwSGNS3DngiEXMw9STVgGZygEfUeWuxtdPqb+cNbddi/
         aEKbDjbc9ghy+lyoYEpDLMM+0zxewoIsYo86CpibzwiHyxSFqfMnKk8xAEuFjmwmo9
         OquEi07HmreYjA6sMDt5q1EOUgPtTHR4lpUTUezAdwrmuvaz2spswhrslE/laEtIXf
         CCZj151vc1A1qMcx/naFfc4eEbV1yGSDdnotBMay2NxTKB7RBNF/t8weEHHRjZlXN6
         yHhX0X9/2UZoYrjlw2kWTMDtng+Yw/0ZuX6Ipwp6JDHpwxg0/+wA2eqfSYCQvB5csI
         iKifE4fmb6EWQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, claudiu.beznea@microchip.com
Subject: [PATCH] clocksource/drivers/timer-microchip-pit64b: Select CONFIG_TIMER_OF
Date:   Sun, 26 Apr 2020 22:43:56 +1000
Message-Id: <20200426124356.3929682-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is an OF driver, it depends on OF, and uses
TIMER_OF_DECLARE, so it should select CONFIG_TIMER_OF.

Without CONFIG_TIMER_OF enabled this can lead to warnings such as:

  powerpc-linux-ld: warning: orphan section `__timer_of_table' from
  `drivers/clocksource/timer-microchip-pit64b.o' being placed in
  section `__timer_of_table'.

Because TIMER_OF_TABLES in vmlinux.lds.h doesn't emit anything into
the linker script when CONFIG_TIMER_OF is not enabled.

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Cc: stable@vger.kernel.org # v5.6+
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f2142e6bbea3..f225c27b70f7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -709,6 +709,7 @@ config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
 	select CLKSRC_MMIO
+	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
 	  based system. It supports the oneshot, the periodic
-- 
2.25.1

