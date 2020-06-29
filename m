Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BEE2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="dInReT4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgF3DA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:00:56 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:4064
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726993AbgF3DAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX+ob2NvUXuovps2tdGZ31TL8WEs0N9wKvD6N8D6Q8l4Uw/4AshbUJputHadsGlzD5OumZT9GfA+87sYtUBamcz2QmJz7sAZ5Ict0gmb0bi80fn9CKzO3ZFHOaZ3G7uKH8YYkm5qmsDC5uXoibwhyqn0Hs5tjDJs8joWwU6gDSNlOJYoyl54YkvejhuMnQyBBGm04tqUV2hImbirosgsLjx9qTbxZzohGFG9eQnug8sHZqElyJAIkNQcK8GtLtLEyE2RV1nLgJP/v6lOvfR1asSArR4iK26gzboRjGrMShenCSi9qPxAGaGpN7SvX6Z/s4GMVcMwg46WA36p7t8pEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6rYxZXbHNu0PXWK0OiP6bjtI+If0ptHQ4Nj7TssWgw=;
 b=Ho4X7ugl3AASrP/+VLuLh6ufEe9yZlsgaHCG7mtWGnAUJqoZ+Yhdh/I5wUk1u38csiuwkt6uti3atRLteimoAAbRcKdtRnTYAs0IA5FMfPVjtF8CiVugckZ23aKnypCNj+NfsQbDy7gYDpmL87JgUilluYXF+rXJfZkgOWyifqUcufFVe4txsHSQuI7a9QypKxxq4PFrNbs8DsfQ4mfsUJMlwVlZaqzvIz8yr5ImrbCce19+HRZ2UMe1f584Aciw9eOq0CMY/Ok+3D7Ax6n9qVQAtWMW99ZkBCvauapjE4oahE4xs5XoPuLv+arF3xmzqu+8CM/Lys6RpkdTBRelWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6rYxZXbHNu0PXWK0OiP6bjtI+If0ptHQ4Nj7TssWgw=;
 b=dInReT4ZSvjcfGRQ++OH0YTqVIi/MFGQ3fRl0Ml3YkMdxLAhp0C+QbUQd8zhtDRmvJQdzYCrXlI8dA6hZNcHcKZhueex6OmmGgML+eAmwyAxlvFVLf9kpS/Z/t7+Nqz/j4VU7NjIPJKihZsmkOkefTf7VM1aTpCLMtZhkjvlqXA=
Received: from AM5PR1001CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::47) by HE1PR1001MB1019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:72::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.28; Tue, 30 Jun
 2020 03:00:51 +0000
Received: from VE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:206:15:cafe::37) by AM5PR1001CA0070.outlook.office365.com
 (2603:10a6:206:15::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Tue, 30 Jun 2020 03:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT031.mail.protection.outlook.com (10.152.12.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 03:00:50 +0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 30 Jun 2020 05:00:48 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 78A3C13F670; Tue, 30 Jun 2020 12:00:47 +0900 (KST)
Message-ID: <bed9dbad886fecff8d38a6daf7e7cbd4aaa248ae.1593435662.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1593435662.git.Roy.Im@diasemi.com>
References: <cover.1593435662.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 29 Jun 2020 22:01:01 +0900
Subject: [PATCH v15 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(70206006)(2616005)(356005)(83380400001)(82740400003)(186003)(478600001)(26005)(47076004)(86362001)(82310400002)(81166007)(336012)(6666004)(8676002)(426003)(8936002)(33310700002)(54906003)(6266002)(36756003)(316002)(4326008)(70586007)(36906005)(42186006)(110136005)(5660300002)(966005)(2906002)(107886003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6595c612-80a6-44dc-245b-08d81ca1cb84
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1019:
X-Microsoft-Antispam-PRVS: <HE1PR1001MB1019DE178F784876E527F531A26F0@HE1PR1001MB1019.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNLuBM4X77qebJQJbStP0DmATcW7KQuUrAAWm1cS4b2h970U79OKHqPxe34M0/30XCrK98xr8e04dqtgeXjQX9gARmYmPnHTwCNBdTiqHHnP5/qyhJ2Aggx1YvmFQKQwOot/B/D9fH8upb5nq4xDO01maKzm90Nb6dyca59LmVghnbFoMAoe9Hy50qIdjo23H9ge7GXOmd7MO6XXrlJGgsuO5DoS+OvaRPnnyeeXsIpyuOjMIAWLddY7BRXDe9ApQ78oI6SId8rbJHx6rJ9Dl1TeZ8GJWEdfamN8k3+LsDaYJ42fum4sOKvtsIl9VctCIEInp71I3GfeNZGcq8sROcGadILvhLT1+XSDSOpsVmaTJQjH3VF9QPtk0/VhvvrEhj13qTKb9a2FrAMCxUmlzL/v5iZE0NVKdfg7+kcDULAjEh4TQjPiiLtplY3qyG+0pYOW4pI716AG5rYAhE1+iL2e3bXoian5xw7oIZfVsbEpo1dCfFFFzTb7s2u5dd6T
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 03:00:50.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6595c612-80a6-44dc-245b-08d81ca1cb84
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
index 496fd4e..9a45a7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5002,6 +5002,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5012,6 +5013,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for PATCH v15

