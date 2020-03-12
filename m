Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB661C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD83B2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bo+yZQyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCLJYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:24:10 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:10534
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgCLJYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfQW/kTP0vVgac2xyJpDqiIOHGm0FXSQDuwJxSsx8cC6uxZ3GNjIVkLtf2T1TwfzfyPOE/CkVV5tsxEO6gIEBS1P58B1UBfuqZUHnXm489/6MRubuzEpSuBdoxjKsahxhg05pEEvr9qTIY2RuYO+oeReZ6qd89gPp+Ls9KVRwm1ePlIvvKPrgSzT4FZBRzMg63IdzpS9EKek93AmraBWEIoCQGVPovz2KpzdFFpgckorJCkpEgXuxCTLF6CzSY3rzNJCS5ZK7hH9gBbjTTa5/xWrV8zvI6Z8zNSTRv8NqzQT4Q28KzoCOB5auMsB9iEDglmIBAOi9jZKaOvk82w9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1vgNOYIEHm1GJnhcKpeTOncfmcQYdWgzXYLqnqvAKo=;
 b=Wn8/pfTGFK8j4EY2HNEMCPnGbhiVWY+tvWxPAiC9gZ0QmHZs9p1Kjs7FeUd5rABr88NWsfl+Bq8iuq7i9pDldiwGiVME21ulRavCiPcA94JmcV6i63cGp3GpLF8pkbYl4IH0ZuXgh3pC+o4RLSWa11o8dVQ+MI/luqoF0Vk5rlGoWbSWJb0VpAJ0OrrlDHAkCeN+EREhiov1YrTmPwin1HWZSNEeJcCbchizCu+oeQFLyMIXzLsxqAPtZ919uj1jX/CHeFDgjriBRqiy8wsgAaHI+/hiMIj/wNWhOT2EqXt//D/0ZmZ+aE1JzZ6AuRcC10AZdTXHOzCCmyo1xX3VyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1vgNOYIEHm1GJnhcKpeTOncfmcQYdWgzXYLqnqvAKo=;
 b=bo+yZQyM6Er0bk00TkObmTcEh+y6o8WMGoMbmIM/BghYsMikuYokHWI8zPCQGKU2tpFfNMv3calvsM3nskJ357sYeMrrdIoFoSOIkFfoc5jvP8fuUngDVlQ6w6ePgaXBuxGCQIgAGIgo0QR7iQePOk9Jd2UyZkyx5oRngxHaMGU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5042.eurprd04.prod.outlook.com (20.177.41.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:24:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:24:07 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V1 0/4] ARM: imx: move cpu code to drivers/soc/imx
Date:   Thu, 12 Mar 2020 17:17:21 +0800
Message-Id: <1584004645-26720-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:3:2::11) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:3:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 09:24:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 650cc49a-8ea6-42a8-9d13-08d7c6671d21
X-MS-TrafficTypeDiagnostic: AM0PR04MB5042:|AM0PR04MB5042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5042304AD21149713D065ABA88FD0@AM0PR04MB5042.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(316002)(52116002)(8676002)(8936002)(6506007)(36756003)(81166006)(81156014)(186003)(6666004)(9686003)(6486002)(16526019)(4326008)(66556008)(66476007)(26005)(7416002)(6512007)(956004)(5660300002)(966005)(86362001)(478600001)(2616005)(2906002)(66946007)(69590400007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5042;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGtd1c7ZOpPGUnwU6g3rjvWq3qagwROcKANC6od1SJLPnB/PZndh4IABUcRL/WH0GO+NvRRjN1b3fVOlDJtHa+mX+4Cjbbe0JKPNF0NRYANwXI4c6O0cAboxXZuH1rD6fdqqsNf5i8kKMr6NDWHPp+BIWX7OmgZwERlPlSU3X2YWsYRSifDjYPcz81aRiE6yrfQfUKfi2MLxSTROfa3PbbZBv3Cky2APdubGg7bsYs3DFcBPnyEvBqULYmuLDh6EAsr9hiUOC0Uj+VT9RRioMEm6ryiLNOqe/jeEzEChb32YLj+qOsFcmY1GeTQBXODhDgLanTrJT1cbwJGugnyAfTmWWC88VoCUErwjKjUuodVyL52VirNq73zxU0aVkR5ynRO3b6UyC1D+V2p5TuduX6ih9WEpFWdko34Yp60yme2g62vicrPEgFsyMI9XjcJWgzMgKNos8+imQx+eCOzpyoXQdFzlf/4qIpgqzL8cqgTqx3qXHjmqKejC//lKOv9ZWQ+BNBfg5o0ZScjBbAVP+yNXpXBA5pXe4uKgfjivJfym5nZr8D7ofrNnCbBXGtoKYWSzbsdKXdAUtwcy63yuWw==
X-MS-Exchange-AntiSpam-MessageData: GQa6UKM3F9mrD+AuaNBakh6bNDC12LffW+5IPQhn2wej0pfDfFgyXAxMSWac5xcmS5rP03L8v9C/Vl1PBnLf+UsQ03PzzcZI5ZBv8pcYJXo69OD8dNMdnOxdiN4p2bewMUvf6ZPS/N8y5dyQRVeVxQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650cc49a-8ea6-42a8-9d13-08d7c6671d21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:24:07.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WIlepKl4+/jRad5pcbBKtBotftHA3zUPMkKAkdsSyktD/JUTLe2yhrR6LAMn77SmwMEzQofuhf+4hRvVRVpbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

RFC version :
https://patchwork.kernel.org/cover/11336433/

Nothing changed in v1, just rename to formal patches

Shawn,
 The original concern has been eliminated in RFC discussion,
 so this patchset is ready to be in next.
Thanks.

Follow i.MX8, move the soc device register code to drivers/soc/imx
to simplify arch/arm/mach-imx/cpu.c

I planned to use similar logic as soc-imx8m.c to restructure soc-imx.c
and merged the two files into one. But not sure, so still keep
the logic in cpu.c.

There is one change is the platform devices are not under
/sys/devices/soc0 after patch 1/4. Actually ARM64 platform
devices are not under /sys/devices/soc0, such as i.MX8/8M.
So it should not hurt to let the platform devices under platform dir.

Peng Fan (4):
  ARM: imx: use device_initcall for imx_soc_device_init
  ARM: imx: cpu: drop dead code
  ARM: imx: move cpu definitions into a header
  soc: imx: move cpu code to drivers/soc/imx

 arch/arm/mach-imx/common.h       |   1 -
 arch/arm/mach-imx/cpu.c          | 159 ---------------------------------------
 arch/arm/mach-imx/mach-imx6q.c   |   8 +-
 arch/arm/mach-imx/mach-imx6sl.c  |   8 +-
 arch/arm/mach-imx/mach-imx6sx.c  |   8 +-
 arch/arm/mach-imx/mach-imx6ul.c  |   8 +-
 arch/arm/mach-imx/mach-imx7d.c   |   6 --
 arch/arm/mach-imx/mach-imx7ulp.c |   2 +-
 arch/arm/mach-imx/mxc.h          |  22 +-----
 drivers/soc/imx/Makefile         |   3 +
 drivers/soc/imx/soc-imx.c        | 146 +++++++++++++++++++++++++++++++++++
 include/soc/imx/cpu.h            |  30 ++++++++
 12 files changed, 185 insertions(+), 216 deletions(-)
 create mode 100644 drivers/soc/imx/soc-imx.c
 create mode 100644 include/soc/imx/cpu.h

-- 
2.16.4

