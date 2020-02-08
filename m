Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE39C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FCC21741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBHO6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:58:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgBHO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:58:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0RYb-0003Bj-WE; Sat, 08 Feb 2020 15:58:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9964D1C1A0D;
        Sat,  8 Feb 2020 15:58:05 +0100 (CET)
Date:   Sat, 08 Feb 2020 14:58:05 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4.1: Fix programming of
 GICR_VPROPBASER_4_1_SIZE
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206075711.1275-2-yuzenghui@huawei.com>
References: <20200206075711.1275-2-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <158117388538.411.5967613915724924192.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e88bd316e5971fe78884ad1f466b9fc576575e5f
Gitweb:        https://git.kernel.org/tip/e88bd316e5971fe78884ad1f466b9fc576575e5f
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Thu, 06 Feb 2020 15:57:06 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Feb 2020 10:01:33 

irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE

The Size field of GICv4.1 VPROPBASER register indicates number of
pages minus one and together Page_Size and Size control the vPEID
width. Let's respect this requirement of the architecture.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200206075711.1275-2-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e5a25d9..992bc72 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2531,7 +2531,7 @@ static int allocate_vpe_l1_table(void)
 		npg = 1;
 	}
 
-	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg - 1);
 
 	/* Right, that's the number of CPU pages we need for L1 */
 	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);
