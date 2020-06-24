Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FC2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7692080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593028727;
	bh=vOk/KS2oyObq/ip/FzPtbh8Z4MzVJ5vpZhAYl4vAmQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O2XFcEp+PMqLpY2U+HibSA+J7QYPhXMdOP9/yb95zyvMHq4FFF73HRsk23ZJP8kkj
	 DFnd37vmuud7GQhIvHY/HUvxamnHbaTmgwRiK59djsiwH99na8OhOJt/XBWDyC66km
	 E1n6koWhkrX6ztW6ZvUu+Yl/PYx3kIz6yYDFEoQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406328AbgFXT6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406258AbgFXT6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:58:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EE920857;
        Wed, 24 Jun 2020 19:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593028700;
        bh=vOk/KS2oyObq/ip/FzPtbh8Z4MzVJ5vpZhAYl4vAmQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulkROwrwBWOMiGUW0j1tU8lpQdzifIfL01uXD9FZ5tAiD3A6sZF4HOfA4grkerbaS
         XA9sLyoNn71o9M6MmpIbv1uVHjYgEx/LFqsFtv0NJQi2IYUJ5vA+FamrUojSawDTKO
         S4LWeDs6/noYGPGtMzLI2+WNvQZRaJ9QHP4JHDas=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joBXH-006ABu-81; Wed, 24 Jun 2020 20:58:19 +0100
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
Subject: [PATCH v2 05/17] irqchip/gic-v3: Describe the SGI range
Date:   Wed, 24 Jun 2020 20:57:59 +0100
Message-Id: <20200624195811.435857-6-maz@kernel.org>
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

As we are about to start making use of SGIs in a more conventional
way, let's describe it is the GICv3 list of interrupt types.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cc46bc2d634b..19b294ed48ba 100644
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
2.27.0

