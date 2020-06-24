Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1009C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C889820773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="F05RxlZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404024AbgFYK2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:28:40 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:29901
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403840AbgFYK2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:28:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EumCs5L271QC5fLvDtwo700CbL/Tii4yaPFshuVfg1CGiz0BEPICnVCutztmrNEGYlPCsM00ykLnpQrmI5V2C0IYNOdwIcDG9JNmjT3JSXBVD6xHcg/So+TAsk8/jX7FrBlu286XDTFxRV9aqG8m21X2BjbPRWnd6fA/ma5jgv3Mtvu2Txg8lXFD1EPr4DWSx8MDaanLO+SX1hVT2tWgBNtTG8dyRfGJ7AXX3gauzrFv3c//HMGPAfryo90XHPvB20yeUwTzZwZ+ifep3wS20ALs/E3Q3/AkVn5SDogTrWt5X0i44ViXNEik4FD5yXdr5fybSxpu1GVosqA/37h9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSvxNKS7oEMPwOCq1nBuwqnjo82stGDDda3Lqz+y4Qk=;
 b=au5cTLDImeA7Q642brdptoyA4gLpfEoQXENlaCHPDi0KXZYuzYXEmr8b+3NKCsZrqhpLWovK17M9ijsiKXwfeov6o2+KllKjVVnJDxYo1aqyhIf4VsmZECe9ogMWqFYQUm0XAir3wNKvL82sNYvEOjcwvwmCPMM7sfa8lZSfFUVE06CR8zo5qKqBOMSZzq1Hiqj0+aN3ydY6fjBJevMEcZWOyqD7bj9xNfnk+CEHx+/nq8aF2NbD/tuWeXf1pnKiN3NZ6mvR5NvdS+bpZZTJWbO2I6AMTKheovY0wL1lDNmNJRP73TeoOGiwemKceGkqyLcyvtEF29wK/ZYt2Fx7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSvxNKS7oEMPwOCq1nBuwqnjo82stGDDda3Lqz+y4Qk=;
 b=F05RxlZ4mKCERd73KGAHgaqob1SgegFld22hgJaSLpzAAZpqmTUcS5Zax9kE5+iD9Gd+3ueqnN+P3e5EgqHoYbvpgk/Fl/98cbxnmxsXZJn8nOEwUYJA3k4vaZOntOl90nTH2O03RAPN/VBXiAnadShInbCTkSJTc5/dnqTLWAk=
Received: from AM6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::17) by DB6PR1001MB1046.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:5f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 10:28:29 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::45) by AM6PR01CA0040.outlook.office365.com
 (2603:10a6:20b:e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Thu, 25 Jun 2020 10:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 10:28:29 +0000
Received: from krsrvapps-03.diasemi.com (10.95.17.51) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Thu, 25 Jun 2020 12:28:27 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 A77FE13F670; Thu, 25 Jun 2020 19:28:25 +0900 (KST)
Message-ID: <def7f8fe1f95522abb4e990fe45fa7ea1a44c55b.1593017969.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1593017969.git.Roy.Im@diasemi.com>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 25 Jun 2020 01:59:28 +0900
Subject: [PATCH v14 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(46966005)(966005)(36756003)(2906002)(36906005)(4326008)(356005)(54906003)(426003)(42186006)(82310400002)(107886003)(316002)(110136005)(86362001)(47076004)(2616005)(81166007)(82740400003)(478600001)(8936002)(33310700002)(336012)(83380400001)(186003)(6266002)(70206006)(26005)(70586007)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29382164-2965-474a-65bc-08d818f280cc
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1046:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB10468BBF880DCE2194286F63A2920@DB6PR1001MB1046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPq5+tOKaf3h5m8Dh5b9l5V58OvS2FVCOjzHgwKN/JEXGm2uIJj/ISg7Y9uXLyzjcRN7ib9o0iqicMO4Sz61DGOCMYW1hogiFTRuZX7SODQqsKgVpNdpiO/WwDdBHw9T+/snKy/DFp6N87w/RXnoZSkufZu9CfhEP991gPAq/ast/sqhdRhJ5fOI+Smf/PLwSgr0X/zJIeQLYSDLxOsDIZRrIp7OI8lFf90VgMyUq6Ozptrg7ZcZlnB4nZSttmhvGBJ5cVdR69tjmlyhc1Wh5yypV+mokUS9BJ9ZvCYu+LwLnku8n4PfpkQIjg1Q0q9OB4M1YIP8BmYMsSms56f8fkmlVIGxYDgIS7MCzQEZjQafDSwLvd6VVZy8h2iNIwT+KwTZJZFw7kCJkA9svml4szrAf6Pb3Ipx5kQ7Z1d2YyFsRyOpYsni23skfzd5udqno5zeH1g/r4BfTpjrGD6T7GMMmMjuUXLeNj13/qUh1q8MRBIk3QalmdW862hHD/6H
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 10:28:29.2087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29382164-2965-474a-65bc-08d818f280cc
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
index 7b5ffd6..26fdec0 100644
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
end-of-patch for PATCH v14

