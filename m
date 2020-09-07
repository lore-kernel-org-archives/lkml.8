Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C2DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E222220678
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a78TO2/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgIGPO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:14:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44458 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgIGPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:13:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087FCIkr089553;
        Mon, 7 Sep 2020 10:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599491538;
        bh=/68cxUDsibqKLYKB9gViI6eL4J9ca4TgeLlSAUIVeAI=;
        h=From:To:CC:Subject:Date;
        b=a78TO2/9eI3OM5uzhtKXFmJE/avIc+2KMmkLML1JiSVLqSzgnF+cBrCNdZicSEreh
         px29+L6IB235RKu1I3ws7PjnAWqRTPmfZN5lfMoW8KI/j0QyBCAvUQ8za/xzWQAGfU
         0eJHCdOdMU6yHCEzGIyqkdtNsHDjizZd8WKWk0JQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087FCIDY123152
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 10:12:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 10:12:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 10:12:18 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087FCGU0015249;
        Mon, 7 Sep 2020 10:12:17 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one
Date:   Mon, 7 Sep 2020 18:12:16 +0300
Message-ID: <20200907151216.10896-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of the genpd support over TI SCI uses a single
genpd across the whole SoC, and attaches multiple devices to this. This
solution has its drawbacks, like it is currently impossible to attach
more than one power domain to a device; the core genpd implementation
requires one genpd per power-domain entry in DT for a single device.
Also, some devices like USB apparently require their own genpd during
probe time, the current shared approach in use does not work at all.

Switch the implementation over to use a single genpd per power domain
entry in DT. The domains are registered with the onecell approach, but
we also add our own xlate service due to recent introduction of the
extended flag for TI SCI PM domains; genpd core xlate service requires
a single cell per powerdomain, but we are using two cells.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/ti_sci_pm_domains.c | 251 ++++++++++++++---------------
 1 file changed, 121 insertions(+), 130 deletions(-)

diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index 8c2a2f23982c..af2126d2b2ff 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -9,7 +9,6 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -18,150 +17,95 @@
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
 /**
- * struct ti_sci_genpd_dev_data: holds data needed for every device attached
- *				 to this genpd
- * @idx: index of the device that identifies it with the system
- *	 control processor.
- * @exclusive: Permissions for exclusive request or shared request of the
- *	       device.
+ * struct ti_sci_genpd_provider: holds common TI SCI genpd provider data
+ * @ti_sci: handle to TI SCI protocol driver that provides ops to
+ *	    communicate with system control processor.
+ * @dev: pointer to dev for the driver for devm allocs
+ * @pd_list: list of all the power domains on the device
+ * @data: onecell data for genpd core
  */
