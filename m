Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C409EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9210220786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 09:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VjsKtk6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGEJrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 05:47:16 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:63618
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbgGEJrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 05:47:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzbEqNJs4LaRks8V3YL10AFCtdVkr01hBUEZsmXkZPsacajz1AwZud4w6ZB9aYf6A3DM1Rq+To4/Adayli56wdFbhzcFGwyDWDU0/EGhuJbm2DPZ7SbOLobobncJDqW+TUBj65Z+Ij3YtosRVsYHam30QW0Vk/abh7vcSe45iOYScX4GAHfI/PLuu/hURas+a3O2qnsiyvBMStvPPiplbnobxyCr/HAOTnbpKDXlb3igt6xFsIo/dzwXLtKWGdH/OKBhD7MSMcX/gRTMsQakUEpiY85nJYTEiI4FpMJ0VMuUVa9zJAkFz4DrrIiEm/uhl5x74IyHRZeKupWXzYXPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSMV1Cae+jMtd6qowymAGJ1FI6AZjDpyJUljH9ENBpg=;
 b=bG+ECylqqGMZ6zK7NTCzOWmuG72wGdx/Hx+GI4Hq4iI8f5HH3MFisXi6znEIm0wV0D5IdG8poRRe7SUUq/vO5/uukoXGbZeZmtnga6+purwF9sPO6WCTF4++H9Wcd1DjUPjT+5/kdzULPX0rhloLtKo5ShY3WmiRamI5d6tS/rF8LIjiPnNUI8b1dSqxEv3ORzQkXZiYU8ka9XZPEP6wDClup1d1it5MERfJkXAk3M9Chy3dJUf88/8ahEiHJvhKRQzvsjgOmbRw8REqryPzYFi98E+fM7UXVIkZ7+xvMjSOZ7p2yeyPch9x3IsFtlAjFbsZfAClhYbTlRzXg0P9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSMV1Cae+jMtd6qowymAGJ1FI6AZjDpyJUljH9ENBpg=;
 b=VjsKtk6dkDgpPXWmtkQPZ8V+LyDNsMnB1GapYdQ70Mt1ud1z9tnxVEr66eO51QYA16k3c2dzk+BYjbmNtj+BBFEtxGJumXuGoEQXi5rsOs3QX2wzncnOQrgDPnOpQnqpPEE34RiSItrDNbOMrKWnw5WX+M7AahZvUCnjslr84Ro=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR04MB5183.eurprd04.prod.outlook.com (2603:10a6:803:5e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sun, 5 Jul
 2020 09:47:07 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::8459:4be8:7034:7a81]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::8459:4be8:7034:7a81%6]) with mapi id 15.20.3153.029; Sun, 5 Jul 2020
 09:47:07 +0000
Subject: Re: [PATCH V3 0/3] ARM: imx: move cpu code to drivers/soc/imx
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alison Wang <alison.wang@nxp.com>
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
 <fd6a7452-25f6-4ced-7b3f-4aa92388ad09@nxp.com>
 <DB6PR0402MB27604DD8AF73824C3972BC90886A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <03737ac7-75c8-05d7-e0b0-3af470e3b6b8@nxp.com>
Date:   Sun, 5 Jul 2020 12:47:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <DB6PR0402MB27604DD8AF73824C3972BC90886A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0098.eurprd05.prod.outlook.com
 (2603:10a6:207:1::24) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.129] (84.117.251.185) by AM3PR05CA0098.eurprd05.prod.outlook.com (2603:10a6:207:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Sun, 5 Jul 2020 09:47:04 +0000
X-Originating-IP: [84.117.251.185]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6f3aa16-15a5-4020-cd3a-08d820c860f4
X-MS-TrafficTypeDiagnostic: VI1PR04MB5183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB51834AE2821A9A151A165B3798680@VI1PR04MB5183.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 045584D28C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aasoQnAc6irHr/Ld6Rx7Zp+8GVSZgPqb2ln3MceXB2HMNYw5TVrt59Bok14k4ePaDS1YU8R9kOF+ViGMPCiMFypbRzBv2J2a/TJf6Iet5pjfLl3BDH5sSXvF8ozIh9h9NYyNv1BGkoHF9/xinGs6R7Jk5avV70DMNCo8HSvvpjUjwIDkTRgSqvY4wjuH5ADAjzcNYkb9wcy4nSQedsgtZ2iSp3UpMsXA5GvWU0knO/ol0ZWGHTxT/yH7U9WrJY09ElcrBY8oh1B+Ji6WabHSmmcU5wlKwkad7Qvaafq6EfLnUHA90ZYyzk2PiE0MEDHPSAx4sYqSqB6Y0KF/5l0n45WRXEF4ZtfHFB6ZCdkwJMqtLeCZhS81HrVL9dtwrEPl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(6486002)(53546011)(2906002)(36756003)(8936002)(31686004)(26005)(4744005)(8676002)(186003)(16526019)(316002)(110136005)(54906003)(16576012)(52116002)(956004)(7416002)(2616005)(86362001)(66946007)(5660300002)(66476007)(66556008)(4326008)(478600001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4sNsShOx6Raosa7RSXO4CVHI7FUy4oR0vSIAIhFK4e4oyxG+6nLSC1d4LybqwUVHHNE+yH8PrVnMwae08G3ig+IxK6W6W2GAnQSmkaAHIwgdW3wIE24AdzknnqgiQMz4eZa+GgQ3iJdFiLvcRfSvCgstnPfSd5hku30QmYikW1Yp2QGI1RpVMOTGfqFj0ZnHAaipvXwiEK7nOwC2kmpFnZBVnQubRffG/bGFXy7UMhp4fwOv47fdjDIMabuZHtltV1xSEw5peCrB9hZPiZKxXCYuHMhuLacx2G6BfU2JdN+bgcHD67quC9qS7VsdL5el8SO/3E9J5KlhWk9aoPjKJOs2zZnmvbkqPGdgSHLc4mWiPA8SDyTsauFs7ex6MA7B43oSzatwRqzaHI049mnvjxkVMdHVA7xcxEpKu+hJ87J+QEsERbARy3LY4uvCac/AtB5oD31sa3r1zmtVKKEhwAclZlWK4BMOSjiizDrZT0TRqyi9MJCLD88tUZ+y8xJk
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f3aa16-15a5-4020-cd3a-08d820c860f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2020 09:47:06.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZbrYGAn9zCpKE5U00rlzZnmeGxhSNSkVp/A+XvevKGYMOzirGd8dYXOWiWAaQ0C0PnaDkXH4qKvEjeQzA3gQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2020 3:25 PM, Peng Fan wrote:
> Sorry to break LS1021A. But I wonder why i.MX code would affect LS?
> 
imx_soc_device_init() was modified to be called for all SoCs under ARCH_MXC.
multi_v7_defconfig, which is used for LS1021A, selects ARCH_MXC.

Previously imx_soc_device_init() was called only for i.MX (and Vybrid) SoCs.

Horia
