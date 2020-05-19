Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDAD20826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905127;
	bh=ngymdRy/GrnWvhqH1+agQKtWfVBAGwiWKHGa9+7JoHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KOpFZsXet1I7jpX4ND+L3oE7wkzl81hpQmt6djl2PvIYs6sPiRbaDs3cC9KeZnos2
	 W4muj8WPrMVQ91sg2JzbokPlZP4hi73P2//B32RA0gOZS6ZRxIDzHZ/lt8yPyPSQgk
	 CVGtW3JVjgijY1ooGsx1CUI+7Xg9LbdLM7qVoTYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgESQSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbgESQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:18:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8ECE20842;
        Tue, 19 May 2020 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589905104;
        bh=ngymdRy/GrnWvhqH1+agQKtWfVBAGwiWKHGa9+7JoHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwjaIC+31+LJYewlDKF415zzu8tyJ0lU8IbH5R1b7svBEF1BAf8fVL4ukpEFiU/cG
         6le1NOfYwMwPiqe99udjfmr0OaVJBT+QBu9n7grkXpVx383T3p3nIVERCQwCXjDQCP
         N/vYTTkXYG+o9ynOj/3aEQ48O/L1hQQyDII9VMuc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jb4wh-00Decy-4f; Tue, 19 May 2020 17:18:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: [PATCH 05/11] irqchip/gic-v3: Describe the SGI range
Date:   Tue, 19 May 2020 17:17:49 +0100
Message-Id: <20200519161755.209565-6-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519161755.209565-1-maz@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef18a0d..23d7c87da407 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -112,6 +112,7 @@ static DEFINE_PER_CPU(bool, has_rss);
 #define DEFAULT_PMR_VALUE	0xf0
 
 enum gic_intid_range {
+	SGI_RANGE,
 	PPI_RANGE,
 	SPI_RANGE,
 	EPPI_RANGE,
@@ -123,6 +124,8 @@ enum gic_intid_range {
 static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
 {
 	switch (hwirq) {
+	case 0 ... 15:
+		return SGI_RANGE;
 	case 16 ... 31:
 		return PPI_RANGE;
 	case 32 ... 1019:
@@ -148,15 +151,22 @@ static inline unsigned int gic_irq(struct irq_data *d)
 	return d->hwirq;
 }
 
-static inline int gic_irq_in_rdist(struct irq_data *d)
+static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
-	enum gic_intid_range range = get_intid_range(d);
-	return range == PPI_RANGE || range == EPPI_RANGE;
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		/* SGI+PPI -> SGI_base for this CPU */
@@ -253,6 +263,7 @@ static void gic_enable_redist(bool enable)
 static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
 {
 	switch (get_intid_range(d)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case SPI_RANGE:
 		*index = d->hwirq;
@@ -1277,6 +1288,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		chip = &gic_eoimode1_chip;
 
 	switch (__get_intid_range(hw)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
-- 
2.26.2

