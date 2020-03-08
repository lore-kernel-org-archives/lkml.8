Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D1C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3CB20866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pxnSRS0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHNbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:31:10 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:52159
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbgCHNbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:31:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV6ehLdTH5qwgQ2/Y485IkOcuG3jCRfdmo6GMQpH2PeZpibk81blyIvHrieW8PRu9DjPVgcVMVSFNksE0nWfiPSPGZ/8xAeTFQA0KO4zH0Tu90XUTp9Uy7j8ApAuAtoEG5sc8wJlqvIrdJp2QeRXbQjhGOxL4a4nOdz7Vcp5WcYhTSqrXApmeDmrpa1b10hGZ9MrjSTZxj0W+LSEhGlkFBYOSZOwUnzbjTOtvVdhPHV96foaCpvnhqkLDqHG6NGFpnzXZvZiuyV1YVmc2csMGzjD/D1OOKqnH3mLbJzQD3m6tEqBLMAnD3aetvwZJqMuDLNAAMk04snyj6arHLjn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWVRd42hKEs8dz/naK502WbxtO5C9uYAL6Gjqs4cOgI=;
 b=LE12QFwe+x7Yv1mh/pmTwKx7ux8iBdspk8Ura9iJcxipNX7GUZA5yqVyi71LI3YY3ptEawFRuNiuZL2yi9va/vYruWECHBo0VTqu66nS+1wtDgAg1fWOwvS55Y7jSJ97vdfKOjNt3K8NuDSetyF7lTJRvagLPQ38FE9hqy4dYCRX3j8oIdh1yMvVKtov4SdLNjv5hK3qAzJUUuKZRoz6i7fvDh356eyalCVorY+I8GW+DaFeqgaSpo2smY5Y6KdPGCT+nwgUQkKl+X6fHGJA/+5wjg5dLoywQ+Ob1taeTo/E/D4pYwxQ9DUhwGkFVMgPnYq1t//eowzOkV5QI4cd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWVRd42hKEs8dz/naK502WbxtO5C9uYAL6Gjqs4cOgI=;
 b=pxnSRS0vwx6a+XYnkPLZ7yP8KDgF5DlfaoGw3cB8fnTTi3DVPJEDtsJSRnMWs+bimfpZCrYo8aqUM5Upy6PfIBv2U5SUPxdz7PTzMjoXLYGs44tSUr5nWLygcPNiakvgQUQBseApe+eAC5BSsasYrB2UPrNCuioc05f9gtfP9J8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6275.eurprd04.prod.outlook.com (20.179.36.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Sun, 8 Mar 2020 13:31:06 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 13:31:06 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transport
Date:   Sun,  8 Mar 2020 21:24:38 +0800
Message-Id: <1583673879-20714-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
References: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0116.apcprd01.prod.exchangelabs.com (2603:1096:4:40::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Sun, 8 Mar 2020 13:31:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2a557b0-f23a-43dc-b957-08d7c364f49e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6275:|AM0PR04MB6275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB627558F61F33BE63E287C8C288E10@AM0PR04MB6275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03361FCC43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(5660300002)(16526019)(186003)(2616005)(956004)(2906002)(4326008)(6506007)(6512007)(6666004)(9686003)(52116002)(66556008)(6486002)(81156014)(81166006)(86362001)(478600001)(8676002)(316002)(66946007)(66476007)(26005)(36756003)(69590400007)(8936002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6275;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwluFMXTMeskhr9NROLgE3wV72UpjkCvDE477iOKKtdEsraeT/Zo96i+9MqnnsCdy/Ai70fTRwE8qz8mhDc0grozaaMyxs7ZQlgxagOf0yubwY910djpM1ozHlNFZUbCdRUjNQJVtBp/VNoAVo9PdPhQyvaKF4hpbBQ9yfDgf0gh8q+1ysag+mK4a1WA5Wv5ICc7k9sogevr06ZPSRfCLNIoKSOXR0J7d8TXZQKsA8b/aSNfMNJXaQ3IlQ2sHGcBC02oDLjkmFFNd4tw0OgbIiorAdeOU7S1C7B2ok97p49KyicImfY+nTTfxd+x6FeqdqHNrxDrNqOF/VomfZHgFKXzKncFKJ7/hw3VuySTVtcSawCPS4/yk3TATHNOk6P9zukqHudKaWy+0lucQ1EpDo94/ya+BRXTVuw5zAwHc7EDj7XS/DOqVE4Qa8SpAMRqHOSuVvnA9dRWFHIR+vSVCw++ZjBUbF9vwwAFz+SFNQcvLq3gUFi0Wqq4LJoAJ9BRzqXBpihH7//I57K5SR/I+A==
X-MS-Exchange-AntiSpam-MessageData: LnyqRqdDFEpK+dtVBozNbHU1xDOvn8QBkHW3Muu0gZtzpsU6yFDpj2iz+Wc7NxJDY5RSCP+GZwAnKGL29gCD/k0NrbvzWzvOaF3kD5IzZ/Y9FZrqlSLTNDVJdwdrlYPOjJTis6UkkVGyaQa8I633NA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a557b0-f23a-43dc-b957-08d7c364f49e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2020 13:31:06.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvUQYY8JWaFdd/7bskBIqdaFoy5rVaIyou4MizEcxBBCU3dYkeeOspgMcaF52Z6TccKX7ut+6jwa1qm8qcsjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI could use SMC/HVC as tranports. Since there is no
standardized id, we need to use vendor specific id. So
add into devicetree binding doc.

Also add arm,scmi-smc compatible string for smc/hvc transport

Reviewed-by: Rob Herring <robh@kernel.org>
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

