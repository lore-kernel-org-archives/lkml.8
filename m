Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4868C246A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qBU9KTF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCCCNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:13:16 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:8921
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbgCCCNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:13:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb6x0x4+9Pl+HOhoPYzzC0Sz7goxPsKtS4QDBcoX9Ux3LbimLuHQv9GE/47FVxNIvwRVfkGHI0p8oXd+2GvIiViR8NY5LtN7GHaiE4D9bbKlFL64Zxo2IZWsC926IFMIehimyfjJniQNbdtCUVeFpap+bd+c7S+PlNWqhk9sigVCWlwMxa8eIeD8mXOXj5pK1FEXS3qe6xbJ7GG57gBRp0MB/TZL3nrOgYl5u7gPV9ehwr4GWpcliySmUQ/qIlkWGBCa5PWKeCwvXnuYU3b5hjb6bOEQ64fLkB3QZnucGWNIg7Y9fEFursRd+lvgkiV/6R/HWkwNXJYZw5sdgA5DcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTEPRvmDpn0B7HYc7rlzofD9RpOTbggaLCyUpfkZ72g=;
 b=bWJaGx7ugVz8enC/QIs6jfV71kVSv3HY1xaxB/bGXP4BMrt72+J2jvtd3jCdNZRcfFzFdLnLdcbUmO4/gEoWLh45ddJewAxCqz7CRblOsmuGjP2ZLo1WCNJcNBwmFekY7hGIp9DnH201kBmcT+Ac/sdbwfVfKXByHyuTO2B4QERFCmJHxRIP9Z2baaHJc8G5Haoe/pVTjjsBWuChJtH+ibMJd80X36fdyO/NKJtbivzv+4AHCkpI3GFIT2vdWxz5HWYQu8azdOX9j33xul/i/Q8SSLL+EBJGSWQe34fModzVAk6PkK1tcacjipj1evEPpzlwX6um5XvGs/A4fvGkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTEPRvmDpn0B7HYc7rlzofD9RpOTbggaLCyUpfkZ72g=;
 b=qBU9KTF8pUtTuX0k4X317hClSLYCSGEJ/qjD2MVtQIrXvFfOWQSuAnVVf0YN104BQUkjnltMX96Mftlq0toSiJB5z7MN+USye33qkfeY9LaONWO9sJJkoicA0srrOCLGVbmYeifjyxxWBi90zRpz38wMuczKMrCu/GXxc0VdC64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6946.eurprd04.prod.outlook.com (52.132.214.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Tue, 3 Mar 2020 02:13:12 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 02:13:12 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transport
Date:   Tue,  3 Mar 2020 10:06:58 +0800
Message-Id: <1583201219-15839-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0125.apcprd06.prod.outlook.com
 (2603:1096:1:1d::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0125.apcprd06.prod.outlook.com (2603:1096:1:1d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 02:13:09 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba6a04d7-e2bf-4240-3a84-08d7bf186ce1
X-MS-TrafficTypeDiagnostic: AM0PR04MB6946:|AM0PR04MB6946:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB694652574B875C631C7F27BD88E40@AM0PR04MB6946.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(6486002)(478600001)(36756003)(6506007)(52116002)(86362001)(2906002)(8936002)(69590400007)(8676002)(6666004)(81156014)(81166006)(26005)(6512007)(316002)(9686003)(5660300002)(66946007)(66556008)(66476007)(16526019)(186003)(956004)(2616005)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6946;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbW2mZlaxu0D7Mn+F7g9aYEkKiGWZdEKvmtCNCtPpCzy3dH6ULelpg6pO6p4lEtt7JrkC5g3/pS8eTbAW4YZdZB3DBdO0NXh9L5yI37vrC2C0u2TVtaXADMz31uWhWk155OX3XEx+ykMAkvURvuaxK740vDJ5eQ9obQd9q68r49Vaw8JioYByU8FMHcM5V7pGZOhs5d4SKT6w1edPsXNvNPcIdpMquAI9mSFY3GPyKeW1w3yq254zZ9E3wJdtD/j94nu4O3NupTzzZeQSDaHal8pEx+iWN/NNjuIWqTLJBJKqlqKDByivJfuaRonAxMZBFsgYwxKhWhdOd8uzZK/dCvHbAjmpu9FQT1piVUry+/wE2v5TGWV6tuWNbCBo/kAx/U0RRHHS9KrmIGwtE2fBRdnyP9oNZNo0E4rp1H+UYeKiKOA1tBRBDZrkW41XTEvvM9pKnNctNZpJQQeXSEFiCyxvZqJ4S9txl/DXClodnRl+lz8F4tTU2tnLPQ8djLVbfgC6xcFQNIom8acU9vwxw==
X-MS-Exchange-AntiSpam-MessageData: tJ362rWL8WHIKae+B8UAtMu66rATSGb4w34IvYyNu6F64Ip+BrNFTyPHsOdUQ1df9IpjjOS1v6emX+EsSXZk/J61mLO4Au97nLkMwUo2kWPwTYvLEO93M4gQjODsjyfCsYQrtPdIf7HtA/B5GcAGIA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6a04d7-e2bf-4240-3a84-08d7bf186ce1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 02:13:12.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24XlgF21azL8q7gXAOvOqB8xFLPibpKLOS+NwY5lqgn6NifccNuB8JwvGBCP5zbvGbsrBJi+5HZhfgZ6NBA9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6946
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

