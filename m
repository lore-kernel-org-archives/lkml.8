Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A567C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7E222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgAPBvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:51:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729949AbgAPBvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:51:55 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 222A5FDB6804EAE21C5B;
        Thu, 16 Jan 2020 09:51:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 09:51:44 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <sudeep.holla@arm.com>
CC:     <linuxarm@huawei.com>, Zeng Tao <prime.zeng@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cpu-topology: Skip the exist but not possible cpu nodes
Date:   Thu, 16 Jan 2020 09:47:35 +0800
Message-ID: <1579139255-29262-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the device
tree, all the cpu nodes parsing will fail.
And this is not reasonable for a legal device tree configs.
In this patch, skip such cpu nodes rather than return an error.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
Changelog:
v2->v3:
 -Fix the Review comments by sudeep, including fix typo, remove redundant check
 logic, change the warning print level etc.
v1->v2:
 -Remove redundant -ENODEV assignment in get_cpu_for_node
 -Add comment to describe the get_cpu_for_node return values
 -Add skip process for cpu threads
 -Update the commit log with more detail
---
 drivers/base/arch_topology.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5fe44b3..d4302a1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -248,6 +248,16 @@ core_initcall(free_raw_capacity);
 #endif
 
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+/*
+ * This function returns the logic cpu number of the node.
+ * There are basically three kinds of return values:
+ * (1) logic cpu number which is > 0.
+ * (2) -ENODEV when the node is valid one which can be found in the device tree
+ * but there is no possible cpu nodes to match, when the CONFIG_NR_CPUS is
+ * smaller than cpus node numbers in device tree, this will happen. It's
+ * suggested to just ignore this case.
+ * (3) -1 if the node does not exist in the device tree
+ */
 static int __init get_cpu_for_node(struct device_node *node)
 {
 	struct device_node *cpu_node;
@@ -261,7 +271,8 @@ static int __init get_cpu_for_node(struct device_node *node)
 	if (cpu >= 0)
 		topology_parse_cpu_capacity(cpu_node, cpu);
 	else
-		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
+			cpu_node, cpumask_pr_args(cpu_possible_mask));
 
 	of_node_put(cpu_node);
 	return cpu;
@@ -286,9 +297,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 				cpu_topology[cpu].package_id = package_id;
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
-			} else {
-				pr_err("%pOF: Can't get CPU for thread\n",
-				       t);
+			} else if (cpu != -ENODEV) {
+				pr_err("%pOF: Can't get CPU for thread\n", t);
 				of_node_put(t);
 				return -EINVAL;
 			}
@@ -307,7 +317,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 
 		cpu_topology[cpu].package_id = package_id;
 		cpu_topology[cpu].core_id = core_id;
-	} else if (leaf) {
+	} else if (leaf && cpu != -ENODEV) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
 		return -EINVAL;
 	}
-- 
2.8.1

