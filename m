Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3922BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189FC20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="YoGjYxDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHCRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:03:25 -0400
Received: from crapouillou.net ([89.234.176.41]:38222 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHCRDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596474113; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1g+QKtXV9DCOpif0q4q8sqFyZv5rk25JtqNe+NBVeLY=;
        b=YoGjYxDom37rkIr/KSMAaIKSIMH00xGFjUHEM1xyLyVtNdKYG4i6n0xnNPfVSNsQUor/JI
        xo0qxYTAQYZXWhoaG3TRBtBt7dz0f76Gl2SzuhRENW9nVq3TV0lRTRhZt2xvj93GWbgCt2
        9jhcNvyFLX0Qk6hy2JxGe5DRPD9AXPU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 13/13] MAINTAINERS: Update paths to Ingenic platform code
Date:   Mon,  3 Aug 2020 19:01:24 +0200
Message-Id: <20200803170124.231110-14-paul@crapouillou.net>
In-Reply-To: <20200803170124.231110-1-paul@crapouillou.net>
References: <20200803170124.231110-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Ingenic chips has been moved to the generic MIPS platform.
Update the paths accordingly.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bddc79ae76e6..1d89029cb89a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8508,8 +8508,8 @@ INGENIC JZ47xx SoCs
 M:	Paul Cercueil <paul@crapouillou.net>
 S:	Maintained
 F:	arch/mips/boot/dts/ingenic/
-F:	arch/mips/include/asm/mach-jz4740/
-F:	arch/mips/jz4740/
+F:	arch/mips/generic/board-ingenic.c
+F:	arch/mips/ingenic/Kconfig
 F:	drivers/clk/ingenic/
 F:	drivers/dma/dma-jz4780.c
 F:	drivers/gpu/drm/ingenic/
-- 
2.27.0

