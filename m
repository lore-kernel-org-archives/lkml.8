Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E02C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56BC2076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="h5hfp74G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCXP5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:57:17 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:35762 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbgCXP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:57:17 -0400
IronPort-SDR: jR74JQkpGsoVtAZxI90iMlB5nga7+fxehpgPMWldFFG6la6rP8NxLzftBoKDChKes6N+f/s+Vd
 A29oCKkM91siDDOGfrsVYNR4rB5m02eI2pWzZGmgc4kr7hy2xLQugFyweAKmsMub/FdQCaSDxk
 3Cd5QPBKQDzS+xSS7jbQrpgaa117xbwNeMhkHijxu6hIHZOeIKLVwd9pNV/fNqHQ4ZSOG3bwvp
 OhmrJZ3CiAgJphh+wllUB7Xp21IPIlTkmRRp9HWCe9aDqGSQiBi8qFF6M9y892vjonnZS6ZWwG
 W9o=
X-IronPort-AV: E=Sophos;i="5.72,301,1580799600"; 
   d="scan'208";a="70011230"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2020 08:57:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Mar 2020 08:57:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 08:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfK/AJUCg2Du43l73JkqThCU7Sq8kf9OoZiV1ODU/a50uBChTFp1q4yFwYphivLwnIcqMANyXaPoDs7zXfHe7vqkCa5e/AQuDI96bowq99n8K327OCCcjc2gjYCcxR+hFCwV4jphj4tE5ImjP5EJ7C39TX+i39TqZRJ3uWM6FRgAbi0Yn2xm2sjeZcn2VgJ+irgYGmRCqpo+kuIoHeyTDweJxi91qlmmvMhrZ13phtr5EXLFccgxH85IPK7gaeXZwir1VNkcLpjuvOWonQwI3ulCzzOQI0EE3M7ZDc55Ysc8FXOKdPDpbucSxGYPGdNAuWizgrefaVAhwQFg0+yYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EULWoixF60A+vm9seEBj0VR3IBA1hwpcfMsh0nUph4=;
 b=YaJp5tFGuBMKTheAfGlcnl1jJofB02KWpQQjxO61QpgtfrxkJ9GkilCIwjUiAlxAhhwgqawGgpAMn+ncbzB0PzRlPqQ3WWlRS/Cvbj93UfpkZo+vgJTbi8f3WnWzH2AwZVwiQzCz9cfSsSFeMtto0yFj/km9XCi/xAr2lcN//7gvVyy3edapQIlBiO+8Jbfs+ikjfpuFzVc/CV5PRojJOUbfizpSqvoLIZ/hGVLtN3JO3C1lQHEoEZWRgMz3i5elUkpe4uz31BNY4R4kTbAi1NBypRPdxNdhBoLJt48VemQV80vxUVlsQVK9NZ5Tp/1VivswT5Gay51ldUqrbfiVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EULWoixF60A+vm9seEBj0VR3IBA1hwpcfMsh0nUph4=;
 b=h5hfp74GDYiATrIMTp5zTWpUhG8kam5On8nVMJLPCoX+cz6zuG+moHMlwuAJPHnZH5GPZCVEZCyhaUucoTrH2MQKqSvZmlvTGm/HQFSzYGTBc2LVlaJFbET0SBN9BKWqJfWmHYxK3b2hy/X85ruzCKdn9mg9udbRbixJx/xpCDA=
