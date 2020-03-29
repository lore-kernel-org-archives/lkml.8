Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F87C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81520784
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgC2U1y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56977 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgC2U0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVe-0001Mi-2r; Sun, 29 Mar 2020 22:26:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B45D1C04D7;
        Sun, 29 Mar 2020 22:26:12 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:12 -0000
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ingenic: Add support for TCU of X1000.
Cc:     zhouyanjie@wanyeetech.com, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584456160-40060-3-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584456160-40060-3-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <158551357212.28353.13991321888756052946.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7d4cac5b7ce5ab87d5f0a2296a118f2eca713f1f
Gitweb:        https://git.kernel.org/tip/7d4cac5b7ce5ab87d5f0a2296a118f2eca713f1f
Author:        周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
AuthorDate:    Tue, 17 Mar 2020 22:42:40 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Mar 2020 11:52:52 

irqchip/ingenic: Add support for TCU of X1000.

Enable TCU support for Ingenic X1000, which can be supported by
the existing driver.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1584456160-40060-3-git-send-email-zhouyanjie@wanyeetech.com
---
 drivers/irqchip/irq-ingenic-tcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 6d05cef..7a7222d 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -180,3 +180,4 @@ err_free_tcu:
 IRQCHIP_DECLARE(jz4740_tcu_irq, "ingenic,jz4740-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(jz4725b_tcu_irq, "ingenic,jz4725b-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(jz4770_tcu_irq, "ingenic,jz4770-tcu", ingenic_tcu_irq_init);
+IRQCHIP_DECLARE(x1000_tcu_irq, "ingenic,x1000-tcu", ingenic_tcu_irq_init);
