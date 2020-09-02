Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE14AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB512071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599068786;
	bh=3xtSTc2OZMj/mMgPUyatTB0SGWmOKUY5lfR1mbL5PxU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bh9WS+uQOOgSzD1OqtqIDVJ0YGtv6to4GFkMCQxxO+cXwQykLUIc2UJgx1I435TJy
	 wXqi1tvpMs5Cgy75/Wxjftc/Rji7u9AlYKi6BS5vHh6AjzeUG2wgSDhOQeiS7y0WSk
	 yaeiNfcJ7dvjhySX+BW/Td7p6AMz2MDsgwr1Fixg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgIBRqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBRqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:46:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA312071B;
        Wed,  2 Sep 2020 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599068781;
        bh=3xtSTc2OZMj/mMgPUyatTB0SGWmOKUY5lfR1mbL5PxU=;
        h=From:To:Cc:Subject:Date:From;
        b=1NCp2JfqWVzLx1MIW5qNtdA4eDFE3n43YnslRlR5gBuV3enyLrg+iWudVHppylomp
         AqhcnpbN9paRXy+Fn0Rk2UmMr65ic1YaUJ/v98ff9ECDrb0CSpUgOEnDF75bgTQM4k
         C2qvvVwLHxK4Ex/KLRolA8BmWq0ew03a609LRJ4Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] irqchip/ti-sci: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 19:46:14 +0200
Message-Id: <20200902174615.24695-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

There is also no need to assign NULL to 'intr->sci' as it is part of
devm-allocated memory.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/irqchip/irq-ti-sci-inta.c | 10 +++-------
 drivers/irqchip/irq-ti-sci-intr.c | 10 +++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index d4e97605456b..bc863ef7998d 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -600,13 +600,9 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 
 	inta->pdev = pdev;
 	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
-	if (IS_ERR(inta->sci)) {
-		ret = PTR_ERR(inta->sci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ti,sci read fail %d\n", ret);
-		inta->sci = NULL;
-		return ret;
-	}
+	if (IS_ERR(inta->sci))
+		return dev_err_probe(dev, PTR_ERR(inta->sci),
+				     "ti,sci read fail\n");
 
 	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &inta->ti_sci_id);
 	if (ret) {
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index cbc1758228d9..6a6fb6616c21 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -254,13 +254,9 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	}
 
 	intr->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
-	if (IS_ERR(intr->sci)) {
-		ret = PTR_ERR(intr->sci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ti,sci read fail %d\n", ret);
-		intr->sci = NULL;
-		return ret;
-	}
+	if (IS_ERR(intr->sci))
+		return dev_err_probe(dev, PTR_ERR(intr->sci),
+				     "ti,sci read fail\n");
 
 	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dev-id",
 				   &intr->ti_sci_id);
-- 
2.17.1

