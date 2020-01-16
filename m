Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81401C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454682072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Krtfqm1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgAPLG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:06:57 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46397 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPLG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:06:56 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: HtPa3mJO8Ri7+a0zlOKIMhkuPgJ29g4lbRErF4bOc9jDMGj4BPAXmdlTjYGLqCzq3BhZJCjSry
 +++AD/sCASobauP5kvCyqlLhCjq8Kvafggg/WC5MM5Z1gGAvwQQ438bzOJOYENwSwGAQx2v9WP
 Dlg+kpxQ4t3HUvunkJAz+EMH+VPr9ewPzpU94IJPyfl5NB0BcipGsG3WVMUAM/+lO/bFtgaTHH
 Yf2s64lY+z67cRIlEtDa2iQTh9zDnifY8t4/02chndAOJQH/yLG0yKyYxO/6EQqmOPPxwP+y7C
 gSo=
X-IronPort-AV: E=Sophos;i="5.70,326,1574146800"; 
   d="scan'208";a="61273043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2020 04:06:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 04:06:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 04:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZpQEM8qDpG/mEQKan5E2pPlgobi/6DL9QDm5CUOzi6QPpPqFbM/4aflwk81ozQxcW0qoo0Fs9Y/7W8y/yUIaMbBeuQIQLqiKnFeKZacbzGTpVnag0fbjEjjFl2GhFiZKb9zG3giJousvdWZAqb2tGCeZpNLdqE5N3vGZpbaXf7R0hUf8EVQT6wsc+Lp/NaRdWV/uNHFNsis2H8R9gWWve+An/RadZv/dproLFoMtuCRFg/MyUd7oi+AP3OasnyILNDWJY6qNMYvZ/sD7/4PIauONDA4CPjbolI/Xq26mhDRIvMepVwtlkvRJxYP18urKFwziNXblZQc/cPQh+nANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKRtgvxk1q6lGsVYs4yRG6bkMSaUoMoQ4YyDJmKNY+U=;
 b=QuqzmKFDn3CV/x5HzLBGtVcXB4waWcX3i/Bthf4uy8V81Z/C0MyBfstbADYVfZRMHMoQd7mjr5rc1x/0brIt+n53ooa9xRMAMbl3mxnL1BLMgxb6LrmuIZiiXtLUFrnWNhQMB9v23Unbj/ordA0c6hGiIFsyE6pTPUAFPs7I8cxvrDfiBB9rzkiNMa0/1W1SOAQufi6193Q7iAfdht2UgPZv51toLBYCyJAb29DJk6qSuwk9SMKFaeamUU4kdLKGeKVYtACUoU9sMg1mA6D4uSO47JXRBtmQW5jdcl0VGhxYEITimfMI7Q1eV0R0VIwuMSizzvBLHLut2L9yj5LyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKRtgvxk1q6lGsVYs4yRG6bkMSaUoMoQ4YyDJmKNY+U=;
 b=Krtfqm1eaPOgqICrqgPBFf6Y2r6Xw1Mnri+Nj+/vhL+en7FgTreW7FZTXdwIXU4F12r1SNd0+YqkkbuB7fZdxeMzqkX134AxpRoYWWvzMgYZUOmcDHN29s0c3eHF1Pir8znvwXEUTylGWkU9b2j6zoa/oGMIwHASNXG4x/VMi2s=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3808.namprd11.prod.outlook.com (20.178.254.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Thu, 16 Jan 2020 11:06:54 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 11:06:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: remove unused enum spi_nor_ops
Thread-Topic: [PATCH v2] mtd: spi-nor: remove unused enum spi_nor_ops
Thread-Index: AQHVzF0PZqMyl62bfkCO4I6pV4HVMA==
Date:   Thu, 16 Jan 2020 11:06:54 +0000
Message-ID: <2612409.6oCxq906ie@localhost.localdomain>
References: <20200113223248.15743-1-michael@walle.cc>
In-Reply-To: <20200113223248.15743-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b82bb25-4777-468c-942c-08d79a74320d
x-ms-traffictypediagnostic: MN2PR11MB3808:
x-microsoft-antispam-prvs: <MN2PR11MB38087C5781F256BB7B3CA163F0360@MN2PR11MB3808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(346002)(376002)(366004)(199004)(189003)(86362001)(8936002)(9686003)(6512007)(54906003)(5660300002)(81166006)(81156014)(6486002)(8676002)(71200400001)(91956017)(76116006)(66946007)(6916009)(508600001)(966005)(186003)(4744005)(6506007)(64756008)(66476007)(66556008)(66446008)(4326008)(53546011)(26005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3808;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfdAvatUb9nXmP8OT3NFkjUH4dRN68Aq94FrmFffdLGXJt06UUbTPy6UnNaXEWvhBz43EIMjkkkIu4B9nQFm0HeuyEkJZFzFEfj5wZGrC2MYwn+n+Q3jBccO8QzhNSPlZ40B94zyjM/BVhPDds82bVvpmVShBCtVgvqiCgUKQ5hpUewQOjMKAdQRPgiU5SctkMcybVtAC0Rx9yweuETITeK/3NLbFGUFOSEMECJWZIC2J+OsObaMgLRMryGNkWLmSISnYsB0Ugbbuc2GjaC/C6B+3w7agHE1HVjvEmOY2hNtJpI+HdMY0Z7uDNDNbOcwtvQsvBUDEV0rgK9I4vLBP9JHVzlzXUy4cV6DQTcd98jVaPwMwGf2SbWtbe0iBrjrlNpdRU6K8lD+Oy3pEQ9bVzmdSaov+hixAEbBJkc4Ilb7kma0Ca1mc3Hk2KEvHaQb6ORAQwD6yD9gFRDWeaccxJg6yU0WCdsdt4I90smWilt4yzsH0qO14TWtnniv7Nif/IUljoMA4s+rGgTP7VAPDw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D45124B2F6040D42844B4B55B4526216@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b82bb25-4777-468c-942c-08d79a74320d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 11:06:54.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRxRK2or5tPuqYjIXSJ6z3pZfHhTd2zetfKcFuKlawJ3E2XzqsDchE1pnUCsd7jrRnrG5ClrjRvE8aUtcuPM0NEQ3C1EXOnHTOQwKiHtPOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 14, 2020 12:32:48 AM EET Michael Walle wrote:
> The ops aren't used in any SPI controller. Therefore, remove them

substituted SPI/SPI-NOR because the controller_ops struct is specific just =
for=20
the SPI-NOR controllers.

> altogether.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> This patch superseeds the following two patches (thus v2):
> https://lore.kernel.org/linux-mtd/20200107222317.3527-1-michael@walle.cc/
> https://lore.kernel.org/linux-mtd/20200107222317.3527-2-michael@walle.cc/
>=20
>  drivers/mtd/spi-nor/aspeed-smc.c      |  4 +--
>  drivers/mtd/spi-nor/cadence-quadspi.c |  4 +--
>  drivers/mtd/spi-nor/hisi-sfc.c        |  4 +--
>  drivers/mtd/spi-nor/spi-nor.c         | 36 +++++++++++++--------------
>  include/linux/mtd/spi-nor.h           | 12 ++-------
>  5 files changed, 26 insertions(+), 34 deletions(-)

Applied to spi-nor/next.

Thanks,
ta

