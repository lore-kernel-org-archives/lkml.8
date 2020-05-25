Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F01C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0730204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="jeyPm6p1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8gT7tWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEYEMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42215 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgEYEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1645558008B;
        Mon, 25 May 2020 00:12:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Xrn0lUcE0vYS+
        TYAfF+PxgGbwGOEAVyhKE+EutZlw7o=; b=jeyPm6p1W2pH0ex81eyyNM8nrghkZ
        BOsNNl3zRKwTqY5tyKPNdVw+Wa/X3aDbfIqzGiQO+oDMOIes0aDwY306W//4QklT
        5GGuj4qFjCrdPQXiGZqiC61uthi8AHmSQOwhbP0juuxgbGrr6XXf5k69m4Qc8KYy
        VQ5/UPbW8nTuYZc4QchEc1JcM6fqHCohD+vWVEwE93AU2wmny+zdjYrrsbDhokU2
        JXF97UgIe/paAHnEkTAWp1j8LOhbKSRKEkWt+wHeFYB9t7Sy2AY0+TyAU8Gc2zrk
        uAKc6UnnXKsZJYl13j8XjSe7Aud6olpGqo/yB1n4K9atkhW3+DCbSG6ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Xrn0lUcE0vYS+TYAfF+PxgGbwGOEAVyhKE+EutZlw7o=; b=P8gT7tWR
        c4T+vsC7CKDXzdIOAPZbP4ghGdnxHldTkdxiVfTyXBS6cmpYLDr4TtloEUhqE3eP
        rP9J9dwD9k+cG6iOP5XbvMzFf2E6wVxkx0rMaSmY3ihRMChHpOXOJ60f6khfzJs4
        1kI5A8jFWR278ZvokgCDe3HgtOtHMOyDWqhn5hk5rSGABz4GAiYCuzUkkIOWOtAB
        YLIeEyAcM+bFMKp4KcitRwPpLwNS2s8XNCzuCHDgsaQQYE40T0kuRQSeM6R4gLhZ
        at/bcF7MUn2LRW+WubthlUOmGR/bWsZ1iXwe90xAQG1acDPIcotO9ZyYVg2jjySO
        Byj+o/CAJc984Q==
X-ME-Sender: <xms:tkXLXmsFYa9LdwjxfgZJUzpFeHy_g5rWskP95FNTA8nd9N3bdbRB2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:tkXLXreMx-f7YZt1b40PvqrDXoAx_eMUSEUIYV5cCc-7MdO81uOgNw>
    <xmx:tkXLXhysd1qx5L8kOsQMdb1LUUIxL2xUhaVh92-zaRhvomfOwz0b4g>
    <xmx:tkXLXhPcSEBhKptNu_Vs-TcMCuSvc4BnNqCOSzrvumrMSowR5DNHvQ>
    <xmx:t0XLXn2W8IWg1qdsAjAwH9dpgO_lypih_umdBgog4B9S2kzjhoEeZw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F2E9306653A;
        Mon, 25 May 2020 00:12:38 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 2/9] irqchip/sun6i-r: Add wakeup support
Date:   Sun, 24 May 2020 23:12:55 -0500
Message-Id: <20200525041302.51213-3-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200525041302.51213-1-samuel@sholland.org>
References: <20200525041302.51213-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain a mask of wake-enabled IRQs, and enable them in hardware
during the syscore phase of suspend. The restore the original mask
of enabled IRQs (just the NMI) during resume.

This serves two purposes. First, it lets power management firmware
running on the ARISC coprocessor know which wakeup sources Linux wants
to have enabled. That way, it can avoid turning them off when it shuts
down the remainder of the clock tree. Second, it preconfigures the
coprocessor's interrupt controller, so the firmware's wakeup logic
is as simple as waiting for an interrupt to arrive.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/irqchip/irq-sun6i-r.c | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index f8bfa5515f20..a5deea92057f 100644
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
 
@@ -24,6 +26,9 @@
 static void __iomem *base;
 static irq_hw_number_t parent_offset;
 static u32 parent_type;
+#ifdef CONFIG_PM_SLEEP
+static atomic_t wake_mask;
+#endif
 
 static struct irq_chip sun6i_r_intc_edge;
 static struct irq_chip sun6i_r_intc_level;
@@ -106,6 +111,20 @@ static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
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
+	return 0;
+}
+#else
+#define sun6i_r_intc_irq_set_wake NULL
+#endif
+
 static struct irq_chip sun6i_r_intc_edge = {
 	.name			= "sun6i-r-intc",
 	.irq_ack		= sun6i_r_intc_irq_ack,
@@ -116,6 +135,7 @@ static struct irq_chip sun6i_r_intc_edge = {
 	.irq_set_type		= sun6i_r_intc_irq_set_type,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
@@ -129,6 +149,7 @@ static struct irq_chip sun6i_r_intc_level = {
 	.irq_set_type		= sun6i_r_intc_irq_set_type,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_EOI_THREADED,
@@ -170,6 +191,34 @@ static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int sun6i_r_intc_suspend(void)
+{
+	/* All wake IRQs are enabled during system sleep. */
+	writel_relaxed(atomic_read(&wake_mask), base + SUN6I_R_INTC_ENABLE);
+
+	return 0;
+}
+
+static void sun6i_r_intc_resume(void)
+{
+	/* Only the NMI is relevant during normal operation. */
+	writel_relaxed(NMI_HWIRQ_BIT, base + SUN6I_R_INTC_ENABLE);
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
@@ -211,6 +260,8 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 	writel_relaxed(NMI_HWIRQ_BIT, base + SUN6I_R_INTC_PENDING);
 	writel_relaxed(NMI_HWIRQ_BIT, base + SUN6I_R_INTC_ENABLE);
 
+	sun6i_r_intc_syscore_init();
+
 	return 0;
 }
 IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
-- 
2.24.1

