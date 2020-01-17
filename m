Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC503C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D852073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPtoIYGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAQJ7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:59:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38167 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAQJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:58:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so6907933wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IimwIZWWa1VVuWQv/hNX0pZ26OrvQk2Ht7ELq9Rp8kU=;
        b=sPtoIYGgKgbKnmSo9AtWDGiCuHSmO5L294/W3C2j92HNEh7QAMJFnM+oJTjnRVUzvj
         Q9mOgBpiVZWbraG3mi94QLdB6b55VI475xn1NkvGGeQFtii1vviWdNHoOfQt85KAnC9K
         CCvTjSwDR3pFtrPQxtQGLAefeCqxZi3+B4A2kRaCTF7WFRtPEYdOtcmbhIVH9qaQbISO
         1QjvuU1RTOlHo4Fpj0RfZ/875g39n9fC9WEuhSYWsqcEeAfpYK370w9CJEAbMNzx2mLD
         PbcuUkkN7KkOQv+dIKNJY9Sp0sfBP0dKjPSyqwTYsY12T/EYe1eFjULCfyXqQ8531/BI
         nKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IimwIZWWa1VVuWQv/hNX0pZ26OrvQk2Ht7ELq9Rp8kU=;
        b=H7r38H0BngJ+R735INulZOFU99ZU5BiFWnCkQ0Q6k3jM7Me+0QrWRF5RqYG+RfIEMC
         R81KrVKv+uWpZS1R5kfjxnriddMOEZ+uveEImhDddMZvIw5b3pAiFHr3JGOC4IO2BKll
         2mfw9umGu1H6Qgkdt55n/DlFFkN6XDmUsHKFqsaqb0mSwcQNfxh9NrosnyYf2L9RER/9
         8MbHANsT8F+9vlBlnrGxjhWj3z2ECK4qPGhidPOpSf8yZAef04hu8tVXg9BW9/gUyzDb
         zWtfdv14AFvO5eW5oWsgCtDMCOFDVrkAX5GPeCnxBbxpvT+oaUEsjvksf6F+YSFOiMVl
         aJog==
X-Gm-Message-State: APjAAAVZOq86gnYfZrF20GHnkLjjBVYPpwEjlIzW/r9RXbIA80HgyRub
        I/MDYkiADxesHXA5yZFOVt1/CckHZa4=
X-Google-Smtp-Source: APXvYqyJqeYqOx1EGqfxZtobmXX5KKSqDMm15dAMTEW8mxEziDijPrt5c6EvACASyGYl51sdTJc7GA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr3620817wme.67.1579255109154;
        Fri, 17 Jan 2020 01:58:29 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:28 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 08/12] interconnect: Add interconnect_graph file to debugfs
Date:   Fri, 17 Jan 2020 11:58:12 +0200
Message-Id: <20200117095816.23575-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

The interconnect graphs can be difficult to understand and the current
"interconnect_summary" file doesn't even display links in any way.

Add a new "interconnect_graph" file to debugfs in the graphviz "dot"
format which describes interconnect providers, nodes and links.

The file is human-readable and can be visualized by piping through
graphviz. Example:

ssh $TARGET cat /sys/kernel/debug/interconnect/interconnect_graph \
	| dot -Tsvg > interconnect_graph.svg

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/driver-api/interconnect.rst | 22 ++++++++
 drivers/interconnect/core.c               | 66 +++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index cdeb5825f314..5ed4f57a6bac 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -91,3 +91,25 @@ Interconnect consumers are the clients which use the interconnect APIs to
 get paths between endpoints and set their bandwidth/latency/QoS requirements
 for these interconnect paths.  These interfaces are not currently
 documented.
+
+Interconnect debugfs interfaces
+-------------------------------
+
+Like several other subsystems interconnect will create some files for debugging
+and introspection. Files in debugfs are not considered ABI so application
+software shouldn't rely on format details change between kernel versions.
+
+``/sys/kernel/debug/interconnect/interconnect_summary``:
+
+Show all interconnect nodes in the system with their aggregated bandwidth
+request. Indented under each node show bandwidth requests from each device.
+
+``/sys/kernel/debug/interconnect/interconnect_graph``:
+
+Show the interconnect graph in the graphviz dot format. It shows all
+interconnect nodes and links in the system and groups together nodes from the
+same provider as subgraphs. The format is human-readable and can also be piped
+through dot to generate diagrams in many graphical formats::
+
+        $ cat /sys/kernel/debug/interconnect/interconnect_graph | \
+                dot -Tsvg > interconnect_graph.svg
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 03625406c69f..63c164264b73 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -71,6 +71,70 @@ static int icc_summary_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(icc_summary);
 
+static void icc_graph_show_link(struct seq_file *s, int level,
+				struct icc_node *n, struct icc_node *m)
+{
+	seq_printf(s, "%s\"%d:%s\" -> \"%d:%s\"\n",
+		   level == 2 ? "\t\t" : "\t",
+		   n->id, n->name, m->id, m->name);
+}
+
+static void icc_graph_show_node(struct seq_file *s, struct icc_node *n)
+{
+	seq_printf(s, "\t\t\"%d:%s\" [label=\"%d:%s",
+		   n->id, n->name, n->id, n->name);
+	seq_printf(s, "\n\t\t\t|avg_bw=%ukBps", n->avg_bw);
+	seq_printf(s, "\n\t\t\t|peak_bw=%ukBps", n->peak_bw);
+	seq_puts(s, "\"]\n");
+}
+
+static int icc_graph_show(struct seq_file *s, void *data)
+{
+	struct icc_provider *provider;
+	struct icc_node *n;
+	int cluster_index = 0;
+	int i;
+
+	seq_puts(s, "digraph {\n\trankdir = LR\n\tnode [shape = record]\n");
+	mutex_lock(&icc_lock);
+
+	/* draw providers as cluster subgraphs */
+	cluster_index = 0;
+	list_for_each_entry(provider, &icc_providers, provider_list) {
+		seq_printf(s, "\tsubgraph cluster_%d {\n", ++cluster_index);
+		if (provider->dev)
+			seq_printf(s, "\t\tlabel = \"%s\"\n",
+				   dev_name(provider->dev));
+
+		/* draw nodes */
+		list_for_each_entry(n, &provider->nodes, node_list)
+			icc_graph_show_node(s, n);
+
+		/* draw internal links */
+		list_for_each_entry(n, &provider->nodes, node_list)
+			for (i = 0; i < n->num_links; ++i)
+				if (n->provider == n->links[i]->provider)
+					icc_graph_show_link(s, 2, n,
+							    n->links[i]);
+
+		seq_puts(s, "\t}\n");
+	}
+
+	/* draw external links */
+	list_for_each_entry(provider, &icc_providers, provider_list)
+		list_for_each_entry(n, &provider->nodes, node_list)
+			for (i = 0; i < n->num_links; ++i)
+				if (n->provider != n->links[i]->provider)
+					icc_graph_show_link(s, 1, n,
+							    n->links[i]);
+
+	mutex_unlock(&icc_lock);
+	seq_puts(s, "}");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(icc_graph);
+
 static struct icc_node *node_find(const int id)
 {
 	return idr_find(&icc_idr, id);
@@ -827,6 +891,8 @@ static int __init icc_init(void)
 	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
 	debugfs_create_file("interconnect_summary", 0444,
 			    icc_debugfs_dir, NULL, &icc_summary_fops);
+	debugfs_create_file("interconnect_graph", 0444,
+			    icc_debugfs_dir, NULL, &icc_graph_fops);
 	return 0;
 }
 
