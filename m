Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C6A20897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hzi02I5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgE2Qc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:32:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33762 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgE2Qc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:32:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529163224euoutp02481d6df490523bf164be8ae4812c7651~TjNX6vPr81716917169euoutp02E
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:32:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529163224euoutp02481d6df490523bf164be8ae4812c7651~TjNX6vPr81716917169euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590769944;
        bh=SqVa+/xmVUtB5jG/wZd4ZgkSi/Pgluso12CiUoVcY/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hzi02I5yhBD2wwVdTe7Hk1cwHbALQceyJWY9JPY/sNEquEvajBRenQED9pKlF41RO
         ukw9zN/6UapdkR3CcIXO5EtbTQKrWbj+utPjOTXW8j1DgA3fWuLHzOlaKeFsEPBl5R
         750vHclulRllBQ2Q7vSAukjGSZppkYqzLTahWXKA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200529163223eucas1p12969b264e85eafc0acd2deb177ad31f9~TjNXeHfT22310023100eucas1p17;
        Fri, 29 May 2020 16:32:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.BB.60679.71931DE5; Fri, 29
        May 2020 17:32:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5~TjNXAvHP12862228622eucas1p2U;
        Fri, 29 May 2020 16:32:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200529163223eusmtrp29a2cc19a4e60b49191267d459de27503~TjNXAH9AX0721307213eusmtrp2h;
        Fri, 29 May 2020 16:32:23 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-0a-5ed139174c71
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.DA.08375.61931DE5; Fri, 29
        May 2020 17:32:23 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163222eusmtip116a16f09f7c9f8157d83f0f35c239aaf~TjNWTxG791045810458eusmtip1T;
        Fri, 29 May 2020 16:32:22 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
Date:   Fri, 29 May 2020 18:31:56 +0200
Message-Id: <20200529163200.18031-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529163200.18031-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djP87rilhfjDI6tl7O4P6+V0WLjjPWs
        Fte/PGe1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt7jduILN
        4vCbdlaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQi
        fbsEroyNMzwLbrhW/Lh5n6WB8bxVFyMnh4SAicTsdXtYuxi5OIQEVjBKvFrylR3C+cIo8WjF
        JijnM6PErHOPmWBa1p7YygiRWM4osajjPhtcy6b3i9hBqtgEDCV6j/YxgtgiAi4SbU/nsYAU
        MQvsYZLYN/sdkMPBISwQLdH8MAykhkVAVWLz551sIDavgLXEmavzWSC2yUus3nCAGcTmFLCR
        6P4zgxmiRlDi5MwnYDXMQDXNW2czg8yXELjFLnHi1z5GiGYXiQ19O5ghbGGJV8e3sEPYMhL/
        d85ngmhoZpTo2X2bHcKZwChx//gCqG5riTvnfrGBXMosoCmxfpc+RNhR4sCztUwgYQkBPokb
        bwUhjuCTmLRtOjNEmFeio00IolpF4veq6dCQk5LofvIf6i8PicOPFzFPYFScheSdWUjemYWw
        dwEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzA1HX63/EvOxh3/Uk6xCjAwajEw1uh
        dTFOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8s
        Sc1OTS1ILYLJMnFwSjUwrplz+JG5euIT77Ofm3cLbJSYyeqkPJV5YVp3suwSQ80C8ZeXfkmu
        3+kqcu90aatmZEq87RXP8rl+mzTEtm4qX9/c62yb5n/lj4rh9YA5Toosq5i/5XakujSs/Tjp
        c2q5+Y19U54ul3rw0+5u+P/Uy6K+jbM67VlOzknZbH59Pn9KtEvCyoc+SizFGYmGWsxFxYkA
        4rjpm1kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7rilhfjDC52M1ncn9fKaLFxxnpW
        i+tfnrNaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW9xuXMFm
        cfhNO6vFjMkv2Rz4PDat6mTzuHNtD5vH/e7jTB6bl9R79G1ZxejxeZNcAFuUnk1RfmlJqkJG
        fnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbGGZ4FN1wrfty8z9LA
        eN6qi5GTQ0LARGLtia2MXYxcHEICSxkl5qw/AuRwACWkJOa3KEHUCEv8udbFBlHziVHi7vKt
        zCAJNgFDid6jfYwgtoiAh8Sp1rWsIEXMAieYJJ70bmQDSQgLREp8/jwbzGYRUJXY/HknmM0r
        YC1x5up8FogN8hKrNxwAG8opYCPR/WcGmC0EVNP2eBYrRL2gxMmZT1hAjmMWUJdYP08IJMwM
        1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgNG479nPz
        DsZLG4MPMQpwMCrx8F7QuRgnxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        pkCvTWSWEk3OByaKvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFIN
        jN4Gr2tFinQ0rhuu89z74pf2hQU+9aKzOpafnFLANcEp473SUfdm7tJb6vu+Jl9w0Hw5+cvB
        mZvuCPWfaqy227OSR4qN53fl4rmRui2SE/UtIssiF4adflonLZN80nOqRN1r7/tiIguZ5vW4
        FiXHnE/Y1f5Z7EK1Zvv+60fY7kbOz5KdG5f0TomlOCPRUIu5qDgRAEXevl/cAgAA
