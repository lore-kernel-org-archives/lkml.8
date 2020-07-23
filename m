Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD4C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA8420709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1cZNJwr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mBsyb73p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGWTKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgGWTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78BC0619DC;
        Thu, 23 Jul 2020 12:09:43 -0700 (PDT)
Date:   Thu, 23 Jul 2020 19:09:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b5r8C8OA+wELxVBiLJsNuUQpQ2AlGxYKcEwqg6dH3s=;
        b=h1cZNJwryqs/xiW6lriwZfcyqrX5uDwmqtEaBBSD+jZvKnAAAxPz0wyetI6malvgMvIUxT
        UZT35tJqJPlVJzwGBvnGQ6Sb4ZBUSLuMdWr6KtzrfFV90rm8WxfDF6WniPFj4w60gi4Rib
        KiNmaLQeWmvBm8r+xVgOMRdggtC1auVNK4CxM6sE77SRFRb3oz0IiNIbssJX3ILE4Bpfcb
        J6niY7skVN3fpL1STmIODvcF4z5JmOewA1O7MND86Yc4OkJETzqDHi55DKsLFLLSPSM/Zf
        wpbgaV0XfhQqAdolgHgeuZ5cTNP668CriFvoD5JXAC+TWRH9ShNAs4PuySeRBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b5r8C8OA+wELxVBiLJsNuUQpQ2AlGxYKcEwqg6dH3s=;
        b=mBsyb73pM9lwgRtjo/BnDoXogj95q81WyXps0F4f2hsKhnT9aUAKPODqSuOIdPFn0ghsCg
        y2Ev8RSjClbuvUBw==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Add high resolution
 timer support for SMP/SMT.
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Boddie <paul@boddie.org.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        zhouyanjie@wanyeetech.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200624170749.31762-2-zhouyanjie@wanyeetech.com>
References: <20200624170749.31762-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <159553138109.4006.17640169514706530461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f19d838d08fc1cde742dedafa776a865e1682e63
Gitweb:        https://git.kernel.org/tip/f19d838d08fc1cde742dedafa776a865e16=
82e63
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Thu, 25 Jun 2020 01:07:49 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:57:19 +02:00

clocksource/drivers/ingenic: Add high resolution timer support for SMP/SMT.

Enable clock event handling on per CPU core basis. Make sure that
interrupts raised on the first core execute event handlers on the
correct CPU core. This driver is required by Ingenic processors
that support SMP/SMT, such as JZ4780 and X2000.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Tested-by: Paul Boddie <paul@boddie.org.uk>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200624170749.31762-2-zhouyanjie@wanyeetech.=
com
---
 drivers/clocksource/ingenic-timer.c | 182 ++++++++++++++++++---------
 1 file changed, 124 insertions(+), 58 deletions(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingeni=
c-timer.c
index 4963336..58fd918 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * JZ47xx SoCs TCU IRQ driver
+ * Ingenic SoCs TCU IRQ driver
  * Copyright (C) 2019 Paul Cercueil <paul@crapouillou.net>
+ * Copyright (C) 2020 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@=
wanyeetech.com>
  */
=20
 #include <linux/bitops.h>
@@ -15,24 +16,35 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched_clock.h>
=20
 #include <dt-bindings/clock/ingenic,tcu.h>
=20
+static DEFINE_PER_CPU(call_single_data_t, ingenic_cevt_csd);
+
 struct ingenic_soc_info {
 	unsigned int num_channels;
 };
=20
+struct ingenic_tcu_timer {
+	unsigned int cpu;
+	unsigned int channel;
+	struct clock_event_device cevt;
+	struct clk *clk;
+	char name[8];
+};
+
 struct ingenic_tcu {
 	struct regmap *map;
-	struct clk *timer_clk, *cs_clk;
-	unsigned int timer_channel, cs_channel;
-	struct clock_event_device cevt;
+	struct device_node *np;
+	struct clk *cs_clk;
+	unsigned int cs_channel;
 	struct clocksource cs;
-	char name[4];
 	unsigned long pwm_channels_mask;
+	struct ingenic_tcu_timer timers[];
 };
=20
 static struct ingenic_tcu *ingenic_tcu;
@@ -52,16 +64,24 @@ static u64 notrace ingenic_tcu_timer_cs_read(struct clock=
source *cs)
 	return ingenic_tcu_timer_read();
 }
