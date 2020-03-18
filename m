Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD29C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EC120752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="QphiRFAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCRG07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:26:59 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:8011 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgCRG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1584512744;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=wfYixzilm1gZlhfT1UD6Dh4dE2sMP0s306i7VBtGiGI=;
        b=QphiRFAcBShx/WoOwt8ndr0dOu7NdZnQONCMQYtj0i6fSqg7ybzWvD7mH2DTmBIq
        1duMCRLbnyZOyoIunAZ6FVw34e/CkrNcMGB4G32w4/AvgK3BiwvtIqPJqy40NMksx8J
        XZaWW9swG9sQpjlfS3Lj+c7GOsSqxVKqJtjG8X6w=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1584512742231792.6229827957009; Wed, 18 Mar 2020 14:25:42 +0800 (CST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-ID: <20200318062102.8145-12-jiaxun.yang@flygoat.com>
Subject: [PATCH v5 11/11] MIPS: Loongson64: Move MIPS_CPU_IRQ_BASE
Date:   Wed, 18 Mar 2020 14:20:39 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200318062102.8145-1-jiaxun.yang@flygoat.com>
References: <20200318062102.8145-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent CPU IRQ collide with PCH IRQ, we move down
CPU IRQ BASE to 16.

Co-developed-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/includ=
e/asm/mach-loongson64/irq.h
index 12208119aac0..1ce2e0bbe305 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -5,7 +5,7 @@
 #include <boot_param.h>
=20
 /* cpu core interrupt numbers */
-#define MIPS_CPU_IRQ_BASE 56
+#define MIPS_CPU_IRQ_BASE 16
=20
 #include_next <irq.h>
 #endif /* __ASM_MACH_LOONGSON64_IRQ_H_ */
--=20
2.26.0.rc2


