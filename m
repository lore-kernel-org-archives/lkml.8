Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C01207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRDYz8Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGACQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGACQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1489C061755;
        Tue, 30 Jun 2020 19:16:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so21472608ljp.6;
        Tue, 30 Jun 2020 19:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7/jf6iskdniTzEnZUnWGVVNcVP/qHfzghErMkcYKrI=;
        b=eRDYz8Af3Y6euS1TibxYdASJGDq3VMjusT+reg7W83QwN6iS5cczzeL7lRZmIlOdeh
         +yxCgS4h4GUhkLfqEsJ8zC/1ye2DZLjRSuDL1Jb7fIVw+dV3KkbFeNcDoKF1BqYEQdvP
         Ezz2+XZb8Eo8+9HKpa8NhW/9EdsOEmlEebOX4A0WuU8krf87ml3nFcZT0q/h/zGE2MmT
         v0ALd1Jr+CabNSulFfmxAYSvyfuohUdk6m3pb744fWQhzufx5KW+LMP4GRovZDYl2FIT
         3AZ6Xnh2nC94N145k/0zPM+Jm9gVq6CWjU7S82XxRBtRH3ho3ILvRptaFxjqGTCdtCOX
         zy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7/jf6iskdniTzEnZUnWGVVNcVP/qHfzghErMkcYKrI=;
        b=UNXR4+5hs2SbLoGQ1winJOxs50IyiIk/ocF5Zkcyc+ZfdFm6bSZciupwbZB+aUb9L9
         wHuaFJpqbm5kJu1pmgqs49Z621yvTt3r8Zky+VAaFEBefsKH+dHWFPvSDO0CAitXsWha
         xnjPYzsgrO6dhOu3dcdce9sC6AGZEdckSTelG0QxwtqWc+M4zvw9uXC7OWV63oVyBGot
         e6GAlItsa4xOV3zYcu88xodhVoMK6wKgVYcg879nsgmHwMYoTZDL1QGhXw+kgYG4Sjkp
         6/LSctZRNqqourShwHla5Y08q6N3QqcaztZSzw8HYNen+YBdfjQ9pEVMEggJChZ2csHJ
         UiNg==
X-Gm-Message-State: AOAM531PnarcqlOdKF6e3UT3/6jcdHHVlls2pYCyL6/2WmtjGm/Zomnk
        hDg3Goz+TOm+Ivl1EPenFsp4PCKdkw4=
X-Google-Smtp-Source: ABdhPJyvXbSFIlwy/fqehI8pJT5nQ8DL+Dt/RKHyIvne+LI9aF8jQ0bM9Z5mZc3y2fy7CQthFoOeHA==
X-Received: by 2002:a05:651c:107a:: with SMTP id y26mr11354430ljm.59.1593569792401;
        Tue, 30 Jun 2020 19:16:32 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id i2sm1296892lji.59.2020.06.30.19.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 19:16:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/2] of_graph: add of_graph_is_present()
Date:   Wed,  1 Jul 2020 05:16:16 +0300
Message-Id: <20200701021617.12030-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701021617.12030-1-digetx@gmail.com>
References: <20200701021617.12030-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case, like a DRM display code for example, it's useful to silently
check whether port node exists at all in a device-tree before proceeding
with parsing of the graph.

This patch adds of_graph_is_present() which returns true if given
device-tree node contains OF graph port.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/of/property.c    | 52 +++++++++++++++++++++++++++++++++-------
 include/linux/of_graph.h |  6 +++++
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6a5760f0d6cd..e12b8b491837 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -29,6 +29,48 @@
 
 #include "of_private.h"
 
+/**
+ * of_graph_get_first_local_port() - get first local port node
+ * @node: pointer to a local endpoint device_node
+ *
+ * Return: First local port node associated with local endpoint node linked
+ *	   to @node. Use of_node_put() on it when done.
+ */
+static struct device_node *
+of_graph_get_first_local_port(const struct device_node *node)
+{
+	struct device_node *ports, *port;
+
+	ports = of_get_child_by_name(node, "ports");
+	if (ports)
+		node = ports;
+
+	port = of_get_child_by_name(node, "port");
+	of_node_put(ports);
+
+	return port;
+}
+
+/**
+ * of_graph_is_present() - check graph's presence
+ * @node: pointer to a device_node checked for the graph's presence
+ *
+ * Return: True if @node has a port or ports sub-node, false otherwise.
+ */
+bool of_graph_is_present(const struct device_node *node)
+{
+	struct device_node *local;
+
+	local = of_graph_get_first_local_port(node);
+	if (!local)
+		return false;
+
+	of_node_put(local);
+
+	return true;
+}
+EXPORT_SYMBOL(of_graph_is_present);
+
 /**
  * of_property_count_elems_of_size - Count the number of elements in a property
  *
@@ -608,15 +650,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 	 * parent port node.
 	 */
 	if (!prev) {
-		struct device_node *node;
-
-		node = of_get_child_by_name(parent, "ports");
-		if (node)
-			parent = node;
-
-		port = of_get_child_by_name(parent, "port");
-		of_node_put(node);
-
+		port = of_graph_get_first_local_port(parent);
 		if (!port) {
 			pr_err("graph: no port node found in %pOF\n", parent);
 			return NULL;
diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
index 01038a6aade0..4d7756087b6b 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -38,6 +38,7 @@ struct of_endpoint {
 	     child = of_graph_get_next_endpoint(parent, child))
 
 #ifdef CONFIG_OF
+bool of_graph_is_present(const struct device_node *node);
 int of_graph_parse_endpoint(const struct device_node *node,
 				struct of_endpoint *endpoint);
 int of_graph_get_endpoint_count(const struct device_node *np);
@@ -56,6 +57,11 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint);
 #else
 
+static inline bool of_graph_is_present(const struct device_node *node)
+{
+	return false;
+}
+
 static inline int of_graph_parse_endpoint(const struct device_node *node,
 					struct of_endpoint *endpoint)
 {
-- 
2.26.0

