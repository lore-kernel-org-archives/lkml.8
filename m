Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A83DC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8772084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OukCMUra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgANALx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:11:53 -0500
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:47553
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728641AbgANALx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuLuhEajycc8oD/8GCqqNB2r7PDbCql614/wqw/3WZ39mWArdn8mU5ZT4O5ajD/sY/RF9zmpRiNdG0sNNmf/WUZ5STELQ+F9RuTZ+nuqDPvnnsPDZhh2/45QFGX0JJM+q9FYNRVW/p7eKOWz6PCpOKD38q/EVMK3AQy9z1NHfq4g9kpq5myM64tFVenP61osQ9KFCV8Q7uvpAu/9rCcRtkfFpuUqn+57LW5HwqARHo4+Tn+h+yLiMaFixrjJtYBtwlRwJbuEwzTp6DtGBWn6W4NA62pWJds08Osf/jMiOGCwVjFTz1kIBN9Z1t3U08CkEuwqZm+uHH2Kt7uxwRbArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky4F/SUWAnzMk9SKKIMsqiDZS70SLre1zvgzxtY2Scc=;
 b=hv+ub9y2bqhmfZXDzjY3IZCZYFiMJPqdAtfytUHMpiyHD4T15Px496OjY02zZhsrDCgb6WdCwBHNPmZJu56pwftVMF5numlh18IW8faUru5BlYN+Z/Fid7l/gOZX5jYmxKzSnp4doFnwxNe8OkTMnFs+/8wm99SjIzfyC0zRSMpWJMr6v0s62OgFXm9++qDzB3HBiIr4/p8zAzCYvmfTxBCqc6w9ZiIZn/p2wP1oB4lmII30DV0TI82n/MAUO6x/2pFrsOWD9kzyLVJi0ms2G6Hy6B5OiP6JP8i3ax63/2oExkTIP+EAgpBeOBeYTQ4iEzON7dDhoY7N0xTFOSP6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky4F/SUWAnzMk9SKKIMsqiDZS70SLre1zvgzxtY2Scc=;
 b=OukCMUraG/XfMFPUv+ggYDtqMpWIcGX0KgLoRgry0x1KCdQQ5vBkxjXIdu4ChT9y59EgEuWIEl4dmHUcMbGYTTE67oY6tPr1g2n1ZQezDld4dNS7xJ9C0sF9mCPoOwl2hSeQdhuZ7RENAcgM4UOjJq9BHJsPHRqQPJ2dDCXAzCk=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4957.eurprd04.prod.outlook.com (20.177.48.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 00:11:48 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 00:11:48 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
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
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/3] clk: imx: pll14xx: avoid modify dram pll
Thread-Topic: [PATCH 1/3] clk: imx: pll14xx: avoid modify dram pll
Thread-Index: AQHVvvFWN8I9RWVOxUWrR8yNvTfk6g==
Date:   Tue, 14 Jan 2020 00:11:48 +0000
Message-ID: <VI1PR04MB7023F51C86DB71DD22F7761BEE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
 <1577696903-27870-2-git-send-email-peng.fan@nxp.com>
 <20200112023248.GY4456@T480>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ff15e71-21a6-4294-cdc0-08d79886594c
