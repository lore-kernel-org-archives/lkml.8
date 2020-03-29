Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58479C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328520748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgC2U2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:28:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56947 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgC2U0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVa-0001NJ-7Q; Sun, 29 Mar 2020 22:26:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EEA511C0451;
        Sun, 29 Mar 2020 22:26:12 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:12 -0000
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-irq-combiner: Replace zero-length array
 with flexible-array member
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319214531.GA21326@embeddedor.com>
References: <20200319214531.GA21326@embeddedor.com>
MIME-Version: 1.0
Message-ID: <158551357256.28353.13119952500983370550.tip-bot2@tip-bot2>
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

Commit-ID:     33ad1e5db06c94126352f785e9f0a08e867cb94c
Gitweb:        https://git.kernel.org/tip/33ad1e5db06c94126352f785e9f0a08e867cb94c
Author:        Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate:    Thu, 19 Mar 2020 16:45:31 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Mar 2020 11:52:52 

irqchip/qcom-irq-combiner: Replace zero-length array with flexible-array member

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200319214531.GA21326@embeddedor.com
---
 drivers/irqchip/qcom-irq-combiner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index abfe592..aa54bfc 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -33,7 +33,7 @@ struct combiner {
 	int                 parent_irq;
 	u32                 nirqs;
 	u32                 nregs;
-	struct combiner_reg regs[0];
+	struct combiner_reg regs[];
 };
 
 static inline int irq_nr(u32 reg, u32 bit)
