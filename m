Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE5C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D058520719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2BVP1HOF";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vDidLKvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgDGOEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:04:16 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16822 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586268255; x=1617804255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cu2xeQUDjBBE37z76xOQ1L3cq1QISnJEKLlf7ySpSyQ=;
  b=2BVP1HOFNy3n1I72RG/vMxplqk1XG0VptBrQaNLJZ413VxrnRxQrvg8p
   ZoQHHOdIqYPiSP1S5Y2YBrSa+HHifQZtn/Ia4oTdnglRxE+5WmoIel34s
   t3/o/Z8AfHzEbkyXi7AhBM5qBZffSQQn2F4lKR1BQ3ycVpYOB+Kzf2rlg
   dPRYPLm+UZ9jScZXFz0XmdYxC5yEMfEs+H5MLag0VgD5Xrw9AwjRHNBpT
   Sju/HlGGZlz4zU1FqLNlNfjphhaVoZj1nyggs3V3Yk7jhI8w5WhlqJkxV
   SSAt6YxuCnFG/2Eav5T6xab/Hocu0m9yInlrq+iXRLS6oynfMH719WCXH
   g==;
IronPort-SDR: aSAo+oYOClxrezj4gEVQp7X6DcTZni2yl7sVJjYswQ3G+cA43Ss+vAQIL0O+51GeF5WCXeYxrD
 JNQbofB4p/wSTZtlskakSHDEbTwAVfSfIwBL2Mhr1NtnRACWcawtvAeRg2pHcwjsmVnxKFnu2x
 Cx1bpjWzjehbKqGZ8SQVCT7vWXY7ab1Qa6WllU6TFJgDHvHbzqBZzeSWnGkyUhwCkr/s+JKWbd
 BS/4etpy9wr0hmMHZ8C9cJmo6+KNnGdUce2TnF3ut+w6ouGpuaSUI5ilSHoh2NVl18+pfKe7Kd
 C+k=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="69648868"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 07:04:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 07:04:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 Apr 2020 07:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD6bBR+mqnMGYUbctwUbCDBg7Hr7OqK+/CsjLftqAqCmfVWxcBv0D+GBA5BwX1S3VW+ZfB1m+3rQIaZFqj7V68Oi3tEuRFERaLts6W+zeTSNy7gmAmbKga22IxRHAElRocZ/Zr7iBY/B7IZoVbRvVrK0FTlw0AaVAaoYK/JnA5Y1DG3WpSYfFGK8UM8lMD6UZa/DrqGorYFTAgUzOn33iEUBlLKGwle3fdzz6ypmXzS2LxA/wOHJzjy+hcshApWfX6FB1rVRD92D3NfanK9Ek/8g9T4N3FgMg8ujHrHG/3PnTeylxQvLEq8PllM43+HAqK3Fox5RyxrNk5ZIezoMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu2xeQUDjBBE37z76xOQ1L3cq1QISnJEKLlf7ySpSyQ=;
 b=DgcC2Wo8sBhk7eyGwA0KK7Jhrxz394bES/RVz69mxy2rj0d76Rr3le6vGOThHt6kvPf5VvFnAulvdC2XVP58lxHxaUqRnbaCvQCMATzyrF2qo7vMoJG6EfPopqdExIi7P/NhCnLC2Q/Unao3wD4lYkyGEMS7S3fFV+uX47yqrbvxWAZse2LgLX2XChgqd4xA6uefTVTAIRhoNPaKC31uvxKtptH8VRzEezV5IOvL/kCQ1/orja8BwFjb29tVLhf1hJQrDiky+XnwLq4HkEhGjnt6jiz3weDBOQAqoq1SxhJx5GhmLU9h1rbdaJgjm+VNphplavbOMLJzV5qu9klV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu2xeQUDjBBE37z76xOQ1L3cq1QISnJEKLlf7ySpSyQ=;
 b=vDidLKvzYak2rtQTgnTeen1SdXL2kBvBsJY7k+vSwadAVmg7WeUqSJOLD61xVc50EGjSQZL1OW/WVhzv/gcfLPgDGGz96dAdppFNN0x7eeynr3KxfkJ64WpHJ+IOexf8iOgEFUrGRUCha2X5plT1L5ndRVIyjjCXAr7h8d/UKqI=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) by
 DM6PR11MB3353.namprd11.prod.outlook.com (2603:10b6:5:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Tue, 7 Apr 2020 14:04:12 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::b1e1:1148:5130:3e7]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::b1e1:1148:5130:3e7%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 14:04:12 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 2/7] usb: gadget: udc: atmel: add compatible for SAM9X60's
 PMC
Thread-Topic: [PATCH 2/7] usb: gadget: udc: atmel: add compatible for
 SAM9X60's PMC
Thread-Index: AQHWDNhiGgvQ+kD9dkSS4M+c+kjssahtqt+AgAAGQ4A=
Date:   Tue, 7 Apr 2020 14:04:12 +0000
Message-ID: <9a8920cc-be8e-16f7-3cda-ceb349f84232@microchip.com>
References: <20200407122852.19422-1-cristian.birsan@microchip.com>
 <20200407122852.19422-3-cristian.birsan@microchip.com>
 <20200407134147.GI3628@piout.net>
