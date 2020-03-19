Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6486C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7120722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DfoaqiFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCSH5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:57:24 -0400
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:6099
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgCSH5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:57:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljCWULdegx1MalgwONbgFI83BIwv7TFJIJoVFemjprXuxYfjE7R5avFJNw44/Vg7BYXKAPjHRGok1JsIQsQn9F3UiFwilDHDcV9+qD7KU35RAzazNu3otyPkvNt2L90Q0RWJK7QCxBZTfZyAbAA3K6+nJMklmNuovEehB0z2weXqt1P4ium2G8IBM4fcr+rN1bRJV2+LyaQ2sYLKEvsDUzssMw5UMvC6k1JV9umXvX+VSd/h6YlwXJavJNlb4UTi+TW+Rrz6jw+CMyyD3lMNrZNV7tI2EgctzSSOYTSP823KG33++VTfbFY9ssOsUbVjLcB9ygLpO4+6rpFvzi2mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfYC0tiDswtEMx6MuvV2P75/ztzxCNZ6JuOk4Hi8kOI=;
 b=gGyL04RG7JKk125DE4Q8z84FXnrDzozDg/qz2aMr0rNSzBSpeoK1TQR72dmknOP/nNQRFbNl9yFjHjvG3PjxQSJU2M+wQVVxnedFTHNFDWIr6peOiOYPeqvq77+sx2Xgy94REVldCV2MxlZXcu9CevQ+DvPUsW94EiqV5BNVxPUwIUwmM20UTdJpld3eldFZQzNfMPIwgpGv/RuYROGS/Ab7D5nJNqEFqSok+YPIi69BE2HyetD+G3T18X1rMDmqQQ1xjcnzrqEqvemlkmP2S92pQTlpexrJkPI+MQhiLhX4xTmJKTExop5/LE9X6CKmOUh8eGyjJAEFZ9hRbYfKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfYC0tiDswtEMx6MuvV2P75/ztzxCNZ6JuOk4Hi8kOI=;
 b=DfoaqiFk/t2cGhhqF4CVKka+b95HTRdbYNSnK4pk06n1lMCt8w7K1z8bHPmEqwnN2vc36fGRiEfEqXgu4ZWK+TNtnho42wZg4CMDfhvTBGXJyC6FU3FGxu2aBRF10weGnzi7C8QjDtcOfE/Gj2BTYegRNSOgSPH8dRXiPijQpSA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5956.eurprd04.prod.outlook.com (20.178.113.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Thu, 19 Mar 2020 07:57:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 07:57:19 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 0/4] mailbox/firmware: imx: support SCU channel type
