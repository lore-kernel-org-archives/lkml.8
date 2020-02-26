Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882E1C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5654E222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rdoOvCsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBZHTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:19:01 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:43793
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbgBZHTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:19:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+GemtTCpV48les9dpIzt8l2rbgs2Z7MrJB1PaqwHSfiJJEyowk7QDAEla/SD6WvlLcKOwKIf83nAysI2At617sHmlcAto6GU0QXf6PMRi1N7j/Xcaw3yZrja5igNdpdKX1OZbCtitncxoPKOcU1wFoCv9goXIfvDSk/edQ4bQ5LlXKb654E8HtapglYevtrZpbtANOK4759XWgLMV0SzSywb8+z2XwXh/tk7FyZwbxs+ShjLkmJ8AV8qLAahsrnbYdvM8H7fLpPWipJb5bndi2co6cvO8Hd4IKb3Qqjrz7bPaXbPqMQ0S6bw9k93GVTv5B64tdjEYZDJc4TC309Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTEPRvmDpn0B7HYc7rlzofD9RpOTbggaLCyUpfkZ72g=;
 b=eORRrrHXaPSHmkx506hODvEIBT542Q8SiEeDSli5/LjS9/8QJnP2k1P0aMofEeEBl08nXwPSzOBDgaQxGFoOPo1HL4yWrQf7Mte7bFFnk4pdZz8RDwPI4PfhkTAupMcwoq1bTDXgdzQh2p0X1bZW5tyqg2jbulC1MRcgSSQ7UzfphmLwKKgEnklmPMixpu4Yv02McO+YKtHuoqAhQnLNwyf5KWFNL9pk2FyL+0DePCyOlobRlSOW68FaSwSMS5mVklYdMPWjesqujuXW2W35kZOmYGDqzBBuRQ1i7ISj7Oa7oaf4uheKIpMW8Sim9kqx6FCnIt9uVbkhg5e4VsTaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTEPRvmDpn0B7HYc7rlzofD9RpOTbggaLCyUpfkZ72g=;
 b=rdoOvCsqXNqxbCqUcpxX/t+nNCWsZqczKC32NlEBeIDNbb6GEEkd0NIkix1ufI9hX/SgPpEECFBU5M4c4w8SD3MWxg7urvtxJ1oNRSHBblgSNXULQZD/T7n0o5CDLj1sWpJELpmlsaepW49LlVw3h1HKNxbGkXGGGm1ZO9SZ/N0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5506.eurprd04.prod.outlook.com (20.178.115.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Wed, 26 Feb 2020 07:18:57 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 07:18:57 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
        robh@kernel.org
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transport
Date:   Wed, 26 Feb 2020 15:12:50 +0800
Message-Id: <1582701171-26842-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582701171-26842-1-git-send-email-peng.fan@nxp.com>
References: <1582701171-26842-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0131.apcprd01.prod.exchangelabs.com (2603:1096:4:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 07:18:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f6e0a74-4130-41f1-7abc-08d7ba8c24fe
X-MS-TrafficTypeDiagnostic: AM0PR04MB5506:|AM0PR04MB5506:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5506608F6452DC54A6272AD888EA0@AM0PR04MB5506.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(2906002)(6512007)(26005)(2616005)(16526019)(478600001)(8676002)(186003)(956004)(9686003)(8936002)(81156014)(6506007)(66946007)(66556008)(81166006)(6486002)(4326008)(7416002)(52116002)(36756003)(316002)(5660300002)(86362001)(66476007)(69590400006)(6666004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5506;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mw8TOy+u2Ylkxzo5Yfk3piuCr0gPYSrJ66xRc1dAL0LcR5YWXzBR2oLonABjuYlXPDupZBMglGSW/IKnACWREPkPIl+mu99n1mTwFM/g6b/pKIoka9XVKdkyNaVBU7+HS18X5c0uul4v+B2LKl6+MbzMfPQauC+c07w6c7kWXZK+v/vN0CsESyP87qt+iSbS3+P4D5zBAWCJiBHpSbjD/EKSy9dMIuqKM386E2lpimxjBazzc8Hx/nU2dJDE9ypG1SDVHz72E7gvoCPQSxt8p4U9phrQ6bRvKLdqDsHbFh9itvfKx/XQA21Vp5WFMBaPDHL1r8xeRsi1UOJ8dBzE0RP1H9qStukKQKMBTHTsjx25LmVMNggcvghL+txscjIEEkQ5iUgl87c1rClYQVB7bulWeGwrasJhJrNeCIEyZVw1cZTDHpymjIRV0rvzpRVzLgNvD/bDwzEwvs5h/2PMrkyMIw5E6Jf5Wu2lZWpAcK6VvutgicadpomqvIdMVR9H7wnzPhzOpQdswek0mJ1HlrpeHxwlN6d42tuncZ2czw+KZ5Z7J/Zyq7aGFcHb9dg
X-MS-Exchange-AntiSpam-MessageData: X//2Hsq3PPDfofQS+wG8aOvWmBrPh0W4Zmrhh0/oUo1xJATZxJg8Z2BZXc4sE0tINjqUIUUFAu9tz7B5Ap7saiJ4FmfUlt8RRmPQSj0T2C9cSMIa6I+OTZWhCNoE+T8KlqaJwr5XCX7mpfCQ4ntMkw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6e0a74-4130-41f1-7abc-08d7ba8c24fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 07:18:57.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 783LDQMnRApziGLwiaM1VvCEe6V08GA3XtRkwNeJgExFEkICXwTNbRGXpkDj96IjONk1S8ay8QVKkCkIQ6sJfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI could use SMC/HVC as tranports. Since there is no
standardized id, we need to use vendor specific id. So
add into devicetree binding doc.

Also add arm,scmi-smc compatible string for smc/hvc transport

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index f493d69e6194..4ce57b88f84d 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -14,7 +14,7 @@ Required properties:
 
 The scmi node with the following properties shall be under the /firmware/ node.
 
-- compatible : shall be "arm,scmi"
+- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
 - mboxes: List of phandle and mailbox channel specifiers. It should contain
 	  exactly one or two mailboxes, one for transmitting messages("tx")
 	  and another optional for receiving the notifications("rx") if
@@ -25,6 +25,7 @@ The scmi node with the following properties shall be under the /firmware/ node.
 	  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
 	  associated with it.
+- arm,smc-id : SMC id required when using smc or hvc transports
 
 Optional properties:
 
-- 
2.16.4

