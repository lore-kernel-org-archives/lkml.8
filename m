Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0520870
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+NXfLRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCBKOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:14:16 -0500
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:52211
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbgCBKOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:14:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCJ3FDYcvv4FLS5Cx1b6IyEU7ZKRHlTtlwyOJOqPWFdPZlVdHxigG8yJSEsNV2ES1h4EE+w8rpcv/8+iH0PFwtF1u4E7aTjX18Yxis3URWXa/eFFDbMshicYFxPybXwbzcgwBx8p4YxS52h9uKODr8j36GboObp/STj0WjIamhOphzgZcUCxoq4BM46zyeIHh6jie/nTlJ0fZNBvOBqQwfjUgon3nYeJPrP9lXgFmuR4RmV37Rhj71kBtjxm8zjQT+vAkFB9B5T61AM7SAnNzN5YTZhCpPCQQsRW3jTb4bcDl0NVoEyYzGRQuubnfWxxcdtQqJ6zmsx/6sABgGLlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvsR+GnOmnLuv6yg1p4NBs1AqQWDGlyjZurJ/QItLV4=;
 b=CMT/aHTFImNEUMWr4UdDieRZ7vvsKNH7OM2cFKuJqVL8Sj2XVw85qY7K1lKoeddV+1dhzCgIKlGTOGbpdT6/SaPMTcynnZbYgmcG33/Ryc4ejhJSAIvZy9Emxz+oI84r6XzdQF9iP5xFwdxtqyuly0FHpCxc8TdNMKieJY4cJo9jymAjmWiZHNRFMp95LalzVZNHgbT4T6zpiKtVoRec7CkRtaSLIPUbHKvjKK3R12x2NTY4hGRC1U3n8Pojph4XNhEC4Nq0aBTw9RYjJBYMWlBSeyAsdrm4zqXfYm0MK8G+3ca+zm1oa+2fW6Hp38FZbpSVa0f1WUZMFUD7RS8Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvsR+GnOmnLuv6yg1p4NBs1AqQWDGlyjZurJ/QItLV4=;
 b=i+NXfLRdqdqu9e05JcRUWzV+auLDwNrUslHDN9RYFh9aCSuWf9jVNZC3FxXyNBq/pWEtQTNKowk8QKW0VPy6rWijqvJdg79gkq6oAF2C2NWsO2xPXDMHYt70/89d6x6dusUk51w5Zh3XK7034lNktLQMGX4CtP39FsAtfg1TRug=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5423.eurprd04.prod.outlook.com (20.178.124.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 10:14:11 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 10:14:11 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>
Subject: RE: [PATCH v2 5/9] usb: roles: Provide the switch drivers handle to
 the switch in the API
Thread-Topic: [PATCH v2 5/9] usb: roles: Provide the switch drivers handle to
 the switch in the API
Thread-Index: AQHV6wvzIyZpbIaiske1bsSyj2bnlKgqUqgAgAqNTQCAADDIAIAADpxg
Date:   Mon, 2 Mar 2020 10:14:11 +0000
Message-ID: <VI1PR04MB53278E3B1B3E1FE58C29C6B18BE70@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20200224121406.2419-1-heikki.krogerus@linux.intel.com>
 <20200224121406.2419-6-heikki.krogerus@linux.intel.com>
 <20200224131442.GA5365@b29397-desktop> <20200302062302.GE3834@b29397-desktop>
 <20200302091738.GB22243@kuha.fi.intel.com>
In-Reply-To: <20200302091738.GB22243@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [180.171.74.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bafa1861-8a13-491e-c6cc-08d7be9273ec
x-ms-traffictypediagnostic: VI1PR04MB5423:
x-microsoft-antispam-prvs: <VI1PR04MB54230D7303C485B8BEF9D4778BE70@VI1PR04MB5423.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(54906003)(26005)(2906002)(33656002)(9686003)(55016002)(66946007)(7416002)(76116006)(6916009)(86362001)(66476007)(64756008)(66556008)(66446008)(316002)(478600001)(71200400001)(44832011)(8936002)(81166006)(81156014)(186003)(4326008)(6506007)(7696005)(5660300002)(52536014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5423;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgcStndRvkYwW6i5sjaAyorvFlpyuAeWeFRnmPdbBGs6HK5PjvJDZ44+XbOfCiTHakz56HpSdyO1lk1bPKguUyqkdaeojE2ANrG8cbvHmsJ1jYE2YpXatOR+VreK1hVkg98B15/sdyJVxkTMVFeFXgZ4gEX/hgyrcPjdBIDJUphFLLfXCYi7eFzypT/JlWPkNjtfHuP+WELoWH4UxWwZ9ZjO5ryQs0f/AkfcKWO2zAGA4oP4jfnz4nw8hvYQv89Y5oYAANeiphVDr+yeISuchi8JyDEdQwCIDoEZ6l7QncteooII0boiOQAYJKjvnYfhCd9eeYsHT5egC2edVpPB0N/LHM0MPQbJhbbD18IMHS0CY/jZFmXneri480ods++d7F5n7IaGFkmfw0u1A4TZs/Z16/d6NSZ0O+gkyDEEgfC/YKuj3Op4X0FHCVXFRQ+n
x-ms-exchange-antispam-messagedata: Or2OiW29buS22q4+GkvwqdnjoC67v4DqFqldIrGTxy5uDeGASZxCVx3ednkMI804Rrh7eDrEMieETQR5Vb9pLYFlXn6t1srnHTRfGvGSfjb+6dgKyyqH/S09YYvfrCz8zOW0Bwp6RKbUp+NXpQx+Bw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafa1861-8a13-491e-c6cc-08d7be9273ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 10:14:11.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1qkCXeLhwPKOY3wlqGOw80mebN8Icx+UM5V4/fbx6Di4b8KR0ROnDIr3pprm8n/Uw3AfqC0ygSYGToEuRbgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> On Mon, Mar 02, 2020 at 06:22:59AM +0000, Peter Chen wrote:
> > > > @@ -613,9 +613,10 @@ static enum usb_role ci_usb_role_switch_get(st=
ruct
> device *dev)
> > > >  	return role;
> > > >  }
> > > >
> > > > -static int ci_usb_role_switch_set(struct device *dev, enum
> > > > usb_role role)
> > > > +static int ci_usb_role_switch_set(struct usb_role_switch *sw,
> > > > +				  enum usb_role role)
> > > >  {
> > > > -	struct ci_hdrc *ci =3D dev_get_drvdata(dev);
> > > > +	struct ci_hdrc *ci =3D usb_role_switch_get_drvdata(sw);
> > > >  	struct ci_hdrc_cable *cable =3D NULL;
> > > >  	enum usb_role current_role =3D ci_role_to_usb_role(ci);
> > > >  	enum ci_role ci_role =3D usb_role_to_ci_role(role); @@ -1118,6
> > > > +1119,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> > > >  	}
> > > >
> > > >  	if (ci_role_switch.fwnode) {
> > > > +		ci_role_switch.driver_data =3D ci;
> >
> > And chipidea code, better change it like cdns3's, otherwise, the
> > switch desc for all controllers have the same driver_data.
>=20
> That I'll skip after all...
>=20
> Note that since the context of the switch descriptor is always copied dur=
ing
> registration, the driver_data is not going to be the same for every switc=
h.
>=20

Yes, there is no problem now, just to avoid the issue if usb switch core wi=
ll use
each descriptor in future.

> The structure is actually filled in two separate functions, so the change=
 is not
> straightforward. We can still change that of course, but it's out side th=
e scope of this
> series, so it needs to be done separately.
>=20
=20
Ok, you could leave it like this v2, and I will do it in future.

Peter