Received: from SN6PR11MB2830.namprd11.prod.outlook.com (2603:10b6:805:57::21)
 by SN6PR11MB3309.namprd11.prod.outlook.com (2603:10b6:805:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 15:57:12 +0000
Received: from SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::7d58:c548:530f:985e]) by SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::7d58:c548:530f:985e%4]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:57:12 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: rm9200: switch to new clock bindings
Thread-Topic: [PATCH] ARM: dts: at91: rm9200: switch to new clock bindings
Thread-Index: AQHWAfThPZ0AP2JRCkqlXBprAMXdUg==
Date:   Tue, 24 Mar 2020 15:57:12 +0000
Message-ID: <89792a78-95f7-e334-632c-9b0baf217024@microchip.com>
References: <20200324124154.368335-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20200324124154.368335-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-originating-ip: [2a01:cb1c:8c:b200:7d6c:a50:f953:7f68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22f6345b-035a-49a7-0d3b-08d7d00c0457
x-ms-traffictypediagnostic: SN6PR11MB3309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3309880331B4FF8EE501DBC8E0F10@SN6PR11MB3309.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(366004)(6506007)(71200400001)(6512007)(53546011)(31686004)(110136005)(8676002)(6636002)(8936002)(86362001)(31696002)(54906003)(36756003)(2616005)(186003)(30864003)(2906002)(4326008)(66476007)(66946007)(64756008)(5660300002)(316002)(66556008)(91956017)(6486002)(76116006)(478600001)(81156014)(81166006)(66446008)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3309;H:SN6PR11MB2830.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4JdApxq/Jk9adlBofIFa06lbdA2JN/pjA8WaLar9BW9HTPqsQe9HF9FQNnFYj6jKByf+/N2LFiab+K/6IlkEI7+dGttF7syiGbHyMGQdssB4mVp3dhabEZ7yHJQl75rqus7ELDT8dpiEnp5RRiKNCyun0VcOoV4YnS3+fZzltONqNRvoP+YizI2qxFvZUE0RoFPRiitnjs2ChRxBF1YFSWaYTO+8MsoejBXWFrQDZed+A7yy5j1f1IZoXsYQRF3FwCGp9YV3M7b6ZVqgjHWjYrdRdtYC5aqEI5Lk245KMvvZu8ajq3phz/6J6/pr0OeEK3uGIoaiuthWmHtvLwihqnAj7IXpvwxa+Au0GYNlGVQA97QCla2g5RDdcf3nvYqwP/VI7OnsPdm/9F6BWqiaUqUdKBeJBPHqCtSiJHIR2SMwzRwfCu2w0lJ04+7o+02d
x-ms-exchange-antispam-messagedata: Bjk3Y1aTcgJcCtrQAbzRSPEqmYamCpKxG5u51pmW8Xp8X4t/T8pzzig/Ytx3rrwjm16UqNSKrj9TvjfMjchH4VczB4ehsd6nT5OGr5tN2F5vyCDhjOLgJ9Odd7i9NRMn3vdOIKfVnIPA80u8RgMgxb+jRObIZtf3Bz31nDdghkN6VvAVTJ3cBqukWbKp62OJg8X2wRqpdnIyANPSr76+ig==
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9A16B8AD9E790A4086AB9DA8E007973C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f6345b-035a-49a7-0d3b-08d7d00c0457
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 15:57:12.5174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+hOmtgR8QE4wGM+EXm4GWRwvJsmpfP6ERZ/cQ+j0opev2fQQy4EckLKMDz1ObD4t13aU0kr17oaJtabq8WRJZCylCENMi+FcC7UWMO3SLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2020 at 13:41, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Switch sama5d3 boards to the new PMC clock bindings.

must be at91rm9200 there.

>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   arch/arm/boot/dts/at91rm9200.dtsi | 296 +++---------------------------
>   1 file changed, 23 insertions(+), 273 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm=
9200.dtsi
> index 44385718d9d4..a5040f5ea641 100644
> --- a/arch/arm/boot/dts/at91rm9200.dtsi
> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> @@ -101,259 +101,9 @@ pmc: pmc@fffffc00 {
>                                  compatible =3D "atmel,at91rm9200-pmc", "=
syscon";
>                                  reg =3D <0xfffffc00 0x100>;
>                                  interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>=
;
> -                               interrupt-controller;
> -                               #address-cells =3D <1>;
> -                               #size-cells =3D <0>;
> -                               #interrupt-cells =3D <1>;
> -
> -                               main_osc: main_osc {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-main-osc";
> -                                       #clock-cells =3D <0>;
> -                                       interrupts-extended =3D <&pmc AT9=
1_PMC_MOSCS>;
> -                                       clocks =3D <&main_xtal>;
> -                               };
> -
> -                               main: mainck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-main";
> -                                       #clock-cells =3D <0>;
> -                                       clocks =3D <&main_osc>;
> -                               };
> -
> -                               plla: pllack {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-pll";
> -                                       #clock-cells =3D <0>;
> -                                       interrupts-extended =3D <&pmc AT9=
1_PMC_LOCKA>;
> -                                       clocks =3D <&main>;
> -                                       reg =3D <0>;
> -                                       atmel,clk-input-range =3D <100000=
0 32000000>;
> -                                       #atmel,pll-clk-output-range-cells=
 =3D <3>;
> -                                       atmel,pll-clk-output-ranges =3D <=
80000000 160000000 0>,
> -                                                               <15000000=
0 180000000 2>;
> -                               };
> -
> -                               pllb: pllbck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-pll";
> -                                       #clock-cells =3D <0>;
> -                                       interrupts-extended =3D <&pmc AT9=
1_PMC_LOCKB>;
> -                                       clocks =3D <&main>;
> -                                       reg =3D <1>;
> -                                       atmel,clk-input-range =3D <100000=
0 32000000>;
> -                                       #atmel,pll-clk-output-range-cells=
 =3D <3>;
> -                                       atmel,pll-clk-output-ranges =3D <=
80000000 160000000 0>,
> -                                                               <15000000=
0 180000000 2>;
> -                               };
> -
> -                               mck: masterck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-master";
> -                                       #clock-cells =3D <0>;
> -                                       interrupts-extended =3D <&pmc AT9=
1_PMC_MCKRDY>;
> -                                       clocks =3D <&slow_xtal>, <&main>,=
 <&plla>, <&pllb>;
