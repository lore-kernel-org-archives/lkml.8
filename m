Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD72C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAD42075A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="DNneaN1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2D0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:26:35 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:19572
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgG2D0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccT0BxaKSNJQ3hFt/z2S4EQlyiSlWsyGXv8UGG9hSUts1+IEZwweVMtXL6P4EFu6ZHKCo0saQ//xK+HTrboJ0APviYTvI/PS9WUYOGuqBslL1fwDqWmJGz7zqFBYRuBvWmtXEwt93MsLxal4WtXUzrQnWrGKjJic9m7hzwUH8GP7Nh6DlN8g1qgld+R2E7/kpv3KjPTxQdGZKaaA1XKr7QZoo2OOHXBWL+HaMj0CwZCV4oRTub6uwa4wwv6x+Tnrn3UhsAQ+sVOBti4wW7ulVDI/huX6PF4OssjxUnPvU7wEJhptNyz5eKK6ilSm2j2uqpgSbQNw3ehgqyAI9zWPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beDDC2FFCJYfat4HC/HAUqvfDbMTEF3uWim3iVtLpaw=;
 b=hqOacN7rLcFDI/1NyrKC/zuf6C1qBdv/osBH16dw//bBp6RW9frA/un1rbpNSYKr/s0UMAQcJK0xQf6kJcmuXVl2olI1FQ1q1eQ6g7lpFvI3jlWE2BVF4D0SGgp4vMczUyGDkdRa8pDWFS1EsepYuOnNz1Ne7rUYnkkwdlVGuAcorKF7DVlL8Uz7AWnZYy+SY9LBbsJZ3DhkFV/cpcjIYf2LYrqTNUgTTpDquKGQpjwbcSnK3IAaKwR6Um6mqcdsq+HqeD7/x+8xKRI2xQkuNoFv/7HHWBuKxq5oghPCMWniU3m2hV/DgiXXb4DQNIJ4tOD/GYn7en4W/yseeI2UaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.111.57) smtp.rcpttodomain=davemloft.net smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beDDC2FFCJYfat4HC/HAUqvfDbMTEF3uWim3iVtLpaw=;
 b=DNneaN1ObFFqjZfE2+9XSuLUIbOkBnMmop12roZTnU02OBhbU4ab7a7hO4BbMRs0P+Sl65LxoDDAE+2Xfov71yImxT3D2QZKuRZN6fnGzzq8zkKUFfxp/Ez19qaHLjpXNKxFrBVeB4bU6F8c8VFdRAPgwyben+ngwHPXE8PPntk=
Received: from AM6PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:20b:6e::30)
 by AM6PR10MB2405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 03:26:31 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::1c) by AM6PR02CA0017.outlook.office365.com
 (2603:10a6:20b:6e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Wed, 29 Jul 2020 03:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.111.57) smtp.mailfrom=diasemi.com; davemloft.net; dkim=none (message
 not signed) header.d=none;davemloft.net; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.111.57 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.111.57) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3216.10 via Frontend Transport; Wed, 29 Jul 2020 03:26:29 +0000
Received: from NB-EX-CASHUB01.diasemi.com (10.1.16.141) by
 DB-EX-CASHUB02.diasemi.com (10.0.16.142) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 29 Jul 2020 05:26:28 +0200
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 29 Jul 2020 05:26:27 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 B298513F670; Wed, 29 Jul 2020 12:26:25 +0900 (KST)
Message-ID: <e734833da0358c5401b25b6ab7506362986af913.1595991580.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1595991580.git.Roy.Im@diasemi.com>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 29 Jul 2020 11:59:40 +0900
Subject: [PATCH v18 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-MS-Office365-Filtering-Correlation-Id: bb0651c2-5f64-4ac6-04bd-08d8336f2edc
X-MS-TrafficTypeDiagnostic: AM6PR10MB2405:
X-Microsoft-Antispam-PRVS: <AM6PR10MB24056383EE9ACB03D6F299A0A2700@AM6PR10MB2405.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gK/g0h8MGRcTuRDqkFLne+jMr5/1YohOeVL3Y6NJy5+DQx1Df+kHMSwzcHy0TMD27TPwUItDMC9ftVLVqPdfa/+isML1tgo41QOk3cUx6BMhGAokv1Ft8gB7hmCxKDhXMRoF1lkDuNQnsN32zmdcTMO0H+6iRNZreo1jPhCBsLAZGnxL+h2JcGRfRsxw32GBIImhbI4uvS6yClQxkl2yqU99gA+7RQBs4VK8UzE0qdYrkiYkcIyaj7mdIAOjm8+Gr8rc8zDrfM1y9kq9wSG2payyvycPpEgfNEwXg9xBIa3Zk6MB9v9v1Ll7UVjtqRQOQxOUqOVounxjaP6ZsimfzwM5A3bY8Aho7TX+LEbVT9mO2E6xiOiZU3TKDUglD4mPhVGdVf7cMN5BQIN1ELh95WZfNfc0ck2oP/n5M5kU5eIkc83/wRj1FxnWJVW8OnKvrAmvPMS3twstJTCrFoZBEXPhBKUVb4+xdjOMdCmBTNcyFvyrWFAy+bFKcVRrHvH
X-Forefront-Antispam-Report: CIP:193.240.111.57;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(396003)(39850400004)(46966005)(110136005)(478600001)(54906003)(4326008)(5660300002)(86362001)(316002)(2906002)(6266002)(33310700002)(356005)(36906005)(6666004)(36756003)(966005)(83380400001)(107886003)(82740400003)(2616005)(26005)(186003)(8936002)(426003)(70206006)(8676002)(81166007)(42186006)(82310400002)(70586007)(336012)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 03:26:29.1101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0651c2-5f64-4ac6-04bd-08d8336f2edc
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.111.57];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
index f0569cf..6d76a80 100644
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
end-of-patch for PATCH v18

