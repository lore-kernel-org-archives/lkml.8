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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3516DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF120775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjGc2Fb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgGAHnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgGAHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:43:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F6C061755;
        Wed,  1 Jul 2020 00:43:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s16so7565299lfp.12;
        Wed, 01 Jul 2020 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vhza9ZHeiMaCPs/6QRV0zm5dqFctu0tGjnrB9xohpRY=;
        b=jjGc2Fb5f5oGDiIof5sN1xI+8DKa0bOXujnT3GO1Br5PDOxSM+kEYWhbWtKT5KjtLH
         fnuP0+B6s6RWxdH8fetIqJQVdQszj3Kfa2RgnE8R4LUfey9OsKPmnZEFR3yWv2EieCT/
         WOnNnkbm+BfX4PlRgD886yD+mYts7JB/RQ0IxOe+r5++BznYspBgwtwGsEZ22TwBjdGu
         SdrqTH8eYsF5uFcscqmUvLAtf/x6yRe/9JD2PV7HMfo8BM0dfcw0NyUG/E38vWaD30SE
         Ox5oDna49wLaCwhpIpI1Jchp6ghjDWUxnTB/ZA8SeKl37pnCrXRIOKqakZK/wm85GiNh
         YpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vhza9ZHeiMaCPs/6QRV0zm5dqFctu0tGjnrB9xohpRY=;
        b=G1DTASZS2wWi1PKuG6B57aTKAAty4zbOGyxqciyhBU7XQ+zjGUgNd3SfvGNc8K8C/z
         +jKVXQWp1B+KqCt037Abs+FOwYk8a3yFy4c7SqsY9UAdOM1OVoZU+K7lOYyUv0J5hWoy
         iUa8pDh/HbPJPQOonqSHxMgCl/77/Lq9UBHR4jHWzZvvaY6qIqdYFUwgVtsGp8n9ci3c
         n2JBf1cNwVxOeEhFgRyl2+NiD2UWiHmdLi1dUazbi+GBw0/qfqS0FBqVXKxB/AGzxN1E
         pbYCpZ6eRCGfViVqj3jj1v72ourVtVyeJlysqpyOdTF6qjKwQI/h5/k7uLFofucPStKq
         CADw==
X-Gm-Message-State: AOAM531HcuCy+I0TXRwzWM9uwh4IJfrqe/P1Q04hKSXidtulkO3wBILb
        be4HTfFajWrQ822X/X4eHl4=
X-Google-Smtp-Source: ABdhPJxzWdx03z6LDNSI0qZvHK4dIxS6mE6LKiwnMXFfZ5H2XLyjhSUJJvI3F4HorF2xTzpmLloM7g==
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr13714003lfm.99.1593589381631;
        Wed, 01 Jul 2020 00:43:01 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e10sm1520881ljb.118.2020.07.01.00.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:43:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] of_graph: add of_graph_is_present()
Date:   Wed,  1 Jul 2020 10:42:31 +0300
Message-Id: <20200701074232.13632-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701074232.13632-1-digetx@gmail.com>
References: <20200701074232.13632-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases it's very useful to silently check whether port node exists
at all in a device-tree before proceeding with parsing the graph. The DRM
bridges code is one example of such case where absence of a graph in a
device-tree is a legit condition.

This patch adds of_graph_is_present() which returns true if given
device-tree node contains OF graph port.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/of/property.c    | 23 +++++++++++++++++++++++
 include/linux/of_graph.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6a5760f0d6cd..fed7229d9d9f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -29,6 +29,29 @@
 
 #include "of_private.h"
 
+/**
+ * of_graph_is_present() - check graph's presence
+ * @node: pointer to device_node containing graph port
+ *
+ * Return: True if @node has a port or ports (with a port) sub-node,
+ * false otherwise.
+ */
+bool of_graph_is_present(const struct device_node *node)
+{
+	struct device_node *ports, *port;
+
+	ports = of_get_child_by_name(node, "ports");
+	if (ports)
+		node = ports;
+
+	port = of_get_child_by_name(node, "port");
+	of_node_put(ports);
+	of_node_put(port);
+
+	return !!port;
+}
+EXPORT_SYMBOL(of_graph_is_present);
+
 /**
  * of_property_count_elems_of_size - Count the number of elements in a property
  *
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

