Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5846EC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470E214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D5A9hwfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBFNGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:06:54 -0500
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:31423
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgBFNGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:06:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjN6yGBmpuOatDFXBxnFptQKKJC7WlH/tSGz5/2c8Ai/erLy+aeCjVB1Mrq6l5i+x7Q3UN/FMS0kC/CqiZiOd3ihvtcmMyihkb0JUmGHs2bME0Ox0iyoftPVTV52+cbru0dWf7yjxgVlUTIhnKmLk+ABCXFvW4FzCJDBVzzUgmXmdGYcVkzpzMS6fBRTm822CaF3mJWeb0/spZ3hD6wjs1M/GonUe3AQsfk5QnpyZ1gHKZ9lVWI7dQzfeDk+4sE03CWWxqhfFfFr+hqhpfG9z5mwgpCPpsL9tgcg+kQcUP59kNzikTvxoHreOHWErS+yIHYNPzlT3kfg2qAWH7iHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gybqcWbyB5XKzo4YAEC+KJP2BFtg6pi/7ThCLJLO40Y=;
 b=EvMfYuCaEFc4PQIbkREvu0Doic9mC8W4wstQkXyv75C4zjLlxGJ8ThCVdX2tM5x7nXTcVUVi9oIKSFAa9lArVZYWqHR/rJeTichmuXbSqWmQsZeXXh3xhTYzs1MIfLRwOxnXJenZNnnx149C9r2vk/SoLV2BP5GoApOMWGSWx9mMuFyMiRSuR5fMVf4NuIneyzdeUI5vC90m6Y2UyWiM04MMgeEryp18AKrhdxwqUAjSjOQSCN0vBDdLnoEW6C+6rSVDc+Qr3O2EPOisbLHiGPQrb1YV0p9/P9LFH/BmJOD08/3iEHRImFCFUGqm6WGI1UrSd7vDvQwrR4o4Df7kMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gybqcWbyB5XKzo4YAEC+KJP2BFtg6pi/7ThCLJLO40Y=;
 b=D5A9hwfKvyHkWvO4MXc67bVr/xfF8oZK7E4iGeds/WNAMglBJGyz6jJ2pQtUcIO4s4aFZl5p0axiI/bsAKaWR6C8iMKkzZD0dHsidhgHwuwQm1D3FZ5aBSLfbsXa1OnbigN44DPpgUXybNlY9+NUsJ4Rn/D6HCL9OtFlfGFJ8eY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4770.eurprd04.prod.outlook.com (20.177.41.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Thu, 6 Feb 2020 13:06:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 13:06:50 +0000
From:   peng.fan@nxp.com
To:     sudeep.holla@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andre.przywara@arm.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Date:   Thu,  6 Feb 2020 21:01:25 +0800
Message-Id: <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:202:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 13:06:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb9c3bf6-564f-4d92-aae6-08d7ab056dbf
X-MS-TrafficTypeDiagnostic: AM0PR04MB4770:|AM0PR04MB4770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4770C7A647C0A835CB59300A881D0@AM0PR04MB4770.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(86362001)(2616005)(956004)(36756003)(6486002)(6506007)(4326008)(6666004)(6512007)(9686003)(69590400006)(498600001)(26005)(186003)(16526019)(2906002)(66946007)(5660300002)(66476007)(52116002)(81166006)(81156014)(8676002)(8936002)(66556008)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4770;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugH1DOXlJ7UstDvyzxSOrd3Bboc8/33mCckgK6DGYhD2sBOlghGiq99dl5k5MWk1WEKgfcV2rstdvZboPotGtTgKXgzqEQ7lrRvsodcu0EEctkVFHZcyTTrlEpbzxWrPgTDzmbWynUH9cFTpvhD9oF6eJJAHhDA+1BRVz4NfqRQQt/ZaifeAW0FQmvtUDQzr7OgfABNtAm4F06LubHUG7pHIk6rs7Z3Ead8X/PpRaiuFuxjQCyfNP7vDcaLA1XVOoVghq6zQfcjGJMtf2AMqUMvJzlpilp0svzQtvWQVi/K/fSDGeBQZQ7969IDRpT2QyIE/Eye+/Ht0Ueth5OqcUAzMc9kh4L615rTKhHMnp2BAwKfxkuWdQm4C5isc+kmRmVTnkVTh8chHD0mC1UVrl4hKQWQz/zZA/ileaM+Aqy97FLGXro/DwVW+dVpAn5g2pTvccBi1iiZ1MicGfru+8UGYUH/X6ibLxTnE5/TAAfZv7O+HrIKSmoPSQ2xb1XBhWBrBoRJWh/xwChtI4QI19ZtKFUwK4RYhvBo2sRv/4RFN5REclfGKhJsAMY6Q2GSY
X-MS-Exchange-AntiSpam-MessageData: n0qF5UIaqQLenWlnJx0X1UQXHO5TQ2sy4dcKqkgdv0pO6In+wmaotPntRfLhEVRKg4ys1AcYyMiF7LEycSZhdPbvs5yE8yCNBjwrA1B2dWpPmIu1GwWdPVqUFPZd4YP4XXT/00V3Zi/lXobvKoJVtQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c3bf6-564f-4d92-aae6-08d7ab056dbf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 13:06:50.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EXzjzY8EYNk+wDyjYMEOBkH/egebjQuHQM9ir5JphgrjKEuldqgbCx0KuTcIdVT80I+XixcJfwz82vrMOvRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI could use SMC/HVC as tranports, so add into devicetree
binding doc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index f493d69e6194..03cff8b55a93 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -14,7 +14,7 @@ Required properties:
 
 The scmi node with the following properties shall be under the /firmware/ node.
 
-- compatible : shall be "arm,scmi"
+- compatible : shall be "arm,scmi" or "arm,scmi-smc"
 - mboxes: List of phandle and mailbox channel specifiers. It should contain
 	  exactly one or two mailboxes, one for transmitting messages("tx")
 	  and another optional for receiving the notifications("rx") if
@@ -25,6 +25,8 @@ The scmi node with the following properties shall be under the /firmware/ node.
 	  protocol identifier for a given sub-node.
 - #size-cells : should be '0' as 'reg' property doesn't have any size
 	  associated with it.
+- arm,smc-id : SMC id required when using smc transports
+- arm,hvc-id : HVC id required when using hvc transports
 
 Optional properties:
 
-- 
2.16.4

