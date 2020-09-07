Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39713C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F094208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgIGR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:58:37 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:53474 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729410AbgIGR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:58:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8FD0218029135;
        Mon,  7 Sep 2020 17:58:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: knot81_1802507270ce
X-Filterd-Recvd-Size: 4548
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 17:58:21 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drivers core: Miscellaneous changes for sysfs_emit
Date:   Mon,  7 Sep 2020 10:58:08 -0700
Message-Id: <536145200969138069f3ba6f7ed9d0f09ba1609c.1599501047.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1599501047.git.joe@perches.com>
References: <cover.1599501047.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change a few additional instances that could use sysfs_emit that
the coccinelle script could not convert.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/class.c    |  2 +-
 drivers/base/cpu.c      | 18 +++++++++---------
 drivers/base/node.c     | 15 +++------------
 drivers/base/platform.c |  4 +---
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index bcd410e6d70a..c3451481194e 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -478,7 +478,7 @@ ssize_t show_class_attr_string(struct class *class,
 	struct class_attribute_string *cs;
 
 	cs = container_of(attr, struct class_attribute_string, attr);
-	return snprintf(buf, PAGE_SIZE, "%s\n", cs->str);
+	return sysfs_emit(buf, "%s\n", cs->str);
 }
 
 EXPORT_SYMBOL_GPL(show_class_attr_string);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 232f8146a8c4..d3dc48bf6b0f 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -241,30 +241,30 @@ unsigned int total_cpus;
 static ssize_t print_cpus_offline(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	int n = 0, len = PAGE_SIZE-2;
+	int len = 0;
 	cpumask_var_t offline;
 
 	/* display offline cpus < nr_cpu_ids */
 	if (!alloc_cpumask_var(&offline, GFP_KERNEL))
 		return -ENOMEM;
 	cpumask_andnot(offline, cpu_possible_mask, cpu_online_mask);
-	n = scnprintf(buf, len, "%*pbl", cpumask_pr_args(offline));
+	len += sysfs_emit_at(buf, len, "%*pbl", cpumask_pr_args(offline));
 	free_cpumask_var(offline);
 
 	/* display offline cpus >= nr_cpu_ids */
 	if (total_cpus && nr_cpu_ids < total_cpus) {
-		if (n && n < len)
-			buf[n++] = ',';
+		len += sysfs_emit_at(buf, len, "%s", ",");
 
 		if (nr_cpu_ids == total_cpus-1)
-			n += scnprintf(&buf[n], len - n, "%u", nr_cpu_ids);
+			len += sysfs_emit_at(buf, len, "%u", nr_cpu_ids);
 		else
-			n += scnprintf(&buf[n], len - n, "%u-%d",
-						      nr_cpu_ids, total_cpus-1);
+			len += sysfs_emit_at(buf, len, "%u-%d",
+					     nr_cpu_ids, total_cpus-1);
 	}
 
-	n += scnprintf(&buf[n], len - n, "\n");
-	return n;
+	len += sysfs_emit_at(buf, len, "%s", "\n");
+
+	return len;
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index f10e8236aba8..e6092b81644d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -945,17 +945,6 @@ void unregister_one_node(int nid)
  * node states attributes
  */
 
-static ssize_t print_nodes_state(enum node_states state, char *buf)
-{
-	int n;
-
-	n = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
-		      nodemask_pr_args(&node_states[state]));
-	buf[n++] = '\n';
-	buf[n] = '\0';
-	return n;
-}
-
 struct node_attr {
 	struct device_attribute attr;
 	enum node_states state;
@@ -965,7 +954,9 @@ static ssize_t show_node_state(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct node_attr *na = container_of(attr, struct node_attr, attr);
-	return print_nodes_state(na->state, buf);
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&node_states[na->state]));
 }
 
 #define _NODE_ATTR(name, state) \
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0e03168c657c..927047f9e6a4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1023,9 +1023,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	if (len != -ENODEV)
 		return len;
 
-	len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
-
-	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
+	return sysfs_emit(buf, "platform:%s\n", pdev->name);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.26.0

