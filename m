Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B62C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B49520787
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgC2U2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:28:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgC2U0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVc-0001M6-0U; Sun, 29 Mar 2020 22:26:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AAE911C0334;
        Sun, 29 Mar 2020 22:26:10 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:10 -0000
From:   "tip-bot2 for Mubin Sayyed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/xilinx: Do not call irq_set_default_host()
Cc:     Mubin Sayyed <mubin.usman.sayyed@xilinx.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200317125600.15913-5-mubin.usman.sayyed@xilinx.com>
References: <20200317125600.15913-5-mubin.usman.sayyed@xilinx.com>
MIME-Version: 1.0
Message-ID: <158551357030.28353.11165971801388773677.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9c2d4f525c002591f4e0c14a37663663aaba1656
Gitweb:        https://git.kernel.org/tip/9c2d4f525c002591f4e0c14a37663663aaba1656
Author:        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
AuthorDate:    Tue, 17 Mar 2020 18:26:00 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Mar 2020 11:52:53 

irqchip/xilinx: Do not call irq_set_default_host()

Using a default domain on DT based platforms is unnecessary.

Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200317125600.15913-5-mubin.usman.sayyed@xilinx.com
---
 drivers/irqchip/irq-xilinx-intc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index ea74181..7f811fe 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -250,7 +250,6 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		}
 	} else {
 		primary_intc = irqc;
-		irq_set_default_host(primary_intc->root_domain);
 		set_handle_irq(xil_intc_handle_irq);
 	}
 
