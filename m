Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15123C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94A5206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXib8MAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCMH6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:58:18 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:63969
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgCMH6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYiyKx0qTyOZfFDMKJkmAeGCbL6MWRKhIY1xmjqMgORx1p/H6bkhJNTfCoy6wnND8wGXN4X5UdHPVFTSKFFUUum6KYqJt8n/9kLbYGZ7a4vBOCOINae2sPyXAF7COd80P0+2zGKkDTzLpnm8GtS2rcSpIzbQZeH8BmW1bNs/xUwqHSJHxGA+SkprpXfts0M7xVQe/GSU5loyugTU2hj+efs7S8E4vHSyQjT/ypgrEnaGL0H9AupYp6UbcYLq3Kwws5A8Le5at8JwufjKp1JH93A+NpElRUByxXJvBHa9DWiGL0kJyNxRBjmXGsRopVou+WRuGNv4RsGejmCWU9ynPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bfKLPsIoHaf2VUXcYPigbNobdml3pQLe0VzlKaZvMo=;
 b=n1N7c8PlpWrV5t+qaN5DzdJuYmIuJNGXfXDe1wYSAiRutr03BEioX9It2+DojvFL3oCjKX0M6A9sFelB54M/KikJPZ2pk0OPlle8IGCJEj20Zq6bBTHzQLsBIe+rQRDr8htSLR8N5eQ4xTB+ISi4+xfGlmCpzeQIa4sWvcLmEo7VLYiwRcpHt6lJuygjJ+oEe7y26dtF3+lF/hgcdgKLHY+ZyOt6RL3y/5ge5jfkZkuRvDAcOSyMhRrTfDEwIvkY+QNNz2+BvmLbJbJLAPC5KEIvAHz4B7ym7Gk9dDZB3aLmgAlVfafuf85Y/KoWpqb+jfnjkJrgUGlQcDM1Mp4Cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bfKLPsIoHaf2VUXcYPigbNobdml3pQLe0VzlKaZvMo=;
 b=YXib8MAz1ck6ixm0fJOJhTtBcX/AFcswml4GAe88X2l5uIsqYFw8JFL9Gn1fJQqRoACIdzDOkNRFgASu4fJYHNr1WgkVjm1GBqBFL+tcJR4W0RUoFWq7deTN/4d1mMU7F2nwEpPgJvgQqPRzdNcWCRNTt8WPZzsS0L6PRrn7AaU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5521.eurprd04.prod.outlook.com (20.178.112.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Fri, 13 Mar 2020 07:58:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 07:58:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [RFC 06/11] clk: imx: Add helpers for passing the device as
 argument
Thread-Topic: [RFC 06/11] clk: imx: Add helpers for passing the device as
 argument
Thread-Index: AQHV8TqqG8jg875rt0+/0iqjNCvp+qhGN6/w
Date:   Fri, 13 Mar 2020 07:58:14 +0000
Message-ID: <AM0PR04MB44816071F2A24C60A7DFC73188FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
 <1583226206-19758-7-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1583226206-19758-7-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec0ac09b-d05d-4747-5133-08d7c7244882
x-ms-traffictypediagnostic: AM0PR04MB5521:|AM0PR04MB5521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB55211A6CE2F590697103ED5488FA0@AM0PR04MB5521.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(6506007)(66946007)(6636002)(33656002)(9686003)(76116006)(64756008)(66556008)(52536014)(7696005)(66476007)(81166006)(8936002)(55016002)(81156014)(110136005)(316002)(478600001)(8676002)(44832011)(54906003)(66446008)(5660300002)(71200400001)(4326008)(26005)(7416002)(2906002)(86362001)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5521;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ue4T7VXezXxJ/AjJh/7zE5AmHDVDRFoElRxHQ0VK214XonYyxBqqMtKySmhszLDnqpFeLJwpjv8P7jPs+Mu6gLfWl0+VTwMLXenzteWBPEhNegOScwzf9TfyowEuILtb7mKZc70D3qC07SzrgG1HI4OHEQxo0Oo0YgVCaKKiFh7LZWiBciNPeg8WMdEdmE6ex2Fd6f/k4eZjFE1fNliXBS2Z9ZOl4fQQJYHc9EDygdwP7fdp0UwT+pDslWk0WOxfAXI5GxodGT9ejyy4Facv2gM8Yyo2NQNLdrMCgGjMC+puHr5KMdxUICNwbbr5EfBZRLJNXTIQHrLo2UsoPagmcinjiGBWerhSfh9Pbji8Wf09ttDBxKjro9WalNN7BmIDnLLLDaPVcKl1ncwkPNtS0cXFGuL88GB96IaHpBVScQoX2dQKp969UVaWXYN0O1xRwvlfiB5101LG2jSZ7qVrMr7rZY0w0/ZJOnh7VGZlXVcv0qoWDFJ1QcSfHCvNDNHl
x-ms-exchange-antispam-messagedata: fzTrsAawOE5xF23sYByPm1RZl4kmZpan4Ei5p/2OP2Zcq3xaYfeUehn8tFItmhP7fj8FYQ1bPyKF/8ZkfVdWBZPhetoUJbSF+IGQcSgpoGD6Gr8NeC7cqpfiH62/qNmojv7TedDYL60KLU0eew03ZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0ac09b-d05d-4747-5133-08d7c7244882
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 07:58:14.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y6/ABk4TyzYwPs5N/yvmToGf19oW+obJZIk9kNiahfB4aig97zR22iMnxk5p6N5SRT3ik1mzLvHMN1hz4JulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [RFC 06/11] clk: imx: Add helpers for passing the device as argu=
ment
>=20
> All the imx clocks that need to be registered by the audiomix need to pas=
s on
> the device so that the runtime PM support could work properly.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/clk/imx/clk.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> cb28f06..42960a9 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -321,6 +321,13 @@ static inline struct clk_hw *imx_clk_hw_gate(const
> char *name, const char *paren
>  				    shift, 0, &imx_ccm_lock);
>  }
>=20
> +static inline struct clk_hw *imx_dev_clk_hw_gate(struct device *dev, con=
st
> char *name,
> +						const char *parent, void __iomem *reg, u8 shift)
> {
> +	return clk_hw_register_gate(dev, name, parent, CLK_SET_RATE_PARENT,
> reg,
> +				    shift, 0, &imx_ccm_lock);
> +}
> +
>  static inline struct clk_hw *imx_clk_hw_gate_dis(const char *name, const
> char *parent,
>  		void __iomem *reg, u8 shift)
>  {
> @@ -422,6 +429,15 @@ static inline struct clk_hw *imx_clk_hw_mux(const
> char *name, void __iomem *reg,
>  			width, 0, &imx_ccm_lock);
>  }
>=20
> +static inline struct clk_hw *imx_dev_clk_hw_mux(struct device *dev, cons=
t
> char *name,
> +                        void __iomem *reg, u8 shift, u8 width,
> +                        const char * const *parents, int num_parents)
> {
> +        return clk_hw_register_mux(dev, name, parents, num_parents,
> +                        CLK_SET_RATE_NO_REPARENT |
> CLK_SET_PARENT_GATE,
> +                        reg, shift, width, 0, &imx_ccm_lock); }
> +
>  static inline struct clk *imx_clk_mux2(const char *name, void __iomem
> *reg,
>  			u8 shift, u8 width, const char * const *parents,
>  			int num_parents)
> @@ -484,6 +500,19 @@ static inline struct clk_hw
> *imx_clk_hw_mux_flags(const char *name,
>  				   reg, shift, width, 0, &imx_ccm_lock);  }
>=20
> +static inline struct clk_hw *imx_dev_clk_hw_mux_flags(struct device *dev=
,
> +						  const char *name,
> +						  void __iomem *reg, u8 shift,
> +						  u8 width,
> +						  const char * const *parents,
> +						  int num_parents,
> +						  unsigned long flags)
> +{
> +	return clk_hw_register_mux(dev, name, parents, num_parents,
> +				   flags | CLK_SET_RATE_NO_REPARENT,
> +				   reg, shift, width, 0, &imx_ccm_lock); }
> +
>  struct clk_hw *imx_clk_hw_cpu(const char *name, const char
> *parent_name,
>  		struct clk *div, struct clk *mux, struct clk *pll,
>  		struct clk *step);
> --
> 2.7.4

