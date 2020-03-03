Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C753D2465E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bcl5vj1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCCB7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:59:22 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:28645
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbgCCB7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:59:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWla2xcOgopgKVYUMU7f2u6hLFwCjBFjR1YzIOYBsnMaD1bqjfxlbFZ/uffPkGw5Hj8iMPMoo/KZ+x0m+7LYWResynbvyLZlE2YtGUX28skzG8LEhQ7Pl++Q60/6+jjCs7zevPCax96Jhc+lX7bcrcpax907SQUqRLjTs2OU19duwdjvBzcQzXKVrgXdwBGF5KiTts5XvXYKpTkziEXiaLWwkrh3vknLfgCG4DzlVmCFSdm6SYM1S1iD+NMy3+X3L1nrx3B761jinJJHbs9o4cfdnfR/rouQKk2EbC48VNKV1cZuRq06oh5Genb8O2IeWOmC9vE4jnjm4jYDjEUK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxfHwjlGJa4S3kYkNq1belQhIqSGjeSgMSncQBN3kOI=;
 b=GicPcVwvAMt4neVaApRlSQkHRDIPB86jqjWOGgfAq9pChXY4H3CU8CQjWYdC6RoAFrYgl0Oxpvou3OA+MhIkT/Yl/0ZtJTcsUp1NduD2y9QdZ+38H7Sc1Z8y3pz+1EyxV1b5eQQ2Klag+XdpYPNLY472TuXEPVZ55V+MHs/o7n/7GE5kV5kVIpwFs0N1lzJAEt9KBsNAbcKmoEwtPsMBWxTSoKG30+g94KxUU331o4700VvucuNkS1TD81ftTTcJ6Nml0vg/84ucujQb+qG2EVF+99tsUtqqxq4Te00QWtcSLp6JBlURy7Y/eB1TQp9pNs2LPBRytn7XEcUDVI+aBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxfHwjlGJa4S3kYkNq1belQhIqSGjeSgMSncQBN3kOI=;
 b=Bcl5vj1BROiu/QnTQ9NJMtqWEMksBgvCrmdg9EAgVWvaQROLJYJNlYIkrlfc4/6Alt6YtvK87/Y8MhzOnKvhbq/befzj9CGiBS6adgJVMQHhZO6wtlKIgUJsUsntmxUpZsjRtA+cdok8S6DXmV6qok2vx/Hp6bV5cvmOTJS/Q94=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7057.eurprd04.prod.outlook.com (10.186.131.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 01:59:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 01:59:18 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/4] mailbox/firmware: imx: support SCU channel type
Date:   Tue,  3 Mar 2020 09:52:56 +0800
Message-Id: <1583200380-15623-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0147.apcprd04.prod.outlook.com
 (2603:1096:3:16::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR04CA0147.apcprd04.prod.outlook.com (2603:1096:3:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 01:59:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92ed0af8-a29c-49bc-1722-08d7bf167b6c
X-MS-TrafficTypeDiagnostic: AM0PR04MB7057:|AM0PR04MB7057:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB705792E82D4265CC689C1A3488E40@AM0PR04MB7057.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(9686003)(6512007)(2906002)(15650500001)(6666004)(6506007)(26005)(956004)(81156014)(81166006)(8936002)(52116002)(186003)(6486002)(2616005)(4326008)(16526019)(66946007)(66476007)(8676002)(478600001)(66556008)(86362001)(36756003)(316002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7057;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wdr0md4Zob792u62iF9Jc77U5rOJCYMamZWCZuSCN/KPur7/c3zbjrhQRNKAAJNqz3b93CwKjqEZFNyu/yUShbrxcsWxo8iYDumDJqtKEX/4FdyXYZUv49xJor8H5pKQ7CZgoOK3NehOqtQBNrA5Z6kISBSxm8X3KnTFL1Yxowlw+FCwweDCgmT/5TIzKURKKJ7a1lswJ8rFgWtLF6Rix2siz8PGz3r47ftRrAfmJSkbQ4XszSgsbr2L/G8D/MOedwMhnLiRAAZy2E0URIxTB+c8AOV4govo1+sC3a2wTqHNOGYkXyqmJyhCg9r0Nv6UIgGwA8w/MMDHVQOhz72QfpskpX1OB8TVhBQ3YLoX3Bmmd7o0xC0TI+p46gG/lv0VGY58J2cyVArIhyBHDSQdcAgq1nu59Fy65NS4xX3jPag4m4wa9NHj6/XP/m9+Mipo
X-MS-Exchange-AntiSpam-MessageData: yLfxkSl7du/DsmBtrU1PSnYgn/rICTUbqKuilmohkUSKU2M7nHOdK5jX/QpWnKbYvMdtMO7IE7enYpq3IfG3DpZH64/MinrYnvF5T4mPoi39NB28wB4oQRaUO9wk3WpyeRuGt90v9ieZce4+A2zgoQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed0af8-a29c-49bc-1722-08d7bf167b6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 01:59:17.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /odMjZmTlrIdfE8+OfyFJHwz6Dk1rlSr9i3TJrk5uqOCzBSgWvBj/rm2OHqUaw+ZytcTAHu1CMVk5Xg44FyrzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


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
 drivers/mailbox/imx-mailbox.c                      | 253 +++++++++++++++++----
 3 files changed, 249 insertions(+), 60 deletions(-)


base-commit: 770fbb32d34e5d6298cc2be590c9d2fd6069aa17
-- 
2.16.4