X-CMS-MailID: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
        <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a generic interconnect driver for Exynos SoCs in order
to provide interconnect functionality for each "samsung,exynos-bus"
compatible device.

The SoC topology is a graph (or more specifically, a tree) and its
edges are specified using the 'samsung,interconnect-parent' in the
DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
propagated to ensure that the parent is probed before its children.

Each bus is now an interconnect provider and an interconnect node as
well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
registers itself as a node. Node IDs are not hardcoded but rather
assigned dynamically at runtime. This approach allows for using this
driver with various Exynos SoCs.

Frequencies requested via the interconnect API for a given node are
propagated to devfreq using dev_pm_qos_update_request(). Please note
that it is not an error when CONFIG_INTERCONNECT is 'n', in which
case all interconnect API functions are no-op.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Changes for v5:
 - adjust to renamed exynos,interconnect-parent-node property,
 - use automatically generated platform device id as the interconect
   node id instead of a now unavailable devfreq->id field,
 - add icc_ prefix to some variables to make the code more self-commenting,
 - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
 - adjust to exynos,interconnect-parent-node property rename to
   samsung,interconnect-parent,
 - converted to a separate platform driver in drivers/interconnect.
---
 drivers/interconnect/Kconfig         |   1 +
 drivers/interconnect/Makefile        |   1 +
 drivers/interconnect/exynos/Kconfig  |   6 ++
 drivers/interconnect/exynos/Makefile |   4 +
 drivers/interconnect/exynos/exynos.c | 185 +++++++++++++++++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/interconnect/exynos/Kconfig
 create mode 100644 drivers/interconnect/exynos/Makefile
 create mode 100644 drivers/interconnect/exynos/exynos.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 5b7204e..eca6eda 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -11,6 +11,7 @@ menuconfig INTERCONNECT
 
 if INTERCONNECT
 
