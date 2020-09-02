Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4933E2071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="J1mIpoT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:48:10 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:39918
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgIBJsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:48:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmGhU2AgXexYHDj0K+x/3z/u+YXVDl4lHmFobOsKwN2mmp4H5If3bgfLeQL+L0UwBN0eci0JbZ38y5ediin88PBum6mA7R1Nm+PoMDwbpMMdxfGSz19JTGIVXjQWGk06JdmnHNcDtuTiBM3pI0Npkf9Pq+XZ2DKoo5Nriafcj8QxqUukMbAcIsOMwugbWIzN73DwB8ckSAeLYoOq+l6qyQiG9SR7WjFONZLTtn5qUGGnqB1YwTaP5+7Q1HnCcH4dZhC7FI5octrSQ1jE6vpXs8wsYOrTy8U/DvQqnJO6aiLrk/qoUJ2r3RdUiLPDoNj6jm1RAwMBC1wjAPqXUYyP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPrTYZVH1G+G/OS/3YmI5YCL8W9JtFq7DF94lCvM4Go=;
 b=Zy6nTxUMeO/a5W7Y6vxs5F7LSSqDXj/QRKKD3UTAM46lXmZsttPW/Q2jV8bRW8XK6IOBAzqjpZcqhxLT5Q5Fu67to/B66xDyyUiF5twKdr6pG3a9WQtn8Vf+0euZMjW8vugQtRI7HCgAyQkq6TJiX1up0yHRKIzmo8sxVS+fLIuPRezOgrGFF3Xsy3aek4U516cIiXQku8oX515IKqqE5AALeXs4FCOI0FXWXNJasTNK7lE2Pww1bRzO7SmgLq/f6F7NWbN6PXrmIPpLFFp7Z504fmdBBRMojaDWdYp+t61C8gUSEFjsc0FinqMZ4X7xX2MOefJWbE1wl46i3ElqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPrTYZVH1G+G/OS/3YmI5YCL8W9JtFq7DF94lCvM4Go=;
 b=J1mIpoT4CMAMUdC/A975HosLk3qMZANm75yI6JrUEnGqadK2VJ4IBVyCAPR9/w6SQ0+9mDKj/dduvyfKS6/aHdvsv3ZV93WGeJLVjnKg33XuLTEcp8L9dKDcvm1xeO0AEUzfilNtfpHgYjBDCOg3C+SOQ3PCMT+A1cYrPTS1FLs=
Received: from AM5PR0701CA0016.eurprd07.prod.outlook.com
 (2603:10a6:203:51::26) by AM4PR1001MB1266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:200:95::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 09:48:02 +0000
Received: from HE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::2f) by AM5PR0701CA0016.outlook.office365.com
 (2603:10a6:203:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Wed, 2 Sep 2020 09:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT004.mail.protection.outlook.com (10.152.10.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 09:48:01 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Sep 2020 11:47:58 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 444ED13F670; Wed,  2 Sep 2020 18:47:56 +0900 (KST)
Message-ID: <b825660680906abb0053cbe43c6bbe899bfe0c32.1599022115.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1599022115.git.Roy.Im@diasemi.com>
References: <cover.1599022115.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 2 Sep 2020 13:48:35 +0900
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
X-MS-Office365-Filtering-Correlation-Id: a0671d12-b688-4778-0ba5-08d84f254889
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1266:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB12665EFAA1754BE979CE2000A22F0@AM4PR1001MB1266.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilkx8Ut405//jKEXeDFK6DpSQNztbekvSw442kFpVZGcOygxSPrtc7pfg0zsmB5SoMV84MK9sflfbCvuQqJZdaAJpkBnvnz82S4z1OcYfAhOLVDduDnMtltyTU8dq1we0/exDQWMuVusSQv7HqsqKSb1QM4swsUKepm36FSHE5eaGjuSpl9G1sMRluPZZS3M5IxztG634UcrWJuPQvl9bRLA16R+3dgVYIfnURtYgw5sT+RevdRlm2F2bRu8THO3aXA7AkwkQBsmt3mpybEoTEtBkjF/l9Hz/SmlNKtH0MqWoJkW9ouF3AgivHqP6WHeUNEXMDN6/plHOGNWguDTA5AOpA+MiKlV3ORjzWIeGdzQJY1HsdIT4jeyFM7aVj1rySwq8F89C+YvFC/mqUbZqWntx5Tk9PKnKW9fC7gR6fiS/x1oPMCqTwpVvw8dPEqiB/+3k2nJML1nIF/doIH50k2epfuVglCYQUbDibJITM/2LHf0DjXFqb1XY8q4j+v2
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966005)(36906005)(54906003)(186003)(42186006)(26005)(426003)(336012)(82310400003)(6266002)(4326008)(966005)(33310700002)(70586007)(83080400001)(81166007)(356005)(70206006)(47076004)(83380400001)(498600001)(107886003)(5660300002)(110136005)(2616005)(2906002)(6666004)(36756003)(8676002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 09:48:01.9341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0671d12-b688-4778-0ba5-08d84f254889
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1266
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

