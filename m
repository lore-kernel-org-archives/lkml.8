Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698A0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451492075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hknn1nl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404574AbgE2B40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:56:26 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48548 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgE2B4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590717380; x=1622253380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lq95wbME5tlX+TcoBEVkIXDmb7WeA/4am7B95qmISv4=;
  b=Hknn1nl7MRaQso42DvlQ2+iuEpDdsTvMdCaNfTKt58tywY3rt2H2xyO5
   S51be2qRRxI4ORb6aYQ5Ndf9EYO26/mElpYVSPWl1oFZeGZm33nWySHjV
   nmmvpsop0SnPEiurGSARleSNqEBaWwDFkm46cK5NZbyXJ9x7sJsuiDv69
   Y=;
IronPort-SDR: tOS+xtIRM09X5NTb1w6XwRPrA4comkSml2YS9WvClr6O4c/94E6dR9efhF31/MP+RXWIpIPedk
 NPYpBTGFF/dw==
X-IronPort-AV: E=Sophos;i="5.73,447,1583193600"; 
   d="scan'208";a="34269762"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 29 May 2020 01:56:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 97E97A20D3;
        Fri, 29 May 2020 01:56:05 +0000 (UTC)
Received: from EX13D02UWB004.ant.amazon.com (10.43.161.11) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 May 2020 01:56:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB004.ant.amazon.com (10.43.161.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 May 2020 01:56:04 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Fri, 29 May 2020 01:56:04 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 5907A228F8; Fri, 29 May 2020 01:56:04 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <benh@amazon.com>,
        <dwmw@amazon.com>, <zeev@amazon.com>, <zorik@amazon.com>,
        <alisaidi@amazon.com>
Subject: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Date:   Fri, 29 May 2020 01:55:01 +0000
Message-ID: <20200529015501.15771-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.1.AMZN
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an interrupt is disabled the ITS driver has sent a discard removing
the DeviceID and EventID from the ITT. After this occurs it can't be
moved to another collection with a MOVI and a command error occurs if
attempted. Before issuing the MOVI command make sure that the IRQ isn't
disabled and change the activate code to try and use the previous
affinity.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 124251b0ccba..1235dd9a2fb2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1540,7 +1540,11 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	/* don't set the affinity when the target cpu is same as current one */
 	if (cpu != its_dev->event_map.col_map[id]) {
 		target_col = &its_dev->its->collections[cpu];
-		its_send_movi(its_dev, target_col, id);
+
+		/* If the IRQ is disabled a discard was sent so don't move */
+		if (!irqd_irq_disabled(d))
+			its_send_movi(its_dev, target_col, id);
+
 		its_dev->event_map.col_map[id] = cpu;
 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	}
@@ -3439,8 +3443,16 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 	if (its_dev->its->numa_node >= 0)
 		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
-	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
+	/* If the cpu set to a different CPU that is still online use it */
+	cpu = its_dev->event_map.col_map[event];
+
+	cpumask_and(cpu_mask, cpu_mask, cpu_online_mask);
+
+	if (!cpumask_test_cpu(cpu, cpu_mask)) {
+		/* Bind the LPI to the first possible CPU */
+		cpu = cpumask_first(cpu_mask);
+	}
+
 	if (cpu >= nr_cpu_ids) {
 		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
 			return -EINVAL;
-- 
2.24.1.AMZN

