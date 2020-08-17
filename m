Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5BCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EED20639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="01/shgT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHRGs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:48:28 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:28824
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgHRGsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCfsMFWxy8xeHce9EXV0estMZB/aNo4oKhmIBAp8i13hQqu0Hvd18JYoTkorNieLP0jdCmZuQ48uYKz+MRd2kyDy6AQrYOlsQC1zHQ1Cz+F8odCg+F2X8oHZh4WD1A9q/saMFwl7Yx2/g2rdWel9owPoe4u04TMO3fB0/Q+G1WU/wlmxCxzA3TNtAgVBYI+bChlSDGlggwkYIFRlzSPGtA4Sux2CAfLZkgiDlCcZHnle9DAn2zX9w8ksgQ1meUjjGKTP+5YSga9P1Bnr9JRbg39Y1wrpzr1ekQwg0pK/zYH1C413+0kbhnF9oMPrxQLTrK5GmvYcEl2FEUByu0to3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPrTYZVH1G+G/OS/3YmI5YCL8W9JtFq7DF94lCvM4Go=;
 b=QDoykQSQ3b00fKZXwhEJLGQJ1GxdARv6G3KpcoFioY208xlztdlqcGMhzjZxR1j6tcI0n8dhyo7Dpe3mlsKYkLRUIH58qT/T3JKvDNFTfeHB1QuCvJUdCtlYYYwC+HeKHNrssE4IHwprs3Wg5EgZiqBkJR6dLrAldCkVzGaGumVEZ28/80VzxcMtWDnGeMlkRQydf131OO0GKQ9Hz3RO/xH2lrW6zMrCoKjHUV+PruJYlqMGNK5fG191NDck4GIA/2V1W5f08Bc5vRYZbOBaTExUCeHboLcQqIvVJeD3RXweRUuL9J5leKSCGwLGnA864tmvzN68LZyDFkfQjGNDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=neutral (sender ip is
 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPrTYZVH1G+G/OS/3YmI5YCL8W9JtFq7DF94lCvM4Go=;
 b=01/shgT/AHy/2WzGuC/L8alHP4fbOx6/pd9yEMFJoy7fhgXzk8LUYe6+P7J2kbPl3DkqTg4w5H/nW4n/ALMeMl1IPG+gnAFYsto7fcusKVbSDUl2zmAK8zZmZ6WI/LmLtaL64zTZDShPxNLNiMbU/ZCAcv2cBjcHUeARUHy4q8M=
Received: from MR2P264CA0177.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::16) by
 DB8PR10MB3815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Tue, 18 Aug 2020 06:48:21 +0000
Received: from VE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:501:0:cafe::5a) by MR2P264CA0177.outlook.office365.com
 (2603:10a6:501::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 06:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=neutral (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: Neutral (protection.outlook.com: 193.240.239.45 is neither
 permitted nor denied by domain of diasemi.com)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT031.mail.protection.outlook.com (10.152.12.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 06:48:20 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 18 Aug 2020 08:48:16 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 5A5FC13F670; Tue, 18 Aug 2020 15:48:15 +0900 (KST)
Message-ID: <4f9843d978aebfde7f0b25f9059c66a5f29bfdf0.1597706056.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1597706056.git.Roy.Im@diasemi.com>
References: <cover.1597706056.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 18 Aug 2020 08:14:15 +0900
Subject: [RESEND PATCH v19 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7470763-b047-4eb9-15d7-08d84342b24e
X-MS-TrafficTypeDiagnostic: DB8PR10MB3815:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3815489F9E3E303B9FDDF857A25C0@DB8PR10MB3815.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7Hz/Q+uA2ClhppcOv2ZHFYUxb0TyxpYrMIPOrfdnosxRHzilA0SzU0eWxJSnvWfvz4wWn9EpOEmXjF+EMhU3QJ6teLwu9nG11DREq0GhAoBaQVYL9crR+AUd8mb0BMf6+8B2e8lPHUSLutf4fGG2rneZHnMwjmHtEHtDGHsEVCfcLcXRG0xbBPUZdiL8HFCe0ZmHoGC5JdfZiIn3JJ5U9UbLfbaVZuQ7Lv7zrHNvuSwiUuHHZNk0qvSH/nFr2lSyIv3lSPpQtCC983Bn4/2cxe1rVhy6jly3Ow9yCFOxbBursCpgAgpmdpM6Ukt1G7J8UnBNyTcKGgG8OFt4q2hLpsEgD2qKH2p+Zi2WIEGJ9W8hkj+AC/WdWCd3tqda8rBD1hzlaM9ZPXPOCJycpeGqwGUFMEBIZ4pC/H3/ztB9x4DG6cOMGe53hC5StKHGawOwC3LoaqhZjC5Vjd5RiR/y7BC4W3fzXzLHx8qvsZT+XT/J2pRm21iOfB94Jmekve6
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966005)(36906005)(6266002)(966005)(336012)(8676002)(316002)(107886003)(54906003)(36756003)(478600001)(83380400001)(186003)(356005)(8936002)(82740400003)(33310700002)(70206006)(70586007)(5660300002)(4326008)(86362001)(110136005)(26005)(2616005)(42186006)(47076004)(81166007)(82310400002)(2906002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 06:48:20.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7470763-b047-4eb9-15d7-08d84342b24e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v19: No changes.
v18: No changes.
v17: No changes.
v16: No changes.
v15: No changes.
v14: No changes.
v13: No changes.
v12: Corrected file list order.
v11: No changes.
v10: No changes.
v9: No changes.
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698c..81a9416 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5003,6 +5003,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5013,6 +5014,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for RESEND PATCH v19

