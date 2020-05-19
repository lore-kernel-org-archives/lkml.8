Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893932075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FI7K1tez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgESARQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:17:16 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:45550
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbgESARP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8BZwTnSqfw/mopkNh3F/9wguaJ8PWf5YnnGjgMB7Cw3/tZK9CIICJ9NzsDEkji2ZVHPFgtxyx+SEKU+K2IlEzNBoaQCj81P0+qw2J5li2VPEUQEkGGpHUTL88CXd95GgHyf0sWY5Hl5QIe9KX83EGHjZS3nlNJALDYDLzG9rtjOyWeHcfhVyZGSsL+IXWZsC4ijk3CSrEAK8mYPhXl51G/4gGBs0+bY/LmeRvh/27pFW4b00/mg7EXa4EsDKqIN/mTMsMSysHpaxEek4Xw+4Lmn+NhdqbyJfcWU56NYrBjcJ90AQUtWeU7Uos/FCAjFb8FPP5VLELnRD0hbSSjkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5KdXLyHTuAP1kDuGzZgLusDTq/AkK8nxRZ3hRHfTlg=;
 b=ZlN65DNjiP6wbHKmzRyVGpRJc8EZEd83glBmV8JSLi+csE9C84F7h1CBc83Hm2FHhRGKjk+Fa9cFwXQXzfD5Y0V6tbR/byCD5/neDdHhKJvJuFCzHWyadzLhC2psusARLldgSaZvzPt5SWw51wCSx567dHJ/Z7I+oGg3Dvty/AFIw5/0Kj47CwQwwuyoXZSGDUfuQ7PJIh7BzFHHOqZRqEJTMcKEL/ekQh/F/rvpKCAtBzN2lIe6gMH7QDjRIwEufqhFBmm1ZMWK2eSUMnou02GM5kafm92ogOUkveLua4C+ZdglbLZHaYxBfNhQulZp7uZfJIe8tc62as59E4c6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5KdXLyHTuAP1kDuGzZgLusDTq/AkK8nxRZ3hRHfTlg=;
 b=FI7K1tezRgNvJ0dAMq3i+hIJv6lvpMBaBpJoG1VKW39DPhOOnNOilieQT5tNIf084b6rjg+6CCSYviZ0IwwyvoHSfvwpSJMDF4e48OSO7Ib5cYYpdeqnPwMei2I3GByYqyTeAyT963bB8+xmPA8QiX/JC+ujuvSeoLZbDTrea/I=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 00:17:09 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::7c34:7ade:17d0:b792%9]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 00:17:09 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v2] usb: gadget: Fix issue with config_ep_by_speed
 function.
Thread-Topic: [PATCH v2] usb: gadget: Fix issue with config_ep_by_speed
 function.
