Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075A1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39B9215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9+2bdFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgCCHtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:49:10 -0500
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:6981
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbgCCHtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:49:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeRw+TytfRDyij420sGNVZE7G0OkXeu3FQL5flHVaX0wDkF81JSxentS/4AU8f/vt7Lla+Ghm9/iUcCWzsucUdskpvRLDV1/m6mK5ibooQfxcsC59OhCKuXSpJ953V6vNCW8rWc6hTjSQRgZFGel7vDumoH4rQALTNpFd4NZcG/nwhcIRY1XFaFgwfo8GWKZxGoG4rZj+clkj+hL1YsfEPm2vSBe6Xz5orp8hkjZ27JA2aIWVfVRmvoZ+Rz/R2k9mXabz5QFI8QY+KgK8Bpa+gewLBUEMCkdKWvpXwVcLboYox5l0mDhL/8+VH8lC3iddys46oFhVf8s0XMIrcoJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErN327zcqyfS+wrfBjeApFm5A/wQ5+cxB3M6KzJNV+4=;
 b=oUSg39LX8MtvpmHc/W9Fqo6wpv9rfL1nPD3xH/5vNqXdr3uQ4307gqotxk490WbAuD2o/gBNg/6BrP+p1DbJC6W9TGiycMBFIrcw5HxlzLXe/EMJeQajRECOskh7kguDURsupy49/YPqfh4YFv0eJSU8AKFcrhxtDJNdv4lVJj/ZnU9gONEXS/Ik0NWqZ19fQF1FUvjZNS2J4DY/+V/3RGekHD71+L3FSVE26mgiIQ95QqtNsWxkDLPVuLDRKtNAjslMYYL31bsnWSaBDMv+U0jJAjRUMRTJuP9GrMk0fJtg3TdEu/H+jv/8Z7h3nMzAm8u9kDO70IkJIhsOYkmVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErN327zcqyfS+wrfBjeApFm5A/wQ5+cxB3M6KzJNV+4=;
 b=V9+2bdFeRe4Ol/ekwsLXq394P5sxV5dizm3kO5FLdsqUSvUUDznxXalfuD1qOjSOfZbagWwjnYnQCkEkZ/t7TTsOydLsI3MEUf/lltaekhN46xxki+VMO4mHT914Hztm8azO7TofhE1KORK+QqKgA32gwF/HbtP3Qw/ls2RT3AE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (52.134.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 07:49:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 07:49:05 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/4] mailbox/firmware: imx: support SCU channel type
Date:   Tue,  3 Mar 2020 15:42:35 +0800
Message-Id: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 07:49:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d494492-ba52-4d22-7c90-08d7bf475902
X-MS-TrafficTypeDiagnostic: AM0PR04MB4114:|AM0PR04MB4114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4114BD14595BF3992EB10D3988E40@AM0PR04MB4114.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(8936002)(52116002)(9686003)(6486002)(5660300002)(6512007)(8676002)(66946007)(81166006)(66556008)(66476007)(81156014)(26005)(36756003)(6666004)(956004)(478600001)(86362001)(4326008)(2906002)(2616005)(316002)(16526019)(6506007)(186003)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4114;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q99RUJ1dThw4Qv6tdzdsKob9IrOuJ0m6kyAilk0l9WToZgaGHCVf1aDuN6WucHdfHkpC+J1JN5n/AMfEFQyXEU0oHdqXB+roJHoNTr7sHQ9zVX0rK20UFMVDKhwuXdneiTxt7UEFJcf64efN2jDfrylpWPTxmDhV/RGpeKUUyZnWg0tfAhcZ7dd5yKEWC+eoQbCobRi3gM5Xkvo8JrZl8fdn8tr7dhW5kW1nEg1xZEopPzYwEtjoU3F3qhDPAZ71nDtzvDUESuetMhvqJhUtcPdVkc/Bni/qMqgjo8BjdiJ+DbyFzv6R6DLxMgmAxEDoO2QdWEott4vL2Eg1he91UJpsuKWtM+aKOTHVnEcuAoms96MW/pqCrKdiGRpiL06o64CO4x5DAEKNXFGoIkoi5do6tvdZ5uXIam1BQBP/lm3Bb6apJVw8nFirfv5qvVdX
X-MS-Exchange-AntiSpam-MessageData: O8f7mdQWAZX0zQNufOLxAx9zPJ6x0pyCjtMdd+ypy7RZYLR9bjostJ5ttVvHWVQLPxRDoO2oLTnHd1lVUDzDOHMG4bdD16a2YH0TPQZKm3oEY6DrXiCVYqJKpHjAuM0ZNlXxU8b5up2LBhwXWAlOxQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d494492-ba52-4d22-7c90-08d7bf475902
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 07:49:05.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiQXu6THzoIhIWi60IjKOl7DZaAcK2RV4SKbTqMP/qu/usm6AfN9P+oNmCHqAlQqTuyoYjm3iVnzmKUhkEJ75Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

