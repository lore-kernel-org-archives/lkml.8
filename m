Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B87620747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjaF4rtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGAGk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:40:26 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:36118
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgGAGkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEA7FKuecaBKLtu/GVALBspUUacJu+GO6y4OokdWplvUl8AIny0Z8pCh8p82ThVrNzl9LT5YJLOKOJwftJvmP2liglnfW5Z+LEXz1oR7lY7E0oQl9qLJeabZxKsLxmR/kiAjZ2d4TyxnJzpXCKDZZoav6YkTBaq7IlTXN+qBJBtmLZ2BS1lQ0D6crWMex+FVQ/oVXodIiF3aoYJyvpv8e1syPbZ1J72gbX2QkIFTfvlZet1bYWawXrcWkobpn44VmQ1ChMu6ubdujChN0MS5zZNbh3Wcl7Cw9XdBtEHE9FJgo0yip1gXoRsvxxQJ2ea5SzcTh/KwgP9+5WY0zskI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFjtY0MABmKbFjgig/fT3NK9RzXmNQPQ+Ik6HBOySBw=;
 b=Ml7/6V/06ZArPtffvX4ZBZpjkl9z06GuiIcvCZV3V0mfXUUsgOVlm3KHmTsxrCV3WPfGSy4XdiQR68os0C52ek05JNRyJD1sM+BaqJMJc467zhaQUgr/uxvByS5NaqEjaRWyOAqMpXeiOpXlg0Hxd/pk93bDEnPq88U+qV+1E7WU3IvkSU2vM/cCkwwvw2biXF95fptZmiG/XVcq1zzp57pYIn3P0TQT0qrguT7frq9Wps63GqrUbY72385xLuC5BTGGUO5veI1pB71rUF9WFPG68vyNYCMQXo/+Wv6o4ZNoPC0WogR3gQFEYiz2fsiYYiV29kGa5xmGW57e0oWmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFjtY0MABmKbFjgig/fT3NK9RzXmNQPQ+Ik6HBOySBw=;
 b=HjaF4rtAF5OYacyYfLuZyFYQbzG4/6fJNmc4mGUFIR7tjIepP6rfzd6swDY2XF+7askRJew40+HDaFzlPFoWu5vATpMWYiChDfUSqXocO3zOuAX2VoOe0l8r86oHYrH0fs2H3Ot+3M0e/gU5TTH2ActSNMa1jx66KEtc+OQ+s6o=
Received: from DB8PR04MB7162.eurprd04.prod.outlook.com (2603:10a6:10:12c::13)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 06:40:20 +0000
Received: from DB8PR04MB7162.eurprd04.prod.outlook.com
 ([fe80::f0c8:301c:ac45:5ba9]) by DB8PR04MB7162.eurprd04.prod.outlook.com
 ([fe80::f0c8:301c:ac45:5ba9%8]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 06:40:20 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <hzpeterchen@gmail.com>
CC:     USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] USB: Fix up terminology
Thread-Topic: [PATCH] USB: Fix up terminology
Thread-Index: AQHWTwW9HyKrrL9ZNEWpiYiLojKJSajyPDkAgAAHpwCAAABscA==
Date:   Wed, 1 Jul 2020 06:40:20 +0000
Message-ID: <DB8PR04MB7162C271B04650CBCC87729D8B6C0@DB8PR04MB7162.eurprd04.prod.outlook.com>
References: <20200630174123.GA1906678@kroah.com>
 <CAL411-pgboix6=1=jKNv_4JaHiC8fKDJ4_mryooMepeHdB-2AA@mail.gmail.com>
 <20200701062924.GA5927@kroah.com>
