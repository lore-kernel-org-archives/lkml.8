Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A93C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477A8222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1B5QH2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgAOLsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:48:16 -0500
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:5547
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729892AbgAOLsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:48:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjgVgdj7x7j5PQxdixV5fzgXExsIwrEAmo5/l6dh2VFxGstAOd6er+a/sPppl/Db4Jood4RIFMPXSyp1xg/Zcogu62YG5rK034VY0knvvcHEKXghATPDD7NSn/fZSdzWOE9f5cgDqRwmoedA49lgl8xtUeDuUOJjMV02pJIfFwv8xIQIF0qwBInaQ+cz/Av+Ddscld+J2auuIraoDZnRSLOYDI1dIb7mt9SJ0L9QVL4F+81s0EMuta5YdaoAUdfZNihLQhiOhjH5iLO9oxRtIow1fSiR2QABHLDt8tQeac6F1FflcofeWN4KIkOHe2JcwsJ/03wcr5EHhE8v1Hi3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmEvxD35nBUYTKdZ6odL3f+pmh2ZfvjhV3YFzX2pMGs=;
 b=HVm2zop/g8RXhzBN6smkLBJDGcgb51VQzHokxHao+867uMv6eXE7l0JjsQ5EC+z90c87PhSmxOeeVGsn6bY58BPJ1ZfQ0SaRvGkfCAYrNVS/aBtqzPuU9NAbh4kTrSxDiAavppsETck50b3cH2q8eh2Isf3U2TQwDsLVtcgkvo0LNG+XLpuPWKVexIopyJ/s3KZqvrusdTPfyKaBc1ePu0FPz3PpRgkCSsNLolH6szUWI1JuIoHzYWWSPT1635gz6LSJY7WlucGwvTA0CIALOyXiy9mDG6gnG7xequQbqJAnGGjt5+iPS8QkKyXVzT2btjMbcikk+a/AYRcHsFh5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmEvxD35nBUYTKdZ6odL3f+pmh2ZfvjhV3YFzX2pMGs=;
 b=F1B5QH2bgax6nSpGlDTwKbasFVZhJ1fRuca2O5h8P+UlOwfwgDcOIBZ3dOxFn7PSskUpUrqTWJYsvEERZEhrQFu5QGtoTllEmqHPs6dnLiYIMfCa42LsCgke3wErUzd1LPIq1vid7FqRk7oa48yljQgqzEw8yY0Eehexnare+v0=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4351.eurprd04.prod.outlook.com (52.134.122.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 11:48:11 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 11:48:11 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
Subject: Re: [PATCH V2 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YVaHYUgIfOpEylrWn5NhhQ0A==
Date:   Wed, 15 Jan 2020 11:48:11 +0000
Message-ID: <VI1PR04MB7023D08F2C9F97C293695A05EE370@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
 <1578640411-16991-3-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023981770D458F6D1FB546FEE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20200115111205.GB29329@T480>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [78.96.82.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc608298-d1f3-4d43-bf5a-08d799b0cc3d
x-ms-traffictypediagnostic: VI1PR04MB4351:|VI1PR04MB4351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB43518C870136A9A0E07A2760EE370@VI1PR04MB4351.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(199004)(189003)(6636002)(71200400001)(54906003)(52536014)(5660300002)(110136005)(316002)(9686003)(55016002)(478600001)(44832011)(66556008)(66946007)(66446008)(76116006)(66476007)(33656002)(4326008)(64756008)(81166006)(186003)(8676002)(2906002)(26005)(81156014)(86362001)(6506007)(53546011)(8936002)(7696005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4351;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HxoQC5ASeIHiQDAksaruepEOntV0KSsryiqzOrt2MkTXMsHJYd7AE3PyAgBFpOsYkuWAwPcdYH4TOF0IU27+JPQGJPj0JmL7C7ja+dWWZfpvXoouliU9kZf6ZgS1SRPuuUWNqZe4YmbLd572ChwyiotIHR0+8b5knawC/ebHmIyNLwryrPIQcYQUCkGSSPaOLvamqyMQEeTPqjaQZAFr4rjEntiptWCFP3VZrLeJ8QLLBE6RN3Ca9vK/x7PwFn/d1UnL6/3Mzg+RO8lF6BFWQ1aE8dBGtkYrotrDXWyrlrtJDet4jdQeZHO6QNBT1GgJxbOjhCMX74VXwZqE5C9KNy4nx8n/++flR9PP1qUdTx6xgpwoe77JD6HxXXjGeroHcQoHVXUBqzlXeVL9zCYqUPs5j/XIj68jysAUZoPi+UbvTMFtesI2UTXooYMaK0ZaHfQNlAzhK8jRB8gdPnek1TG7N8wr/oyba50ahASEkzprhdlve9VPCdW51XBbTeQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc608298-d1f3-4d43-bf5a-08d799b0cc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 11:48:11.4992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvZ6z6uMufHaqbtyzNEhL4f/S9TOKY7kLqcsE38HEzmE4N9zFPueAtV0q2z7PtbyLiNaZutrefcInMDMFfc5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-15 1:12 PM, Shawn Guo wrote:=0A=
> On Tue, Jan 14, 2020 at 04:49:20PM +0000, Leonard Crestez wrote:=0A=
>> On 10.01.2020 09:17, Peng Fan wrote:=0A=
>>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>>=0A=
>>> Use imx8m_clk_hw_composite_core to simplify code.=0A=
>>>=0A=
>>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
>>> ---=0A=
>>>    drivers/clk/imx/clk-imx8mq.c | 19 +++++--------------=0A=
>>>    1 file changed, 5 insertions(+), 14 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.=
c=0A=
>>> index 4c0edca1a6d0..b031183ff427 100644=0A=
>>> --- a/drivers/clk/imx/clk-imx8mq.c=0A=
>>> +++ b/drivers/clk/imx/clk-imx8mq.c=0A=
>>> @@ -403,22 +403,13 @@ static int imx8mq_clocks_probe(struct platform_de=
vice *pdev)=0A=
>>>    =0A=
>>>    	/* CORE */=0A=
>>>    	hws[IMX8MQ_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0=
x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));=0A=
>>> -	hws[IMX8MQ_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x808=
0, 24, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));=0A=
>>> -	hws[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100,=
 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));=0A=
>>> -	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D imx_clk_hw_mux2("gpu_core_src", base=
 + 0x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));=
