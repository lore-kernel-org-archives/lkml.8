Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE4020890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ftW5OuYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgGDKmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:42:54 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:31874
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgGDKmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9R7kYkV0p9JpF2OdPdNaMPztM3AGOhZQoMyaOO1WRjRM74ygl4aRA1rjIMrGySTdM6I69T3OsBfykbY3KBfynxe8FbZ8nTXTMc432Xrpgc62rCGNtEGrux6niC72hO18nZqJVoDCe7mdrENeaY/kIFHFjWW5Lq98ARqNJrGrQOdjeNseg3H03mw+MX/rw+tuaRtWLgk+FgNq88lTorseb8qnmuwLQduqg0qqd+6yeSEcFmyV+yqTEC3g3GPf4zHUlRp4BYPXSYX7nI9DA96VxR+vUVNm7CzZRLDHVDCV6USWNZSKlRDRl4JTDTb9Dv2sJuA5EEnFzguRavPkkOEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12U8hZi32/kUn1f0scFTlV2/AmCA7cKWSQ4cRFj6mQ8=;
 b=Vjniqdbm7xuCq8+HQwRsDXfq5dnqGDSnf5U092t5M1QsyjBCx+g25MbYzfuDlDeTNuf8p33fzh6wfGHrWsivekjPavF+ODFM9oM09Df0zr8nyWHE8gG+KU2G3cvhQ+Q7dZ00U8hc5oaRjs5bXMw1oBcdqXYsCvIe0pglZaXxT/9AbJTCnHJNtTEBYswa9nMAl6E411LQx9SrmpoCrYNp1taIa4Vs8VL5KlFkrZ0tTo5KFxzi43OvPKqZ6x7wjfNT3m0n2iM9LfEOzfJtP5+PpRixM6bEPm637HDuojEj/Ojb4i8U8owSDfOOxfkR7iEeh1NQ005hNhLCdGzVJ6jNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12U8hZi32/kUn1f0scFTlV2/AmCA7cKWSQ4cRFj6mQ8=;
 b=ftW5OuYfBaimHXJIh9WMtWvvD08mXijmoF5xdTAMm/flb1xTrZBtFoD7+vV68lS3zi1C9aBGKsmGlQTRW4gZ2fK3YQJ8Jpa1eCJ+ID40wVupwGRtygLZVnxVMIiG6ZpiictUFfxvBM6CbcF7ZYwK3X+8YWeGOGgiYpGzZQMQFn8=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR04MB3026.eurprd04.prod.outlook.com (2603:10a6:206:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Sat, 4 Jul
 2020 10:42:49 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Sat, 4 Jul 2020
 10:42:49 +0000
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
Thread-Index: AQHWTlKTg5pjRWaycU+d+M1I+15YcajwZ1GAgAVKcYCAAZFcAA==
Date:   Sat, 4 Jul 2020 10:42:49 +0000
Message-ID: <20200704104258.GB5695@b29397-desktop>
References: <20200629201845.28138-1-ruslan.bilovol@gmail.com>
 <20200630015843.GB12443@b29397-desktop>
 <CAB=otbSnP7ecO9W5osxqSHSa4JRCUU4KR-g2BjBweDBUwjWobA@mail.gmail.com>
In-Reply-To: <CAB=otbSnP7ecO9W5osxqSHSa4JRCUU4KR-g2BjBweDBUwjWobA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fcc686f-8752-46b8-bd9a-08d82006ff49
x-ms-traffictypediagnostic: AM5PR04MB3026:
x-microsoft-antispam-prvs: <AM5PR04MB30265541829A37C168B4E4678B6B0@AM5PR04MB3026.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:245;
x-forefront-prvs: 0454444834
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgsuQI5YpIn6GQWb/2fpQ/uJtuf7lMnAVnjtpDg93KwoIgBU7pwg3iV3t9mwDt0ajUSpNHjOpqMrt3wz67TiOYdNiJ1xjcdnbiS/S7SXSdry32UzcQ1PQ9siuNGx0/lpli4udMOHQYkGG/lZ3gQDgo4WtDhR6WddlXahC4lIlp+rCVeBZMCZ/4D3XFbOUYIbm4m1t57spVv/ezC64mOc0QPaQ+LgdVkizzbcc9lfEeZdn2dUYf/ppkvKtIK4v1P8rka5ayhnpIbxNi21rLRZGN1397PJNVhasc1Qb33WMEpA2ww4GSh0H2xaA1XtlyFWlKRqUNPZ19ivJFQq4myJbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(54906003)(6486002)(6512007)(9686003)(86362001)(4326008)(44832011)(8676002)(8936002)(53546011)(2906002)(6506007)(33716001)(478600001)(186003)(26005)(33656002)(91956017)(76116006)(6916009)(66946007)(5660300002)(316002)(66476007)(71200400001)(64756008)(66446008)(66556008)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GxoUN8QbSNaFE7Hxn9mQXauQu9gGDfHH1cWq8V53VZ0JRsFS2SAfAdXgWEtdBbzYAGbiO0tqFtWE+gZCtMoqhOlJXXChC1+31VoUJt65oq3OS+HOYIrRCiEY9rBpzQdU9GQrlhZp3/AGTyzOMC2VVRIx1LPchzpSnCV6LwuRFweWcw8OKzV/yz0QhMKMF43HGBgUKIqBxje/PkFBD31Sr5/Y7Q6yjBISgot9vNPGuBigQhiELNRiTtBYY+FvBFvGFnCSqCo7x9FSilELx5YqThEztWDC33LcCy0w9X8FkEAQnEyq/8ZXGW0MPW/GVmXAtyary8N6fnZP6VSh+4E9TY3wMGZoi1c98OfQWQ7yuHMe00WJuWhUyfzZ6bRw1Hc6gpE/WZfrV4E22weTQwjZ6xiJwnuBKdM/Ie0dQYZB74/1wNCyl4XAgry41Bi++MZPgs5AXyViDVSs/+cly1s85CnBzN1FLVsT+QcFwvF/XkQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3309747428F6324B90A630E7351E5EE3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc686f-8752-46b8-bd9a-08d82006ff49
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2020 10:42:49.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPUVYNPvUCXesKmEg/03dMf3pEQAG6ziNDjFheCO6VotMOvfB7w7tB7koawYOd65sNkl3J9UF9kWVo5tWUJhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-03 13:46:27, Ruslan Bilovol wrote:
> On Tue, Jun 30, 2020 at 4:58 AM Peter Chen <peter.chen@nxp.com> wrote:
> >
> > On 20-06-29 23:18:45, Ruslan Bilovol wrote:
> > > UDC hardware may have endpoints with different maxpacket
> > > size. Current endpoint matching code takes first matching
> > > endpoint from the list.
> > >
> > > It's always possible that gadget allocates endpoints for
> > > small transfers (maxpacket size) first, then larger ones.
> > > That works fine if all matching UDC endpoints have same
> > > maxpacket size or are big enough to serve that allocation.
> > >
> > > However, some UDCs have first endpoints in the list with
> > > bigger maxpacket size, whereas last endpoints are much
> > > smaller. In this case endpoint allocation will fail for
> > > the gadget (which allocates smaller endpoints first) on
> > > final endpoint allocations.
> > >
> > > To make endpoint allocation fair, pick up smallest
> > > matching endpoints first, leaving bigger ones for
> > > heavier applications.
> > >
> > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> > > ---
> > >
> > > v2: rebased onto latest balbi/next branch
> > >
> > >  drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
> > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epa=
utoconf.c
> > > index 1eb4fa2e623f..6c453b5d87bb 100644
> > > --- a/drivers/usb/gadget/epautoconf.c
> > > +++ b/drivers/usb/gadget/epautoconf.c
> > > @@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
> > >       struct usb_ss_ep_comp_descriptor *ep_comp
> > >  )
> > >  {
> > > -     struct usb_ep   *ep;
> > > +     struct usb_ep   *ep, *ep_min =3D NULL;
> > >
> > >       if (gadget->ops->match_ep) {
> > >               ep =3D gadget->ops->match_ep(gadget, desc, ep_comp);
> > > @@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
> > >                       goto found_ep;
> > >       }
> > >
> > > -     /* Second, look at endpoints until an unclaimed one looks usabl=
e */
> > > +     /*
> > > +      * Second, look at endpoints until an unclaimed one looks usabl=
e.
> > > +      * Try to find one with smallest maxpacket limit, leaving large=
r
> > > +      * endpoints for heavier applications
> > > +      */
> > >       list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> > > -             if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)=
)
> > > -                     goto found_ep;
> > > +             if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)=
) {
> > > +                     if (desc->wMaxPacketSize =3D=3D 0)
> > > +                             goto found_ep;
> >
> > Why you do special handling for this? You still could give the smallest
> > maxpacket_limit EP for it, right?
>=20
> Of course it's technically possible. However in case "wMaxPacketSize =3D=
=3D 0"
> gadget driver wants to get maximum possible wMaxPacketSize from endpoint
> configuration and I was thinking about avoiding regressions if we always =
provide
> smaller endpoints.

You may only want to change the match logic, not but the special case.

Currently, it returns the first matched endpoint no matter
"wMaxPacketSize =3D=3D 0" or not. And you changed the match logic
as returning the smallest maxPacketsize endpoint, you also don't need
to consider whether "wMaxPacketSize =3D=3D 0" or not, otherwise, it may
introduce the complexity.

Peter

>=20
> As I can see, providing smallest endpoint that matches requested wMaxPack=
etSize
> is OK, but if gadget driver just wants autoconf core to use it with
> maximum possible
> value, I'm thinking now if we can even change this part and if wMaxPacket=
Size
> is zero, find endpoint with maximum possible wMaxPacketSize
>=20
> Does it make sense?
>=20
> Thanks
> Ruslan
>=20
> >
> > Peter
> >
> > > +                     else if (!ep_min)
> > > +                             ep_min =3D ep;
> > > +                     else if (ep->maxpacket_limit < ep_min->maxpacke=
t_limit)
> > > +                             ep_min =3D ep;
> > > +             }
> > >       }
> > >
> > >       /* Fail */
> > > -     return NULL;
> > > +     if (!ep_min)
> > > +             return NULL;
> > > +
> > > +     ep =3D ep_min;
> > >  found_ep:
> > >
> > >       /*
> > > --
> > > 2.17.1
> > >
> >
> > --
> >
> > Thanks,
> > Peter Chen

--=20

Thanks,
Peter Chen=
