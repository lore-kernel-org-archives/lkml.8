Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F32C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832F624673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjHnUVdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCCB70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:59:26 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:6238
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgCCB7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnxaoXMZjSrr9GEHn+tRIiO04LrvK9XSoSlrAdF2pH88WHVbi7T5FJtbfxNkKNGcyNJoKMqgl//rrNge87cnNmxnwz7DKrkId3owfMB3EXo7l3KfrNcDCEhhV8NIqxw4eEL1gHIaTJFhRUf5Bla/OV0q4DNW0phOdzpDVQKgeTbfpELLXDtX6Y4q29OjtfTMD/99plUCyJU6e5ZBCiLLC093q5W9XW+nIxIyysr63GnjnbIiBMbX1lUpdeep6gn/siXAs5NIYnKn9vuONWm9GqkZslKIfvizkbRgIF8LABGLqbhNEc06I0qLgXNHwXKMp1VzYbrZWVwuA/KnplHTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHIhPwQSPZ86lHfegvZEMamGMqxcR3dtyjGOfGNmch8=;
 b=UUIiAVuxPXoiaQBE2pyxYQFMj+jpZo/6O6JvYlRG6S09+lgQ0bitZj3QRRt2uR3+W0koPXhmtyxGu+ub6a+cKhjkaYrjOozvR/qbsSGWNG8rjs/lKOerLJQDvUmEF7Ibs3NTOBYxzInSltgqbcVOI9hr1F92dR+X5STncb2SBsJ7c5doXD+B8VSI5fozJ8wM/2a6SN3ixgjl8/5Ff/kl2cbBs8Pld94Q84A55AJxWX4K7L7Jd7CCwo9CXWvnad3Bupjm3PnELrPdc3Y6em5wnu/CxWZDeMQK3TLflfeHO7KUaEuP/sHObVxJ4uaOxfRNGGJmSxPGiMYUN/ndKpqdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHIhPwQSPZ86lHfegvZEMamGMqxcR3dtyjGOfGNmch8=;
 b=HjHnUVdLA1CznkrpGXwRpvYPEcjZ1NTX655DHoem+GdaXO7hPGGBpIWbeH/uUkGYa5JxK3aTOtSLDu42QX2cplKRU4ByT0kkbMSzjG2owmI5BH3NeyKO+Bb5+bxvZu65dWcXB065tLweOqdM6eWN3bJxY3WMGz+NQgn5KRpqFbM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7057.eurprd04.prod.outlook.com (10.186.131.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 01:59:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 01:59:22 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/4] dt-bindings: mailbox: imx-mu: add SCU MU support
Date:   Tue,  3 Mar 2020 09:52:57 +0800
Message-Id: <1583200380-15623-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583200380-15623-1-git-send-email-peng.fan@nxp.com>
References: <1583200380-15623-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0147.apcprd04.prod.outlook.com
 (2603:1096:3:16::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0147.apcprd04.prod.outlook.com (2603:1096:3:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 01:59:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ead3c55a-0ea8-4385-1680-08d7bf167dd5
X-MS-TrafficTypeDiagnostic: AM0PR04MB7057:|AM0PR04MB7057:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB7057DB5B809316489115F3CE88E40@AM0PR04MB7057.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(9686003)(6512007)(2906002)(15650500001)(6666004)(6506007)(26005)(956004)(81156014)(81166006)(8936002)(52116002)(186003)(6486002)(2616005)(4326008)(16526019)(69590400007)(66946007)(66476007)(8676002)(478600001)(66556008)(86362001)(36756003)(316002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7057;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFQsO2Cefm2OOwAvsTMFzVWGfcJ1bfcMMutm2akE2ZphN3/pCXd75KvbE+p7zTYI6lzmuoG8htGL4LlAGdb2ArvNidUKVc462oR5BRmLkyy68UvwJS8lFPwvHuPRSNGDClN2uSAKGk7u+umt6Q0RyzFYWpLIMLNVhBYH3W7ttNeGqjgKCVEC82MtKgt6E12PghhcYnBBeITEleoHPewocRlsPRhbeKU/A7Ox8PaS5aX4CdqoeEbKUR1C233N3zbRx8DEMDGxIGwu/D36XoGABHFCSkUtt7Bp0Ioz4+nsfxeQ9A/hMlgXhrHcAYtUfFyx67S4MUExgLKpTatQpcDRl+SOLTMxb7Gp+/K/jUGdYNjSBZLpQJoiF7e51aGgO0B6arXQAVjG3LwQPYuPugj8wygwcmNylRkrYFTX+OBly8LJyVZXSb0+gB3jnSS5fnmHa6kqKjzeUGMBnRFsnjiC0+u9O6nBEcnUXwG4lN4KETvh03uitzyxw/BWjTY/c8zu
X-MS-Exchange-AntiSpam-MessageData: jJfxCLEMr+eOibuBaqXtGQB/GvrScWNatq8hnQpH4i4duosxp4Z/PHyUHkPelkhx2TbJy5iP0un/7z3a5OSx4pzOTB0m4FhUWDbYbwvWINeV1ntHTMBNucyfr9qnKaKIq2n91oFEq0011beFpVVuYA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead3c55a-0ea8-4385-1680-08d7bf167dd5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 01:59:22.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: renoiHUZ/zeE6ezYYwUo2gmAamOCV5NgDn2MMNc+UzFsahqdNeHHk7sLWzEnz3eXH4IE0pNLhvmlRn/VRIXMsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8/8X SCU MU is dedicated for communication between SCU
and Cortex-A cores from hardware design, it could not be reused
for other purpose. To use SCU MU more effectivly, add "fsl,imx8-scu-mu"
compatile to support fast IPC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 None
V3:
 New patch

 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 9c43357c5924..31486c9f6443 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -23,6 +23,8 @@ Required properties:
 		be included together with SoC specific compatible.
 		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
 		compatible to support it.
+		To communicate with i.MX8 SCU, "fsl,imx8-mu-scu" could be
+		used for fast IPC
 - reg :		Should contain the registers location and length
 - interrupts :	Interrupt number. The interrupt specifier format depends
 		on the interrupt controller parent.
-- 
2.16.4