In-Reply-To: <20200407134147.GI3628@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Cristian.Birsan@microchip.com; 
x-originating-ip: [2a02:2f01:5825:1b00:3c12:302d:fb00:70e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0adb271f-edd2-4bb2-4a60-08d7dafc8cba
x-ms-traffictypediagnostic: DM6PR11MB3353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB33530E7A2F341950CF081330EFC30@DM6PR11MB3353.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(2616005)(8676002)(6916009)(53546011)(81166006)(81156014)(8936002)(6506007)(498600001)(107886003)(31696002)(966005)(36756003)(4326008)(86362001)(6486002)(6512007)(2906002)(66946007)(71200400001)(66446008)(186003)(31686004)(54906003)(91956017)(5660300002)(76116006)(64756008)(66476007)(66556008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42Zyvl4X0o7VNnVSAxHIPuisaL+4TWcyIZQ9IxhJv5U070RKnZr11RGx0r21hDm2ntcasv9byulVySVDRcp/wBJWWHX8MoJd4Vfn6c7ckpAsvgbwvWcxCknYWQOlEC66LEwN1FmgkG9Lwlkwf5O5UGH8tLTPd33ggXD0J0Upp9GUNiF9SehSNOb3jl0WefmAKPy8Hn89ypwMU5FKEyujsFTLEZkEjmRBDY9zAQhzcN+P4KE6Fsl15eMByvfv5CmkhBP5jXLmAYj8/jI2XPTOCTdnX9GCTt5SSfm2otjzSqZy7Q7gPSfYzJ7Xv3a4Vc2On1F7WoUP3I7KyqkHCtG2Xkq92FjZh5SeshPQ2BJ4E6twsCaqqZo5/tohSBP7adNAMiscdxXePkxkZvO/GIwiQc0+jJ6ifPCdUiSFLEYxcAbCY3tlkAzRiXliVsIIraUFI0x0NqR54FYjE8/IJJ7gPMhzGYklD9rSpxR9N7TaXQgWvdnppR4/AbSvHHF+krJnQ+IfPO+mh8Ixo7PAZWbgIQ==
x-ms-exchange-antispam-messagedata: S1Bs+/KtBFh9fexRGdbeZFezdFqVzHCruTgZ8jRW2IgoDbH0ENPEpYdcII8KrB+KVK70Ch2u5vYoDIFJuOPayBV4tAt91El34oXC1ERFDhwKbUiP0SBdCh2Pb1vdhoqVCcfDRqFCf/WadSCmt2+pA6CNNy/XiaTXrEURf14ITnKuR3AeVDfgM49GdOT0HHWN2tEk/JTilNH7neoJLAxoFQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B990BB84F197DE4BB0D9D6CE923DE312@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adb271f-edd2-4bb2-4a60-08d7dafc8cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 14:04:12.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzaVR8f7IEeZ4VvWZxNctZqapEefyHRUKGHxdIB1lfCo5PRt0XEoTgB9mOTQ94foi9bUJAFTMb+lP0tif6wq1+gXXMfLOxa70B5MhWhxqx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC83LzIwIDQ6NDEgUE0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4gT24gMDcvMDQvMjAyMCAx
NToyODo0NyswMzAwLCBjcmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZy
b206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+
IEFkZCBjb21wYXRpYmxlIGZvciBTQU05WDYwJ3MgUE1DLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gW2NyaXN0
aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tIEFkZCBzZW50aW5lbCBhdCB0aGUgZW5kIG9mIHRoZSBh
cnJheV0NCj4+IFNpZ25lZC1vZmYtYnk6IENyaXN0aWFuIEJpcnNhbiA8Y3Jpc3RpYW4uYmlyc2Fu
QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVs
X3VzYmFfdWRjLmMgfCAyICsrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRj
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRjLmMNCj4+IGluZGV4IDMy
ZTViNDRkOWZiZC4uYzUwOTAyYjkxYTk2IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2F0bWVsX3VzYmFfdWRjLmMNCj4+IEBAIC0yMDU2LDYgKzIwNTYsOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBhdG1lbF9wbWNfZHRfaWRzW10gPSB7DQo+PiAgICAgICB7IC5j
b21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05ZzQ1LXBtYyIgfSwNCj4+ICAgICAgIHsgLmNvbXBh
dGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlybC1wbWMiIH0sDQo+PiAgICAgICB7IC5jb21wYXRpYmxl
ID0gImF0bWVsLGF0OTFzYW05eDUtcG1jIiB9LA0KPj4gKyAgICAgeyAuY29tcGF0aWJsZSA9ICJt
aWNyb2NoaXAsc2FtOXg2MC1wbWMiIH0sDQo+PiArICAgICB7IC8qIHNlbnRpbmVsICovIH0NCj4g
DQo+IFRoaXMgcGF0Y2ggY2FuIGJlIHNxdWFzaGVkIGluIHRoZSBwcmV2aW91cyBvbmUuDQoNCkkn
bGwgc3F1YXNoIGl0IGluIHYyLg0KDQo+IA0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgQm9v
dGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8v
Ym9vdGxpbi5jb20NCj4gDQoNCg==
