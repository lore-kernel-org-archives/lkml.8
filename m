Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21092078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="esxmnJ85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391354AbgEYRmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:42:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48922 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389348AbgEYRmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590428535; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPflBaHsPOYHwSyPSQMst63oUT7yG5ljn2n34MW5nkk=;
        b=esxmnJ85ycbnuPSjCLt4plZ0YSPQEtomE9/hZZVKsmU0OLqT5BPAx73PotDATivxLKIfbp
        X6SVeXIXyruQzR91ak4WsZHyri3vkYzZDaiYnz413ifx/vigCkaEX9LfQB3K1w24ThhXtw
        O+KmAJqbXnX1xzNIWHV7FxBT3/JzZF0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] MIPS: ingenic: Default to a generic board
Date:   Mon, 25 May 2020 19:41:55 +0200
Message-Id: <20200525174155.457491-3-paul@crapouillou.net>
In-Reply-To: <20200525174155.457491-1-paul@crapouillou.net>
References: <20200525174155.457491-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a generic board option makes it possible to create a kernel that
will run on various Ingenic SoCs, as long as the right devicetree is
provided.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/jz4740/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 412d2faa3cdf..9c2e8c15bb97 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -2,7 +2,14 @@
 choice
 	prompt "Machine type"
 	depends on MACH_INGENIC
-	default JZ4740_QI_LB60
+	default INGENIC_GENERIC_BOARD
+
+config INGENIC_GENERIC_BOARD
+	bool "Generic board"
+	select MACH_JZ4740
+	select MACH_JZ4770
+	select MACH_JZ4780
+	select MACH_X1000
 
 config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
-- 
2.26.2

