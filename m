Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B9CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4088217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ATqKup0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBFNEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:04:46 -0500
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:40961
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbgBFNEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:04:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/ntwDpVNDuPONw0DvVAQj9wiMC6RRlOiLPWG+SMPBWMUZmszukkuQZj+v8SlKJoGRoeLx14DIvTzptjRKYQWINNt7RFjxoVFeRo9sxkII5utZ0MFuE/PVZsCX7MPF9VkEVJZYL5DBvMURbs2o8+CFilyZZDHpgRNUjmeJ5A6LCWALK0a2s3rdT5CfCDLsYiGw6UHV1PMHdhKB6tXZhyM6+/I7vuJINwB73yn56FrkRxtpbve2y2h1kdjUePIhiFvkSuFytQdO4udooyFdTlwhVhOXDH+8E3jGHFbANniGwEXoZ8H/t33TYOX75JZAeSPgHcO9DtEQk9BrLjWX+d9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHfSijKilckf0Ocd/D/WiT7dQGm7dElsEx+7gO/odB0=;
 b=NIxsEWQIBDCbP7AT8Ro/x8nOBzZt5kYwSpGwzF68tt2jzwucQ7YtTjEfC1Qopp0WPc137ywE3GYZmiXU5bgxGdHQnsG0t3At86OwG5BxOpJVPPuezkyoYWwaDaaABnqVpVNQdc8CZp0F0R5qwxDsUMM1JIFhSKwSHOfH7PzWp/gYMT6kNg8OCTVUqi1rkBfPjAUPCXCjuT4naA1G3cy31N6jLUneK7SsX52Po5kGprfsrF9PJoAKouGHHPtOWGK95G5SuD9qTV2FGA1kG7RqFMl9Od2kSLcqWzVoPkHcJ+aAq5+EovNQDYSl0DIQq4qZFAAVfA0/hf7tExbMA2vfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHfSijKilckf0Ocd/D/WiT7dQGm7dElsEx+7gO/odB0=;
 b=ATqKup0LL3QbQlTQVQ6Bm+2A/Mnc4LBIsR+zldflHcNKYb5K6nOKrdhZNJlY27vFohNnWfEchkRj8FBMnrdwXya3kKXLsBNGKILkcZVKlBGPsJi4k7aVyn2AmC2mCPf1nWef1ps2D9/rKpG+BtHckCUkl8yxh1mayr43oz5dtlc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4770.eurprd04.prod.outlook.com (20.177.41.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 13:04:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 13:04:42 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] firmware: arm_scmi: mailbox: share shmem for protocols
Date:   Thu,  6 Feb 2020 20:59:25 +0800
Message-Id: <1580993966-17757-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0086.apcprd04.prod.outlook.com (2603:1096:202:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 13:04:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba963931-86ce-46a6-45de-08d7ab0521b1
X-MS-TrafficTypeDiagnostic: AM0PR04MB4770:|AM0PR04MB4770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB47702E6D4629E4A6CC555136881D0@AM0PR04MB4770.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(189003)(199004)(86362001)(2616005)(956004)(36756003)(6486002)(6506007)(4326008)(6666004)(6512007)(9686003)(69590400006)(26005)(186003)(16526019)(2906002)(6916009)(4744005)(66946007)(5660300002)(66476007)(52116002)(15650500001)(81166006)(81156014)(8676002)(8936002)(478600001)(316002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4770;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgesQtD41UpgvUQnfAgoegTQwDgwAHdAiMbmMDphFrZHiBug2vfysRBIzmJTYQOOxx2WGe9UfMe3gI5DokPYbgSYPNOBcr57V7aMc/Ip85igWK4fHKx3PHUNrjw19tuilQZFL4CCg8eGFfX8Sx6moxld/CZyoPZlxSfvctmbRwv0wZXMD+H8no2Xr65D8yjrFkqhvZFVnDPARvrFt3g4jZDcYJOHcOzOP4GQHUljaUbdVwVN6vExfzJeRnR+PW/1HW8p1qwGZ9lG5OTVkA/nX8EpY9dvbK0Krq0iRNJ8e4Q1h3NmzLQJv0UA5sgede8CGJYqaeK5waP2upC4I6X7btW/qPPbpZcOrb+gS1EvjZmguU2hjNUknCX+AXHeNjvXzM2KuJZL5VbVCvSoBonvPxPKEMgdEd4ZpM3XWkANx9sId7ViWGocg3Q1QqvzztEFH9vRAQpPA7iyE6p17C+/Cb2jYxa7O8VSCiK+gdJIfxm1RynqZZIp+ggWTYc6+ruscMZMz8AQMmYWQgWAKUD0G2RUk3MWw5eSZ75esH/V1AA=
X-MS-Exchange-AntiSpam-MessageData: tiyv8m5VxH5wNrBsMknrCHUwPfCvjiJcbDTOkEZTEK9y3upAyZkEonLKLX0SfA+QlSfHvoUr6U4t6KG8Xnfrp4w9D1joCSjh8n5Ci3NRnbx8t/6jzn+dStlxpIyX6bh3l+44hYwmdD7likgx8mU15w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba963931-86ce-46a6-45de-08d7ab0521b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 13:04:42.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGjOvss0po+fYeAxX92CVLEtg9s4tcQ8tsVxfdOwI1itR2eVNc3uuTxegiCg6elFxB4mci9RJpCkmD+YDDWs+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When shmem property of protocol is not specificed, let it use
its parent's shmem property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Based on Viresh's V6 patchset.

 drivers/firmware/arm_scmi/mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 73077bbc4ad9..68ed58e2a47a 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -69,6 +69,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		return -ENOMEM;
 
 	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
+	if (!shmem)
+		shmem = of_parse_phandle(dev->of_node, "shmem", idx);
 	ret = of_address_to_resource(shmem, 0, &res);
 	of_node_put(shmem);
 	if (ret) {
-- 
2.16.4