=20
-static inline struct ingenic_tcu *to_ingenic_tcu(struct clock_event_device *=
evt)
+static inline struct ingenic_tcu *
+to_ingenic_tcu(struct ingenic_tcu_timer *timer)
+{
+	return container_of(timer, struct ingenic_tcu, timers[timer->cpu]);
+}
+
+static inline struct ingenic_tcu_timer *
+to_ingenic_tcu_timer(struct clock_event_device *evt)
 {
-	return container_of(evt, struct ingenic_tcu, cevt);
+	return container_of(evt, struct ingenic_tcu_timer, cevt);
 }
=20
 static int ingenic_tcu_cevt_set_state_shutdown(struct clock_event_device *ev=
t)
 {
-	struct ingenic_tcu *tcu =3D to_ingenic_tcu(evt);
+	struct ingenic_tcu_timer *timer =3D to_ingenic_tcu_timer(evt);
+	struct ingenic_tcu *tcu =3D to_ingenic_tcu(timer);
=20
-	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
+	regmap_write(tcu->map, TCU_REG_TECR, BIT(timer->channel));
=20
 	return 0;
 }
@@ -69,27 +89,40 @@ static int ingenic_tcu_cevt_set_state_shutdown(struct clo=
ck_event_device *evt)
 static int ingenic_tcu_cevt_set_next(unsigned long next,
 				     struct clock_event_device *evt)
 {
-	struct ingenic_tcu *tcu =3D to_ingenic_tcu(evt);
+	struct ingenic_tcu_timer *timer =3D to_ingenic_tcu_timer(evt);
+	struct ingenic_tcu *tcu =3D to_ingenic_tcu(timer);
=20
 	if (next > 0xffff)
 		return -EINVAL;
=20
-	regmap_write(tcu->map, TCU_REG_TDFRc(tcu->timer_channel), next);
-	regmap_write(tcu->map, TCU_REG_TCNTc(tcu->timer_channel), 0);
-	regmap_write(tcu->map, TCU_REG_TESR, BIT(tcu->timer_channel));
+	regmap_write(tcu->map, TCU_REG_TDFRc(timer->channel), next);
+	regmap_write(tcu->map, TCU_REG_TCNTc(timer->channel), 0);
+	regmap_write(tcu->map, TCU_REG_TESR, BIT(timer->channel));
=20
 	return 0;
 }
=20
+static void ingenic_per_cpu_event_handler(void *info)
+{
+	struct clock_event_device *cevt =3D (struct clock_event_device *) info;
+
+	cevt->event_handler(cevt);
+}
+
 static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
 {
-	struct clock_event_device *evt =3D dev_id;
-	struct ingenic_tcu *tcu =3D to_ingenic_tcu(evt);
+	struct ingenic_tcu_timer *timer =3D dev_id;
+	struct ingenic_tcu *tcu =3D to_ingenic_tcu(timer);
+	call_single_data_t *csd;
=20
-	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
+	regmap_write(tcu->map, TCU_REG_TECR, BIT(timer->channel));
=20
-	if (evt->event_handler)
-		evt->event_handler(evt);
+	if (timer->cevt.event_handler) {
+		csd =3D &per_cpu(ingenic_cevt_csd, timer->cpu);
+		csd->info =3D (void *) &timer->cevt;
+		csd->func =3D ingenic_per_cpu_event_handler;
+		smp_call_function_single_async(timer->cpu, csd);
+	}
=20
 	return IRQ_HANDLED;
 }
@@ -105,64 +138,66 @@ static struct clk * __init ingenic_tcu_get_clock(struct=
 device_node *np, int id)
 	return of_clk_get_from_provider(&args);
 }
