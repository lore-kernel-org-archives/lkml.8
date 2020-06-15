Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1430C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A647420679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="1ExsCQQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgFOMBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:01:05 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:18182
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729785AbgFOMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI8ctuQPQIy/TZSwo5zCxCHoK3Dzbz4TECDhqOR9iCd2MeNvmyGZtPs33c2dFu/LO8IDtDoRvZ0eqm9tW9kS+nuHNt59IDTVvJYWWQ0VdODJROtZqfuR04c56ADV6R4C6RRTFGAELEG3MxItiZx9Ik/aASkI7Mom2yOpvW6KGYgWCQlJr7bUKai1JbpMPy1GI02AN8hrbIKOfS0Ti+IEYY2kr+o3LmPKkzZ6osNkdDC5jXo7RnphiVOgR8d2i8xTR2sw701HwWctGC3hX98HFxwszDZ+Wsj7zhIZjFG2KAA0kcfnH8rAPQSIpSVu87aqumzimp4dSnzL8D/ulQu/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8+sjrFiPYc6fEfNQb4Cj7QVaXxX8RkEfApcGgT1EQ0=;
 b=bcRDHJ9f4FEW5RACfZf3PxiL15xzTcD8UfnNEQ8hMF8u2aWUZl5S3iH74qO4rr9L3Lq/m+wOClw8YTYNtplnqJwQ263T8tkbUw3ltd0p1gmxVDoOL1c4wgfo9J9WutRN5l43QYMfr5cdOs7I1ouWApflaLH4PZalkYUKrTk97sz0F4lCV6YniVRwVVgbgB70CjtPJAZ6BRJ6h2q9CH9T459PFu6hg8MzSZ/YbzbFc/Veqn0Nskq9hQOEYBiyu8x5CdeXItOzbEHLosvVqKvMRoMdMDz8AT/BSx4bxRvTaT60WjrREU+4nCiZVO+6UmDYQ6a3hMxsr+fu/lbQURHT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8+sjrFiPYc6fEfNQb4Cj7QVaXxX8RkEfApcGgT1EQ0=;
 b=1ExsCQQ5UoBy8/f3f7lrxDddcQukgkaNc746wM1CjfmqcFJbLaKMLQLuSg1AdVilConx+lSFxgYuReKXx861ND3UCzvRxr2DqNyTttSbObaRlIa6iCkIgNEl5oSPxjs8+pf7dUo+Ehngtuj5gn3+wYOW002xFMq8kqhl1e+nPVY=
Received: from AM6PR0202CA0055.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::32) by AM0PR10MB2385.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:da::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26; Mon, 15 Jun
 2020 12:00:59 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:3a:cafe::fd) by AM6PR0202CA0055.outlook.office365.com
 (2603:10a6:20b:3a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend
 Transport; Mon, 15 Jun 2020 12:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3088.22 via Frontend Transport; Mon, 15 Jun 2020 12:00:59 +0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 15 Jun 2020 14:00:57 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 8E1AE13F670; Mon, 15 Jun 2020 21:00:56 +0900 (KST)
Message-ID: <4f13b0bf04d3e76802a9b03b04837ade5947d3c3.1592221223.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1592221223.git.Roy.Im@diasemi.com>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 15 Jun 2020 20:40:22 +0900
Subject: [RESEND PATCH V13 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(46966005)(478600001)(966005)(186003)(26005)(70206006)(70586007)(36756003)(2906002)(5660300002)(6666004)(42186006)(6266002)(4326008)(82740400003)(33310700002)(82310400002)(8936002)(356005)(110136005)(86362001)(2616005)(336012)(107886003)(8676002)(36906005)(316002)(81166007)(426003)(54906003)(47076004)(83380400001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7baf059c-3a50-4c91-7363-08d81123c4bb
X-MS-TrafficTypeDiagnostic: AM0PR10MB2385:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2385474748702E792712D320A29C0@AM0PR10MB2385.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsNXEFOtPLXyy2tBAVi2Ym7HzOdr9jjC+4uWPvFi/wu0btNPOuimKWRx1s8RlwBMk19ZgvZIQJI8t7Qdtmb04wVWdJFTl5upXPjNLzAtmIxULF+Yy7Rooex3V8liZOM7fNMyDHlJwG/3sNvjyhDIG3+PlQs7R/m7sXlnMUBY7G6F2qa3+iE4xJytxlP+bS70AWGhMhETt6N5UA3vZIwXJBWGvXUy+0BZrxbmeALTunWTAQlUajkoA/02lFMvu4ng5WeNXnzMKs72p+7YHnNJW6D4LvEt9O7FV/um+mzeOiLchAN2kND9VDE1m+B6g2SZ3777URhpY6wC8pWuuOTOBbMjmn97MBDDF+fuzyKeVY71CSJRIMF3avIxUtZLrQn0/WKvAYN08Xfhq4SPg5y+Dtb0+ic7CagCKQ0zV4JsHJ9rQqCjG7NTdoQ2U3svs9UEMeReClA17iRMXpSnPJx7QiLdvhkqI/Hx5v1V3J+SheJaqtr+Sn8la4/AyPi+k2a8
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 12:00:59.2173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baf059c-3a50-4c91-7363-08d81123c4bb
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
index 50659d7..eff15f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4938,6 +4938,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4948,6 +4949,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for RESEND PATCH V13

