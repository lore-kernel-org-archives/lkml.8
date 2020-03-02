Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D260C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB6524699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HOLsZRju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCBBkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 20:40:36 -0500
Received: from mail-am6eur05hn2226.outbound.protection.outlook.com ([52.101.152.226]:60576
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbgCBBkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:40:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEFXFI3T6NA6HuRGn5S1Eakpa5JF+36ldj5CHmV9qdrdMfWgoizJuUs+YZS8iP9UZjf68MKeyz5A5dgAkFKP/e0BvcqQR5YLXpLSsKY6gXhjoq6sJ2ALEUExdVBRigTdBIi9pprJbJdWH3anFk6Ys2xv1vmObrimVw74TpmEA6pMVnFBrynUSfKSK1k9KJdNHKorFJjwIpzCZ2bsULYK8xtgebJG+VX+fhc9FYkdqEIUxNfxyapb22IW2s/AdnYNpImv55HUZI15zCxa7lmJZIRHCcWlmdwyvIP6fPMDLJQ/cgE5BmIbQPHZcmhylvqm2+J87aSn1B56VmM1h03ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ImO1cOZ65sfQgsppZIv20tIPoNepj2SbWDg9LSRoko=;
 b=ociKTbaDFasUlyAbxEyKaSto5pw5QVvxqZKCW2RL9ON4nxPuXSCY4yi1H1fopzzFwOxZ1YSqG2Ssxf02fLlU/6wIW3gcc7rZJo9X/8A6TZaBYbRQMxOPOBOLSOY28ONIA09knc96lOUNADxDEUNXLodGjcHB3ayfnCcLlg64dfD/G+gC6jz66EbOwZqBbw7JZn6oh/K8Zr9W7UHU5VA5hke7wuz1oczh0xvMq19087DSooZDjQ/zttEQ9BkVRiERK458KB41nwBBy+uXNAIwewI2KNharfNQtCVpyT9eM/o/rzCjCca3K9cAeXE0HzItCNISsbi5bwaejW2/zBPTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ImO1cOZ65sfQgsppZIv20tIPoNepj2SbWDg9LSRoko=;
 b=HOLsZRjuq4u6AaQ5uYu0adWB602+5j86uuoWjIQkND4ThpRCHetm6tU66fyOyt7kb9P3uyckCsB8aZAuDI1C1RLOSi+A9MGed8tssBR/jQEmjZY/31gmqxy/D+YHs7e/kpg/w3tx+bcNYoN0NTHfYAt8pwwEv8ZE2P4//MhiqDk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4308.eurprd04.prod.outlook.com (52.134.91.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Mon, 2 Mar 2020 01:40:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 01:40:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt
Thread-Topic: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt
Thread-Index: AQHV5vtt9q1uPmk0BESPnzoSAIGwTqg0mA0A
Date:   Mon, 2 Mar 2020 01:40:30 +0000
Message-ID: <AM0PR04MB4481FF78BB300729E59D6D8C88E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e3729ab-59e9-42d1-60c3-08d7be4ab19f
x-ms-traffictypediagnostic: AM0PR04MB4308:|AM0PR04MB4308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB43083DB35792FD11BBF26DBB88E70@AM0PR04MB4308.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:SPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(5660300002)(186003)(44832011)(6506007)(2906002)(966005)(478600001)(26005)(86362001)(33656002)(7416002)(71200400001)(81166006)(81156014)(8936002)(110136005)(54906003)(316002)(4326008)(8676002)(52536014)(7696005)(64756008)(76116006)(55016002)(66476007)(9686003)(66446008)(66556008)(66946007)(556354011);DIR:OUT;SFP:1501;SCL:5;SRVR:AM0PR04MB4308;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbOwP8GLFO1jyv51v4oaViT7XsfvmQ+ZW3aHcvz2S2GyiI6/UNWN6S0WfZB2nkyn+vde03dsFEIiECJ5Hfhg193lYhoVZS8rQjsQLEx/cNtXVDqSiCbrnkxaDGRdlTkNI2xlkpyzbeMHKG4m75T1krJ7b53b/WgyrXAfZGDr9uxaYVSbpRaJ2IQhj6VX/vXDEBOOPcL4zt1rt4Rb4Q9XhYSd4HSjGKUNNP1Sf6ydHv0CjIeY5511ELMaFGNANNqyaITgo6ywt9h1CUrQ3vig5kXbq2VdbYsZNcQN62OdOpGeX/A2thY/IFGXqC64UuOZzZtY/neFpNdAAhVBp8vUZSBA5uvSK3TcO6cIJ6DX8VAIJMeHjetGVYoOHbpot/cCN7burKkIudtE0GfagUnPptvmlcvyFEapWkcsjUOWp+SIfZnxaHbOIsj9cuS/e+K5/0J628DjeGlV7AXwpE4oZ/Ih35oFyRVbINZ0x7qUeZkEIgvGEF0ub4i545IPZu+T42lQJSDreagcmksSitqj4tNXUg3xmcWAzrHoDE2QUWanK86u7YvMzu2+HSk4aY059ZqNh3IQciP1WQOemTPQ1FGpgxkGQqMjLNzyCXByDh51fUJ8Ua5VZqiY4783FkTW0zkgTjKJ/8KSsmCHMv3OAn5bJY+v8KTXX+0quoLlquVs9ht73MFw+9gQ/opF3TQVoLulERHEYP9AFsTxQhzbpLwlgXT88BPJyDNe2nVDoQhQXV/dq665ZGMGa96QndXGEmsRi+G8okLv65jQ+gkWQTcYYwB3TSMntANzbhf1KJChLSHr6q2XY0li4iBZNI6PcJY0B/+7VvNfqDGYWZoeBUC9YesHJ6eD0tXnZaZmBWo=
x-ms-exchange-antispam-messagedata: 7kb8+dX0+z1dHySLn5TGA3RuhjUYQifKAFu/0RH9psKV5IJ7B1QxzoC7bsfkFdvGu9M7JJiO+YURvbm9Q+aA+TEVK/AEOs1Qgu0dVkeoxSn5JDfw0+QuYuGyhO3KI3JeHsEzeSzSbSfEXSoRoGp33w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3729ab-59e9-42d1-60c3-08d7be4ab19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 01:40:31.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ep0PvzWrN4X1ARWuMvrJo1jw9vUFVzUyJPL6ytmh58CiI7IGN4khPGtSCOtbjYmZyh3bq6QROPdBlT6r2lMJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt

Is it possible for you to pick up patch 1~8, 12? Or any comments?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V2:
>  Per Stephen's comments, I drop the cpuv2 clk code, and find another
> solution to change ARM clk  Included get_intermediate/target_intermedate
> for cpufreq-dt  Add i.MX7ULP intermedidate implementation.
>  Per Fabio's comments, disallow HSRUN when LDO enabled.
>  Add dt-bindings and pmc node
>=20
> V1:
>  https://patchwork.kernel.org/patch/11364609/
>=20
> This patchset aims to use cpufreq-dt for i.MX7ULP to avoid plaform specif=
ic
> cpufreq driver. i.MX7ULP has some specicial requirements to change ARM
> core clock, see patch 11/13,
> "cpufreq: imx-cpufreq-dt: support i.MX7ULP"
>=20
> Patch [1,2]/13: add pmc bindings and node. We need read pmc registers
>   to get system info.
> Patch [3-6]/13: i.MX7ULP clk pfd/pll code change to make sure to get the
>   expected pfd output clk. For RUN/HSRUN clock, we use API
>   imx_clk_hw_cpu to make sure RUN or HSRUN could not shutdown clock
> output.
>=20
> Patch [7-8]/13: Make sure we could run into HSRUN mode and not when LDO
>   enabled.
>=20
> Patch 9/13: let cpufred-dt could have get_intermediate/target_intermediat=
e
>   hooks to allow platform specific freq set.
>=20
> Patch [10-12]/13: i.MX7ULP cpufreq support
>=20
> Patch 13/13: Test dts, should not apply.
>=20
> For rpmsg/vitio part, I have posted patchset, if you wanna rpmsg regulato=
r:
> https://patchwork.kernel.org/cover/11390481/
>=20
> Anson Huang (1):
>   clk: imx: Fix division by zero warning on pfdv2
>=20
> Peng Fan (13):
>   dt-bindings: fsl: add i.MX7ULP PMC binding doc
>   ARM: dts: imx7ulp: add pmc node
>   clk: imx: pfdv2: switch to use determine_rate
>   clk: imx: pfdv2: determine best parent rate
>   clk: imx: pllv4: use prepare/unprepare
>   clk: imx7ulp: make it easy to change ARM core clk
>   ARM: imx: imx7ulp: support HSRUN mode
>   ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN
>   cpufreq: dt: Allow platform specific intermediate callbacks
>   cpufreq: Add i.MX7ULP to cpufreq-dt-platdev blacklist
>   cpufreq: imx-cpufreq-dt: support i.MX7ULP
>   ARM: imx7ulp: enable cpufreq
>   [Do not Apply] ARM: dts: imx7ulp: add cpu OPP points
>=20
>  .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 +++++++++
>  arch/arm/boot/dts/imx7ulp.dtsi                     | 38 ++++++++++
>  arch/arm/mach-imx/common.h                         |  1 +
>  arch/arm/mach-imx/cpuidle-imx7ulp.c                | 14 +++-
>  arch/arm/mach-imx/mach-imx7ulp.c                   |  3 +
>  arch/arm/mach-imx/pm-imx7ulp.c                     | 25 +++++++
>  drivers/clk/imx/clk-imx7ulp.c                      |  6 +-
>  drivers/clk/imx/clk-pfdv2.c                        | 61
> +++++++++++-----
>  drivers/clk/imx/clk-pllv4.c                        | 12 ++--
>  drivers/cpufreq/cpufreq-dt-platdev.c               |  1 +
>  drivers/cpufreq/cpufreq-dt.c                       |  4 ++
>  drivers/cpufreq/cpufreq-dt.h                       |  4 ++
>  drivers/cpufreq/imx-cpufreq-dt.c                   | 83
> +++++++++++++++++++++-
>  include/dt-bindings/clock/imx7ulp-clock.h          |  5 +-
>  14 files changed, 257 insertions(+), 32 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
>=20
> --
> 2.16.4

