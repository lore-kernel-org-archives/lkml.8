Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB81206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 19:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEPTsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 15:48:20 -0400
Received: from mail-oln040092003072.outbound.protection.outlook.com ([40.92.3.72]:29709
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgEPTsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 15:48:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J675Tm8GZiimtp+yxBj9/BJKDs+CQhXLVQe3FsCRz8In1rEFHnoymlRhGHVDNjD8hiORc3N4+SBekpbaAqEA+WUR5M4Y5Vy8X4wX0UFfGlnsqzoaWcpM5BD84nZnk8MVnLbREVFHzcWesBr4wqeiY7JMHmMjw4kdWPAc/o6NXy8hvDinPr/vbqppJuGgOLgOYD4VFArfFOXQYSnbP3nbPK9dLO7bNLpSuQB3UltY+RvyCz0cYOrlS3UDEvh7HcZ5gMu2CbA9Zu8sfvDt8PEe7Otuyvs5cAnaT5a61nf4wxpq6Mv8QPaVkd1/jj7o7ziv13kXIlLyVolPu4MXOp/fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5VuGyDtGP5C2WiO+uMB/7S9xeV2Py5CzDzTDDXar3g=;
 b=U0m67isTt0xyfc/B90+Aq2i0zl/HiaVckjuoGkAItqXn3aF07zIZ2/e5m4+xI2NdcjaTOGikVkYXGGCBZzmgfia4jpwMxLGKjCTwQ8HaY+dxCLg8XsNzsGlX7aHRo9x7OqVeMWHqFMRbqtp4V776JhmiWragaHmAYcm5xYTD+iT6eU1gBYkA7ZbWVSvZkvbQpc0g5brBl7UmUJnohfjx7t4W8O6WjI9sCF4xUmv6s0+ZPHbh1GZK0V/TKs+tZ96rj6YlHxSXieVXnIvBTCJY57zf6weqm0+LA3WhegRyMPiOhunryj3MDqejUo9Xfn/e+4FdDaY8EXVwGZJzyr2oBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (10.152.76.60) by BL2NAM02HT159.eop-nam02.prod.protection.outlook.com
 (10.152.76.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 19:48:17 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e46::50) by BL2NAM02FT054.mail.protection.outlook.com
 (2a01:111:e400:7e46::363) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 19:48:17 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:154CCDB7B13C5351FB4DAF8BCFC59B3A9E379A337AAF91F73B7D753E7A4B3AB2;UpperCasedChecksum:B330C09C44C8DBC641ACEC5A46C71DA6B130000A5D39A6C63CDB98A69BEDD8CB;SizeAsReceived:7682;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 19:48:17 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/2] dt-bindings: mfd: max8998: Document charger regulator
Date:   Sat, 16 May 2020 12:47:58 -0700
Message-ID: <BN6PR04MB06600D05B27BAE69970E3C30A3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:300:d4::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200516194759.7643-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR19CA0016.namprd19.prod.outlook.com (2603:10b6:300:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sat, 16 May 2020 19:48:15 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200516194759.7643-1-xc-racer2@live.ca>
X-TMN:  [1HfOrMjKII0sWB6kCOSpyZmZVbtXRRHBlQ4sM26MYUBHnVWqw5iGWTByf9PVlbxH]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 30e14a11-0440-481d-7a7d-08d7f9d213bd
X-MS-TrafficTypeDiagnostic: BL2NAM02HT159:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEMu/HJ+YQ2UabJ5So8+I4KIr6C+ehyIFbxSxsOrjpyMJc6i7YIoRAql1AfbXxTTiOMsrbWrGV7y5gbpIu1kQ8wuUTtWNO3XaRNa8MlxhEgbsQN71hHH5CYJYOKWAgBo5hR7PU6fVSPzBo7YuUhaOglkqz0gccMwDuRfWs4wryv/v+TS8mfCIfT9WBk9skqNbV/+O6N//hW82e+dn/f9zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: EMD8PavzJYt8NNB+XSO0wXmo4r64ZRUrv0I2zx7tZF7vRJTU6J3S/iPjTlcVRNypbdB8r+iG55Nhc4RULNNDNZ0/ev/M0itknFYV7vRyTma3/Tqmm00RVQskvzrNnHq6U49geYvny43CBJB31BbJ9fDAeIpN0IzniZxlrc9uJOPqd2h2M+HY9h0E/hqA2SZF3CHPWcaeZlvNumRa/oJdjg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e14a11-0440-481d-7a7d-08d7f9d213bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 19:48:17.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max8998 has a current regulator for control of its charging
current.  Document it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 Documentation/devicetree/bindings/mfd/max8998.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
index 5f2f07c09c90..4ed52184d081 100644
--- a/Documentation/devicetree/bindings/mfd/max8998.txt
+++ b/Documentation/devicetree/bindings/mfd/max8998.txt
@@ -73,6 +73,8 @@ number as described in MAX8998 datasheet.
 	- ESAFEOUT1: (ldo19)
 	- ESAFEOUT2: (ld020)
 
+	- CHARGER: main battery charger current control
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details.
@@ -113,5 +115,11 @@ Example:
 				regulator-always-on;
 				regulator-boot-on;
 			};
+
+			charger_reg: CHARGER {
+				regulator-name = "CHARGER";
+				regulator-min-microamp = <90000>;
+				regulator-max-microamp = <800000>;
+			};
 		};
 	};
-- 
2.20.1

