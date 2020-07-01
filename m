Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EEF20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kFbkH3HY";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JI+M2fWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGAImA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:42:00 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32682 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgGAIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593592918; x=1625128918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=euoqUb6UiQUAU86ug0tGvfzv+zbwA1reQrNl9BEUGR0=;
  b=kFbkH3HY1jfnX8pzPog7RFkmqv/q6gSKEEE1zd8eUHMn0McpIcZxXEai
   z/Z+/rKap7ZOwu+l73IFYxGm3Lp3Km3FTNi++SAHbLDY1VOSBT1WdDFP/
   spfobDhb/nKeIq9nvBKaz7Lawii4l3/OqKEk0rqyM4jmhcAjOxDYPILaQ
   v6/8e5Dupt2AREuVDRog7fWLrniO0yO5U7CZntVutmltmmsRxiT872Ahq
   0tb50rOm2rwkUWWcC1fs2DgvbCgXHuRrCsvxAa0pNwC1xppzHSDaaqy4Y
   Lu+9OECeZuEQYnr+WbFEbzJOhWRUC0U9wSRSfMECACtUaGqgQftQh8hxn
   g==;
IronPort-SDR: Ujko8Zk0rhuQHx5xLlTMlExaONsiTnMtitHOQl3tFNBoEf5YTHVS+af6htJlAZK0ak+G8RlrSz
 xgmHu6PWAAMilx/MBhX8hfp8i63OLiLCkdjw/KvAYueR3pftg7iE4ef0GIs2weFVN2y1riKq7O
 /18MDAz27qmZuWbGpLXUCNIpr3racSgLWlp611geLY1tclL0E+XWFzAqEMXMkCr3Q6/iK13FD+
 z7gaRcdPM6Q3hcTbOxqnGExjUnPwPh5Yvi3CpXp43d/dYANJB61gb6cXDxa1ICTJA5FWQKEaFj
 TOE=
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="80323258"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2020 01:41:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 01:41:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 1 Jul 2020 01:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnpN9BbHnRxhsmhCKDGlDHNAWawR0UGOG5p48HjGtuPJz8ezDuIzQ4r9nbjL49sToEAKAPw88og9T6R4Ev/ZGkoiul4NrjjXuJpD5wgf2HI8eHxGj5NN9uoL05SF6IkbNJ7OYH0l38/28r6w8W0PVV3ygGuTa/WrE1DhNYJY25yfRruThG8vIcZzYwAEDeTy/OByMC3Al+xpjD4Ic4n0zxyINNDO8vlZSR/rrGFHQiy7lTuEx+U998KBWCiy2INAXEZqukY2J08e3JT4N2jqmzYPO+5DduzGFjGWqE8cybY9sn/uB6PaAVuHN4J53de1nSyQ8iAnCNuwBDghnkLkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoqUb6UiQUAU86ug0tGvfzv+zbwA1reQrNl9BEUGR0=;
 b=ibv8fLJAPIosMKys1YdL+X+rLxzae6rf79DN+MAJmpiWs/XsSIZxlYzpNYbotpnSLGvJsfCSwyR8HBYmqqmASKZOaayPZEJANMNMSPIkbxRGcBkzxnDBnPKYygU9SHHl2coQUP1tA8v9xnGFGr+CBexSAwOaxwQmURZSqb+3grVKc/9AevgqSLudU2ZYbfq4tAI6nrQHgJb3yMIqHOKbTswNnaj3yZInsJKRtOprBYp0fv1swal8LlOUl5u05Eq5NL/LD3vHVbo47jPfe7dDgk0DgggElfcN4YM7GP9StDYL6uu+ifWTqCSlf51R1DiHP5BX6aNBiWMj36F+yjHRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoqUb6UiQUAU86ug0tGvfzv+zbwA1reQrNl9BEUGR0=;
 b=JI+M2fWAKf1pO41r9M+pOLiMiqMo+I0e/68EfFpzWiSfJIApSL9yHXzgoIjp/D2efI6czQ6euYHJCzF0Sgv9gYwxHn2hmgACl95f0AGH0P8s+QvxYhiUCNmhJKROuQUgq4mCZmG+G3jghK1qN4TnOlN11gVR9wB2Z/W/v3XkIHI=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3799.namprd11.prod.outlook.com (2603:10b6:a03:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 08:41:52 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 08:41:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wuxy@bitland.com.cn>, <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <linux-mtd@lists.infradead.org>, <stlin2@winbond.com>,
        <vigneshr@ti.com>
CC:     <wuxy@bitland.corp-partner.google.com>
Subject: Re: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Thread-Topic: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Thread-Index: AQHWT4N3W/OUOumSFUWYBQmrBfACaQ==
Date:   Wed, 1 Jul 2020 08:41:52 +0000
Message-ID: <172b3f0b-9341-7f44-b855-1c353e321e2d@microchip.com>
References: <20200528033600.26105-1-wuxy@bitland.com.cn>
In-Reply-To: <20200528033600.26105-1-wuxy@bitland.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: bitland.com.cn; dkim=none (message not signed)
 header.d=none;bitland.com.cn; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459e0a65-5489-4861-e797-08d81d9a9a64
x-ms-traffictypediagnostic: BYAPR11MB3799:
x-microsoft-antispam-prvs: <BYAPR11MB37998B3C0FB6881FDDA4209BF06C0@BYAPR11MB3799.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZoqvkPWC974lFnhxgR4SenA7NQGpfcj5c5C2TF5a0J8QD5Hu7CG8R7373XV/f3ORQ67/I4IZgUtS/ZNul/LWnNhfLxs0iltAJQc9ZiLNpjpc2xRnnO4TuilDB7kBc/IruS1RLa8PC3GO4OHhuq2ZOwR6t3TbUPfjzcM5pJM6EUkSmpvGfxhlbM6z0L6n8026sOJ4OMiwl9Oo7GHa3+ZvbTwgll2ddmYB1+XNyojv09KBw4r8Y0liv1qag0YyVSbb51Ll3EwpM7mF+ZSHJYJsOhTikG7V+m8QTcyHDAA2DSiUNGe0tvFqb7dTohFFOne9BMMBb0WC7ms89F+deTnopAjbnxaJO0oSgnnxaQn2jCDMmYpXjkk50X2TTFEGsHqBwBg6hJkA6aFVUAn3Ba9WOqaZ3wd4C20xqg4I2QFrGTTUduxMG8SVdEUYSjB76XEzrMZacpNPOH+K2QYbzl55w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(31696002)(66556008)(6512007)(91956017)(86362001)(83380400001)(186003)(2616005)(5660300002)(71200400001)(4326008)(26005)(2906002)(6486002)(316002)(8676002)(478600001)(31686004)(110136005)(6506007)(36756003)(66476007)(66446008)(76116006)(53546011)(64756008)(8936002)(66946007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BRCln6OC/X5G8yiB0R61gzPw1abyR2cl7QcPwNHUbubdklrG1XKOpvy8k3uRFNyADuR8dyli1muosokK4SHuvK7/EO8iA4CXvlE2Szy9uaWjthNBeaUI2SLPSLNRb8PRRal9cWG+QsE3bmku/mprKCzYES5Uzc/Vei66G5i3sMwzeiuFtxF6bnCOMHrbJSIs0+Ssg+2U4zltYvO2qRrq6vVE4LMKsq0K0p6lpbOyeGQYsMlelBtfRLY4a1m5D72xBMNfWuV0vMalTbbCmMwb6iBRtuGbotPYYlNBJS7qvEtq4FBmMWHdR8TtIeHLc5no2WQ2V56R5oformx5Op2WEpRKa/01a2q1+aWeka4vMixbHHcMn/kCJy7v07nNhzmiD2vXyXjOBGEE+b7AoHianHZap2FaEErHkDuGqKEm+aVGBWaiW5M0ALqcZmq60nC1dxCSHcyJPTKR2BxjGDgJnEUj06525D1Uuc8CNOw5mMQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3E292EBA091654B8317AF18A9AADA52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459e0a65-5489-4861-e797-08d81d9a9a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 08:41:52.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lzuSlDl2M2QaTZJJ16c3la3+321QHj0Mwrzk6zywlaEyNxCuUN5l4LIXchL/otx+EsT5oGnk00SVEDva6C/fxCmxnvhezD55sz6xKHicKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOC8yMCA2OjM2IEFNLCB3dXh5QGJpdGxhbmQuY29tLmNuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IHd1eHkgPHd1eHlAYml0bGFu
ZC5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gDQo+IFdpbmJvbmQgaGFzIG5ldyAxLjhWIFNQ
SSBOT1IgRmxhc2ggSURzLHdlIG5lZWQgdG8gdXNlIHRoZSBTUEkNCj4gZmxhc2ggSURzIGluIGt1
a3VpIHNlcmllcyx0aGlzIHBhdGNoIGNhbiBzdXBwb3J0IHRoZSBuZXcgZmxhc2ggSURzLg0KDQpX
aGljaCBmbGFzaGVzIHdlcmUgdGVzdGVkPw0KDQpPbmUgc2hvdWxkIGRvIGEgcmVhZCwgZHVtcCB0
aGUgY29udGVudCwgZXJhc2UsIGR1bXAgY29udGVudCB0byBjaGVjayB0aGF0DQplcmFzZSB3YXMg
ZmluZSwgd3JpdGUgYSByYW5kb20gZ2VuZXJhdGVkIGZpbGUsIHJlYWQgYmFjayBhbmQgY29tcGFy
ZS4NCg0KSSBzZWUgdGhhdCB5b3UgYWRkZWQgdGhlIGxvY2tpbmcgZmxhZ3MgdG9vLiBXZXJlIHRo
ZSBsb2NraW5nIG9wcyB0ZXN0ZWQ/DQoNCldlIGRvbid0IGFkZCBmbGFzaGVzIG9yIGNhcHMgdGhh
dCBhcmUgbm90IHRlc3RlZCwgcGxlYXNlIHNwZWNpZnkgaW4gdGhlDQpjb21taXQgbWVzc2FnZSB3
aGF0IHdhcyB0ZXN0ZWQuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpbmd5dSBXdSA8d3V4eUBi
aXRsYW5kLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTVCBMaW4g
PHN0bGluMkB3aW5ib25kLmNvbT4NCj4gVGVzdC1ieTogTmljb2xhcyBCb2ljaGF0IDxkcmlua2Nh
dEBjaHJvbWl1bS5vcmc+DQo+IA0KPiAtLS0NCj4gVGhpcyBwYXRjaCBjb3BpZWQgZnJvbTpodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzExNTA3NTYvLA0KPiBUaGUgb3JpZ2luYWwg
cGF0Y2ggaXMgaW52YWxpZCxzbyByZS1zdWJtaXQgYSBuZXcgcGF0Y2ggZm9yIHRoaXMuDQo+ICBk
cml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyB8IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci93aW5ib25kLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPiBpbmRleCAx
N2RlYWJhZDU3ZTEuLmNkYTRmODg0N2JkNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3Bp
LW5vci93aW5ib25kLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4g
QEAgLTYxLDYgKzYxLDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyB3aW5ib25k
X3BhcnRzW10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQ
SV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ICAgICAgICAgeyAidzI1
bTUxMmp2IiwgSU5GTygweGVmNzExOSwgMCwgNjQgKiAxMDI0LCAxMDI0LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfUVVBRF9SRUFEIHwgU1BJX05PUl9E
VUFMX1JFQUQpIH0sDQo+ICsgICAgICAgeyAidzI1cTY0and4eElNIiwgSU5GTygweGVmODAxNywg
MCwgNjQgKiAxMDI0LCAxMjgsDQoNCldlIGRvbid0IHJlYWxseSBjYXJlIGFib3V0IHRoZSBQYWNr
YWdlIFR5cGUsIGl0IGRvZXMgbm90IGNoYW5nZSB0aGUgZmxhc2gNCmNhcHMsIHdlIGNhbiBkcm9w
ICJ4eCIgZnJvbSB0aGUgbmFtZS4gQWxzbywgdGhlIG1hbnVmYWN0dXJlciBjYW4gaW50cm9kdWNl
DQpuZXcgZmxhc2hlcyB3aXRoIGRpZmZlcmVudCB0ZW1wZXJhdHVyZSByYW5nZXMgd2l0aG91dCBj
aGFuZ2luZyB0aGUNCmZsYXNoIGNhcHMsIHNvIHdlIHNob3VsZCBkcm9wIHRoZSAiSSIgZnJvbSB0
aGUgbmFtZSB0b28uDQoNClRoZSBmbGFzaCBuYW1lIHdvdWxkIGJlY29tZSB3MjVxNjRqd20NCg0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFE
IHwgU1BJX05PUl9RVUFEX1JFQUQgfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJ
X05PUl9IQVNfTE9DSyB8IFNQSV9OT1JfSEFTX1RCKSB9LA0KPiArICAgICAgIHsgIncyNXExMjhq
d3h4SU0iLCBJTkZPKDB4ZWY4MDE4LCAwLCA2NCAqIDEwMjQsIDI1NiwNCg0KdzI1cTEyOGp3bQ0K
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JF
QUQgfCBTUElfTk9SX1FVQURfUkVBRCB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBT
UElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl9IQVNfVEIpIH0sDQo+ICsgICAgICAgeyAidzI1cTI1
Nmp3eHhJTSIsIElORk8oMHhlZjgwMTksIDAsIDY0ICogMTAyNCwgNTEyLA0KDQp3MjVxMjU2andt
DQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxf
UkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikgfSwNCg0KdzI1cTI1Nmp3bSBoYXMg
NCBibG9jayBwcm90ZWN0aW9uIGJpdHMsIGxvY2tpbmcgd2FzIG5vdCB0ZXN0ZWQgZm9yIHRoaXMg
Zmxhc2guDQoNCkNoZWVycywNCnRhDQo=
