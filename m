Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7304EC3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC8A2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="GHDiX1rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBTFPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:15:55 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:7660
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbgBTFPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:15:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/ubmjYucYfsR7YIss+uswxuDNo+RbEAcolnEm6AK2soJ+5vb5hLWFnlxYWS82AcFgZ70q3vwBjtxqCuEINpHPEgkjNlO50xlnsimCM8DeKv2zRI3dB3JVbQ56n64VW5X+GKZM8ONQ5APB/abTXqZGeYkMw2FiKFjytmYyPdihwEu28n3l3T53z3YxMDwlT+Z3MiaQ7o2eDdEr1yPbMrXrt7Dw7wK98G1cdt2v1kIkItJRFv/xVsYrafnOKOTA07Km/N0Ff0vICYFKLzDBXZIQPJgDOjlnOQ5cNhjTpVvKby8cESH6YlFH3STzdxpkEY3pRDiUkSuxTUZACH7ndCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xOvjZiGP6zoQ1MkHQtQAZWh2nhYYRoTfyln8AZbqL0=;
 b=O9BrcNtCCYq58tj0l8oo1UB9wGP8ZHiH27wvv1WYyvEMDpbf9+2SC3KBr5n7A0jSjgYkcPUbDdcYZWN5HK9jxoqhp/1AgOjtrM7MHMi1WHWEea0dTl5w/iBFzDmVOA9iTBYOc9Yyd/t5OQHda+WVoIv4Cdk6g34iAWSwzl0bSq3CQnyy7oSD4+8DR9G2UoG3L+/LaIx5GC+SA8ZDeoe6iMDafV9LIPLyOZdEjrLrWG30b7mgzEEiPzddUGV4OZOiWwY8sqWzfA2f9/9nTCGE0pub/v/lUisc9Qqdv6RuLCOfZXBy13fvJzBNjfiHA6pVDzgoUyNwTY6CfuNWRfqxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xOvjZiGP6zoQ1MkHQtQAZWh2nhYYRoTfyln8AZbqL0=;
 b=GHDiX1rcSoS8R2NobD9L4ZwERoJcFxXk+0Oc77bX5wDt3VGHxugPrB2tGHbq3hktqzuKHHmC5s1K6xEHto5eFHfpdNNOceybuGZJhnsdkfU0zL/xi2yRW/DxP1eB18n0p2o5boeEbNeaUiRVOTYsMUhpdDjZ+V9b8UBQDUgeQd0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3495.namprd13.prod.outlook.com (52.132.247.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9; Thu, 20 Feb 2020 05:15:52 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::55a5:5dab:67de:b5d8]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::55a5:5dab:67de:b5d8%5]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 05:15:52 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, anup@brainfault.org,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, bp@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v5 2/2] riscv: Add support to determine no. of L2 cache way enabled
Date:   Thu, 20 Feb 2020 10:45:19 +0530
Message-Id: <1582175719-7401-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
References: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: PN1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::26) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by PN1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 05:15:48 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6404fcf-f9f9-48c6-e091-08d7b5c3f47a
X-MS-TrafficTypeDiagnostic: CH2PR13MB3495:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB349560C5A7FEE3E8BD07171E8C130@CH2PR13MB3495.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39830400003)(136003)(396003)(376002)(366004)(199004)(189003)(4326008)(8936002)(316002)(81166006)(8676002)(5660300002)(6486002)(81156014)(52116002)(107886003)(6506007)(66946007)(2616005)(16526019)(6512007)(956004)(478600001)(2906002)(6636002)(66556008)(86362001)(186003)(6666004)(36756003)(66476007)(44832011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3495;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtYDzZ+TxBsXMEDw3nr/MShbAqzzkXhvYg9h3hKgXfx2yuswgr/Kin4MAhOa8pjWdmyzJ+BIvPQo90G2NIZsCGuDaxqvJqOu3y73sFlfV7zPDaYhTM3wcLLxsKTXaNkzaf8XHKnzJHGru2YRftuqfAueW4S27J+/sfcN6sWzM5vNtVtWNTkF5GcncQT2eu8XqaRs3rjVVjDenyE5/yuOohyzt016YfbSEla4lGLul3xw3rmKLIwe1j2pF0BYETfoj+Vm4yi2yZt214wjBpJh6RQeXx+3080QLekxZSvngHU0c0B7v9KVp7zbS4NcCVXIeJT0bH1DADvUmNXBhOwPKHvkmfOHU7GB58JslIV9nkdBVGMUCskupSbX54yCHDyj6mV6sXdrmceWLQop/1anf9PL+u9U84qylia12U3LWvgEJl6LLcxwELb5CN0zhLSW
X-MS-Exchange-AntiSpam-MessageData: nhfeVx8tQ94RVhqv40N0j8aGodAO8YxT7Ojq0iOZg1ZsIUIzVk3mlpCoE9nlec3zLpgfNz71xuJUyjQ1oCX3kNRkla5YfVOeDkFHvUMqP7fFIHC9ueXuYuxp25CnbOMZyycfD8qOdqrAgden6SeqsA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6404fcf-f9f9-48c6-e091-08d7b5c3f47a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 05:15:52.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqO0H684z/kqUyaUL+Z1N8t47Mn2yGICnI6zbiRGgON61LeVOOHWmes4sBF/ejVl2FvDcs3KxC9Uezuqm/cmhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to determine the number of L2 cache ways enabled at runtime,
implement a private attribute ("number_of_ways_enabled"). Reading this
attribute returns the number of enabled L2 cache ways at runtime.

Using riscv_set_cacheinfo_ops() hook a custom function, that returns
this private attribute, to the generic ops structure which is used by
cache_get_priv_group() in cacheinfo framework.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 drivers/soc/sifive/sifive_l2_cache.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index a506939..d5f2665 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -9,6 +9,8 @@
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/device.h>
+#include <asm/cacheinfo.h>
 #include <soc/sifive/sifive_l2_cache.h>
 
 #define SIFIVE_L2_DIRECCFIX_LOW 0x100
@@ -31,6 +33,7 @@
 
 static void __iomem *l2_base;
 static int g_irq[SIFIVE_L2_MAX_ECCINTR];
+static struct riscv_cacheinfo_ops l2_cache_ops;
 
 enum {
 	DIR_CORR = 0,
@@ -107,6 +110,38 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
 
+static int l2_largest_wayenabled(void)
+{
+	return readl(l2_base + SIFIVE_L2_WAYENABLE) & 0xFF;
+}
+
+static ssize_t number_of_ways_enabled_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sprintf(buf, "%u\n", l2_largest_wayenabled());
+}
+
+static DEVICE_ATTR_RO(number_of_ways_enabled);
+
+static struct attribute *priv_attrs[] = {
+	&dev_attr_number_of_ways_enabled.attr,
+	NULL,
+};
+
+static const struct attribute_group priv_attr_group = {
+	.attrs = priv_attrs,
+};
+
+const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
+{
+	/* We want to use private group for L2 cache only */
+	if (this_leaf->level == 2)
+		return &priv_attr_group;
+	else
+		return NULL;
+}
+
 static irqreturn_t l2_int_handler(int irq, void *device)
 {
 	unsigned int add_h, add_l;
@@ -170,6 +205,9 @@ static int __init sifive_l2_init(void)
 
 	l2_config_read();
 
+	l2_cache_ops.get_priv_group = l2_get_priv_group;
+	riscv_set_cacheinfo_ops(&l2_cache_ops);
+
 #ifdef CONFIG_DEBUG_FS
 	setup_sifive_debug();
 #endif
-- 
2.7.4

