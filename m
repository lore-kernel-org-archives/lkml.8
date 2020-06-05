Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A91F20814
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b/rKbnO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFECKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:10:34 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:31179
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgFECKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQZYvXjweuQjZvNzYFLg1vZyr4UP8r4xtoZFnHI6LT7SyT/sEvdSc74939rVhUta3D6kzuZToapLP8ooeUVlHkJIytTL4WyC0ehtEFniOjeQojnxaKdMHzt7vX8IJroxcuc5K/j/D3YkzlZ1v1dY0pA6f68RhjeR1sMxsgwek54sUvD3B4ML6LxkcF4mXFIy48hWW78EuM5ZsPMKau7/HGdwIypS+M3++ANaHo+qtYe75t40zxamW73Kz5ZKyVnKc+fLN0fuab0XfUJP3Zcd0llqHuK4COAKrFbQKmdN3HpiHLSS83Hnbb7wZW1PKgGcHLfVAZmK1G2AU9F3prnGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/hQy3gTaNgnhXCXllfbB8ZGToJ4h85FMaa5f8Qr8RE=;
 b=arzmTuoxuWOXh0AG8u8tSDhfrzmxjueWr/sQtGMmVUr/Bfc4FqKUHgEQHL4XxnBVaYVUL0BANRsFO1RtURtBy3yacco2sZT0VGmBKpYdgfq0ZcEgqwTpoZ7wBQXCytiRTiH50NuRHbMX+4lgdsxMzigQBnAZsgLmgwTNSEemz0aprEkwA4awebxhrs4NNvhMqTVpRAadC9tIl8+ABQbHlATB+riboUb+e7nqD2fgjKcWplNFoS4BEi3mcXwjgBqodFYO8lfZ4kARvncF3t+rL6dsStQ9lnO1O9X44dJgrnFPZPvW/GsaQ8vIl9cafnoS323jVWVz5+S3uzz5t6lbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/hQy3gTaNgnhXCXllfbB8ZGToJ4h85FMaa5f8Qr8RE=;
 b=b/rKbnO7os2aOMh8POBpC8+jkgXOUy50BsC9DxCc639FpBQzCE+IW8YaGJJ2fKzozz00xUMPpcsW3XG9xb5nUEdH22X/jsdSQarThIVurXTFSqXMG6Drc6gjgkBrWW5t2snj2DtZUNCVayyRW32LUylZjqTHSMO7UQO5MByqsYE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2696.eurprd04.prod.outlook.com (2603:10a6:4:a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 02:10:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 02:10:28 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        franck.lenormand@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/3] firmware: imx: fix/update cm4 and add resource check 
Date:   Fri,  5 Jun 2020 09:59:29 +0800
Message-Id: <1591322372-3793-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 02:10:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8995f4b1-60c7-408b-9f0c-08d808f59de5
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2696D75F48850A82D7A3103188860@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klcd5G1N9Hnt2Va5cYthIch31DmliLbvjzb60ETEDROvYEg5Ub35Vh+N69UroW/0x371bJKtdw8OBnnTCBaoBRodvnl/NlKQ+7U4iVLPRgG2qzzLy7+TbOB5C9ynd10Ol0FxcKN1J5PP42WSdaR9PKa4I90QK/W8xvL6NfYEIYDn/fgwqrCgv+93PqxpZ5O2tP2L0OLZJgPGsJnWp9EkFw/V4VIZW/okFJHoh6pyGOobmK853Vrx9YpsVD3LtaPl3+YUOQHx4Xa8GX5t5Z942EJhehiG+5JSejfU+mCzBw8rZk6zBAr6jwBTltyighJVj5ES5u8Jvalj96tzE1rtdUUawrL3ypvrdTSiSc8Jiwj65onDuvJuK9SSeVpTg+krood4EMmgi5Ysf57V/z+hroxJpF+AuTRD1JNigr7aqkUGa1jPcxxvWNDob1e1DKAdcEfi65K9hqQC8ldZ+4EmWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(83380400001)(6506007)(52116002)(478600001)(4743002)(66556008)(66946007)(8676002)(9686003)(66476007)(6512007)(8936002)(2906002)(4744005)(186003)(36756003)(2616005)(966005)(6486002)(956004)(4326008)(15650500001)(69590400007)(16526019)(26005)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pGbnuTCqjKXtHwv9D0RN1YaVU2b4Drj36CvZDBDJQN2TClNx+vAyx8qToXZbB1fg9oithWhBSwnL1miDJ0fYOhc2fGgN7zmkFwvgkmANG8udJlKeMFGplMfTv9gMR94Bx/1Y5mWOhfJgSv8+be329/bp409dGmonl9htdAeMtKHiCp0+Vy41NyZ6y6HzEdCQSLIrd9TyLhCBz5MzbwZiAp3W2Sfx0fnBtsUWtfTv3i9y5hLMUM2bH4REXY0qHWbx7WLkv7VX5LwjhwPLTAIFDvkfEDrMPnSoWLMSPAv2MTy5vcmMWx2jOWOGiSoGX/9vauPvuORpHwtJmmGkvXuTxfLNPuk1A3rnAMzLnIgVmco5jlv3VDFDvpN44yjRsDA987bWeBhTDb/m2lTbDoZWods2P/HurkWE2Y3eMcuaiiyhocjLEiTKGKCB0MtFiLUmqI022SChiOcMWrlcNW9pJb95LFTVT9avmAdSxT33BZs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8995f4b1-60c7-408b-9f0c-08d808f59de5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 02:10:28.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxQoTLl0GLQkn6nBoU0YQQGb/JsI5ClGS++D3dohD3gy2g6Piw5wN2tn50lvoiHlGhBXaqnqfflTVMt78kQQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Fix comments
 Add R-b tag

V2:
 Add R-b tag
 Drop patch 3/4 from V1
 Add comments and update Copyright for patch 2/3
 keep code consistency in Patch 3/3

V1:
 https://patchwork.kernel.org/cover/11505045/

Fix cm40 power domain, update to add more cm4 resources
Add resource owner check, to not register if not owned by Linux.

Peng Fan (3):
  firmware: imx: scu-pd: fix cm40 power domain
  firmware: imx: add resource management api
  firmware: imx: scu-pd: add more cm4 resources

 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/rm.c           | 45 ++++++++++++++++++++++++
 drivers/firmware/imx/scu-pd.c       | 14 ++++++--
 include/linux/firmware/imx/sci.h    |  1 +
 include/linux/firmware/imx/svc/rm.h | 69 +++++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 include/linux/firmware/imx/svc/rm.h

-- 
2.16.4

