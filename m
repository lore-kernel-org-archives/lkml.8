Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A054C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5EF21775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WetFEqyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGTJGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:06:40 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:23200
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728194AbgGTJGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPDI0A1iDC2HZ6Q3FS84rCTrlsfX6jyJ8h9w3e/6TVgn+FemBiSsn/8pcvwLYOBKCzvd7dL07OwaT6I31u7HODPqLKFg8S6LQ3865coLzydJgN1cYdTI812X881aNyfbw3krYIjQjSa37GoE3n0Ze+d86Paw75hfoIPbUJSATvZjRDAzjkaF88SexOTrDL0kpWDFXBWCQUygCqjLgY9z1ThQkgLxZdcCgVK1GGFEvjNy+3p2qJ1p5ob1gNiYRH7MJL7hMIHLx/uUv36i7k1FtHx+xVTxAg7lFAZZhwY0+c1M/O7umuTgK1D5UwtL/+HVVOOkx9F87ezOsTLK/WUkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uteGmeVdh6mwbpu9EYw+XDYU2Cv6F6tTCTsYliI4J9c=;
 b=KgWBCETE3T/7wzqo+MG9W8x+SS5km8+U76xHdeh8MZShwsluIkaHlLJahZRxoWGjT2e5te/PWwgREvvFp8Y4cVw/T5lUbmSgy5Ep/pzJKI6rRoh+nx7oQKp6GM4wwT41xfC/hFOsC/JJiCouSC7mkYvYa9IYCIgRpZJgkmd24g07ZGA75oR+qAZfHS8N5obbzKeByQmhiU1yhSnHb/2u3gAFY3RoDwJAALy9Ceuj9B2jmYBI9B9y8BldBc+zVql4fH2rmYOjb544wWFhT8SEjOknhuPqjYZrzEznmk75YMH8UW84y353LIlnwe4z6YI1peHQ7k8jw4+Pdg1IckMxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uteGmeVdh6mwbpu9EYw+XDYU2Cv6F6tTCTsYliI4J9c=;
 b=WetFEqyNdpJUNv/eIqldqgAnWXaTh90iwwYC5wYoaTzBeEPjhSO5ZbWTwCXjOOjnkMsNzKR/V3VY9K3OWXMp0emYos92GaazjuMr/yF0XoSDbgtJ8HijHeDQkp1K0SWw5XsnOCcJhVZ1YmK6ddl3OvWEPicUahuWa98Jpdo61gw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR0402MB3762.eurprd04.prod.outlook.com
 (2603:10a6:208:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 09:06:24 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:06:24 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH 5/7] dt-bindings: firmware: imx-scu: Add SECVIO resource
Date:   Mon, 20 Jul 2020 11:06:15 +0200
Message-Id: <1595235977-106241-6-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1595235977-106241-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 09:06:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 351b431d-64f6-421d-b296-08d82c8c2d94
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3762A842D91603496DE1C8F9D37B0@AM0PR0402MB3762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNVNYfAY0vfj3fvQKo4MStlxebMpvoKU9fexi9ieWoy8aT10DNPEGknsh/O1lQsbprw2r95SfJYwrlMzsME0C7XuEfVEKXS2BhtdAx6A6TqYT3BrGDlDokgJ0wwdQyiRQGTmS747s9UCPQMqoVAuTyJ90cU1dFrPZLI2UiKDoVq2WrpD2JRkPgirCWs0HqqqLbjPEu2aIHE4qwo6yp9eFeiHCZh69UojNw477ysUfEzuttRkJNh7hOgl8AL+YCSSIzfuMWjZSgVhigXoxMP9JgJNZzF7O3472qp+dkSFtgIMELL+zZlI33mN07JI1a5fyQvNKcCf+LG0ns1rys3zhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(6512007)(316002)(66476007)(66946007)(66556008)(2906002)(6666004)(9686003)(8676002)(8936002)(86362001)(83380400001)(5660300002)(26005)(186003)(16526019)(2616005)(6506007)(956004)(6486002)(478600001)(52116002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6bnvE/Ka6KLLmC0b3FSE8YtNXmPPQQsZoGr9/J5EOUFvn9mxJkrqpsqB9wPOKtOw7h0TqvMb/iY1jCceHkJ3kiCPoGX9j3fbKqBI3eV+Xy3VXJbBe4tOgubVmCraJQmlmEyrcpJOvTYR4ETfovSqjlqs4ShOlqNJTpNuFk4ljehodnXEph4+jeGNw8COR6s3mIwr3PFVoWfIizImUMi/Xt504l7XA+Fh+n8wwyJlG9lkytpez9DXGHW1wDM4arfR408PE24GklBpFsDTNPQoFUbjPo/RrZX8ZlbS9NDezi/wpe+0p/kejzYRFQAtOIiyxYxk+NzpwKPIsXEwI0E4edI2KzJDMJsTxcHbTybXFDHK5zfpH3bmoWRpDG8PbUn05L1Mem1QxY4QBCjYpwtshckw7kKrNd8bPvVdbC8nqy3HuXb4oYZmm11bgLggrMgiS3XdgMODylxzAuWmbMS+4tzWAcOgsESVrPcHN8d/Ct0=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351b431d-64f6-421d-b296-08d82c8c2d94
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:06:24.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmAc0zJHY8nsWpJMb0CtsaAABUrbs62eMAwYDvTh7x+etCaMlTIsYIQJawMyO/riDOhBjAUeviwGmVneJoNBRtMuCcYWkN8U6Y1rrDLAi5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

The SNVS can trigger interruption when detecting a SECurity
VIOlation.
This patch adds the definition of the resource.

Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 54278d5..fe5f25f 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2018, 2020 NXP
  */
 
 #ifndef __DT_BINDINGS_RSCRC_IMX_H
@@ -50,6 +50,7 @@
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-- 
2.7.4

