Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED6C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CD724672
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lUUs6Vms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAVG6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:58:42 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:25862 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgAVG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:58:41 -0500
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
IronPort-SDR: 7ElZQBEC0aUOUX5sCl/4EyP62uTehjMeKXv4tu42SBYqExqjg6zFn2sOwVz9l82MGlLaaHeNIb
 7HucQXoIzL4sPyWi435kxYb3YeZSZvkvGJR9FuI5Nrw9tD4s35sJF55y3ac3bfZ4XtT0FwsdhB
 ExcMskCHjz/re+gz/vmAuy9lFC7x2exMBP4fp6wC0d1OeVbC9FDivyqk97GA9e0ffcd3NML2qh
 4BRnuTqipOKzsuyJnxlzaKj3wxJRpZ61yCRRjTWyYSRX4n/cFiqHfJ+Ew3O4cvl+b3tca2Uqer
 suk=
X-IronPort-AV: E=Sophos;i="5.70,348,1574146800"; 
   d="scan'208";a="63365868"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 23:58:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 23:58:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 23:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2CfTVoB5Mq/8xdXa0HtIkzMWQ+3WeQWOUjkGYkgyx1Nz2skabybT1ePijoEY+mzxoiUoe45h2Rr9r8VXhCIwMsUNtwkGlS7XtHU0ql6I3B9MY+gxJhDADPesGZX7w236vkZai2avvlh5PGp7swvMJ9lpi/7doj6N1xlQMLzen28FRpFaxzrKBKNaSu+f9b2+yAH9CxBDmmhIIP0G32qY3VTBN9t6NJEetnP/RiodtNM4tJrXyf53UD2waeSU8/TU/l6PGwv1DuqxPSAqER2LV//A/83ohkjcIOadlotMAMxpjzzq+9B5JP+0nuFIT1zCMSMlxSJyonlHa6D62k26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WolCcCRSOkKeSScmhSxet45XSgRHyl+rT9WGI7gxlXE=;
 b=DUY/JKMH+GLjcoelOA2AJ1gD0Z+JXU24esFqQmOIrXFUgCcOSKTzD55Q1YrKorw1ZMrPN78YYs1XEiQnRjAzU0brGpoiT4Zaz20cJS06h3OSppwinodfRiNbTLFTltAtqHgM6HvWTZVWPoLWT2/VsFk4mAUPb+dDxrGrO8ikq+h/Rcn0kXvy0fqrwBG8esoYSB9DPOLAFHfHmrqpYnOtBjykMEc7enQ/10IjQXSS91EXmRg5m5g11xRGBU/t3YFEsqM5QKMKEuuuBK+0mceOMTsnA6eO0C00uLXDUTH4/NPrHVvICF1TmJCutHSov27csbGHmDSRfguU/31djw9jXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WolCcCRSOkKeSScmhSxet45XSgRHyl+rT9WGI7gxlXE=;
 b=lUUs6Vms/+rusxd+oKCcBkbmAuspsMuKHjG1C2XL2+zr13aMxWHKofD1n1VA4MBUiKIz/iSdfo6KufRFNmSy9vaoBcLPBd21zFjJ8zfHsrtkgAwEQgPx1gQ88KjvBEPT4uL2AqCStYAT5CLnvDmL23K2VCsFrV2TwJx1l4iLVwk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 06:58:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 06:58:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <marex@denx.de>
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Topic: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
Thread-Index: AQHVyIWMlxFjXvTu+EGjJ9P1l4qrM6f2Ua+A
Date:   Wed, 22 Jan 2020 06:58:38 +0000
Message-ID: <1658390.DVVSh22Ze7@192.168.0.113>
References: <20200103221229.7287-1-michael@walle.cc>
 <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
 <5323055.WqobA3rpa8@192.168.0.113>
In-Reply-To: <5323055.WqobA3rpa8@192.168.0.113>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c349dc5-beff-4b6c-2c96-08d79f08823e
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-microsoft-antispam-prvs: <MN2PR11MB37121BE95B70821E9AA1C5DDF00C0@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(8676002)(71200400001)(8936002)(66946007)(81156014)(81166006)(53546011)(6506007)(5660300002)(14286002)(186003)(26005)(2906002)(64756008)(4326008)(316002)(6916009)(9686003)(478600001)(66446008)(6512007)(86362001)(66476007)(66556008)(6486002)(76116006)(91956017)(54906003)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEcBmGfrUAyC6sSVv61cz7ZtakH33PNljpUqiAs0wj2o3Zmj/VZhgq/MvfYGSAFJowu8Z4DRDZJObZQ5LTEjvN9zIMxoFufUc83NvFNGgJiit0DQZ4hCWNqc9oDz2/IVyYhibsC5KjKCs586AkNe6BuTFfeVavVZn+GFDmLeXTE+aIu0/dYFKHWFAoV9MMjmDfLl/SdNPZ8Hbo971DEgJJ5+aNDc11/pWN4MSdm2Ek8nzVtkevx21QNNKAH+sDEDGBrgb+8nZssvrLgHs9GhE7NuX/vz2Ua7WbkSvWRsXu2jZGYksdTpdBCQ3xgsYW2b19e/BRDWEjqYoBOt9d+re5OVhIGRa4ROdTmRjFSukO9tYB/xKeMgZeA2ug2K3gpD26qgFLbdOFyt07EGG01MF0brzsaA1Sf+58Y6gJmLIfhdEEPFuKlNmYaeCbN966SJL38QOBQ5Quozu1dXHGUvr4fm4bmpgybwucXRJHcIqfUl1IkDfkdwz3y/UEvyDrAB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <374D7B91938A8A4C8ABEDA916F6E74ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c349dc5-beff-4b6c-2c96-08d79f08823e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 06:58:38.8233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbiK7bszRP8/6H8vdmHN+7XRETSSmWIXdu83lvPckE6TQZpWBMeuY6yZRE99nDBx8xhmL+O6eDfzQS2hBZJvnGsdWjoCdP+9H2xpLyvi7hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

To be more explicit:

On Tuesday, January 21, 2020 8:53:20 PM EET Tudor Ambarus wrote:
> Yes but that was the whole idea of this patch. So if I get you correct
>=20
> > it is
> > not possible to change that even if:
> >=20
> > (1) it was never intended that way. Eg. the original patch(es) were
> > about
> > removing the volatile write protection (which makes perfectly sense,
> > even
> > during probe time) to be able to write to the flash. But it was never
> > intended
> > to disable the non-volatile write protection.

Even if this is true, we can't break backward compat.

> >=20
> > (2) it might be even harmful. It is still an open question wether the
> > write
> > to the non-volatile bits (even if it is the same value) might wear them
> > out.
> > Unfortunately our FAE didn't answered yet..
> >=20

We'll think about this when we know for sure.

> > (3) it makes the write protection utterly useless, because if you lock
> > the
> > flash it will be automatically unlocked after the next reboot. Even
> > worse, the
> > user likely won't notice it.

Even if this is true, we can't break backward compat.

>=20
> Breaking backward compatibility and keeping the locking state of the spi-=
nor
> flashes at probe is a no-go, because there might be user space apps that
> expect that all the spi-nor flashes are by default unlocked. The unlockin=
g
> of the flash at probe time was introduced 12 years ago, we definitely can=
't
> change this now.

Kconfig option or module param will fix this without breaking backward comp=
at,=20
we should focus on this direction.

Cheers,
ta

