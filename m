Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B71C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE2B20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M00WJQBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCRMRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:17:13 -0400
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:33241
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgCRMRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:17:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkvZUB5qZbw4yG6mG1ntZ6j7ZsFXws6cogfBaP3ZFXU5DPxSHG5S/yFkI8fvQROtTHVRNPpaB40Cmfs12WUPgGlNPLPPNf3EZ03++iMNj/Q6GMp/UH7lZWJiUycPIDnejv0KIczNFekcTNMwX9jSFlydPzpIoZs/dXLyznOmBwXkPFWMA+TqTwcsW0YedhF0g7g3rDtfF2lpjYAL5eKQ+TDCFNgIU9tUZ9wZfNC6nwqruPe/rjBEGfHL3k0As3reon87I5cHJjIe/4s4OYLY49HRVuTBibMBKoRI/s8PvDjiuOlIggtYJtqNkg0SnMFzPSdc/MIXsbFPtcsDXOpqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5cJUNDYVsOrAeuzl8D1Bd/zF5efBK97Rv9G84w5mKQ=;
 b=lendlmOViwXe/Oh7ZKlW/6z+jdXRe9qekZwcG3yke41OXWnI8rwesRk8RRkwxwv2Ion57qzPJbPRTsceexpq9cfRHIMJQ0QMzsrdTqnflkFdn+VpY8g5xQT6IsydjaZCXniObVlzUrsTy1tO5xrWybG10VMTK3kl2VkpGX2TeqS4B6O/KVxf2Tz4Ms6ZqpkLmZ0n1hoQ8NoBTgcFa+ZfCg2r+F/KEensyJqCGnI7QInUGg8oA7izGxifVkKQg6/IgdScFBWghf9PRnVDrFHY0iHCZTg8L24lb2n6yJGdJiecOhzzndVLgrM3mfyBQj81HNZpKmFxk+AjlXtG4xAvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5cJUNDYVsOrAeuzl8D1Bd/zF5efBK97Rv9G84w5mKQ=;
 b=M00WJQBJrIgAYW+mHWqbkopSlLFdfCivdS3/pMoK3eAhGNBw3UU2BwLWDf0xANBJMS30cG6YmpqIUnAFSDhMS8BEnSl/bsHwB+tusmnXV8jLu67+Z0ux7JIJiHJ9jJ5mfg0p17VQFFhtmaxsTV8WJxERhV1sy6tUSsgaMpXF1io=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6929.eurprd04.prod.outlook.com (52.132.213.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 12:17:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 12:17:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
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
Subject: RE: [PATCH V6 3/4] mailbox: imx: add SCU MU support
Thread-Topic: [PATCH V6 3/4] mailbox: imx: add SCU MU support
Thread-Index: AQHV8emYEjywJylLTkOpGZN4OlOQPKhOWcDQ
Date:   Wed, 18 Mar 2020 12:17:07 +0000
Message-ID: <AM0PR04MB44812E72AD047A7339375DE988F70@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583300977-2327-1-git-send-email-peng.fan@nxp.com>
 <1583300977-2327-4-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB6941C68049C777411CBC56D0EEF70@VI1PR04MB6941.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB6941C68049C777411CBC56D0EEF70@VI1PR04MB6941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9363225f-0793-4e46-930e-08d7cb364735
x-ms-traffictypediagnostic: AM0PR04MB6929:|AM0PR04MB6929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB69295266A85D2A2F719765D788F70@AM0PR04MB6929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(66556008)(7696005)(66946007)(15650500001)(110136005)(66476007)(55016002)(5660300002)(76116006)(478600001)(9686003)(44832011)(33656002)(4326008)(81166006)(81156014)(8676002)(52536014)(316002)(53546011)(6506007)(8936002)(54906003)(2906002)(86362001)(186003)(71200400001)(26005)(66446008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6929;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XonK1PbwfSsSt2hG5mJw3Wo5X7o3M00z4ohFJZc+a8h75Z1tbDpiCdwiKS5mqwcGsgNQZlfc4T5WCWPENjEOk5hkYic0h1y8Aw1sv/uLJ97UQah7K198V8iCxis4uvSyhoNr/X10NLOHW0XAsRCJqGPa8Eb0jAGA8Dce2mX4rmysuhy6xVktUWvCCVk1hxZeSFju44FpoWx9IMEUq1YSW106mreyUjw3SqXTV+80phV2W+0PWm1HjBcMmz+hK4GdXXq4+mGhE47DdhMONEYPEKYSvfxvLirL6FwGhaz510Hay46/PlYn8MUPntSD3dRORcwN4D4r+zawTsHyXZLOVkqTcoN/XC0yD+dgBjL6AAQKGRp3kLJchGTDI+7/M3xa0capCVDIjqRRGm7pWh09Bsat4PEH81xbtX6i18tZOTvhFnfRzf4z5wzCVqPup7Bm
x-ms-exchange-antispam-messagedata: XcGd5NGFXRLtfqVvw0Ac7RVsUOFXAi+wsktZ6NAR/LOqWet0L4Kdlpb9sKInt1QBOg8IZdcIhAFIqVDfKYUPWlQa4m3sKNttkKptM2BKNNJl2ykFQN17v+wqgjkAv3wVO7nrCkNcXjbfunmcyeyYcQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9363225f-0793-4e46-930e-08d7cb364735
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 12:17:07.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDEtTU0KqcJwF+p+DcMDSbfQkqKBceXy0Gl/IVMiVpIlY2ZKcCp3WDOx8ncwr7Yudg2okvc+KHAlvgV6r5mrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V6 3/4] mailbox: imx: add SCU MU support
>=20
> On 2020-03-04 7:56 AM, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8/8X SCU MU is dedicated for communication between SCU and
> > Cortex-A cores from hardware design, and could not be reused for other
> purpose.
> >
> > Per i.MX8/8X Reference mannual, Chapter "12.9.2.3.2 Messaging
> Examples",
> >   Passing short messages: Transmit register(s) can be used to pass
> >   short messages from one to four words in length. For example, when
> >   a four-word message is desired, only one of the registers needs to
> >   have its corresponding interrupt enable bit set at the receiver side;
> >   the message's first three words are written to the registers whose
> >   interrupt is masked, and the fourth word is written to the other
> >   register (which triggers an interrupt at the receiver side).
> >
> > i.MX8/8X SCU firmware IPC is an implementation of passing short
> > messages. But current imx-mailbox driver only support one word
> > message, i.MX8/8X linux side firmware has to request four TX and four
> > RX to support IPC to SCU firmware. This is low efficent and more
> > interrupts triggered compared with one TX and one RX.
> >
> > To make SCU MU work,
> >    - parse the size of msg.
> >    - Only enable TR0/RR0 interrupt for transmit/receive message.
> >    - For TX/RX, only support one TX channel and one RX channel
> >    - For RX, support receive msg larger than 4 u32 words.
> >    - Support 6 channels, TX0/RX0/RXDB[0-3], not support TXDB.
> >
> > Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V6:
> >   Add R-b tag
> >   Use %zu for printk sizeof
> >
> > V5:
> >   Code style cleanup
> >   Add more debug msg
> >   Drop __packed aligned
> >   idx santity check in scu xlate
> >
> > V4:
> >   Added separate chans init and xlate function for SCU MU
> >   Limit chans to TX0/RX0/RXDB[0-3], max 6 chans.
> >   Santity check to msg size
> >
> > V3:
> >   Added scu type tx/rx and SCU MU type
> >
> >   drivers/mailbox/imx-mailbox.c | 134
> ++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 134 insertions(+)
> >
> > diff --git a/drivers/mailbox/imx-mailbox.c
> > b/drivers/mailbox/imx-mailbox.c index df6c4ecd913c..0895ccd23d17
> > 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -4,6 +4,7 @@
> >    */
> >
> >   #include <linux/clk.h>
> > +#include <linux/firmware/imx/ipc.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/io.h>
> >   #include <linux/kernel.h>
> > @@ -27,6 +28,8 @@
> >   #define IMX_MU_xCR_GIRn(x)	BIT(16 + (3 - (x)))
> >
> >   #define IMX_MU_CHANS		16
> > +/* TX0/RX0/RXDB[0-3] */
> > +#define IMX_MU_SCU_CHANS	6
> >   #define IMX_MU_CHAN_NAME_SIZE	20
> >
> >   enum imx_mu_chan_type {
> > @@ -36,6 +39,11 @@ enum imx_mu_chan_type {
> >   	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
> >   };
> >
> > +struct imx_sc_rpc_msg_max {
> > +	struct imx_sc_rpc_msg hdr;
> > +	u32 data[7];
> > +};
> > +
> >   struct imx_mu_con_priv {
> >   	unsigned int		idx;
> >   	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
> > @@ -134,6 +142,63 @@ static int imx_mu_generic_rx(struct imx_mu_priv
> *priv,
> >   	return 0;
> >   }
> >
> > +static int imx_mu_scu_tx(struct imx_mu_priv *priv,
> > +			 struct imx_mu_con_priv *cp,
> > +			 void *data)
> > +{
> > +	struct imx_sc_rpc_msg_max *msg =3D data;
> > +	u32 *arg =3D data;
> > +	int i;
> > +
> > +	switch (cp->type) {
> > +	case IMX_MU_TYPE_TX:
> > +		if (msg->hdr.size > sizeof(*msg)) {
> > +			/*
> > +			 * The real message size can be different to
> > +			 * struct imx_sc_rpc_msg_max size
> > +			 */
> > +			dev_err(priv->dev, "Exceed max msg size (%zu) on TX,
> got: %i\n", sizeof(*msg), msg->hdr.size);
> > +			return -EINVAL;
> > +		}
> > +
> > +		for (i =3D 0; i < msg->hdr.size; i++) > +			imx_mu_write(priv,
> *arg++, priv->dcfg->xTR[i % 4]);
>=20
> Need to poll for TE, otherwise for long messages we could overwrite TR0
> before SCU reads it.

I planned to add a follow up patch for long word messages.
Since you raised it, I'll add check for TX for send, RX for recv.

>=20
> > +
> > +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>=20
> Shouldn't TIE be armed ahead of writing? In theory SCU could read first
> register before loop above is over.

This is to avoid TX interrupt be triggered early.

>=20
> > +		break;
> > +	default:
> > +		dev_warn_ratelimited(priv->dev, "Send data on wrong channel
> type: %d\n", cp->type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_mu_scu_rx(struct imx_mu_priv *priv,
> > +			 struct imx_mu_con_priv *cp)
> > +{
> > +	struct imx_sc_rpc_msg_max msg;
> > +	u32 *data =3D (u32 *)&msg;
> > +	int i;
> > +
> > +	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
> > +	*data++ =3D imx_mu_read(priv, priv->dcfg->xRR[0]);
> > +
> > +	if (msg.hdr.size > sizeof(msg)) {
> > +		dev_err(priv->dev, "Exceed max msg size (%zu) on RX, got: %i\n",
> > +			sizeof(msg), msg.hdr.size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 1; i < msg.hdr.size; i++)
> > +		*data++ =3D imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
>=20
> Shouldn't you poll for !RE? It's possible to receive RX interrupt and sta=
rt
> reading before other side writes the second word.

Will add RE check.


Thanks,
Peng.

>=20
> > +
> > +	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
> > +	mbox_chan_received_data(cp->chan, (void *)&msg);
> > +
> > +	return 0;
> > +}
> > +
> >   static void imx_mu_txdb_tasklet(unsigned long data)
> >   {
> >   	struct imx_mu_con_priv *cp =3D (struct imx_mu_con_priv *)data; @@
> > -263,6 +328,42 @@ static const struct mbox_chan_ops imx_mu_ops =3D {
> >   	.shutdown =3D imx_mu_shutdown,
> >   };
> >
> > +static struct mbox_chan *imx_mu_scu_xlate(struct mbox_controller
> *mbox,
> > +					  const struct of_phandle_args *sp) {
> > +	u32 type, idx, chan;
> > +
> > +	if (sp->args_count !=3D 2) {
> > +		dev_err(mbox->dev, "Invalid argument count %d\n",
> sp->args_count);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	type =3D sp->args[0]; /* channel type */
> > +	idx =3D sp->args[1]; /* index */
> > +
> > +	switch (type) {
> > +	case IMX_MU_TYPE_TX:
> > +	case IMX_MU_TYPE_RX:
> > +		if (idx !=3D 0)
> > +			dev_err(mbox->dev, "Invalid chan idx: %d\n", idx);
> > +		chan =3D type;
> > +		break;
> > +	case IMX_MU_TYPE_RXDB:
> > +		chan =3D 2 + idx;
> > +		break;
> > +	default:
> > +		dev_err(mbox->dev, "Invalid chan type: %d\n", type);
> > +		return NULL;
> > +	}
> > +
> > +	if (chan >=3D mbox->num_chans) {
> > +		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d,
> idx: %d)\n", chan, type, idx);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	return &mbox->chans[chan];
> > +}
> > +
> >   static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
> >   				       const struct of_phandle_args *sp)
> >   {
> > @@ -310,6 +411,28 @@ static void imx_mu_init_generic(struct
> imx_mu_priv *priv)
> >   	imx_mu_write(priv, 0, priv->dcfg->xCR);
> >   }
> >
> > +static void imx_mu_init_scu(struct imx_mu_priv *priv) {
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < IMX_MU_SCU_CHANS; i++) {
> > +		struct imx_mu_con_priv *cp =3D &priv->con_priv[i];
> > +
> > +		cp->idx =3D i < 2 ? 0 : i - 2;
> > +		cp->type =3D i < 2 ? i : IMX_MU_TYPE_RXDB;
> > +		cp->chan =3D &priv->mbox_chans[i];
> > +		priv->mbox_chans[i].con_priv =3D cp;
> > +		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> > +			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
> > +	}
> > +
> > +	priv->mbox.num_chans =3D IMX_MU_SCU_CHANS;
> > +	priv->mbox.of_xlate =3D imx_mu_scu_xlate;
> > +
> > +	/* Set default MU configuration */
> > +	imx_mu_write(priv, 0, priv->dcfg->xCR); }
> > +
> >   static int imx_mu_probe(struct platform_device *pdev)
> >   {
> >   	struct device *dev =3D &pdev->dev;
> > @@ -396,9 +519,20 @@ static const struct imx_mu_dcfg
> imx_mu_cfg_imx7ulp =3D {
> >   	.xCR	=3D 0x64,
> >   };
> >
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu =3D {
> > +	.tx	=3D imx_mu_scu_tx,
> > +	.rx	=3D imx_mu_scu_rx,
> > +	.init	=3D imx_mu_init_scu,
> > +	.xTR	=3D {0x0, 0x4, 0x8, 0xc},
> > +	.xRR	=3D {0x10, 0x14, 0x18, 0x1c},
> > +	.xSR	=3D 0x20,
> > +	.xCR	=3D 0x24,
> > +};
> > +
> >   static const struct of_device_id imx_mu_dt_ids[] =3D {
> >   	{ .compatible =3D "fsl,imx7ulp-mu", .data =3D &imx_mu_cfg_imx7ulp },
> >   	{ .compatible =3D "fsl,imx6sx-mu", .data =3D &imx_mu_cfg_imx6sx },
> > +	{ .compatible =3D "fsl,imx8-mu-scu", .data =3D &imx_mu_cfg_imx8_scu }=
,
> >   	{ },
> >   };
> >   MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> >

