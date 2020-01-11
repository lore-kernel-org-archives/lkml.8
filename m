Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61048C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 06:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303EB2072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 06:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgAKG5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 01:57:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728413AbgAKG5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 01:57:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 202AF6B31E8B1024BCDB;
        Sat, 11 Jan 2020 14:57:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 14:57:29 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <sudeep.holla@arm.com>
CC:     <linuxarm@huawei.com>, Zeng Tao <prime.zeng@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpu-topology: Skip the exist but not possible cpu nodes
Date:   Sat, 11 Jan 2020 14:53:40 +0800
Message-ID: <1578725620-39677-1-git-send-email-prime.zeng@hisilicon.com>
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
With CONFIG_NR_CPUS = 128 and cpus nodes num in device tree is 130,
The following warning messages will be print during boot:
CPU node for /cpus/cpu@128 exist but the possible cpu range is :0-127
CPU node for /cpus/cpu@129 exist but the possible cpu range is :0-127
CPU node for /cpus/cpu@130 exist but the possible cpu range is :0-127

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
Changelog:
v1->v2:
 -Remove redundant -ENODEV assignment in get_cpu_for_node
 -Add comment to describe the get_cpu_for_node return values
 -Add skip process for cpu threads
 -Update the commit log with more detail
---
 drivers/base/arch_topology.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5fe44b3..01f0e21 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -248,22 +248,44 @@ core_initcall(free_raw_capacity);
 #endif
 
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+/*
+ * This function returns the logic cpu number of the node.
+ * There are totally three kinds of return values:
+ * (1) logic cpu number which is > 0.
+ * (2) -ENDEV when the node is valid one which can be found in the device tree
+ * but there is no possible cpu nodes to match, when the CONFIG_NR_CPUS is
+ * smaller than cpus node numbers in device tree, this will happen. It's
+ * suggested to just ignore this case.
+ * (3) -EINVAL when other errors occur.
+ */
 static int __init get_cpu_for_node(struct device_node *node)
 {
-	struct device_node *cpu_node;
+	struct device_node *cpu_node, *t;
 	int cpu;
+	bool found = false;
 
 	cpu_node = of_parse_phandle(node, "cpu", 0);
 	if (!cpu_node)
-		return -1;
+		return -EINVAL;
+
+	for_each_of_cpu_node(t)
+		if (t == cpu_node) {
+			found = true;
+			break;
+		}
+
+	if (!found) {
+		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+		return -EINVAL;
+	}
 
 	cpu = of_cpu_node_to_id(cpu_node);
 	if (cpu >= 0)
 		topology_parse_cpu_capacity(cpu_node, cpu);
 	else
-		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+		pr_warn("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
+			cpu_node, cpumask_pr_args(cpu_possible_mask));
 
-	of_node_put(cpu_node);
 	return cpu;
 }
 
@@ -286,9 +308,8 @@ static int __init parse_core(struct device_node *core, int package_id,
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
@@ -307,7 +328,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 
 		cpu_topology[cpu].package_id = package_id;
 		cpu_topology[cpu].core_id = core_id;
-	} else if (leaf) {
+	} else if (leaf && cpu != -ENODEV) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
 		return -EINVAL;
 	}
-- 
2.8.1

