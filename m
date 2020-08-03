Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D7920678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TS/M5bM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHCRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:02:55 -0400
Received: from crapouillou.net ([89.234.176.41]:38084 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHCRCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596474110; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xh8SmG43SMf8REJ2QSZSVqOvJz0EXXwQEvQb3hTL8cE=;
        b=TS/M5bM/favgQVePmcP/3e++czwnDTsD1fTboi1pPw2X+8htJu6FMDf+yvGhRz1iwIOVw4
        TXrvKlbBIB3vwyFZ2NnE+fA9fh7dE7Tfw73DKHykqDibYMp3NctbNcQEeEv9ksVZA6YV7Y
        a+IweU6kP3zYIDTrSnlBgXTISoeoMps=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 09/13] MIPS: generic: Increase NR_IRQS to 256
Date:   Mon,  3 Aug 2020 19:01:20 +0200
Message-Id: <20200803170124.231110-10-paul@crapouillou.net>
In-Reply-To: <20200803170124.231110-1-paul@crapouillou.net>
References: <20200803170124.231110-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

128 IRQs is not enough to support Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
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
2.27.0

