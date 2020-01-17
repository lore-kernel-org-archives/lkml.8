Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F06C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C7320728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="oRpWP73u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgAQHoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:44:23 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:7136
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbgAQHoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:44:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5sr2tnAJ1/t5dcvqpOr8WUZLvJUmXLH/aDU+wzLwLwSI2Q8etjS/8tlg6ozdjL2n8f+uAKRXfBMs9LR1W3i0WDQQ3WHdvgPPjvm7E9LfgMMOBta0wuD6GQtYvS4CgPxf/FWwuukQIgsDh08Ltxx8v2j4WydD8nhqNsnuCDjbhC2I5/2TWz+jzF+WJPeRTWbsg8FMCQkgHe6MNw4s1sMKZkPY3+rEjUzb4YRrbnWJBb0bgygCjlZmRSwE/3vclZQIS0zKwgLrqVy9fYBPuJSbUgvG8JltWF9uEo8EFkMYDPJjL0jAYeZYVaiLi05d8RjEmtdbmkCgxxw7ufQztaCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjMruP9mh9FL9b0giCY/DE0kxv3dZI+2RI3EWWCYlic=;
 b=B4l3WGZCb1JGrtl/X1FwjrK/p9PRM1RemHfGD5Z71dMsFQf0SNFZhr9Xm0d/6SJ82vRc/xGWgB8VegQcnmei0D8RC7PB5elxk+G9FjCdxGdLXTFhg+agK8ljC2d4doofYO+hF3DrA9cZOW77lLmmmsMDemKtk5OcjZnIZGH3f14Z1ji1Z5fuTv49kDRfCRSm9Dn/VCR7WQeo0WtkyKw8dtKayC1C6vQwU5Sh431yTIo4y3yvizbbePXMLwa2PVd+FFyPIONGebRA7RC9wRGg6hr8F4Ze5xVySfipWsVatZOvXhV7nk5qndhfay/VdviI7V8kCKkEdyo4Jp7cJ5B+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjMruP9mh9FL9b0giCY/DE0kxv3dZI+2RI3EWWCYlic=;
 b=oRpWP73uxpsZ8Rf6K6mS0oeh53y+brmQdP/DfLffGjz3pAPRRYZ8GiG0s3oKrtOBHirMDTKO1LNaLv/iclUcEHzXdtDmSlrztvX11F3KlpL1J3pTUWy0zz/dSBtAPIV8SJa5p/ZtuwW7U9rVWGrlDIyw6ID1alSej6I2euNeLhA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3765.namprd13.prod.outlook.com (20.180.15.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Fri, 17 Jan 2020 07:44:13 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2644.021; Fri, 17 Jan 2020
 07:44:13 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, allison@lohutok.net,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bp@suse.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v4 2/2] riscv: Add support to determine no. of L2 cache way enabled
Date:   Fri, 17 Jan 2020 13:13:38 +0530
Message-Id: <1579247018-6720-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579247018-6720-1-git-send-email-yash.shah@sifive.com>
References: <1579247018-6720-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::18) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 07:44:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61429218-f104-4329-9d40-08d79b210b8f
X-MS-TrafficTypeDiagnostic: CH2PR13MB3765:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB376514BE5BE9D38FAAF23CE28C310@CH2PR13MB3765.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39850400004)(366004)(396003)(376002)(189003)(199004)(6512007)(2616005)(107886003)(316002)(956004)(5660300002)(52116002)(36756003)(16526019)(1006002)(6666004)(26005)(66476007)(66946007)(66556008)(186003)(6486002)(86362001)(8936002)(6506007)(44832011)(8676002)(81156014)(81166006)(4326008)(478600001)(7416002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3765;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpuJ1TSqzDt53M8nYr9xWnNV7c2vPwpgB1Pf8+i75TyyU+2+08E30gTi6+KyCBMu4+xGkUId89LeowCrAxl5AaIRjQc0txijs6klhcufWK1NnxV/vsWSai6y6XvZ5Tl8qjg1HKbAsvARWjt4mhL2waGEi5LeCbkuko67z5xPbOFPmj/+6Yc2t2Tm/DRTb6QCAwjVIZn4oCI4khOHUQ2LyDDgRwGcPqP/mQ+bsEGLocFiG2k2mVipicgkv52hq374Jgi2Thy8sTg7QNmEkxrNGzCWWH6SLK2eal12DyZTOV+gye1CGuYKxv4bonM739AevJ+bKd3W0lTOoBtfzSFua/fve0Xwt1W2HhwAwErJTUlLd51GqXxmZX6YM2fszXpJ8n43A/CCAqT6Q2zBd1PLqlQJ7IwEP58J0O0uUxD68T9rldm9sn+wXE9UFvaSAHhm
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61429218-f104-4329-9d40-08d79b210b8f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 07:44:13.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDzSpSQ3hFeiZiiCP6D+CNP+2fNu0zBd9FfOrGMZs0XR6b6EWUI+J/xSkz9ErYbvl/29RU2q6Yf8JxiUOAeIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3765
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
index a506939..3fb6404 100644
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
+	return readl(l2_base + SIFIVE_L2_WAYENABLE);
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

