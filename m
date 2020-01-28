Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D78C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC102173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DG/6lxIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgA1OsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:48:07 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:6314
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgA1OsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIeHtMwWIxYm639DNzTuUcJsCmjFh0+5P09SBXAz7fKznCgWhOvEaRLv3xfAAwAd4uc8GAJ6GTzT2q2q30wzoYMIcuJXD1LjkqpbEUJ7kVBY9+JVmSH5D9ChmBrsErp+UNPjpzQgVVHGGMyGWLOTMZrheD3V/nN3BgakzXVFG6+jOmeKb70ickVthzL8ZiMsaPj2vM60cSwrnQSkVlGTU6ViP95hj2GBytM0+r8d3P2l0YAqgrgtkl8uM0beDDI2j7D0GaZY4mfD3X14QIFQrqx9qVjsK8WrKzoJWY69dZXmTTXx5Xf5s6wfABUR4LuBIEuyssQvE12ivy/XFqDmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiyDTYxr1XOqgjnvzJaRqcWcUU92825C3UPpV3vUFjU=;
 b=IybQ6fZ4N1hOn96ikrhgHAwArAuCo45ws1ZbWozmaPH4wDcYrTUxR5GZa+/pRQv/s25pZi3kyExsNZprM9zx/Er3wROmrPycgW42PrkSo1/0dzp5wkvuS9eW2yluYcFNajYS1IYh6eSXiYQN5VX+K7JDMvyWVl7ajYeLBwUcei7WDcP0FNAG1LP9SMy3u1u0tdv7tjy7v7w64lNJ5h/kvT97Gni+zUCkrZgMNH35GcWoSpD+qCikxtVOhUVcgEtC7TPm3c98yKxLWDpGI5c6EDQFckGC9Y9Il+aZAog8Y0wi11mweCLDMxz/D+CKUV75TIoW62SVzwoUCsH4DtHEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiyDTYxr1XOqgjnvzJaRqcWcUU92825C3UPpV3vUFjU=;
 b=DG/6lxICmLRtLA5+J1w6azrJ1UyqeulVoyVlRklpTj8vwvVWNFwbCmrzt1NotsYIU88TqO33ZYmOiAokvwH2ZwfqEu+xWF1F62YM9f93bRhMPaXdF+C941UTrjE62IpmD6yP0TkPfPN0IZ0MSwyuInwiGAJfS9RQzeKVHWAJkIE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.121.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.26; Tue, 28 Jan 2020 14:47:59 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 14:47:59 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH V4 0/4] clk: imx: imx8m: introduce
 imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V4 0/4] clk: imx: imx8m: introduce
 imx8m_clk_hw_composite_core
