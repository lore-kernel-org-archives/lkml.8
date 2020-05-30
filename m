Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A608C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A96D20810
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KI3xuIfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgE3BDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:03:22 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:28225
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbgE3BDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:03:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pvmmz4k4fxbKUF9oJf5HGYefrEmUE85vjTybTYkFpA3lp4KwpIxXVnwAgm1zhwNrf3/3DA17MTAF6Ws6/x8NWH5mbyk5DbNVmUXgfjJpBqVDphHkmUEBs8P74o40pTkdWPbcJInJ+8CCXUIy/4+rmxRgGj5ZWfKkszOoMYMgH9vBlz9j2z+++mh9OZHYM8MlPXXLw6U3sQiPtf0GH0q2szbzDx1WaPQsM4NCgFtav1g0NbIumG8HWpIFABvTtntQ+MSxpdEnFnMFgcmiJN8GHNlpaXiqP8yg8V6o42IHqILzMThrOJdu3K/7q14N0jmZkOIGkFMbySy4AfzbcCQn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOePKroUVJb3gBd2FEocK4Rdeo6CVJKWCi8byr5s1RE=;
 b=LLiwCJxi2ha4B+gN1tV65TA7wL5+oKLlN4cwN6bhTmX0r9PlGvezDs3eut4m1t/TNeMTFQvhA/d5WnM4Adh4rbCbtHcb2Op1Rz3dH64SJSnoeIfhOA/y8LN3q6Xa3jSvMD+/xxt+ptnvAtWSqJ5YkpkfCxBrPOZ2g4vftXTJTPASXQHoXFzwT9d4B0h5l3TrrbJ+g25wlxqDF0U976TwlrYqR96LKh0r/E2k6GR6JBt3ynw69PTkhAYYDVkk6YD9C5wv2cWeEMqDnkQVJppVybvVoXgG2CZFNMyhbZ4GcWJjupb/72EyRkfLhsJ4jneLXeQzkbOig4UZImHnAgoEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOePKroUVJb3gBd2FEocK4Rdeo6CVJKWCi8byr5s1RE=;
 b=KI3xuIfMxGlLbG6qMFgTPJwTFK1uS7fNUnOch+evOIVtpYeVmKAef4CEuuAAkPaCHWQUN2apjWR1QkXz5qh1L5rhvyI2+89RTDTGUODwQFt9ATJf6g9ZTcB0U3Dr+WqmMS0JfO15jxGCoRkRWjuupdgQh+4JwuXZiSKOyfTil20=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sat, 30 May
 2020 01:03:17 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3045.022; Sat, 30 May 2020
 01:03:17 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Thread-Topic: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Thread-Index: AQHWNXESSGSOBa+W40WQH/z+ZHSm4ai+toSAgABgMwCAALdzEA==
Date:   Sat, 30 May 2020 01:03:17 +0000
Message-ID: <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl>
 <20200529081104.GD32755@b29397-desktop> <20200529135524.GA14614@qmqm.qmqm.pl>
In-Reply-To: <20200529135524.GA14614@qmqm.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rere.qmqm.pl; dkim=none (message not signed)
 header.d=none;rere.qmqm.pl; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [222.65.251.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2aa8973b-fb38-4ec6-8582-08d804353d31
x-ms-traffictypediagnostic: AM7PR04MB7031:
x-microsoft-antispam-prvs: <AM7PR04MB7031341929B3F240042DD3D08B8C0@AM7PR04MB7031.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cR+n99v4m7/YKTwYgFyf7XxLVSBhz7a3zrmX92dg/lVBJwnwUpeg4Lmbs6QL+bWpubhF54YrzYNKF5LhW3dvPORnmGZZrcnXU/YQPRq4gnU8V6iGGPOdGoS0VlBtPf8iqP6oBlcstMZdfXMyl6w2aMzJEbHgvhymnAdi+1OkkINoyLjs2M3EOGMXeImOud23antcT+s22vP2V//RBllMDh33dPo8KaqUxiQTccXM7BwviZdJ9J1U7P4k1lPvLe2sUx+IFOh+NaQy9edDLv4V75v0JMJWe+hXMeFpNymEdxB4xFlvUxZxeoUdvGAOOG7XmpKCgOcczKVQoSpuMG1cig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66946007)(55016002)(478600001)(76116006)(8676002)(2906002)(8936002)(66476007)(54906003)(66446008)(66556008)(64756008)(44832011)(316002)(5660300002)(71200400001)(86362001)(4326008)(83380400001)(9686003)(52536014)(7696005)(6506007)(186003)(4744005)(33656002)(6916009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 060+WhrxI+R3CkAEEBi74WpmDOwGolvogoIu7OPpaWPkBpDQEKdg0fETUvazs6SkUw0SPXcUS+mIzCylIRzt+S+6aXczOP7XCHpjfySBfLHToW84p89Cu7zRCUr1d9Uc9NSsu27AwDTqvwvSy9JmZtKEm5V4bLRgdt4ILlZK9ACcKBJ9Tk44SEQswdHvXR2e0h/4QZrOImrfQIhAczGCYns6lEi6FSjRsa4YVAk1lqisJlzA9BESDFyM1INtwU9JkaqD3wx+1JClCwU20KVtBmm+V/elmmqhNC0KYZLkJ/GTmhaqgoFtogyRyXgwsCXblJ+bTIVlcTC+QPD6GPt7TdVFP+Qhc/OZJ9Gtzej+31n3GX5+GBLt/GEGi/3u30CB2+MlqY3Qv8abCqiPcivlfMfQkoTHBEiV2jxRf951LZQUg6YBArZPlHTEtyN9dp8LkYgwX3ihlLIw1ORl/Zk2tVv0Sno725piRipoVqIvr3w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa8973b-fb38-4ec6-8582-08d804353d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 01:03:17.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAHf9NsT0oPSaegQQt4cw0VGRY6BrKC/6p3GqiVpcacq35YD8iIvcl1KCfo+blxndU4dVYxF5SGItHLMban6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> > > @@ -425,9 +425,11 @@ static int acm_set_alt(struct usb_function *f, u=
nsigned
> intf, unsigned alt)
> > >  	/* we know alt =3D=3D 0, so this is an activation or a reset */
> > >
> > >  	if (intf =3D=3D acm->ctrl_id) {
> > > -		dev_vdbg(&cdev->gadget->dev,
> > > -				"reset acm control interface %d\n", intf);
> > > -		usb_ep_disable(acm->notify);
> > > +		if (acm->notify->enabled) {
> > > +			dev_vdbg(&cdev->gadget->dev,
> > > +					"reset acm control interface %d\n", intf);
> > > +			usb_ep_disable(acm->notify);
> > > +		}
> >
> > But it does not fix any issues, the usb_ep_disable checks 'enabled' fla=
g.
>=20
> It generates spurious trace events if you enable them.
>=20

You mean the trace events from core.c? If it is, we could try to improve it
and indicate it is already enabled or disabled.

Peter
