Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E31C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483F020842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EXmTxOEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgETC70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:59:26 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:39045
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbgETC70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGnxiwfBFEJ20bgCa3X4VHMyxAc8zGFLXLMLs2RVUrQMobF0n/+6c14nwFrkubLE901U7wwmGIQVD0H2uBw8E318gVrn4b54metKzl1ZmwSDNmlLfmIve7MqD3O4RCak3ZkvCoQA0yggDwb4z58WJqTpJ5HSe7reMyNJiSnGt9A3YquKmwdjJCYzRYThL/B8SveQff6LFUsxpFVsoaIw+Af+az5mgqQiE7CldtOwc04vl/CVkS8E8Se5cPKVbNln1b4y44Ms5J9iH5ljgtT7ekWr9ZNB/s2HzJDQrt5OArOKo4JoDbMnv5Q9p2Ix4bU5SjJNlaZI+XoAWl8xKH4WPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwPV/c+mnU9Evz8xkGeS+nxXmRufqeVzSOhbU2ursvQ=;
 b=ZHy6GjKtA6YVL7CJOJRsvsq2FbFVJpyGZ5/9k4Li55AnjSD2WvvmkiPQmdO4KmUoDrZ09RRR91UcVG17DmX/YY0euxNvOg80PbNEDPLNoXu08qLAKIylzrBuMiVRk0OF9SG4DjVYqiMwvppdyOPx8dLcNvnuEkTbATYIl0GvkS47d704aqi0qqocyG2iPVUDcpAMW1E1BIIg9fKi/VNVFCS0Sz3lW4Kb+aEY3dPOgEtLjKxc9nR6g/azK44CubrEIE1A8zVpfQ6lp4YAnTtXXjL6uXvX/xn0rY4uzRAH56h4qw5+aPj08Yc3LDdZNl+eR+lCX7y4A/UCaESkM3XYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwPV/c+mnU9Evz8xkGeS+nxXmRufqeVzSOhbU2ursvQ=;
 b=EXmTxOEmUIzUwG7KdLXOSHUyr+nJwNLEWsycR1wO76j63enC3Nh5tLub/pLMKeK88CWaLHqlK4TzThRj5YMEGU5F+kuc01HXeLW/eccZT5W7o+OGlloBu4FdYNao44GlkI6gs/S7OQUnVFVzIIfSRcfBw6Tl51kqC3Nnjretx8s=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6634.eurprd04.prod.outlook.com (2603:10a6:10:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 02:59:21 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 02:59:21 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] perf/imx_ddr: Add system PMU support
Date:   Wed, 20 May 2020 10:56:16 +0800
Message-Id: <20200520025619.687-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:59:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebcbe17e-44f1-44e1-14e5-08d7fc69cb4d
X-MS-TrafficTypeDiagnostic: DB8PR04MB6634:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB663457A8FD6F3F2AEC6A65E3E6B60@DB8PR04MB6634.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1u+bUvKMd9SORe/DkIhxyodK4HhlcuQPvb2Z2uNaAo5/Z7itGy3UMuvZBUtEMxvyKRT90P88A1241QlfXfxMeYARUdbBHPvIgpHJz/NB6fFW9A5z/n8Rql8GolGJBHKBOg4+m81Z5v2hOFwrsqVyMnB56ZQmTIAd3912qqQtBV8rp4eXw2HUOi0eic5y/W7WkOLrB6ZdwQhy3ojOKA/yVduC/Am/LCgYtT71AjfjfFgJkC5tlMVwpEDDwAkdd4PxQYR/itrtd/6j2TmsoRnuaEs7McZTHLyx8TuByp520ui4imHbfqmUePx8oY31/jWTpB6cC7Y2bUbFctWELJ/9U8UbBu36a6JpD4yadZ1cY/y0ZWJGSAl2BuZVYYwcKBYTr6aEakQt7lSo3u+2p5izYpy0yGTfBeKxhg+oPJ3dqItB9R1coiaRhl89Nn2NBH0rX9FfH0PeDPK0iXkVO+HB1tnxCSn+HVMQaRVBbJejdNJ+2RqtXImv6CR7rarj5iKr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(8676002)(478600001)(2906002)(6486002)(956004)(4744005)(8936002)(2616005)(36756003)(6506007)(16526019)(5660300002)(66556008)(66476007)(4326008)(26005)(66946007)(1076003)(6512007)(316002)(86362001)(69590400007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 64CSBvKyDyJPydAO8Wd/3ufLi1aQ3bwxZ6hf3Kkn8bgCGYi9OcmU88fqr3VAcLl6Is9lPzDAkeyndSRbiU4YDl2v41pCHScyhoFngVydExn+L8KGoAHwCAmp2bHPMrplLM0NhUJCzUitfcc5wNvoS8/3jyp/tBKgNodlycOOam/iUuVk8ulVUDL3Jy+Vv0UuSNvF8RKw2VdtbA1REjg93oQsqv0yZdgUupGK753vAyd9CiZRaeKL+PX4SF4Ebx+nY0n9LKBMm4jwqAvpStkc26Yr4MwiZAUtAkBPizzO0nvhep+9vSQWu1VZxupof/eg8GtW671xaHP2XNuxuAz+l4y/fd522BLHv65mFrOBTCZQ0NI9bMNKPzehO1bnJZfj8Malbh8PskTpx4JOsy7xrdUxz8RLyWjetJPKU16chD08gIPF4NmGDbuX480ZnnbQUtLwr/bQEmQOK4xBtqINLq7urMQ/1PAI9DinMEcK5r8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcbe17e-44f1-44e1-14e5-08d7fc69cb4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:59:21.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tset2zCvP0/t1qqxFEq/673W/78HyOgzh3KyQ1zwFKZqnzDiUYjlS0POH6D2l6wPXpv9ThP2UCv4zgwJMwoDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set adds system PMU support for i.MX8 DDR Perf.

The sysfs location for userspace to get the PMU identifier under the
directory:
	/sys/bus/event_source/devices/<PMU DEVICE>/identifier

ChangeLogs:
V1 -> V2:
	*add property in dt instead of changing compatible string.

Joakim Zhang (3):
  bindings: perf: imx8_ddr: add identifier property
  perf/imx_ddr: Add system PMU identifier for userspace
  arm64: dts: imx8/8mm/8mn/8mq: add identifier for DDR perf

 .../devicetree/bindings/perf/fsl-imx-ddr.txt  |  3 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  1 +
 drivers/perf/fsl_imx8_ddr_perf.c              | 29 +++++++++++++++++++
 6 files changed, 36 insertions(+)

-- 
2.17.1

