Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E96BC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311D920792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="jy5+FIov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgGWRVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:21:01 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:56489
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgGWRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:20:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjDQWZ0y4lh6QCsEyRfF3+mHRggRCfUKlE0r5VZ8ygPgH8xQSHqPIldTyXEozYOYjuEBgyKCa69NFruPB/VBVIleFQ2l1EqjvRy5eUksBlbFpyAcBdmhUK3limyMhbvhPgOeU0nPQeQNXvS1J7/daL8ii10CrfEgY0o6GAoOiTszevqznZ90DRvG0cJG6ww4j+MYrkmV4rxiv1NZDVi/4NodXgj0X5xRFnWvxor5d6D3AE0mH+wgXjG/XVpg9EmMr59djCC23B4TAxsA678e07TgtX75M4mez0FDZGBcNFUyYAZv+/S7uXGz8OMp9dTGRRAlzl8DHXuSXzMSyaTVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNynuv2TqiXsvAp7re8SmgcONuqIQREa5rXwjNJVBA4=;
 b=izinrTuumzAx4CIaNLAzriQunYFzK5g8qbE+5ziNtnSm92WaF656pdX0Wfeq3pgux2PrFfiwvmE++JESdSTrvkfYgmMwrNey5p4NsIReP+OYIR6iUa6jY4SfDeWxl1jdpk7jMIH9rFyacc2i2Lr1Md8tHd6dgSJHzvDQIPFy/G5ZkL0/75Ao3Wz/CxUuwlTDJxEEO7LkHUmSnzpeA/y+aB9g0KuSTz8MkmWQz6gPZOrqP2EN5OKqe1BjnmAau3Y1yacACerGcwfHOqO5QHAxTEX8h0HGpgVjMfvMZBeX2A6+Vr2P2X2gTBN7Y2wGWKHxoVDUoFmtaneS/BVptH0cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNynuv2TqiXsvAp7re8SmgcONuqIQREa5rXwjNJVBA4=;
 b=jy5+FIov84JoqM2znIT6uIQaMccbanMi6m5UCJp65+lmhuQG1+3wPvknKoOAnzzoEhJtw4S8vRFPQn5Lj1djipbAw/uHVW7QaqSfM06r9hv6teq24D/Akip77PibGoV5vwRkR5Y5reAgUF4iZG2JRdAVhuXG4q4XbYEwLcUf7c8=
Received: from AM5PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:203:51::20) by VI1PR10MB2336.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 17:20:53 +0000
Received: from HE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::9b) by AM5PR0701CA0010.outlook.office365.com
 (2603:10a6:203:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend
 Transport; Thu, 23 Jul 2020 17:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT049.mail.protection.outlook.com (10.152.11.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3216.10 via Frontend Transport; Thu, 23 Jul 2020 17:20:53 +0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Thu, 23 Jul 2020 19:20:49 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 A1F7413F670; Fri, 24 Jul 2020 02:20:47 +0900 (KST)
Message-ID: <c43c56f6e7b6427880b42ad98079c5085e0b1026.1595516501.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1595516501.git.Roy.Im@diasemi.com>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Fri, 24 Jul 2020 00:01:40 +0900
Subject: [PATCH v17 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-MS-Office365-Filtering-Correlation-Id: 305be171-c711-4357-3d64-08d82f2cc0ec
X-MS-TrafficTypeDiagnostic: VI1PR10MB2336:
X-Microsoft-Antispam-PRVS: <VI1PR10MB23366674D048AF413AFDF448A2760@VI1PR10MB2336.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8O4mabDq6F5dK2vpPO8EztDc6aPy0F/skypPA9cnHA1T1fXK6SCAnco2nujOD9JOX6sqLsYsHzcu2Wxc7jJ9vOtwaBRJm4jhhdS3bu+18/UZ/h5KlUbmYv6pn5CJrRMhdK5qZL/os/UJUeBKqvbPN1TNJcz0U8uSDNP2tKh+O67If6sVuTRmBZX6dBPUGYfuNEc0Y/dslOPQ/tiUd6cFDnAeqCxKQzZL7Bexdvl0g+PjgRlIrTVNfXFBsFkKTHg1M7IeBGwbiAzajMXLTmGpBIHnP07Sma5JcYDnJ37mzWmanmVGlQMA8roPXqt/r+eobwAKX2xijXhqfq7SPlLOtfY7rqeEROXjzLyxCS3AvbjkXl0gBH1BVNKuGfRHgULFVDLY/LxplCADfAlxnJC/NJkeBcleZ9B+jwPwTlAkzJ3eqgCX+YX8+H0hnINRODsJCxwaDcNUpO4YRfMyl+Tf8Wsw6qrWfHKFP8whuYtMNTyo0bJAXIF6HOLXgJyEmI4
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(356005)(336012)(81166007)(478600001)(82740400003)(8936002)(8676002)(4326008)(86362001)(47076004)(83380400001)(2906002)(82310400002)(36756003)(966005)(33310700002)(107886003)(6266002)(316002)(54906003)(70206006)(5660300002)(70586007)(26005)(426003)(110136005)(6666004)(42186006)(36906005)(186003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 17:20:53.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305be171-c711-4357-3d64-08d82f2cc0ec
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
index d53db30..8e6f364 100644
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
end-of-patch for PATCH v17

