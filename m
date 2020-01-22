Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3675AC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C39024683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAVNCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:02:19 -0500
Received: from ns.iliad.fr ([212.27.33.1]:44002 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAVNCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:02:18 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id CF92C209AE;
        Wed, 22 Jan 2020 14:02:16 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B45DB20169;
        Wed, 22 Jan 2020 14:02:16 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [RFC PATCH v2] clk: Use a new helper in managed functions
To:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Message-ID: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr>
Date:   Wed, 22 Jan 2020 14:02:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Jan 22 14:02:16 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce devm_add() to factorize devres_alloc/devres_add calls.

Using that helper produces simpler code and smaller object size:

1 file changed, 27 insertions(+), 66 deletions(-)

    text	   data	    bss	    dec	    hex	filename
-   1708	     80	      0	   1788	    6fc	drivers/clk/clk-devres.o
+   1508	     80	      0	   1588	    634	drivers/clk/clk-devres.o

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/base/devres.c    | 14 ++++++
 drivers/clk/clk-devres.c | 93 ++++++++++++----------------------------
 include/linux/device.h   |  1 +
 3 files changed, 42 insertions(+), 66 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..76392dd6273b 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
 }
 EXPORT_SYMBOL_GPL(devres_release_group);
 
+void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
+{
+	void *data = devres_alloc(func, size, GFP_KERNEL);
+
+	if (data) {
+		memcpy(data, arg, size);
+		devres_add(dev, data);
+	} else
+		func(dev, arg);
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(devm_add);
+
 /*
  * Custom devres actions allow inserting a simple function call
  * into the teadown sequence.
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index be160764911b..582fda9ad6a6 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -4,26 +4,18 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
-static void devm_clk_release(struct device *dev, void *res)
+static void wrap_clk_put(struct device *dev, void *res)
 {
 	clk_put(*(struct clk **)res);
 }
 
 struct clk *devm_clk_get(struct device *dev, const char *id)
 {
-	struct clk **ptr, *clk;
-
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	clk = clk_get(dev, id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	struct clk *clk = clk_get(dev, id);
+
+	if (!IS_ERR(clk))
+		if (!devm_add(dev, wrap_clk_put, &clk, sizeof(clk)))
+			clk = ERR_PTR(-ENOMEM);
 
 	return clk;
 }
@@ -33,10 +25,7 @@ struct clk *devm_clk_get_optional(struct device *dev, const char *id)
 {
 	struct clk *clk = devm_clk_get(dev, id);
 
-	if (clk == ERR_PTR(-ENOENT))
-		return NULL;
-
-	return clk;
+	return clk == ERR_PTR(-ENOENT) ? NULL : clk;
 }
 EXPORT_SYMBOL(devm_clk_get_optional);
 
@@ -45,7 +34,7 @@ struct clk_bulk_devres {
 	int num_clks;
 };
 
-static void devm_clk_bulk_release(struct device *dev, void *res)
+static void wrap_clk_bulk_put(struct device *dev, void *res)
 {
 	struct clk_bulk_devres *devres = res;
 
@@ -55,25 +44,17 @@ static void devm_clk_bulk_release(struct device *dev, void *res)
 static int __devm_clk_bulk_get(struct device *dev, int num_clks,
 			       struct clk_bulk_data *clks, bool optional)
 {
-	struct clk_bulk_devres *devres;
 	int ret;
-
-	devres = devres_alloc(devm_clk_bulk_release,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
+	struct clk_bulk_devres arg = { clks, num_clks };
 
 	if (optional)
 		ret = clk_bulk_get_optional(dev, num_clks, clks);
 	else
 		ret = clk_bulk_get(dev, num_clks, clks);
-	if (!ret) {
-		devres->clks = clks;
-		devres->num_clks = num_clks;
-		devres_add(dev, devres);
-	} else {
-		devres_free(devres);
-	}
+
+	if (!ret)
+		if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
+			ret = -ENOMEM;
 
 	return ret;
 }
@@ -95,24 +76,16 @@ EXPORT_SYMBOL_GPL(devm_clk_bulk_get_optional);
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks)
 {
-	struct clk_bulk_devres *devres;
-	int ret;
+	struct clk_bulk_devres arg;
 
-	devres = devres_alloc(devm_clk_bulk_release,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
-	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-		devres_add(dev, devres);
-	} else {
-		devres_free(devres);
-	}
+	arg.num_clks = clk_bulk_get_all(dev, clks);
+	arg.clks = *clks;
 
-	return ret;
+	if (arg.num_clks > 0)
+		if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
+			arg.num_clks = -ENOMEM;
+
+	return arg.num_clks;
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
@@ -128,30 +101,18 @@ static int devm_clk_match(struct device *dev, void *res, void *data)
 
 void devm_clk_put(struct device *dev, struct clk *clk)
 {
-	int ret;
-
-	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
-
-	WARN_ON(ret);
+	WARN_ON(devres_release(dev, wrap_clk_put, devm_clk_match, clk));
 }
 EXPORT_SYMBOL(devm_clk_put);
 
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
-
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	clk = of_clk_get_by_name(np, con_id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	struct clk *clk = of_clk_get_by_name(np, con_id);
+
+	if (!IS_ERR(clk))
+		if (!devm_add(dev, wrap_clk_put, &clk, sizeof(clk)))
+			clk = ERR_PTR(-ENOMEM);
 
 	return clk;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index e226030c1df3..d47872c5ab72 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -969,6 +969,7 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
 			    resource_size_t *size);
 
+void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size);
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
-- 
2.17.1