Thread-Index: AQHWLXLWiBgnUIlSFEeJ2Nea8YHp9g==
Date:   Tue, 19 May 2020 00:17:09 +0000
Message-ID: <20200519001734.GA2659@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b46cb641-87cc-4e3e-88be-08d7fb89f8cc
x-ms-traffictypediagnostic: AM7PR04MB6887:
x-microsoft-antispam-prvs: <AM7PR04MB6887A591A00F8ED2296193738BB90@AM7PR04MB6887.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G70uMQiuzR75XCcOo+CciCacfWU3kqdoGMwDfHGx8y96SiJajanqG9mwqK/iYi2uSFU+5S7aWGGmq0rkuPcrZHnbG+wtizfyg72f3N0cMWel46taxkG7pyCmY8tmihfe0IZygaBFR6seHoIxEbRnBq8gNpm2EHfne7NixumTJgRG/MpcO1kTbS3QnH01GJoVH+Ffs7JQ3BwXz+1V22km5f8Cfige7lzHpbkcv77x+zyKxDjVb/DDPhRGmTWCCa7qWUpBrTor3opjs+Xros8nhPAvJKNYjVY5QmkNlO/IwG9uU235e40PFba39pfobsWjpgMjuSo2UhvwVKS1e9VI0YBOWrUN9klvxhdD0TF/+7ldc1Yc3fYDtmAgNsM53EerX9U5WdJnW00FjEYXF11+S8yZWLcIJOBKqrPPV1y0xVs+37WCG8CiJrNVcYrd7ytb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(6916009)(8936002)(76116006)(66946007)(66476007)(54906003)(66556008)(66446008)(6486002)(64756008)(5660300002)(1076003)(6506007)(478600001)(316002)(7416002)(186003)(8676002)(6512007)(71200400001)(9686003)(86362001)(4326008)(91956017)(2906002)(53546011)(33656002)(44832011)(33716001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FaWxbLXhc8p9ro7SD0idjxKnH94MwtBaCuLNtgXP+jB62p+bvrBMS7NOswn6G2WNrA/FfRtYynB4AnJh1Zfvqy+phwenNLx2d42GYfBY6R6P2db9YXGTbhHkflEc5T5CdoV/PSQo21CJwUHBtonj5toVnUThKrEbLvU5HtzGeFLo/4IJhbvzf6oQXT6lCQNs0sdMO/a5IreeTZMgr5fL1dFG2MHMKfo1gf5WgLQX77GWEpjZe1zH9xtfkGUVGJIU39tOoucb1Xg63gSElQh0PEkeLZ6Cnlnrs4nQdxY5OjANhv3/bkYQ9dyCCWaFgoKxvlwuxAUrxx4dy+xn5w1K0K8enPbNkp97EJHIUspX9KJfL/3KLQK76rTBBflg4UBB7Q18Itpq1bR+jIMpwGmvjbJHKCWM/7bUvcrWT87tZ2EIt/W2SIcKtDbYzAJrGZhpEDU93fPu9MZPW4EYGPCJVLqko79ei3ye365YSPt/CNS7WxUI/9AhAnIUd3921skT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B0F89A0A4786C459368F444A6FD6A43@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46cb641-87cc-4e3e-88be-08d7fb89f8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 00:17:09.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufucYVG/UqwbF4Vgzj0+KS1JA0dTroxxoTSpq/YpGktVFCj0oyBX4pPyy3KAOqEfddZQYLxqUPn4nsSHMe0f/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete '.' at the end of subject.

Reply-To:=20
In-Reply-To: <20200518100844.28293-1-pawell@cadence.com>

On 20-05-18 12:08:45, Pawel Laszczak wrote:
> This patch adds new config_ep_by_speed_and_alt function which
> extends the config_ep_by_speed about alt parameter.
> This additional parameter allows to find proper usb_ss_ep_comp_descriptor=
.
>=20
> Problem has appeared during testing f_tcm (BOT/UAS) driver function.
>=20
> f_tcm function for SS use array of headers for both  BOT/UAS alternate
> setting:
>=20
> static struct usb_descriptor_header *uasp_ss_function_desc[] =3D {
>         (struct usb_descriptor_header *) &bot_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,
>=20
>         (struct usb_descriptor_header *) &uasp_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_status_desc,
>         (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_status_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
>         NULL,
> };
>=20
> The first 5 descriptors are associated with BOT alternate setting,
> and others are associated with UAS.
>=20
> During handling UAS alternate setting f_tcm driver invokes
> config_ep_by_speed and this function sets incorrect companion endpoint
> descriptor in usb_ep object.
>=20
> Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this
> case set ep->comp_desc to uasp_ss_bi_desc.
>=20
> This is due to the fact that it searches endpoint based on endpoint
> address:
>=20
>         for_each_ep_desc(speed_desc, d_spd) {
>                 chosen_desc =3D (struct usb_endpoint_descriptor *)*d_spd;
>                 if (chosen_desc->bEndpoitAddress =3D=3D _ep->address)
>                         goto ep_found;
>         }
>=20
> And in result it uses the descriptor from BOT alternate setting
> instead UAS.
>=20
> Finally, it causes that controller driver during enabling endpoints
> detect that just enabled endpoint for bot.
>=20
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
> Changelog:
> v2
> - redefine config_ep_by_speed() instead removing it.
> - remove changes from f_tcm.c file.

I think you may add f_tcm.c changes as the second patch,
since it is the user for this patch.

Peter
>=20
>  drivers/usb/gadget/composite.c | 78 ++++++++++++++++++++++++++--------
>  include/linux/usb/composite.h  |  3 ++
>  2 files changed, 64 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composit=
e.c
> index 3b4f67000315..858a71fbcd13 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -96,40 +96,43 @@ function_descriptors(struct usb_function *f,
>  }
> =20
>  /**
> - * next_ep_desc() - advance to the next EP descriptor
> + * next_desc() - advance to the next desc_type descriptor
>   * @t: currect pointer within descriptor array
> + * @desc_type: descriptor type
>   *
> - * Return: next EP descriptor or NULL
> + * Return: next desc_type descriptor or NULL
>   *
> - * Iterate over @t until either EP descriptor found or
> + * Iterate over @t until either desc_type descriptor found or
>   * NULL (that indicates end of list) encountered
>   */
>  static struct usb_descriptor_header**
> -next_ep_desc(struct usb_descriptor_header **t)
> +next_desc(struct usb_descriptor_header **t, u8 desc_type)
>  {
>  	for (; *t; t++) {
> -		if ((*t)->bDescriptorType =3D=3D USB_DT_ENDPOINT)
> +		if ((*t)->bDescriptorType =3D=3D desc_type)
>  			return t;
>  	}
>  	return NULL;
>  }
> =20
>  /*
> - * for_each_ep_desc()- iterate over endpoint descriptors in the
> - *		descriptors list
> - * @start:	pointer within descriptor array.
> - * @ep_desc:	endpoint descriptor to use as the loop cursor
> + * for_each_desc() - iterate over desc_type descriptors in the
> + * descriptors list
> + * @start: pointer within descriptor array.
> + * @iter_desc: desc_type descriptor to use as the loop cursor
> + * @desc_type: wanted descriptr type
>   */
> -#define for_each_ep_desc(start, ep_desc) \
> -	for (ep_desc =3D next_ep_desc(start); \
> -	      ep_desc; ep_desc =3D next_ep_desc(ep_desc+1))
> +#define for_each_desc(start, iter_desc, desc_type) \
> +	for (iter_desc =3D next_desc(start, desc_type); \
> +	     iter_desc; iter_desc =3D next_desc(iter_desc + 1, desc_type))
> =20
>  /**
> - * config_ep_by_speed() - configures the given endpoint
> + * config_ep_by_speed_and_alt() - configures the given endpoint
>   * according to gadget speed.
>   * @g: pointer to the gadget
>   * @f: usb function
>   * @_ep: the endpoint to configure
> + * @alt: alternate setting number
>   *
>   * Return: error code, 0 on success
>   *
> @@ -142,11 +145,13 @@ next_ep_desc(struct usb_descriptor_header **t)
>   * Note: the supplied function should hold all the descriptors
>   * for supported speeds
>   */
> -int config_ep_by_speed(struct usb_gadget *g,
> -			struct usb_function *f,
> -			struct usb_ep *_ep)
> +int config_ep_by_speed_and_alt(struct usb_gadget *g,
> +				struct usb_function *f,
> +				struct usb_ep *_ep,
> +				u8 alt)
>  {
>  	struct usb_endpoint_descriptor *chosen_desc =3D NULL;
> +	struct usb_interface_descriptor *int_desc =3D NULL;
>  	struct usb_descriptor_header **speed_desc =3D NULL;
> =20
>  	struct usb_ss_ep_comp_descriptor *comp_desc =3D NULL;
> @@ -182,8 +187,21 @@ int config_ep_by_speed(struct usb_gadget *g,
>  	default:
>  		speed_desc =3D f->fs_descriptors;
>  	}
> +
> +	/* find correct alternate setting descriptor */
> +	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
> +		int_desc =3D (struct usb_interface_descriptor *)*d_spd;
> +
> +		if (int_desc->bAlternateSetting =3D=3D alt) {
> +			speed_desc =3D d_spd;
> +			goto intf_found;
> +		}
> +	}
> +	return -EIO;
> +
> +intf_found:
>  	/* find descriptors */
> -	for_each_ep_desc(speed_desc, d_spd) {
> +	for_each_desc(speed_desc, d_spd, USB_DT_ENDPOINT) {
>  		chosen_desc =3D (struct usb_endpoint_descriptor *)*d_spd;
>  		if (chosen_desc->bEndpointAddress =3D=3D _ep->address)
>  			goto ep_found;
> @@ -237,6 +255,32 @@ int config_ep_by_speed(struct usb_gadget *g,
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(config_ep_by_speed_and_alt);
> +
> +/**
> + * config_ep_by_speed() - configures the given endpoint
> + * according to gadget speed.
> + * @g: pointer to the gadget
> + * @f: usb function
> + * @_ep: the endpoint to configure
> + *
> + * Return: error code, 0 on success
> + *
> + * This function chooses the right descriptors for a given
> + * endpoint according to gadget speed and saves it in the
> + * endpoint desc field. If the endpoint already has a descriptor
> + * assigned to it - overwrites it with currently corresponding
> + * descriptor. The endpoint maxpacket field is updated according
> + * to the chosen descriptor.
> + * Note: the supplied function should hold all the descriptors
> + * for supported speeds
> + */
> +int config_ep_by_speed(struct usb_gadget *g,
> +			struct usb_function *f,
> +			struct usb_ep *_ep)
> +{
> +	return config_ep_by_speed_and_alt(g, f, _ep, 0);
> +}
>  EXPORT_SYMBOL_GPL(config_ep_by_speed);
> =20
>  /**
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.=
h
> index 8675e145ea8b..2040696d75b6 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -249,6 +249,9 @@ int usb_function_activate(struct usb_function *);
> =20
>  int usb_interface_id(struct usb_configuration *, struct usb_function *);
> =20
> +int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function=
 *f,
> +				struct usb_ep *_ep, u8 alt);
> +
>  int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
>  			struct usb_ep *_ep);
> =20
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
