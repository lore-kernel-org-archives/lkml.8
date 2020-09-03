Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA06C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7450E20684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRYkd9Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgICBqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:46:34 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:19778
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbgICBqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:46:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWCpqtzkFbjuCAwxwS4ENsZzf8zRxjC3aX3Qi7Hdi3w4+uc/3o0OD4z8X2BnF69vsHEN/T1guyRi68/ZT0A7Q6XANPWeiNniSH9utD5O5yqB5fCxMbR1zyx/Efu6qVg5k5950Dxf2OaCt2h0xdQfxh2qKpV0BO5mKJBh+VUFxWTylMglxfNMN88a90E8jnuYR2m13tjEeug7biZ9VbXoHwPRZnLYbCsezmmqldVgc7pos0mDFZPiU9jaZNN/y/h9A6lh+aONFDLpT5nXdcQmCQSN4F5ZnuWQxfi0P26K8S5PSlJ7F15yq9sFFoIU8bu5cXv/Mbl4jKDA9yQdQJTNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d1GUWl2/sxfOk/2bIieDSDP1jKcCFxpRcMUrv4Ka7I=;
 b=hX2fAwnM0MaII4b5aEGkFofFT7lNocLPjVoJeui7ELC10cMohNBrw+K9G7e8vBBwBdN1tpmbZXET81oMJgOslnRJqHGjSxjOY72KD9AC9/9QxAtpeCYwtaUJecDXsTlKnE3DTr+vMoUpbpAuPp6eNK9xImms4eMewf6jXHlRr4v/Gqu+PqUarTNy+SBMdFH+3Q8l4xSfoszka/XTb2qdKCjXWwhp3igp1uSSMB7xvk8l9c0H26KqQ1VIdT2+SXACjhnzJnUmTDL3mEs96SuvDQgAnGAyfOfIKeYlxa/WaTTRnUysf1WHU16E6+CukC+L/Su7vVJeDsjfqMG0UrdVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d1GUWl2/sxfOk/2bIieDSDP1jKcCFxpRcMUrv4Ka7I=;
 b=GRYkd9CeRP6GXN11yL62RR5/ky/0HwPvcHIfOYaARMs1BQFyRUt5frjXXKweud9QQQy2PW/vTn8oU44xczZ8kTkrGvV/5jwEKPJ64bp8SAiAjFFsVEX09ZBcz1VWLEG2JKgvcbxFOghI3toCD+m/rmwNEAu3HkFRARpWTPqLRQ4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6149.eurprd04.prod.outlook.com (2603:10a6:20b:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 01:46:18 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 01:46:18 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Thread-Topic: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Thread-Index: AQHWgJ2O9T1DMOMaDk2K+eB9hhc5F6lU0zIAgADNTACAAIY4gA==
Date:   Thu, 3 Sep 2020 01:46:18 +0000
Message-ID: <20200903014559.GB11250@b29397-desktop>
References: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200902053048.GB6837@b29397-desktop> <20200902174536.GE3419728@google.com>
In-Reply-To: <20200902174536.GE3419728@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58b94e27-fded-4492-a915-08d84fab26fa
x-ms-traffictypediagnostic: AM6PR04MB6149:
x-microsoft-antispam-prvs: <AM6PR04MB61493B639CF9DEA0E164C7038B2C0@AM6PR04MB6149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OA2jHcbPjNJRwPuAnAnPTKv1Y0NwbSYcbU6SzUhpPFdEjoX5QwH+BNBKqkaRgdok1SlfhZ9wr9wqIDSylmJPVqHalNU5fr6lFuNI2XkpQagfgCmjF3VYahVTlsh5y/D7YzcPgLg22GxogPoLkyn8CFJdtSHof01s79mPqaSKt1k40NyFmqePxi3Q8xgB9zvkCW+ViV7KMNiqf+oIL/nrnKntmdweP34G+I5clCh6AThl6FYrsBUyInNvtf5f/QpfWDaKeh8YdnyVC3MutJjt3BZ6C+XEYA7AAMDphPffp8M2SAZr1Ji+0pjasn+0yAYnDSjLmN+vijQKzHL7F9IVIetzRor1FawXit37BSW4xE2Acpl5u6OU3KrrNOQKMfvVuh6H1h1incaWUZpmUa1xuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(6512007)(9686003)(66476007)(71200400001)(2906002)(66446008)(64756008)(66946007)(66556008)(966005)(6486002)(86362001)(91956017)(478600001)(6916009)(26005)(83380400001)(186003)(76116006)(316002)(33656002)(7416002)(33716001)(8936002)(1076003)(5660300002)(8676002)(53546011)(4326008)(44832011)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dlfsyBwJlYIWj34qqgmEyh3oEDqaY5SBzQq86E6zbInKTGlBw111Pl2vHwsgZWdnfZkxCvMdQlzB8wITfLKcPcwZQhHaZsni5GcU2y1Ec9zQki5pny2qoZhO5MRMrVkWZP7YwgExCRdC+k86rhTcsJFCXWxwokySQpfduREj/TTdIAmkoCESsxUc7uflUd/SMPMdsHVwSyYhNfrYHNu+xJJ7RUGkuR8G8Bxtrdzh2XeCM/3Knui4YnP6SKUwvI3/XPl+7WCVUQ+ifOxrf3ZHxBU6VRP+vxMdqXAUXKknEaT4bcN7H4Q21uINktAw7U/JC+/VFZOx17wolw+ilKwPxWo7F6l39f6gPJcsKpdwquiLbLJj3JRYNQKbp9rq/S8zvUnT3EoR6HYHVZxP4zxpqVeMWykMA2RpRd1bf38lz4gN7PJGIVCJcEaz0evk0/lXAKyjmtJIECX8Yx25vRoiCVhiwAhFQJSd/I/WlScfIxWMRXXDToXRcTlK2yPCdhx6x4lNJv5anQERMx23TdLkvI6w+nzLq9e4zLRvqagV8h3aNnLvTFn8nCF+C4S4S+V8qkTt4DyXVHLAJEODGhbRELSWUITCnsw/M3hgjf8y4l+oVTDodOhPHeER0RrPnex9l0iA3YKTfGa09iZ1DAbUBg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8652DA30BD7DF40B8C997707D9C17A4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b94e27-fded-4492-a915-08d84fab26fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 01:46:18.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8R0nw0cqqrHnUijXtVPnQPfZk7oGr7Y9UUtlOdQEnsP7OPGs5K7Fbvz4jAXH2jYpxKZAjukGvAVg31mihKj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-02 10:45:36, Matthias Kaehlcke wrote:
> >=20
> > Hi Matthias,
> >=20
> > I did similar several years ago [1], but the concept (power sequence)
> > doesn't be accepted by power maintainer.
>=20
> Yeah, I saw that, I think I even reviewed or tested some early version
> of it :)
>=20
> > Your patch introduce an new way to fix this long-term issue, I have an
> > idea to fix it more generally.
>=20
> > - Create a table (say usb_pm_table) for USB device which needs to do
> > initial power on and power management during suspend suspend/resume bas=
ed
> > on VID and PID, example: usb/core/quirks.c
> > - After hub (both roothub and intermediate hub) device is created, sear=
ch
> > the DT node under this hub, and see if the device is in usb_pm_table. I=
f
> > it is in it, create a platform device, say usb-power-supply, and the
> > related driver is like your usb_hub_psupply.c, the parent of this devic=
e
> > is controller device.
>=20
> This part isn't clear to me. How would the DT look like? Would it have a
> single node per physical hub chip or one node for each 'logical' hub?
> Similarly, would there be a single plaform device or multiple?

