Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F95C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1AD22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ASX+t96h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGTHom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:44:42 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:41356 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:44:42 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 6B7C71FEC7;
        Mon, 20 Jul 2020 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1595231081; bh=cp+frRMJbDSmQF0aHJsiydb5cvCrlCDWTwGZKrqtUy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASX+t96hntqJaytBufC3nJUDijiewiMVBuDyDErO8UE5xAmylMffgM2To0T5GKkTo
         0uE9D73nBInSL4OYPqNdZ/dJszcqZwWANaEY3JKAclGO08/MSEwhuwflbKCjHp/z3f
         tkdj2eDUGOl/DcvBe8Qs1aaq02E9CJIBtNIHK1fZrgo1/RUc7twgA6+DhvvnyctMaq
         8td2uxoQmYYk1q7n4aj+d1s7Znu4JxID8pTFHyBpQrEWTYSG49I5pDHcmJLFx7LEgW
         EhYEpxTYZdRUFxLNEfOVARYnr0OT1P3k76NFkRFJI8sAFbN57arWt9XqB/9Tbcnuyh
         6G5eUZqRy9udg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] MIPS: Loongson64: Enlarge IO_SPACE_LIMIT
Date:   Mon, 20 Jul 2020 15:42:36 +0800
Message-Id: <20200720074249.596364-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200720074249.596364-1-jiaxun.yang@flygoat.com>
References: <20200720074249.596364-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be very big on LS7A PCH systems.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/io.h                     | 3 ++-
 arch/mips/include/asm/mach-loongson64/spaces.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 346fffd9e972..0072489325fa 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -50,8 +50,9 @@
 # define __relaxed_ioswabq ioswabq
 
 /* ioswab[bwlq], __mem_ioswab[bwlq] are defined in mangle-port.h */
-
+#ifndef IO_SPACE_LIMIT
 #define IO_SPACE_LIMIT 0xffff
+#endif
 
 /*
  * On MIPS I/O ports are memory mapped, so we access them using normal
diff --git a/arch/mips/include/asm/mach-loongson64/spaces.h b/arch/mips/include/asm/mach-loongson64/spaces.h
index 3de0ac9d8829..b99b43854929 100644
--- a/arch/mips/include/asm/mach-loongson64/spaces.h
+++ b/arch/mips/include/asm/mach-loongson64/spaces.h
@@ -11,8 +11,7 @@
 #define PCI_IOSIZE	SZ_16M
 #define MAP_BASE	(PCI_IOBASE + PCI_IOSIZE)
 
-/* Reserved at the start of PCI_IOBASE for legacy drivers */
-#define MMIO_LOWER_RESERVED	0x10000
+#define IO_SPACE_LIMIT 0x00ffffff
 
 #include <asm/mach-generic/spaces.h>
 #endif
-- 
2.28.0.rc1

