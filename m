Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B248C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2671720776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="lwCw5CG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgE3MMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:12:45 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:34818 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgE3MMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:12:38 -0400
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id B513F2049E;
        Sat, 30 May 2020 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590840758; bh=BZDmVeLAL/9NfTcfEUMMIQVENfqhtSTJnHjQ/WoS1A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwCw5CG2l+fMtoykWL3nwusVZZrxf1+JHiw/B4FSv+aWUrLsFCC57Clm2LCNcfmvm
         K4hVWh4JWLtHxRzbO63hss3CooF/eTgq2oQx5Re79iSB+2/DW071bt9VMhlzudCgt+
         t97VeNcRiH95V8xlQ3Z10Lm5uF+VVVFLbh7QGD6Ab5aQJvJdS7c7i725wyTheq1ucX
         I1LcT+QBdH+du3VB+xjpl2f85PO9JGF7B/JSq9ZH6ZTWbWOkGS9lUey9lyJ+9tDwuy
         I4884E9XkzYdQfzoHe25f/bvVSRCdpP2ywvGX8GsHFZifCD/aUUQto++CeDvRyQJ2z
         BKN3XP0Ag8Alw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 1/2] irqchip: loongson-pci-msi: Fix a typo in Kconfig
Date:   Sat, 30 May 2020 20:11:12 +0800
Message-Id: <20200530121113.1797678-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200530121113.1797678-1-jiaxun.yang@flygoat.com>
References: <20200530121113.1797678-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCH MSI driver's tittle was wrong.
My stupid mistake.

Fixes: cca8fbff2585 ("irqchip: Add Loongson PCH MSI controller")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0b6b826dd843..a444f15a1f57 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -550,7 +550,7 @@ config LOONGSON_PCH_PIC
 	  Support for the Loongson PCH PIC Controller.
 
 config LOONGSON_PCH_MSI
-	bool "Loongson PCH PIC Controller"
+	bool "Loongson PCH MSI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
 	depends on PCI
 	default MACH_LOONGSON64
-- 
2.27.0.rc0

