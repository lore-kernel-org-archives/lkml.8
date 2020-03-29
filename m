Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2456EC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015B320781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgC2U1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgC2U02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVj-0001QQ-JA; Sun, 29 Mar 2020 22:26:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2281E1C07A5;
        Sun, 29 Mar 2020 22:26:16 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:15 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Wait for completion of
 redistributor's INVALL operation
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Eric Auger <eric.auger@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302092145.899-1-yuzenghui@huawei.com>
References: <20200302092145.899-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <158551357577.28353.13458625309986219311.tip-bot2@tip-bot2>
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

Commit-ID:     b978c25f6ee7d4c79cbe918eed684e53887ec001
Gitweb:        https://git.kernel.org/tip/b978c25f6ee7d4c79cbe918eed684e53887ec001
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Wed, 04 Mar 2020 20:33:11 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 20 Mar 2020 17:48:09 

irqchip/gic-v4.1: Wait for completion of redistributor's INVALL operation

In GICv4.1, we emulate a guest-issued INVALL command by a direct write
to GICR_INVALLR.  Before we finish the emulation and go back to guest,
let's make sure the physical invalidate operation is actually completed
and no stale data will be left in redistributor. Per the specification,
this can be achieved by polling the GICR_SYNCR.Busy bit (to zero).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20200302092145.899-1-yuzenghui@huawei.com
Link: https://lore.kernel.org/r/20200304203330.4967-5-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1af7139..c843702 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3827,6 +3827,8 @@ static void its_vpe_4_1_invall(struct its_vpe *vpe)
 	/* Target the redistributor this vPE is currently known on */
 	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVALLR);
+
+	wait_for_syncr(rdbase);
 }
 
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
