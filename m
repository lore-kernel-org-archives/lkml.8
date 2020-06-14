Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93931C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B12B20776
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuuwpiMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFNRXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgFNRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:23:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43EBC03E969;
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so8133555lfe.11;
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AU8aHNXSJicC/3mJ6DI0lDrv2zkNv1iB0kltJtsuQAw=;
        b=EuuwpiMkbbMKMls8xVM/R+dW4jTSovpLjRK+sPtMRrFMpHoHw/kpM0xivjB5l+3Wu3
         XcUOjOxZDNoxCm9oFseCYWGMQ4vKztSVSKaiiekr0ZHPjmq71USjRbt3J8TPe3Km7Gqj
         86xW1PapknQ65as28VSKdVfcrouIaRfG8tcHkG1XO8H0q1TQP2ev6QgYkXmf6yzttsN1
         3+Qt1QJ4OnQcEEPRzCq/I/qpa7toX5wmOqFyYeMQJA8iqB8HECwkI+b4byv4eW8aSFdx
         DUVNa2qUVBn5Ue4ihyiX2OKpG5BslNmisbchP8GEm4WR8NFbkSb1bIk8yMxj4seYeMQ+
         BnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AU8aHNXSJicC/3mJ6DI0lDrv2zkNv1iB0kltJtsuQAw=;
        b=eeBSXGKi3DXR/LZf/FiX1GakNu6yNfWK13KXlMNYSgXGJlX3wx6BGj7+egKmpdOo4B
         zy6HfjhZr5yqUxVCcr8VA55rm5O5Ip+kTn3vIMcibJz3k2f0NuVxJ2p8N13SQ/ZSAzzU
         auyIIV3tFY1KR/WxUBrUyskPqCKtikPOOAiFraWoF+Z/DNNyh5oHKN/+Gni8LmNaNmP8
         5Yxz+GUzr4Ixb10sCMm0l9nCY6LvxoPl1wM6fDP1NvLAe3cDiB8TgVSRhHOERTfsd3F8
         Fyo5JDZdk/lu7zd5dal9zaojMqpTs6hZAkB207Bi/tfC7ikkXjF8mAO5CztyNMe17OXY
         SAAQ==
X-Gm-Message-State: AOAM531OAz+w++6CWcD2fL5qXrQ7j2imWHGJEKoKL9PJHsRbj53VV0eD
        Ay8HmFuRQyLQIx1TDxeaotU=
X-Google-Smtp-Source: ABdhPJzCKQtPD6hDheFX6eXjxf0eeSg/hLqj0WyObz6WVWCknsTBezAKbLQH2/+sU3UDZqxB0Q3JGg==
X-Received: by 2002:a19:356:: with SMTP id 83mr11724834lfd.179.1592155399430;
        Sun, 14 Jun 2020 10:23:19 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id m14sm55144lfp.18.2020.06.14.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:23:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/6] of_graph: add of_graph_get_local_port()
Date:   Sun, 14 Jun 2020 20:22:29 +0300
Message-Id: <20200614172234.8856-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614172234.8856-1-digetx@gmail.com>
References: <20200614172234.8856-1-digetx@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/of/property.c    | 32 +++++++++++++++++++++++---------
 include/linux/of_graph.h |  7 +++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 1f2086f4e7ce..05c5f619b8bb 100644
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