x-ms-traffictypediagnostic: VI1PR04MB4957:|VI1PR04MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4957D64BA1B05D8521CDF97EEE340@VI1PR04MB4957.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(478600001)(33656002)(6636002)(4326008)(9686003)(44832011)(2906002)(71200400001)(54906003)(110136005)(55016002)(5660300002)(52536014)(8936002)(86362001)(81156014)(26005)(186003)(53546011)(7696005)(6506007)(81166006)(76116006)(91956017)(64756008)(66556008)(66446008)(66946007)(8676002)(66476007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4957;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8dKQMkWJ05Pd9kNTMs7XDntErB1cBpxQmPpenyp46llTLF0uNFtfJFwqmkDqfX//klGFev5fTukLQekz+HYgdK8vc0URa4bF4AsbWQ34ZZ/aOlH3Jl43KplxO88iPLSPwoXQbPlIJ0VMUj+mDUiR7UQSnQmqRF05OJbWpTQWHBIEhQEfrJazgymxqWcz0JEDRR8UOdKQQO3asKpEScLNWkJgRefO9V2quXby1Mgo5qpk0ToK2NVKQZ50VoOuHrUdO82188fPpSHeKIu+AFfBEnxDv08rRrady4GGeIlzGeY1obCCZE/8ohP41VPVhOc5oSQHxtYzHWGaYsMzwfbmsFovb4h+DiPb/R2xl2vx5S+DoDozCY0iIOpQrOyScmnPQ4d0wpE+9zpJqQZ+qnKm14coJk2sor0uSZro2IMsRnP0ZAG5m3xAjnECbU3TNi7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff15e71-21a6-4294-cdc0-08d79886594c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 00:11:48.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3KXKuIlL+P56/AnWSHn7t4W8puwQEfrV8uPQAec57w4ArgNBOLFQc7beOyW9mg6nxiOFu0bVecTatZtOBKX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.2020 04:33, Shawn Guo wrote:=0A=
> On Mon, Dec 30, 2019 at 09:13:00AM +0000, Peng Fan wrote:=0A=
>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>=0A=
>> The dram pll is only expected to be modified in firmware,=0A=
>> so we should only support read clk frequency in Linux Kernel.=0A=
>>=0A=
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> @Leonard, do you agree?=0A=
=0A=
I'm not sure this improves anything.=0A=
=0A=
As far as I understand the only way this could be a problem is if a =0A=
driver deliberately does clk_set_rate on the dram pll and this shouldn't =
=0A=
happen.=0A=
=0A=
There is an infinite number of ways for clock consumers to break the =0A=
system by manipulating clocks and providers don't need to guard against =0A=
every scenario.=0A=
=0A=
>> ---=0A=
>>   drivers/clk/imx/clk-pll14xx.c | 11 ++++++++---=0A=
>>   1 file changed, 8 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx=
.c=0A=
>> index 5b0519a81a7a..9288b21d4d59 100644=0A=
>> --- a/drivers/clk/imx/clk-pll14xx.c=0A=
>> +++ b/drivers/clk/imx/clk-pll14xx.c=0A=
>> @@ -69,8 +69,6 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {=0A=
>>   =0A=
>>   struct imx_pll14xx_clk imx_1443x_dram_pll =3D {=0A=
>>   	.type =3D PLL_1443X,=0A=
>> -	.rate_table =3D imx_pll1443x_tbl,=0A=
>> -	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),=0A=
>>   	.flags =3D CLK_GET_RATE_NOCACHE,=0A=
>>   };=0A=
>>   =0A=
>> @@ -376,6 +374,10 @@ static const struct clk_ops clk_pll1443x_ops =3D {=
=0A=
>>   	.set_rate	=3D clk_pll1443x_set_rate,=0A=
>>   };=0A=
>>   =0A=
>> +static const struct clk_ops clk_pll1443x_min_ops =3D {=0A=
>> +	.recalc_rate	=3D clk_pll1443x_recalc_rate,=0A=
>> +};=0A=
>> +=0A=
>>   struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent=
_name,=0A=
>>   				  void __iomem *base,=0A=
>>   				  const struct imx_pll14xx_clk *pll_clk)=0A=
>> @@ -403,7 +405,10 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name,=
 const char *parent_name,=0A=
>>   			init.ops =3D &clk_pll1416x_ops;=0A=
>>   		break;=0A=
>>   	case PLL_1443X:=0A=
>> -		init.ops =3D &clk_pll1443x_ops;=0A=
>> +		if (!pll_clk->rate_table)=0A=
>> +			init.ops =3D &clk_pll1443x_min_ops;=0A=
>> +		else=0A=
>> +			init.ops =3D &clk_pll1443x_ops;=0A=
>>   		break;=0A=
>>   	default:=0A=
>>   		pr_err("%s: Unknown pll type for pll clk %s\n",=0A=
