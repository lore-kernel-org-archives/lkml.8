Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C322082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029027;
	bh=KzbCMPrNfvmvBz/UyIe0+2bYMC6msl6l/aVwi0G3kCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdZ1xtL/YXT66+VIoANqcQQCe4DLFi1EeZLirKBjI/xPCR2aUSk8z5SuEOX2O2g4w
	 IZGA+sPF3Ry+k9BxRd7NnEMv9xjfk8Pdet+SdD14L0lhURzgaDT2DPOiBVx7rlOmdE
	 Pk6TWhFH1qbjaF5Zr/eIWEE09msYmTaMgVs1YDMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391432AbgFXUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391398AbgFXUD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:03:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B6C2084D;
        Wed, 24 Jun 2020 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029007;
        bh=KzbCMPrNfvmvBz/UyIe0+2bYMC6msl6l/aVwi0G3kCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eJlgTomBk4G/AEPLGYap+UGrn4gTq7JqiKIK1mNzjTkfTocIeKZrKTjUgQWecKM7U
         Nby52xhqG6u907/IEATnHIEREmSWVIaEWFspZQ80/V1ndeCJ0Qx2CrWOl8/kqdpXog
         mG3pBcuHKKqlGWLJ0TWz7xOR7URoKxoCBprbi50I=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXL-006ABu-F7; Wed, 24 Jun 2020 20:58:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: [PATCH v2 10/17] irqchip/gic-common: Don't enable SGIs by default
Date:   Wed, 24 Jun 2020 20:58:04 +0100
Message-Id: <20200624195811.435857-11-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624195811.435857-1-maz@kernel.org>
References: <20200624195811.435857-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture code now enables the IPIs as required, so no
need to enable SGIs by default in the GIC code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 82520006195d..f47b41dfd023 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -152,9 +152,6 @@ void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
 		writel_relaxed(GICD_INT_DEF_PRI_X4,
 					base + GIC_DIST_PRI + i * 4 / 4);
 
-	/* Ensure all SGI interrupts are now enabled */
-	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
-
 	if (sync_access)
 		sync_access();
 }
-- 
2.27.0

