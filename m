Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C815C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BA92166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EFVtjqzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCDFz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:55:57 -0500
Received: from mail-am6eur05on2053.outbound.protection.outlook.com ([40.107.22.53]:36704
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725271AbgCDFz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:55:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1MjS6cXqmRnj4AamD/rqp6pwjaef7vz5ZJpIWUrkme7ndbcq8NPLDjHV3LKuw0/J6Ldvh5fmCimNZNR2WhFE5X4JsJeWkM3uZ6d5PlszPSsZqe42l9Y7yktTyVdc9l1eRWrLY/k27+0IpXGUcLCTN31xoCa7IgFBlO2CrI4nLAqDXeZLIkVMhNVHGJ3eE5HU6tJ9dxT4pCX6SPr7WXDj/sKavZuZNOgtebSnUnq5/fpdDxNijj72PQPL6OWzp5kVqxjqQ7oqRYlAdXbuPy5Zc3vMCv9ZKs3Sq2+dFP9to2oTUH4YskWBtzY1L5OucEKfRlvNcYpe98mMqHA096y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAFRintuq51dkWazuKBiRasNFIRbGW9FyJTdxezItSY=;
 b=KQUWGPJbAIlpHpn7FjT1Ubz4eMiu3vjFyjPWZxTcArPl0Lejxsh6XhWEk8+o0M/PdSBP0Z5YghXD6VOdctjLc4jd4VyCwYoP60ZbTRHsiB592HRANCerbCsrU6BpCuSzFEc99t3irahJlkxEFb++n76qS18exc8asM19Im+gByFBiZtiqTSDDNEZcgVX2tNhflx1yhpqdtjwsaiQn6M9YS3Q/PZypE+pzZkEwZ7gPQ+qD0B6/1DtzRSVbALJPYT3EqaPVmOlpUuk2KGsjeqZtgAdtff2Xi5KOSJn78k0z1wG2YFMXsuaaBeU3TPEBctJET7dleqHd0dVrEzoo3JxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAFRintuq51dkWazuKBiRasNFIRbGW9FyJTdxezItSY=;
 b=EFVtjqzCT/19HFFwWyzYwdxlliY9ZkQOGboC7qPpPHu88u9DbucGZL3ofIK+WFcSzqCeor5revNnfMyv2a5AwvUMPROz1Tm5+P1HsJDbD1i3efMdiaeqoIDKyvfbu8ET9PuJFPjjZlP361DYUb+LwWRiuZtbmKxxcR0hmx4VdJ4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5860.eurprd04.prod.outlook.com (20.178.203.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Wed, 4 Mar 2020 05:55:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 05:55:54 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/4] mailbox/firmware: imx: support SCU channel type
Date:   Wed,  4 Mar 2020 13:49:33 +0800
Message-Id: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:3:1::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:3:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 05:55:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dec08fba-2bcf-4d45-ad4f-08d7c000b3a7
X-MS-TrafficTypeDiagnostic: AM0PR04MB5860:|AM0PR04MB5860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5860016532A91CB68A21D96988E50@AM0PR04MB5860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(81166006)(8936002)(6512007)(15650500001)(9686003)(5660300002)(81156014)(86362001)(66556008)(4326008)(8676002)(6486002)(66946007)(66476007)(52116002)(6506007)(2906002)(6666004)(966005)(36756003)(16526019)(26005)(956004)(186003)(2616005)(478600001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5860;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xufQ9YXtq4vgOwC/DRSXapOXf2XRtilVub28E2CnXm/PBpnSAYRq1lLzXiwEBaFUk8udP3rrlswfQTahbU+kU98DYRDdaivrUC5d5JAEo7KQbL+EOmQSQBcKdcwyUO5e0jj9BmyT96+IVwVQ2Z4PRnfhvSZENFofxQqK6GZhRLU1J5ZXjM/VnwDl95pOtmJDa/Wy6/E8E0RZa68X9NpKIT6JTAjNvFZM8hZHva+i8T8BRxnM0KMJ5NsYXkQ7N3M6jGe9d16oHrvIUQ5EXxBqmLrAHRdgWUIuNufjtFtKIrijtt1kM5fXwxPO/dFwoOBUTuxddxZx/NBCuNMTCjAW7TjlyH5M7yt/OkA4uQgUtu4ekHTM1Bc1Ys50/5x4C2j6ZGOOa8zK1DyFvWcaDjIh6S35ASLwUN06+owScqpwk4q9sD4hIMfyYltEjK7QI06CIJ7rU25HhDBfXD7WNgCxYKWx+WEJoYVNC4zcJBedBSqcXVueygcEPhXmU5HvqzVdgdQFP33Sxy9TVp4hkD92Fg==
X-MS-Exchange-AntiSpam-MessageData: VYyVCq+aHE7dAjM+pueYvrOMNeZqRZk+WWlrWKHJq4gWJMjgREZGn7V2S+8hp9YBkWYqJ23YSExFWY5F5jZdQMAohYCMpX5SRo305lO7WJxcwFyK9ZUuXdj4tZHTLoOokoyfDh7Dutlsenb1F08XIw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec08fba-2bcf-4d45-ad4f-08d7c000b3a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 05:55:54.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1lyOZJTc8iZTZGLmK2pzRXYmHdlbPjMVjfqSehMEfDe6msIFU4rKF/zFHdwo2ZQDn0L6CPOPymYjBfrBLyRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
 drivers/firmware/imx/imx-scu.c                     |  54 ++++-
 drivers/mailbox/imx-mailbox.c                      | 267 +++++++++++++++++----
 3 files changed, 260 insertions(+), 63 deletions(-)


base-commit: 770fbb32d34e5d6298cc2be590c9d2fd6069aa17
-- 
2.16.4

