Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D215FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A433520707
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mn0CZDgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFAEK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:10:29 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:25599
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFAEK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awftJkezXB3iVGT/ugtKGHqWE2pOn2OsmrX8gCRmGEaAlxmGZD1ArZGRyOx9bdTp29By37FXEr32paluyaFA7A4o8lrMAJIDn5RMOag4CtAz32N9QcT/Gf8V6izr1DgEZns3AJ4bPRLUB15isxU2Zgno1x6eWDfAXWREATru5x8SUh/4Z3wswp5wJCLwIPAK4GBVP3q30Ym9YmCk6Bvf3WUHbi5fiWtu5NA4QEUEFsfoDvfVKkpwqTwYWeWiKMyLYNOVuaSpzJvVdrQ5KaiM0WPDs1wc1yotPVy1lUYl+J1ha21g2W+5ttDZHeu7gFUUDq414VTCOyEkTsLxL5KWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFfFnY0ADOOvtSrSXBhw7R8nAv2iCDo/O1xodSTWU2E=;
 b=jrcOKQQ90k/4xv/jSItZs1aPl3FBsuk5oSLofypLId8QqgsQcxf5sy8hLOEcv/tv8FH7HcsHFNO8JMxB7uAxyWedg3D/sPvg7POq6Vl7Ek4SRaYsX/p2kk0Mobs0ucCt3q/g/lpRi2Xl3E4geK+MwGxlCex3UBhKFI4dObYhU4WJaHyCH1VYWeHUYm9ZEFirJ9G8jefc9fUNSU/loZ5tWhFb9YIfrTFkFWPRUFl4tAvIZNvA/eYirZMLFhMt1UJXdigJWuxaCIbFCJDSVPRp/a1uOD3PwvZ4hO2Iy2ZwH1ICuCzpyjBMTLCH4JRYHHMZP7BbjdIUZU4KIa9K4QBacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFfFnY0ADOOvtSrSXBhw7R8nAv2iCDo/O1xodSTWU2E=;
 b=Mn0CZDgZsKLsZMFlSoDw5tk2/NA6894O5qzpgnAXRagl++Igq4H0i2y5C+fNRuH9O0357T2UxVEBl4dnWuon2nHsY33LwTO6Ea58e1tTqY8MDzqX5uvn2WVnPo6IcdLUTlMsYuYZZkDxWdItVrMWTOM0m1fmA/D6Rx0+02/NU/4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 04:10:24 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 04:10:24 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: fix possible buffer overflow caused by bad
 DMA value
Thread-Topic: [PATCH] usb: cdns3: fix possible buffer overflow caused by bad
 DMA value
