Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A4C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790AA24679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+ZqSaio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0UdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:33:14 -0500
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:29573
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgA0UdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:33:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6lyFHrr1WOlWb1lmhVX+9TGK720UGdkmcbO6j3ow8HiT/2m/1+hn6d2+3oL8qw2+866VVG+XuOV0Gqqn+yhSw3JKqzAkC37oFS13uBJxShs4GhZCoW9njZkR6aNHnYRfUH+Uyd+J0JoyLw1kXD5Sz796zOHmS9v/dHsLRjUC/KKUc6CS6eOqi8VclljdO0F4bvhoCg4bG5khXQrUNlLMOfVcolmP7uHMre2FTHdNKwbmcbom5ZsEOoVvmen4XnGNNIxUugJvLZvgbk7AQTZJ66twKwAZ+Y+qluG23d4xuE9TNikDY6KGAT2ejLT65Uqu71nH65wu9dUmYABrRWATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8J72gs7OIqGCxvKth4+8QmAalkpO2xoPCm/b6ee6qo=;
 b=OhTVzzl1mMRCmYgw+2ecfBfKgdE3z33luBsVZYVuBLkTF3dyLGXCQ3zE2aipFr+S0gpzGc5wKh7YRr6ciknvZ/rOUyMEpBJIqNv7QJerj1dr5v+ALveZowTAzkJ9hWH0GGwq0NUP95MCpBBovvloZUzwkg/VVCRNoieTySEpPKlLlkIDmZwZajbyT+Xc7qUfLK1AgH01OgOrBNU1pM3Zb4pe3ZgT3EI9SeGT68mo539okFTIpENqofRZzfMGtY6qLRK0kWVhgLP/ryyDbMffq/Gv9XuyyAP2fOW6x9Va6daBDJ7TjQZzwNdeNi8Juoj7MEUi7STCbISwLMYoO4iLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8J72gs7OIqGCxvKth4+8QmAalkpO2xoPCm/b6ee6qo=;
 b=V+ZqSaioRV436hv33gaikX5Ra005MQ4EyDAk9/Sanp133T718boglEHmJMeiFg8tXy2o33gk2VqFRBAXMuH1UZ8XbT82/pAjss1XB37sND6pCaQG2gAHNC3NyfJ+YSfNbbcHp7Ut7sW9r3dQtGb7ikZgMTv68G+2Xzk/rFvCbNA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7184.eurprd04.prod.outlook.com (10.186.157.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 20:33:10 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58c5:f02f:2211:4953%7]) with mapi id 15.20.2665.026; Mon, 27 Jan 2020
 20:33:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
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
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V3 2/4] clk: imx: imx8mq: use imx8m_clk_hw_composite_core
Thread-Index: AQHVzBLhUkGtl3RwMUeoFEsar3ylZA==
Date:   Mon, 27 Jan 2020 20:33:10 +0000
Message-ID: <VI1PR04MB7023DD8E3D07543FB8F5CD50EE0B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1579140562-8060-1-git-send-email-peng.fan@nxp.com>
 <1579140562-8060-3-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB70239267F223F63918362DDCEE320@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <AM0PR04MB4481A8AF4694F539FBED0D54880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1133360-afdb-4421-6cfc-08d7a3682020
