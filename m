Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D42C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D89F2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eNybmrkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgDXTaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:30:21 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:61063
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgDXTaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:30:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBBO1xGjxQxdgI4ygAZohKBC36M7BDo6FLBl/hKZBGay4Yx+BymAdvAFCDv0Igb3HYOlrpUHBTVnDDh/K2A1LNmWro4r53T6bDtJXY3nN1QWn9W2+mUBWRf8sFJ6XYEQrbp6thV+znzFOJ8N5n0C55gtMfnYimN+zPc7TtpxT6vCDYiA35okMRuIx+03G6lSlguo+Z/nOs8Mtbt8RMe8PXKPOPQD/OE78s/0ZXbwGUUa28LT7vIxE0XQtmWJR9Vwb4Y8mB1iWyghKWzoxjWOpj12aVF1no2njHRx1uZxEApSKzZTsPEZTfHFWSDJmcXBvCZsw6O94RDkOrpVFSnajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qKlRQqAB1bUXMrfvUiqzHpw4g9p8Nvk0sfgkgiaeGs=;
 b=S8kIKYoPsyY3ggHTuNTAQcFMzF/6twc4FdqXx/n4Of/gg8WLECUcXNNTiG2dBJTIJ0wQUhcEi2/McVGskSM167MBvrFc0HUHXce/VOp6de5S+TyGClNEr/MFqiHD3V74nYN/jqhVHDGGA4xY/nBZUZuLPnUBO+Wh1Szby9dS+RTqzL3RwLOaWqpLBECCAt1VQbI/Wuo+tMbKVsuZmq0e0g30HRdeq9XFZxd9QGiUnEU5riCi/G3U9sGN8z6l1iK/p2YHHlbWO0rLmtPxzPQamqIEPBnhRa+qJP2JSOfTiVxjiDBc+WEfL+t6q4uo/D8exlC2Zv5XsVqUBcM9tAHd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qKlRQqAB1bUXMrfvUiqzHpw4g9p8Nvk0sfgkgiaeGs=;
 b=eNybmrkEIe2ZKhuJuF7YkRynVH85oSIZCVCTf/2QcRxtFv6b8HuXFfBQ6HY7eXyDvCP0dtCvAjLTZXmuZSN+Q72qEYfIywwANT/q2cy5xprSOo6g0t0RsoYFpX+k6Gpxpn/LBcyV867v3VLZ2ylzRSxNdztDgFYgCLnhu4djZjg=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 by VI1PR04MB5056.eurprd04.prod.outlook.com (2603:10a6:803:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 19:30:16 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::8de5:8c61:6e4d:9fe9%9]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 19:30:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Topic: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Index: AQHV+Fizr+1km/QCtUyii39f5J5PvQ==
