Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67566C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3405921835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kcftFNee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgATMpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:45:08 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:15501
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728852AbgATMpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:45:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT8JgGDSY8g068ANVrAMVlFQy0om7Hf4RwHlCuLm4En1/pTivYE9kFLEtkATnzdBJTbwcY5D2lmUNim4yEYBCd3S3Dk7jUq3+9GyJt5RCQFm11PEWA1DXOc4fg7q8zDqcKQb4OySq+g5fyzONqHzqzeB+8CFgLmicsHiN2pJv8WLqY86FsDILrGEeOn3cZtHj0H9IRfqjS5wYp+8aS/48jOEBFEqWi/+uh7Alt+3xITrKZMHIMKKbyMZtsVRTpYU/Q4hzr2YIDsHczu96+82IPCjWG+JspEJ+IsZhvD3ddOU83DvjAcwbd1zYR5YgThf8Tf6DUL50Qoxie/t/7hT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvbD91ZAlLfkkhIX2Uwkv3c0T4qOl5Zo0pGMo4d3kJ4=;
 b=Ul8DMfql8uVozl8gW1SoYZLnLdLZ0NwXisL3S3pp66PcHprSltSZdamU8aL12rHVOjnqSzxidawUnijqpDvDIVWySOOtJvHXlqA084aYyhC/x5cIOd9jUwRjvwQh1yiwVyEOrqE+pUKGXrjHPQrcqLjpMgn/6rTAsaUCBKEA3ZLLECXjUOdTvOQXhA8XmgEEn4gwA9ogZHLpf+xthUyu9A5p7JohH+eGIhvAaO9TLdnh0aftNY3PfrEUXOwebqSVBe+ujqu/jkeLZgXCSmew7cpES5269kBBEzyEF5w7mR0YWPVns6AShau7PTQkFpx/ICPr4Lu/PIet2QgX7MlDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvbD91ZAlLfkkhIX2Uwkv3c0T4qOl5Zo0pGMo4d3kJ4=;
 b=kcftFNee4HloLHxa3P/tyWWcO0w/O/VicXAeM9hJLomrTdItfOFMOlOxUUyh1qkL6CkssCUkvdzJtDvjOzJPBCxr8SQx/ndXPrXnr/XZqQJjFPLbLpqshrIRUlVnF5rrC1uxS+1P8kjnpqfxr6IhDroSC/EzDN1YhPBrsqDkJyg=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4365.eurprd04.prod.outlook.com (52.134.122.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Mon, 20 Jan 2020 12:45:03 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 12:45:03 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] soc: imx: increase build coverage for imx8 soc driver
