Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3EC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ED22082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="H4U1i2ZQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="suCHuiSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgAMEtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:49:43 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43033 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733103AbgAMEtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EB0AB6126;
        Sun, 12 Jan 2020 23:49:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=reXcLSbb+prTw
        I8AliRHNqGV5b9kALgHS1AE29T8AYU=; b=H4U1i2ZQj1rYKQQzTkEtBJnqb6xbM
        Phiq+UP9EMm+BWiL4BjDtXfMY7v5LIA6f+h3m10scf6jaH8bXdheafC2ueYogxRU
        5MQ66O6OP6l/XSoz5O2YVo4kgHEDI+QiIKpWoi5GNWJs9KAlG593RREQ2WQrixz9
        XX50/Wnzanm5W98IwMeTj4Roafbzsr6J5MNZrxqGD+A8k35Rrxgbnqyrf8GX702f
        CQaO+bhgsp2CmR1cYkaU5r9HY5r7P71qLIG9Ss2WHFCRiQia9WRPWDI10SLc/N3p
        s+EIGf6v15/7H1fXhsdfvM+X+7Z6QvRszpzx7K6MsjV46Cag90pvGJp1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=reXcLSbb+prTwI8AliRHNqGV5b9kALgHS1AE29T8AYU=; b=suCHuiSv
        dgYZl1S5aUrQvib47ij59kfAFjwWGbgddDTSpnlvVTUB7q5ywK2hyb14Qx1zfb/4
        uUc3/YxYyOnqc/XOp7swbCzwoUDh5WiU15UykHynx/vNCuvzWO5qI6RQz7+eig4k
        KT3TFWSmeZrC6TLTcwpahzfC0a44tH3hI+ipj59kN9kArE3Rng03UE+TRTNGKm9A
        2qQ11mU+hw8T5xmDpbpoecf+CT5n6ny8kVD1kHYZk9z5LYLwDuVoSfLkza+qtEc/
        sBSJII4HJ0qc9lnhrUB4Lyr/bkoxiiCuirS5KabpWLNJCtZB4pfE4vIMPPGg8c7R
        vhsGmDbvM7cleA==
X-ME-Sender: <xms:4vYbXiSXlyqL0twguZloHZTmDwsoj5XmtYPtZWcmHSU9guT_-3pkkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4vYbXo1pNsmj1-IFkLAfvsx3EpDRLRIR34drhDj7nMsv0wKyLSXY-w>
    <xmx:4vYbXix0g1k4fg1sctfBk7_PYkdcjYjrue-lMeNmJajaOmLdcE-YeA>
    <xmx:4vYbXrtEwspzYo-6poOAysiOWa3zdNFAdhKNJ5ZOvFU-sYck_XHAzA>
    <xmx:4vYbXiLOf9kEezbv0VoBrwp4vIPJCs8sxTNKg-0AKdAmXsLc7Riw8w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F96030602DB;
        Sun, 12 Jan 2020 23:49:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/9] irqchip/sun6i-r: Add wakeup support
Date:   Sun, 12 Jan 2020 22:49:29 -0600
Message-Id: <20200113044936.26038-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We maintain a mask of wake-enabled IRQs, and enable them in hardware
during the syscore phase of suspend (once IRQs are globally turned off).
We restore the original mask (either nothing or NMI only) during resume.

This serves two purposes. First, it lets power management firmware
running on the ARISC coprocessor know which wakeup sources Linux wants
to have enabled. That way, it can avoid turning them off when it shuts
down the remainder of the clock tree. Second, it preconfigures the
ARISC coprocessor's interrupt controller, so the firmware's wakeup logic
is as simple as waiting for an interrupt to arrive.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/irqchip/irq-sun6i-r.c | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 37b6e9c60bf8..f4a4e335061b 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -3,12 +3,14 @@
 // Allwinner A31 and newer SoCs R_INTC driver
 //
 
+#include <linux/atomic.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -31,6 +33,9 @@ enum {
 static void __iomem *base;
 static irq_hw_number_t parent_offset;
 static u32 parent_type;
+#ifdef CONFIG_PM_SLEEP
+static atomic_t wake_mask;
+#endif
 
 static void sun6i_r_intc_irq_enable(struct irq_data *data)
 {
@@ -108,6 +113,21 @@ static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
 	return irq_chip_set_type_parent(data, type);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sun6i_r_intc_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	if (on)
+		atomic_or(BIT(data->hwirq), &wake_mask);
+	else
+		atomic_andnot(BIT(data->hwirq), &wake_mask);
+
+	/* GIC cannot wake, so there is no need to call the parent hook. */
+	return 0;
+}
+#else
+#define sun6i_r_intc_irq_set_wake NULL
+#endif
+
 static struct irq_chip sun6i_r_intc_chip = {
 	.name			= "sun6i-r-intc",
 	.irq_enable		= sun6i_r_intc_irq_enable,
@@ -118,6 +138,7 @@ static struct irq_chip sun6i_r_intc_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= sun6i_r_intc_irq_set_type,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 };
 
@@ -171,6 +192,36 @@ static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int sun6i_r_intc_suspend(void)
+{
+	/* All wake IRQs are enabled during suspend. */
+	writel(atomic_read(&wake_mask), base + SUN6I_R_INTC_ENABLE);
+
+	return 0;
+}
+
+static void sun6i_r_intc_resume(void)
+{
+	u32 mask = atomic_read(&wake_mask) & BIT(NMI_HWIRQ);
+
+	/* Only the NMI is relevant during normal operation. */
+	writel(mask, base + SUN6I_R_INTC_ENABLE);
+}
+
+static struct syscore_ops sun6i_r_intc_syscore_ops = {
+	.suspend	= sun6i_r_intc_suspend,
+	.resume		= sun6i_r_intc_resume,
+};
+
+static void sun6i_r_intc_syscore_init(void)
+{
+	register_syscore_ops(&sun6i_r_intc_syscore_ops);
+}
+#else
+static inline void sun6i_r_intc_syscore_init(void) {}
+#endif
+
 static int __init sun6i_r_intc_init(struct device_node *node,
 				    struct device_node *parent)
 {
@@ -215,6 +266,8 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 	/* Clear any pending interrupts. */
 	writel(~0, base + SUN6I_R_INTC_PENDING);
 
+	sun6i_r_intc_syscore_init();
+
 	return 0;
 }
 IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
-- 
2.23.0

