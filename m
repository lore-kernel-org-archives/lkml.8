Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C15A2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nZDn5WqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgETGBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:01:25 -0400
Received: from mail-db8eur05on2043.outbound.protection.outlook.com ([40.107.20.43]:29665
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgETGBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILq5aEkY67AK5ACMr8VmsO9L2mRIYtLzo0AJyX77IoLoJ7OzBhp9AF9DdmqcPPrjm5VGDl1SZkAdZVi8iyvm3s/+6P13nRcCVoeEfoTS3TTkkwlE35emanlPBtwvMzSlM0A/wamJJU7ywHLqO9ovwihwY1kr02uACKDBMLEeIfAu8U7MFsViIEQ42Isu2ulqje606pWTBSrlk6FTn9hw9Nm4Hno7xZv7F/gw5y10PJMybQWqBai/L/EDPhRH+1lWtoGcwlcQvXY4Dkxr16dwhw619OtjC+mfcGNCJGYMBQ6nhjB1PNPy9gghELKGTdg7HnAM5hyuv4nbo0AO60T3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pziITDQvwrvyKHtLnKFlbCGb7/VBRcRhm8W4JqkTpk=;
 b=V84T1cZd/W1bGlTfSEWfeLH849nZNtNppgZahZa/VF4uBKkyU2WL0go93IfDWdd3RZOABSI+f1SF1HyT/EjHvMG0oNokBrfhIsvhtFZfn59cBglrjICsbhS+tgmeWEzbiJRMt7EqCv69LMryUfbbfdXs0yDnpwSfKsDeL4d+BkZf7+rre89WDOrIsa05eFeXsvV5ABXv/8jZbXbGYK0CFaoY0uL0D9tLmYa/Hi/IeswcSaF4oevn+6F8VyX0gZl2H1dqgShHj8BitfHJr4aJBcUAXEWJSqEaSQybRYwUK48SRNT7fwfutvT66BVlI8IieU+1ihmxsjrRTENRFuUQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pziITDQvwrvyKHtLnKFlbCGb7/VBRcRhm8W4JqkTpk=;
 b=nZDn5WqK5I9LVJiwsnliw6nrWZ1f1Rf7+fgRmK8gbe48bGHKWiPpJ3Dx0QUtxwZTfOUn2+vqwjHC+GY/chWs33tAP5qDiS5SJNqDIaaOApskXf+sT0xd7OLurwPpsI28/fhlLdhsiqbNraxwUKr5BmBwjQP+L9NGer7ppTqHhy4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2790.eurprd04.prod.outlook.com (2603:10a6:4:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 06:01:21 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 06:01:21 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        allison@lohutok.net, info@metux.net, Anson.Huang@nxp.com,
        leonard.crestez@nxp.com, git@andred.net, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, cphealy@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/3] ARM: imx: move cpu code to drivers/soc/imx
Date:   Wed, 20 May 2020 13:51:26 +0800
Message-Id: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:3:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3000.31 via Frontend Transport; Wed, 20 May 2020 06:01:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d579ff5-6ccf-4166-84c5-08d7fc83382e
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2790186BE4030DA7FD3B856288B60@DB6PR0402MB2790.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FflA5pYAgLtfPqUlyXbWDzTwPK0PlVvQ8iNEm80U/xzHxJ1q84n3m7CPT0FG5KpLgznPjzmbuYst0I0gmCRN5llz8d1nai0lAUSzmJ+Oe6d96dj8hi/Etv5O/gqG7b8oOOoiFAUgyETlyAL2KdJyN+9R+j5iXqdLmCxt00hu4jAITn35hrCLVodv0n2YxENbUYX8jgpyQ8sKbDxLmKeFh2DvpR9cJhbvSRsmhOlPmm+24O02hEer7/bdP9u4nYiGkgCTJLBuIusGL+6rTbs3l9dRiPE12ex/WDr4pvlpGq9C+ykifNNZO6vpIZ+OjmxQV98+N7DBX9gE7Wzt0notOjFwBiyn2O1UbGvq5X2cZnvqKXCWDj+P08X1E6OiXdcfWIO9CT8Ztm/FOZNNvfJQdEh436x55P0st8ubBHMCZSOvs4cAZbQOkzkbo0Wdj774+vAWngxjZVYog6hXFRl5rVLhK7wXOBatHDPP6QhvhlntFpB2xItiQzp/FgX3feRNJLV1s8W1aryE5EyQ3JjWweFeQwJhcOB6PKl7phI4sosN5K411gzYrIOiyMkqvzTPj8Xeuodl0pZpBfZBhqLqrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(7416002)(2906002)(16526019)(186003)(66556008)(6486002)(86362001)(956004)(66476007)(2616005)(66946007)(69590400007)(6666004)(316002)(26005)(5660300002)(4326008)(966005)(8676002)(6512007)(478600001)(9686003)(36756003)(52116002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G9mR2SAcqKtG0lEtT8MManaEGTk00IbGnDTdBmDCllQbCpx8nsgNjJ7umoIg7vzBeFN2raCdPwuTUN3e7CQpZh0QHgJZ4lfMhutJRIFuzaipyHFGTVXbbkDFcB7lRkxJIDdgJKBG1MHg5myyQjgaI5G5bzCPPBm+2JZzwZtWudSnVdyuFxHXx1uQ0lRk+BB2XI7IC7z0ZsWMXBiDUMvRDaAT2ChFIAcWT4ug+Yum6Xu3obof4Sj2iyNP0uHa9Ia2/I4Kf9jczSxbyiz1kp8sFZONm04xQufUFMi+bAGxS0pBMs4yLOlUDat0pofWbl6HJKu/tPkorgFXxhxSrCKyuj2cTXaF/lmjsm/eAZCdyLrm9/0YTGWsUQaw0Xqu6Gzbn26fjwrXAyhLpFEk1uW4YB69Idn7yRKTLzxXetl1wQYyNofzfqyNQdqI2rNsa18vFHVjKM2y8Sgs0OpWwvbaOr/LvdsfdW2we1tew8gRUxi9n7KebJ7WmtWs5FlqJsLx
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d579ff5-6ccf-4166-84c5-08d7fc83382e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 06:01:21.3750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD0HFwofWK2W1riL4GcdqS9zACsEwH5hggMCP/anKOytV9AAtgHXLY6qXu6uP0V0UYxgnt7yQrBuhw2aWyssFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Rebased to latest next tree
 Resolved the conflicts with vf610 soc patch

V2:
 Keep i.MX1/2/3/5 cpu type for completness
 Correct return value in patch 1/3
 use CONFIG_ARM to guard compile soc-imx.c in patch 3/3

V1:
https://patchwork.kernel.org/cover/11433689/
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

Peng Fan (3):
  ARM: imx: use device_initcall for imx_soc_device_init
  ARM: imx: move cpu definitions into a header
  soc: imx: move cpu code to drivers/soc/imx

 arch/arm/mach-imx/common.h       |   1 -
 arch/arm/mach-imx/cpu.c          | 175 -----------------------------------
 arch/arm/mach-imx/mach-imx6q.c   |   8 +-
 arch/arm/mach-imx/mach-imx6sl.c  |   8 +-
 arch/arm/mach-imx/mach-imx6sx.c  |   8 +-
 arch/arm/mach-imx/mach-imx6ul.c  |   8 +-
 arch/arm/mach-imx/mach-imx7d.c   |   6 --
 arch/arm/mach-imx/mach-imx7ulp.c |   2 +-
 arch/arm/mach-imx/mach-vf610.c   |   8 +-
 arch/arm/mach-imx/mxc.h          |  28 +-----
 drivers/soc/imx/Makefile         |   3 +
 drivers/soc/imx/soc-imx.c        | 192 +++++++++++++++++++++++++++++++++++++++
 include/soc/imx/cpu.h            |  36 ++++++++
 13 files changed, 238 insertions(+), 245 deletions(-)
 create mode 100644 drivers/soc/imx/soc-imx.c
 create mode 100644 include/soc/imx/cpu.h

-- 
2.16.4

