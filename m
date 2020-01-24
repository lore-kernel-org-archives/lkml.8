Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26720C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFE82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392209AbgAXTNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:13:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389363AbgAXTLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MI-0007bR-1G; Fri, 24 Jan 2020 20:11:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B10CC1C1A62;
        Fri, 24 Jan 2020 20:11:08 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:08 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224111055.11836-8-maz@kernel.org>
References: <20191224111055.11836-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157989306847.396.9104611654547024981.tip-bot2@tip-bot2>
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

Commit-ID:     0684c7046590dd1e8047e187aaf4c7910cc35bce
Gitweb:        https://git.kernel.org/tip/0684c7046590dd1e8047e187aaf4c7910cc35bce
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 24 Dec 2019 11:10:30 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Jan 2020 14:22:20 

irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is set

The infamous VPE proxy device isn't used with GICv4.1 because:
- we can invalidate any LPI from the DirectLPI MMIO interface
- the ITS and redistributors understand the life cycle of
  the doorbell, so we don't need to enable/disable it all
  the time

So let's escape early from the proxy related functions.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191224111055.11836-8-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fbf4ca7..9bc8adf 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3212,7 +3212,7 @@ static const struct irq_domain_ops its_domain_ops = {
 /*
  * This is insane.
  *
- * If a GICv4 doesn't implement Direct LPIs (which is extremely
+ * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
  * likely), the only way to perform an invalidate is to use a fake
  * device to issue an INV command, implying that the LPI has first
  * been mapped to some event on that device. Since this is not exactly
@@ -3220,9 +3220,20 @@ static const struct irq_domain_ops its_domain_ops = {
  * only issue an UNMAP if we're short on available slots.
  *
  * Broken by design(tm).
+ *
+ * GICv4.1, on the other hand, mandates that we're able to invalidate
+ * by writing to a MMIO register. It doesn't implement the whole of
+ * DirectLPI, but that's good enough. And most of the time, we don't
+ * even have to invalidate anything, as the redistributor can be told
+ * whether to generate a doorbell or not (we thus leave it enabled,
+ * always).
  */
 static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already unmapped? */
 	if (vpe->vpe_proxy_event == -1)
 		return;
@@ -3245,6 +3256,10 @@ static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (!gic_rdists->has_direct_lpi) {
 		unsigned long flags;
 
@@ -3256,6 +3271,10 @@ static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_map_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already mapped? */
 	if (vpe->vpe_proxy_event != -1)
 		return;
@@ -3278,6 +3297,10 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 	unsigned long flags;
 	struct its_collection *target_col;
 
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (gic_rdists->has_direct_lpi) {
 		void __iomem *rdbase;
 