Date:   Fri, 24 Apr 2020 19:30:16 +0000
Message-ID: <VI1PR04MB6941A5E995F36689CB2A098DEED00@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <DB6PR0402MB27608E9A3D273DCFF6D90AE888D60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.3.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa211548-22d8-4d0d-d073-08d7e885eacf
x-ms-traffictypediagnostic: VI1PR04MB5056:|VI1PR04MB5056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB50566DAEDCF88747671951EBEED00@VI1PR04MB5056.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(81156014)(316002)(5660300002)(4326008)(52536014)(8936002)(8676002)(66946007)(33656002)(66556008)(91956017)(66446008)(66476007)(86362001)(26005)(2906002)(71200400001)(64756008)(76116006)(44832011)(9686003)(6506007)(53546011)(7696005)(186003)(7416002)(54906003)(478600001)(110136005)(55016002)(966005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74Ks0nZs/rs8BjDB+MFDHxoSBk5b2fmzSgCkw4LFDJEqYCTqV+3yB2mS8t/ENTU9spRJqdJENX/B0vRJ4JBWfcSHhEAvvuKmbW2kLN2spfURN8qyOaeta7mfUFqCRoYKqRXA/7rt81gEttCgcEJdCwdZ/ZWqKvsLAyIyN11giOSaPd3T3jTphNMk/wa0FmGlfqNw8jdudeuwDiz/enGvL1YqmMOBQGNaTIioq4r/BNwSVGYoY7PCaMZb+2fi6Z9xAbCRkqdpykW8f2h+pTD56PiCSLlbYmyu2GWhhPhDRir6I9v+eB44JEqE4LNRJ9rUtfU6jsHezA6f0bDBHeJnx97MX70ao+ZAO8BjwCPPG8aWwfYvL1VSTQwGncXkCbArGOfstiOhAS0/EEPLdwnpF5wP1KAbTwu/emjsSZbJfga1LiaxH2k23RSXSdjuj7+v0leY5K8baHMZQrdQCN3Tu8H7aNIpzKogdl5q9qNtVS8zG4nAYEZNA4uMCviTd1viHOEXcZM/4XwmzEimPTpJ4A==
x-ms-exchange-antispam-messagedata: ohEOcDTqPq3VGspBDBpf8Bi6gKHpBkvunXaQVXyIVBJAwm30Z8tXPQ6LftFALO8VZIK7dBhRsmshteA4z0j4SnCZxh/bh2I2I+A9dEZUk5RRwN4m++eJhRAzrYqO+asENiUNXOPqJk0R3tGM5W+wJA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa211548-22d8-4d0d-d073-08d7e885eacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 19:30:16.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8F5wskCsyKqR9tJO4WmC4LRTsx7A1roSVcrPPO7wf58oSLb/CeSWNYwNQm6Ao9maXSvDDjqYiHJoJaD1DK227w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-18 4:45 PM, Peng Fan wrote:=0A=
>> Subject: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M=0A=
> =0A=
> Ping...=0A=
> =0A=
> Thanks,=0A=
> Peng.=0A=
> =0A=
>>=0A=
>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>=0A=
>> Patches based on for-next=0A=
>>=0A=
>> V2:=0A=
>>   Patch 7, drop wait after write, add one line comment for write twice=
=0A=
>>=0A=
>> V1:=0A=
>> Patch 1,2 is to fix the lockdep warning reported by Leonard Patch 3 is t=
o fix pll=0A=
>> mux bit Patch 4 is align with other i.MX8M using gate Patch 5 is to simp=
lify=0A=
>> i.MX8MP clk root using composite=0A=
>>=0A=
>> Patch 3~5 is actually https://patchwork.kernel.org/patch/11402761/=0A=
>> with a minimal change to patch 5 here.=0A=
>>=0A=
>> Patch 6 is to use composite core clk for A53 clk root Patch 7,8,9 is act=
ually to=0A=
>> fix CORE/BUS clk slice issue.=0A=
>>   This issue is triggerred after we update U-Boot to include  the A53 cl=
k fixes=0A=
>> to sources from PLL, not from A53 root clk,  because of the signoff timi=
ng is=0A=
>> 1GHz. U-Boot set the A53 root  mux to 2, sys pll2 500MHz. Kernel will se=
t=0A=
>> the A53 root mux to  4, sys pll1 800MHz, then gate off sys pll2 500MHz. =
Then=0A=
>> kernel  will gate off A53 root because clk_ignore_unsed, A53 directly so=
urces=0A=
>> PLL, so it is ok to gate off A53 root. However when gate off A53  root c=
lk,=0A=
>> system hang, because the original mux sys pll2 500MHz  gated off with=0A=
>> CLK_OPS_PARENT_ENABLE flag.=0A=
>>=0A=
>>   It is lucky that we not met issue for other core/bus clk slice  except=
 A53=0A=
>> ROOT core slice. But it is always triggerred after  U-Boot and Linux bot=
h=0A=
>> switch to use ARM PLL for A53 core, but  have different mux settings for=
 A53=0A=
>> root clk slice.=0A=
>>=0A=
>>   So the three patches is to address this issue.=0A=
>>=0A=
>> Patch 10 is make memrepair as critical.=0A=
>>=0A=
>> Peng Fan (10):=0A=
>>    arm64: dts: imx8m: assign clocks for A53=0A=
>>    clk: imx8m: drop clk_hw_set_parent for A53=0A=
>>    clk: imx: imx8mp: fix pll mux bit=0A=
>>    clk: imx8mp: Define gates for pll1/2 fixed dividers=0A=
>>    clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code=0A=
>>    clk: imx8m: migrate A53 clk root to use composite core=0A=
>>    clk: imx: add mux ops for i.MX8M composite clk=0A=
>>    clk: imx: add imx8m_clk_hw_composite_bus=0A=
>>    clk: imx: use imx8m_clk_hw_composite_bus for i.MX8M bus clk slice=0A=
>>    clk: imx8mp: mark memrepair clock as critical=0A=
>>=0A=
>>   arch/arm64/boot/dts/freescale/imx8mm.dtsi |  10 +-=0A=
>> arch/arm64/boot/dts/freescale/imx8mn.dtsi |  10 +-=0A=
>> arch/arm64/boot/dts/freescale/imx8mp.dtsi |  11 ++-=0A=
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi |   9 +-=0A=
>>   drivers/clk/imx/clk-composite-8m.c        |  67 ++++++++++++-=0A=
>>   drivers/clk/imx/clk-imx8mm.c              |  27 +++---=0A=
>>   drivers/clk/imx/clk-imx8mn.c              |  25 +++--=0A=
>>   drivers/clk/imx/clk-imx8mp.c              | 150=0A=
>> +++++++++++++++---------------=0A=
>>   drivers/clk/imx/clk-imx8mq.c              |  29 +++---=0A=
>>   drivers/clk/imx/clk.h                     |   7 ++=0A=
>>   include/dt-bindings/clock/imx8mp-clock.h  |  28 +++++-=0A=
>>   11 files changed, 240 insertions(+), 133 deletions(-)=0A=
=0A=
For 1-6 and 10:=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
