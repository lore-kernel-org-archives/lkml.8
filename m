Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A179C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634DD207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y1oDmmHo";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rYrSiHCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIBHP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:15:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:34915 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1599030954; x=1630566954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6KeaoymcKDczEYzdB4CEu7hKvGbsVVpxBjppC8yB4Jw=;
  b=y1oDmmHoQgVljP9H/AfaFjz0AAo7tMHHDhtGtswp16DpPnFgLj+aHI7M
   upHbLv7RHdy5tJ/2ZBt+HldBzb2qnvNJuUR8+6hReMgI4YjZ0DVLpu9TJ
   v30Lnz2Wfis9hz0T6VQqn/PBarb1Z1xX/YPXCt3PAum9OLpujXgNlTHBN
   Z0BXraI30Au3Y4j/KSBUmrB1Rb/Y2NP37xylJADEeaE7Tt+1sFahLswYX
   nRePdFMaDZmrG6TpUgaWteEDG4Y0208LQkweUVLJ9pbvq9oBsiFC1JL33
   haiCNtBDZkFi+Fal8gL/ozsewaX9u6K2zW1qD+Aj4zIBcULT0c/inAsf5
   w==;
IronPort-SDR: +irw0qLpvfBA6ea1J2akwrrm2HsG76IA0bc+0hGvK8ak11cOLEh4IkXKyRSvKVo89WhRFZj5Vf
 zEB5aQ3A9v1B4MCKuBCE+b+5lvrNiLB0SUTKHuUb8n2C98LCGKULNFDP0Ieq2mwh/ZEoH2cJvc
 LWQSstMkO92kQDQpygAt239V6lXwhmkKx+OyhAiRkmMBchHexGxRAa4w5Rrnu3mu1+nIjeeqiZ
 m2g0pAMiRYuUV8eaoj9fRoT9Xmsb2dc2Nb5tcAWfd+mxysDgKI9REzqbY90ZOJu1W2fIFnZVNM
 wrE=
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="89486614"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2020 00:15:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Sep 2020 00:15:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Sep 2020 00:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9CECuz+5MsxXFf9MOVDKNwu+5wyfi5FW9nLzP8K6tOzffIbXv3p0k/JXDdOmHAaggIMwFxuvtEcZy3eS3cJgWbX1DWOWPWbXFiivf4NjLoSoZ9GfXUCSLalCBPAI/YtHZmZzhc198si8eC7bxY7udmcOmagwccRycTu3E060Hq/pVpnbO4J+rxdW6w5pKMMeLCSg5+eEt1Y3tGkGL7cg4lZ4MMwhVPsEqpWYNEvQo1yZvE4M6V80ST8E64b/G3DizieGcZDw7UqHlQoLlRLrUEFv+VKo0p31x/OGJfvhSTlW6NETB1gV2sOfJVXAqCyRi3nu1rlaYF1dQHHLCgAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH/BgrvEC0rJETRXXCnsCY6DXbFTKOy6KV6x4UNMnio=;
 b=EyuxVHdDuPV3rH79tnjlqfKP0qgxN3b812fahpVKjjosjE22Ph+w0ld+iuWiHDfy28RrG3P26nnivQjCD8XS4RSrHeCmLeNJqxz9Ay1c4Pq+aNPi/1oWKkGazuXyPj3IRozcyJXB2NViANTQ5Fg1AdFAfV+Z41uAegXjjSQ2kUtERuq4KxJwy88GJBBIbrPg9n+1r0rG5XYJLUClldiYuej6KmnxAWgSiiy56PeQh4Dwv0o5mgaghiuj+CQ7ic5zhooqEznDBuZLPq0joqFtg9VjT3hea9/AA1JCwbx3uw/nSo7xSPyd/uPvv1K7U+NBX+HRPbBS3dx1FttTM5/nCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH/BgrvEC0rJETRXXCnsCY6DXbFTKOy6KV6x4UNMnio=;
 b=rYrSiHCgOvov+ou1NZBkBT/ThaC7gY9p1AS1xx+/aFv3T92OfM1JO8SoDjsQVag5RVE67h0uipFvBcmxC+/f5Fh1d8NWfSCWbUU5BWbIIN1GcZW0ps5JklVp+uGGeoPrj23l6nr+hHyci+A5zQkw9vzn7CO+q9bLzog0I/4Gz6I=
