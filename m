Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4A2C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386002070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jk+W8BOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQCbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:31:14 -0400
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:12164
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbgGQCbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjnkHpzEBIi5WzhZl2RgXd/0GlkZ8exMVVebT7Ge62lnla+LDKCSXyONo15FZGb7rCQBkIa/tv6V9bWkwD9umgp60cca+pylK3d8y/zS5b61a6J8UCBIclFO3/07lmFBsvVhfZV2kMhrWqEWZIaEYpVOv4vTxacWCYN+pbcY09UEIaKgwZM8kRyNMEqYdd9DzO/wsyadqWJWKITqZVvLzlGSEe8Bp2TQwDpQqI5hx9hzG9nou/XuSxoBOoAQt6zPOxp04g2sNrqITISDhhrCmBW6sAqSEFXe9TGBp3VN7dgSwEJ7p2MY+zBe9ibL7IZ0QJ2pQBzzNZrcZUItDI7ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsPLI7RyxD/DARATxe+uRlR+KEIu4J+qi/xfai2lFX0=;
 b=nsG4m+I+5yGXm12NtthymIfPa3PMZ0v81FR++6Ty1+w+rULJQEsF2tuaQNJ4tDjGKYE2TSI7hIOUlzpfxJSfwIyBVSvKjMMiMoQpKqyETvJl72ZaUNYOcVwvEUWkPQedU6pd/R/Ij/+YImHFZJDOJJ/V6A9CP3QepUYEoG5egzQ/y4uA1aXkyD+iAVu4xhmYHi44tCs/AVXRJ5jv9Quvm4s2xbE4giHm6tYH8jJpJCpsABaT9FdcogpAc79cw38PkFqhj/4B/rARzn6uMu91t+ToPCx6xExyZ28TeRiE/vX6ZJXrmLKBZhcdOzmr9TsSRqhApVeRxsP2Tzg4zWq4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsPLI7RyxD/DARATxe+uRlR+KEIu4J+qi/xfai2lFX0=;
 b=Jk+W8BOZggUxGzbQZSFvq4a5hbCN8gfsJT4HnIkItNAVrQpgOeO0Op72LKEDfeDufhfgjGllQ4SRvsMmk+TBbWf9sS6TYD70NnWJgqbDzd9vhP4qkBEdkjDP3sPR7J2y7rXO1iWxPieX5tcNNoSnZi5+4ThGZ5L+q6ljj/yaEa4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5813.eurprd04.prod.outlook.com (2603:10a6:20b:ab::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 02:31:09 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 02:31:09 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: ci-hdrc-usb2: add property
 disable-runtime-pm
Thread-Topic: [PATCH v2 1/3] dt-bindings: usb: ci-hdrc-usb2: add property
 disable-runtime-pm
Thread-Index: AQHWWfIOX6WrPbWACU6caDfv2RVZEqkKmaoAgAB3GQA=
Date:   Fri, 17 Jul 2020 02:31:09 +0000
Message-ID: <20200717023108.GA17070@b29397-desktop>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
 <20200716192452.GA2699629@bogus>
In-Reply-To: <20200716192452.GA2699629@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99216192-2a61-4614-6515-08d829f9775f
x-ms-traffictypediagnostic: AM6PR04MB5813:
x-microsoft-antispam-prvs: <AM6PR04MB5813BFA14DD278FED59351048B7C0@AM6PR04MB5813.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8Kl+9G7xME97RP4zKVrIci8PhuzYYfJLFlA7BIqRXjzFEgkLG4TY+mFfB2zdnya2+ZgpHAqW3yoSllK8I2ouBsqu3FEt1fac1gfr8XxYjnlPr9qfnE2/nu+5qYvJnl3mhkf187fRHO+HXhcxV1Iw0WTdMmMIsu+9r7QhMkJsOFW71+cFlf/8y6D3ZxBsIP1HBjT0ZMjG0k0yqSOqI9n3O0Ti1L2ADCEZhibISqVmuUyt1EY8qob26RgjRCamSKsY94U+fNbjYJOlVyhznFuRc4Ru6+eezrfQfbCdg5LkuG1W+hIPwiRQAxRSOcNo/MvIqRsMY0xMyKpbSbwx4cioQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(39860400002)(136003)(376002)(396003)(346002)(54906003)(83380400001)(44832011)(33656002)(33716001)(186003)(5660300002)(4326008)(1076003)(8936002)(66446008)(64756008)(66556008)(6916009)(2906002)(8676002)(478600001)(66476007)(26005)(76116006)(66946007)(91956017)(86362001)(71200400001)(6506007)(316002)(6486002)(53546011)(9686003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CR4VYfakJJ5mx1hhSUx4ei67zXRlHVsAofkXilgJRCI8s/RSFa/WJvo0GsivmtWJXLlbARdXy7ueD4qHHXW0GlhQz5fZuf23Xr66OsuLaTVN/hNBwZpKHwfTUOTq2vSUBJFmzptrvXFwPKp96bdUAmfjxw9c+PdZEZ7qRTcwMKA7FxX6sWFUjElX3kKnzviUT9w6DvRDVPNLj6KPgoPXo+uKXwl5JZ1MAJtF6UhCwCq1Vnx3hT+0c1xleJL+D/2lXqgc28QlwqO5ix3USK61Pmjh64I17yd4lc+eXhCeA7KnqnbXE9tbN5DVBndYFCZNh1YuCz27AqhP7lPjMiXVJeOeIQCRuKFCxJy+iDgGtuPPI9yZt8WEepx1DmMLG/+EHO2NfZxoRkamzMF3yhCrHAv3XobwgvHyDtdJxb1C/NC8cUHoozwWVVDQFiQ4RAaWNYjN146ewQ80zlozd1TWZO5WKQw+Mc86itYg0G98HPM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC0CC7ED8FC97B4E95BE667F252BACE3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99216192-2a61-4614-6515-08d829f9775f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 02:31:09.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO9z0tiSGvIekG35Qf1/AaXrxUAkkYbh1wBGIOXnq2Sni2dfa3Bb4O/gVq8IRuVUUdsYW4cljKPlnUsiiZ2oRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-16 13:24:52, Rob Herring wrote:
> On Tue, Jul 14, 2020 at 05:18:20PM +0200, Philippe Schenker wrote:
> > Chipidea depends on some hardware signals to be there in order
> > for runtime-pm to work well. Add the possibility to disable runtime
> > power management that is necessary for certain boards.
>=20
> This is why we have SoC specific compatible strings. Use that.

It is a board design limitation, not SoC's. To support USB low power
mode for device mode, either VBUS connects to SoC, or VBUS connect to
GPIO, or VBUS connect to Type-C IC, but none of the design is used
at that board. So the USB can't enter low power mode for that board,
otherwise, the USB controller can't be woken up since no any interrupts
will occur if USB cable (host at other side) connects to the connector.

Peter
>=20
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > ---
> >=20
> > Changes in v2: None
> >=20
> >  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/D=
ocumentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > index 51376cbe5f3d..67a31df13e69 100644
> > --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> > @@ -90,6 +90,7 @@ Optional properties:
> >    case, the "idle" state needs to pull down the data and strobe pin
> >    and the "active" state needs to pull up the strobe pin.
> >  - pinctrl-n: alternate pin modes
> > +- disable-runtime-pm: This disables the runtime power management.
>=20
> This is a Linux feature, not h/w description or config.
>=20
> > =20
> >  i.mx specific properties
> >  - fsl,usbmisc: phandler of non-core register device, with one
> > --=20
> > 2.27.0
> >=20

--=20

Thanks,
Peter Chen=
