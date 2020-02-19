Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67335C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D22220801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBSMws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:52:48 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:49098 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgBSMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:52:48 -0500
X-Greylist: delayed 2361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 07:52:47 EST
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1j4OE9-0003q3-58; Wed, 19 Feb 2020 12:13:17 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.93)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1j4OE8-005GIt-ID; Wed, 19 Feb 2020 12:13:16 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] rqchip/gic: make clearner warnings when no-type specified
Date:   Wed, 19 Feb 2020 12:13:14 +0000
Message-Id: <20200219121315.1254222-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an IRQ is defined without an associated type, then this triggers a
warning in the IRQ translation function gic_irq_domain_translate()
which does not give any useful information about which node was at fault.
It also means that if there are multiple entries the dmesg soon fills
with backtraces which are not useufl either.

Change to print a single line with the info of which fwspec
info was at fault.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc; linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-gic.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..52442eff4027 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -996,6 +996,16 @@ static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
 }
 
+/* give a useful warning if there is no type specified. Just using WARN()
+ * end up with lots of not-useful stack backtraces. SHow the node and the
+ * IRQ number being translated.
+ */
+static void warn_no_type(struct irq_domain *d, unsigned long irq)
+{
+	pr_warn("WARNING: GIC: %s: no type specified when translating %lu\n",
+		d->name, irq);
+}
+
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -1018,7 +1028,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
 		/* Make it clear that broken DTs are... broken */
-		WARN_ON(*type == IRQ_TYPE_NONE);
+		if (*type == IRQ_TYPE_NONE)
+			warn_no_type(d, fwspec->param[1]);
 		return 0;
 	}
 
@@ -1029,7 +1040,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
-		WARN_ON(*type == IRQ_TYPE_NONE);
+		if (*type == IRQ_TYPE_NONE)
+			warn_no_type(d, fwspec->param[0]);
 		return 0;
 	}
 
-- 
2.25.0

