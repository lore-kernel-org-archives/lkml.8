Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7696EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE562074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IuHkb+cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgFAIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:30:33 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:40929
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbgFAIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:30:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et/CgP0vvit/4K5QHC7a3kVtWo89l+bhl3P+Cd+EujRbYcTMC0pytnSjgvgz+R4BpqNKWdVzRMKXO+jnlXlixQypdHTjZP7Jux8XR3ROR+Mzhbjf3XvI5TXv7gOnjfjLqmfiM2xj/gMMP++JGflg5xDtopQly14sYz/WmlzezCewITdrS8y6PBoY+RPafR/4Wy48IEZsxL3f8qEzTjOQezlvqfQHZ5S3bnvHoXl3Ebn1ONKzOSPfgw/s78CRU0bttCLH7+3UCFyXg2YmbSxaaltEu7Y3mGzpXXj1KTmWKltCwi15xDNIBeoUehUAD1DiJpgJlgu6HsAd/daumG8i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXjcUUfJ7czmbLLXnms0PX5EcniiddCa/TUREnIW68=;
 b=R1qfnUT2gKmCS3EcQEbSPS/jK9/F8SvPQDllQ2smf10buGpN/Ft10WBYp43BOhDk5Fu5dC/txtpdzqVtu0/cpXJTNCZME5NyihHtgPu7v37cT4meSHAjEAsPCpa61MjlBDublOTHx7ZBWDR7ol7F7dAS9jnQyOD5k66IlxU+vbW//DJ27IQqr5YQ7YFVAJFDSN/J5g4LEFGhOCEJopwWsKIgcYm7Bu2l2+ofL+PIbd0MNgEE6m7rd5ol10U3vI1uTlqJ2ZKnwz1VMQGvyqP06E6uXRR+rw46PocHMR+2SYdhWYavGyT+A+tMtrpot7/EPd14pJBnQf8neYE3fRwKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXjcUUfJ7czmbLLXnms0PX5EcniiddCa/TUREnIW68=;
 b=IuHkb+cC+l+VY5MvJgtegrkb2lgFDOXPhb8EByr7R0xz0WMayHViVRhuA1FSyyWrS3ZqHl78YTeX8cv4D99+bjyM3v+iWcTHF2ySzxvhZQxBcMFTEa8MOwxq541SOntJeMg8ttTZgbvMDe07nHtX6pDM/wcVydGrzh3RhdoBYO0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2728.eurprd04.prod.outlook.com (2603:10a6:4:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Mon, 1 Jun
 2020 08:30:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 08:30:28 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de, jaswinder.singh@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/3] imx8m: add mu support
Date:   Mon,  1 Jun 2020 16:19:59 +0800
Message-Id: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0044.apcprd02.prod.outlook.com (2603:1096:3:18::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.27 via Frontend Transport; Mon, 1 Jun 2020 08:30:23 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64103976-5a14-4568-d09a-08d806060a3b
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27281A9EC82B2956A2EB7107888A0@DB6PR0402MB2728.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zq8eK4p+9mcbCSqKbyukUgXwlAy+pA37qJOTNhajh4I+gIOOblCxhYzPjDwT2LYmOvW89LO/KrTFrh6pLjahwbjl7XApyf9H+WbwLVpqLEiyvChxY3VPUPvLumTwzFS1u3+KoqBrbQUIEkWfvD2jqMb98eKgwAoIgVnxCgCjPj/TkHKwGX3jvTyLkyOMglJqL6iqRjpw7aSjmYvk0NMwdzIxXb+VsUwOG+CSGg41Ig0wf9cRMDuNjq4/AKzThpEyTCdQ5xZ+xNQuyaOMayDez0jaelO6vx0Xhj8nvdVcKeYOLO/PzMvRN1p/iRrx0XXbECoapJ3Hq9rIPk23UohgPUoW5ZDAG+8jat59PcOzKbC8UUpaFszc44dreqOdy9zeKhRhY0Mchh/wjyAVGUXnRfbP1pAKvddWO0ZuhdBqV8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(316002)(36756003)(6486002)(6666004)(478600001)(86362001)(8676002)(4326008)(2906002)(83380400001)(69590400007)(66556008)(26005)(2616005)(6512007)(66476007)(4744005)(8936002)(956004)(16526019)(5660300002)(66946007)(52116002)(9686003)(7416002)(6506007)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eO/K6wXSTfXHPvniGCbIGenGB3+ZITVGImdhg+k8TMYvmqLjC9QBH89LCCOYBmiZ0NahVLaFFZiWJrIWbaIKEwET2n0Lbh8ieW2wXm7DkTxUpamKG1swSe1/m+osD3IqyvOyYo1O++ESEYinBlWE6kj0NJdh7as+U5EBSBRKJaZD5U5cQoyFf7GiUvPQ7JbAah5u4Cbdnd41J+NzB8kBN78aPbDLzs8LqWLX4zuUfWkzXDUhUo3CC2XcCABOg9Pk+OOTxpecXhsbdWlAZoTb6bxoz+5ibwuYGH10dshgaSUHr+sIwe9pwuGqUKvXywONf/tLQJl9IuivvFIBoPNnc4K010Jcfo6pY7PiGcCM3168rV8C7P+ADdlxUsRTqJ0CyZydgv3FA2Utt0zuBdxUVGhbKdxEgyZZJu1EIhKiHOrGCrsC/zl075Quwr5gqtFokqsTla+ajxoZgtfjbARQjSdLb8ilT8qtSCYofRgxkgHKUYziC4hzudzUhxPXM19G
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64103976-5a14-4568-d09a-08d806060a3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 08:30:28.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmfKmEJqcvS95mg3ZirauY+n5j5ZD8uZ5ZI7mGZ31/rpa1IB6RicX66awuyg5TcgY+3E/MhAwdUIscDDcL7cUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Add R-b tag
 Remove undocumented property

V2:
 Add dt-bindings
 Merge dts changes into one patch, since all is to add mu node

Add mu dt bindings
Add mu node
Add i.MX8MP mu root clk

Peng Fan (3):
  dt-bindings: mailbox: imx-mu: support i.MX8M
  arm64: dts: imx8m: add mu node
  clk: imx8mp: add mu root clk

 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi            | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi            | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi            | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi            | 8 ++++++++
 drivers/clk/imx/clk-imx8mp.c                         | 1 +
 6 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.16.4

