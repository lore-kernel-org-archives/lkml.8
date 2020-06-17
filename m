Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084AF20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwdklXAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFQW2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFQW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:27:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2128C06174E;
        Wed, 17 Jun 2020 15:27:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so4852847ljc.8;
        Wed, 17 Jun 2020 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctWQ9TZFDyYjy41m/bWYQmrPw1HpGYc8fpv1hjZ0KQo=;
        b=dwdklXAyAFHJ23dbH03q3jAUtq32OHCptiGtSVxoBCUYeso8+WqA8A3bizGuDPU+gv
         oHqGwfOcvTDr4l1aQqut40IA7a72w/rxkeB0xhQQt5NXh46g68JVMYBrhzcd9Cy1uS9x
         hV/RWVaPq9jgBivD97/qgxpKcTmnyfcz7zzrrlUQjjMe1G68EdaKfIpEs5OkLRaqNofe
         1WqgUDWkrCdKh3s6VS5PLcUnEvzaCp+B9WC2ztT6UnRgusIhz7Y/KNhqeZt7EROiL3in
         b5DAcTGgpErJRuq5SUt1ohcAaLk6wNFXzx35XUedJ+z8PxdU7ouvHR2/htPkD/qlhLRl
         /Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctWQ9TZFDyYjy41m/bWYQmrPw1HpGYc8fpv1hjZ0KQo=;
        b=UEbuTK0qB2ZJLYkCe3HdqcODVRcrCP/efpEtRDz1Srx18QFCOissyykcwAIy0R+Avw
         Hbu0vvK97kog23jbA8otQxxpDdcEfX9eTUynDy46VSrXocZzS3Iy17jESk5QaqfjGdX5
         3e11HsaZegariA+PIqTUPHV6Z6tPw3fbPcp/tPDwPEotZhRax2Sn24dkGsodYaUVs8xI
         hYh6TCYfbNOZJ1nm5F4Fiq9/WkKSYkqfoAvtctHFet1Kvl074C9u5Ov+dVRjBb4KuUYR
         wPlifFPnaIGoG1JmNeKe29B9+nKShjaC3Y23cQT2WDARvo5IdCOkAYHgRJCCkXOKnI+s
         uQ+g==
X-Gm-Message-State: AOAM5314kdiopo+FSaxw2D43SGjnIpJSImvARwzLh3UlVQ7Uq+PZ7UN/
        xc6o3lM+WJS7qol0WsXeqNQ=
X-Google-Smtp-Source: ABdhPJwkoTaH4WuZGpqJFoZ45uqBFI0iXLbYRGzllThvZoBuBs9UOOEuxcDKPe9JyThvyYJ1kM5KiA==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr710439lji.384.1592432875401;
        Wed, 17 Jun 2020 15:27:55 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id a1sm210378ljk.133.2020.06.17.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:27:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/7] of_graph: add of_graph_presents()
Date:   Thu, 18 Jun 2020 01:26:57 +0300
Message-Id: <20200617222703.17080-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617222703.17080-1-digetx@gmail.com>
References: <20200617222703.17080-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case, like a DRM display code for example, it's useful to silently
check whether port node exists at all in a device-tree before proceeding
with parsing of the graph.

This patch adds of_graph_presents() that returns true if given device-tree
node contains OF graph port.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/of/property.c    | 52 +++++++++++++++++++++++++++++++++-------
 include/linux/of_graph.h |  6 +++++
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 1f2086f4e7ce..b84ed6a7cf50 100644
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
+ * of_graph_presents() - check graph's presence
+ * @node: pointer to a device_node checked for the graph's presence
+ *
+ * Return: True if @node has a port or ports sub-node, false otherwise.
+ */
+bool of_graph_presents(const struct device_node *node)
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
+EXPORT_SYMBOL(of_graph_presents);
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
index 01038a6aade0..cc3028a0659d 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -38,6 +38,7 @@ struct of_endpoint {
 	     child = of_graph_get_next_endpoint(parent, child))
 
 #ifdef CONFIG_OF
+bool of_graph_presents(const struct device_node *node);
 int of_graph_parse_endpoint(const struct device_node *node,
 				struct of_endpoint *endpoint);
 int of_graph_get_endpoint_count(const struct device_node *np);
@@ -56,6 +57,11 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint);
 #else
 
+static inline bool of_graph_presents(const struct device_node *node)
+{
+	return false;
+}
+
 static inline int of_graph_parse_endpoint(const struct device_node *node,
 					struct of_endpoint *endpoint)
 {
-- 
2.26.0

