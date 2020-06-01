Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0BC206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hf3+SGeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgFACRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:17:01 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:29413
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbgFACQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrL+4ZlVMjD8IiNzsRt4lfbXSQSugAB2OCsrks62EKitOws6uqDk+IaDVTFvuavSlKoTfmFFzy9fkT8nLeDT2l+aA/aQiV9WipciVUaat3I/a8iPt+Sq2ebXgcJkigqYtU2yNiDNpAI9MVuQceXmNesiP01WlHQqN9WND+pB3oltApbQOVpGx0McdjqCEQq1c3gdb1uOCxl628hfip0ut7XIykJtGzg2FKMAmgkJK7ELVU4/tlpmsqAowg2j0T0dL7dhwnVntde7nVkZmHJXrDczqRagDhqGHIGxbsdQwDWGGFk/KZO5b/LPa8TlrbkSeQOE7gWQfPZ8DTLNpPIzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsQxHD6Ioi18/pcivDAqWDmzwr/sf74RCsJu177TEwg=;
 b=YWJoM+HK35XfgAh3uquDAL9RxLZb3nIKbcAb05ffxp5VtMVnfZt+cMT7nfrNvx4LY6NNanpRKHo+o5dMkCGdr6fvPScieA/0Pie1hs1S7WyMsFf9+vU36PqMmAGpb+SMAbjCSgJiXx5hF4Fh0ysmGf0bdKPMS88DqV+8mAFn1XUrkpMyWK+e99uuTvKN+zOF8rZZ+5dAL3TTaW/Yc3h0ztxK4++askee4MWm800pxCc5v2+CUN5xjFupEc2DlqC6XTeUbY9B6QzasU3BsRZYthT/A5/RHpzERXYCkrRn1/5T+V8TVc1SPzHOBpQmwfo3mxVpW5+ABF8lPE0fYUCRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsQxHD6Ioi18/pcivDAqWDmzwr/sf74RCsJu177TEwg=;
 b=Hf3+SGeWFoHXCetYIzfQ0k3uunLjpsnTCu9JQDgggtsqSNMOVaWt+A5xxPZxyn1/cGEMW40quQvHgY6Fc+b4XQO5h+0pXQS3X/5l0xcQ5KXwuYgVDbIeBi61iiF1EtZuQKV6b8O/jqWI4TAk9kjXcKRJVqao5tq4QZ8AH+Jh0Uw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2744.eurprd04.prod.outlook.com (2603:10a6:4:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 02:16:56 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 02:16:56 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] arm64: dts: imx8qxp: add alias for lsio MU
Date:   Mon,  1 Jun 2020 10:06:18 +0800
Message-Id: <1590977180-9957-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
References: <1590977180-9957-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0157.apcprd06.prod.outlook.com
 (2603:1096:1:1e::11) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0157.apcprd06.prod.outlook.com (2603:1096:1:1e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.17 via Frontend Transport; Mon, 1 Jun 2020 02:16:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b72045d-70fa-46e5-54b7-08d805d1db80
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2744652CB1FBC7F912A5A8C7888A0@DB6PR0402MB2744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Z6bZuTGJvF6W9LsmIIteZpmvldqV6lZhRIpGbQA89gudmIF/JAgN9fFN48EGjMEwOgHcLbc24OKqptstDLTkzFofYGO+ntfVvuFK5UPkEbv4gkycUJMePpGwwpXYKMC49X2ggGs06eVs0XjKetLGHxQ+s6hFdEzNJwFpNoOZThiROIUqnNXDE7ZCl8njESsAySUTbmXzs4TfxpEXjQFIjiZC+O7MDqVXDvBzPcrS9vdhGPauhL9AuQ4YDNItQ7CpJ1vFDFXpEhMBKK3xsU5QOzlK7qCmS9wLMRX4JZ5PQ1hHnZy00ArubTkOYuiXMKiO+G40DB9IVlkIXTh3f/6eJL13VoJbVFaCmScxUUc4cwVj53FyBWiaWdaoGTFmUA5vw2aAFuFGklKKkGtGcaWBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(26005)(316002)(52116002)(6666004)(186003)(16526019)(6506007)(8676002)(6512007)(9686003)(478600001)(6486002)(8936002)(4326008)(69590400007)(2906002)(36756003)(66946007)(66476007)(66556008)(2616005)(956004)(86362001)(4744005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BTM/JQqR/ixifJg8bm/QXe4XmJsQCfsvM4pzACLGzgjpd7/DB+X0fuWv3wwZb4cRQaBj+2D1sMGeYZBIT71YOXgFvFuaFAAa9UzGAFY+JvkU+MIkzTyIwIMqBAFKhGGzzxOy6dfcInFehhAyXFkI2C3qfjDE7ixRIYMKyIeK810XryC7Q5CahCnUbWDFjhcItDxrrlsCvRlsJwJgRrnH9bYbBCFnNbnfJB+IdaoHfjC6LtydiVCM35bj5bXRWh8yuAe5T4U+vXfial4zZLnrJ+F9FFQnfAa7tok0wVbUMUebhKOCRh7dfkMGlj5Rj/Dsi6v69FhqaiiD4gW5Z+5+6D8EjNbWl37am0suyn9rk6r/bvIAgHp4dtG/xzUW5YEIvse+KZ+msF46QKllpnzbGMmTDeibiva/mpYuwLJTfzHwsOFU+AzWwLo9Lt7p5N8xU6uWoVD8FoK/aYDb/R7olq70idJ4+JBQa1wRkX1djEo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b72045d-70fa-46e5-54b7-08d805d1db80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 02:16:56.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NRUFFen6C92b+96ivr2M23bihLTQ9h7wb1X5C00ms1chTa5gl8XftTzuy7QUSsEMcAU8YqvXoYAXQWENp8eiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add lsio mu alias for all lsio MUs that could communicate with SCU,
imx_scu_enable_general_irq_channel will parse the alias to get
the mu resource id, if using other MU, not MU1, the `mu_resource_id`
is not what we expect, so add alias to fix this issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index d1c3c98e4b39..33363c127478 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -30,7 +30,11 @@
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
+		mu0 = &lsio_mu0;
 		mu1 = &lsio_mu1;
+		mu2 = &lsio_mu2;
+		mu3 = &lsio_mu3;
+		mu4 = &lsio_mu4;
 		serial0 = &adma_lpuart0;
 		serial1 = &adma_lpuart1;
 		serial2 = &adma_lpuart2;
-- 
2.16.4

