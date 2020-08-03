Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFFBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC0320678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mrtR61It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgHCRCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:02:20 -0400
Received: from crapouillou.net ([89.234.176.41]:37472 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHCRCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596474107; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBwkyuw6Fl2eLdGww+d1yV8XDoZJxZ/MJv7ZAPfQ2WA=;
        b=mrtR61Ity4ShIJyP0wEbIWP4ttGdxdSppr01yxHFFB1fXxCCPzL192K9LmZiKK6UOqLk7E
        5qrCV3FX7X4P/00wr1jui9nJyQG+rqi6970ayRDKz6LZN8qcvdupHBKVjEnE/Jcxprukgo
        59d9RFw3F/C6YQ8sbJVcI3bEcI5Oguo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 04/13] MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
Date:   Mon,  3 Aug 2020 19:01:15 +0200
Message-Id: <20200803170124.231110-5-paul@crapouillou.net>
In-Reply-To: <20200803170124.231110-1-paul@crapouillou.net>
References: <20200803170124.231110-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS_GENERIC symbol now won't select any other configuration option.
The MIPS_GENERIC_KERNEL will select all the options that the previous
MIPS_GENERIC option did select, and will select MIPS_GENERIC as well.

The whole point of this, is that it now becomes possible to compile a
kernel for a SoC supported by the arch/mips/generic/ code, without
making that kernel generic itself.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig         | 8 ++++++--
 arch/mips/generic/Kconfig | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f6bb446d30f0..17878c37fc84 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -94,14 +94,18 @@ config MIPS
 config MIPS_FIXUP_BIGPHYS_ADDR
 	bool
 
+config MIPS_GENERIC
+	bool
+
 menu "Machine selection"
 
 choice
 	prompt "System type"
-	default MIPS_GENERIC
+	default MIPS_GENERIC_KERNEL
 
-config MIPS_GENERIC
+config MIPS_GENERIC_KERNEL
 	bool "Generic board-agnostic MIPS kernel"
+	select MIPS_GENERIC
 	select BOOT_RAW
 	select BUILTIN_DTB
 	select CEVT_R4K
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index fd6019802657..5216c850b7e2 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-if MIPS_GENERIC
+if MIPS_GENERIC_KERNEL
 
 config LEGACY_BOARDS
 	bool
-- 
2.27.0

