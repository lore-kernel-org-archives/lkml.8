Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B00C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EFD20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JpvY16Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRCwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:52:04 -0400
Received: from mail-eopbgr30077.outbound.protection.outlook.com ([40.107.3.77]:4599
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgCRCwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AERiBoQYFlv8PWdBd6F8bZcxxthdxwfvYUao+hcSauQps2qIeBcXv5BcuQKFK+Q+uW1bhKcExbX//EEXlpAlAW/JSAadOBK7HvyGHlsI6VPYYP+kKNHWLGbKVS/bCuLbjF+UHTur9bJk6aSkEIoGW11nsWdOQskmQ7Au/lLwZGcbtCmfNmOi2EzMUx+tcFUkUMp7UxmrIuPg/TcGHdPl9nENc0hc5PzX7F+opsXooJMjOicgSMXAlg74gTuDuHfyJXtLT7csp41ucZBnMy1qDusil7loxvvw1BtFIGxEijdb4lew97ccQV85qixQ3DjdTN+M0E2OKszitXD6UGqEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWktdu0RRD4qHRP0UQsrpXmIwWbykJksEhrnxbl/zPc=;
 b=nSlXJOyOcO2diYMDMHZ2gCfQYaX3T22baySzC7NgL/eArsEF3NhQk4Vqgu+cprCs5p0OdEA77FZOibjraeaY/W/11RnT5bdCGFQRC1BKgVnObVaiKf2zlDNwCIS4M8hqB8likLHIoKPbp56CCK92/6WXM4cNuv/KAXIf/4By0kvu5dAOKz43y2DItKSe+pCZLBk7kfPb8N4g5vPQF/ZVql754tNCeK3BgQkkXgvzxNKVyBcq8lmnldKEjQSwWAdQC1Gi3fKgKtj3qeI4d/AS3Lr40gBeVNxam8AKaLknRLMwR5da0XSMkpg8itgkBy9x9BB+RYu0um1IVecU1BTiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWktdu0RRD4qHRP0UQsrpXmIwWbykJksEhrnxbl/zPc=;
 b=JpvY16ZozC+/swZIkHP2gAo3L8CYHpXMGK+YWOiSIkPL0yXLU9rxRzNfptqMZTKPs8wCzEXNYdiJgjKqvZSvWgt8UMLY/uPDCwUM+vUxBKU6rIjtzP79k6KZ60kYWY9XopuNga3HmiAU4q1SMqviUhrceFSFad1KcBsjiBapqEQ=
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com (52.133.244.87) by
 VI1PR04MB5711.eurprd04.prod.outlook.com (20.178.127.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 02:51:58 +0000
Received: from VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200]) by VI1PR04MB6941.eurprd04.prod.outlook.com
 ([fe80::289c:fdf8:faf0:3200%2]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 02:51:58 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Franck Lenormand <franck.lenormand@nxp.com>
Subject: Re: [PATCH V6 3/4] mailbox: imx: add SCU MU support
Thread-Topic: [PATCH V6 3/4] mailbox: imx: add SCU MU support
Thread-Index: AQHV8embb7q0w++ct0i8/ftV4j8c6g==
Date:   Wed, 18 Mar 2020 02:51:58 +0000
Message-ID: <VI1PR04MB6941C68049C777411CBC56D0EEF70@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
 <1583300977-2327-4-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 843ccbb0-7b71-4c9b-a6fc-08d7cae753ae
x-ms-traffictypediagnostic: VI1PR04MB5711:|VI1PR04MB5711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB571150C26AC29C048CE7D038EEF70@VI1PR04MB5711.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(2906002)(66476007)(66556008)(86362001)(91956017)(55016002)(15650500001)(9686003)(66946007)(66446008)(64756008)(8936002)(76116006)(4326008)(54906003)(316002)(110136005)(478600001)(81166006)(81156014)(52536014)(8676002)(5660300002)(6506007)(71200400001)(33656002)(53546011)(44832011)(7696005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5711;H:VI1PR04MB6941.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnBoTOenx8O/mAd1boVX5cXz4hbujCQYEafSqfCJPhNx2dRvanzuxpbfgcIVF5nXKh3CuHvybY6g/LBYiNspG8lStv8PKyIGZqki7oIP7xnxIY2jeBj+YXTuXYP2LlaTQKC8S0ebOtQcBIxTuI4SMMiC2srw/YRAC/10dIm7xdnSU2TdpPHqbWYgzvif/UNZHPedsq1RmN/0IKv3BMyU+DQ9MjogO3fjmD2rWq0Y5hkkjm9ZFsv2g7ar33PMBc2r1zWbf/g6Nv/wpI+Y2Q4dm7pzYtaopLTVWqHijo5mB+YD24e8vR3eV6uCze4sk/JiiGBdQnDIvuTSkt0ANfBPqvDQpTThWyMl0a3KEno6YW5uCDLL+2s6bLzEFPfE7zbNOU/kcwLJY8gZSNXjL/bZfTiVALTb/hX93keNvYST6ClNGLbqGsG8RPm08YCdc2CT
x-ms-exchange-antispam-messagedata: GCIqR/ssGXsRkRp3O+6Vwk9LyeJSqbMMglO833pDz4OTGDDK6l0WKNRT30+vvAhIp+nAeNuWSjleqZkYtAClI+qjNFksjVh38NuQsUKp8Xplh8UnDs0hvLYgVHvMaLMZvtC+eBpa4vdYh1lg4I9jCg==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843ccbb0-7b71-4c9b-a6fc-08d7cae753ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 02:51:58.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dx9G/7GsHDmazEcnw340HHptNFRrP3C9fnfPHd4m/Flfh+5cQIwczsjqFD50nMYMv34w8mmrCwIk2T1dvIkl8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-04 7:56 AM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> i.MX8/8X SCU MU is dedicated for communication between SCU and Cortex-A=
=0A=
> cores from hardware design, and could not be reused for other purpose.=0A=
> =0A=
> Per i.MX8/8X Reference mannual, Chapter "12.9.2.3.2 Messaging Examples",=
=0A=
>   Passing short messages: Transmit register(s) can be used to pass=0A=
>   short messages from one to four words in length. For example, when=0A=
>   a four-word message is desired, only one of the registers needs to=0A=
>   have its corresponding interrupt enable bit set at the receiver side;=
=0A=
>   the message=92s first three words are written to the registers whose=0A=
>   interrupt is masked, and the fourth word is written to the other=0A=
>   register (which triggers an interrupt at the receiver side).=0A=
> =0A=
> i.MX8/8X SCU firmware IPC is an implementation of passing short=0A=
> messages. But current imx-mailbox driver only support one word=0A=
> message, i.MX8/8X linux side firmware has to request four TX=0A=
> and four RX to support IPC to SCU firmware. This is low efficent=0A=
> and more interrupts triggered compared with one TX and=0A=
> one RX.=0A=
> =0A=
> To make SCU MU work,=0A=
>    - parse the size of msg.=0A=
>    - Only enable TR0/RR0 interrupt for transmit/receive message.=0A=
>    - For TX/RX, only support one TX channel and one RX channel=0A=
>    - For RX, support receive msg larger than 4 u32 words.=0A=
>    - Support 6 channels, TX0/RX0/RXDB[0-3], not support TXDB.=0A=
> =0A=
> Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>=0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> ---=0A=
> =0A=
> V6:=0A=
>   Add R-b tag=0A=
>   Use %zu for printk sizeof=0A=
> =0A=
> V5:=0A=
>   Code style cleanup=0A=
>   Add more debug msg=0A=
>   Drop __packed aligned=0A=
>   idx santity check in scu xlate=0A=
> =0A=
> V4:=0A=
>   Added separate chans init and xlate function for SCU MU=0A=
>   Limit chans to TX0/RX0/RXDB[0-3], max 6 chans.=0A=
>   Santity check to msg size=0A=
> =0A=
> V3:=0A=
>   Added scu type tx/rx and SCU MU type=0A=
> =0A=
>   drivers/mailbox/imx-mailbox.c | 134 +++++++++++++++++++++++++++++++++++=
+++++++=0A=
>   1 file changed, 134 insertions(+)=0A=
> =0A=
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c=0A=
> index df6c4ecd913c..0895ccd23d17 100644=0A=
> --- a/drivers/mailbox/imx-mailbox.c=0A=
> +++ b/drivers/mailbox/imx-mailbox.c=0A=
> @@ -4,6 +4,7 @@=0A=
>    */=0A=
>   =0A=
>   #include <linux/clk.h>=0A=
> +#include <linux/firmware/imx/ipc.h>=0A=
>   #include <linux/interrupt.h>=0A=
>   #include <linux/io.h>=0A=
>   #include <linux/kernel.h>=0A=
> @@ -27,6 +28,8 @@=0A=
>   #define IMX_MU_xCR_GIRn(x)	BIT(16 + (3 - (x)))=0A=
>   =0A=
>   #define IMX_MU_CHANS		16=0A=
> +/* TX0/RX0/RXDB[0-3] */=0A=
> +#define IMX_MU_SCU_CHANS	6=0A=
>   #define IMX_MU_CHAN_NAME_SIZE	20=0A=
>   =0A=
>   enum imx_mu_chan_type {=0A=
> @@ -36,6 +39,11 @@ enum imx_mu_chan_type {=0A=
>   	IMX_MU_TYPE_RXDB,	/* Rx doorbell */=0A=
>   };=0A=
>   =0A=
> +struct imx_sc_rpc_msg_max {=0A=
> +	struct imx_sc_rpc_msg hdr;=0A=
> +	u32 data[7];=0A=
> +};=0A=
> +=0A=
>   struct imx_mu_con_priv {=0A=
>   	unsigned int		idx;=0A=
>   	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];=0A=
> @@ -134,6 +142,63 @@ static int imx_mu_generic_rx(struct imx_mu_priv *pri=
v,=0A=
>   	return 0;=0A=
>   }=0A=
>   =0A=
> +static int imx_mu_scu_tx(struct imx_mu_priv *priv,=0A=
> +			 struct imx_mu_con_priv *cp,=0A=
> +			 void *data)=0A=
> +{=0A=
> +	struct imx_sc_rpc_msg_max *msg =3D data;=0A=
> +	u32 *arg =3D data;=0A=
> +	int i;=0A=
> +=0A=
> +	switch (cp->type) {=0A=
> +	case IMX_MU_TYPE_TX:=0A=
> +		if (msg->hdr.size > sizeof(*msg)) {=0A=
> +			/*=0A=
> +			 * The real message size can be different to=0A=
> +			 * struct imx_sc_rpc_msg_max size=0A=
> +			 */=0A=
> +			dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i\n", size=
of(*msg), msg->hdr.size);=0A=
> +			return -EINVAL;=0A=
> +		}=0A=
> +=0A=
> +		for (i =3D 0; i < msg->hdr.size; i++) > +			imx_mu_write(priv, *arg++,=
 priv->dcfg->xTR[i % 4]);=0A=
=0A=
Need to poll for TE, otherwise for long messages we could overwrite TR0 =0A=
before SCU reads it.=0A=
=0A=
> +=0A=
> +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);=0A=
=0A=
Shouldn't TIE be armed ahead of writing? In theory SCU could read first =0A=
register before loop above is over.=0A=
=0A=
> +		break;=0A=
> +	default:=0A=
> +		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n=
", cp->type);=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int imx_mu_scu_rx(struct imx_mu_priv *priv,=0A=
> +			 struct imx_mu_con_priv *cp)=0A=
> +{=0A=
> +	struct imx_sc_rpc_msg_max msg;=0A=
> +	u32 *data =3D (u32 *)&msg;=0A=
> +	int i;=0A=
> +=0A=
> +	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));=0A=
> +	*data++ =3D imx_mu_read(priv, priv->dcfg->xRR[0]);=0A=
> +=0A=
> +	if (msg.hdr.size > sizeof(msg)) {=0A=
> +		dev_err(priv->dev, "Exceed max msg size (%zu) on RX, got: %i\n",=0A=
> +			sizeof(msg), msg.hdr.size);=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	for (i =3D 1; i < msg.hdr.size; i++)=0A=
> +		*data++ =3D imx_mu_read(priv, priv->dcfg->xRR[i % 4]);=0A=
=0A=
Shouldn't you poll for !RE? It's possible to receive RX interrupt and =0A=
start reading before other side writes the second word.=0A=
=0A=
> +=0A=
> +	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);=0A=
> +	mbox_chan_received_data(cp->chan, (void *)&msg);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>   static void imx_mu_txdb_tasklet(unsigned long data)=0A=
>   {=0A=
>   	struct imx_mu_con_priv *cp =3D (struct imx_mu_con_priv *)data;=0A=
> @@ -263,6 +328,42 @@ static const struct mbox_chan_ops imx_mu_ops =3D {=
=0A=
>   	.shutdown =3D imx_mu_shutdown,=0A=
>   };=0A=
>   =0A=
> +static struct mbox_chan *imx_mu_scu_xlate(struct mbox_controller *mbox,=
=0A=
> +					  const struct of_phandle_args *sp)=0A=
> +{=0A=
> +	u32 type, idx, chan;=0A=
> +=0A=
> +	if (sp->args_count !=3D 2) {=0A=
> +		dev_err(mbox->dev, "Invalid argument count %d\n", sp->args_count);=0A=
> +		return ERR_PTR(-EINVAL);=0A=
> +	}=0A=
> +=0A=
> +	type =3D sp->args[0]; /* channel type */=0A=
> +	idx =3D sp->args[1]; /* index */=0A=
> +=0A=
> +	switch (type) {=0A=
> +	case IMX_MU_TYPE_TX:=0A=
> +	case IMX_MU_TYPE_RX:=0A=
> +		if (idx !=3D 0)=0A=
> +			dev_err(mbox->dev, "Invalid chan idx: %d\n", idx);=0A=
> +		chan =3D type;=0A=
> +		break;=0A=
> +	case IMX_MU_TYPE_RXDB:=0A=
> +		chan =3D 2 + idx;=0A=
> +		break;=0A=
> +	default:=0A=
> +		dev_err(mbox->dev, "Invalid chan type: %d\n", type);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	if (chan >=3D mbox->num_chans) {=0A=
> +		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: =
%d)\n", chan, type, idx);=0A=
> +		return ERR_PTR(-EINVAL);=0A=
> +	}=0A=
> +=0A=
> +	return &mbox->chans[chan];=0A=
> +}=0A=
> +=0A=
>   static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,=0A=
>   				       const struct of_phandle_args *sp)=0A=
>   {=0A=
> @@ -310,6 +411,28 @@ static void imx_mu_init_generic(struct imx_mu_priv *=
priv)=0A=
>   	imx_mu_write(priv, 0, priv->dcfg->xCR);=0A=
>   }=0A=
>   =0A=
> +static void imx_mu_init_scu(struct imx_mu_priv *priv)=0A=
> +{=0A=
> +	unsigned int i;=0A=
> +=0A=
> +	for (i =3D 0; i < IMX_MU_SCU_CHANS; i++) {=0A=
> +		struct imx_mu_con_priv *cp =3D &priv->con_priv[i];=0A=
> +=0A=
> +		cp->idx =3D i < 2 ? 0 : i - 2;=0A=
> +		cp->type =3D i < 2 ? i : IMX_MU_TYPE_RXDB;=0A=
> +		cp->chan =3D &priv->mbox_chans[i];=0A=
> +		priv->mbox_chans[i].con_priv =3D cp;=0A=
> +		snprintf(cp->irq_desc, sizeof(cp->irq_desc),=0A=
> +			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);=0A=
> +	}=0A=
> +=0A=
> +	priv->mbox.num_chans =3D IMX_MU_SCU_CHANS;=0A=
> +	priv->mbox.of_xlate =3D imx_mu_scu_xlate;=0A=
> +=0A=
> +	/* Set default MU configuration */=0A=
> +	imx_mu_write(priv, 0, priv->dcfg->xCR);=0A=
> +}=0A=
> +=0A=
>   static int imx_mu_probe(struct platform_device *pdev)=0A=
>   {=0A=
>   	struct device *dev =3D &pdev->dev;=0A=
> @@ -396,9 +519,20 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp =
=3D {=0A=
>   	.xCR	=3D 0x64,=0A=
>   };=0A=
>   =0A=
> +static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu =3D {=0A=
> +	.tx	=3D imx_mu_scu_tx,=0A=
> +	.rx	=3D imx_mu_scu_rx,=0A=
> +	.init	=3D imx_mu_init_scu,=0A=
> +	.xTR	=3D {0x0, 0x4, 0x8, 0xc},=0A=
> +	.xRR	=3D {0x10, 0x14, 0x18, 0x1c},=0A=
> +	.xSR	=3D 0x20,=0A=
> +	.xCR	=3D 0x24,=0A=
> +};=0A=
> +=0A=
>   static const struct of_device_id imx_mu_dt_ids[] =3D {=0A=
>   	{ .compatible =3D "fsl,imx7ulp-mu", .data =3D &imx_mu_cfg_imx7ulp },=
=0A=
>   	{ .compatible =3D "fsl,imx6sx-mu", .data =3D &imx_mu_cfg_imx6sx },=0A=
> +	{ .compatible =3D "fsl,imx8-mu-scu", .data =3D &imx_mu_cfg_imx8_scu },=
=0A=
>   	{ },=0A=
>   };=0A=
>   MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);=0A=
> =0A=
=0A=
