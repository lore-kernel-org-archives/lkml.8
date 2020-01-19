Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A736C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E620684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 07:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="P4cJEAqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgASHTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 02:19:25 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12472 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgASHTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 02:19:24 -0500
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
IronPort-SDR: COE6Pz76tcR5+oe/AEYOuwMxkDzlSltO0DG8jwFztjXZTBuxCAU20H6RbaXGmtsIObtDdIRYtn
 fAk6hAeOSHdMvsWcVaghVOVyibh+LfghEOUab4wBWskyZHCXfmi3I5KC0HAALSxQ1ibAyFwLgG
 dU40I274ECzHn7ZBlbIiKXw3qwg7hsTTTZccivg3eQuRM4vSkxTOkx0MI52kwYwkC+YAf/1ZAn
 gYLijHdrRxMpa5uJnAr+UX5bV7qOiaERv1X6o9Z8YoKT9O1DLm547jjKSePB9s7rKvH5dMKZqT
 bYs=
X-IronPort-AV: E=Sophos;i="5.70,337,1574146800"; 
   d="scan'208";a="63076813"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2020 00:19:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 19 Jan 2020 00:19:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 19 Jan 2020 00:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDdJ6mqfWCAjuSLpjz3J+Qha2d5J2EUELdRDcsMgpR+/7f8hrCjiUMUdjxsB9z9HOdwUMb1p7h7KuLayjrh6fcKkcm5RFfE9NGKEBZRkc7XHD5QIgOh9DAraVBmCc+llEV70E8S5dY7bdk4OH7bNAZea2/bD95/ijjBYX0yD/VTct+WOzqW9MmdJNtPYH3L2r0IPNOAdIUVIJKsdUZXMZ8fypJNLSK4jkhU6wQeqyLgTghWjNyperCBIsS3u0FyieiKSMtqTgZ4CSte0fNHMy0IJ/8y1m+2A6qjawZjxv1/H1Ky5RiWREDS/iAmLIe+tZMVSYfJ3UGnoLz+c6EK33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2P2qqWM7HbefkQNFwhVZXZPeHNVg+Xcbx8DAn5zNgA=;
 b=aCmru7ncksy2Ct468yVm/kjxnwpAhi755tJeKQVCceg8ic9BJS/BTLvo5GTEYCqy4PKhfCR8NY/KrZKOptb1fC/4wst/MbAwaz18VwrDZxCXqzD/y9sehCzazp8/f9WbBdEC8OJ20D4vV4QQocI4CPvsQ7dLgoMnWNQ6A1AQY05ttqjiixU4g+HRossYw0x6AeTJU09eyAGCW1+g9L4u5o+dIDmAgxCrQ5LpjRpYcxxlS7jRlQ5L+XNznNHklRBRTA5gJV7yXBLl5QaDyTTifKkylJWoKzeofIaSw258mK2HDeGyufw5bNQULVJA7DCyjLIdcyfI81j3Di9yr9BGEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2P2qqWM7HbefkQNFwhVZXZPeHNVg+Xcbx8DAn5zNgA=;
 b=P4cJEAqq3WnBV7UhourGtNmXocVw3haX9gZUhupmxRLPwHF1EY8KwqHQcizVNqLJ6ZXOSHAdyOn4o71LA69Z3Drhf5ePQIu5+e5o32JHkMc8uaLURFZuWcT/zxICJU7vcTpAO/8xpD5r5FOV2p4XgW4oS2viEsE3JspU9CkYp/Y=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sun, 19 Jan 2020 07:19:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.023; Sun, 19 Jan 2020
 07:19:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>
