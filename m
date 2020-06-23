Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084C6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D174C207F9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UmNaVg6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbgFWSZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:25:10 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52044 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1592936686; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K44PD9Lu84ScFUkt/pJ1sEZS/nHBSokcXHkHizWvV6g=;
        b=UmNaVg6gM3rwrW7fVF+hksjY5nqi26dwIJ9i/5+MsVcb9zXnOgGuwX+nweDqS6kCDweVJv
        U4CIZjGq70cKulYMyriTjKrXt7WDqAjNWPGTSB4FUv293uD6F7UjMQZEstdXuJghucMLGh
        I1pd1iIx6EK4E9rwwodgYTmxtgH4/VQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/7] MIPS: ingenic: Use enum instead of macros for Ingenic SoCs
Date:   Tue, 23 Jun 2020 20:24:29 +0200
Message-Id: <20200623182432.187843-4-paul@crapouillou.net>
In-Reply-To: <20200623182432.187843-1-paul@crapouillou.net>
References: <20200623182432.187843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an enum instead of macros to represent the various versions of the
Ingenic SoCs, and add some of the SoC versions that were previously
missing.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/include/asm/bootinfo.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index c3bd9b2d66e4..26f267d5649f 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -65,12 +65,22 @@ enum loongson2ef_machine_type {
 /*
  * Valid machtype for group INGENIC
  */
-#define  MACH_INGENIC_JZ4730	0	/* JZ4730 SOC		*/
-#define  MACH_INGENIC_JZ4740	1	/* JZ4740 SOC		*/
-#define  MACH_INGENIC_JZ4770	2	/* JZ4770 SOC		*/
-#define  MACH_INGENIC_JZ4780	3	/* JZ4780 SOC		*/
-#define  MACH_INGENIC_X1000		4	/* X1000 SOC		*/
-#define  MACH_INGENIC_X1830		5	/* X1830 SOC		*/
+enum ingenic_machine_type {
+	MACH_INGENIC_UNKNOWN,
+	MACH_INGENIC_JZ4720,
+	MACH_INGENIC_JZ4725,
+	MACH_INGENIC_JZ4725B,
+	MACH_INGENIC_JZ4730,
+	MACH_INGENIC_JZ4740,
+	MACH_INGENIC_JZ4750,
+	MACH_INGENIC_JZ4755,
+	MACH_INGENIC_JZ4760,
+	MACH_INGENIC_JZ4770,
+	MACH_INGENIC_JZ4775,
+	MACH_INGENIC_JZ4780,
+	MACH_INGENIC_X1000,
+	MACH_INGENIC_X1830,
+};
 
 extern char *system_type;
 const char *get_system_type(void);
-- 
2.27.0

