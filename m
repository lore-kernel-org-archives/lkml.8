Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B3DC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F3020674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQGdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:33:54 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:35508 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgCQGdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:33:53 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 2F4F9345;
        Tue, 17 Mar 2020 14:33:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30131T140169344710400S1584426789590745_;
        Tue, 17 Mar 2020 14:33:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f78793f1b0da05f9d036f31a68ad4d38>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     linux-kernel@vger.kernel.org
Cc:     anders.roxell@linaro.org, arnd@arndb.de, sboyd@kernel.org,
        gregkh@linuxfoundation.org, naresh.kamboju@linaro.org,
        daniel.lezcano@linaro.org, Basil.Eljuse@arm.com,
        mturquette@baylibre.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] arch_topology: Fix putting invalid cpu clk
Date:   Tue, 17 Mar 2020 14:33:08 +0800
Message-Id: <20200317063308.23209-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sanity check before putting the cpu clk.

Fixes: b8fe128dad8f (“arch_topology: Adjust initial CPU capacities with current freq")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Correct fixes commit's commit id

 drivers/base/arch_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8a9fe2bc8635..4d0a0038b476 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -176,11 +176,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial freq_factor value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk))
+		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
 			per_cpu(freq_factor, cpu) =
 				clk_get_rate(cpu_clk) / 1000;
-
-		clk_put(cpu_clk);
+			clk_put(cpu_clk);
+		}
 	} else {
 		if (raw_capacity) {
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
-- 
2.11.0



