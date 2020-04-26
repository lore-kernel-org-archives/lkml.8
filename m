Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F22C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C9C2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="D62SW/M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgDZRlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:41:18 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:60006 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgDZRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:41:16 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 275842049A;
        Sun, 26 Apr 2020 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587922876; bh=prpMrkoSAy8iSRgJ5vUbfLQcjZXENeRE5+WtUrRFzyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D62SW/M8V1GXmb53wqGrNIJ77onCk7Re5jZhutzWe50lpq/Kkn3pBWDevZk2/b7Xd
         maV8CZe5Bnu9vZR2P8rMEbxmlKsKFcEcbdSsiJZPvkCn1BHYeIp2TcTJN4SOTivjjF
         cwA6hIak424aXYfssPHrLAENTL2Nlt6p1vI036qUv1aPwL+NYrp4z0seaKSjfSW7KP
         q2he1ZBkYP0Oz8Cf7R3N5gEJaSfhMN1vW+hSYzlTnH9VEMpKyaibIjKfvMIhV9Ee1i
         WvSLRw/hkOBYit6Sa8g0HwuaCGKh6tL7N1Rj40/VJS32UEOQxjh33JxFDSjs4qCYdg
         70VpODaX6m2Jw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     akpm@linux-foundation.org
Cc:     sunguoyun@loongson.cn, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        Daniel Silsby <dansilsby@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mips/mm: Enable SOFT_DIRTY for all 64bit systems
Date:   Mon, 27 Apr 2020 01:40:56 +0800
Message-Id: <20200426174058.1181837-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200426174058.1181837-1-jiaxun.yang@flygoat.com>
References: <20200426174058.1181837-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64bit systems always have enough page table bits.
So we can safely enable it for all of them instead of for Loongson
only.

If oneday 32bit systems get 64bit PTEs than we can drop this
limition.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 85011023839b..743ed9b9099e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -45,6 +45,7 @@ config MIPS
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SOFT_DIRTY if 64BIT
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
 	select HAVE_ASM_MODVERSIONS
@@ -495,7 +496,6 @@ config MACH_LOONGSON64
 	select COMMON_CLK
 	select USE_OF
 	select BUILTIN_DTB
-	select HAVE_ARCH_SOFT_DIRTY
 	help
 	  This enables the support of Loongson-2/3 family of machines.
 
-- 
2.26.0.rc2

