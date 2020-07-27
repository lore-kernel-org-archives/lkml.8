Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6053F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RALWgwdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgG0SLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:11:36 -0400
Received: from crapouillou.net ([89.234.176.41]:45736 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgG0SLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595873494; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=a1uZ6dI3revExsbwQsIqi1pThqXLFYmFNrGJ1505KSI=;
        b=RALWgwdktf5953lze/tfqx7Md7gy21mrPtuv+5Fz9kcWprfLXgDfm92xrxZ4LEnnNVl5uL
        P5IZoRn+JnOZm8cIFChAof2fwdOcZCdaaCLYCMYdeAGt30oIVPOF8SheY7xWy4rOGsuF7z
        Ta74WF7tE432hLg//uKAJtMBpk7egCA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: qi_lb60: Fix routing to audio amplifier
Date:   Mon, 27 Jul 2020 20:11:28 +0200
Message-Id: <20200727181128.25756-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROUT (right channel output of audio codec) was connected to INL
(left channel of audio amplifier) instead of INR (right channel of audio
amplifier).

Fixes: 8ddebad15e9b ("MIPS: qi_lb60: Migrate to devicetree")
Cc: stable@vger.kernel.org # v5.3
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 7a371d9c5a33..eda37fb516f0 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -69,7 +69,7 @@ sound {
 			"Speaker", "OUTL",
 			"Speaker", "OUTR",
 			"INL", "LOUT",
-			"INL", "ROUT";
+			"INR", "ROUT";
 
 		simple-audio-card,aux-devs = <&amp>;
 
-- 
2.27.0