+source "drivers/interconnect/exynos/Kconfig"
 source "drivers/interconnect/imx/Kconfig"
 source "drivers/interconnect/qcom/Kconfig"
 
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 4825c28..2ba1de6 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,5 +4,6 @@ CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
+obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos/
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
diff --git a/drivers/interconnect/exynos/Kconfig b/drivers/interconnect/exynos/Kconfig
new file mode 100644
index 0000000..e51e52e
--- /dev/null
+++ b/drivers/interconnect/exynos/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTERCONNECT_EXYNOS
+	tristate "Exynos generic interconnect driver"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Generic interconnect driver for Exynos SoCs.
diff --git a/drivers/interconnect/exynos/Makefile b/drivers/interconnect/exynos/Makefile
new file mode 100644
index 0000000..e19d1df
--- /dev/null
+++ b/drivers/interconnect/exynos/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+exynos-interconnect-objs		:= exynos.o
+
+obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos-interconnect.o
diff --git a/drivers/interconnect/exynos/exynos.c b/drivers/interconnect/exynos/exynos.c
new file mode 100644
index 0000000..8278194
--- /dev/null
+++ b/drivers/interconnect/exynos/exynos.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Exynos generic interconnect provider driver
+ *
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *
+ * Authors: Artur Świgoń <a.swigon@samsung.com>
+ *          Sylwester Nawrocki <s.nawrocki@samsung.com>
+ */
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_qos.h>
+
+#define kbps_to_khz(x) ((x) / 8)
+
+struct exynos_icc_priv {
+	struct device *dev;
+
+	/* One interconnect node per provider */
+	struct icc_provider provider;
+	struct icc_node *node;
+
+	struct dev_pm_qos_request qos_req;
+};
+
+static struct icc_node *exynos_icc_get_parent(struct device_node *np)
+{
+	struct of_phandle_args args;
+	int num, ret;
+
+	num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
+					"#interconnect-cells");
+	if (num != 1)
+		return NULL; /* parent nodes are optional */
+
+	ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
+					"#interconnect-cells", 0, &args);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	of_node_put(args.np);
+
+	return of_icc_get_from_provider(&args);
+}
+
+
+static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct exynos_icc_priv *src_priv = src->data, *dst_priv = dst->data;
+	s32 src_freq = kbps_to_khz(max(src->avg_bw, src->peak_bw));
+	s32 dst_freq = kbps_to_khz(max(dst->avg_bw, dst->peak_bw));
+	int ret;
+
+	ret = dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
+	if (ret < 0) {
+		dev_err(src_priv->dev, "failed to update PM QoS of %s\n",
+			src->name);
+		return ret;
+	}
+
+	ret = dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
+	if (ret < 0) {
+		dev_err(dst_priv->dev, "failed to update PM QoS of %s\n",
+			dst->name);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
+						 void *data)
+{
+	struct exynos_icc_priv *priv = data;
+
+	if (spec->np != priv->dev->parent->of_node)
+		return ERR_PTR(-EINVAL);
+
+	return priv->node;
+}
+
+static int exynos_generic_icc_remove(struct platform_device *pdev)
+{
+	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
+	struct icc_node *parent_node, *node = priv->node;
+
+	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
+	if (parent_node && !IS_ERR(parent_node))
+		icc_link_destroy(node, parent_node);
+
+	icc_nodes_remove(&priv->provider);
+	icc_provider_del(&priv->provider);
+
+	return 0;
+}
+
+static int exynos_generic_icc_probe(struct platform_device *pdev)
+{
+	struct device *bus_dev = pdev->dev.parent;
+	struct exynos_icc_priv *priv;
+	struct icc_provider *provider;
+	struct icc_node *icc_node, *icc_parent_node;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	provider = &priv->provider;
+
+	provider->set = exynos_generic_icc_set;
+	provider->aggregate = icc_std_aggregate;
+	provider->xlate = exynos_generic_icc_xlate;
+	provider->dev = bus_dev;
+	provider->inter_set = true;
+	provider->data = priv;
+
+	ret = icc_provider_add(provider);
+	if (ret < 0)
+		return ret;
+
+	icc_node = icc_node_create(pdev->id);
+	if (IS_ERR(icc_node)) {
+		ret = PTR_ERR(icc_node);
+		goto err_prov_del;
+	}
+
+	priv->node = icc_node;
+	icc_node->name = bus_dev->of_node->name;
+	icc_node->data = priv;
+	icc_node_add(icc_node, provider);
+
+	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
+	if (IS_ERR(icc_parent_node)) {
+		ret = PTR_ERR(icc_parent_node);
+		goto err_node_del;
+	}
+	if (icc_parent_node) {
+		ret = icc_link_create(icc_node, icc_parent_node->id);
+		if (ret < 0)
+			goto err_node_del;
+	}
+
+	/*
+	 * Register a PM QoS request for the bus device for which also devfreq
+	 * functionality is registered.
+	 */
+	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (ret < 0)
+		goto err_link_destroy;
+
+	return 0;
+
+err_link_destroy:
+	if (icc_parent_node)
+		icc_link_destroy(icc_node, icc_parent_node);
+err_node_del:
+	icc_nodes_remove(provider);
+err_prov_del:
+	icc_provider_del(provider);
+
+	return ret;
+}
+
+static struct platform_driver exynos_generic_icc_driver = {
+	.driver = {
+		.name = "exynos-generic-icc",
+	},
+	.probe = exynos_generic_icc_probe,
+	.remove = exynos_generic_icc_remove,
+};
+module_platform_driver(exynos_generic_icc_driver);
+
+MODULE_DESCRIPTION("Exynos generic interconnect driver");
+MODULE_AUTHOR("Artur Świgoń <a.swigon@samsung.com>");
+MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:exynos-generic-icc");
-- 
2.7.4