One power supply platform device for one physical device, and DT only
describes physical device. HUB driver only probes non-SS HUB port to
avoid create two power supply device for SS HUB, there should be no
SS-only HUB.

Below is the example of DT entry, there is a dwc3 host, and one USB
HUB on it, there is a onboard USB ethernet chip on HUB's port 1.

&usb_1_dwc3 {
	 status =3D "okay";

	 usb2415: hub@1 {
		 compatible =3D "usb424,2514";
		 reg =3D <1>;
		 clocks =3D <&clk, IMX6QDL_CLK_CKO>;
		 reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
		 reset-duration-us =3D <3000>;
		 vdd-supply =3D <&reg_vdd_hub_usb2415>;

		 genesys: ethernet@1 {
			 compatible =3D "usb5e3,608";
			 reg =3D <1>;
			 vdd-supply =3D <&reg_vdd_genesys>;

	};

};

>=20
> I guess when registering the platform device we could pass it the
> corresponding DT node, to allow it to determine its regulators, GPIOs,
> etc during probe.
>=20
> > - After this usb-power-supply device is probed, do initial power on at
> > probe, eg, clock, regulator, reset-gpio.
> > - This usb-power-supply device system suspend operation should be calle=
d after
> > onboard device has suspended since it is created before it. No runtime =
PM ops
> > are needed for it.
> > - When the hub is removed, delete this platform device.
>=20
> What exactly is removal? It seems once the hub is 'removed' it could neve=
r be
> probed again because the platform device that is in charge of the
> initialization is only created when the USB controller is initialized. I =
have
> the impression that the platform device would have to exist as long as th=
e USB
> controller.

This USB power supply device services USB devices on HUB ports (HUB is
also one of USB devices). For USB devices under the roothub, it will be
powered on when the roothub is probed.[1]

[1] https://lore.kernel.org/lkml/1498027328-25078-5-git-send-email-peter.ch=
en@nxp.com/

--=20

Thanks,
Peter Chen=