Thread-Index: AQHV1ZvHklheOLKStkK+igJOK/WgpA==
Date:   Tue, 28 Jan 2020 14:47:59 +0000
Message-ID: <VI1PR04MB7023201D8DF545198F1B6CB6EE0A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad4081eb-d4c4-4209-fc29-08d7a40111ce
x-ms-traffictypediagnostic: VI1PR04MB5967:|VI1PR04MB5967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5967907B8EBBDE392CBA3B10EE0A0@VI1PR04MB5967.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(33656002)(44832011)(26005)(6636002)(186003)(53546011)(8936002)(6506007)(316002)(478600001)(2906002)(54906003)(86362001)(81166006)(7696005)(6862004)(4326008)(71200400001)(55016002)(9686003)(8676002)(81156014)(91956017)(66556008)(76116006)(66946007)(5660300002)(66446008)(66476007)(52536014)(64756008)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5967;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z12dsSMbbKmP0r+XCPGDfPXMWBwu0hXF9gbd5U3KNvUvcMI5CVCKBZt3hp1WaeJuYlNh/y2XkKIH9FeNpHUumgxQog+6eOS5bWtjIxZ03/pYzBfsjnhrhrRWydrtgkSC2f2xJgMQK+xFj6x+Bj/prS8XvX19cKIYK9XdepIal5BQehDCgQAvJpm8Im5a1nJFA0syW/1d0nMIVq5eO5WM3PxL4mEb06vzgxxGlPweFlO2KVDauvK3D+oc0w2RXU/l9txF1vCEAhrlut2te6FPjF/8TM+JqHCrWMDzBQBAmBx2X0a8Q9H8BCwyUSmk93RevfCSlNCLY6ID4kKBZt2yvCF3SXQ6eUBVFt0HY7335d78kYsCjpMJ+RZ7qwxirLi+lYacX7RYDJXe+lveoGk9QOCmShyht92BMedEX2qSnafQV7GLP248ZXnEP7r1bHyaZkzyF2a8hS3u4wysuAVrjiXbHI3CZVBOzKFe8b6QfTVqJeo2GM2HMbr5BuA+FIQeCytOW3cX7zkmCmMbOsxAow==
x-ms-exchange-antispam-messagedata: i+iP59Zfn9iSwCsalRtfHaVxaNu6E/LuKTX3cfIQIcbbKIaUjz23wkw6n0AI/RkTkMMWbdQGO/LUJSW+8bUWnqzFP5JiuAKiAWkBfNq39IJSvb1U6M2diEbtUIjFrYSNyYzUIofj+Oz3IpRFHuT/Xw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4081eb-d4c4-4209-fc29-08d7a40111ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 14:47:59.5640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WN22ZnQr1aSk0pszp9Hz5gHf//oBWodo9/56Y7X1fePuzULqj6+u2S5Si1qni9iC2E9GhG0bem6FwG/77BVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2020 07:28, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
> V4:=0A=
>   Per Leonard's comments, added new definitions and  _SRC/CG/DIV are=0A=
>   alias to the new definition.=0A=
>   Did boot test on i.MX8MQ/M/N-EVK=0A=
> =0A=
> V3:=0A=
>   Add CLK_SET_RATE_NO_REPARENT and CLK_OPS_PARENT_ENABLE for core=0A=
>   Avoid break DT for i.MX8MQ=0A=
> =0A=
> V2:=0A=
>   Rename imx8m_clk_hw_core_composite to imx8m_clk_hw_composite_core=0A=
>   Add Abel's tag=0A=
> =0A=
> To i.MX8M family, there are different types of clock slices,=0A=
> bus/core/ip and etc. Currently, the imx8m_clk_hw_composite=0A=
> api could only handle bus and ip clock slice, it could=0A=
> not handle core slice. The difference is core slice not have=0A=
> pre divider and the width of post divider is 3 bits.=0A=
> =0A=
> To simplify code and reuse imx8m_clk_hw_composite, introduce a=0A=
> flag IMX_COMPOSITE_CORE to differentiate the slices.=0A=
> =0A=
> With this new helper, we could simplify i.MX8M SoC clk drivers.=0A=
> =0A=
> =0A=
> Peng Fan (4):=0A=
>    clk: imx: composite-8m: add imx8m_clk_hw_composite_core=0A=
>    clk: imx: imx8mq: use imx8m_clk_hw_composite_core=0A=
>    clk: imx: imx8mm: use imx8m_clk_hw_composite_core=0A=
>    clk: imx: imx8mn: use imx8m_clk_hw_composite_core=0A=
> =0A=
>   drivers/clk/imx/clk-composite-8m.c       | 18 ++++++++++++----=0A=
>   drivers/clk/imx/clk-imx8mm.c             | 35 +++++++++++++++++++------=
-------=0A=
>   drivers/clk/imx/clk-imx8mn.c             | 19 +++++++++--------=0A=
>   drivers/clk/imx/clk-imx8mq.c             | 34 +++++++++++++++++--------=
------=0A=
>   drivers/clk/imx/clk.h                    | 13 ++++++++++--=0A=
>   include/dt-bindings/clock/imx8mm-clock.h |  7 ++++++-=0A=
>   include/dt-bindings/clock/imx8mn-clock.h |  5 ++++-=0A=
>   include/dt-bindings/clock/imx8mq-clock.h |  7 ++++++-=0A=
>   8 files changed, 92 insertions(+), 46 deletions(-)=0A=
> =0A=
=0A=
