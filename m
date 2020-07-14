Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5D922453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cQSVL88A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGNPEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:04:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:04:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m16so5940428pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69EodTdWYHlEAq5QPFBw8533OrGBXqn7j8SYE13YOZs=;
        b=cQSVL88ANjkwN4gGvrPeJaPo6cD8kadt+RcL4kRtj568HiFgABjsmINlN7cj7LpxME
         7cl3m4SHsKCc3FSaiHNy+jsW+xKTCF//O4QSQujOITFjxZNfj7URCPQ20mjS97UyRgCD
         2yayid8YdwA9tPHqqkEh3DRab59yP6eJjxYLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69EodTdWYHlEAq5QPFBw8533OrGBXqn7j8SYE13YOZs=;
        b=cZZt9pyxeGHOovXU48vEhelV+akrUBurLYv5oODIQszGjysIc5EWBX6W7WAe6XQs+S
         9MOOZe7f39lQbEPXBaiSfaaUa4j5W+aqx9jUKfjQFMw0g2zc5pBXZOUtW/l7DH4IB63p
         mNr7nJ7csXysVC78hheS3Q1q8y7qvls1S5Od2K9zsgEFEAbHXt188IwWcZfbDx2d3U7P
         xj9L90B5B0T/2eQ7NRKA2Ky5xG0Y5RhBv3M3YEeMt0AaOSCH0g1sbcitd9wwQEBQ8UxZ
         O1tFilW2rX8aXDzCNk4PvTas0tsk26IY1iQ9H7kunA9xBF8b1OoUwfF74Kg/wcTqG8Iv
         W+LA==
X-Gm-Message-State: AOAM530w6y77w7zui6qKrSlj2+nNekZfP/I9NzwoEsq2CwobkuQMYID1
        Z7q4Z/MC5WMjo9ui7nISWfcs8Q==
X-Google-Smtp-Source: ABdhPJwiBC+kV8XEGEiCll0NbA71iPHEzbM0ilNZUq825EkI66xmzeU4QYutwOVwCVoe6Yi5pK69YA==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr4353185plk.321.1594739087887;
        Tue, 14 Jul 2020 08:04:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id n18sm18849700pfd.99.2020.07.14.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:04:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org
Cc:     rnayak@codeaurora.org, mkshah@codeaurora.org,
        Marc Zyngier <maz@kernel.org>, ilina@codeaurora.org,
        cychiang@chromium.org, swboyd@chromium.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pinctrl: qcom: Handle broken/missing PDC dual edge IRQs on sc7180
Date:   Tue, 14 Jul 2020 08:04:17 -0700
Message-Id: <20200714080254.v3.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on how you look at it, you can either say that:
a) There is a PDC hardware issue (with the specific IP rev that exists
   on sc7180) that causes the PDC not to work properly when configured
   to handle dual edges.
b) The dual edge feature of the PDC hardware was only added in later
   HW revisions and thus isn't in all hardware.

Regardless of how you look at it, let's work around the lack of dual
edge support by only ever letting our parent see requests for single
edge interrupts on affected hardware.

NOTE: it's possible that a driver requesting a dual edge interrupt
might get several edges coalesced into a single IRQ.  For instance if
a line starts low and then goes high and low again, the driver that
requested the IRQ is not guaranteed to be called twice.  However, it
is guaranteed that once the driver's interrupt handler starts running
its first instruction that any new edges coming in will cause the
interrupt to fire again.  This is relatively commonplace for dual-edge
gpio interrupts (many gpio controllers require software to emulate
dual edge with single edge) so client drivers should be setup to
handle it.

Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
As far as I can tell everything here should work and the limited
testing I'm able to give it shows that, in fact, I can detect both
edges.

I specifically left off Reviewed-by and Tested-by tags from v2 becuase
I felt that the implementation had changed just enough to invalidate
previous reviews / testing.  Hopefully it's not too much of a hassle
for folks to re-review and re-test.

Changes in v3:
- Rate limit the warning.

Changes in v2:
- Use handle_fasteoi_ack_irq() and switch edges in the Ack now.
- If we change types, switch back to the normal handle_fasteoi_irq().
- No extra locking.
- Properly print an error if we hit 100 loops w/ no stability.
- Beefed up the commit message.

 drivers/pinctrl/qcom/Kconfig          |  2 +
 drivers/pinctrl/qcom/pinctrl-msm.c    | 74 ++++++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h    |  4 ++
 drivers/pinctrl/qcom/pinctrl-sc7180.c |  1 +
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index ff1ee159dca2..f8ff30cdafa6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -7,6 +7,8 @@ config PINCTRL_MSM
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 
 config PINCTRL_APQ8064
 	tristate "Qualcomm APQ8064 pin controller driver"
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83b7d64bc4c1..c322f30a2064 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -832,6 +832,52 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	msm_gpio_irq_clear_unmask(d, false);
 }
 