x-ms-traffictypediagnostic: VI1PR04MB7184:|VI1PR04MB7184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB718444F99491A2FED9727E45EE0B0@VI1PR04MB7184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(316002)(478600001)(6506007)(4326008)(186003)(44832011)(53546011)(33656002)(81166006)(81156014)(66946007)(71200400001)(5660300002)(8936002)(55016002)(9686003)(52536014)(86362001)(7696005)(110136005)(66476007)(54906003)(2906002)(76116006)(91956017)(26005)(64756008)(66556008)(66446008)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7184;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRrGomf6MyDZBZqkWESTBstJaJfDj88minrwseOESDgK+9N202tUbwZthTSp08OIiCROLPZtEesSeSzlkEHQXgP7bd9q4ssZqgboHJYeBLUv0OpjbcgsOUeffhGxHGqLZlrrxIc9g9uOMzgSfxRSwaXMyxLioaWPVfhaEuETGDLIRTgO105bsLrvw2071L/Cjdju/nk2E7yc+ZYUtSATn3lknYt41OOrQXJ/nCp4Cxxt5H1Ideb4LWksOG/YZbbDog3sja9Z3VEL5OpOCCOSLYSyYBV6s/j0/j6wafojLAVbY+gNmod7RQxiQO2cj9vUJ8SkEaSTfrxqNe7skpSFwf4aiVSYKceFIbjrkHlZXMDGX+LSz4jc4G3uJ1nfrD2Uedu9usGhM6rCPbIE7xUP1ZdooEzkP1oBb7GCRAW1WEm4EK01GzJksCDfTtZOFLW8FQTgev7oUdsBeEpd3dkHYR1OrYl6DfdEVBM617Zh4CGNGORGYzCP1zTbWS7MJAzY
x-ms-exchange-antispam-messagedata: tyd55icAKZT86uJd/gTHY6C67JMiwqXlzIX+8eA34CTlvdW6TWcxuMqAiVj6vwFNsaMloZ9HCOAu5dBJ15BPLT7m4u6QWOh2ZzoRSaIuiYgCFcbu1xR66j56lRCw9HEBiLpkxVwvxE79yPKSmbDTUw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1133360-afdb-4421-6cfc-08d7a3682020
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 20:33:10.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2rGFdWqMTPzIH7fowu/0+omf/fZfM+Y2HJDV3s056AxToIP2tRZ7wOP5oWcn5gv62FFYZldtDD9ie1X3jxAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.2020 07:00, Peng Fan wrote:=0A=
>> Subject: Re: [PATCH V3 2/4] clk: imx: imx8mq: use=0A=
>> imx8m_clk_hw_composite_core=0A=
>>=0A=
>> On 16.01.2020 04:15, Peng Fan wrote:=0A=
>>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>>=0A=
>>> Use imx8m_clk_hw_composite_core to simplify code.=0A=
>>>=0A=
>>> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=0A=
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
>>> ---=0A=
>>>    drivers/clk/imx/clk-imx8mq.c | 22 ++++++++--------------=0A=
>>>    1 file changed, 8 insertions(+), 14 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/clk/imx/clk-imx8mq.c=0A=
>>> b/drivers/clk/imx/clk-imx8mq.c index 4c0edca1a6d0..e928c1355ad8=0A=
>> 100644=0A=
>>> --- a/drivers/clk/imx/clk-imx8mq.c=0A=
>>> +++ b/drivers/clk/imx/clk-imx8mq.c=0A=
>>> @@ -403,22 +403,16 @@ static int imx8mq_clocks_probe(struct=0A=
>>> platform_device *pdev)=0A=
>>>=0A=
>>>    	/* CORE */=0A=
>>>    	hws[IMX8MQ_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src",=0A=
>> base + 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));=0A=
>>> -	hws[IMX8MQ_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base=0A=
>> + 0x8080, 24, 3, imx8mq_arm_m4_sels, ARRAY_SIZE(imx8mq_arm_m4_sels));=0A=
>>> -	hws[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base +=0A=
>> 0x8100, 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));=0A=
>>> -	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D=0A=
>> imx_clk_hw_mux2("gpu_core_src", base + 0x8180, 24, 3,=0A=
>> imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));=0A=
>>> -	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D=0A=
>> imx_clk_hw_mux2("gpu_shader_src", base + 0x8200, 24, 3,=0A=
>> imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));=0A=
>>> -=0A=
>>>    	hws[IMX8MQ_CLK_A53_CG] =3D=0A=
>> imx_clk_hw_gate3_flags("arm_a53_cg", "arm_a53_src", base + 0x8000, 28,=
=0A=
>> CLK_IS_CRITICAL);=0A=
>>> -	hws[IMX8MQ_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg",=0A=
>> "arm_m4_src", base + 0x8080, 28);=0A=
>>> -	hws[IMX8MQ_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src",=0A=
>> base + 0x8100, 28);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg",=0A=
>> "gpu_core_src", base + 0x8180, 28);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_SHADER_CG] =3D=0A=
>> imx_clk_hw_gate3("gpu_shader_cg", "gpu_shader_src", base + 0x8200, 28);=
=0A=
>>> -=0A=
>>>    	hws[IMX8MQ_CLK_A53_DIV] =3D=0A=
>> imx_clk_hw_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);=
=0A=
>>> -	hws[IMX8MQ_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div",=0A=
>> "arm_m4_cg", base + 0x8080, 0, 3);=0A=
>>> -	hws[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div",=0A=
>> "vpu_cg", base + 0x8100, 0, 3);=0A=
>>> -	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D=0A=
>> imx_clk_hw_divider2("gpu_core_div", "gpu_core_cg", base + 0x8180, 0, 3);=
=0A=
>>> -	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D=0A=
>> imx_clk_hw_divider2("gpu_shader_div", "gpu_shader_cg", base + 0x8200, 0,=
=0A=
>> 3);=0A=
>>> +=0A=
>>> +	hws[IMX8MQ_CLK_M4_DIV] =3D=0A=
>> imx8m_clk_hw_composite_core("arm_m4_div", imx8mq_arm_m4_sels, base=0A=
>> + 0x8080);=0A=
>>> +	hws[IMX8MQ_CLK_VPU_DIV] =3D=0A=
>> imx8m_clk_hw_composite_core("vpu_div", imx8mq_vpu_sels, base +=0A=
>> 0x8100);=0A=
>>> +	hws[IMX8MQ_CLK_GPU_CORE_DIV] =3D=0A=
>> imx8m_clk_hw_composite_core("gpu_core_div", imx8mq_gpu_core_sels,=0A=
>> base + 0x8180);=0A=
>>> +	hws[IMX8MQ_CLK_GPU_SHADER_DIV] =3D=0A=
>>> +imx8m_clk_hw_composite("gpu_shader_div", imx8mq_gpu_shader_sels,=0A=
>> base=0A=
>>> ++ 0x8200);=0A=
>>=0A=
>>> +	/* For DTS which still assign parents for gpu core src clk */=0A=
>>> +	hws[IMX8MQ_CLK_GPU_CORE_SRC] =3D=0A=
>> hws[IMX8MQ_CLK_GPU_CORE_DIV];=0A=
>>> +	hws[IMX8MQ_CLK_GPU_SHADER_SRC] =3D=0A=
>> hws[IMX8MQ_CLK_GPU_SHADER_DIV];=0A=
>>=0A=
>> Why not assign to all the old clocks?=0A=
> =0A=
> Are those clocks expect the GPU ones needed?=0A=
> =0A=
> Currently only the gpu clocks are needed, others are not used in dts.=0A=
> =0A=
> For dts update to use the SRC clocks should be avoided in future for Linu=
x,=0A=
> DIV clocks should be used.=0A=
> =0A=
> How do you think?=0A=
=0A=
In theory backwards compatibility should be supported at the level of =0A=
"DT bindings", not just hacked for a particular DT. In this case it's =0A=
easy to add aliases for everything, just slightly verbose.=0A=
=0A=
It might also make sense to add new defines for the composite clock so =0A=
that IMX8MQ_CLK_GPU_CORE looks like IMX8MQ_CLK_DSI_CORE and all the _SRC =
=0A=
_DIV _CG stuff is just aliases to the unsuffixed composite.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
