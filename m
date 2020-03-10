Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2D7222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCJKTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:19:38 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60862 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCJKTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:19:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 69FE120467;
        Tue, 10 Mar 2020 11:19:33 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 57A621FF7A;
        Tue, 10 Mar 2020 11:19:33 +0100 (CET)
Subject: [PATCH v5 2/2] clk: Use devm_add in managed functions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
Message-ID: <f51ec6ec-e956-73d5-eb8d-c4addfcb0720@free.fr>
Date:   Tue, 10 Mar 2020 11:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Mar 10 11:19:33 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the helper produces simpler code and smaller object size.
E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:

    text           data     bss     dec     hex filename
-   1708             80       0    1788     6fc drivers/clk/clk-devres.o
+   1524             80       0    1604     644 drivers/clk/clk-devres.o

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch needs testing on a platform with many clocks.
---
 drivers/clk/clk-devres.c | 97 +++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index be160764911b..537fabf3a2a4 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -4,26 +4,22 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
-static void devm_clk_release(struct device *dev, void *res)
+static void my_clk_put(struct device *dev, void *res)
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
+	int ret;
+	struct clk *clk = clk_get(dev, id);
+
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = devm_add(dev, my_clk_put, &clk, sizeof(clk));
+	if (ret)
+		return ERR_PTR(ret);
 
 	return clk;
 }
@@ -40,14 +36,14 @@ struct clk *devm_clk_get_optional(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get_optional);
 
-struct clk_bulk_devres {
-	struct clk_bulk_data *clks;
+struct clk_bulk_args {
 	int num_clks;
+	struct clk_bulk_data *clks;
 };
 
-static void devm_clk_bulk_release(struct device *dev, void *res)
+static void my_clk_bulk_put(struct device *dev, void *res)
 {
-	struct clk_bulk_devres *devres = res;
+	struct clk_bulk_args *devres = res;
 
 	clk_bulk_put(devres->num_clks, devres->clks);
 }
@@ -55,27 +51,17 @@ static void devm_clk_bulk_release(struct device *dev, void *res)
 static int __devm_clk_bulk_get(struct device *dev, int num_clks,
 			       struct clk_bulk_data *clks, bool optional)
 {
-	struct clk_bulk_devres *devres;
 	int ret;
 
-	devres = devres_alloc(devm_clk_bulk_release,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
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
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return devm_vadd(dev, my_clk_bulk_put, clk_bulk_args, num_clks, clks);
 }
 
 int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
@@ -95,24 +81,17 @@ EXPORT_SYMBOL_GPL(devm_clk_bulk_get_optional);
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks)
 {
-	struct clk_bulk_devres *devres;
 	int ret;
+	int num_clks = clk_bulk_get_all(dev, clks);
 
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
+	if (num_clks <= 0)
+		return num_clks;
 
-	return ret;
+	ret = devm_vadd(dev, my_clk_bulk_put, clk_bulk_args, num_clks, *clks);
+	if (ret)
+		return ret;
+
+	return num_clks;
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
@@ -130,7 +109,7 @@ void devm_clk_put(struct device *dev, struct clk *clk)
 {
 	int ret;
 
-	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
+	ret = devres_release(dev, my_clk_put, devm_clk_match, clk);
 
 	WARN_ON(ret);
 }
@@ -139,19 +118,15 @@ EXPORT_SYMBOL(devm_clk_put);
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
+	int ret;
+	struct clk *clk = of_clk_get_by_name(np, con_id);
+
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = devm_add(dev, my_clk_put, &clk, sizeof(clk));
+	if (ret)
+		return ERR_PTR(ret);
 
 	return clk;
 }
-- 
2.17.1