=20
-static int __init ingenic_tcu_timer_init(struct device_node *np,
-					 struct ingenic_tcu *tcu)
+static int ingenic_tcu_setup_cevt(unsigned int cpu)
 {
-	unsigned int timer_virq, channel =3D tcu->timer_channel;
+	struct ingenic_tcu *tcu =3D ingenic_tcu;
+	struct ingenic_tcu_timer *timer =3D &tcu->timers[cpu];
+	unsigned int timer_virq;
 	struct irq_domain *domain;
 	unsigned long rate;
 	int err;
=20
-	tcu->timer_clk =3D ingenic_tcu_get_clock(np, channel);
-	if (IS_ERR(tcu->timer_clk))
-		return PTR_ERR(tcu->timer_clk);
+	timer->clk =3D ingenic_tcu_get_clock(tcu->np, timer->channel);
+	if (IS_ERR(timer->clk))
+		return PTR_ERR(timer->clk);
=20
-	err =3D clk_prepare_enable(tcu->timer_clk);
+	err =3D clk_prepare_enable(timer->clk);
 	if (err)
 		goto err_clk_put;
=20
-	rate =3D clk_get_rate(tcu->timer_clk);
+	rate =3D clk_get_rate(timer->clk);
 	if (!rate) {
 		err =3D -EINVAL;
 		goto err_clk_disable;
 	}
=20
-	domain =3D irq_find_host(np);
+	domain =3D irq_find_host(tcu->np);
 	if (!domain) {
 		err =3D -ENODEV;
 		goto err_clk_disable;
 	}
=20
-	timer_virq =3D irq_create_mapping(domain, channel);
+	timer_virq =3D irq_create_mapping(domain, timer->channel);
 	if (!timer_virq) {
 		err =3D -EINVAL;
 		goto err_clk_disable;
 	}
=20
-	snprintf(tcu->name, sizeof(tcu->name), "TCU");
+	snprintf(timer->name, sizeof(timer->name), "TCU%u", timer->channel);
=20
 	err =3D request_irq(timer_virq, ingenic_tcu_cevt_cb, IRQF_TIMER,
-			  tcu->name, &tcu->cevt);
+			  timer->name, timer);
 	if (err)
 		goto err_irq_dispose_mapping;
=20
-	tcu->cevt.cpumask =3D cpumask_of(smp_processor_id());
-	tcu->cevt.features =3D CLOCK_EVT_FEAT_ONESHOT;
-	tcu->cevt.name =3D tcu->name;
-	tcu->cevt.rating =3D 200;
-	tcu->cevt.set_state_shutdown =3D ingenic_tcu_cevt_set_state_shutdown;
-	tcu->cevt.set_next_event =3D ingenic_tcu_cevt_set_next;
+	timer->cpu =3D smp_processor_id();
+	timer->cevt.cpumask =3D cpumask_of(smp_processor_id());
+	timer->cevt.features =3D CLOCK_EVT_FEAT_ONESHOT;
+	timer->cevt.name =3D timer->name;
+	timer->cevt.rating =3D 200;
+	timer->cevt.set_state_shutdown =3D ingenic_tcu_cevt_set_state_shutdown;
+	timer->cevt.set_next_event =3D ingenic_tcu_cevt_set_next;
=20
-	clockevents_config_and_register(&tcu->cevt, rate, 10, 0xffff);
+	clockevents_config_and_register(&timer->cevt, rate, 10, 0xffff);
=20
 	return 0;
=20
 err_irq_dispose_mapping:
 	irq_dispose_mapping(timer_virq);
 err_clk_disable:
-	clk_disable_unprepare(tcu->timer_clk);
+	clk_disable_unprepare(timer->clk);
 err_clk_put:
-	clk_put(tcu->timer_clk);
+	clk_put(timer->clk);
 	return err;
 }