Date:   Thu, 19 Mar 2020 15:49:49 +0800
Message-Id: <1584604193-2945-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0118.apcprd02.prod.outlook.com (2603:1096:4:92::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:57:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 670f7893-d165-473c-63b6-08d7cbdb25bf
X-MS-TrafficTypeDiagnostic: AM0PR04MB5956:|AM0PR04MB5956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5956FE72AC87321B3694B80E88F40@AM0PR04MB5956.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(26005)(36756003)(86362001)(316002)(2906002)(15650500001)(52116002)(6506007)(66946007)(66476007)(66556008)(9686003)(6512007)(8676002)(8936002)(6486002)(5660300002)(81166006)(478600001)(4326008)(6666004)(81156014)(966005)(2616005)(186003)(16526019)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5956;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCmKmWbI+T6EJ0PTiwK3zkNEBjtyDetRANmY2RQtVkcYrx6PGSFils5DcJZsrajvZIETtBfphYYc0O1Sm0AQaRYBhvZN6/70rrRRqO+vfxtFfzvjOb+CT1HD0mAH7PQfOn5LtU4L3NTFOFKQQIUxKziOtEc/3EkMTADpBFh9JgFdA1OL/s/Z/eieCNeoot6jPrJ+58PBqyoixk7AutzjQ7xrTx/D30FfPMZ0kfLkExqOYWywQClvaVRXp+mg7r2CdcKByx7YxDxi2qBhm2Eq3qJz5iDU478VM173OlypgMkyHvVNJsnBfL8GpZDz8WwbU6tKTBoJatynCqhaor9t64oWyq0lsp7YWw+tDP1GOwT2V4COlxsdS12uQAccLGGl8dJ8fm5Qo53p9O64BW82bsKXD8CiNfbT0B5CM5X/xa9RV9lzfVKgiBcRL5VwTbRG2XngHWQQ7c744B/Z9lvYXq9lzS04L25IppAoekR1ZNQ9aiT8VvOYYO+poOFo7gW49EWntG2OKLmQI8v2f9z1rg==
X-MS-Exchange-AntiSpam-MessageData: Rl/yRLZCLwdHUNn27ySrwqOjm+soKECVu7qlZq8UIL/+/8nmubIFwsgn5+TPsfmtLNbx6g/bmk8qijUmv6cj8IadSJbVFBPFxt9oN3j1SaUV1aq9QRjK2UGLVQmwNIYl16Mnvcvv+QwBpvYdEo6rEA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670f7893-d165-473c-63b6-08d7cbdb25bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:57:19.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wref0OrskCtBNLZw5zaTnSavSWj9h4i+GwHexzxo1hW0d+B3IRKO1+/KuSNUml8VUEvAMDc4anVZmsHdQF/muA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V7:
 Per Leonard's comments, added check for TE/RE
 Passed test from Leonard's https://github.com/cdleonard/imx-scu-test

V6:
 Add Oleksij's R-b tag
 Patch 3/4, per https://www.kernel.org/doc/Documentation/printk-formats.txt
 should use %zu for printk sizeof

V5:
 Move imx_mu_dcfg below imx_mu_priv
 Add init hooks to imx_mu_dcfg
 drop __packed __aligned
 Add more debug msg
 code style cleanup

V4:
 Drop IMX_MU_TYPE_[GENERIC, SCU]
 Pack MU chans init to separate function
 Add separate function for SCU chans init and xlate
 Add santity check to msg hdr.size
 Limit SCU MU chans to 6, TX0/RX0/RXDB[0-3]

V3:
 Rebase to Shawn's for-next
 Include fsl,imx8-mu-scu compatible
 Per Oleksij's comments, introduce generic tx/rx and added scu mu type
 Check fsl,imx8-mu-scu in firmware driver for fast_ipc

V2:
 Drop patch 1/3 which added fsl,scu property
 Force to use scu channel type when machine has node compatible "fsl,imx-scu"
 Force imx-scu to use fast_ipc

 I not found a generic method to make SCFW message generic enough, SCFW
 message is not fixed length including TX and RX. And it use TR0/RR0
 interrupt.

V1:
Sorry to bind the mailbox/firmware patch together. This is make it
to understand what changed to support using 1 TX and 1 RX channel
for SCFW message.

Per i.MX8QXP Reference mannual, there are several message using
examples. One of them is:
Passing short messages: Transmit register(s) can be used to pass
short messages from one to four words in length. For example,
when a four-word message is desired, only one of the registers
needs to have its corresponding interrupt enable bit set at the
receiver side.

This patchset is to using this for SCFW message to replace four TX
and four RX method.

Peng Fan (4):
  dt-bindings: mailbox: imx-mu: add SCU MU support
  mailbox: imx: restructure code to make easy for new MU
  mailbox: imx: add SCU MU support
  firmware: imx-scu: Support one TX and one RX

 .../devicetree/bindings/mailbox/fsl,mu.txt         |   2 +
 drivers/firmware/imx/imx-scu.c                     |  54 +++-
 drivers/mailbox/imx-mailbox.c                      | 288 +++++++++++++++++----
 3 files changed, 281 insertions(+), 63 deletions(-)


base-commit: e506dba69a5e9aaff20fd73a108639f84e2c39d9
-- 
2.16.4

