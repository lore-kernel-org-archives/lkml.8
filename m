Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9F2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC60820675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cyjOj5oX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbgDCBqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:46:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17748 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDCBqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585878372; x=1617414372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sXzY6X7y/HJOV8eyJ7EyKZ7Q9GvaNwIs3iD8jdW9I3A=;
  b=cyjOj5oX8uQxeq4+VxP/Fsw1GOMZ4cVSS/EabhPVL9jzcOuKb0Qtbi8z
   XUkmKQpvTETGXkuEllPQKGHUjCkxMXTuwrPVX5z/h4FgEYK24QUXMR4uF
   e2AQnhC+IFt7mPeJ3zmwAuu9v1KY3wJ10+0cVSgch+w6vxGRjBIuJhqRV
   djJrkocRJnZgoLTjErwacwVf8hQSadNNbQgZofHqLnInBu29bh+fDKvkm
   JNVLg2vRHdXKza7zMJZcvnZpE5tVbcctqnOR+rJ+adUyd1prPwoBmMRiA
   3+pzZCVmco/udH95aeWYSWLaewq4MVBND+4qXLWrr/REOK6ArskILWFvT
   g==;
IronPort-SDR: Z/huWYO4R/vhI7IfVzj5I0Nb5XiE+FTx40j1NKMG2BNOCiZKq9vnIGCC+lbSqB1jSra17xG3y0
 LmFrJq/3s+Vs2JlveRQcgGJyYe62BjMwP9E6n8eYlDWnmgwKPHbPNXSoUPJvYfFPt+gp4XAAZ6
 T87P3UBCiRlNqYHPVeZbOcxNxj81JFN4lJCiNjrrKUitK0+auCu64qrEiba7tyemmw8sbIktnK
 UkfNUen1aE6JXpi7wma0O0F5KhcikeJOtmlSqEBSyN/toKeb3jnPsMdb/XrkFs7/QHaztc5/Mw
 KiA=
X-IronPort-AV: E=Sophos;i="5.72,337,1580745600"; 
   d="scan'208";a="134782509"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 09:46:11 +0800
IronPort-SDR: KDKavQl3zDQbbQaDL1DEzBVyiPipWeM0Z0KLjungVVbXONLsGNkpfx2mct4IlSMwSKPeajf3Jr
 Qqv9m5XbfuHpQ+6evOprhkkIGSuDzSIGaBR/7XNZYakdM7uV+SYVQvxyYJJlFxGi5fZW4uD9Qq
 BVjIa7CALMPbkD66Kzxfd5wc7lEG1Yz6/A3fo8wZWTJmJuGLAUbJFhppCq40oz+CBG0uK3FCsR
 7pldTg6f8tQM9f3+Jg/NBEaC18huoydclI5FckyNkyZzYe7H4qAcn4bn+DpCA+mck/ZZE3n2HQ
 jkO55+Ck8IruJKiIDDmpd2tR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 18:37:01 -0700
IronPort-SDR: ZAP/86deKbIkcrM7fGbTYi3JBhvMWizQVQ+sVBUZ+C9VlVOhubJ5WIm8d89j3VAGd0ilAEJ70s
 g9qEgSzrNx/ZvR/3xNdL9yT4Z2jkaZxnyMGv9VkGzF2J3yS7Sii8aR6/ckOAHG10e32sqzV4zb
 +t3u6OJe5ZBIHaqO6wLNuy/GaLFQ+DhtzNzFRZFfHZyQPaeo5bDi2dWoGjyiz38k1NxbMcFQZR
 Bp1Yueq5YC1cuW83W8C4eDtvKvpUGtTcChQJZjIUGooois9pihtCB8WjR8mlczKVkSHvx49mdh
 O/8=
WDCIronportException: Internal
Received: from usa002249.ad.shared (HELO yoda.hgst.com) ([10.86.55.19])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2020 18:46:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/sifive-plic: Fix maximum priority threshold value
Date:   Thu,  2 Apr 2020 18:46:09 -0700
Message-Id: <20200403014609.71831-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the PLIC specification, maximum priority threshold value is 0x7
not 0xF. Even though it doesn't cause any error in qemu/hifive unleashed,
there may be some implementation which checks the upper bound resulting in
an illegal access.

Fixes: ccbe80bad571 (irqchip/sifive-plic: Enable/Disable external
		     interrupts upon cpu online/offline)
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c34fb3ae0ff8..d0a71febdadc 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -56,7 +56,7 @@
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
-#define	PLIC_DISABLE_THRESHOLD		0xf
+#define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
 
 struct plic_priv {
-- 
2.25.1