Received: from BYAPR11MB3477.namprd11.prod.outlook.com (2603:10b6:a03:7c::28)
 by BYAPR11MB3479.namprd11.prod.outlook.com (2603:10b6:a03:1e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Wed, 2 Sep
 2020 07:15:50 +0000
Received: from BYAPR11MB3477.namprd11.prod.outlook.com
 ([fe80::d1dd:de76:4e99:7c85]) by BYAPR11MB3477.namprd11.prod.outlook.com
 ([fe80::d1dd:de76:4e99:7c85%7]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 07:15:50 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/5] ARM: dts: at91: fix dtbs_check warnings
Thread-Topic: [PATCH 0/5] ARM: dts: at91: fix dtbs_check warnings
Thread-Index: AQHWgPjiEhZ1kd1sa0uwKYuae7G5wA==
Date:   Wed, 2 Sep 2020 07:15:50 +0000
Message-ID: <9984d83c-429d-66f5-8f10-e88aaa2b5b2d@microchip.com>
References: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a01:cb1c:8c:b200:18a6:9bfe:e6a3:3c7c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6fc5b25-b7f2-4f6c-8eb3-08d84f100571
x-ms-traffictypediagnostic: BYAPR11MB3479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3479E617C38FF0290629FE44E02F0@BYAPR11MB3479.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzDsIYYkDPfUqkF/ihH5YfRGoMSwf1ElVbHkxcJo7WsLlLjjY66afHnQMQW0WI4OU/gB8yRPxedB/mY/0xMqDqNrlVk7fSreGQ4OmvgLOmG4tNJj/vmGpIhrWG9CcGSmpQpI5Ds6WWlorBbfLGg3g2tJuk7Z+NLtD3jGJrSFPhTPT5ogCRGlIr/XSTYEWzgszjRQZKQV+VEPhY726QmCWoUDbcjLzWN9AOwccX7XgiEXvlm7vCielSuBm5lqLblUgnNQ3rowBh2N0W5jjoKuoZABcXh41bH5lMcjjKkjZHO590b2i8ZIxB9ihivwyp8AfaoP+2URspS4K6JHvscV9Sl/PkEM8dX513hfcbm+G4ieWYG5uKbQhuPDOmFK1d5T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3477.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(66446008)(2906002)(186003)(64756008)(53546011)(8936002)(6506007)(6486002)(71200400001)(4326008)(5660300002)(83380400001)(31696002)(66556008)(2616005)(6512007)(36756003)(54906003)(91956017)(31686004)(8676002)(76116006)(316002)(66946007)(478600001)(66476007)(110136005)(86362001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1abFbpjawwXTm/Iptzeao2GRfNGMuV+x9he/j9YHJOe0tqunKy+Zrgx4fNkBxO7J16rrvTjPvqTuKfwtNUbVLFcL6noJtXbsS6UtfSvPBEMfNCWGXveZxGD0jCllNMYXoJ68/To2sMhlWxNBr8LErJVzNkrtZqHnMW7Pdgfh8HpRZ5GPTkRx9XIaXCOFhLKcYbzXev3kd13nv3Pvtu6uWiyB0abUTWK8MmBk25MhcAk/GoCYMm1Ej/UF4K3lOgecdQcVympEiHqkZBCOlnQBgRK2LEJEj1f+tyZ25dLxo3ghRhmBLw+ltwWzvJqI3bhX49YH2l6u8bIR3Z2z5kKAoaT70aXyFxm/QQDAJgwn8J162m7wIYHHJ401+CkCr6HYqm7rGgoTVlCNFFfoqbZVnnQ/9kl5kYejZubv67TFChr2Ba/KORudtSr7o8KlUPcmww1JF/I2BgkgGN/oLlKV81MV4JeXSUYWCzQqIn/9XNYZ0PSyiMgBSlD8ULUHts8Hv+jzBfpOF99epg6SM/mpR469pWprgQPBdV3ESxCCJQqoV9Ay5u8+AIC3l7yvjazXCSSl1jqv4Hg5pIm0N37x82u0/XADCSChUZ8VJEHpRCAi7ielWkO5bJg6m9yrWbFPvQYlpPnCAK9Ggqg3fZSsfYfUoAIQXmtISOsukz3ydF238qcJXNv7NFavLrOF1QccpcPYAziM7Jm1vuathXY28Q==
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E0453DBE66210E44910BE0AFA535B725@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3477.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fc5b25-b7f2-4f6c-8eb3-08d84f100571
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:15:50.0135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdWk+KXkG8/750yFYwktnJ+kKABJ++A3Fp55WrIthqw8rU87TeCKj/qKGohuCsZz9cPtO+OsmbtDJhkvqnzqNntKVOv+AXPmTas08ET9X1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2020 at 19:11, Alexandre Belloni wrote:
> Hi,
>=20
> This series fixes some of the dtbs_check warnings. The remaining ones
> are mainly missing documentation or the documentation has not been
> converted to yaml.
>=20
> Alexandre Belloni (5):
>    ARM: dts: at91: fix cpu node
>    ARM: dts: at91: fix sram nodes
>    ARM: dts: at91: move mmc pinctrl-names property to board dts
>    ARM: dts: at91: add unit-address to memory node
>    ARM: dts: at91: sama5d2: add missing flexcom spi node properties

You can add my:
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

To the whole series.
Thanks for having handled that Alexandre.

Best regards,
   Nicolas

>   arch/arm/boot/dts/animeo_ip.dts               |  3 ++-
>   arch/arm/boot/dts/at91-ariag25.dts            |  3 ++-
>   arch/arm/boot/dts/at91-ariettag25.dts         |  3 ++-
>   arch/arm/boot/dts/at91-cosino.dtsi            |  3 ++-
>   arch/arm/boot/dts/at91-cosino_mega2560.dts    |  1 +
>   arch/arm/boot/dts/at91-foxg20.dts             |  3 ++-
>   arch/arm/boot/dts/at91-kizbox.dts             |  2 +-
>   arch/arm/boot/dts/at91-kizbox2-common.dtsi    |  2 +-
>   arch/arm/boot/dts/at91-kizboxmini-common.dtsi |  2 +-
>   arch/arm/boot/dts/at91-linea.dtsi             |  2 +-
>   arch/arm/boot/dts/at91-qil_a9260.dts          |  3 ++-
>   arch/arm/boot/dts/at91-sam9_l9260.dts         |  3 ++-
>   arch/arm/boot/dts/at91-sama5d3_xplained.dts   |  2 +-
>   arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi     |  2 +-
>   arch/arm/boot/dts/at91-sama5d4_xplained.dts   |  2 +-
>   arch/arm/boot/dts/at91-sama5d4ek.dts          |  2 +-
>   arch/arm/boot/dts/at91-som60.dtsi             |  2 +-
>   arch/arm/boot/dts/at91-vinco.dts              |  2 +-
>   arch/arm/boot/dts/at91-wb45n.dtsi             |  3 ++-
>   arch/arm/boot/dts/at91-wb50n.dtsi             |  2 +-
>   arch/arm/boot/dts/at91rm9200.dtsi             | 11 +++++++----
>   arch/arm/boot/dts/at91rm9200ek.dts            |  2 +-
>   arch/arm/boot/dts/at91sam9260.dtsi            | 11 +++++++----
>   arch/arm/boot/dts/at91sam9260ek.dts           |  3 ++-
>   arch/arm/boot/dts/at91sam9261.dtsi            | 10 +++++++---
>   arch/arm/boot/dts/at91sam9261ek.dts           |  2 +-
>   arch/arm/boot/dts/at91sam9263.dtsi            | 15 ++++++++++-----
>   arch/arm/boot/dts/at91sam9263ek.dts           |  3 ++-
>   arch/arm/boot/dts/at91sam9g20.dtsi            |  5 ++++-
>   arch/arm/boot/dts/at91sam9g20ek_common.dtsi   |  3 ++-
>   arch/arm/boot/dts/at91sam9g45.dtsi            | 12 +++++++-----
>   arch/arm/boot/dts/at91sam9m10g45ek.dts        |  4 +++-
>   arch/arm/boot/dts/at91sam9n12.dtsi            | 10 +++++++---
>   arch/arm/boot/dts/at91sam9n12ek.dts           |  2 +-
>   arch/arm/boot/dts/at91sam9rl.dtsi             | 10 +++++++---
>   arch/arm/boot/dts/at91sam9rlek.dts            |  2 +-
>   arch/arm/boot/dts/at91sam9x5.dtsi             | 12 +++++++-----
>   arch/arm/boot/dts/at91sam9x5cm.dtsi           |  2 +-
>   arch/arm/boot/dts/at91sam9x5ek.dtsi           |  2 ++
>   arch/arm/boot/dts/at91sam9xe.dtsi             |  3 +++
>   arch/arm/boot/dts/ethernut5.dts               |  2 +-
>   arch/arm/boot/dts/mpa1600.dts                 |  2 +-
>   arch/arm/boot/dts/pm9g45.dts                  |  3 ++-
>   arch/arm/boot/dts/sam9x60.dtsi                | 10 +++++++---
>   arch/arm/boot/dts/sama5d2.dtsi                | 19 ++++++++++++++++++-
>   arch/arm/boot/dts/sama5d3.dtsi                |  8 +++++++-
>   arch/arm/boot/dts/sama5d3xcm.dtsi             |  2 +-
>   arch/arm/boot/dts/sama5d3xcm_cmp.dtsi         |  2 +-
>   arch/arm/boot/dts/sama5d4.dtsi                |  8 +++++++-
>   arch/arm/boot/dts/tny_a9260_common.dtsi       |  2 +-
>   arch/arm/boot/dts/tny_a9263.dts               |  2 +-
>   arch/arm/boot/dts/usb_a9260.dts               |  2 +-
>   arch/arm/boot/dts/usb_a9263.dts               |  2 +-
>   arch/arm/boot/dts/usb_a9g20_common.dtsi       |  2 +-
>   54 files changed, 160 insertions(+), 77 deletions(-)
>=20
> --
> 2.26.2
>=20


--=20
Nicolas Ferre
