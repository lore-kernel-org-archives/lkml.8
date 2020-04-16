Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4862214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051721;
	bh=QmB29ly0Y71X/FgMW4b306XefznnlZC+fnySE+kruPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZVgQH7CCCahO2Ea/4y5BVQtUDVWpwBhJqDnZsfZedqzT+RS5kOneeRziq3x4VwT3S
	 3WoTI6/b+Tt9pDcJnyA5mEOI2/2dpzyPQ48NczDy+bimAVfQMIVFjEhhRb28s/nloL
	 n0oUZkFtWWMoJPwfMAfVAmBkFtCdMAeniWvjDqpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395517AbgDPPmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897370AbgDPNgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:36:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F70021BE5;
        Thu, 16 Apr 2020 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044212;
        bh=QmB29ly0Y71X/FgMW4b306XefznnlZC+fnySE+kruPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfAr3iBSPqpVnlGKrt3KvOBcqyN3GplVjVjEf3SOIRf0b8cuvQZ28tL6IDkukloZq
         /MPWkz1PXBsJYQTpXiusjaW+SO+n1pQOOn4I1XU8KPxNcLjwechL9sd8fJj9yr6f1/
         dvRzJ2PX1QMgDfio3HjF57DSaQ20xkLEEB4owBmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.5 127/257] genirq/debugfs: Add missing sanity checks to interrupt injection
Date:   Thu, 16 Apr 2020 15:22:58 +0200
Message-Id: <20200416131342.240942269@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit a740a423c36932695b01a3e920f697bc55b05fec upstream.

Interrupts cannot be injected when the interrupt is not activated and when
a replay is already in progress.

Fixes: 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from userspace")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200306130623.500019114@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/debugfs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -206,8 +206,15 @@ static ssize_t irq_debug_write(struct fi
 		chip_bus_lock(desc);
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
-		if (irq_settings_is_level(desc) || desc->istate & IRQS_NMI) {
-			/* Can't do level nor NMIs, sorry */
+		/*
+		 * Don't allow injection when the interrupt is:
+		 *  - Level or NMI type
+		 *  - not activated
+		 *  - replaying already
+		 */
+		if (irq_settings_is_level(desc) ||
+		    !irqd_is_activated(&desc->irq_data) ||
+		    (desc->istate & (IRQS_NMI | IRQS_REPLAY))) {
 			err = -EINVAL;
 		} else {
 			desc->istate |= IRQS_PENDING;


