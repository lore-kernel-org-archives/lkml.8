Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A13BC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97A2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h/owNDU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgDHTP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:15:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43284 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgDHTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:15:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038JFfeK086312;
        Wed, 8 Apr 2020 14:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586373341;
        bh=Qb5ZeAVRpJh28ykpe0w7F87pvW1U8JceUNeMw/ITQaM=;
        h=From:To:CC:Subject:Date;
        b=h/owNDU1NivTnUt4VOatmB7/pwiAwiGO1KnfFF8IFkZul3QdgNDidiTYL/o3l1hll
         kXryCYfMntuBeGKA7Ah9IF/Q9UTRqm4+td+BX1SpVNFMToYkuPwKMvM4UiT4z8O1im
         Eum9Yemss3CvZfy7/Vghx9qn4KEldqv4AyhDGl+I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 038JFfTg006789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Apr 2020 14:15:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 14:15:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 14:15:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038JFd3K108863;
        Wed, 8 Apr 2020 14:15:40 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] irqchip/ti-sci-inta: fix processing of masked irqs
Date:   Wed, 8 Apr 2020 22:15:32 +0300
Message-ID: <20200408191532.31252-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_sci_inta_irq_handler() does not take into account INTA IRQs state
(masked/unmasked) as it uses INTA_STATUS_CLEAR_j register to get INTA IRQs
status, which provides raw status value.
This causes hard IRQ handlers to be called or threaded handlers to be
scheduled many times even if corresponding INTA IRQ is masked.
Above, first of all, affects the LEVEL interrupts processing and causes
unexpected behavior up the system stack or crash.

Fix it by using the Interrupt Masked Status INTA_STATUSM_j register which
provides masked INTA IRQs status.

Fixes: 9f1463b86c13 ("irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 8f6e6b08eadf..7e3ebf6ed2cd 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -37,6 +37,7 @@
 #define VINT_ENABLE_SET_OFFSET	0x0
 #define VINT_ENABLE_CLR_OFFSET	0x8
 #define VINT_STATUS_OFFSET	0x18
+#define VINT_STATUS_MASKED_OFFSET	0x20
 
 /**
  * struct ti_sci_inta_event_desc - Description of an event coming to
@@ -116,7 +117,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
 	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
-			    VINT_STATUS_OFFSET);
+			    VINT_STATUS_MASKED_OFFSET);
 
 	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
 		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);
-- 
2.17.1

