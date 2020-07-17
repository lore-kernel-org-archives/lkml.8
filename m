Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD06C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442BA2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edzH6w1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGQCow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgGQCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:44:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47102C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:44:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i62so9673746ybc.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2BxjzP72iQdxP7BBImWs20Rvt3buz2LvW5kNpRsHJrc=;
        b=edzH6w1tmEp4FV+8F+FvzJxmwPfMcqxN+r0PndFf2NFYuR596Xt4jVy1S/lpZiFYo5
         ae7FEfCSqzYLDi7YIWgUMuCeJjkPUB+UPbluOzn0kLYVk6RjxL/cpgkXDb9qWKzFLPPC
         cRvAHzNnG6mJFDoIVlSSFsd68wZbcYFmytYJ2yBV0rZavd1olwPZZqP37WSypAmsKBQS
         Wbf4R/F3y3DxQb2LBvm+Y3KugnDSpyOIGmEwiTBG2DnOFsT4ywnYvxv0y/PE7n7WnJJK
         V6y75QybSjrtKuOqY8ds0cCJwlLHynUw1YbaNSXcvzxI8skPsfGKq43PzLdrLvL9qVe+
         QboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2BxjzP72iQdxP7BBImWs20Rvt3buz2LvW5kNpRsHJrc=;
        b=Ztkayy9Z9iPybbpVsIR1m1D23DOI4bmh289vtgyKFemVYe7LCq9RUbC+npUt5OqIUz
         vZqabjD2eV/5rijoq+DTzkgTViglhKFKGdW8DuaSSVs0bHWqqC1f5NDjuWl2BFFFDwsZ
         gX0wFYhowQf+FQ/v9PS/0wotBs/CnO/m75V4nZI/hq6KVL4i+vw9TIeQCDwZi306dwuE
         84/B3knST+MQZ5/pCimprh0Rn8jqkgr7iMkCSJt9S24nGt0TwvTydNas8OfgHqNwwWBn
         yLQAriHcr8aHnX85S2Y3ay9HYzNQM2//Bl8mJbQj9XKl9tBejwHdfmU85DvZGw2Gw7yN
         NhOw==
X-Gm-Message-State: AOAM531WOFXVyN0save3jBlt3I460yUOEfZfRxRbEPcqfYhQ+g9dP7zA
        1NQF5CieKUlrQPIE86Iuy0MNhTdOyP4cisY=
X-Google-Smtp-Source: ABdhPJxSbi/so9LC9Hx2K/NJBPQpWfhio3DksqcrkFYd3YFZSePPAWPP+AQatb0XaXyze7GjIuJH4VCknBdbDlE=
X-Received: by 2002:a25:73c2:: with SMTP id o185mr10556755ybc.169.1594953891393;
 Thu, 16 Jul 2020 19:44:51 -0700 (PDT)
Date:   Thu, 16 Jul 2020 19:44:47 -0700
Message-Id: <20200717024447.3128361-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and
 IRQCHIP_MATCH helper macros
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

IRQCHIP_PLATFORM_DRIVER_BEGIN
IRQCHIP_MATCH(foo, "acme,foo", acme_foo_init)
IRQCHIP_MATCH(bar, "acme,bar", acme_bar_init)
IRQCHIP_PLATFORM_DRIVER_END(acme_irq)

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irqchip.c | 22 ++++++++++++++++++++++
 include/linux/irqchip.h   | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 2b35e68bea82..236ea793f01c 100644
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
@@ -29,3 +31,23 @@ void __init irqchip_init(void)
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
+	/* If there's a parent irqchip, make sure it has been initialized. */
+	if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
+		return -EPROBE_DEFER;
+
+	return irq_init_cb(np, par_np);
+}
+EXPORT_SYMBOL_GPL(platform_irqchip_probe);
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 950e4b2458f0..6d5eba7cbbb7 100644
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
+#define IRQCHIP_PLATFORM_DRIVER_BEGIN \
+static const struct of_device_id __irqchip_match_table[] = {
+
+#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)		\
+	{},						\
+};							\
+MODULE_DEVICE_TABLE(of, __irqchip_match_table);		\
+static struct platform_driver drv_name##_driver = {	\
+	.probe  = platform_irqchip_probe,		\
+	.driver = {					\
+		.name = #drv_name,			\
+		.owner = THIS_MODULE,			\
+		.of_match_table = __irqchip_match_table,\
+		.suppress_bind_attrs = true,		\
+	},						\
+};							\
+builtin_platform_driver(drv_name##_driver)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their version and their initialization function.
-- 
2.28.0.rc0.105.gf9edc3c819-goog

