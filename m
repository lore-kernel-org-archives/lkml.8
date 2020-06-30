Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B883C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5664620780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="muggFYDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgF3B6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:58:24 -0400
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:41016
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgF3B6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe9YTeY0YYjJM3zcm9oDCNzhKjPMEPOTNxCUljjSsBRXO4yh/IliC6Uqzssb5X2yW7O+5UtzFprbyBpg3evp4+AlP8o8NRKYA8n3tZ1IgyllG9HplaAFPN48eogcDiWg96I9Luv6rW4+8u3EGYZzfzl1cSv7y+De3UP061EyoYqmAiFVaMPHEKMdQHuCv5OBlSr7GyeF01RxACVDMzSKBY7vMrqMuIoR61J49/mtte2eSBhBDEUwLVxlDrhh6vw24xlCzMMsi6FPNxfkdqVsEYy61WE1nmNjlaTw6mtRhe0WfsQc2dWf4NhDUrhKy5F3Tv4iCfxePU90bNFFGPu63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Koq57J4L28uM0G799RDhTNT8kahbZabY3ssr074aPdY=;
 b=JAURqsjaVuWr2/Be/cKRvRW12zU4e/bQNUTISURZoyCwBkGZBdQMje36wYKcP0LTJzXd9D4j/ubytvngnBWdlur2fryqAeUZKzjiTmGhGBYlkxwEmMXvpBekn85rw9mwQkEDcHwZx72AU4NAFPB0KgScqW8vf6z7vBHpZc8NHN+O3sJdJ5JHOxz2WrEYHDC/v4+OM+OCis7UJBNp2IZsR1CZuhsryuGwVMDUn2/nl/6D2DzjYAW86zN2o1RAXl05VLp8RsBoy5/iEs0pUDe/+erMrATCyyWnK9AhFoYYg92U50GBsEFtLuwWjsNtTjiLRg301O6wjRuAwnnk2nuUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Koq57J4L28uM0G799RDhTNT8kahbZabY3ssr074aPdY=;
 b=muggFYDpf8V4cjorFkzDbSVbAwjVLD6Qh2B7lbGEaezrtpo/nZE9O5u0LgtWcx65UbcIa4esVoVOmXtzfc0MQZkBC/0GjHOUd3o1+2zTAMMTuSXaDiNvb7HefrjNauBSQkUyN5I374MYUyz84u5mYdFDqYSPs/OAzYsO6Exi4G4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6551.eurprd04.prod.outlook.com (2603:10a6:20b:fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 01:58:19 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 01:58:19 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: epautoconf: claim smallest endpoints
 first
Thread-Topic: [PATCH v2] usb: gadget: epautoconf: claim smallest endpoints
 first
Thread-Index: AQHWTlKTg5pjRWaycU+d+M1I+15YcajwZ1GA
Date:   Tue, 30 Jun 2020 01:58:19 +0000
Message-ID: <20200630015843.GB12443@b29397-desktop>
References: <20200629201845.28138-1-ruslan.bilovol@gmail.com>
In-Reply-To: <20200629201845.28138-1-ruslan.bilovol@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39b77814-5200-46ac-3fc9-08d81c991003
x-ms-traffictypediagnostic: AM6PR04MB6551:
x-microsoft-antispam-prvs: <AM6PR04MB6551B060B71FFD113F765D498B6F0@AM6PR04MB6551.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:234;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0MAz8piBHg9rejQjbdx94H1yd7nqI+cAW7IPCvNw7HB1PnWeDySDQwNUNCLAhkBPnKQZlEJMwLzzUEZ4iWjmDa4eOaDq1vsMr1/hI/2rOdCAENGZ+rfJ1GO/78+OQqj4lcSBqxJVmcmN7zQROV2HvtjoPWfxpToU/9UKau6R/VW2pukh/qZ073y+DPX/GZgpSf6+JJQXIkTBhkzhEMkOD4SDhB5S+ELmc6sJgVU8hwCuSXluKg6GXSSWkgw/jnEooRpMg4K6Em4eb39YZ//HokkhS/Wfz/9XP6afqV1aGT3lGZY3kT1YK/S2DTQpmkzb6CO8gCdWxuLNxL6UbZatw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(2906002)(33716001)(44832011)(6512007)(9686003)(8676002)(33656002)(478600001)(86362001)(26005)(6916009)(186003)(54906003)(6486002)(71200400001)(6506007)(316002)(8936002)(66946007)(76116006)(91956017)(66446008)(53546011)(5660300002)(66476007)(1076003)(83380400001)(66556008)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CVGSKq+4+8/avfkdl7nl369nMDoVQu4OYamrzbeZokGRb03vZGSFzHx3vjCKJlRUgBCpkP0cdgobeDzew/czY/yFpkHz95y8AK0VJ6wsAq1E1tOwylA5BeH+JejUUx/tLhrbps7ywt32/aT/HXmccTgf2sjjToGWiXZv1nEHKJfkPl8zRNe3950OhxEGBItgOmsYYxtktK04FQ9k/eIxm0/CNfptWWBlpZe6JRuRjen/qzZmI+Z4Jj9hcNJjYdxXSMiY/psJn47XHiLnDiucALzz2/FT7iZ2IhNm2bV6xDtPt99YRFsVMH9nexdEWKTRDow85q2HWO8S0EqzFzK3jW7ZKb7nG8xWhrHE4EQf1S7Y2oh5ATYDZEFoZ3mWhSOqotTH5CpzUO2ssT4Nl9q4NdS+p5EFSKjvoS/BgFLwVy1mohFAl9dZlG6Y5SuahfEmNpHxkCEnQLbrqfXJ1fQllbn+xKLbX8FJ56rWs6lF7JM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D32088B65AECB64C9F8E0F709B056022@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b77814-5200-46ac-3fc9-08d81c991003
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 01:58:19.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRCwtQrEv7w7K2EaXw126Xv5dVG8/5sATlxZvDhPBpmJziGB3/Mh0p0xCwH/joSYftaRbyl/2vchbRmI0jGnfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-29 23:18:45, Ruslan Bilovol wrote:
> UDC hardware may have endpoints with different maxpacket
> size. Current endpoint matching code takes first matching
> endpoint from the list.
>=20
> It's always possible that gadget allocates endpoints for
> small transfers (maxpacket size) first, then larger ones.
> That works fine if all matching UDC endpoints have same
> maxpacket size or are big enough to serve that allocation.
>=20
> However, some UDCs have first endpoints in the list with
> bigger maxpacket size, whereas last endpoints are much
> smaller. In this case endpoint allocation will fail for
> the gadget (which allocates smaller endpoints first) on
> final endpoint allocations.
>=20
> To make endpoint allocation fair, pick up smallest
> matching endpoints first, leaving bigger ones for
> heavier applications.
>=20
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> ---
>=20
> v2: rebased onto latest balbi/next branch
>=20
>  drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoc=
onf.c
> index 1eb4fa2e623f..6c453b5d87bb 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
>  	struct usb_ss_ep_comp_descriptor *ep_comp
>  )
>  {
> -	struct usb_ep	*ep;
> +	struct usb_ep	*ep, *ep_min =3D NULL;
> =20
>  	if (gadget->ops->match_ep) {
>  		ep =3D gadget->ops->match_ep(gadget, desc, ep_comp);
> @@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
>  			goto found_ep;
>  	}
> =20
> -	/* Second, look at endpoints until an unclaimed one looks usable */
> +	/*
> +	 * Second, look at endpoints until an unclaimed one looks usable.
> +	 * Try to find one with smallest maxpacket limit, leaving larger
> +	 * endpoints for heavier applications
> +	 */
>  	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> -		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
> -			goto found_ep;
> +		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
> +			if (desc->wMaxPacketSize =3D=3D 0)
> +				goto found_ep;

Why you do special handling for this? You still could give the smallest
maxpacket_limit EP for it, right?

Peter

> +			else if (!ep_min)
> +				ep_min =3D ep;
> +			else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
> +				ep_min =3D ep;
> +		}
>  	}
> =20
>  	/* Fail */
> -	return NULL;
> +	if (!ep_min)
> +		return NULL;
> +
> +	ep =3D ep_min;
>  found_ep:
> =20
>  	/*
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
