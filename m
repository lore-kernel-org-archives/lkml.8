Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C56CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD3A206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aBVyQTYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgELR1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:27:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13887 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589304423; x=1620840423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pkopmhjPeLL3KurZFQqOAJKPug0srGyFJVNPAWCZUnQ=;
  b=aBVyQTYzzQeCa3ulPp7UArPo5tYqUjbfE/567e2A+soIvuv2arFPQ4Y2
   pnsgy5ibHjthu6v5Ap/oaVxi46RrCuY7NOU7NpfH/olTx7O0qjWyUJPwh
   coVqGuul5Kb3I0tOHxPHZYyr6vtT3KapMTpI7qHyqZFjpRgWvAm3LQXOq
   adEePkIxFZS7l14zjTpbXkOaeiut66Lb0TC5pbHfGd0Zt2ah1a1cNZtQ2
   t4OKWHPziqNOthl7iuWz8ScxCAsmHpqDYlKZ09qUnJj7Ugp/K8+1Mq1fW
   uC9ETRjjUQbc4zAVqCpr/AX9RICb4VGNAK8hQCgAuBPnqvtXyl/5/0ucs
   g==;
IronPort-SDR: 1r4QnSuc1yxQ0DdW5JTtqDdRKNDdK5/dYxCq6i1a2RtQXbDRADs1dIINKGH78ae8Hxg58/4sqd
 BbugRZ3MmTJjPvPZmRiEThdz85Vr2DLL1wueBk7l262JvIuqj8zj5bQcsHYLofwXQCD+vMe44Q
 46ti7W2LFirO7tv2QhRLvWbzcheUSPbfa5RT+U6FTzlgKWDUTHLbUAddXOa/NXaGmjna7ATpEJ
 FHJz/NovxC+87ANjGdE8k0XZZsiUfVdrWTX33LXI7vvIuW27MyzI4FFbmhMf6iOjfaM8PknfqV
 Kfw=
X-IronPort-AV: E=Sophos;i="5.73,384,1583164800"; 
   d="scan'208";a="246447462"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 01:27:03 +0800
IronPort-SDR: X/0pjPIPd4QjGcGAekcOIT6SDFQ2yZMz6X1o37FSnUlsiabHcagaeLgDoJvB0WXYZhtQlWTl+m
 eCfQ4VApc4Mc21YIPgjKSBTvHfl9J6DaA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 10:17:19 -0700
IronPort-SDR: 2ejtzASysWYYZdITFELGb9zYXq8bhGjmDZIhqQerDQZ0ODBXymb1YEIFDwnpa3m4RQhiDcNDdj
 sHsrvCZ1Dsyw==
WDCIronportException: Internal
Received: from unknown (HELO yoda.hgst.com) ([10.86.57.98])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 10:27:03 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Wesley W. Terpstra" <wesley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irqchip/sifive-plic: Remove incorrect requirement about number of irq contexts
Date:   Tue, 12 May 2020 10:26:36 -0700
Message-Id: <20200512172636.96299-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

A PLIC may not be connected to all the cores. In that case, nr_contexts
may be less than num_possible_cpus. This requirement is only valid a single
PLIC is the only interrupt controller for the whole system.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
[Atish: Modified the commit text]
Signed-off-by: "Wesley W. Terpstra" <wesley@sifive.com>
---
 drivers/irqchip/irq-sifive-plic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d0a71febdadc..822e074c0600 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -301,8 +301,6 @@ static int __init plic_init(struct device_node *node,
 	nr_contexts = of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_contexts < num_possible_cpus()))
-		goto out_iounmap;
 
 	error = -ENOMEM;
 	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-- 
2.26.2

