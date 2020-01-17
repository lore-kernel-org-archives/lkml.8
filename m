Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3FC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D68E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="mW6lK9ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgAQHoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:44:10 -0500
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:60705
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727804AbgAQHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:44:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn/GXslAc/iyvvOXk1DFl6FX+mp42fXmtHQbwK+BiCia+2ztuIdpC/SCeG8wp1wgADQy9zKTWwk88j64I6bEaKcSfMoVXuiBGYkgklYP32Ewl5syPk5cwCemcumFc4v1Slbe9vuAAn8XKN6X5hxlPUiIr8ATssCslMnSnfmAixbdzZMIKftLLgdh4jr/nqoZRO2dfaoVQH8dcDNE1pg1R+KnmUPRA+DSgf103f05J2SWBy8qsBttgrDSg+VRDbGpXMeWo3Z8MxwtAG6p7lk8xNdMHm2YC6XgA/GiHoU3dmoXvToz96wE47fpCYiI9/FENFG3nMweR79BtgbxJx9wKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY7dT9Uu4EIpwCcoMVNkJiqk6krljwcG6BPRo9t5UC4=;
 b=nCPrludUZhAqOWdsJaqakflSgAm4pW86Mk3sz1LRYrn7osbkO1FlyocCNq2pycApPIMiN2CKajNSoubXpZo6eYVTCS3oEbxaJ3vGvukZ4YYK/nwj1lQ/B/Q41T+ynJ/sQfpiNdRA6NVovTuypnJYkHTMsUUgWXUqECH2zL+I9NhPDbJoCu9MBDFXFwnpOGBjIbY3lotPJwIUibR14A5jpf6xcgNVnfPJ8zdEiIXPeFx8mTRLtOjrK6QCZnAi3JFMswR51ErHPjIY0C32HOw/BFo5cMnNsxYuKMTp7ndivtGMJGdb464RZ7nYMPIy2W8av2njHKe/JHvgMsJRlqTslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY7dT9Uu4EIpwCcoMVNkJiqk6krljwcG6BPRo9t5UC4=;
 b=mW6lK9uejF2pz0n6Q+WOGYkT53ZmV7XpGj9PgP7aWJqNsMXOTzs1NsdqfMaBlI5eD9XaG6wKZJkd+YKPO6Thz4aUEE5yZDoEqavTolHQQr3lKvtPZggBOj5D+y4K6AmmeZLeFP0iwEj27lHaWffjXehZw7Xyk2Nju7RAQg6R+NY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3765.namprd13.prod.outlook.com (20.180.15.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Fri, 17 Jan 2020 07:44:08 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 07:44:08 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bp@suse.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v4 1/2] riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
Date:   Fri, 17 Jan 2020 13:13:37 +0530
Message-Id: <1579247018-6720-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579247018-6720-1-git-send-email-yash.shah@sifive.com>
References: <1579247018-6720-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::18) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 07:44:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77398771-fe30-42b8-2c80-08d79b2108ca
X-MS-TrafficTypeDiagnostic: CH2PR13MB3765:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB3765F002E5F7321D3EE1F5BB8C310@CH2PR13MB3765.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39850400004)(366004)(396003)(376002)(189003)(199004)(6512007)(2616005)(107886003)(316002)(956004)(5660300002)(52116002)(36756003)(16526019)(1006002)(6666004)(26005)(66476007)(66946007)(66556008)(186003)(6486002)(86362001)(8936002)(6506007)(44832011)(8676002)(81156014)(81166006)(4326008)(478600001)(7416002)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3765;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QczVaYO2FIVaPbRRINN0oxy1XhfhN5JYMejIbDTkKDCZTW0vtOnifvUSNX4kYe1YAO+NXSbLeYRIko1q2XAVqw8C/x6wNoI6SVCcOb9+bi3ISji3KGs48weK10fVdtqOS02pmTrRjTsUHRrCCAFmIN/Nm0aEtlNDAvyHxD5hWtrsYdCEt0x3rAJGuzgP8CoPPsIsVJdVRjIZaloGcQlD4w95pP4bHmLC4zDFOxN2UvLEpeeyFCPHtrhrRZiQw3AvByo4klc0c6NqIgFr7mFpyOycPlRaUwS7wadPHav2PjpUOWZoN7gTxdUWjnGUYqUQM8bhuZb1qDq1DPWxrN6NLFL9tZWbveMNX6nzayeia4sX56HmiV7RfZTGcD9tU4iM2Xu7a9vkgHRvR9d1y9cy3EUlHbuFNtd164ssgjLZZy/QPU32Tv4TtNRdRnw794dICC7z8DkmyGKikoqy0FjJrBaSHMVThHhNky9iKYn2OTI=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77398771-fe30-42b8-2c80-08d79b2108ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 07:44:08.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywxWHEW4GKCSgyWSsVW1wo0p7C91cjGap/iPI1QeSZLzp2i0Mvi9wdu7OpIv9GAEIO0hU3bd7qj9KO2P3DPBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement cache_get_priv_group() that will make use of a generic ops
structure to return a private attribute group for custom cache info.

Using riscv_set_cacheinfo_ops() users can hook their own custom function
to return the private attribute group for cacheinfo. In future we can
add more ops to this generic ops structure for SOC specific cacheinfo.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/cacheinfo.h | 15 +++++++++++++++
 arch/riscv/kernel/cacheinfo.c      | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/riscv/include/asm/cacheinfo.h

diff --git a/arch/riscv/include/asm/cacheinfo.h b/arch/riscv/include/asm/cacheinfo.h
new file mode 100644
index 0000000..5d9662e
--- /dev/null
+++ b/arch/riscv/include/asm/cacheinfo.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_CACHEINFO_H
+#define _ASM_RISCV_CACHEINFO_H
+
+#include <linux/cacheinfo.h>
+
+struct riscv_cacheinfo_ops {
+	const struct attribute_group * (*get_priv_group)(struct cacheinfo
+							*this_leaf);
+};
+
+void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops);
+
+#endif /* _ASM_RISCV_CACHEINFO_H */
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 4c90c07..bd0f122 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -7,6 +7,23 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <asm/cacheinfo.h>
+
+static struct riscv_cacheinfo_ops *rv_cache_ops;
+
+void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops)
+{
+	rv_cache_ops = ops;
+}
+EXPORT_SYMBOL_GPL(riscv_set_cacheinfo_ops);
+
+const struct attribute_group *
+cache_get_priv_group(struct cacheinfo *this_leaf)
+{
+	if (rv_cache_ops && rv_cache_ops->get_priv_group)
+		return rv_cache_ops->get_priv_group(this_leaf);
+	return NULL;
+}
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
 			 struct device_node *node,
-- 
2.7.4