In-Reply-To: <20200701062924.GA5927@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eefccf9a-a761-46f6-6656-08d81d89a02b
x-ms-traffictypediagnostic: DB8PR04MB7163:
x-microsoft-antispam-prvs: <DB8PR04MB7163D66D89A47A8EF0E086A78B6C0@DB8PR04MB7163.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xD24zyXpuE24Ykbp45Vqcn9/nQpnHxAwd1XF0ODh0qsMasWN8ZCxvbPzvcWM5qP4fUd418et+UFn1cYAAiRcL//2PxsH0pnxla51laFH3hxDv7rSiFSBAQW/zQf1mb6//GKXxt/CzgnnWzxeXoHVofw1Rzyh5hTW+38zpI5meP/qSAVEqZXdPzWE1s1KjSrgbmrm10/WkQzQLFqBvJnANMA1iV5A3q1i7sz8X9+q7J7lKTPsUtqj39goAT0zFWbgWdKtIb+MSBiyrv12TLWx7VihMRxJrlL/UAHKM+UI/XIV6mSsPql5JMuSEJ5CtF5HCgneQP+eC5n2he3t8XirLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7162.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(9686003)(33656002)(55016002)(7696005)(83380400001)(8676002)(64756008)(66556008)(8936002)(66446008)(186003)(71200400001)(66946007)(66476007)(76116006)(478600001)(44832011)(4326008)(6506007)(52536014)(5660300002)(26005)(316002)(2906002)(86362001)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6sHOmU/NE/Q1IFbUuKn20jRNZ3sjpARSfXp2wkXkrI1Bj8KgPlyet3aSbo0RnFLB6RUZHadEYZNPYf8Zwf2NYGWS44UCys7uLzkYELpNBBI5WrtJDapxOy6r8gqsqun7gcantSySzLSitirh6vDt0ihaUWz8kSH3bFo/WlOOzT7SzYXsSdbZBLTBCB1OG/GI5au2ozLoM6h4D6c3vyu/elnyfRbQoA1iIHZWPdGSfjRgPCfStmns6uQ5wdJjZYA+QEwux+/cpigNOuPDLhX3T+SJH9Nov216BXSi+C+nm5XyjY93ibnFNzCTjMkmYjGuPD0188Vi+MAvS5qlp4N9UyCbscT0t2v8oDHlX6LXfvRlTZOJKe8tm5chTI2GR50+xipWtq9CHPJSrMU1WqdlgKJ16E8n7c3vuuHzgvTkHvNXTELV09w+yexTMBYN3yDtJK2fDbXCwBLb7WUz+mDE2APb5cdHHJLW2YMkC7e0ImU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7162.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefccf9a-a761-46f6-6656-08d81d89a02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 06:40:20.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smp4YGVyYIzBMYjcOKRmQrFdJTg140cKyXxUUiqBa7f9V52016jazAVxX4cM400nDIn1UL2d3Bw1yrCI8Z5XDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> On Wed, Jul 01, 2020 at 02:02:00PM +0800, Peter Chen wrote:
> > > index 3a7179e90f4e..1a12aab208b4 100644
> > > --- a/drivers/usb/gadget/udc/Kconfig
> > > +++ b/drivers/usb/gadget/udc/Kconfig
> > > @@ -474,7 +474,7 @@ config USB_DUMMY_HCD
> > >         help
> > >           This host controller driver emulates USB, looping all data =
transfer
> > >           requests back to a USB "gadget driver" in the same host.  T=
he host
> > > -         side is the master; the gadget side is the slave.  Gadget d=
rivers
> > > +         side is the controller; the gadget side is the device.  Gad=
get drivers
> >
> > 'the host side is the controller' may not be suitable.
>=20
> Really?  It is literally a "host controller" as per the specification :)

You are right. At first, I thought, there are device controller, host contr=
oller and dual-role
controller, why you only said, "the host side is the controller"? After che=
cking USB 3.0 spec,
there are only "device", "host" and "host controller" at its Terms and Abbr=
eviations.

device
A logical or physical entity that performs one or more functions. The actua=
l entity
described depends on the context of the reference. At the lowest level, dev=
ice may refer
to a single hardware component, as in a memory device. At a higher level, i=
t may refer to
a collection of hardware components that perform a particular function, suc=
h as a USB
interface device. At an even higher level, device may refer to the function=
 performed by
an entity attached to the USB. Devices may be physical, electrical, address=
able, and
logical.
When used as a non-specific reference, a USB device is either a hub or a pe=
ripheral
device.

host
The host computer system where the USB host controller is installed. This i=
ncludes the
host hardware platform (CPU, bus, etc.) and the operating system in use.

host controller
The interface provided to the system to support devices on the USB.

Peter
