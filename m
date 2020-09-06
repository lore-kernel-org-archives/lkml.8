Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B18C10DAA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BABE2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oZzb2o4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIFTbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:31:23 -0400
Received: from crapouillou.net ([89.234.176.41]:35990 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgIFTbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599420595; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuRofGilklF4w6l+ySrilmqjGaUP3XWiEEyoR8/CGRA=;
        b=oZzb2o4fLjbbWkJlCaEPIZX24o2wE9Y5/N5gJTlRt7U6NSEPFSuf3q4cMKC8EMfxaR8kXg
        kyl1qDeBfE2GJaTadAq33hcpskzIli+VeWvm6KaNrTACY0vwIvM057XSE0A0Y6O2dNqsTi
        zcXenFQ1ZBie+JRV8QOi7pUT3q53QGE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Maciej W . Rozycki" <macro@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 10/15] MIPS: generic: Increase NR_IRQS to 256
Date:   Sun,  6 Sep 2020 21:29:30 +0200
Message-Id: <20200906192935.107086-11-paul@crapouillou.net>
In-Reply-To: <20200906192935.107086-1-paul@crapouillou.net>
References: <20200906192935.107086-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

128 IRQs is not enough to support Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2-v3: No change

 arch/mips/include/asm/mach-generic/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-generic/irq.h b/arch/mips/include/asm/mach-generic/irq.h
index 72ac2c202c55..079889ced4f3 100644
--- a/arch/mips/include/asm/mach-generic/irq.h
+++ b/arch/mips/include/asm/mach-generic/irq.h
@@ -9,7 +9,7 @@
 #define __ASM_MACH_GENERIC_IRQ_H
 
 #ifndef NR_IRQS
-#define NR_IRQS 128
+#define NR_IRQS 256
 #endif
 
 #ifdef CONFIG_I8259
-- 
2.28.0

