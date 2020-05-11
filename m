Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F19C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C62A207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="aqsQeAtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgEKLJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:09:02 -0400
Received: from mail-eopbgr1320123.outbound.protection.outlook.com ([40.107.132.123]:22006
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbgEKLJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+U8BH0VII6srA4X5/ngIhe59Gfb9iRtrl0QE4jCpc5q/lUSVHV3CZvv++euVJHP8OQZKCb9xWvltSUXDAk28CtY/7yPicEwwg5f3TwORE5kF8QoA884k1TI04+aUwYjqUmxl38PuKVIUL75ulr/j+2aEEwqjWVvP2gZBdAEoetWBeXZcG1kWuM3/yk664VlK5HIOZyT+MD1mGHKN3EMyl+IjfbLyojd0oHK3P3jblmWwNnwXCuRBLigFqhzTa7kqvF4STuXINMkuRH0dRrVcW02q1BkgvXZmCOcZrNA8X2cBilGjy95ICHKreW+rCpZ7OhWnV2Th4n/EQA00Nq5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VT3e3XRC0nVLa/MuiXnEryOeMhi3eZwrr8XwFYKGn8=;
 b=YEStM9YwiZjpCcijHOnFc7u/eLWQReDqs89go5QMPO8PDEL46yALkvHY5THft0CRmLvlZ66rnP0U0lXlaXmkJYw8qaRDm5HezOhVwwYkuzeha4Eqyb2H66t3f9L3uMehwFvZU9TbEeT9wKbjaszbP/IQZhlQgX8/Gx1r4UYuMCPI1z9wkoJCjnMCWf1hDY3AqDf+QvsxAeIxeKeVAEotU2gC8EGjbcTFeES4uzNrxNmh/hPfOvwXeQaCVhA9/sncPPLosHZuyoxRW34fUQrqoCcgFy0NQdfB95qUczUZH3s6PQIi8c6Qt7+wNsKLELCT+p6sBUHpFRyZQWSoWJVFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VT3e3XRC0nVLa/MuiXnEryOeMhi3eZwrr8XwFYKGn8=;
 b=aqsQeAtAhSBB2P6S5hb0TDN1xuojSU3oEPXNaQgWCU3m6/wpqu69cPNn5VFpFgAzKW5mUeeP6YOxEpuvECp4LYC1gK6cdOEJG5eygJ9klmzUyJkzQv0Ybhes/y22sQm1v9T+zbFwEDgFj4ofnm7HE1RtQxAj6EoXlfsvoptQwBQ=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (20.178.142.214) by
 TY2PR01MB3819.jpnprd01.prod.outlook.com (20.178.142.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27; Mon, 11 May 2020 11:08:56 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2da1:bdb7:9089:7f43%3]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 11:08:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Al Cooper <alcooperx@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v8 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
Thread-Topic: [PATCH v8 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
Thread-Index: AQHWJX5wxwwSBar7Y0yDjv9LdsbElaiiu9NQ
Date:   Mon, 11 May 2020 11:08:55 +0000
Message-ID: <TY2PR01MB3692CE6A245BE2C06AC4694CD8A10@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
 <20200508211929.39020-2-alcooperx@gmail.com>
In-Reply-To: <20200508211929.39020-2-alcooperx@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ed6cc13-a65f-4b82-ef0f-08d7f59bb274
x-ms-traffictypediagnostic: TY2PR01MB3819:
x-microsoft-antispam-prvs: <TY2PR01MB38193047C425611B32A11AC0D8A10@TY2PR01MB3819.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bB4Ghsq0jEBv6Mqms5PP5QMs1B9yMUu/lm/FU89EOb+mq4Je64J8HEEd1fXELLSofbdlX5eE0zaADjUYny8k4dz80xdOBzFYtELlXn0fSfHEWn8yBfKf17r/Dz1FrPgyr6XjTPV4OPBVh2t5gJj3Yhojf0Vdi0ls+vjqYtYXBYqKbVFsga/UBTJampDGON85xCMuMfwlduEAwh5IV7l7WIUsFEdAVh72m5STyXzBAwj52F+DwWeweLDf0gtSa9fyBwIG9kQj2adg/myyXhEDI9z34Ur0iedNdjS2RdUHJA7EcqOy+Xbsp89Yl1iGmi1CPwp2oraQqUtTaDRDUR4Z57hHg+2b019xJYecqaJUzA0JtN+yiUPqQeudVTrhze1UDlc/AeU+UEvO/V/vwyauaJPTwUENCAL34aDmtpPSG+hRgZKtjGBRu23qm6s+IquoPceT5nWBsviPaqG/0mwK7eV9SpGP7WLxPe+ltf236Im06Usn/bNVNsxT4MGqn7dHUwYRAxI2S7ggJ2Em7ABysA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(33430700001)(33440700001)(55016002)(86362001)(9686003)(7416002)(66446008)(66556008)(4326008)(66476007)(316002)(64756008)(76116006)(66946007)(33656002)(5660300002)(71200400001)(6506007)(54906003)(186003)(26005)(110136005)(7696005)(55236004)(2906002)(8936002)(4744005)(52536014)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0NkEVRwWvrzRMvrqhYsJbWrtmqT21GPPxoofCjZsfNKVUIqyJzL7Q6kai5Iskss7T/5y1Ie6/QrwGgnzIIXJfFUfaknj9niSnrOLJxnLkfwmYpGx1F52VdcenOq4r7fBoTwAQ6r1NeYfOt+rzjNcmEl+/BkkkCqW0u2fqqu7t/RLQmHB0J9flGP/YgqmQC4NNJoVn73T30LCeBpe8CwEemxzV0YEJI4KHwosYqaru+ayKKJyVhBHZDDihfdKEH8AvVTzYC9zOTDOuNUy+SZuisTBabZihuSk4OpVThrzJoF0VMg5GOCmHHIAxHo2T1+mZqC0tgZsGgbMOMSvm3WsBT8qoTHgA25AUG1jgifgZw8Krp4WzLcRjiAZK5YCEcbo+0ou4M7gtNeLtZDi29nF/1qT/pO7gJHRgQfguEPLIf/Rh8AnIDxblG2CwCiAfFjpNC19yQnW3B3gYlwuB9rDpSlkFNXoHHhcb+DlxwMlDAYP9cyN95ZjlwO1dJ0ILVQC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed6cc13-a65f-4b82-ef0f-08d7f59bb274
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 11:08:55.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POB2uXoQrTfLfcy0V8wdG/jZZ48wjb27hS6lyroJFYyj/zRQPQFSkCDYOAuHJuTe05C9dIi3oo1/kE+vND2ADme2v1vCpqhS2J3FOZipSaYnOQbT5+1ARAzeSpXufY1Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

> From: Al Cooper, Sent: Saturday, May 9, 2020 6:19 AM
>=20
> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
> devices and OHCI handles <2.0 devices. Currently the Makefile
> has XHCI linking at the bottom which will result in the XHIC driver
> initalizing after the EHCI and OHCI drivers and any installed 3.0
> device will be seen as a 2.0 device. Moving the XHCI linking
> above the EHCI and OHCI linking fixes the issue.
>=20
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

I tested on my environment (r8a77951 and r8a77961) and then
I didn't detect any regression. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

