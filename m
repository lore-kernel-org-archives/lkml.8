Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43494C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BAE2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 13:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oEAo8E8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgAKNqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 08:46:46 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:2530 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgAKNqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 08:46:45 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 4neUknRqleX83RXlv40EiWD0BSBtAQ98R6Tt5pbH4ofqpNd0OCuqI3Sjq39kFBYobic8grhva0
 dl/TnqHTzPhLUaci1TD5O41/cSHBsiD65bNCjqzy5jgBVI+725N4mZnGU93LKqp7kfpliCD3RK
 XsN5337UTSyLexDysfg8lG1Ua6AoeD0Ri5mxZ/7/qO/ZcAnxV++YBpyGQgg6zDPbCDzoVd1XEv
 YrAL2ZeMDvR/69AeI4y4cBpTTfR+IShv9vM0VyCC8buiCk5cpSFGKGsuPbBaTfK24nrtnwnyBf
 OTw=
X-IronPort-AV: E=Sophos;i="5.69,421,1571727600"; 
   d="scan'208";a="62326724"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2020 06:46:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 11 Jan 2020 06:46:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 11 Jan 2020 06:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl13XybmnUxJwFs06vdgmKC2PFQY7B7MrJWxkupj4EBUVNOsVzuyxx4tSUczJfxQ9uIgIDaIskTcduw835afD7xLID2g+4VYNsBgAqft/DoTqew70e4361PcfXBv10SzdIO4549oCO0a4OkZlpv8OaxBLCt6w1+VOHMGRTHOinfZaCvYbXmHcNFn8JV0C/411HrU6QmP8hjRk/kzBa42MvmNxmbbomSVXu0cGnX4mEJKrigtKNjlEJ4UXnsSdCF+BKVqSlI7zQekc6teOBuI7sVYedJEKPBaedLIqJ9vAuWLUQEYCgfqb7No2coTvh4+5VKTO//qigXEVBdG2XoRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo62Mv6RNzfUDY2dN9bb+JfxJCyeopM3CxQMZfGZaXM=;
 b=DnVRTWg4B2JaQWSCdOmW9+R8ZmZAPvkSx4heRTY9Fs4KKMjiZwUH7zWMxqD0TVSwado4Z6duTS7iDyde72zb2lTMWY93qKOyKBX553q+lDPDD1fTDWV9DGe51F1oYBlajv/Kx6nqzUtpJ6E0a42NAOr6UkLzXvSjJopoJB54oy9GmbWEB9sVIoUnend5QHJ2lbKprvk8PbAzW9OwbW88zWtX6Oih0OpPMLnMY0ZnXnzZJYvjgKBVoU2MxexEaJ4AgVJOConDfEUKIUOxIqoWGlDUwGdsqnMOhHouG8UlBnKdq37mSbUd26bz9lhmpFW5Zto+pNA0DKBDFCo9y4Kx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo62Mv6RNzfUDY2dN9bb+JfxJCyeopM3CxQMZfGZaXM=;
 b=oEAo8E8pqwcc17HTYFAqVqYQHzAajTCL7qd1hzlZ6C0+DkRGJQg6JMn3txOCx8dejVZHb0JoFRNRDJ+b4QuK714y87JJna/N+W7is1xFJIpAqPA+7Sx6zaTlpl1RvQC5mL5sa6e7qo62zTHhG7H2y1U178g+4zytlVgIMrzFyEw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3839.namprd11.prod.outlook.com (20.178.254.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Sat, 11 Jan 2020 13:46:40 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.013; Sat, 11 Jan 2020
 13:46:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>
CC:     <michael@walle.cc>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <marex@denx.de>
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Topic: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Index: AQHVyIWMlxFjXvTu+EGjJ9P1l4qrMw==
Date:   Sat, 11 Jan 2020 13:46:39 +0000
Message-ID: <8187061.UfBqSTmf1g@192.168.0.113>
References: <20200103221229.7287-1-michael@walle.cc>
In-Reply-To: <20200103221229.7287-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec322142-443b-4902-1ca9-08d7969caf8c
x-ms-traffictypediagnostic: MN2PR11MB3839:
x-microsoft-antispam-prvs: <MN2PR11MB3839AC5329967C3F933770F5F03B0@MN2PR11MB3839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0279B3DD0D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(54906003)(6512007)(9686003)(478600001)(316002)(5660300002)(966005)(6486002)(76116006)(91956017)(66946007)(81166006)(26005)(81156014)(14286002)(86362001)(8936002)(66446008)(66476007)(66556008)(64756008)(6916009)(8676002)(53546011)(4326008)(186003)(2906002)(6506007)(71200400001)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3839;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lI++594xO0ugH4EF084Kjs7v/TWUrqVi8UnUTyEGlolKS6far1FF272SmlDjWkY5T750RJDHde1DPu4axvBmb/zPOG6n/8fA23Yu48ToRU4BIA22S1Hg/3lGhwziBpjvDqA3BzSX3AME2Cg+TgqoeRBxmqktz6jU51cjDmEX8rOO4nDx7AUGdwjdtwlD5iIv485D9BXPpdp1HrPWuvCLjpdTQtOE8GmMELAVTC7V3nCP4Dwm8JvXU/+LMQF6n6erKYPFWCdBn59QZxIi6eFgAxqFNOWYxrP19vothXTZhtvZ2kJOdkz4vcSUGkYyf7SJ0vX/5n7hv1aghWec8Df3hXO+bx6ekIjN5Sqh+Qua8ZwRKmqgOKuT7R8vRQgdF5xxO3XTYRN0Ji0ny12nTknvjW8oZtqMscSJb2xosEMtKGzWR8eeLFGTlGWLCl1a/0lzCW1XShdGshIMNdGefndrWBKAfvNQhM3qdR0sH2Ux+m2vI+jZ/V23en+7Uw5zcwcmCOciUPezhoJi8QIqZ9qvoPK0tNDcb+dR1wf3Yl539r6cpiucWmn/RY+dweUZKXK5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <266AD8ED94A09A4D810CCBEAD4BF36BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec322142-443b-4902-1ca9-08d7969caf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2020 13:46:39.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtJ2tFnvzCpu8A5BwSYCi1VOVKflsoZJNRSoi3xx8Q2i41rSucmjZ9+xxHJU3emSoyyxhGpVbO4TChIWA+LzJPpngd/tveqbKKwncUtpRIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

On Saturday, January 4, 2020 12:12:29 AM EET Michael Walle wrote:
> Traditionally, linux unlocks the whole flash because there are legacy
> devices which has the write protections bits set by default at startup.
> If you actually want to use the flash protection bits, eg. because there
> is a read-only part for a bootloader, this automatic unlocking is
> harmful. If there is no hardware write protection in place (usually
> called WP#), a startup of the kernel just discards this protection.
>=20
> I've gone through the datasheets of all the flashes (except the Intel
> ones where I could not find any datasheet nor reference) which supports
> the unlocking feature and looked how the sector protection was
> implemented. The currently supported flashes can be divided into the
> following two categories:
>  (1) block protection bits are non-volatile. Thus they keep their values
>      at reset and power-cycle
>  (2) flashes where these bits are volatile. After reset or power-cycle,
>      the whole memory array is protected.
>      (a) some devices needs a special "Global Unprotect" command, eg.
>          the Atmel AT25DF041A.
>      (b) some devices require to clear the BPn bits in the status
>          register.
>=20
> Due to the reasons above, we do not want to clear the bits for flashes
> which belong to category (1). Fortunately for us, the flashes in (2a)
> and (2b) are compatible with each other in a sense that the "Global
> Unprotect" command will clear the block protection bits in all the (2b)
> flashes.
>=20
> This patch adds a new flag to indicate the case (2). Only if we have
> such a flash we perform a "Global Unprotect". Hopefully, this will clean
> up "unlock the entire flash for legacy devices" once and for all.

Thanks for the detailed explanation. Unlocking the flash at probe time was=
=20
badly designed from the beginning, we should disable the write protection o=
nly=20
on request, to avoid destructive commands during power-up.

Breaking the backward compatibility is a no-go, and looks like you break it=
,=20
by not treating case (1). We can indeed continue your idea and treat both (=
1)=20
and (2), thus disabling the write protection at power-up for all the flashe=
s=20
that we support as of now (in order to not break backward compat), and to n=
ot=20
disable the block protection for the new flashes that will come. This means=
 to=20
have some point in time before which some less fortunate flashes don't bene=
fit=20
of write protection at power-up, and after which the others benefit. I=20
wouldn't got this way, I prefer a generic method that handles all the flash=
es=20
in the same way.

I see three choices:
1/ dt prop which gives a per flash granularity. The prop is related to hw=20
protection and there might be some chances to get this accepted, maybe it i=
s=20
worth to involve Rob. But I tend to share Vignesh's opinion, this would=20
configure the flash and not describe it.

2/ kconfig option, the behavior would be enforced on all the flashes. It wo=
uld=20
be similar to what we have with CONFIG_MTD_SPI_NOR_USE_4K_SECTORS. I did a=
=20
patch to address this some time ago: https://patchwork.ozlabs.org/patch/
1133278/

3/ module param, the behavior would be enforced on all the flashes.

Preferences or suggestions?

Cheers,
ta