=20
@@ -238,10 +273,12 @@ static int __init ingenic_tcu_init(struct device_node *=
np)
 {
 	const struct of_device_id *id =3D of_match_node(ingenic_tcu_of_match, np);
 	const struct ingenic_soc_info *soc_info =3D id->data;
+	struct ingenic_tcu_timer *timer;
 	struct ingenic_tcu *tcu;
 	struct regmap *map;
+	unsigned int cpu;
+	int ret, last_bit =3D -1;
 	long rate;
-	int ret;
=20
 	of_node_clear_flag(np, OF_POPULATED);
=20
@@ -249,17 +286,23 @@ static int __init ingenic_tcu_init(struct device_node *=
np)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
=20
-	tcu =3D kzalloc(sizeof(*tcu), GFP_KERNEL);
+	tcu =3D kzalloc(struct_size(tcu, timers, num_possible_cpus()),
+		      GFP_KERNEL);
 	if (!tcu)
 		return -ENOMEM;
=20
-	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	tcu->pwm_channels_mask =3D GENMASK(soc_info->num_channels - 1, 2);
+	/*
+	 * Enable all TCU channels for PWM use by default except channels 0/1,
+	 * and channel 2 if target CPU is JZ4780/X2000 and SMP is selected.
+	 */
+	tcu->pwm_channels_mask =3D GENMASK(soc_info->num_channels - 1,
+					 num_possible_cpus() + 1);
 	of_property_read_u32(np, "ingenic,pwm-channels-mask",
 			     (u32 *)&tcu->pwm_channels_mask);
=20
-	/* Verify that we have at least two free channels */
-	if (hweight8(tcu->pwm_channels_mask) > soc_info->num_channels - 2) {
+	/* Verify that we have at least num_possible_cpus() + 1 free channels */
+	if (hweight8(tcu->pwm_channels_mask) >
+			soc_info->num_channels - num_possible_cpus() + 1) {
 		pr_crit("%s: Invalid PWM channel mask: 0x%02lx\n", __func__,
 			tcu->pwm_channels_mask);
 		ret =3D -EINVAL;
@@ -267,13 +310,22 @@ static int __init ingenic_tcu_init(struct device_node *=
np)
 	}
=20
 	tcu->map =3D map;
+	tcu->np =3D np;
 	ingenic_tcu =3D tcu;
=20
-	tcu->timer_channel =3D find_first_zero_bit(&tcu->pwm_channels_mask,
-						 soc_info->num_channels);
+	for (cpu =3D 0; cpu < num_possible_cpus(); cpu++) {
+		timer =3D &tcu->timers[cpu];
+
+		timer->cpu =3D cpu;
+		timer->channel =3D find_next_zero_bit(&tcu->pwm_channels_mask,
+						  soc_info->num_channels,
+						  last_bit + 1);
+		last_bit =3D timer->channel;
+	}
+
 	tcu->cs_channel =3D find_next_zero_bit(&tcu->pwm_channels_mask,
 					     soc_info->num_channels,
-					     tcu->timer_channel + 1);
+					     last_bit + 1);
=20
 	ret =3D ingenic_tcu_clocksource_init(np, tcu);
 	if (ret) {
@@ -281,9 +333,13 @@ static int __init ingenic_tcu_init(struct device_node *n=
p)
 		goto err_free_ingenic_tcu;
 	}
=20
-	ret =3D ingenic_tcu_timer_init(np, tcu);
-	if (ret)
+	/* Setup clock events on each CPU core */
+	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "Ingenic XBurst: online",
+				ingenic_tcu_setup_cevt, NULL);
+	if (ret < 0) {
+		pr_crit("%s: Unable to start CPU timers: %d\n", __func__, ret);
 		goto err_tcu_clocksource_cleanup;
+	}
=20
 	/* Register the sched_clock at the end as there's no way to undo it */
 	rate =3D clk_get_rate(tcu->cs_clk);
@@ -315,28 +371,38 @@ static int __init ingenic_tcu_probe(struct platform_dev=
ice *pdev)
 static int __maybe_unused ingenic_tcu_suspend(struct device *dev)
 {
 	struct ingenic_tcu *tcu =3D dev_get_drvdata(dev);
+	unsigned int cpu;
=20
 	clk_disable(tcu->cs_clk);
-	clk_disable(tcu->timer_clk);
+
+	for (cpu =3D 0; cpu < num_online_cpus(); cpu++)
+		clk_disable(tcu->timers[cpu].clk);
+
 	return 0;
 }
=20
 static int __maybe_unused ingenic_tcu_resume(struct device *dev)
 {
 	struct ingenic_tcu *tcu =3D dev_get_drvdata(dev);
+	unsigned int cpu;
 	int ret;
=20
-	ret =3D clk_enable(tcu->timer_clk);
-	if (ret)
-		return ret;
+	for (cpu =3D 0; cpu < num_online_cpus(); cpu++) {
+		ret =3D clk_enable(tcu->timers[cpu].clk);
+		if (ret)
+			goto err_timer_clk_disable;
+	}
=20
 	ret =3D clk_enable(tcu->cs_clk);
-	if (ret) {
-		clk_disable(tcu->timer_clk);
-		return ret;
-	}
+	if (ret)
+		goto err_timer_clk_disable;
=20
 	return 0;
+
+err_timer_clk_disable:
+	for (; cpu > 0; cpu--)
+		clk_disable(tcu->timers[cpu - 1].clk);
+	return ret;
 }
=20
 static const struct dev_pm_ops __maybe_unused ingenic_tcu_pm_ops =3D {
