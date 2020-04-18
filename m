Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D41C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6F21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8+tA4Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgDRRHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDRRHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:07:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC0C061A0C;
        Sat, 18 Apr 2020 10:07:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 67so1452099ljj.4;
        Sat, 18 Apr 2020 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LF9qYPsgEt1mOQlLDUJnZ056rYW87d7CQEg+TJz1Umo=;
        b=k8+tA4LgVm/G4HwuE5XkDVDgVP2w8rgA8cOUO3qaGJLBV/QXBgCtT8+izVcKJ9SH9i
         dWi5cPGfPBEnUGD0+b8pcaw3xxATY/NlnPqvP1i5I4N1CaM6L9Afkbu38qDJAW6vakzO
         UnEx4O2FNYFQ0RAo8p316b8SlGuYtPKe0V9Z0cwGQ304j80ERHW1vcnNsAOfAakWJzUt
         iCz57nV9Xj0rJ+kg9evHgr2LN1pfLSXk7KpFmDDuUS2h19N84cD63v9860QXjnrBMS36
         O0lHx8LkKbWZSa2ayFBTA7QJdRq1JzKZ5AiNLZFJ+qpFSSHT/4HzSJyQrASe9QFovvrB
         khpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LF9qYPsgEt1mOQlLDUJnZ056rYW87d7CQEg+TJz1Umo=;
        b=TYa8bP80kPhjlLDNRzLkYk/zC2fouiJN0bkAYhyYis3rUjjSZCscxMfjwKQsyrXwq8
         fcMXaqHaOSQ9udvOlB9kYQp/TT778mOY2flnEBOhDf4ze6l6GnoUErdlvLC/3qTGkCPs
         VYu5YjL44GZQQNB17F0vh0AdSNOg72WBZ4FW/nyai9Mp18bHPUgB3IIu5//h5R6elflm
         OgZ5r+1U0g5UoTSxNB+UCRsWt2pN2yGXhwYn66K+ZCbl9FMLrd8rBqKuXCX0MD4tQ45b
         9+KEbg3F2W9AZFVtfk1eOdQB2Y1WWcfZC5nwRuumgKWmTh12mqfAfWBNuDbdxD2zv6Ei
         gRTA==
X-Gm-Message-State: AGi0PuYbZg4OUpuBGEqE+CAjSHFnNCjgXQqc9X6unnt58wY5n5tsqvXC
        otq13gR7uCqE/Q5kynwkNfw=
X-Google-Smtp-Source: APiQypLOLWFYy5XnCNRUduSZevMMwv/vy951mpF50dk/aGrJ00HsLstuqzx1B3gNuIYB77wn1VAJBQ==
X-Received: by 2002:a2e:164e:: with SMTP id 14mr4869678ljw.253.1587229638510;
        Sat, 18 Apr 2020 10:07:18 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id e15sm8768909ljb.25.2020.04.18.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:07:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] of_graph: add of_graph_get_local_port()
Date:   Sat, 18 Apr 2020 20:06:58 +0300
Message-Id: <20200418170703.1583-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418170703.1583-1-digetx@gmail.com>
References: <20200418170703.1583-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some case, like a DRM display code for example, it's useful to silently
check whether port node exists at all in a device-tree before proceeding
with parsing the graph.

This patch adds of_graph_get_local_port() which returns pointer to a local
port node, or NULL if graph isn't specified in a device-tree for a given
device node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/of/property.c    | 32 +++++++++++++++++++++++---------
 include/linux/of_graph.h |  7 +++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 252e4f600155..5dbeccaabb86 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -608,15 +608,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
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
+		port = of_graph_get_local_port(parent);
 		if (!port) {
 			pr_err("graph: no port node found in %pOF\n", parent);
 			return NULL;
@@ -765,6 +757,28 @@ struct device_node *of_graph_get_remote_port(const struct device_node *node)
 }
 EXPORT_SYMBOL(of_graph_get_remote_port);
 
+/**
+ * of_graph_get_local_port() - get local port node
+ * @node: pointer to a local endpoint device_node
+ *
+ * Return: First local port node associated with local endpoint node linked
+ *	   to @node. Use of_node_put() on it when done.
+ */
+struct device_node *of_graph_get_local_port(const struct device_node *node)
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
+EXPORT_SYMBOL(of_graph_get_local_port);
+
 int of_graph_get_endpoint_count(const struct device_node *np)
 {
 	struct device_node *endpoint;
diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
index 01038a6aade0..1fdeb72c7765 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -54,6 +54,7 @@ struct device_node *of_graph_get_remote_port_parent(
 struct device_node *of_graph_get_remote_port(const struct device_node *node);
 struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint);
+struct device_node *of_graph_get_local_port(const struct device_node *node);
 #else
 
 static inline int of_graph_parse_endpoint(const struct device_node *node,
@@ -116,6 +117,12 @@ static inline struct device_node *of_graph_get_remote_node(
 	return NULL;
 }
 
+static inline struct device_node *of_graph_get_local_port(
+					const struct device_node *node)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 
 #endif /* __LINUX_OF_GRAPH_H */
-- 
2.26.0

