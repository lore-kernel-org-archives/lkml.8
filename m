Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54589C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3670020738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="WCEDRTmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgHDLjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:39:19 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:26599
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729799AbgHDLjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frl4cMOkRJA20qthKGmSPt6n6LoT83Ole6nIuoGDNcgAkIZmreTKx7+4f0ymF69++K6jxhbI9p/Zw/r9yJtzFu6nV5llWiCGVUuZlnlv3kp+hxjMg438UsSb9fcJsFLO+ufTwJ/NTfZqsYy4VEwZq8rdKTgRooehaen8qM7wcN/LJ0D1PL9yxKLgud59zEz7tIQONY9Q8WVKrcohjqFB18gOLk4NanvYTR05jN47Zb4r+YRt1WO0cMLjEEmqXTm9WepsijrLp2KgITArNwH1qyxbbF7k3XNZ7knLqGePgcwh8oVYwzAlCh240nAOzhpSNbFRwqhn6XhpEWmXx5zSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad8OQyX4I1YH5lU+pKpT+Pj7NTw6P/pEJp75goOmSGU=;
 b=UVJn2vtgZhvy63gZ8/xF1uRPwcl2+Tru6f/uozv0L56z5n8jJvulAxPmhI2ENgGRl48RLnZlOKSWzrqun8PjCiD4p/9ewAqJ+dSPVfoTb/1Xw/9arOzC0pvMUwe0/ZGCZYxt4iFHtipjUccSdrHx+KNfA0n1RVMGgoRerZNVDB/fJWyAfoF9UGLCvLCd/bJrrk8+UvUeWI7WifgpF/STjQF37G5xo9zOw220iEchBwB4GiNPqAeahv66ItbS1TIHKxWdanIKtxkvpN8mILYpjsriRjpzhHF5xw8CAtMmlRrcoH0NUkFU+8ms44ShpDLPWjt6at+IxdlMaE51gQ6/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=neutral (sender ip is
 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad8OQyX4I1YH5lU+pKpT+Pj7NTw6P/pEJp75goOmSGU=;
 b=WCEDRTmxHWzrEC9O/T+N/+WFaFv0BfRyJG5Sy/N5l+iyINtCaPyshgzHMxTuwUn8PaljcnX+VcCX7WWeCn0D0lQUocNyYuPq/p8dabQi5T16nCl7eKpudZ5j0DR4n8TPPBuJKypW0e+Ibk9uNW1yn4qTlhQMMjdeo4T7NAeRVdc=
Received: from PR3P192CA0054.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:57::29)
 by AM0PR10MB3044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:158::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 11:39:07 +0000
Received: from HE1EUR02FT063.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:102:57:cafe::c7) by PR3P192CA0054.outlook.office365.com
 (2603:10a6:102:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 4 Aug 2020 11:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=neutral (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: Neutral (protection.outlook.com: 193.240.239.45 is neither
 permitted nor denied by domain of diasemi.com)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT063.mail.protection.outlook.com (10.152.11.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3239.20 via Frontend Transport; Tue, 4 Aug 2020 11:39:06 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 4 Aug 2020 13:39:05 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 4BB2213F670; Tue,  4 Aug 2020 20:39:04 +0900 (KST)
Message-ID: <4c3579cc6623f50d53e3cacca29a5cd1954c2063.1596522828.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1596522828.git.Roy.Im@diasemi.com>
References: <cover.1596522828.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 4 Aug 2020 15:33:47 +0900
Subject: [PATCH v19 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-MS-Office365-Filtering-Correlation-Id: 501c25ed-c284-4a9e-7b76-08d8386aff22
X-MS-TrafficTypeDiagnostic: AM0PR10MB3044:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3044FA5DDADF7802F5187F50A24A0@AM0PR10MB3044.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jK3b9eqaeS+D16gnIBsxGyh6mytttk/SN8ZJHVzKYliuM/q8DcXei9WHR9zA4lPIs5hJyvmVLt9E0L+rH1RqCC5TUJBJGqU8zdo6uhJCPU7YOb2NjXHCOx/7wRR0oKg9Syca7lJ8U0lW0ZCk6s6DBeNr+nXpRzatfthsdgWHuK2Q/xGS6n2Zk6mY4LFsIJocjvL/TTCydPH75+4JyqJ//gf0RX43xvTCH/d5JSqUVYa3jTFC/DGm+46LBXZcJpaJ4BEUydsiSoqimN1SCvtm6izykOg7O7dcDpGlqYsXQ5ZaSd+nqsErVXYXpvKd0iIP5Q+X8ucMr69vJoBOJqS++6j+zYKX7aFCgYZQOokHTZNsd/EuBtWwX9/3zuYIeKEVQ31IhRydXU8vaopLsy0AXAjyT1+dLuRuvcTCgO4JtT/KpWVSAw12va5b6SDXaQDBTVykxL6jMHdsy5rwkT78YjQizcY9FqLXrwYlp6AP12ymrdu6B+twZizrM00LkQD
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(46966005)(426003)(8676002)(966005)(83380400001)(5660300002)(336012)(356005)(2616005)(6266002)(498600001)(107886003)(2906002)(33310700002)(4326008)(82310400002)(36906005)(81166007)(42186006)(47076004)(86362001)(54906003)(110136005)(6666004)(8936002)(70206006)(186003)(36756003)(70586007)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 11:39:06.8079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501c25ed-c284-4a9e-7b76-08d8386aff22
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT063.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3044
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
end-of-patch for PATCH v19

