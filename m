Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE07C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE26214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s8WuItH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBFNGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:06:50 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:17029
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgBFNGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:06:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0BOZ26fYYJVZ7YA8J52saTPAZp33tE9o03T31AQ0/RVzCdgEnBk+L4wcZR/X3NhQwtAP/LtDZIWzGoSlo6e74h93jOpHGWljnsaWzHMx467afFKuUPsNnXBW9OZfeAIteZ/5RUKEw8ZZGLmCSG+YwEc+7OI2bf8hFngZgKb0up2LcLQEc4NdcMbxLEPo4ExIDQmmU+/Iv6XEvRrh0pkXUTfh7+jgKK0pn3z8auc1ZUoqv7+X8aHqlmiQiZt8CtnMT8b+/toSFwt2w0jWTBKK9NhM4kCAxkpn0rf1qsq9e0k1s0QWKM1+yB6/XD87PW1Lmg8Gg+aAB28oEi0L7uLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkvH+Q9AOBv6o4IB9gqkOV3V3maW0RSzeNKUxe4Nkwg=;
 b=TkzQ5uShZspPDzWzuVkcetrknG2up3p1yDo45vjBFWcg1CwO4MtR3XrQI+CCS09qpnLFCwlP8E1qhvTAsbOHzVaAv47G7YKqOE7CxJbGyq4lybSSmo/v09MrFzG8JWcZaCYWZUE6rf4UN77vDmlazU0fQhJU7RkpFnKiU0tTPtGfeSMc5fS+iwcEwbHHdxj7PU2Swqtx1IvpfHqcnnw2ATg8dl7BEktbQCYtuo2+aj20Bsw/UmFEAwGkg3EengZOBX/pIPVHUe6bYIrI2zeA/MaueU+0Bp4Du/j4E1j7tqlKQVSLFjuaMG7yBVDKhn7FvrAKlL+7iorDrMdOdHWtyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkvH+Q9AOBv6o4IB9gqkOV3V3maW0RSzeNKUxe4Nkwg=;
 b=s8WuItH6uHm9rbNa2IRHdU/rAN3MGyVW8gG6VOAYXR14imtGpzxYSuhPDJm5Y5dlkk9vjCfYqiky1FHBt/HNlf4o7eIqMQWben2L+hGR7XoAafFBW+g9hT1yZuRknFr5OK5zcEN0kk6NxS68owAubN/ZonSceIWuIbDKy8hhZyQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4770.eurprd04.prod.outlook.com (20.177.41.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 13:06:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 13:06:46 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] firmware: arm_scmi: add smc/hvc transports support
Date:   Thu,  6 Feb 2020 21:01:24 +0800
Message-Id: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:202:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 13:06:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe40001c-2dfd-494c-2238-08d7ab056b80
X-MS-TrafficTypeDiagnostic: AM0PR04MB4770:|AM0PR04MB4770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4770D49E8D440FC66D0421F6881D0@AM0PR04MB4770.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(86362001)(2616005)(956004)(36756003)(6486002)(6506007)(4326008)(6666004)(6512007)(9686003)(69590400006)(498600001)(26005)(186003)(16526019)(2906002)(66946007)(5660300002)(66476007)(52116002)(81166006)(81156014)(8676002)(8936002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4770;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIJ1GosEGIVaL7dWcoQMbLgyE6Qg0UTD+9Ym2fdA97lxdTNX59X5NvRqn4w0Pd7YErLl///+brJXV1Fq1WN89FkuT/vRoo2CtreWw8UI39FJ9COJWZYlS7igWAfxMP8ybGzFFLTWNggNWX3GR1HnUIhHjH1fdYsFzRN6bZe5/HVYio1yqpgNvttllYuxEnD5mxXbWCqm7jYLpbnoGOBDe+2lAWwH2xnc8lM/XnPcd7R0hxk3j9HC/eVhpyBW4bnseEtmFMnTxEnUqUCk840JVr5V6jCmaPdhLzJVIIfvXBpIwpOmk9yWlf+WeJ5/4lbpasyJxUEkVWfImMdpp8764hLA++8oWs06EzBwzy1X2USwNk2IGXqZrKUYFR9QbKetKFVFXtSXPjr00jKWboP792NBtOIFEZgEFmVBXQpofYwMpxuvl6HlC2MwBzRw8SfMujewAxx5aq9MFgwQ9IaAvbPy72pxs2JOKUHi22qOdI3AMAMYyL5oaMj7vPDzyvH3rc4AKVb25BfP1vLwyG+DGtUHXWcbiQ9Kg3ubD0pSj50=
X-MS-Exchange-AntiSpam-MessageData: jstqu2wCaeshREdD1+Y/qpDe0Do9WEw032AL4ABWpbbTbUIgx/wvRcW9KTbMN9ct7fqPCg7+dJqeXQlg//qLxQxtlfC7BOm8HuSp/E1iVspHrc9PHm9U5w1P4NF7NBlA6CrBcBWzXwRwUsi5vYbLYg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe40001c-2dfd-494c-2238-08d7ab056b80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 13:06:46.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKiHks4zi5/JoD5rKu+6BW/AibAOuNmbm5vt9ny4wy8BMkXT170xfSgIKARjSxu04uc7NcVtjTbn89C9krc2Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is to add smc/hvc transports support, based on Viresh's v6.
SCMI firmware could be implemented in EL3, S-EL1, NS-EL2 or other
A core exception level. Then smc/hvc could be used. And for vendor
specific firmware, a wrapper layer could added in EL3, S-EL1,
NS-EL2 and etc to translate SCMI calls to vendor specific firmware calls.

A new compatible string arm,scmi-smc is added. arm,scmi is still for
mailbox transports.

Each protocol could use its own smc/hvc id or share the same smc/hvc id
Each protocol could use its own shmem or share the same shmem
Per smc/hvc, only Tx supported.

Peng Fan (2):
  dt-bindings: arm: arm,scmi: add smc/hvc transports
  firmware: arm_scmi: add smc/hvc transports

 Documentation/devicetree/bindings/arm/arm,scmi.txt |   4 +-
 drivers/firmware/arm_scmi/Makefile                 |   2 +-
 drivers/firmware/arm_scmi/common.h                 |   1 +
 drivers/firmware/arm_scmi/driver.c                 |   1 +
 drivers/firmware/arm_scmi/smc.c                    | 177 +++++++++++++++++++++
 5 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/smc.c

-- 
2.16.4

