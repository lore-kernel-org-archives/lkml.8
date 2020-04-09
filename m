Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF0C2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1020753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fBHl3nAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIHSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:18:50 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:6249
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgDIHSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKNfJWcctU8ATMyifCvTrBZK4OcYPXdXBY11kfWUtXkZUu/HMZmAW+hSZKm1M4h7XUR6sdohlhC5pa9Fn5FmOPJciUGer7hCWk8LIENmTt9067fHO6GiAvCbu8A5PNMyCr76y3LqNDVPTll2+/jc3/uCJ54JpQPe9JDDGHPLjBDllZWqaRe3HYC54pw/oQq9i2srFL+ZSmfRqWMqU3wB7BgBr6bfjLI3WQkhVwCk1zFB7sHYxUPQfoOs6BB23ftQ2posmDL6TSedPaZb/PvV93/ki6LejeMOnY2bLPI2HtqNonPJswafqUKQYkqq8APJ7II828iD95Uu4/LPPtlc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk8+h7R5wYqtP9UURofjAZhtSs0oAT6VipNz7xuQLks=;
 b=Prai0z353lsOG3ytZHvlhPBjGqPvlTNShVH5i60i3Mo9m0JmQTwC3L+hWG+FDGDyMz+wjiVuHNyzwT/FW2XkTg7Z07Ytbb4aJvg4rru8ZZK9jJn7YAXuqumZc7zE0QzQ8QlJ5xI6LXTisxa/+fdAEGb4YZuCrtD4idplzkAX3dxi+BiU+/7BTTUKdDch7b3BNtjCqfH07Oh+ZYHwA8QqtXoh/aBfQnMb7RjVypHQGKhnqcLPjNzG99ol70+ZlauEhNEfjetEnuJQxk8Ff8GLcFEbrsiQJbryRD/aOPvEcWriqjY3TqlNe4YyM+u0HmGDLfxmT8/2MpucTwLRwuuRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk8+h7R5wYqtP9UURofjAZhtSs0oAT6VipNz7xuQLks=;
 b=fBHl3nAdLFjki3SeAeo09xE0vJPklz6M71D7LXE5fENfWkavP6KduU/gIZqyJG4yp2CuPfEZofyfyhUDLME5uHR9Qd/DENB4PQnSRrfUTgX9BzyCX+NlTs4kePCdfpTfFxB/K34aEpEtnN+2l+6ztmu+9o6XqyPAO/wgCoGVy/g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30)
 by DB3PR0402MB3756.eurprd04.prod.outlook.com (2603:10a6:8:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Thu, 9 Apr
 2020 07:18:45 +0000
Received: from DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c]) by DB3PR0402MB3835.eurprd04.prod.outlook.com
 ([fe80::f0e5:c143:32aa:ed7c%7]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 07:18:45 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-imx@nxp.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/5] Add support for SOF on i.MX8M
Date:   Thu,  9 Apr 2020 10:18:27 +0300
Message-Id: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::12) To DB3PR0402MB3835.eurprd04.prod.outlook.com
 (2603:10a6:8:3::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 07:18:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbd7ccac-5399-42b3-aae1-08d7dc563d18
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3756:|DB3PR0402MB3756:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3756190099B6C37B62094601B8C10@DB3PR0402MB3756.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3835.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(4326008)(5660300002)(478600001)(316002)(26005)(4744005)(1076003)(66476007)(6512007)(81156014)(81166007)(66556008)(6506007)(2906002)(66946007)(52116002)(956004)(2616005)(8936002)(6916009)(6486002)(8676002)(86362001)(6666004)(186003)(16526019)(44832011);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGGGFXiEk0xt9U4idbP3uU/TStipN4UeBIt44KGY6WrTWufBD0SlPK1Wh2ujhnYii12W0ukHkJCZuxtYfI/yz8CKkZ2b0hxcIghv7rAjUa5XHhMwHZYi2NF1a0+U5piFN9HCde24lQ4e1IPYd8i6apRIJRzkEHLaNzZop136Eucb3+Zk1MnEroGFNLMLCCSaUd9/1uDKfubXXchcLfeSA64xETPfX1zYYpqV4auk430tQXMWtOmSm1RwhqaWrtqvMWJCnxu4xL8kofDC0IgMf6ZBe9tcHnvhu24qEdd3/jQR2G8wuhHLrCF6co6fU5k06yKGXHXCt8dGnvUHdQkx/sasB1HEd7enc4eRW4V9Xy0GI3QRDmL+BnW3uOcZstOUYe3FR908ZQfBBZYfIglVDIfltjFu21hNkCuxMF4KDtCDDcAdCjZKSUc5xL/LoMwC
X-MS-Exchange-AntiSpam-MessageData: qWgNV3Q6/GsrVoB/t+yg7Gt3AYFqPp6xxjPKg3GjmfFtQyIm9bjrhWDpVyFHbA5NaD22JneY8LEQctOxWkoSdKHGAxhDSeiO9WKoNBIBfmOYN3rsfxhRj2EC0tHZIxVpF60xFyKF7elK5bRxUNrDzA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd7ccac-5399-42b3-aae1-08d7dc563d18
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 07:18:45.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOisoa59itoyKQCnxQpeWizdgUdtfH86zWc0Lkk+KufVk7lXP8wWzR5mUqv7tHOX0GamE8+1YxH0nKaZOEz2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series adds support for SOF on i.MX8M family. First board
from this family that has a DSP is i.MX8MP.

First 2 patches are trying to fix some compilation issues, the next two
are adding the imx8m support and the last one adds the devicetree
binding.

Changes since v2:
 - add reviewed by from Rob to DT patch
 - fix ownership for patch 2

Daniel Baluta (3):
  ASoC: SOF: imx: Add i.MX8M HW support
  ASoC: SOF: Add i.MX8MP device descriptor
  dt-bindings: dsp: fsl: Add fsl,imx8mp-dsp entry

Pierre-Louis Bossart (1):
  ASoC: SOF: imx: fix undefined reference issue

YueHaibing (1):
  ASoC: SOF: imx8: Fix randbuild error

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |   2 +
 sound/soc/sof/imx/Kconfig                     |  32 +-
 sound/soc/sof/imx/Makefile                    |   2 +
 sound/soc/sof/imx/imx8m.c                     | 279 ++++++++++++++++++
 sound/soc/sof/sof-of-dev.c                    |  14 +
 5 files changed, 325 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/sof/imx/imx8m.c

-- 
2.17.1

