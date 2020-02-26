Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE3AC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F9E21927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NXF8xZ44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBZEqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:46:49 -0500
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:10942
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgBZEqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:46:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOAS0dJKgTA4ywWSLE2RJE7bi5vKZOaNgS9KOWYWnjF6awq2l8beN1a+z5wHyigqMfeq/rQLlzra03gEJai05nQG5r0hhrO7x3evmflxTijvrbHdI0y3ENnHRBVEGURCa2xo84hUfEkW7dp4VsQnNLkYrPjk0VjVva589borkwTssJDMdefFBKMmj4OGxhhSGbHFAou7V+g60eUvalU/E+sSE96+HoWMexbHozNaAcpA9MawB6j7Hwp4KIgEt7nWiv+Fb1gX8bO9SXf6irjMbg2UY3ZaCwKpQRjEWvG7EpOrc7yqWCOp/BQfc4n302GUH2ZIUKWMfkLmt/dNNR9n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYuCEoEzcR/qhzHlia3eFVR0dLTljxPsdFi7pMHbulI=;
 b=HxQaIY9AU/uXOc4//vIhnaLtwqnuX7h3XgFgQAKfWqKWRC7OVsxHI/N1O+Z6NuFoHUoRcO1sTnjBYex852Bfo7enJkRDTaLCMW5/JdnuLqChEemZ8JD8JARRBKxXn/lqHYEBjt/HZcWvhIy87gObzO2YpWnZWe3lSyZ2gileWodI8TkL88VaSVUuPeuSOIkfQWy0s7kQ/yM8JCXS/LsxSOwkfyOR8oEjnweD2z6EyccG63i1JP237E8j6svnyJftxMlIvhoFy9m8sb9dIDA0fLBgRp3Tj9ogxpeI5OthSPYS9+967Xx5RSNOY9qUsT1n2a2BtUJ/AcZ9CrPInQimqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYuCEoEzcR/qhzHlia3eFVR0dLTljxPsdFi7pMHbulI=;
 b=NXF8xZ44uZWBhdtA+w9xbDb1NqX+tYJQ8UTuhstV8i9IkZwCbkstG1mEoxxlC0zU6LlNZpofUEIqI9NB/wkiBE/6c48myRN/UMPvsqqSygChP2R66yZf8BpRm8KtL+9nfZdoJh/SMUlF/EWHmhqtIEpcN+NOEwOAtmuRaG9RmM4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 04:46:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 04:46:42 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/4] mailbox/firmware: imx: support SCU channel type
Date:   Wed, 26 Feb 2020 12:40:39 +0800
Message-Id: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0135.apcprd06.prod.outlook.com
 (2603:1096:1:1f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0135.apcprd06.prod.outlook.com (2603:1096:1:1f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 04:46:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5bcb701-65da-4fe0-5670-08d7ba76e036
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:|AM0PR04MB4291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4291EA8842A5C82F0431F1D288EA0@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(6486002)(316002)(6512007)(9686003)(86362001)(8936002)(2906002)(36756003)(4326008)(8676002)(81156014)(5660300002)(15650500001)(81166006)(52116002)(478600001)(66946007)(956004)(2616005)(66476007)(66556008)(186003)(16526019)(6506007)(26005)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qm6ykU2db2A+oU9aVNE5D2R+G4HJCdn+NK5mOZtjINMRhUKySzogwAb883jDLpKa7td++ESOCx+hEyrvro9Y8kUD28CJFOxlkqOUnPTpzDoN0J2IB6T7nPd8PxHcmQkfzYlMAv2agEuiSreqS4+o8GXA1vGtqIrRLdc1y+hWjR8WqdbbawsLAhhAe8vGY+VvBsfQsvu0/zt+6r1i8V2vsDBrW/P124mOtrRkxn3tejdDhExf3K/H26pqiONLtY7kok1KAdklugPU7YW/FDgsjMabRzHKZVJUwkdz+S3T9EXssp/6wGwtjcTK/3Wk/CoINtSjdCWW6RXZ20sF/5+0cYmRJ1Imd+crQhXcPrzd4GF8SuBh2YZMpj5IDgq+MKOGiQDravqvYFROUVfJeOHiJzP+x00K/5ZgHYufs5uJVhFv8C+Ja3OF1L/c6V4Huwr5bwZNdw7UwI7UOTkwfG0La3B86DoQuNrpKdsosn5lOBtVv2eT0LIkt4RuXBQA33oDJevuIItw55kDDzAYL5/O+A==
X-MS-Exchange-AntiSpam-MessageData: H3ut792Myxe/hZ/DJkLGvIAb4w42PWyc1WM4DRUkuYNL2cjvZgyNsmCELcaJGmyBTKC6FMXTQIPhnZaviYgOMSt0WmRCRX7a0BQxjGKWafNgRHhJgJFmtXx5Lv3lpdPri85nPLJ0tbleTB1PC7Nr3A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bcb701-65da-4fe0-5670-08d7ba76e036
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 04:46:42.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjg+tDPdWSRsdGg09zgZKH4MSjVUPexmqG1ObnKSekoB2tOa7G3eWCuYfLNu2POfPNxcoogP0+ZdjQSkwsLNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

 It might need https://patchwork.kernel.org/patch/11395247/ to avoid
 build break.

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
 drivers/firmware/imx/imx-scu.c                     |  54 +++++--
 drivers/mailbox/imx-mailbox.c                      | 165 ++++++++++++++++-----
 3 files changed, 176 insertions(+), 45 deletions(-)


base-commit: 48b4bfe7105f646e270596bf9d22df0e8a4ae217
-- 
2.16.4

