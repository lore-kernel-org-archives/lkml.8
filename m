Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A683206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NpPFle5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHZGsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:48:54 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:8262
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgHZGsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbP4oYzUaq/2u5p93HdDVrs+Jk84uVpkCOB3soKgT3NvHAtUTGNkzBmKXuDsp3PQCPub29mXalL2mtt7ufrqz1xSsLyRM7JXlxy6GLF5vxMsHyod3v0ulZi9EP0xZ8e7Zc6g63hgK0RjGR+d9ZK2Y+xPfkgPmWOpiG2dyl8ZcXxlJDq7HyrpU5K5NBj/BclbK5siee0jIeCb5a5DaAc+4aup3xOwVCzTgA7Jo4VH8b5Y1PL61M1MviqXGxvWXcaPG1edtAmScLIiDGf4b23e0zn2d9Ir8XBUga/i7X/cAkb9mpmnE2oidLQwP1Wr+YFDJ2l59hrg16Dva5H7EVLsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXQH0txAvEyXEJl2HLsX0dWn+Clek8NkZo85gtqNy14=;
 b=Y6k/k3+g/UfhT72hwXYQxnClp7bJyI/LZKf0dT6kvvBrZiTdQ8RKjA2quknByaVM/+bUyZgbdoqJvvgbWuNNZT2zd85Nxx+NEsUXNFpwO5trfkHTNV4eSxfZXi5yCNF9LNrpHGKRLjn1DyBv6tTqAcV8ieO5w+DGFFaV73eDBitlIas+Py3qgnkE8nloRUUP2wWAgmhoY4u1TqmqosmLBWlssB0rYyPBTQS3drArr7TFrMgxHEUBtmSduooXwCQOLnjTFsZAWqMQ2WrOnpRwi8Kzg102tl9kB3MBUIWgobUDgpmS2Wuv/mYR96R95UdJGv4lxZT3Hdbz1X5J11J1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXQH0txAvEyXEJl2HLsX0dWn+Clek8NkZo85gtqNy14=;
 b=NpPFle5m+j7kiF/gG3ZLuYSsarlcflGqk/x+0wgsK+asX6+SJG5ubVGIbgaMLO/pJ0MNYkKGnI5GknsqeGRnkbmSVhUIpn4r1p4yhYuPd9FNRKBxNQ5svfQA0SKOiQPRWU4vA9EM88djta1PFxOdft/Uj3HAEesC5FS91rJqy+0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4092.eurprd04.prod.outlook.com (2603:10a6:5:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 06:48:48 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3305.026; Wed, 26 Aug
 2020 06:48:48 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        abel.vesa@nxp.com, Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: fix composite peripheral flags
Date:   Wed, 26 Aug 2020 15:14:07 +0800
Message-Id: <20200826071407.10543-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0157.apcprd01.prod.exchangelabs.com (2603:1096:4:28::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 06:48:44 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f22abe26-19e2-4602-c4ab-08d8498c1565
X-MS-TrafficTypeDiagnostic: DB7PR04MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB40926F8DF90290D6559F29D488540@DB7PR04MB4092.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFkG8tWYEucqUx9l3Kppy+wv+vDFV6NAbwKthorf3raYrxHf9ioHB0FAe2uhyQqgGCAZM7jPl2wjP1+KpVoVIYIEYoK3GCLWJcEwY9phhNLRahkDwaTwl97k31EbeQWKXiQ9C+u3BLv11bPkFem7S7aWcmpEaHpOiCa56FN5cQdNOJ+2ucOEpajsEPAwMWcBY/ha9rlmqarUh6iuK9ZbvcQ2BigtOyNKTWmhrp1XcqjNPf8DBUpdsl/pw80If6O9xay0fMldwx0TtpJkY5qaZKg6VUtVtWlBm7rWVzPBpADo4mNCl9Q3sooIElBXTZsNcJ4ZSmm5Liz2sa2qisXsIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(83380400001)(4326008)(6506007)(9686003)(6512007)(956004)(2616005)(186003)(16526019)(26005)(52116002)(478600001)(36756003)(8936002)(6486002)(2906002)(66556008)(1076003)(4744005)(66946007)(8676002)(86362001)(6666004)(316002)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yzULdGE59EDfb394uPFUIPV2bnb4/i4ztlA8jx1IIA3yRTThrI2igdaVtm6u6/FbW78+BGQYowDsDIbgCDtcQbjX9lznLPXJqeN9Ytx690Lj1aBW4Ks23M85vt3mNsSe137weUfrUyIL4okrz4Yz/vIY3rueOe3cyt+n4eP2MymEc5zAGc+vCM+fqo5LoTOcsH6XmQAsWLDA6L+MKZOG2ixSBOBr9qavIE845GqyLyKObs5xCgh6RhoFnXBuZ6gXNa4yVOic2UF0Tsx2+eyWTCUJWpN2WifASy0bHyFk21TPXKE6M/tAlsd8tTJulKbLOWSgoDwQ+L92BPJqWsAxRcL9rIjT42l+0nuAdKk3VxCTShn4ix8nuSSk4CkKGZ5QaNoTQ18behr1MVmmZ7HtiBshehklSvutWiznju6qDbTFxRzUB32UbBVnhGILdNHLGRhyhlVEyB74jEReTXN3OsriyDrbAtL/Lcalwv8myaelOo75FibdSOB2rDH1FA2SregpMvwrWEIvN1lLlAtF+P02jbcp2Lt05rGhDWTWUXqsoSm61p+ZUr7+reM8G0vBN1DlCi8CiTguyZziAUlRYJTK/IpX6M+payVJ8/+IWnSivTW841lQQI3Q+0bnngdJ7Oj/byqp6t+N0SEzUUwh0g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22abe26-19e2-4602-c4ab-08d8498c1565
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 06:48:47.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgal6Y6d32D2/4EsELrK72v2qlFxN8v9nocThF1rFEPjOhmsWXI+Jt8R4VEJCbsjC+/7HNSjRi6bGnr/NiY+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM, for peripheral clock slice,
"IP clock slices must be stopped to change the clock source.".

So we must have CLK_SET_PARENT_GATE flag to avoid glitch.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 78fb7e52a42a..2c309e3dc8e3 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -216,6 +216,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		div->width = PCG_PREDIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
 		mux_ops = &clk_mux_ops;
+		flags |= CLK_SET_PARENT_GATE;
 	}
 
 	div->lock = &imx_ccm_lock;
-- 
2.28.0

