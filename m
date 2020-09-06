Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054E7C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AE3208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ei7nV9N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIFTaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:30:39 -0400
Received: from crapouillou.net ([89.234.176.41]:35838 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599420589; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZVAQY7y1f8+ZcJvATWT5KFcw8sq2N5SZcEHU17/r9c=;
        b=Ei7nV9N1ye8gHj1/puvoobQ6t2oaNVxF16d+gt/epX8x7hCK0kUD/yRUQ4lkD8g38SRvlu
        gYpIP+y14tDAF5AnOo61RvO3hZcujw6UXuDYV8N2fIq5GSppQLeuep8NxHjgEWLTlNerp8
        MYqhoxU9cQ9rDBnie8dyDPtg2sXqOH8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Maciej W . Rozycki" <macro@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 05/15] MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
Date:   Sun,  6 Sep 2020 21:29:25 +0200
Message-Id: <20200906192935.107086-6-paul@crapouillou.net>
In-Reply-To: <20200906192935.107086-1-paul@crapouillou.net>
References: <20200906192935.107086-1-paul@crapouillou.net>
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

Notes:
    v2-v3: No change

 arch/mips/Kconfig         | 8 ++++++--
 arch/mips/generic/Kconfig | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5f4c2d43c073..0c9270ee9081 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -93,14 +93,18 @@ config MIPS
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
2.28.0