Thread-Topic: [PATCH 0/4] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Index: AQHVzB/hVXSait8oKkG3c6qn/lfwPw==
Date:   Mon, 20 Jan 2020 12:45:03 +0000
Message-ID: <VI1PR04MB70231E81AB33489264502009EE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1579146280-1750-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75f03ec9-99eb-4d71-dac5-08d79da69203
x-ms-traffictypediagnostic: VI1PR04MB4365:|VI1PR04MB4365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4365A8EE3D0997DA4FBAF3CBEE320@VI1PR04MB4365.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(8936002)(478600001)(81156014)(9686003)(71200400001)(55016002)(81166006)(54906003)(8676002)(316002)(110136005)(86362001)(53546011)(186003)(6506007)(7416002)(33656002)(5660300002)(44832011)(66446008)(64756008)(2906002)(4326008)(66556008)(66476007)(52536014)(7696005)(66946007)(91956017)(76116006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4365;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rD01SqhokGuLJWzwRl3hwSD61d4P09VIWUmm6uO1we1PYbX/PwtRwp62+0/V0CkOIbQPkV13S72fUGTWd3eiv4sjFHTm11gHmbNg/eqVhgM1m95u3p75+or9B+CD6azRGgz5+0sgL+R8s2/nOui1YDUVh71RH2+Jrvi305M1LdE6B0qLMInTE9k7n7U7E4/d1Y135tZqjr3a3QzGcEleZuZqFCNHgP4ZMuIz4KyOWp/AsEjEyuS7GO5Kc/jq1pWa5pA5B5vyrx22rbouVMpQ2FWOvc6ZHmiSLZfVBP9tWiyKG2snXQXICBIXtxJVl886r9ObBlXKyXoS44UfPivJEtAvqDbr1xdk04y4OtxYk5qcdZLMpGql/SdL13FyUzjnuJZAtR4favEuRE4FpjOLyOYNahE13otsqow+EfPynGXWCrkF9Ikbvs4XhmFAeJQ
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f03ec9-99eb-4d71-dac5-08d79da69203
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 12:45:03.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ddm25sp5eT8ScQre+U168nfSQXaGhg+vEGk1HispNjgHfblfPx8ZOybTikZjAj/+cxbcC6x3u1G+eNHL1/67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.2020 05:48, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family=0A=
> Add SOC_IMX8M for build gate soc-imx8m.c=0A=
> Increase build coverage for i.MX SoC driver=0A=
> =0A=
> Peng Fan (4):=0A=
>    soc: imx: Kconfig: add SOC_IMX8M entry=0A=
>    arm64: defconfig: Enable CONFIG_SOC_IMX8M by default=0A=
>    soc: Makefile: increase build coverage for i.MX=0A=
>    soc: imx: Use CONFIG_SOC_IMX8M as build gate=0A=
> =0A=
>   arch/arm64/configs/defconfig                | 1 +=0A=
>   drivers/soc/Makefile                        | 2 +-=0A=
>   drivers/soc/imx/Kconfig                     | 8 ++++++++=0A=
>   drivers/soc/imx/Makefile                    | 2 +-=0A=
>   drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} | 0=0A=
>   5 files changed, 11 insertions(+), 2 deletions(-)=0A=
>   rename drivers/soc/imx/{soc-imx8.c =3D> soc-imx8m.c} (100%)=0A=
=0A=
I applied your patches and compiletest failed for me on x86:=0A=
=0A=
../drivers/soc/imx/gpcv2.c: In function =91imx_gpcv2_probe=92:=0A=
../drivers/soc/imx/gpcv2.c:561:21: error: =91SZ_4K=92 undeclared (first use=
 =0A=
in this function)=0A=
    .max_register   =3D SZ_4K,=0A=
                      ^~~~~=0A=
../drivers/soc/imx/gpcv2.c:561:21: note: each undeclared identifier is =0A=
reported only once for each function it appears in=0A=
=0A=
It seems that on x86 <linux/sizes.h> needs to be included explicitly =0A=
while on arm it is already included indirectly through arch headers. Fix =
=0A=
is very simple:=0A=
=0A=
diff --git drivers/soc/imx/gpcv2.c drivers/soc/imx/gpcv2.c=0A=
index b0dffb06c05d..6cf8a7a412bd 100644=0A=
--- drivers/soc/imx/gpcv2.c=0A=
+++ drivers/soc/imx/gpcv2.c=0A=
@@ -14,6 +14,7 @@=0A=
  #include <linux/pm_domain.h>=0A=
  #include <linux/regmap.h>=0A=
  #include <linux/regulator/consumer.h>=0A=
+#include <linux/sizes.h>=0A=
  #include <dt-bindings/power/imx7-power.h>=0A=
  #include <dt-bindings/power/imx8mq-power.h>=0A=
=0A=
---=0A=
=0A=
My test looks like this:=0A=
=0A=
make O=3Dbuild_compiletest defconfig=0A=
make O=3Dbuild_compiletest allmodconfig=0A=
echo CONFIG_COMPILE_TEST=3Dy >> build_compiletest/.config=0A=
make O=3Dbuild_compiletest "$@"=0A=
=0A=
Other than this:=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
