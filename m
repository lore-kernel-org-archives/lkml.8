Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A8C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34ABE20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731204;
	bh=TygesCzghEkRvZdNuf5/krX4BSlw8CWFiMSdm0suEcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o7dkjGt4Wlclind9ClQ3O2Qqxd6KQyR+aZBhvyOREJk1UlWlwl8XIiSJLEWfOJ0GJ
	 MBxcc4+kMap/fHd/XnYT3WSB5wDyOMfq4bp9nbm9Ky0S5lY7skw9O5HHV4lTsTLtle
	 CB5/OfsbjLKt9S3rdPQ+tuuVk6CBKI/WobuDYw2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgDXMYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbgDXMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8627520776;
        Fri, 24 Apr 2020 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731083;
        bh=TygesCzghEkRvZdNuf5/krX4BSlw8CWFiMSdm0suEcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMX0VN2MPQ4HkKIZyQdvJxPGDRST80BYrmBomSW5n4tnnvDLcZe6w5NaG+8Nh/d8n
         wcOL+jSqGZHqDcr6tcmj7m29Y8M3oztAQMEo1VBGG6NpBnGbOVsg4hZ11HACOwNjgq
         +UHNTX3w/L+KJlfnk0c9sUh2/WvpATbDwM80oETo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/21] irqchip/mbigen: Free msi_desc on device teardown
Date:   Fri, 24 Apr 2020 08:24:17 -0400
Message-Id: <20200424122419.10648-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122419.10648-1-sashal@kernel.org>
References: <20200424122419.10648-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

[ Upstream commit edfc23f6f9fdbd7825d50ac1f380243cde19b679 ]

Using irq_domain_free_irqs_common() on the irqdomain free path will
leave the MSI descriptor unfreed when platform devices get removed.
Properly free it by MSI domain free function.

Fixes: 9650c60ebfec0 ("irqchip/mbigen: Create irq domain for each mbigen device")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200408114352.1604-1-yuzenghui@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mbigen.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f7fdbf5d183b9..c98358be0bc8b 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -231,10 +231,16 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
+static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	platform_msi_domain_free(domain, virq, nr_irqs);
+}
+
 static const struct irq_domain_ops mbigen_domain_ops = {
 	.translate	= mbigen_domain_translate,
 	.alloc		= mbigen_irq_domain_alloc,
-	.free		= irq_domain_free_irqs_common,
+	.free		= mbigen_irq_domain_free,
 };
 
 static int mbigen_of_create_domain(struct platform_device *pdev,
-- 
2.20.1