> -                                       atmel,clk-output-range =3D <0 800=
00000>;
> -                                       atmel,clk-divisors =3D <1 2 3 4>;
> -                               };
> -
> -                               usb: usbck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-usb";
> -                                       #clock-cells =3D <0>;
> -                                       atmel,clk-divisors =3D <1 2 0 0>;
> -                                       clocks =3D <&pllb>;
> -                               };
> -
> -                               prog: progck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-programmable";
> -                                       #address-cells =3D <1>;
> -                                       #size-cells =3D <0>;
> -                                       interrupt-parent =3D <&pmc>;
> -                                       clocks =3D <&slow_xtal>, <&main>,=
 <&plla>, <&pllb>;
> -
> -                                       prog0: prog0 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <0>;
> -                                               interrupts =3D <AT91_PMC_=
PCKRDY(0)>;
> -                                       };
> -
> -                                       prog1: prog1 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <1>;
> -                                               interrupts =3D <AT91_PMC_=
PCKRDY(1)>;
> -                                       };
> -
> -                                       prog2: prog2 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <2>;
> -                                               interrupts =3D <AT91_PMC_=
PCKRDY(2)>;
> -                                       };
> -
> -                                       prog3: prog3 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <3>;
> -                                               interrupts =3D <AT91_PMC_=
PCKRDY(3)>;
> -                                       };
> -                               };
> -
> -                               systemck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-system";
> -                                       #address-cells =3D <1>;
> -                                       #size-cells =3D <0>;
> -
> -                                       udpck: udpck {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <2>;
> -                                               clocks =3D <&usb>;
> -                                       };
> -
> -                                       uhpck: uhpck {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <4>;
> -                                               clocks =3D <&usb>;
> -                                       };
> -
> -                                       pck0: pck0 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <8>;
> -                                               clocks =3D <&prog0>;
> -                                       };
> -
> -                                       pck1: pck1 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <9>;
> -                                               clocks =3D <&prog1>;
> -                                       };
> -
> -                                       pck2: pck2 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <10>;
> -                                               clocks =3D <&prog2>;
> -                                       };
> -
> -                                       pck3: pck3 {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <11>;
> -                                               clocks =3D <&prog3>;
> -                                       };
> -                               };
> -
> -                               periphck {
> -                                       compatible =3D "atmel,at91rm9200-=
clk-peripheral";
> -                                       #address-cells =3D <1>;
> -                                       #size-cells =3D <0>;
> -                                       clocks =3D <&mck>;
> -
> -                                       pioA_clk: pioA_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <2>;
> -                                       };
> -
> -                                       pioB_clk: pioB_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <3>;
> -                                       };
> -
> -                                       pioC_clk: pioC_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <4>;
> -                                       };
> -
> -                                       pioD_clk: pioD_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <5>;
> -                                       };
> -
> -                                       usart0_clk: usart0_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <6>;
> -                                       };
> -
> -                                       usart1_clk: usart1_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <7>;
> -                                       };
> -
> -                                       usart2_clk: usart2_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <8>;
> -                                       };
> -
> -                                       usart3_clk: usart3_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <9>;
> -                                       };
> -
> -                                       mci0_clk: mci0_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <10>;
> -                                       };
> -
> -                                       udc_clk: udc_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <11>;
> -                                       };
> -
> -                                       twi0_clk: twi0_clk {
> -                                               reg =3D <12>;
> -                                               #clock-cells =3D <0>;
> -                                       };
> -
> -                                       spi0_clk: spi0_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <13>;
> -                                       };
> -
> -                                       ssc0_clk: ssc0_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <14>;
> -                                       };
> -
> -                                       ssc1_clk: ssc1_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <15>;
> -                                       };
> -
> -                                       ssc2_clk: ssc2_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <16>;
> -                                       };
> -
> -                                       tc0_clk: tc0_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <17>;
> -                                       };
> -
> -                                       tc1_clk: tc1_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <18>;
> -                                       };
> -
> -                                       tc2_clk: tc2_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <19>;
> -                                       };
> -
> -                                       tc3_clk: tc3_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <20>;
> -                                       };
> -
> -                                       tc4_clk: tc4_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <21>;
> -                                       };
> -
> -                                       tc5_clk: tc5_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <22>;
> -                                       };
> -
> -                                       ohci_clk: ohci_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <23>;
> -                                       };
> -
> -                                       macb0_clk: macb0_clk {
> -                                               #clock-cells =3D <0>;
> -                                               reg =3D <24>;
> -                                       };
> -                               };
> +                               #clock-cells =3D <2>;
> +                               clocks =3D <&slow_xtal>, <&main_xtal>;
> +                               clock-names =3D "slow_xtal", "main_xtal";
>                          };
>=20
>                          st: timer@fffffd00 {
> @@ -383,7 +133,7 @@ tcb0: timer@fffa0000 {
>                                  interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH 0
>                                                18 IRQ_TYPE_LEVEL_HIGH 0
>                                                19 IRQ_TYPE_LEVEL_HIGH 0>;
> -                               clocks =3D <&tc0_clk>, <&tc1_clk>, <&tc2_=
clk>, <&slow_xtal>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 17>,=
 <&pmc PMC_TYPE_PERIPHERAL 18>, <&pmc PMC_TYPE_PERIPHERAL 19>, <&slow_xtal>=
;
>                                  clock-names =3D "t0_clk", "t1_clk", "t2_=
clk", "slow_clk";
>                          };
>=20
> @@ -395,7 +145,7 @@ tcb1: timer@fffa4000 {
>                                  interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 0
>                                                21 IRQ_TYPE_LEVEL_HIGH 0
>                                                22 IRQ_TYPE_LEVEL_HIGH 0>;
> -                               clocks =3D <&tc3_clk>, <&tc4_clk>, <&tc5_=
clk>, <&slow_xtal>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>,=
 <&pmc PMC_TYPE_PERIPHERAL 21>, <&pmc PMC_TYPE_PERIPHERAL 22>, <&slow_xtal>=
;
>                                  clock-names =3D "t0_clk", "t1_clk", "t2_=
clk", "slow_clk";
>                          };
>=20
> @@ -405,7 +155,7 @@ i2c0: i2c@fffb8000 {
>                                  interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH 6=
>;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_twi>;
> -                               clocks =3D <&twi0_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 12>;
>                                  #address-cells =3D <1>;
>                                  #size-cells =3D <0>;
>                                  status =3D "disabled";
> @@ -415,7 +165,7 @@ mmc0: mmc@fffb4000 {
>                                  compatible =3D "atmel,hsmci";
>                                  reg =3D <0xfffb4000 0x4000>;
>                                  interrupts =3D <10 IRQ_TYPE_LEVEL_HIGH 0=
>;
> -                               clocks =3D <&mci0_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 10>;
>                                  clock-names =3D "mci_clk";
>                                  #address-cells =3D <1>;
>                                  #size-cells =3D <0>;
> @@ -429,7 +179,7 @@ ssc0: ssc@fffd0000 {
>                                  interrupts =3D <14 IRQ_TYPE_LEVEL_HIGH 5=
>;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_ssc0_tx &pinctrl=
_ssc0_rx>;
> -                               clocks =3D <&ssc0_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 14>;
>                                  clock-names =3D "pclk";
>                                  status =3D "disabled";
>                          };
> @@ -440,7 +190,7 @@ ssc1: ssc@fffd4000 {
>                                  interrupts =3D <15 IRQ_TYPE_LEVEL_HIGH 5=
>;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_ssc1_tx &pinctrl=
_ssc1_rx>;
> -                               clocks =3D <&ssc1_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 15>;
>                                  clock-names =3D "pclk";
>                                  status =3D "disabled";
>                          };
> @@ -451,7 +201,7 @@ ssc2: ssc@fffd8000 {
>                                  interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH 5=
>;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_ssc2_tx &pinctrl=
_ssc2_rx>;
> -                               clocks =3D <&ssc2_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 16>;
>                                  clock-names =3D "pclk";
>                                  status =3D "disabled";
>                          };
> @@ -463,7 +213,7 @@ macb0: ethernet@fffbc000 {
>                                  phy-mode =3D "rmii";
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_macb_rmii>;
> -                               clocks =3D <&macb0_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 24>;
>                                  clock-names =3D "ether_clk";
>                                  status =3D "disabled";
>                          };
> @@ -803,7 +553,7 @@ pioA: gpio@fffff400 {
>                                          gpio-controller;
>                                          interrupt-controller;
>                                          #interrupt-cells =3D <2>;
> -                                       clocks =3D <&pioA_clk>;
> +                                       clocks =3D <&pmc PMC_TYPE_PERIPHE=
RAL 2>;
>                                  };
>=20
>                                  pioB: gpio@fffff600 {
> @@ -814,7 +564,7 @@ pioB: gpio@fffff600 {
>                                          gpio-controller;
>                                          interrupt-controller;
>                                          #interrupt-cells =3D <2>;
> -                                       clocks =3D <&pioB_clk>;
> +                                       clocks =3D <&pmc PMC_TYPE_PERIPHE=
RAL 3>;
>                                  };
>=20
>                                  pioC: gpio@fffff800 {
> @@ -825,7 +575,7 @@ pioC: gpio@fffff800 {
>                                          gpio-controller;
>                                          interrupt-controller;
>                                          #interrupt-cells =3D <2>;
> -                                       clocks =3D <&pioC_clk>;
> +                                       clocks =3D <&pmc PMC_TYPE_PERIPHE=
RAL 4>;
>                                  };
>=20
>                                  pioD: gpio@fffffa00 {
> @@ -836,7 +586,7 @@ pioD: gpio@fffffa00 {
>                                          gpio-controller;
>                                          interrupt-controller;
>                                          #interrupt-cells =3D <2>;
> -                                       clocks =3D <&pioD_clk>;
> +                                       clocks =3D <&pmc PMC_TYPE_PERIPHE=
RAL 5>;
>                                  };
>                          };
>=20
> @@ -846,7 +596,7 @@ dbgu: serial@fffff200 {
>                                  interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>=
;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_dbgu>;
> -                               clocks =3D <&mck>;
> +                               clocks =3D <&pmc PMC_TYPE_CORE PMC_MCK>;
>                                  clock-names =3D "usart";
>                                  status =3D "disabled";
>                          };
> @@ -859,7 +609,7 @@ usart0: serial@fffc0000 {
>                                  atmel,use-dma-tx;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_uart0>;
> -                               clocks =3D <&usart0_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 6>;
>                                  clock-names =3D "usart";
>                                  status =3D "disabled";
>                          };
> @@ -872,7 +622,7 @@ usart1: serial@fffc4000 {
>                                  atmel,use-dma-tx;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_uart1>;
> -                               clocks =3D <&usart1_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 7>;
>                                  clock-names =3D "usart";
>                                  status =3D "disabled";
>                          };
> @@ -885,7 +635,7 @@ usart2: serial@fffc8000 {
>                                  atmel,use-dma-tx;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_uart2>;
> -                               clocks =3D <&usart2_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 8>;
>                                  clock-names =3D "usart";
>                                  status =3D "disabled";
>                          };
> @@ -898,7 +648,7 @@ usart3: serial@fffcc000 {
>                                  atmel,use-dma-tx;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_uart3>;
> -                               clocks =3D <&usart3_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 9>;
>                                  clock-names =3D "usart";
>                                  status =3D "disabled";
>                          };
> @@ -907,7 +657,7 @@ usb1: gadget@fffb0000 {
>                                  compatible =3D "atmel,at91rm9200-udc";
>                                  reg =3D <0xfffb0000 0x4000>;
>                                  interrupts =3D <11 IRQ_TYPE_LEVEL_HIGH 2=
>;
> -                               clocks =3D <&udc_clk>, <&udpck>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 11>,=
 <&pmc PMC_TYPE_SYSTEM 2>;
>                                  clock-names =3D "pclk", "hclk";
>                                  status =3D "disabled";
>                          };
> @@ -920,7 +670,7 @@ spi0: spi@fffe0000 {
>                                  interrupts =3D <13 IRQ_TYPE_LEVEL_HIGH 3=
>;
>                                  pinctrl-names =3D "default";
>                                  pinctrl-0 =3D <&pinctrl_spi0>;
> -                               clocks =3D <&spi0_clk>;
> +                               clocks =3D <&pmc PMC_TYPE_PERIPHERAL 13>;
>                                  clock-names =3D "spi_clk";
>                                  status =3D "disabled";
>                          };
> @@ -947,7 +697,7 @@ usb0: ohci@300000 {
>                          compatible =3D "atmel,at91rm9200-ohci", "usb-ohc=
i";
>                          reg =3D <0x00300000 0x100000>;
>                          interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH 2>;
> -                       clocks =3D <&ohci_clk>, <&ohci_clk>, <&uhpck>;
> +                       clocks =3D <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc P=
MC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_SYSTEM 4>;
>                          clock-names =3D "ohci_clk", "hclk", "uhpck";
>                          status =3D "disabled";
>                  };
> --
> 2.25.1
>=20

