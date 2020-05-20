Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E97EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6879E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oda3Cbz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgETCMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:12:49 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:64784
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgETCMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHP+QgUnBUgd0fCW+FCwLEggkIQxzJoXkRHDpdUpFepR6oF3lZLd5qkTMJIwNNzbWdQM8KyfP6y67eIBR322LEIvl4mJbIdfTGWMpnshsFPzDMDVg4JvfnlgNWpAfrDCT9kXsFBFUlPJOOsowSt+bs6Amst6itsZA12+V0HYRggfgl/RaXgnOoBXDHRjZX8VeXa68cL7uT3R8zMZ0SmaRHT6S1/WZqztNNRi8E/9QT9ELwFMTnis/AWkXboCjGeNXWfAVsutYt2CVAH4PE0Z+xQ7BffmibTn+3UKJTbNUklKPnN20mvazLUlL1SbFtI9KJCdIrzaf5Uez7Y4VYsbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAAra8S4FKHaL/AAldt7Es2pBNQVdQptevoLOkzkfXI=;
 b=hTf8JB99UI4dgOqh9o2aX9UyVpddB+PVmGBs3pHMxHjLk8uiRPB0tkU+QPc2+CpnvBEUCYfzBbEela+v2SiEvIXLSP7ubr0j6mbuDyl87Pbuvs9yx9bOF1vwFB6ffN+mk5tVlADckXjElGTvSHrcW4Hmj4ImoWPa7CzQklrf1f9rXYRQkRPEHcCFxTWTShjOfXxwaSPwN+slyJvp8QlQ/T6uxX3QpkEkz00m64RFyY+ySLYhjN0kz1fQU/mnKU71lZTO3fK9jkZEDOnPFhEjF877beVo6Ku+Nvje/ZpurgdZNe9gZyUuEhvRb6JnQCKoDOsCx5e86LbwkH68ppgahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAAra8S4FKHaL/AAldt7Es2pBNQVdQptevoLOkzkfXI=;
 b=Oda3Cbz2znat+3Z/ubovKFvdKW0vbdJKjzkqJ2e0TKfjUkBgAylhWwUeT6c8tPKDj4Mtpi8aAK1ce0HCBajhi1d/y6fnI9MivuVmJKNamjBTCym0E+cpuvb8iUyaBusnoKx85/ctEl5v+Aj+w6fVpDC6QCjX5ABczzb5E5m8bos=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2741.eurprd04.prod.outlook.com (2603:10a6:4:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 02:12:45 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:12:45 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] arm64: dts: imx8mq: Add mmc aliases
Date:   Wed, 20 May 2020 10:02:43 +0800
Message-Id: <1589940166-736-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
References: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0099.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0099.apcprd01.prod.exchangelabs.com (2603:1096:3:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:12:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 521d3605-8f0f-42c5-1552-08d7fc6348bd
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2741DB0F8D05B46C654C420288B60@DB6PR0402MB2741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezTgVupTii1gju/HL4qIiKcdI4aOmxwT1pjaMrLB/0VMboLscZimWpb0YcJuI5hwQQks7LCQVQ4s2kZ69stStsM539adqs6VxXFvLHeTXiyfJ3fs/Bqkw0iUGnPrt4XWCowxfgxDN4LOrF9MGUrDoc2hTLW5h9BmCjiPds+3ue8/D/Jzh3WBQfQ9HaQTgo3M2c9tJbbghcyzlIedHtdgYPVsNp9UZbviJXEZuudRF/hMMqz+eH1rNB/ZiT6zGpqMjxN0sTa/gRRu7FJesA/6Ncpiw5u3Y/YIUA3lBwOYiK1hQdAIMnb6cD1c4tuoqnSiV4IHXpBCxrN5b8FKFbFqgFwgrqgNjHQOHj+gbbmRjpDZJ3SnTNqWwqoCnmRmFH1lOvMqu5H3hT4p7kVXB4+ekq94jJ/BS1EhjVFOrA+JhLIgUjfQvNNNAhedrNIlafzRp7OSarLyQ/KUVp4esLS6qBySCB9w8Q2JmjbE6UtGFuLOtOqUtY3h59QCkzRpWQlLMHtg9IvBU3AeESoKtHz2RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(36756003)(8676002)(6512007)(86362001)(52116002)(9686003)(66946007)(66556008)(66476007)(8936002)(478600001)(316002)(5660300002)(4744005)(26005)(6486002)(69590400007)(6506007)(4326008)(2616005)(956004)(2906002)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P2cACLOXvcWSjCi1VZ4AE9oAQ57KJ7r407vfZ3A7Ij01E9zqai5/63mXe+hoIRdAy31XLFD6EMk3oJB9UPQsG3KAoDk/gYv7QMQNVSXSeQw1PtU+CYlrhiM+wmgWLpfaVOB6Giq0ZQQfuVuGM4d6JhOKCfQRYX8lItEpiV1NrA5WtW2l3k53pVMw6fqMA6gIckn9q6HhwoDjg2Fi6Si34T8MBQkDclU6NR07rvqaNvy6cQPxSkUDoveAWKqPWlZWyNjwAIsp5SaED93D/WcqJQnPdPNt6Bx5hYtXE2HjRZqGLSoNi/BRlYh5nUCQ4YqPRigaruTzpaPZ+iIhPWxkOkuLqbtu2Io90RVMD3LTC6YFxq5F/IolxdSzHCLkf1ln+wRBNviVVhYkMSzvmt3lalPF9XvduvKP4LmdrQFa8HCircrzERsURFmCdan6guTleRqzclKc+Dxi5gQNXFbNg0Ts9wDvDSAE8ayQ7lCAGAR3rMYqJBb6c2d4GWLs6nd8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d3605-8f0f-42c5-1552-08d7fc6348bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:12:45.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3X7Uv3kvug+Zyt7EWLVHHm1u5DLD/qHjPe0VEeRlYmfD7gvzUPWkEH95hLvd+Fsga/XDveMsl5CCSXb8Xv+JTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mmc aliases for kernel usage

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index bab88369be1b..9d3c9693d713 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -29,6 +29,8 @@
 		i2c1 = &i2c2;
 		i2c2 = &i2c3;
 		i2c3 = &i2c4;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
-- 
2.16.4

