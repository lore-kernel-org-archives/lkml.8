Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E2C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8103205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443315;
	bh=bnlZR9g9uKjlgGOZbuIMeDer+gJi06w2vhUb6KFKgDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FuMIXBalDsZUSpVyvlWjro4Gq5aasQQAXmw2U4x2mWMJtkTm84ZvMaxlZTdNMrd1l
	 D9O9N/4HoP3hiOMo+7Bux1x8B3sQeh39R6UuzKB3LTRSdvuPHXtS9sweK/Dc+gfoDT
	 CqzlsNN80Toxuoal0xghnkNqqWT3xOjPJ5UF/ebY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgCQLIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbgCQLIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:08:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3E1206EC;
        Tue, 17 Mar 2020 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443310;
        bh=bnlZR9g9uKjlgGOZbuIMeDer+gJi06w2vhUb6KFKgDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iolzlYA2iyXl8BcCycJsL4gb/hJOlpWxbOWaQxiycvh0KQfWijwXuxSVBdY3t8Xyq
         A1/CPKE+AdAk4hPy1T+B84wkTieqFZ0mvEY19Eo3DFD/TP4tG08toSJYGpgbKfNGhV
         Sl9Z6ce7Cyp8c5U1ujeRsuCrQwC50GDrYTuaVBYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 016/151] net: dsa: mv88e6xxx: fix lockup on warm boot
Date:   Tue, 17 Mar 2020 11:53:46 +0100
Message-Id: <20200317103327.579276029@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 0395823b8d9a4d87bd1bf74359123461c2ae801b ]

If the switch is not hardware reset on a warm boot, interrupts can be
left enabled, and possibly pending. This will cause us to enter an
infinite loop trying to service an interrupt we are unable to handle,
thereby preventing the kernel from booting.

Ensure that the global 2 interrupt sources are disabled before we claim
the parent interrupt.

Observed on the ZII development revision B and C platforms with
reworked serdes support, and using reboot -f to reboot the platform.

Fixes: dc30c35be720 ("net: dsa: mv88e6xxx: Implement interrupt support.")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/global2.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1096,6 +1096,13 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6
 {
 	int err, irq, virq;
 
+	chip->g2_irq.masked = ~0;
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_g2_int_mask(chip, ~chip->g2_irq.masked);
+	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		return err;
+
 	chip->g2_irq.domain = irq_domain_add_simple(
 		chip->dev->of_node, 16, 0, &mv88e6xxx_g2_irq_domain_ops, chip);
 	if (!chip->g2_irq.domain)
@@ -1105,7 +1112,6 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6
 		irq_create_mapping(chip->g2_irq.domain, irq);
 
 	chip->g2_irq.chip = mv88e6xxx_g2_irq_chip;
-	chip->g2_irq.masked = ~0;
 
 	chip->device_irq = irq_find_mapping(chip->g1_irq.domain,
 					    MV88E6XXX_G1_STS_IRQ_DEVICE);