=0A=
>>> -	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_hw_mux2("gpu_shader_src", =
base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader=
_sels));=0A=
>>> -=0A=
>>>    	hws[IMX8MQ_CLK_A53_CG] =3D imx_clk_hw_gate3_flags("arm_a53_cg", "ar=
m_a53_src", base + 0x8000, 28, CLK_IS_CRITICAL);=0A=
>>> -	hws[IMX8MQ_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src",=
 base + 0x8080, 28);=0A=
>>> -	hws[IMX8MQ_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base=
 + 0x8100, 28);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg", "gpu_=
core_src", base + 0x8180, 28);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D imx_clk_hw_gate3("gpu_shader_cg", "=
gpu_shader_src", base + 0x8200, 28);=0A=
>>> -=0A=
>>>    	hws[IMX8MQ_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm=
_a53_cg", base + 0x8000, 0, 3);=0A=
>>> -	hws[IMX8MQ_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_=
cg", base + 0x8080, 0, 3);=0A=
>>> -	hws[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", =
base + 0x8100, 0, 3);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx_clk_hw_divider2("gpu_core_div", =
"gpu_core_cg", base + 0x8180, 0, 3);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx_clk_hw_divider2("gpu_shader_di=
v", "gpu_shader_cg", base + 0x8200, 0, 3);=0A=
>>> +=0A=
>>> +	hws[IMX8MQ_CLK_M4_DIV] =3D imx8m_clk_hw_composite_core("arm_m4_div", =
imx8mq_arm_m4_sels, base + 0x8080);=0A=
>>> +	hws[IMX8MQ_CLK_VPU_DIV] =3D imx8m_clk_hw_composite_core("vpu_div", im=
x8mq_vpu_sels, base + 0x8100);=0A=
>>> +	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx8m_clk_hw_composite_core("gpu_cor=
e_div", imx8mq_gpu_core_sels, base + 0x8180);=0A=
>>> +	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx8m_clk_hw_composite("gpu_shader=
_div", imx8mq_gpu_shader_sels, base + 0x8200);=0A=
>>>    =0A=
>>>    	/* BUS */=0A=
>>>    	hws[IMX8MQ_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_=
axi", imx8mq_main_axi_sels, base + 0x8800);=0A=
>>=0A=
>> Collapsing _SRC _CG into _DIV is an useful simplification but it=0A=
>> technically breaks DT compatibility rules.=0A=
>>=0A=
>> Inside imx8mq.dtsi there are clock assignments for=0A=
>> IMX8MQ_CLK_GPU_CORE_SRC and IMX8MQ_CLK_GPU_SHADER_SRC which no longer=0A=
>> exist so those assignments don't take effect.=0A=
> =0A=
> We do not want to break existing DTBs for this case.  Patches dropped.=0A=
=0A=
Sorry. I think DT compatibility could be maintained by adding =0A=
assignments like this:=0A=
=0A=
	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D hws[IMX8MQ_CLK_GPU_CORE_DIV];=0A=
=0A=
If all the old clocks are aliased to the new composite then all =0A=
currently valid set_rate and set_parent calls would still have the same =0A=
effect.=0A=
=0A=
It would also mean that you can set_rate on the mux and set_parent on =0A=
the div but that should be harmless: an enhancement instead of a =0A=
compat-breaking change.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
