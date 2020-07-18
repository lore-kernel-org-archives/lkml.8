Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D50B2074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7sz0tga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgGRAGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGRAGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:06:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F3C0619D4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:43 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r25so7436044qtj.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lZV5LJ2D+3d5c6Q1RBEHt+umrHrDQPYow79ie/sqGoo=;
        b=f7sz0tgaClL14NdE7pJITVXQTObuFddTT6emyjS08ZgPsh5vLij6r8Zr0bdr8nmJRz
         HLP+EdNTkpLXbcL5dYajxBaRik3Dw2bErrgNidiApzncVpOsTCt+bfjEJ1gVY0MTCIK3
         0Zj3UzcABE83gfPsE1DrmmHS203F++mP+Ysu29KDC3/FnR95F8F0v9dVnsnN06FinAji
         R+vJDBGn3CsQ/h9XHm9VCIoUqnaEcHwJCaJu1fQd1sLUv6WgSaZZBj2zHrk05K23z0/T
         ByzcbObDgfus2zOMoNbaOXd15ySmQzPlMHtexdlMoydVKP8BFo62ExGirBtJUN7Nx3Ji
         FLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lZV5LJ2D+3d5c6Q1RBEHt+umrHrDQPYow79ie/sqGoo=;
        b=tRjoej4EB5iHlO6z2Q1P7WWp7TuPzIQB9WB+UOY1dOH1Lc1KxXso1dPNtyjcIMNOsc
         o3ZUp+junmzxK2FVpmLUQaLHO6mdo73iX9UP0Ul4bi8TzmEh1sVuuY5G4CkuLx1rLZby
         zACWWgdTai6BBt1b+yR9y4pUzzYxsrN1YKJ6doNbaFTEdCpgoCPy9N8kRorEU4DWm7WS
         oZtxDgev3pJA+7TnlYvwtzjMoC6tIOomhjNYkvT5wm7mC4jMnyF3q2WpIIr83rhr993K
         AjbW6r6qk9PRGZz5w6SPvNrtcvtyOjldhBA0xvDFtG/vKCKIbtXqmaQtgfslYAVhBJti
         5/wA==
X-Gm-Message-State: AOAM530gMXij/fAQaXTl4/iY2vmlvVwvVl6zkcrxYAhiA9gdhZeAVGzu
        4FMS7XQNUK2SlHzymwbOYaGRSertXyZpw9I=
X-Google-Smtp-Source: ABdhPJxJ7FCreyEpq5UXSDryBArlKlpzEz07QUPpT9WWRT3kKQejA5X0pbgSsPqzz1OI15cxmhDDFZUj4PyeZpY=
X-Received: by 2002:a05:6214:8f4:: with SMTP id dr20mr10977278qvb.228.1595030802697;
 Fri, 17 Jul 2020 17:06:42 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:06:34 -0700
In-Reply-To: <20200718000637.3632841-1-saravanak@google.com>
Message-Id: <20200718000637.3632841-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 1/4] irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and
 IRQCHIP_MATCH helper macros
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling an irqchip driver as a platform driver needs to bunch of
things to be done right:
- Making sure the parent domain is initialized first
- Making sure the device can't be unbound from sysfs
- Disallowing module unload if it's built as a module
- Finding the parent node
- Etc.

Instead of trying to make sure all future irqchip platform drivers get
this right, provide boilerplate macros that take care of all of this.

An example use would look something like this. Where acme_foo_init and
acme_bar_init are similar to what would be passed to IRQCHIP_DECLARE.

IRQCHIP_PLATFORM_DRIVER_BEGIN(acme_irq)
IRQCHIP_MATCH("acme,foo", acme_foo_init)
IRQCHIP_MATCH("acme,bar", acme_bar_init)
IRQCHIP_PLATFORM_DRIVER_END(acme_irq)

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irqchip.c | 29 +++++++++++++++++++++++++++++
 include/linux/irqchip.h   | 23 +++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 2b35e68bea82..1bb0e36c2bf3 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -10,8 +10,10 @@
 
 #include <linux/acpi.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
+#include <linux/platform_device.h>
 
 /*
  * This special of_device_id is the sentinel at the end of the
@@ -29,3 +31,30 @@ void __init irqchip_init(void)
 	of_irq_init(__irqchip_of_table);
 	acpi_probe_device_table(irqchip);
 }
+
+int platform_irqchip_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *par_np = of_irq_find_parent(np);
+	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
+
+	if (!irq_init_cb)
+		return -EINVAL;
+
+	if (par_np == np)
+		par_np = NULL;
+
+	/*
+	 * If there's a parent interrupt controller and  none of the parent irq
+	 * domains have been registered, that means the parent interrupt
+	 * controller has not been initialized yet.  it's not time for this
+	 * interrupt controller to initialize. So, defer probe of this
+	 * interrupt controller. The actual initialization callback of this
+	 * interrupt controller can check for specific domains as necessary.
+	 */
+	if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
+		return -EPROBE_DEFER;
+
+	return irq_init_cb(np, par_np);
+}
+EXPORT_SYMBOL_GPL(platform_irqchip_probe);
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 447f22880a69..8e754d8b8155 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 
 /*
  * This macro must be used by the different irqchip drivers to declare
@@ -26,6 +27,28 @@
  */
 #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
 
+extern int platform_irqchip_probe(struct platform_device *pdev);
+
+#define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
+static const struct of_device_id drv_name##_irqchip_match_table[] = {
+
+#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+	{},								\
+};									\
+MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
+static struct platform_driver drv_name##_driver = {		\
+	.probe  = platform_irqchip_probe,				\
+	.driver = {							\
+		.name = #drv_name,					\
+		.owner = THIS_MODULE,					\
+		.of_match_table = drv_name##_irqchip_match_table,	\
+		.suppress_bind_attrs = true,				\
+	},								\
+};									\
+builtin_platform_driver(drv_name##_driver)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their version and their initialization function.
-- 
2.28.0.rc0.105.gf9edc3c819-goog

