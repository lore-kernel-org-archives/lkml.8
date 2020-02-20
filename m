Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86901C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F342465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="EQsjBlzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgBTFPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:15:50 -0500
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:13344
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbgBTFPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:15:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYNJj9Iw9dDPyPKU2cJAS7zYFB6C99N6M90rokzQ+e33QYWCkJslwejtsfzveATOmwLVJlsPBF3beeEV3kLTXb9OF/DUh87B/lVcv3DvMQZLLAvYI7IOqiZk61Ix4wQs+iknYQwUI6NTUBrBASUb9i5k47YzPi55DYuZxtOgTTeyvTAtd201Qk19RNCrzH/8KXCArRqr037C8ewqGdAe+navg+9mUGev03SDEBO7BW9OvVEnbj4CbiHVGwoKOTw+MQY4zBIWaHmxb4bMt+dVnp1WEpekv819phtv5LhxAg4bYgFndYaMUjo780+Rm1lvkfSQEowuEZM3YXFUNjQ3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY7dT9Uu4EIpwCcoMVNkJiqk6krljwcG6BPRo9t5UC4=;
 b=geAeDBDNFdh+GvSD9P5j7p4uGJgowXN6IFdinP9imBqyynWMAX2meOMisDvlsii9kTeICgsCk/ipXdI0JVRgR69SylibX5rRJi0n/7Sd7cPS2upaHwU2ltj/JdNhDGEoO3UOGYivcArKQmsuySAhTOHD/RM+4+KjR8l+hhuWcdcX8s2i7SWdwdYuYCABFMXV6K/BBgdX2oLjvemluyPUlI+TItMv2QxkJs9jsgYIuYNLHyquaIcGKVDO9L3FOPwzatIaiCpIatCJYzHShhzNkk8aBxXJuNlurau+UigfAAv3ufG1/rOnSSroApQH8cVDSyVuVU4PrQGPRh0qgNmZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY7dT9Uu4EIpwCcoMVNkJiqk6krljwcG6BPRo9t5UC4=;
 b=EQsjBlzziV+F4GeQRJXST24o5K3SwG+AvQfO+NGZU3NHt//9ja5uoMDSMgAwQG5h5KZtlI/SdNIsR+pBmjD0NG/Wx+cniPGLxQ89lDSCwIAd6Ziv6jMJIywbqOQCeKL7acO4aq/VnuS9/TiBZwn00ZWpNup86D3cY28F9NG9CzI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3495.namprd13.prod.outlook.com (52.132.247.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9; Thu, 20 Feb 2020 05:15:47 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::55a5:5dab:67de:b5d8]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::55a5:5dab:67de:b5d8%5]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 05:15:47 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, anup@brainfault.org,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        tglx@linutronix.de, bp@suse.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v5 1/2] riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
Date:   Thu, 20 Feb 2020 10:45:18 +0530
Message-Id: <1582175719-7401-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
References: <1582175719-7401-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: PN1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::26) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by PN1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 05:15:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6203326d-4c45-4095-b898-08d7b5c3f183
X-MS-TrafficTypeDiagnostic: CH2PR13MB3495:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB3495F3FBE3EA3190BFE19F428C130@CH2PR13MB3495.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39830400003)(136003)(396003)(376002)(366004)(199004)(189003)(4326008)(8936002)(316002)(81166006)(8676002)(5660300002)(6486002)(81156014)(52116002)(107886003)(6506007)(66946007)(2616005)(16526019)(6512007)(956004)(478600001)(2906002)(6636002)(66556008)(86362001)(186003)(6666004)(36756003)(66476007)(44832011)(26005)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3495;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8LeWa31iW0UYbvg6T4XGoekbPIDu66xper9yQjY2QRpj1Dqg9KUPFhFKKj4RLN8o4FwXLbiYxJwT7CvlKO5eJCzVVphovvdEpFHIhHYtQvxot4IaJ9CluI8zEuYZjbkWk+fzMmuJVqgpW29mJkwsK1mdTA+WZZaIOUo4wxVgoSyA2aAZcTSbZscKMTjZIm7cn8Rm7oM/AFu8kg3j4PZ26Q16iUKNiGYP8QmXB5KqGUaLY8+uX82CBemIl8jcWhRHmk1tUXA1I+rok5X7yBpg6GCZmusOaUby5DMKmmGPXn6eIaKkH5LMfTf9Gl3hnulLdvzeoMj3CMzLRhwMTMdlq3TvHoPcLyoIF58qlqmt4R5YwVlE1tz37tDjQwQLmJQpkHhanMrQoeTNwpMZ8yc5PM4EsYo3ru78Wls+QQe8HsKwo4B9+k9uq2l7xZrLIRfyJ1UxyAcjsXxBfbusfxq4gGMNIDE+TAqJU9JbblWXzc=
X-MS-Exchange-AntiSpam-MessageData: 6yr1W+aVLGVZX/Fh48kij4YXRwUlIexVzIMdHH/LtqDubK4hpNAMW5HnTM0JH2T8NMSLoyf5Sdj2oh//LaZfyQ4wxL8WR8wMQjcLO20QEmZKxGmWldbEaV0UNOqbi4d67IuYc8Hy+UGaLUBoMC8dbQ==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6203326d-4c45-4095-b898-08d7b5c3f183
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 05:15:47.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCr22S9gRiEqlkadTeKXZcsMtvEG4q2NkV07Egcvmzac4T3mv8VntU5OGXio3sFr/Xg0IYSFi+8tDBM5jXebDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3495
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

