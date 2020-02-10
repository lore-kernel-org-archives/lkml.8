Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36676C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036AA208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DQNgSiiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBJJ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:58:48 -0500
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:3017
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgBJJ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:58:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESMkRwGppluJDuD6ytF+EpC+n/goV/aQqVpBVHmLm5YyeuB8iaGK99oTNJZlHaFUz59YMgeGGMyfOmWqpaHa+THQYqB3Tx7M27erBg/hIJqHq1tzGbrCLadIw2d9vOA89ojoHMFvZ75GiKunASTl3ZzwZr8vKj/K0qIpgjV54cvJtsZJ9nYXJlEuQujwyDXpM0kluxg+0O4jQ0KkWuucbmE/vma1GOD1vUf61K0ioZebJUTkyibmslColqwcZASWYZ297zbcaWe8Sv9g80R3wiyRLHk6Yi7CbTrsYUyPQZyHgEVHeK6hFZXp39Sv7PIYHJu7AxJfTqGxhjSEcVsDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+QA1YSM6T6NusxwnbWRJCIoo6V643ml0FFpPb+ARMU=;
 b=g6ZWC9mxj5trXGARQYVZTzGT6ybE4slRFeLMRCbrpA/f8QLuTMqgVAgq5Mb81WTLXVp4hr4tesvQXOuaoKnSBJdeFO+6lK/pztpqHXuZKBb4FWkuCLrcKlV6KwEVPsrZ0ey8mhSVn7EkcmUkd0y6sFgngbbQKgcDRrWicYTbWWM6JGtz8p5GI4Qi9aNJT2tU1p1IY+8lmFrpEUShn+jlMo+14UyFmwrHvyKeLnNz5lJeoCj5QVbQr1w94aGb4ZlNH+rvh87EN9C7Priesq8fvcGRNBuaCt+nqnMWBhmoXQSUqQsvQio8nzTWGpRQ2Uv0mQiBGtnm6Oy9PjGup1vRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+QA1YSM6T6NusxwnbWRJCIoo6V643ml0FFpPb+ARMU=;
 b=DQNgSiiPBOKdOKXQYVu1hF8qvZjumfV6uJl8XKPS/lqK3YY23scGDwxR6oPQ0nxdH3pJ3p5jgirQN7va5EeesPcrSAiP2c2x0gxxI7Ej7Z3Y+Fd1zW+gZfB0cOSu9RKzukAAghCAzcnhLj2ifV5DOHSdbVbtFIT59JHQQGgJklM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3599.eurprd04.prod.outlook.com (52.134.1.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Mon, 10 Feb 2020 09:58:38 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 09:58:38 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     festevam@gmail.com, alsa-devel@alsa-project.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND 4/4] dt-bindings: dsp: fsl: Add fsl,imx8qm-dsp entry
Date:   Mon, 10 Feb 2020 11:58:17 +0200
Message-Id: <20200210095817.13226-5-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0076.eurprd07.prod.outlook.com
 (2603:10a6:207:4::34) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:207:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.9 via Frontend Transport; Mon, 10 Feb 2020 09:58:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c78cdf9a-243a-4e31-3326-08d7ae0fccc6
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3599:|VI1PR0402MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3599D434531AC7A3E73B7868B8190@VI1PR0402MB3599.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(956004)(2616005)(54906003)(16526019)(44832011)(6506007)(186003)(26005)(6486002)(66556008)(66946007)(66476007)(86362001)(4326008)(2906002)(478600001)(6512007)(81156014)(81166006)(8676002)(8936002)(316002)(4744005)(1076003)(5660300002)(6666004)(52116002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3599;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bRFm1tUey/GL6h2qjN3Ry4Vb+lyMNQyWXQjzNJCuL4Q+Of+10htYZhrAdjN7rq1ekKMc6Dirhgt6H/b8E7pQ9ssCheza5LxHpEq+aX9ED2yWe6a1HuPCgHxBowNn8VLLQCTyninV6r5Pj8pIIarrpYJBgWUdONzHX6AGNZzAmHfNjZh9bcTedq9ZnjMZPkKjk1rArNM2AP1n7VqwxpJ5/pVK/M3VWNCeR8CkW1AGZJijlty4vuvs2EBU3rdTz0BiNEj5ck+GnL0wOiZZmvGw8r48eskA/f1KT9IEODQvim6EL8/4SAIvHbIHsSKAqDxcDPEK+G3QGOlS+3yZMB0k/a7idFUwAc2Y2y14Nox5J/B9ZtYL9zeiB8BRlFUu2/QJg9gZQKerm4O58CDZVsfQnXwqf1Xa97qT0fbw6xZihPF9kDn10TfJ7XMb7hkL5UjLkMlHnMIQB7fl0JJTBwqNptVuL7u3tAcaT1bxQmmoCy9UGjujEIBR1W2EFAIRGou
X-MS-Exchange-AntiSpam-MessageData: Kv0UYy8Z9hG7n0dOrLgjkac4XVfelzURe1w2XfxRxuYe+5arRwdQP6w6Wv6ni0mVOUhRCNqxTrNekhx/CV3pD2/aIEkXai7ScyvzFgKkPOZWbK20HlKue3DPwIWmZJIf8KbPNumJLSR1jgPEF2V51A==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78cdf9a-243a-4e31-3326-08d7ae0fccc6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 09:58:38.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6I9FuetUnJevu+dbuxEJMRIuI/c9+S1vB1p541xQWGnSmEfmu6+aR/uVP2FMusv0ywKj9S2gXzFosA+oMknSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

This is the same DSP from the hardware point of view, but it gets a
different compatible string due to usage in a separate platform.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index f04870d84542..30bc0db7f539 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - fsl,imx8qxp-dsp
+      - fsl,imx8qm-dsp
 
   reg:
     description: Should contain register location and length
-- 
2.17.1

