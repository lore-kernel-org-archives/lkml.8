Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530F7C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D33124650
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XPgPkPgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBJJ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:58:36 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:26564
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgBJJ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:58:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfwYWm2ZBV7ok506aZFm/h93ezxurEYt/kF61edYZwDkYmglHkdBFwXHc2IcdxUPqvP5N4bmd1M2LaAyHR66FtdWg+Oodsan/hGcm7tXeHqfXbmlBeifswDyDQ66Mg8/4c8p/OGjCr/W9llvxob0sW2f/G6c2jE91fPedYhTBX8y8eslA33QCP79mD9OzLc0BGDqiDoQpLu2YEWaixG7OeVqeEqGAIbTZ7ywvCb09WqxezPWkL2FJjMvVkN/eCHyyA/CuFxZrll+Zo/ur2tKLTn/d3OVpLzkwzfH+r7v2+5rcLptpsXW1e3U4xKsFbvDC46+uVTPX6s4Ckcx8XVkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9newka8DUzdEUfBPt6VyZKt/vTiY2CUFOj4luSiW6O4=;
 b=DAwLiV1nn8mHYmMIpIrY026TRT4km8762U8UxtCcGlndmmJOObJDeXujpUsOKTy1MIorgmKo3L7cVXtqeDeDsTzT9d75Eo1SoD+zwk3t0y2PAiy1Zk7EPAmHWi9CnnSsnbpbI7V2Y30pg724Spdqj8lwKzSH1hkRAgkflvoGO2T7j9OWkfFaTn+3qe+UbtTUN3kK0fgU1FoHXM7X50oDjwbdqHNAfXpzbnWy7T323+HAbVUinWhAqOdHS5zGtBVatDyl32lIwXJA3ToRBp9fgaA2YiUYtIXlk37UrFRevY5sxTOTJYvf+kT2sHfZxBJAmwbhK9pwCY02wWL65PzVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9newka8DUzdEUfBPt6VyZKt/vTiY2CUFOj4luSiW6O4=;
 b=XPgPkPgZAZrl3Z3HBuKeBSaLCGlTft8cxa3gh4PcyzpqpOEVM8Vwd3qpZIyyf9x6lQWYNOZ652o9LBeZySUX52RtuZR1/gT3SkZ0E3a95N/Ql+a/B5jMV5KVKNUEzizgz4JQ1HLCLrT8KHdDSf/6pTQ4AVMyxMBKkKN8FWDqVZs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3423.eurprd04.prod.outlook.com (52.134.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 09:58:33 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 09:58:33 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     festevam@gmail.com, alsa-devel@alsa-project.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND 0/4] Add a better separation between i.MX8 families
Date:   Mon, 10 Feb 2020 11:58:13 +0200
Message-Id: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0076.eurprd07.prod.outlook.com
 (2603:10a6:207:4::34) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:207:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.9 via Frontend Transport; Mon, 10 Feb 2020 09:58:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fda7b2f-882f-468e-f6e9-08d7ae0fc992
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3423:|VI1PR0402MB3423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB342359E33DF46047D7BD4CC3B8190@VI1PR0402MB3423.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(66556008)(66946007)(66476007)(1076003)(5660300002)(6666004)(44832011)(2616005)(956004)(8936002)(6512007)(6486002)(81166006)(81156014)(6506007)(316002)(16526019)(186003)(8676002)(4326008)(26005)(2906002)(478600001)(86362001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3423;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiNYC3U5OneanyGs5XaTA6qKUltIyXnl3AMwlgbT3YZFZFN4kGWG3RvSe/CN2A/duNf4IY6k3mqsIlmqqf2O23y6mnvo6SawsLkOC14buBIbsD7rihaIE2PE+nh8/GWHPZhARjbJLv3xIgOl+aDE/BQQDF89E114BaPYsFd6+9najhlNy9UYbQqoRbxSVWfNV81MattsruHtc/00RdfqQG4R6KX44pRfNXJJ7W2luXNlA8wXbg5yfEEe+bBmiLi/+aCZzLo7qOYIs1wgBB8KPk+pmDDtvERuYdOWOkROrcnHl7KvvlXhRsfOk//ul0oLqE4qy0X2yTuw9zowRL7sCGQEnUCEk4sD5hTMxc8EGomwDMw4LngKdR5ErWnQiOjKRlQXSLqhIFdLvuRXvo4thDNSW2QqtLsXJoZd8FkOAXarRkgeps6KTvp6+2/2g2AL
X-MS-Exchange-AntiSpam-MessageData: wtZLns3m0HgJKnJGCG3VmJrG45dNZ+3KC5pCt2g4ZxK00RloUhZsMB4Or53xVeitmKgwWiv7PlUPEgCSDBNUoeGIL5IXm5vmcRdS2D8vOKddHfNb3gvNf2NhM+BP0LXPCS9K88HHMz2iKjsYKQcvuw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fda7b2f-882f-468e-f6e9-08d7ae0fc992
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 09:58:33.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1wNStzIsaUBQRDVWxf3EeLNNBPqZ1df5wZXo9mCUjNZNzhYR+d0izAUXiBxmQwyQ1/kMxjqlV8rx8M6tuyT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

So far the implementation was designed to support  a generic platform
named i.MX8. Anyhow, now working with specific i.MX8 instances we need
to account for the differences.

i.MX8 naming can be confusing at the first glance, so we need to have
a clean separation between different platforms.

Here is the split of i.MX8 per platforms. Notice that i.MX8 names
the entire family, but also a sub-family.

imx8
├── imx8
│   └── imx8qm (*)
├── imx8m
│   ├── imx8mm
│   ├── imx8mn
│   ├── imx8mp (*)
│   └── imx8mq
└── imx8x
    └── imx8qxp (*)

Platforms marked with (*) contain a DSP. In the future there might be
more platforms.

This patchseries does the following:
	* renames imx8 to imx8x (because the only supported platform now
        is imx8qxp).
        * adds support for imx8 (which is imx8qm)

Paul Olaru (4):
  ASoC: SOF: Rename i.MX8 platform to i.MX8X
  ASoC: SOF: imx8: Add ops for i.MX8QM
  ASoC: SOF: Add i.MX8QM device descriptor
  dt-bindings: dsp: fsl: Add fsl,imx8qm-dsp entry

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  1 +
 sound/soc/sof/imx/imx8.c                      | 57 ++++++++++++++++++-
 sound/soc/sof/sof-of-dev.c                    | 10 ++++
 3 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.17.1

