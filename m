Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0899C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801BC22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JtAxnfF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAUSx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:53:27 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:23308 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:53:27 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cr+Kw8fJk3SWQfSETtWWNa93Ud/QaGV4F8hWB3vI1CluoKxo9csFVdKjSSC/zNq4jwGw9mzVax
 sEmGW32ly/ilHaotBFFPC8PYDuZbjSPYVNH+D1rJzXyGBOn5QeLJvWiASgz6ryr1RSQdYR8KhA
 SX5x7sAX9YJsjzRBU3MwadPC2mpswTPK9tEwdlL47Axdnliaaz89lYNb+qi1wX5iO8GpT2NtCt
 U37axWq7GrkREvXIBASE1j6jGdHlW38Pgop8Mgc1rE6//c5VOV+skiaECVTmKx48Ke9aOywrii
 66o=
X-IronPort-AV: E=Sophos;i="5.70,346,1574146800"; 
   d="scan'208";a="62644220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 11:53:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 11:53:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 11:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYkw9siBemPYiLNubckebIf3fqbpn5eezNFsY+djUHV5zHmUouqjMvt1eiCE1oQHLz9WOTLAbDQUPW/2UIOk/3wQw/aedTA7AQ0yVrJxFgmaNtLe+eh59u9USnQuV6xoE+gPVAKLaywvezoN1JJvPs8Yef/CcwuiHYXxcC94v721QzyIoCo/XUrdcgW8yxz6iqGn1/wmy14kACt4HV4C3kjtsRWTRut9VN2yt3VvnlBdWohDel3uDYTX4M1qeNx6fiUs1Ikb0F7JylG42XuNbFbAu4kigELlwzgGznnUKgpGg5p9n2Em2RVApFAiX9N6dyExc0IFQSe6oFT5ImgA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TGVyS8jt2oK32+aFkZq6Bbyr9nUtclWOlfwxF3hlWQ=;
 b=j4xbCaBFNgCQQhz2L8tiOaIQmKreZVJRwIKzWmoFooLREPQ8ILC/wIEguNw3tLn9xnKcXd6V9rzKGAf8I34wCJBmeXKmQPw2ptML3OLr0sgQuxqERq43McZ9qiVpCT9I0WPQg5GOpgyS/MeHOGZDtv4KsPsrRuaEmcV7ayZ7R4vjG+/TALj/q4z0u5ZG9jzL0WtGellY3sdQAebq899jRW/t+okXPx+rpBtUHMtYRYvnaLg4EWJemzfkRiQqlQiHRjuEFwzNxwYdaidlYKw9PT6XtdZ2/v/gIuJLuPLF0Mf8TNT9B7C88W4NrIZa4eAbApHNS+eyU/z1NCyVLIYxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TGVyS8jt2oK32+aFkZq6Bbyr9nUtclWOlfwxF3hlWQ=;
 b=JtAxnfF8wO85rs1Z6LGWDlJglzRsq6TuOJEUFk7n3fJ7h3t9GUjBTdkEP+4XD1yQH3XGO88aA/qinnvTrP7d/ZCvvfWfn3BTOJJEo0NjHx++Yxmu/OdroNvFyMO31GueCBLl0ssdPoV8k4pj/fawEevWNfDCfeCGo2kOeRe4+nw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3677.namprd11.prod.outlook.com (20.178.253.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 18:53:22 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 18:53:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <boris.brezillon@collabora.com>,
        <miquel.raynal@bootlin.com>, <marex@denx.de>
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Topic: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Index: AQHVyIWMlxFjXvTu+EGjJ9P1l4qrMw==
Date:   Tue, 21 Jan 2020 18:53:22 +0000
Message-ID: <5323055.WqobA3rpa8@192.168.0.113>
References: <20200103221229.7287-1-michael@walle.cc>
 <8187061.UfBqSTmf1g@192.168.0.113>
 <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
In-Reply-To: <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 601de839-2df9-49e8-fe29-08d79ea3306f
x-ms-traffictypediagnostic: MN2PR11MB3677:
x-microsoft-antispam-prvs: <MN2PR11MB3677FF30CC9D38E770A4DFACF00D0@MN2PR11MB3677.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(6512007)(26005)(4326008)(316002)(66556008)(6486002)(53546011)(5660300002)(6506007)(66476007)(64756008)(91956017)(66446008)(76116006)(66946007)(966005)(110136005)(71200400001)(478600001)(81156014)(8676002)(81166006)(86362001)(54906003)(2906002)(9686003)(186003)(14286002)(8936002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3677;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTLXgjztU29cjJNWJFOFNzsezz6OA4V4VyN7t5AaApp2ipwir407LHmJjnEwe1t/0TVPum5un6u02pdpnyFLp57ykJnxvQnuuHw79WZuE1iCFDXPIwXkNGgeerUmauv/YoYhz9lnzq+SPqpuzQi9zOPLZHg/ZuOGQztOnUZRuII5CwRtcgBH+UVH2uHu7kaLhiHG2wgQ7UvCsuYg7NkGeVCHa6pcgl1v2T9ZD5RDiyUZw1l3w7wIXW5cPcKxpZLM/yY/LRmauimrmEmxbkeUxx/9dDU59wIdoM/2NzRkhaSm0d47O+/gM4zrKrQISrz5xvo8KWs8OxK904R4JKWagkRzO2t5gfK81h85M3EgJn1+VnXJ5qw3YFbU5+IZnHpWYaR8UQyuBHlIs2tDrFthSkcoJIYkvqnKdKDBDRuwkEISLnpD4vVAi9zNbjz2rN5MqtLrUHmNYllcgByD4xppamLBd5MPWPvoCQY/7KWub9DV1agBr/9uXlTFzV+HOE0Ty742vn8pGTnPCVdcZYqfwfixWKAcQWR//MePURodnG+a0iQjjl+SXSeQTrFmDxA8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89FEE052639A4646ABCE05A2A2BD01FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 601de839-2df9-49e8-fe29-08d79ea3306f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 18:53:22.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwZGjCTeNMDtpHCBaxHUK5cLV5cr7D2luilK5Er8gTMqH+NTwlIXw8kYMwBsX6ghegPkkkT6IzaW9pZPUtpNwt2F2H/9u4b9dC4vRAgWMxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael, Vignesh,

On Sunday, January 12, 2020 12:50:57 AM EET Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Tudor,
>=20
> thanks for looking into this.
>=20
> Am 2020-01-11 14:46, schrieb Tudor.Ambarus@microchip.com:
> > Hi, Michael,
> >=20
> > On Saturday, January 4, 2020 12:12:29 AM EET Michael Walle wrote:
> >> Traditionally, linux unlocks the whole flash because there are legacy
> >> devices which has the write protections bits set by default at
> >> startup.
> >> If you actually want to use the flash protection bits, eg. because
> >> there
> >> is a read-only part for a bootloader, this automatic unlocking is
> >> harmful. If there is no hardware write protection in place (usually
> >> called WP#), a startup of the kernel just discards this protection.
> >>=20
> >> I've gone through the datasheets of all the flashes (except the Intel
> >> ones where I could not find any datasheet nor reference) which
> >> supports
> >> the unlocking feature and looked how the sector protection was
> >> implemented. The currently supported flashes can be divided into the
> >>=20
> >> following two categories:
> >>  (1) block protection bits are non-volatile. Thus they keep their
> >>=20
> >> values
> >>=20
> >>      at reset and power-cycle
> >> =20
> >>  (2) flashes where these bits are volatile. After reset or
> >>=20
> >> power-cycle,
> >>=20
> >>      the whole memory array is protected.
> >>      (a) some devices needs a special "Global Unprotect" command, eg.
> >>     =20
> >>          the Atmel AT25DF041A.
> >>     =20
> >>      (b) some devices require to clear the BPn bits in the status
> >>     =20
> >>          register.
> >>=20
> >> Due to the reasons above, we do not want to clear the bits for flashes
> >> which belong to category (1). Fortunately for us, the flashes in (2a)
> >> and (2b) are compatible with each other in a sense that the "Global
> >> Unprotect" command will clear the block protection bits in all the
> >> (2b)
> >> flashes.
> >>=20
> >> This patch adds a new flag to indicate the case (2). Only if we have
> >> such a flash we perform a "Global Unprotect". Hopefully, this will
> >> clean
> >> up "unlock the entire flash for legacy devices" once and for all.
> >=20
> > Thanks for the detailed explanation. Unlocking the flash at probe time
> > was
> > badly designed from the beginning, we should disable the write
> > protection only
> > on request, to avoid destructive commands during power-up.
> >=20
> > Breaking the backward compatibility is a no-go, and looks like you
> > break it,
> > by not treating case (1).
>=20
> Yes but that was the whole idea of this patch. So if I get you correct
> it is
> not possible to change that even if:
>=20
> (1) it was never intended that way. Eg. the original patch(es) were
> about
> removing the volatile write protection (which makes perfectly sense,
> even
> during probe time) to be able to write to the flash. But it was never
> intended
> to disable the non-volatile write protection.
>=20
> (2) it might be even harmful. It is still an open question wether the
> write
> to the non-volatile bits (even if it is the same value) might wear them
> out.
> Unfortunately our FAE didn't answered yet..
>=20
> (3) it makes the write protection utterly useless, because if you lock
> the
> flash it will be automatically unlocked after the next reboot. Even
> worse, the
> user likely won't notice it.

Breaking backward compatibility and keeping the locking state of the spi-no=
r=20
flashes at probe is a no-go, because there might be user space apps that=20
expect that all the spi-nor flashes are by default unlocked. The unlocking =
of=20
the flash at probe time was introduced 12 years ago, we definitely can't=20
change this now.

>=20
> > We can indeed continue your idea and treat both (1)
> > and (2), thus disabling the write protection at power-up for all the
> > flashes
> > that we support as of now (in order to not break backward compat), and
> > to not
> > disable the block protection for the new flashes that will come. This
> > means to
> > have some point in time before which some less fortunate flashes don't
> > benefit
> > of write protection at power-up, and after which the others benefit. I
> > wouldn't got this way, I prefer a generic method that handles all the
> > flashes
> > in the same way.
>=20
> I'd also prefer a solution for all existing flashes. But it seems that
> the rule
> above makes that almost impossible. Esp. this behaviour will then be
> there until
> eternity.
>=20
> > I see three choices:
> > 1/ dt prop which gives a per flash granularity. The prop is related to
> > hw
> > protection and there might be some chances to get this accepted, maybe
> > it is
> > worth to involve Rob. But I tend to share Vignesh's opinion, this would
> > configure the flash and not describe it.
>=20
> Still my preferred way. but also see below. But I wouldn't say it

Try to convince Rob.

> configures the
> flash but describe that the user want to use the write protection.
>=20
> > 2/ kconfig option, the behavior would be enforced on all the flashes.
> > It would
> > be similar to what we have with CONFIG_MTD_SPI_NOR_USE_4K_SECTORS. I
> > did a
> > patch to address this some time ago:
> > https://patchwork.ozlabs.org/patch/
> > 1133278/
>=20
> Mhh. If we would combine this with this patch that would be at least a
> step into
> the right direction. At least a distro could enable that kernel option
> without
> breaking old boards/flashes. Because as outlined about you need that for
> flashes
> in category (2). Or you'd have to do a flash_unlock every time you want
> to write
> to it. But that would be really a backwards incompatible change.. ;)
>=20
> > 3/ module param, the behavior would be enforced on all the flashes.
> >=20
> > Preferences or suggestions?
>=20
I would go with 2/ or 3/. Vignesh, what do you prefer and why?

Cheers,
ta



