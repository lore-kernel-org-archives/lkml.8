Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5220829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LkYVd88x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgETCM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:12:57 -0400
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:57970
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgETCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhprzgciV98nkhH0zRklYdm6sJlFy5/t38bAjLhwNf1yt1C0K/uQoEnn+WaLTuc+8Qt8hA+LXQqIs+NUZ+SmkUfpaVF6QeeNC6AWux3/X7Qjj2baspi74c5WOqSz0mH/VCctULoTGs7H6YfooE/xMW3YyWQCVrvJh5Zgz4p9uZ68nM6aaxXxVARDURkQUszi5dcxxjKjr7F5L5arJj/QCLsReEAxgQ7G3k4agT3mV3GfS1JX4qKJDUXrTfH7AatyCxX9tZdRC7oYpq6cX53z5PiHc9Si4AV/P5fxzfbhTItvizUfdWiM6WQgbq4Cm4IaFkMrIHYv7H+Rg4kjKFVgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJFFS2IVhMlWgz9jLEX8t2Cy1f8qrHNc3gaT3zLTFqY=;
 b=DfjSGBlEdLFoWwNwAqjva8NIqmn3gxiHtXpiEGj0MBm3kFOnGJZZ6NwXsPKso4MpHAfeJAubT1hp98AHeIC2NBhMDh/MB8eQyGaj7QUh7xZvtVTqDb6yTqOf/rl21ok83mx3hs+BWZKjJg6UNrEVUPnyMEDIp1xywf3XV0j123Fqauqy9g3mR8jdFsWWxa+nDpOkQynu+jPi5mapTVmfyKAVP52uwB7wbtSNlCWyaJU0kTzF6uOinR1gKspxVEOavWjyWYU84gj7Wb2lkfTgrx9S2QVXv/pfSdl9fIXMQs4gclIo5DpqD8AL2SFrl2VPcB4iEByqOThkJvjbHQzGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJFFS2IVhMlWgz9jLEX8t2Cy1f8qrHNc3gaT3zLTFqY=;
 b=LkYVd88xR3kxhb8yWLn+E28vhHKVh6SNQN05Gea92X4supq5tyWH2Q66/pJL43Yp43U1zY7MeAsfK6m7sAfgPoRKUvysg3JKPprRE8ya8e8XZTgAH1CNUfEH99MblYLWu1xTME9sQJYlt9ZNkLEvEcKScTBChDYOdD22bdJPrcg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2741.eurprd04.prod.outlook.com (2603:10a6:4:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 02:12:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:12:53 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] arm64: dts: imx8mq: Add ethernet alias
Date:   Wed, 20 May 2020 10:02:44 +0800
Message-Id: <1589940166-736-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
References: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0099.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0099.apcprd01.prod.exchangelabs.com (2603:1096:3:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:12:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9809b93-49f9-4d95-ecbc-08d7fc634d5c
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB274129EBC3F3A9E7409EDFC988B60@DB6PR0402MB2741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHAUgZVQuEvmush2zJJumy7XpLCuv/qoSwU36AjnMqfch4pwKXglAdKzEULGKIvTtMZ5rvUMiKG1dziB2uOs3ftzQZyuVwVeQuUXpQMwnN9JN/2o6fITNhUZIoa4Q0xq6HORKftTW+hYs8rtvMaESbXUlNFJ98H1JMmSWeRohVCtFl2w08C1DjiGAwNtCnjhtgRZwOccpBmeKsBo7ilWl+eBoORSNgXtPa8vWto3AcA5dwsAgpw2BGELr6NfeyZVEQuN1HU7ouHmDT+XQZI2TP+wUvki8AE3zsB2ImMwwkoM/H3uawlmoNdIKjt0ba0UFjJkn3t/49EfrbneshSRHpwc14zugBdTKP1BmqnhR2Zo9bLPMQDpfKjK1XNrsIhpFovDwtOCtJD1IGxkG8LzNHOHr0DJA6iLRoufrAmZ1T9haOVkvSobO1N4szkRQGvZIq1f4IQ0tNnpEmVV75/h/Zt+Jpz8M4E7sbABr0FFksWwCqidn3mTAdnCsN32PduYnaboGt64P6S7wqnYi677DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(36756003)(8676002)(6512007)(86362001)(52116002)(9686003)(66946007)(66556008)(66476007)(8936002)(478600001)(316002)(5660300002)(4744005)(26005)(6486002)(69590400007)(6506007)(4326008)(2616005)(956004)(2906002)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wwQLg9wJZcPx8S4CpWulqa1VmU4VcMLPfkZTd+XPTwexmTNSdhvv5xcbAFRbUTMByh++DMljZXPWbEaO6rRPjyFYeSWRZGVUbpbpeFt8Z3tgpk8SSoHlMk1dhUMN3FIWD6AzzDLkqZXAAvYWeODP0c6zmMjoD4xberOBYXo7ohv2q98zfzbqXLr+Op2C/XAfJIKcNnAvEIX0k+pB6ZiRhYyE0Z3FF/7+dve6yQoMGHT7mscJ6mKYQQQ5qFii/KPXKsW+QGnJdGJ4+b32n027Sfg7+mJStS1PxV9ohyL65EeBYvN02fV01x5t/eN2rXvjPUOkQE86OKRz7zlOOIYIBvDGGFRR6IXbhnLuhoL1ddE4QMmKhygNuTFVa6g92wsnssXVcNQEMKVeV2cT4O5J5cahYChVBCG/FCil27OB9kqI4QRCr6Hr0NeWJYkaY3pf+xWNAtzYIqLcRoA2sUqPg/w0f93mc1OHrKjpJTo0IhnxOufZe5RAagO37ztxlYep
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9809b93-49f9-4d95-ecbc-08d7fc634d5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:12:53.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdFq4ka/oHYTevAx9NXBR3/q0iUdyT5y608mMiZ1BF4OZUQ0+3+n9jih+1j9SjbWbZFISZMheBSDu+MOOD9fWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add ethernet alias, so bootloader code can use this to find the
primary ethernet device, and set the MAC address.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9d3c9693d713..1d15680a4962 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -20,6 +20,7 @@
 	#size-cells = <2>;
 
 	aliases {
+		ethernet0 = &fec1;
 		gpio0 = &gpio1;
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
-- 
2.16.4

