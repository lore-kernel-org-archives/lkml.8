Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B08022B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xc2znPJV";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="g+xpwwlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgHDPpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:45:51 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:43132 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgHDPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596555944; x=1628091944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/qiQrfjPanEEMuxHLuPM3zWgd7IDcAaRdTXT0LauhC0=;
  b=xc2znPJVYEI9FvfUq1jelHS0eQEGRcq1fQZ3iOPE6POiMMyoaHgRFvOl
   r2HCxdyMrScDhVNg0Zn6xkkswN9uaF7SVmqxmHV6dw055yv4N6DcAznIC
   fBz0z3C3oxZF4brKYPXCENGLdDbXS9LLh02BZmByNe6c+xoc34XkynabL
   5xBeSqgf4NMqGjinp3RkdfRg0yBncoT+5PjAsPaJyCKtvIhLVlhCZ7eaa
   1MIk9TURy0FVLpJezAuilJiRmKD16MrXUUopGXYGiKCpJC1CcQCTjoRkT
   U9NMRwCs9NU1BOqKAMBfpmk2l4ubw3Zof6jWyXxbHbbXQYRZuY3nt8/n2
   w==;
IronPort-SDR: 6kEuuydiwR6757kx9pDsG/XjSvyWYwGifk/Hf7GL+8ZZtZ6zdFcl0QWxJDQSpQnnV+2QqU3DYp
 QC5iFEc4CzdXaRdiL6kjnNm6uZTAQrKmnkZydtsDoFWtiS/Uc3rrZfq4IrNmpM4ruyG5OgL43e
 QAq2IhjTwVfQlLv6kdHBUisrWvP5woKf+UwfwdMDok8iR1HbYEtNYicBnWbzCOhxk4Fep1n6bd
 YyM4Ew56+/BxNQsS8TWQMFY8OedhXuV5Pk+m5pLgEfonkEM37kdkjEBvPwRrTjCShiWtQSrWSM
 E08=
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="85806161"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 08:45:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 08:45:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 4 Aug 2020 08:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHw7UJALw3ixQpChmGbRHbti0NBWgNZ+wJLWWP7+PB4ODNGZnhNwfBa2vMmUDwrfg9aqsDi+ZoTcvT0uhmRoYxHr7ySk4KrkTr2m0PiQJvWyxgOS9bxaUeRtW/PYz8C6ej/aw6zFiTCYa+9A33Oq2N+zysScTgt0XmnFYBuaT0N2kBVZs8f9oJsNpi3eqnyfmN2s8uJx7WKL0Q/aoNUwubhFE4qTbhjvEIMvhCGzgtJqdDl/3VGYUqCPx25MQkUQBxBmabJxZh8Y0jO4J8PpzTXE8REOEapLusrfBddlR6J6QVI5HgKEFtQ3rHFL7gRzRAxshfDvNJ+iOgRgpfitsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qiQrfjPanEEMuxHLuPM3zWgd7IDcAaRdTXT0LauhC0=;
 b=K7MY8h/6gefrrhX0cuMUHLrxJ+/BOF6XTFP7C52SuANkrYi8GSGD+eZs4qalcM8bZEDH5ZfXvE7VATtynrtN11xk03xLw9+OpmDMP54O1+0IUvqmqu6fv5BCuzOq5zPthUMTSrMI9I0J0Wn2ohOuVMzyRnJWzahPXIXV/5OqhfA8xxMbGsa8hvh5ULK8iXB3Ia31BA5uCwT27hFL2Uc9q5EQbwib/SElWRVhzSGpzR65yOMrRdHzvo3CHfWnWYTqYb90VOV78GhkcX3gubAG7/y4vQ2bK9ykV0PJJ09ZEJbcdTEY9keYqRxkZ7ZRpw2hfu7rhvZvYXjpxTYnYnZzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qiQrfjPanEEMuxHLuPM3zWgd7IDcAaRdTXT0LauhC0=;
 b=g+xpwwlqe8r46ONMX4fdZJTUnlgFei588x4RRd27mTboDleV1XtZVVHajNDWZ0REUSX5A2pDIYkcfNZR55o/xCWRUJIsWRDKimbhZRl2oJFZWv4t7BvPpn98sBoQyZJrZATUHIwrO59x7/CN5OgHBhxlXFEncgtgzhxYrRM6lJ4=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3418.namprd11.prod.outlook.com (2603:10b6:5:6e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.21; Tue, 4 Aug 2020 15:45:40 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 15:45:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <wenyou.yang@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Thread-Topic: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Thread-Index: AQHWanACN1d1n4sWwEaqiqSQihqxnQ==
Date:   Tue, 4 Aug 2020 15:45:40 +0000
Message-ID: <5c00c0f9-dc73-fb8d-aef8-88f4bc923295@microchip.com>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
 <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
 <20200804114223.GC7836@piout.net>
 <f9e1d923-225e-7a18-ed48-c8c7e7d4d8cf@microchip.com>
 <20200804150841.GA10725@piout.net>
In-Reply-To: <20200804150841.GA10725@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13ae3e17-aa43-4513-3dd3-08d8388d708f
x-ms-traffictypediagnostic: DM6PR11MB3418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB34182B5D98E95E2D80E0AD51874A0@DM6PR11MB3418.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bjw//ILqp2RZqiH2KOCe5qQISq0WAi1pUJ3d0vY/Uift7X4MwkUVllQLer3HH3HzBcQ5g9Iw2u4szYJYEM2Wk5x4/lb+//+UXA7dndNnWcxD1K/8e3579JXFf1PZJ4MuL2ESyvVX9QDfgKYLR3q1A61MGwbLzzAhlIDmNyT7wDr150WsEqBBTFSG3DFKmfRj2RJE8YYM980ewGWWQ0Xn26yuWCht7td8AX0NN/proW8F5Cx3/WeRvksNFCFvielGzhs66U3dQ5HxnWMbTKNvazeBEpJMKN/APe5Gtm2Quv+nJe8k2a844Vl1RD7DkL4u8M7tYR9FeJvTjSzbVbgZ24T8pnXV6oV1KLcekuvSYEN0XbnbHyCEydO72EFytkIyBdh7yRz/J9TGn9IVttDml619FBtxD7/ysn9qsvL3NLIFSV+ZYekDkk0M2rhmI3oKBX6g2jaLpY3332VDNSflLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(66476007)(66556008)(64756008)(31686004)(66446008)(66946007)(91956017)(76116006)(6506007)(54906003)(2906002)(186003)(2616005)(31696002)(53546011)(86362001)(26005)(83380400001)(8936002)(6916009)(71200400001)(6486002)(8676002)(4326008)(966005)(498600001)(6512007)(36756003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VLsUJUaGdRFuaI6YppQomuiXFlOlNEg4hPhLumKi9j51b4EPcybX6FTr1JRMFyq1ozgQOp8TRrLKnpBTIXI559xSrMTUNtU4ok+2up/Jb+6Li/cWZo2j54pzVk5PEbGPGFgvYpUiPdgZ42r/Z9IfwiYVKzctQ4hyB8vmoFoDqONdsSqn+OA9ugJ2YZcvwZUjPRV7oz53ViUuV3znZx/gA2Shlw5kYFb+nxfD8pm8tMLqFHMfBvwL02KVxWhjsCzCk0Y7E+J065HDTlxF59xuG72w7XkFip/8QzsvSASvMoYSTOWibT84DwSpt35opgip8FfK0EL4XssEI5JYJETiEkFTY2XMxKSvYS1ICyuEprSk1m8EUYpyo7NV1ZqiGZgWfsyvOunXbarSiesVa0OZq+jF82aHasu4JUEWnHxGf8vxDjnSmdkvqv5ocKc35Rey8E5gZEg601h0xeSvBBSZESRcmTcwwqz8LNINnX4vL5zJzaYLK/RyATQs7AI/KsynAIv1B48sGOOVTsmugVKqA4vNpmZS8kg6ja+MZKbkMHqH/+LK83iY8GOw2c3mX3Cy1WmUT83kzaDbMpPl1vAIugSv9KcWxjI2lEE5LoLo2v0eAb7bzEXL6UKVzfhjlp+AmHEQOyZ7xHIbsn8iJHBfyg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1972ED0DE4BED4A8DEA5095FAABA965@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ae3e17-aa43-4513-3dd3-08d8388d708f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 15:45:40.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciP1ogqXQQ5nlqApsS/ZhpTyzv83glwnFNVPSQILpnXZEJe2p8Dn7da3aGSpGSRiLCHUOuKYQiJy40MH5P8eykLesW3GsQlmgLxy08orlH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjA4LjIwMjAgMTg6MDgsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA0LzA4LzIwMjAgMTU6MDA6
MzgrMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pg0KPj4g
T24gMDQuMDguMjAyMCAxNDo0MiwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+Pj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBIZWxsbywNCj4+Pg0KPj4+IE9u
IDA0LzA4LzIwMjAgMTQ6MDc6MzcrMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+Pj4+ICB2
b2lkIF9faW5pdCBhdDkxcm05MjAwX3BtX2luaXQodm9pZCkNCj4+Pj4gIHsNCj4+Pj4gKyAgICAg
c3RhdGljIGNvbnN0IGludCBtb2Rlc1tdIF9faW5pdGNvbnN0ID0gew0KPj4+DQo+Pj4gWW91IGRv
bid0IG5lZWQgdGhhdCB0byBiZSBzdGF0aWMgYXMgaXQgaXMgbm93IGxvY2FsIHRvIHRoZSBmdW5j
dGlvbi4NCj4+Pg0KPj4+PiArICAgICAgICAgICAgIEFUOTFfUE1fU1RBTkRCWSwgQVQ5MV9QTV9V
TFAwDQo+Pj4+ICsgICAgIH07DQo+Pj4+ICsNCj4+Pj4gICAgICAgaWYgKCFJU19FTkFCTEVEKENP
TkZJR19TT0NfQVQ5MVJNOTIwMCkpDQo+Pj4+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4+Pg0K
Pj4+PiArICAgICBhdDkxX3BtX21vZGVzX3ZhbGlkYXRlKG1vZGVzLCBBUlJBWV9TSVpFKG1vZGVz
KSk7DQo+Pj4NCj4+PiBGb3Igcm05MjAwIGFuZCBhdDkxc2FtOSwgSSB3b3VsZCBub3QgYWxsb3cg
Y2hhbmdpbmcgdGhlIHBtX21vZGVzIGFuZA0KPj4+IHNpbXBseSBlbmZvcmNlIHN0YW5kYnlfbW9k
ZSA9IEFUOTFfUE1fU1RBTkRCWSBhbmQgc3VzcGVuZF9tb2RlID0NCj4+PiBBVDkxX1BNX1VMUDAu
SSBkb24ndCB0aGluayB5b3UgaGF2ZSBhbnkgdXNlciB0aGF0IGV2ZXIgY2hhbmdlZCB0aGF0DQo+
Pj4gYmVoYXZpb3VyIGFsc28gdGhhdCBhdm9pZHMgaW5jcmVhc2luZyB0aGUgYm9vdCB0aW1lIGZv
ciB0aG9zZSBzbG93IFNvQ3MuDQo+Pg0KPj4gT0ssIGJ1dCBib290YXJncyBpcyBwYXJzZWQgYXQg
YSBtb21lbnQgd2hlbiB0aGVyZSBpcyBubyBpbmZvcm1hdGlvbiBhYm91dA0KPj4gdGhlIG1hY2hp
bmUgdGhhdCBpcyBydW5uaW5nIHRoZSBjb2RlLiBBbmQgZW5mb3JjaW5nIHRoaXMgaW4gKl9wbV9p
bml0KCkNCj4+IGZ1bmN0aW9ucyBmb3Igcm05MjAwIGFuZCBhdDkxc2FtOSBtYXkgY2hhbmdlIHN1
c3BlbmQgYW5kIHN0YW5kYnkgbW9kZSB0aGF0DQo+PiB1c2VyIHNlbGVjdGVkLiBJZiB0aGVyZSBp
cyBubyB1c2VyIHVwIHRvIHRoaXMgbW9tZW50IHRoZXJlIGlzIHN0aWxsIHRoZQ0KPj4gcG9zc2li
aWxpdHkgb2YgYmVpbmcgb25lIGluIHRoZSBmdXR1cmUuDQo+Pg0KPiANCj4gU28gbGV0J3MgcHJl
dmVudCB1c2VycyBmcm9tIGRvaW5nIHRoYXQuIFVudXNlZCBhcmd1bWVudHMgYXJlIHNpbGVudGx5
DQo+IGlnbm9yZWQgd2hpY2ggaXMgZXhhY3RseSB3aGF0IHdlIHdhbnQgdG8gZG8uDQoNCkNhbiB5
b3Ugc2hhcmUgd2hhdCBhcmUgeW91IHRoaW5raW5nIGFib3V0PyBZb3Ugd2FudCB0byBub3QgcGFy
c2UNCmF0bWVsLnBtX21vZGVzIGZvciB0aGlzIG1hY2hpbmVzPw0KDQo+IFlvdSB3b24ndCBtYWtl
IG1lIGJlbGlldmUNCj4gdGhlcmUgaXMgYWN0dWFsbHkgYSB1c2UgY2FzZSBmb3Igc3dhcHBpbmcg
dGhlIHN0YW5kYnkgYW5kIHN1c3BlbmQNCj4gbWVhbmluZ3MuDQpXaGF0IGkgd2FudCB0byBzYXkg
aXMgdGhpczoNCmJvb3RhcmdzIGNvbnRhaW5zIGF0bWVsLnBtX21vZGVzPXVscDAsc3RhbmRieQ0K
DQp0aGlzIGxlYWRzIHRvDQpzdGFuZGJ5X21vZGU9dWxwMA0Kc3VzcGVuZF9tb2RlPXN0YW5kYnkN
Cg0KQnV0IHlvdSB3YW50IGluIGNvZGUgdG8gZm9yY2UNCnN0YW5kYnlfbW9kZT1zdGFuZGJ5DQpz
dXNwZW5kX21vZGU9dWxwMA0KDQpUaGUgcXVlc3Rpb24gaXM6IGlzIHRoaXMgd2hhdCB5b3UgYXJl
IHRoaW5raW5nIHRoaXMgc2hvdWxkIGJlIGRvbmU/DQoNCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBC
ZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcN
Cj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiA=
