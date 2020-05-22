Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8852072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ox/c+p4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEVCoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:44:37 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:49301
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbgEVCog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej7rMnAnzJdKELTXzvUuvd8YhHW/TxKRzsMm/buCK/qkp3NZ4fLZT2Q/q/0pWXtjsyJin4VoJq5Z85XZtd1gF4QJnFTwPlHzKlZ3daUWlLswlF3wD+6P4nDKfxvra/tG4SV2Xwb7+5vZ/+18WUhwgYZ+44OTdAqat6EQ8zp1OWqU13+/Jem2ZMVy7uJOWAnXWsDwHsaScU+9ouv3ui3Acg1sma6wMffaxQwufxEH6dbJRpXNTYJPET//036cS1wGP3ToZ/K9BL7WtbpqToBVs8g/CPcN9vu2XlLqu6L4AP0yBpg6Ni3AKAXNnVa+hSnPdnRXOI8HY44FXrHtljYfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgYsAjr9K1UvP4JXtaOUtUr+SMosEV9mraTpiZkmXII=;
 b=eViElQw8N5bGqmcxa/1iAeFe/4lUslYw0ZHNx0NKtt4BzjkqnOL2g8hWBwrxLpFAzDxjFaQaFaUq/ogy6s8eAmp7w7b3/OZuvoR00sPCLxV5AM/s5m+ulQ8EVSURVUf8pOTITSq7zoqQW81vdp6oSkmUl11YY4buWoAQC2t0HqJfHtYl8LRWJhfCwqc7GtPQbyXrVhw0s0+FoWKDzVOAsxGWmo8OBqZ5z+7ewwC0aKrer03K4e0jEKD5RbPQZX0j3r6LMBZGImU46O2TZ/2SbgytbiLLeEpyC/7CncJCkrb9F57pflu/HPbtM2SxX3YZhgys5phEFqRpVw9N96ozuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgYsAjr9K1UvP4JXtaOUtUr+SMosEV9mraTpiZkmXII=;
 b=Ox/c+p4Jp3JJk1Lk0g1hg5VY8m5jfANrBGQ0bRuaMYU3g+FBuq0vjyGopnyU/8mvhkA6xy70Lyp5i89k7NydKd29LZ8hDzI3VxpcnuwnjCer9XW4QoM4bjhmeoAw8ypwWmzXIzA0r/aQ+s+5ZJ0unVBFIFQ/K3fOzQFLLWfOB7Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6365.eurprd04.prod.outlook.com (2603:10a6:803:120::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 02:44:32 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 02:44:32 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, anson.huang@nxp.com, peng.fan@nxp.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
Date:   Fri, 22 May 2020 18:44:50 +0800
Message-Id: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 02:44:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 486e10ed-c089-4993-99f7-08d7fdfa0e21
X-MS-TrafficTypeDiagnostic: VE1PR04MB6365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB63657CC5318F19FF936F6E0889B40@VE1PR04MB6365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OXTR9UW79zDWu1I14/46V+22Dp34gJhn+VzodaVI304arEIBtrhpGc1ojddzc1Zop+vtCXTWMVTTd1rFAwKXN1k/iI2oZwGxZRlrKoOUFPG9EwHa/pc0z3OGVCDPwGwejNObeXQDAyIdoBgRoX4RHK/n61kih8GJbOVWwExx+EwaQ2Yx8pvMZSA3/GvlAH/Nug9q6aOSPBEYtzn5KUXwW4SRjFIt9C4yOtvVZq4gshV3txCSl2b/9mg9oZgi2VsNt+YBmYvR4WNB5Ay7Vj6fJspmFo3af6/t/8f4CcpELgVWNKrVmP7cdG739Sct8jI8Yoez3zFFhgw5kLGBxqhSIXupUQmoYAIdULQ4+RQFWNj1PB1chWLGSPj5npeIp+MVEV7FM8LkJsjN+MaoRqkqIago9RPsjqwPg3hTJsWknih693SRReVemoWc12C8KDIa+KEYKWaeT+Qze1NuGPNKpUl0GoK3/YDGsFx9d5kxtzCnMcyGUycheGWqxiEsDzn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(8676002)(6506007)(4326008)(2906002)(6512007)(52116002)(6636002)(6666004)(186003)(66946007)(6486002)(8936002)(2616005)(36756003)(956004)(16526019)(5660300002)(26005)(316002)(86362001)(66556008)(478600001)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xbP2DZF/6z45mpCslyrmJVW1jwa34m1ullIESSzGQ/XlbU+9XBNaUElqX51CXqJxoBdcnj2hSjhPvb/TEU1C0n0ZwSHc/Rr4hkuejJHxAdoOrpCg2e8jsgXv30heuF+iqUTcxBy+QeofdHSGiVal2NasTjDoVNyhym+pPbb8qjcn+TurxVDPOlJGeVqjtGgIc6FtEDwkdQFl39CwUM0l+ib7ZQ6dT3OA9oVzsphJ8Tk5kUyQOsHUMe7564C+1k6WGUDXnd2VriVwl9yFtIjST0yBLuyVaBSxTUIJdamdeXwoosL0GVI54oXRp6XXzNSnyimghtu/YfEdWhsU8Fwk6misM8vklNT9k86a4okLi3l9blSyEnYWj4PHBJWMYuP7j7WHcWBcvUina5Vq6BQiRlxxCDW4MjrJLWElgZMTsBQWQge9xr+x3mrkzSHwXsCHceQH3GL+RvQBJ9ACabBwJLRLIVrTA5cKpvMWiq1IMWU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e10ed-c089-4993-99f7-08d7fdfa0e21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 02:44:32.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqSVl+3q+74xhlO0bh5zEPT2YEdSEcejiKC5NAFXNkEjf2K1K+8bok2dqs4gpXhXEXUJOXcH1zFQd/5bwm0N5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct ldo1 voltage range from wrong high group(3.0V~3.3V) to low group
(1.6V~1.9V) because the ldo1 should be 1.8V. Actually, two voltage groups
have been supported at bd718x7-regulator driver, hence, just corrrect the
voltage range to 1.6V~3.3V. For ldo2@0.8V, correct voltage range too.
Otherwise, ldo1 would be kept @3.0V and ldo2@0.9V which violate i.mx8mm
datasheet as the below warning log in kernel:

[    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
[    0.999196] LDO2: Bringing 800000uV into 900000-900000uV

Fixes: 78cc25fa265d ("arm64: dts: imx8mm-evk: Add BD71847 PMIC")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index e5ec832..0f1d7f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -208,7 +208,7 @@
 
 			ldo1_reg: LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <3000000>;
+				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
@@ -216,7 +216,7 @@
 
 			ldo2_reg: LDO2 {
 				regulator-name = "LDO2";
-				regulator-min-microvolt = <900000>;
+				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
 				regulator-always-on;
-- 
2.7.4

