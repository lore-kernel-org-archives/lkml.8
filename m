Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E794C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D829B206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHCSD518"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgBMEEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:04:43 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:60996
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbgBMEEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:04:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXxxabR4Iej2OCw6B8oWTg7ip+0FZR0aEd2k8CmE65YaD6jwnENf8hC5jlHPqImHycswWuYfTrRbot2pOk9E0B+0YBaOVNBlts0Q+J2YFTi+ZApiobjmrrFb/bt+4WnfMxmmXXUN9u2r4YCVFbquHS64vGDx+9UK1Fc21I8CGZYOXEXHUVwQQkxAR54aCDdSJYqUgT+Y2Eqy5/r+QnB9zT1UG/rFvRSOZHSCoLYO9mlKS0FanYZ3abWi6m8IwPnLQUbDHImI0MYkzSk9o+lECJTul3xqKr4WLOPRKSMDkM4/0clOG4xqTUf5ManNcMAd7ntpkJdHwbw3eNALsRlKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3WFJxMHK7dWSBJAP+NSyGDp4Aeq2W5fMrYXJyaIzlg=;
 b=QvWxiJh/HELF9nuIDng2vEZOSsRu3Q6ssxDDxFyx2qkNrHibEnOyZPPVDQqAXwcMDxh8UtCemuOg48mXIM2FsFEET7WC/bkiz4TE7kek1NMBeQQeM/1PDjCp5bTPCK0sE+m8nBshcAYA2hVDJjkXJHMdfmDvnG7fQw/sGnfoFR0r795zp6sGHR67AIdxWxA0M9bwkYhjZZnJJJXc5cMjjSwk3V0xdIzzymhw5D5arFi0IROpu+vfVI7cu9WDUGM07mIgDsj085dpvV0KQLlDMOpgUYulTKgg4HY6FDtH2KMdREpqEEQisR/30X1TdfAelUizb2FJDkMlBUzHF4sFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3WFJxMHK7dWSBJAP+NSyGDp4Aeq2W5fMrYXJyaIzlg=;
 b=IHCSD518lSxcH/CQAm5cq6X6gsRd2H3IQ2MQqF/5fCbzhJJwKKR/qVJthV7bFh1+vp50fP5VFNdg1874K1sknH1F5OhA2MhVKWx+J64+Qb5A/CBBk6d29F9l948RE2J0t5NpXL15h6p/Cw804378TRcusFDBI0u4O21ga8iMvxY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5220.eurprd04.prod.outlook.com (20.176.215.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Thu, 13 Feb 2020 04:04:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 04:04:39 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Date:   Thu, 13 Feb 2020 11:58:49 +0800
Message-Id: <1581566330-1029-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
References: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR03CA0056.apcprd03.prod.outlook.com (2603:1096:202:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.12 via Frontend Transport; Thu, 13 Feb 2020 04:04:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88a68435-b4a5-4cd8-e033-08d7b039d8ad
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:|AM0PR04MB5220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52206F01C4B811437CEB602E881A0@AM0PR04MB5220.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(199004)(189003)(52116002)(4326008)(26005)(186003)(6666004)(36756003)(69590400006)(6486002)(956004)(2616005)(86362001)(8936002)(2906002)(478600001)(66476007)(5660300002)(81156014)(8676002)(81166006)(6506007)(9686003)(6512007)(316002)(4744005)(66556008)(16526019)(66946007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5220;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1ByVuJf3pUlTJ0jbkQleKpT3awRjOt9vP5pOlIW/eFUCOJbCgVt63jdsklY1VeBBbgAy3zXcZl793bpnW+hfSuw4JLRRq9XLwgraE4nolPHxdXOMeIW2QPTefAbDWlfhrdJwdu1nCjifj9gLVPID7SrOzJRuWrCoVq35tMrGj5IIZ8MWnSURDB3DgnXVKrXKUXSvp6dRjMIu1aIKXTaYWyQA9iDBHhFjKNvcQ3qMryrlj2VQO11zTzB5/oG+e/9mdN5UiBkELjtlkpGec0yo6FMzegevdeXcZmx0lTFLSlBQgKZuugX8FdnAKl+sexniUdjk5LOicrVeCqG1p/I0/bXuzCz7qpVx3GdENIH1GgSIDhHbO5O2JQyqD2bVKuVkzLzA5kagpd37bwhYSiS2FuAHnKJUS5HtsfkzfI4eCPF3ibppz3GqDPwfESJ9aJDT+aghkp5BxiX7LBjkJxP40lYSsrOfdDVu5opgKnvK8xCVVxQr4hyjGICPI5Vfi72OxmyU1C1Pji0cy9nVYB060Vwun9wC8bv6RQl2syib8asfDf7ks862qVmMhAIScWp
X-MS-Exchange-AntiSpam-MessageData: 4eURe24jHErBakCP7SwP7V7cm+vrsKeanj/tOFA8ycdFHWeLxrtCY4fQ2z7Ut3UzVOpHzZN0fXczwajO+OUCvi4ksGxx6kNkqTrSLLRYvpuM6DwRV4dXtI/Uv1ISjt0V5v1GTKWyaXL56o4/XkusLg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a68435-b4a5-4cd8-e033-08d7b039d8ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:04:39.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAvLIwhVY+B1hgXBB1dsLy9x+z0OJp+skJUhPAe4RwaAY0T2r5rmcdOsOrR2M7PxxT9S99bNowrZ3Ftk9o70Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI could use SMC/HVC as tranports. Since there is no
standardized id, we need to use vendor specific id. So
add into devicetree binding doc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index f493d69e6194..dacc62dc248b 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -25,6 +25,7 @@ The scmi node with the following properties shall be under the /firmware/ node.
 	  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
 	  associated with it.
+- smc-id : SMC id required when using smc or hvc transports
 
 Optional properties:
 
-- 
2.16.4