Thread-Index: AQHWNjHPz6qvJgpZ+karMYRZFy9ss6jDKN4A
Date:   Mon, 1 Jun 2020 04:10:24 +0000
Message-ID: <20200601041048.GB13752@b29397-desktop>
References: <20200530032400.12743-1-baijiaju1990@gmail.com>
In-Reply-To: <20200530032400.12743-1-baijiaju1990@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28dd596c-3efd-49fb-026b-08d805e1b592
x-ms-traffictypediagnostic: AM7PR04MB7096:
x-microsoft-antispam-prvs: <AM7PR04MB7096408699CAD54F25AD47AF8B8A0@AM7PR04MB7096.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A2pk6eyvjeSKTXuzVZYtWz/3PcF3NJvQczPwLSHPwySUMvILC+QEiwhAkeow0jSBBU3aD0Ccy9i5itJEcwXbQna7FExq5nEYtPHZmPJojraoJWg8hptC8u6OMzuYqNVvCpU9YL4QjES+idXGkBDfhnywMSX1rFbW5/DHYDBnaCggndT8MJdNPCLVXZMbdE5tQJyOJv1ajkqIQyX3KycQx/A6vOoEK1JIPNygiNdI8b7/r4LAK83Gllkb8yz/+VHadlGft8Qa17UKh/NyXmW/bPoGwwPRxuJYXdDjNGcQf49utohNW6XF8MgSInIi6WFBOzfuA3PqVDyPndIHp6Q0DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(66556008)(478600001)(64756008)(66446008)(9686003)(6512007)(8676002)(5660300002)(316002)(91956017)(76116006)(8936002)(4326008)(1076003)(66946007)(66476007)(44832011)(54906003)(2906002)(71200400001)(186003)(26005)(53546011)(6506007)(83380400001)(6486002)(6916009)(33656002)(33716001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Mx7HIYQ+L2PQEESqzVcaT1eKvl/LPaGd/Bv47orp+SbugaARaV2AX/uXtE8AsIRfKcoU+OnQsDRYdudj+G6a9nvK5MrehAAzQpxCMCcKCwznrUt9IaNeZBp7P4/kbTF9mQkHW1GJyk0NLcms6lIAKDX6Xw7UB0GXPnvWdC2QwjADOwBMblw/ulRN8oelzWPSOaDwTGH0CjvLng42KcWPqTAkllG03TPbNgX0fvcEKD09TMLveQbLYGEleFb2mrUeAEsNGdIZmNoUBeySe858MmWE54a8LugDECFZXmg7zzrZjpPxGkgiWJqlCaigJneEGdaLfTXcqD3LLg5qXasHTsUBevlgqYTFx6OMzvn+/IVJUOIO4WJFQf17vQcDqiERKpzzcl7ViLFb9vY4MQ3jB3XdbyPNOYaNa5ckApUDhFzBejoZzu2/f30J0qSTFljfDTSOo3tc60WVuGr7gd2llYBy1sFPyzYm0gOsQZ8RgCw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DFBDA757AA7E047A20991C996909877@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dd596c-3efd-49fb-026b-08d805e1b592
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 04:10:24.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UT6gjy/IQETs6N5KOPBsIiYgrw056Eq/YEV1Xjq43k0ila94ietYwMdsx0dhMOzZWug8OBBQFm93Ho5I/ITLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-30 11:24:00, Jia-Ju Bai wrote:
> In cdns3_ep0_setup_phase():
>   struct usb_ctrlrequest *ctrl =3D priv_dev->setup_buf;
>=20
> Because priv_dev->setup_buf (allocated in cdns3_gadget_start) is stored=20
> in DMA memory, and thus ctrl is a DMA value.
>=20
> cdns3_ep0_setup_phase()
>   cdns3_ep0_standard_request(priv_dev, ctrl)
>     cdns3_req_ep0_get_status(priv_dev, ctrl)
>       index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
>       priv_ep =3D priv_dev->eps[index];
>=20
> cdns3_ep0_setup_phase()
>   cdns3_ep0_standard_request(priv_dev, ctrl)
>     cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0)
>       cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set)
>         index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
>         priv_ep =3D priv_dev->eps[index];
>=20
> In these cases, ctrl->wIndex can be be modified at anytime by malicious
> hardware, and thus a buffer overflow can occur when the code
> "priv_dev->eps[index]" is executed.
>=20

Did you see the setup buffer is overwritten before the setup handling is
finished?

> To fix these possible bugs, index is checked before being used.

I think the better fix is to use one additional buffer for struct
usb_ctrlrequest, and copy the dma_buf to it after setup packet
has received, then use the value stored in this buffer for later
operation, it could avoid quitting the code which is useful in fact.

Peter

>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/usb/cdns3/ep0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> index e71240b386b4..0a80c7ade613 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -265,6 +265,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_devi=
ce *priv_dev,
>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>  	case USB_RECIP_ENDPOINT:
>  		index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
> +		if (index >=3D CDNS3_ENDPOINTS_MAX_COUNT)
> +			return -EINVAL;
>  		priv_ep =3D priv_dev->eps[index];
> =20
>  		/* check if endpoint is stalled or stall is pending */
> @@ -388,6 +390,9 @@ static int cdns3_ep0_feature_handle_endpoint(struct c=
dns3_device *priv_dev,
>  		return 0;
> =20
>  	index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
> +	if (index >=3D CDNS3_ENDPOINTS_MAX_COUNT)
> +		return -EINVAL;
> +
>  	priv_ep =3D priv_dev->eps[index];
> =20
>  	cdns3_select_ep(priv_dev, ctrl->wIndex);
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
