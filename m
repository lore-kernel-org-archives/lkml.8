Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B12EC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5990920781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgC2U1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgC2U00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVh-0001OZ-OR; Sun, 29 Mar 2020 22:26:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 306BA1C0450;
        Sun, 29 Mar 2020 22:26:14 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:13 -0000
From:   "tip-bot2 for Heyi Guo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4: Use Inner-Shareable attributes for
 virtual pending tables
Cc:     Heyi Guo <guoheyi@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191130073849.38378-1-guoheyi@huawei.com>
References: <20191130073849.38378-1-guoheyi@huawei.com>
MIME-Version: 1.0
Message-ID: <158551357385.28353.9119028347947412581.tip-bot2@tip-bot2>
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

Commit-ID:     b2cb11f4f7643255b7703c0fcabc31a8ec478f3a
Gitweb:        https://git.kernel.org/tip/b2cb11f4f7643255b7703c0fcabc31a8ec478f3a
Author:        Heyi Guo <guoheyi@huawei.com>
AuthorDate:    Sat, 30 Nov 2019 15:38:49 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:40:47 

irqchip/gic-v4: Use Inner-Shareable attributes for virtual pending tables

There is no special reason to set virtual LPI pending table as
non-shareable. If we choose to hard code the shareability without
probing, Inner-Shareable is likely to be a better choice, as the
VPEs can move around and benefit from having the redistributors
snooping each other's cache, if that's something they can do.

Furthermore, Hisilicon hip08 ends up with unspecified errors when
mixing shareability attributes. So let's move to IS attributes for
the VPT. This has also been tested on D05 and didn't show any
regression.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
[maz: rewrote commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191130073849.38378-1-guoheyi@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c   | 2 +-
 include/linux/irqchip/arm-gic-v3.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index bb80285..bc5b3f6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3560,7 +3560,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val  = virt_to_phys(page_address(vpe->vpt_page)) &
 		GENMASK_ULL(51, 16);
 	val |= GICR_VPENDBASER_RaWaWb;
-	val |= GICR_VPENDBASER_NonShareable;
+	val |= GICR_VPENDBASER_InnerShareable;
 	/*
 	 * There is no good way of finding out if the pending table is
 	 * empty as we can race against the doorbell interrupt very
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 83439bf..85b105f 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -320,6 +320,9 @@
 #define GICR_VPENDBASER_NonShareable					\
 	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, NonShareable)
 
+#define GICR_VPENDBASER_InnerShareable					\
+	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, InnerShareable)
+
 #define GICR_VPENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nCnB)
 #define GICR_VPENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nC)
 #define GICR_VPENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)
