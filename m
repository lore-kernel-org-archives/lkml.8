Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B36207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ByhR3cZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCIyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:54:03 -0400
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:6204
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbgGCIyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:54:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEgpjvpQydyVXrw3WnYliAerUJG1Dug68WtHe838f9iRsMvTQtK+r3VEiRXlbFaqnfhblsnsUt6VCqp67dFlvoj2jMHIaDsd/72Zks4WFeUMmbqZrZnqWWa6uhgcr/Id+zbqAtS/FDHds6KPGEXlX/CTj5+XaxCrVJYveGdmVH/zZE8m0RwgfRSJeNOjSxT43Xr0xWHVb8cAUy8oWIKGFZff4mgmEcaVwHtg0mui+iYY3irrIfiuI0JWIhzXZbkRmyEzg72JEq3wfgeFTMfyKePZQVoZIfVV9QCTvQidldrH9moN6HUj8FNbY77Kvll+O3pmzV2jONBLC3qkD4pBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4xUNkT7fc4Wckq8RgxskTANBLRkLgbu55kstAC1OmI=;
 b=LpG0dSDbLcvAQHjpDO4Kt6cS0u6RP/WKSJEIq5Qxq0Jk1dSpx63+bEYYe6FiECJXxhu8u8WqGzNI9TycORheU3WPiEsnuU/QxPmepgFT9KfHHu13RGS0KI42xHSGh4bc1lEFmn8yCtHjR9colnGL9wjUGW7+lxNi5K+uVvFSnfTpUTN5H7yoBMHKM1OQCNc9+D2tVYs3ck4E2Czq0TXHzZhBmIPTnGLkRKBIN0Jbus7+V4S0yWfcOV/ODKX+B93vl+pZCiYtN4VgkspuzzTYz0Lku1rVOSfd8CoQ7tshvZBVogBHpvPwaxxPXkC5wuP7kkS89sMlGF3jhVsDj4/EAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4xUNkT7fc4Wckq8RgxskTANBLRkLgbu55kstAC1OmI=;
 b=ByhR3cZuNxHsr9IRh8KVP1WbhLb3tZSwHBh2UNyuR7QoNzAatxDQiT5BIkjYvjhuQrFOguCQoScicqWJtjazjJQ0ZDK2yWAB4qzxFX2RsvyJFpaYtV0yaWE0Ma2OoS3qhMLz/z+uuj1WhLCJHurRbiqCJQsGOLzhY1/MJ5Fq5mQ=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR04MB5710.eurprd04.prod.outlook.com (2603:10a6:803:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 3 Jul
 2020 08:53:59 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::8459:4be8:7034:7a81]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::8459:4be8:7034:7a81%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 08:53:59 +0000
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
        Huan Wang <alison.wang@nxp.com>
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <fd6a7452-25f6-4ced-7b3f-4aa92388ad09@nxp.com>
Date:   Fri, 3 Jul 2020 11:53:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:207:8::27) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.129] (84.117.251.185) by AM3PR07CA0141.eurprd07.prod.outlook.com (2603:10a6:207:8::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Fri, 3 Jul 2020 08:53:57 +0000
X-Originating-IP: [84.117.251.185]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc949618-6b4f-426a-d7ab-08d81f2ea066
X-MS-TrafficTypeDiagnostic: VI1PR04MB5710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5710D6A8352AC69DF1C498D9986A0@VI1PR04MB5710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mewu3KrJDad2v+KWFG9/HZ61M4NzfJjTORMwsOf/vgRnIOxPBjORy4JdL4XEp8k28Eb+2qG+5rS5U4HyY5bMVjhUSBnNgv/WbWmf0NDzjAzpOyj26P+Ohl9ujgItdPFAYOqxf7lOZKHO3WY4X3l6R3ibzVu2PjILtUiBHP6eXO4TbkNSKRkiUQlBECl+zjGTLXsJ9ZIDElvOq9ZrCcIQrU/TyUEZlfTSoC2RsJg2A0xj8cYlsfjycra2v8eKhtPu18PP8vAkLSoJ8kxNxjJlDwd/s91r0IjNjxf7xKgdPdLkevtcTtMvcPK3G/vlQt9BpIci7BBUNllS+e0FH4D056TrihREzO2ilK9VWznf1Tk6G3M5z81u1dcCUFr5UFC075n0vmrBlb0qg/gDzI5C3WT+XsXp9GdLKW8wd/zTSTzZ72Nk0tp6ODAndrK/0FkpwkynnXbGmTRBkN7ooA5ZIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(6486002)(31696002)(4326008)(8676002)(66476007)(26005)(66556008)(16526019)(66946007)(186003)(54906003)(86362001)(16576012)(110136005)(966005)(52116002)(83380400001)(5660300002)(7416002)(8936002)(53546011)(316002)(2906002)(478600001)(36756003)(6666004)(2616005)(956004)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rMZOU97G7IKgUBwaRWnqFpumxRczS4EvBSidXmF32tyY+XGMI5BSw5G/EJZ7cN3l/+a/c7ALt3Q8gGX86glP7Sq6kU21Qa8HzcoFUr/72OFZ5xVGObBEi14+5k3xyR+mZ/24jiF/FbucI0zBrehCagbIQgP6Fa0cFoVxiE6o50AXV9rj5LI9MT0Q/bL4ljULwZcD/WmNV0a6t4fXUrxRyikH0yK/VaqvgZSsM9+vsJ37Fc2dxlQJp7Sfo2MDgVUEIGwLM5fMCHmMhGnG9j5Ws+rt6Vnbpwv3IsXStdLJ2C4NgMIgfW2iK2IGmJsXc0NwQTMocsR4IhmW3X3CyvcYu1MJwJi9+pTFR90sk+TJqNEe+fWuYtMGuHIWiutfdEJS7lQc02qCUqw6W8YFTIvfyFqkHQYHF6Bb58ajZPt9pl7WTeGtWOc1MchUGvaLdDoSKk+btZ0jncM2j0wAggQ3pH6EpQsFcMzLZEIC58WgpwG79ignk5yL6T2mpOPmhAZW
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc949618-6b4f-426a-d7ab-08d81f2ea066
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:53:59.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAQ0TZCvyG2U2sRpor+aQADu1CmOFp3fheZdXsrZJH5VU3pBc5PiGQMRjBvr20WV/M8TdqRisrpIFV4gnSJ0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/2020 9:01 AM, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Rebased to latest next tree
>  Resolved the conflicts with vf610 soc patch
> 
> V2:
>  Keep i.MX1/2/3/5 cpu type for completness
>  Correct return value in patch 1/3
>  use CONFIG_ARM to guard compile soc-imx.c in patch 3/3
> 
> V1:
> https://patchwork.kernel.org/cover/11433689/
> RFC version :
> https://patchwork.kernel.org/cover/11336433/
> 
> Nothing changed in v1, just rename to formal patches
> 
> Shawn,
>  The original concern has been eliminated in RFC discussion,
>  so this patchset is ready to be in next.
> Thanks.
> 
> Follow i.MX8, move the soc device register code to drivers/soc/imx
> to simplify arch/arm/mach-imx/cpu.c
> 
> I planned to use similar logic as soc-imx8m.c to restructure soc-imx.c
> and merged the two files into one. But not sure, so still keep
> the logic in cpu.c.
> 
> There is one change is the platform devices are not under
> /sys/devices/soc0 after patch 1/4. Actually ARM64 platform
> devices are not under /sys/devices/soc0, such as i.MX8/8M.
> So it should not hurt to let the platform devices under platform dir.
> 
> Peng Fan (3):
>   ARM: imx: use device_initcall for imx_soc_device_init
>   ARM: imx: move cpu definitions into a header
>   soc: imx: move cpu code to drivers/soc/imx
> 
This patch series has the side effect of LS1021A platform now reporting
that it's part of "i.MX family".

caam driver relies on the SoC bus / SoC attributes (ID, family) to determine
if it's running on an i.MX SoC or other (Layerscape, QorIQ).

With this patch set, driver fails to probe on LS1021A:
[    5.998928] caam 1700000.crypto: No clock data provided for i.MX SoC
[    6.005306] caam: probe of 1700000.crypto failed with error -22

Horia