-struct ti_sci_genpd_dev_data {
-	int idx;
-	u8 exclusive;
+struct ti_sci_genpd_provider {
+	const struct ti_sci_handle *ti_sci;
+	struct device *dev;
+	struct list_head pd_list;
+	struct genpd_onecell_data data;
 };
 
 /**
  * struct ti_sci_pm_domain: TI specific data needed for power domain
- * @ti_sci: handle to TI SCI protocol driver that provides ops to
- *	    communicate with system control processor.
- * @dev: pointer to dev for the driver for devm allocs
+ * @idx: index of the device that identifies it with the system
+ *	 control processor.
+ * @exclusive: Permissions for exclusive request or shared request of the
+ *	       device.
  * @pd: generic_pm_domain for use with the genpd framework
+ * @node: link for the genpd list
+ * @parent: link to the parent TI SCI genpd provider
  */
 struct ti_sci_pm_domain {
-	const struct ti_sci_handle *ti_sci;
-	struct device *dev;
+	int idx;
+	u8 exclusive;
 	struct generic_pm_domain pd;
+	struct list_head node;
+	struct ti_sci_genpd_provider *parent;
 };
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
 
-/**
- * ti_sci_dev_id(): get prepopulated ti_sci id from struct dev
- * @dev: pointer to device associated with this genpd
- *
- * Returns device_id stored from ti,sci_id property
- */
-static int ti_sci_dev_id(struct device *dev)
-{
-	struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
-	struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
-
-	return sci_dev_data->idx;
-}
-
-static u8 is_ti_sci_dev_exclusive(struct device *dev)
-{
-	struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
-	struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
-
-	return sci_dev_data->exclusive;
-}
-
-/**
- * ti_sci_dev_to_sci_handle(): get pointer to ti_sci_handle
- * @dev: pointer to device associated with this genpd
- *
- * Returns ti_sci_handle to be used to communicate with system
- *	   control processor.
+/*
+ * ti_sci_pd_power_off(): genpd power down hook
+ * @domain: pointer to the powerdomain to power off
  */
-static const struct ti_sci_handle *ti_sci_dev_to_sci_handle(struct device *dev)
+static int ti_sci_pd_power_off(struct generic_pm_domain *domain)
 {
-	struct generic_pm_domain *pd = pd_to_genpd(dev->pm_domain);
-	struct ti_sci_pm_domain *ti_sci_genpd = genpd_to_ti_sci_pd(pd);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
 
-	return ti_sci_genpd->ti_sci;
+	return ti_sci->ops.dev_ops.put_device(ti_sci, pd->idx);
 }
 
-/**
- * ti_sci_dev_start(): genpd device start hook called to turn device on
- * @dev: pointer to device associated with this genpd to be powered on
+/*
+ * ti_sci_pd_power_on(): genpd power up hook
+ * @domain: pointer to the powerdomain to power on
  */
-static int ti_sci_dev_start(struct device *dev)
+static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 {
-	const struct ti_sci_handle *ti_sci = ti_sci_dev_to_sci_handle(dev);
-	int idx = ti_sci_dev_id(dev);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(domain);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
 
-	if (is_ti_sci_dev_exclusive(dev))
-		return ti_sci->ops.dev_ops.get_device_exclusive(ti_sci, idx);
+	if (pd->exclusive)
+		return ti_sci->ops.dev_ops.get_device_exclusive(ti_sci,
+								pd->idx);
 	else
-		return ti_sci->ops.dev_ops.get_device(ti_sci, idx);
+		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
-/**
- * ti_sci_dev_stop(): genpd device stop hook called to turn device off
- * @dev: pointer to device associated with this genpd to be powered off
+/*
+ * ti_sci_pd_xlate(): translation service for TI SCI genpds
+ * @genpdspec: DT identification data for the genpd
+ * @data: genpd core data for all the powerdomains on the device
  */
-static int ti_sci_dev_stop(struct device *dev)
+static struct generic_pm_domain *ti_sci_pd_xlate(
+					struct of_phandle_args *genpdspec,
+					void *data)
 {
-	const struct ti_sci_handle *ti_sci = ti_sci_dev_to_sci_handle(dev);
-	int idx = ti_sci_dev_id(dev);
+	struct genpd_onecell_data *genpd_data = data;
+	unsigned int idx = genpdspec->args[0];
 
-	return ti_sci->ops.dev_ops.put_device(ti_sci, idx);
-}
+	if (genpdspec->args_count < 2)
+		return ERR_PTR(-EINVAL);
 
-static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
-				struct device *dev)
-{
-	struct device_node *np = dev->of_node;
-	struct of_phandle_args pd_args;
-	struct ti_sci_pm_domain *ti_sci_genpd = genpd_to_ti_sci_pd(domain);
-	const struct ti_sci_handle *ti_sci = ti_sci_genpd->ti_sci;
-	struct ti_sci_genpd_dev_data *sci_dev_data;
-	struct generic_pm_domain_data *genpd_data;
-	int idx, ret = 0;
-
-	ret = of_parse_phandle_with_args(np, "power-domains",
-					 "#power-domain-cells", 0, &pd_args);
-	if (ret < 0)
-		return ret;
-
-	if (pd_args.args_count != 1 && pd_args.args_count != 2)
-		return -EINVAL;
-
-	idx = pd_args.args[0];
-
-	/*
-	 * Check the validity of the requested idx, if the index is not valid
-	 * the PMMC will return a NAK here and we will not allocate it.
-	 */
-	ret = ti_sci->ops.dev_ops.is_valid(ti_sci, idx);
-	if (ret)
-		return -EINVAL;
-
-	sci_dev_data = kzalloc(sizeof(*sci_dev_data), GFP_KERNEL);
-	if (!sci_dev_data)
-		return -ENOMEM;
+	if (idx >= genpd_data->num_domains) {
+		pr_err("%s: invalid domain index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
 
-	sci_dev_data->idx = idx;
-	/* Enable the exclusive permissions by default */
-	sci_dev_data->exclusive = TI_SCI_PD_EXCLUSIVE;
-	if (pd_args.args_count == 2)
-		sci_dev_data->exclusive = pd_args.args[1] & 0x1;
+	if (!genpd_data->domains[idx])
+		return ERR_PTR(-ENOENT);
 
-	genpd_data = dev_gpd_data(dev);
-	genpd_data->data = sci_dev_data;
+	genpd_to_ti_sci_pd(genpd_data->domains[idx])->exclusive =
+		genpdspec->args[1];
 
-	return 0;
-}
-
-static void ti_sci_pd_detach_dev(struct generic_pm_domain *domain,
-				 struct device *dev)
-{
-	struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
-	struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
-
-	kfree(sci_dev_data);
-	genpd_data->data = NULL;
+	return genpd_data->domains[idx];
 }
 
 static const struct of_device_id ti_sci_pm_domain_matches[] = {
@@ -173,33 +117,80 @@ MODULE_DEVICE_TABLE(of, ti_sci_pm_domain_matches);
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct ti_sci_pm_domain *ti_sci_pd;
+	struct ti_sci_genpd_provider *pd_provider;
+	struct ti_sci_pm_domain *pd;
+	struct device_node *np = NULL;
+	struct of_phandle_args args;
 	int ret;
+	u32 max_id = 0;
+	int index;
 
-	ti_sci_pd = devm_kzalloc(dev, sizeof(*ti_sci_pd), GFP_KERNEL);
-	if (!ti_sci_pd)
+	pd_provider = devm_kzalloc(dev, sizeof(*pd_provider), GFP_KERNEL);
+	if (!pd_provider)
 		return -ENOMEM;
 
-	ti_sci_pd->ti_sci = devm_ti_sci_get_handle(dev);
-	if (IS_ERR(ti_sci_pd->ti_sci))
-		return PTR_ERR(ti_sci_pd->ti_sci);
+	pd_provider->ti_sci = devm_ti_sci_get_handle(dev);
+	if (IS_ERR(pd_provider->ti_sci))
+		return PTR_ERR(pd_provider->ti_sci);
+
+	pd_provider->dev = dev;
+
+	INIT_LIST_HEAD(&pd_provider->pd_list);
+
+	/* Find highest device ID used for power domains */
+	while (1) {
+		np = of_find_node_with_property(np, "power-domains");
+		if (!np)
+			break;
+
+		index = 0;
+
+		while (1) {
+			ret = of_parse_phandle_with_args(np, "power-domains",
+							 "#power-domain-cells",
+							 index, &args);
+			if (ret)
+				break;
+
+			if (args.args_count >= 1 && args.np == dev->of_node) {
+				if (args.args[0] > max_id)
+					max_id = args.args[0];
+
+				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+				if (!pd)
+					return -ENOMEM;
+
+				pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
+							     "pd:%d",
+							     args.args[0]);
+				if (!pd->pd.name)
+					return -ENOMEM;
 
-	ti_sci_pd->dev = dev;
+				pd->pd.power_off = ti_sci_pd_power_off;
+				pd->pd.power_on = ti_sci_pd_power_on;
+				pd->idx = args.args[0];
+				pd->parent = pd_provider;
 
-	ti_sci_pd->pd.name = "ti_sci_pd";
+				pm_genpd_init(&pd->pd, NULL, true);
 
-	ti_sci_pd->pd.attach_dev = ti_sci_pd_attach_dev;
-	ti_sci_pd->pd.detach_dev = ti_sci_pd_detach_dev;
+				list_add(&pd->node, &pd_provider->pd_list);
+			}
+			index++;
+		}
+	}
 
-	ti_sci_pd->pd.dev_ops.start = ti_sci_dev_start;
-	ti_sci_pd->pd.dev_ops.stop = ti_sci_dev_stop;
+	pd_provider->data.domains =
+		devm_kcalloc(dev, max_id + 1,
+			     sizeof(*pd_provider->data.domains),
+			     GFP_KERNEL);
 
-	pm_genpd_init(&ti_sci_pd->pd, NULL, true);
+	pd_provider->data.num_domains = max_id + 1;
+	pd_provider->data.xlate = ti_sci_pd_xlate;
 
-	ret = of_genpd_add_provider_simple(np, &ti_sci_pd->pd);
+	list_for_each_entry(pd, &pd_provider->pd_list, node)
+		pd_provider->data.domains[pd->idx] = &pd->pd;
 
-	return ret;
+	return of_genpd_add_provider_onecell(dev->of_node, &pd_provider->data);
 }
 
 static struct platform_driver ti_sci_pm_domains_driver = {
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
