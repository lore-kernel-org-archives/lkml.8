Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B5DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 04:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62478206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 04:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="um5boDh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgDKE7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 00:59:23 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49287 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgDKE7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 00:59:23 -0400
Received: by mail-pl1-f202.google.com with SMTP id h2so3159668pls.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rzrt/FoFajeNul5e6RKZ9bdiWFh9FMdz7P9N92TBcIU=;
        b=um5boDh3v8PMIinvdr8HoftI7Re7PPSiN83y2APW631OjWG8ej+wWL7SOVKmD87L+H
         hCb5qn7Ve4C1IpLU6s0cs+UdE3Ohd/Wnxpv4k1YfoX8CTsWImsJ47YxRSMe7YpLgUfVL
         KcKP7qyK6HjVA0OYk4CZszeVet5pGJjsKlYhsA/IR8YETUziVlbleY7uLqi7GoN7FWUQ
         OrUvQPglEo8wvzYUvdspVjlnlfOWuRpdFSAyf4KpCkJpn98UaM1RoE1bZD6sTC+GB3hJ
         1oAvZURw/Mcr7ekbhbCclNAJVO2V79S7yFIjaMozds83xJgQf8bU0Z1C1apzJ4K2zUJD
         qEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rzrt/FoFajeNul5e6RKZ9bdiWFh9FMdz7P9N92TBcIU=;
        b=c17yfQyYlLnRBIj259f36apL52MK/V/zwIeQPC3xYTv0y6c9Mewl+n0aEmrJV1RifD
         dPu6+Wjzvvp7IaWwzcynivS6jazxaYO7BqWXhPYwCv2E3me6KMGBHL8B6dZZpYpJ8dLT
         w+CvB91ROeowwo2QSWD6yrJ6qWLrGrhhri/p+I4iJT52tbmHhYbEKpA6EVZl3BJeEVgn
         0P6PSibIhHQzqGnrxatRcNZU/x2CjO/u6X+hXoEvza1Hj5Y3dqvcRk/CbIAVHcfLF+sy
         GSwo8rxjHbSZlyzn5n5lwzY9hrkeSKlSgKOFr7W9Jyqt20P3OQN0HhDVi26Z6ryI8oUT
         YDZg==
X-Gm-Message-State: AGi0PuZv54LDNMTbdarKC0381ifz+Qf3tSIfeestmuAPjFYEkghP8YEl
        zwtorWOvE2wPiHvKN+7dH76KlHyvRM4WU3k=
X-Google-Smtp-Source: APiQypItLK0dwvNMQYCGNjmPWr7QyeDZdSCP1GzUI9bcFbK0w+HtiG/GB/HK4cW87r7amYkcJlAtNptrZRa4dEY=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr9446696pjs.150.1586581162582;
 Fri, 10 Apr 2020 21:59:22 -0700 (PDT)
Date:   Fri, 10 Apr 2020 21:59:18 -0700
Message-Id: <20200411045918.179455-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper macros
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper macros IRQCHIP_MODULE_BEGIN and IRQCHIP_MODULE_END that add
the boilerplate code to be able to compile an irqchip driver as a
module.

The driver developer just needs to do add IRQCHIP_MODULE_BEGIN and
IRQCHIP_MODULE_END(driver_name) around the IRQCHIP_DECLARE macros, like
so:

IRQCHIP_MODULE_BEGIN
IRQCHIP_DECLARE(foo, "acme,foo", acme_foo_init)
IRQCHIP_DECLARE(bar, "acme,bar", acme_bar_init)
IRQCHIP_MODULE_END(acme_irq)

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
I don't expect this patch to be perfect or the final version. But I'd
like to introduce macros like this that don't need the driver developer
to copy/paste or repeat the same thing (compat string, function name,
etc) in multiple places for the driver to work as a module. If the exact
style of my macros aren't appealing, I'm open to other suggestions.

There are some checkpatch warning about the > 80 columns that my patch
doesn't add. There are also checkpatch warnings about the trailing ; in
a macro, but I need those for IRQCHIP_DECLARE to work when the driver is
builtin.

Thanks,
Saravana

 drivers/irqchip/irqchip.c | 20 ++++++++++++++++++++
 include/linux/irqchip.h   | 30 +++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 2b35e68bea82..191b605c72ef 100644
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
@@ -29,3 +31,21 @@ void __init irqchip_init(void)
 	of_irq_init(__irqchip_of_table);
 	acpi_probe_device_table(irqchip);
 }
+
+#ifdef CONFIG_MODULES
+int platform_irqchip_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *pnp = of_irq_find_parent(np);
+	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
+
+	if (!irq_init_cb)
+		return -EINVAL;
+
+	if (pnp == np)
+		pnp = NULL;
+
+	return irq_init_cb(np, pnp);
+}
+EXPORT_SYMBOL_GPL(platform_irqchip_probe);
+#endif
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 950e4b2458f0..26b62843cade 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -13,6 +13,7 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 
 /*
  * This macro must be used by the different irqchip drivers to declare
@@ -24,7 +25,34 @@
  * @compstr: compatible string of the irqchip driver
  * @fn: initialization function
  */
-#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
+#ifndef MODULE
+
+#define IRQCHIP_MODULE_BEGIN
+#define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn);
+#define IRQCHIP_MODULE_END(drv_name)
+
+#else
+
+extern int platform_irqchip_probe(struct platform_device *pdev);
+
+#define IRQCHIP_MODULE_BEGIN	\
+static const struct of_device_id __irqchip_match_table[] = {
+
+#define IRQCHIP_DECLARE(name, compat, fn) { .compatible = compat, .data = fn },
+
+#define IRQCHIP_MODULE_END(drv_name)			\
+	{},						\
+};							\
+MODULE_DEVICE_TABLE(of, __irqchip_match_table);		\
+static struct platform_driver drv_name##_driver = {	\
+	.probe  = platform_irqchip_probe,		\
+	.driver = {					\
+		.name = #drv_name,			\
+		.of_match_table = __irqchip_match_table,\
+	},						\
+};							\
+module_platform_driver(drv_name##_driver);
+#endif
 
 /*
  * This macro must be used by the different irqchip drivers to declare
-- 
2.26.0.110.g2183baf09c-goog