CC:     <michael@walle.cc>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for w25q32jwm
Thread-Topic: [PATCH v2] mtd: spi-nor: Add support for w25q32jwm
Thread-Index: AQHVzpi9ZN5ysq9Q4ki2+7vO9nN1Ig==
Date:   Sun, 19 Jan 2020 07:19:09 +0000
Message-ID: <5149002.dABgk2UiNj@192.168.0.113>
References: <20200116154209.32654-1-michael@walle.cc>
In-Reply-To: <20200116154209.32654-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e8dd277-8b56-425d-bdbd-08d79cafe092
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-microsoft-antispam-prvs: <MN2PR11MB3984368C08346667DF4932D2F0330@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0287BBA78D
x-forefront-antispam-report: SFV:SPM;SFS:(10009020)(39850400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(6916009)(71200400001)(2906002)(86362001)(316002)(54906003)(8676002)(66476007)(81156014)(81166006)(5660300002)(64756008)(66446008)(66556008)(66946007)(186003)(91956017)(76116006)(26005)(966005)(8936002)(53546011)(6506007)(14286002)(478600001)(4744005)(9686003)(6512007)(6486002)(4326008)(39026012)(138113003);DIR:OUT;SFP:1501;SCL:5;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4zwPYgl8K2ZO5HbJno5N5tDL3WZi8EJWgQYEKlduT37SPW9H7Hjn0uGip24YuOP8x9/POMjjQGd/VeLIDZDPrGnrjqG4DwHei7MOubjZ8HU/QTYIgR/zmD36YYnXh2EtccqVArmdKGLstdB3QYsLzROzW032SQYG18l3KYylLIUjHCzVJQo9lDsvu7PP+MtZeBumYCMEJGvLBskx1fZhB4JMlYOnCy2ijM/eldpC9T1FmFya/NbujcHFXAgBamv1/miwbMVehRcuWKmrTahPwjQGQ01FKPlSo4tPTllePbh/caHfiBqkErurpH1QgIzOzq/lFqsDNR7Tk/gRKRtiHEZ5yp2VtfFjHtyYncYiGIzdvDvY+AwbqcOMwFLVFT+5qWK4ymrPv6keXyXgFtAdnQp2tbzN1O0VtngufzD7yuetRrZGIflmIzP1973zKDSOsS+v/zD/1qVwZCs3CU7gFDpJ7E3uKSjOamiTnCve7Aw5al98C6qE40BnMdaaxh5gkMV43g9l2AGEDBxjCtk/6XBRR18o+UvSS8tY7rkdgiZFRrntfqcPZzyQ5GIFI4gfWOsyBzcsQCv+M3jdP2SW7n26cC6kVFCPoVV3LkCA2XhpCvSB9mrqet8yAW1uw9X1skJUZuw/qGNBXSbP3hqXoCrhl8pQXZ7VcfrO8rKisI5cJZrfw7vGxnZvqTACR/PwFJJnvoJspRxtaxZM9OHWquaBw7FfOnqCnlc9HLInQ+XLvCscFXU/f12tj6/w3bkMjHt8qFjaVro5x06p7Q4NDLUrK+eI9YR4OovZEIefT5xuQjAvz5/fO2gjSezEHWD3mqsmgjSOkh2GoHJyvd18uND2G21FkX9I7oJ7WtFbZBQrkxEzm0bGd8m3zOksOo9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <243073F4C772694CB138224B1727BC0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8dd277-8b56-425d-bdbd-08d79cafe092
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2020 07:19:09.5268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmIP395GQzPiSG4JO5NQXs00dzSADk1DU5bqS/hn/FxUy4Qjl2wRl0a9gunorv5BR98g3/fCxuOeZt0cLJpKOXDqw6LJcPhLO+v+ARvaDmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 16, 2020 5:42:09 PM EET Michael Walle wrote:
> Add support for the Winbond W25Q32JW-xM flashes. These have a
> programmable QE bit. There is also the W25Q32JW-xQ variant which shares
> the ID with the W25Q32DW and W25Q32FW parts. The W25Q32JW-xQ has the QE
> bit hard strapped to 1, thus don't support the /HOLD and /WP pins.
>=20
> This was tested in single, dual and quad mode on a custom board with the
> NXP FlexSPI controller. Also the BP bits as well as the TB bit were
> tested.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> This patch superseeds the following patch:
>   https://lore.kernel.org/linux-mtd/20200103223423.14025-1-michael@walle.=
cc/
>=20
> changes since v1:
>  - renamed flash to w25q32jwm
>  - removed untested flashes
>  - reworded the commit message
>=20
>  drivers/mtd/spi-nor/spi-nor.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to spi-nor/next. Thanks.
ta

