Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DDEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A1D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583866179;
	bh=tw0gB/ovTVcwrhtwprojKzwKigF0zMWLOBTxhTgjsuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lz7ebHI4I7k4q0iHJgOmRnm0SZhM1IQw5uOAJe5YS6cdffaGLTdViFOQg1DuI886e
	 KVh6a/wg495CSzV4LW1ZtU6ER5smE/7ufhXSCLed7jRSiqqv+38PnQteFYVrbHQG0Y
	 3kwPF+JBGeGCfSiR6OGmpn3GEveu9U0JlJWuTt6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCJSti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgCJStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CDF5222C4;
        Tue, 10 Mar 2020 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583866171;
        bh=tw0gB/ovTVcwrhtwprojKzwKigF0zMWLOBTxhTgjsuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDcTjMpNX02c3ckluYK+vNdLFT/Tl7iG4Z2tiCzUMyp16ctrkTgRf5C2IGs6TPnSI
         lEmhUSqmKR9t2oufMCrzHgH2FWJTe4j4rl3ROUyUfmgBpmTBx335O75xN8tFB/sOTC
         fHlOhxbEJ+cOagJXpGC0R+zkPUh/pmDAfdjlNa5w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBjwX-00Bi6k-G6; Tue, 10 Mar 2020 18:49:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@arm.linux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 3/4] ARM: sa1111: Fix irq_retrigger callback return value
Date:   Tue, 10 Mar 2020 18:49:20 +0000
Message-Id: <20200310184921.23552-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310184921.23552-1-maz@kernel.org>
References: <20200310184921.23552-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, linux@arm.linux.org.uk, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_retrigger callback is supposed to return 0 when retrigger
has failed, and a non-zero value otherwise. Tell the core code
that the driver has succedded in using the HW to retrigger the
interrupt (if ever).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/common/sa1111.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 947ef7981d92..c98ebae1aeac 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -302,10 +302,13 @@ static int sa1111_retrigger_irq(struct irq_data *d)
 			break;
 	}
 
-	if (i == 8)
+	if (i == 8) {
 		pr_err("Danger Will Robinson: failed to re-trigger IRQ%d\n",
 		       d->irq);
-	return i == 8 ? -1 : 0;
+		return 0;
+	}
+
+	return 1;
 }
 
 static int sa1111_type_irq(struct irq_data *d, unsigned int flags)
-- 
2.20.1