+/**
+ * msm_gpio_update_dual_edge_parent() - Prime next edge for IRQs handled by parent.
+ * @d: The irq dta.
+ *
+ * This is much like msm_gpio_update_dual_edge_pos() but for IRQs that are
+ * normally handled by the parent irqchip.  The logic here is slightly
+ * different due to what's easy to do with our parent, but in principle it's
+ * the same.
+ */
+static void msm_gpio_update_dual_edge_parent(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
+	int loop_limit = 100;
+	unsigned int val;
+	unsigned int type;
+
+	/* Read the value and make a guess about what edge we need to catch */
+	val = msm_readl_io(pctrl, g) & BIT(g->in_bit);
+	type = val ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+
+	do {
+		/* Set the parent to catch the next edge */
+		irq_chip_set_type_parent(d, type);
+
+		/*
+		 * Possibly the line changed between when we last read "val"
+		 * (and decided what edge we needed) and when set the edge.
+		 * If the value didn't change (or changed and then changed
+		 * back) then we're done.
+		 */
+		val = msm_readl_io(pctrl, g) & BIT(g->in_bit);
+		if (type == IRQ_TYPE_EDGE_RISING) {
+			if (!val)
+				return;
+			type = IRQ_TYPE_EDGE_FALLING;
+		} else if (type == IRQ_TYPE_EDGE_FALLING) {
+			if (val)
+				return;
+			type = IRQ_TYPE_EDGE_RISING;
+		}
+	} while (loop_limit-- > 0);
+	dev_warn_once(pctrl->dev, "dual-edge irq failed to stabilize\n");
+}
+
 static void msm_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -840,8 +886,11 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	if (test_bit(d->hwirq, pctrl->skip_wake_irqs))
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs)) {
+		if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
+			msm_gpio_update_dual_edge_parent(d);
 		return;
+	}
 
 	g = &pctrl->soc->groups[d->hwirq];
 
@@ -860,6 +909,17 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
+						       unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+
+	return type == IRQ_TYPE_EDGE_BOTH &&
+	       pctrl->soc->wakeirq_dual_edge_errata && d->parent_data &&
+	       test_bit(d->hwirq, pctrl->skip_wake_irqs);
+}
+
 static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -868,11 +928,21 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	unsigned long flags;
 	u32 val;
 
+	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
+		set_bit(d->hwirq, pctrl->dual_edge_irqs);
+		irq_set_handler_locked(d, handle_fasteoi_ack_irq);
+		msm_gpio_update_dual_edge_parent(d);
+		return 0;
+	}
+
 	if (d->parent_data)
 		irq_chip_set_type_parent(d, type);
 
-	if (test_bit(d->hwirq, pctrl->skip_wake_irqs))
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs)) {
+		clear_bit(d->hwirq, pctrl->dual_edge_irqs);
+		irq_set_handler_locked(d, handle_fasteoi_irq);
 		return 0;
+	}
 
 	g = &pctrl->soc->groups[d->hwirq];
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 9452da18a78b..7486fe08eb9b 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -113,6 +113,9 @@ struct msm_gpio_wakeirq_map {
  * @pull_no_keeper: The SoC does not support keeper bias.
  * @wakeirq_map:    The map of wakeup capable GPIOs and the pin at PDC/MPM
  * @nwakeirq_map:   The number of entries in @wakeirq_map
+ * @wakeirq_dual_edge_errata: If true then GPIOs using the wakeirq_map need
+ *                            to be aware that their parent can't handle dual
+ *                            edge interrupts.
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -128,6 +131,7 @@ struct msm_pinctrl_soc_data {
 	const int *reserved_gpios;
 	const struct msm_gpio_wakeirq_map *wakeirq_map;
 	unsigned int nwakeirq_map;
+	bool wakeirq_dual_edge_errata;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
index 1b6465a882f2..1d9acad3c1ce 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7180.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
@@ -1147,6 +1147,7 @@ static const struct msm_pinctrl_soc_data sc7180_pinctrl = {
 	.ntiles = ARRAY_SIZE(sc7180_tiles),
 	.wakeirq_map = sc7180_pdc_map,
 	.nwakeirq_map = ARRAY_SIZE(sc7180_pdc_map),
+	.wakeirq_dual_edge_errata = true,
 };
 
 static int sc7180_pinctrl_probe(struct platform_device *pdev)
-- 
2.27.0.389.gc38d7665816-goog

