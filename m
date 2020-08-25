Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB4DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AD220706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="WqxvrIMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgHYJfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:35:38 -0400
Received: from mail-eopbgr130070.outbound.protection.outlook.com ([40.107.13.70]:6465
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728475AbgHYJfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:35:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIaMlYBCfs6yY78pYCHGeT/EqD+Gee8p4EwC9wsn4ny2XOHdc6F0ozo6mXFy5mHKGqfYSvUXoiX7rqBtHGAgNACaVPzLrtMpJQIKrb5MX2g9YgdZ8OZGhUBRWkNENTex00qLDDwBnbHwbEgPXyMcrHkN5w8jrrjsYBb9jd6CBYAdRv/yMEQ9+j2jVogtboH6we8ecE7W7tMBVu4EwWvXIQBZ6NMUB8Jm3jXZLblqyCijy2O9GM+gSlmK7wrfWlSQGyefsFzVNFR0RU5o1SsNK3n7zftFzl8KfgByNbxWN+WqPWy9uGV558b9v/Ti8Av4O1W1waA1cFdJWckymP5olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfezyYbntFdmllu6vuYO5+9W6NXi8LM8nvI2QCgjKMU=;
 b=VcW+Rm9Ep0OqWJqO4cYiDpgw4inui2Uvgm3aOGdvf0UhExqRF8Ej0IkVMSVF+Z5nM85K0ZgZjfGuoOLgBD83xYBghj+SoUiLgC6OC/qoscG5MLub5HQK0IBPoIeC751d0KcZLPa9aEhnQpohsXQhSG17t1P6XazdBcbIR2uz3TEa34ZBSqjB3iLedyBIgpPUOfoq4emBNx0Dvqmm8Ldh3ccmou4F9ax7J7Q5oXJ4AceidXIWV+KsQfRv5bxmWlcHD9AYhJtHfJ+7XWw5AN0Uywu0wXD1Ya9cgr9fbRXz6QKIHnFzqCjG4SDKRtvEfbYgF2xR5vbTKDEvLtqxYiHKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfezyYbntFdmllu6vuYO5+9W6NXi8LM8nvI2QCgjKMU=;
 b=WqxvrIMO/+opW+xGJsVjEJmRubGGIkS0gMBZxAThmKf5amA/DzlFj1ot9Mlv/N53avFYwPqjr5lVLavFb55su+ZEQ0A7Zwf/Tklf0u0TjU74E+09qg0nkaJtZ2hNFGwv5VnpHm+u1TYe9pL35WBdehal7vVRzoV4g26BcyELJa4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2395.eurprd03.prod.outlook.com (2603:10a6:3:6d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Tue, 25 Aug 2020 09:35:29 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 09:35:29 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "krzk@kernel.org" <krzk@kernel.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align regulator
 names with schema
Thread-Topic: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Thread-Index: AQHWeknSKDZwJ6TG4kKPN+CgQ8rFoqlIY7aAgAAJkYCAAAVqAIAAAZMAgAAIzwCAAAGGgIAAEu2A
Date:   Tue, 25 Aug 2020 09:35:28 +0000
Message-ID: <8c4751a58c89ac10d3b551c74814cf3dd413080e.camel@fi.rohmeurope.com>
References: <20200824190701.8447-1-krzk@kernel.org>
         <20200824190701.8447-3-krzk@kernel.org>
         <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
         <20200825072537.GA5914@kozik-lap> <20200825074500.GA19323@kozik-lap>
         <20200825075038.GA10148@kozik-lap>
         <3018d638b5753e629ebdb6a25973aeff7e446720.camel@fi.rohmeurope.com>
         <20200825082737.GA12902@kozik-lap>
In-Reply-To: <20200825082737.GA12902@kozik-lap>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba00f68-b4fd-4dd4-0ced-08d848da346d
x-ms-traffictypediagnostic: HE1PR0301MB2395:
x-microsoft-antispam-prvs: <HE1PR0301MB239567832445930C71263B3CAD570@HE1PR0301MB2395.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/cFLBccNlkRUAE9bV7KNny9K/vDdJiG2BRn0pw1uC1YZ7x7cjk4p5YbknoNZLlkdHWOUfy+mxX0YBxdUtYyan+ezjW0K5xctLqQ5UkDrogxjpg3sdwiQJvdLSAnxLnprWFnsjQnZrbyqgOSUppb6hrIsEPD0gKAKCdI/BOxnz3p1z0meDZ1dlRqjwGHvKJjG2QfH2RE7ne8TjI7gOOL7ONMROW99Hxsdhij5fzifKftEnJY9GaRvIcaMG0NNa40t3ut5lRUErBU+QThDFM0HbaJPUNPVPeZ97Z1rsSWO7tnw+wJew9M7pwQBBAjXUXXFrJHapHj4DJszl90zvXGAmc9+co//BcV9p38uM+VC80YntxMgoniGT20H117tLfD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(366004)(376002)(136003)(4326008)(3450700001)(86362001)(6486002)(6916009)(64756008)(66476007)(76116006)(2616005)(66556008)(316002)(66446008)(54906003)(66946007)(71200400001)(26005)(8936002)(478600001)(186003)(7416002)(6512007)(8676002)(83380400001)(6506007)(5660300002)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lsWuB6tsFSz6KPXsq2eMJwKZ34xHGHpc0iws7uaMa5D8YbhmjNa2OkNJWMdl/OKkLiNHmFm7dHdBw8UuXuNHbqg44QZ5H7UoL/JP9FBYgZuzZS9FTwOpwKgUx9i3KmesHofRcqGZlabc59ADLGugSPHH7WxgIGL7jFF8PsyDAhZ4BmqpwNSmbKMR4y2kFDMVuJpB0q2mSFbzRdYnbzBCYCcQ7AyPYktaq+b+3+okUKpvK2h2SwrN2ok7wDDfC/D8+CUsFPoVZwJeyvRcWeQq/fkPmsQXfr6pMX2m6AwWNS6hSEfYP6Lh1WCX9J0OFEPR3R1em0omZ2HcQyRqQJ2WNPqV6yN/0LDAcQutBik0RqsB4LryE0xS605WzaG9gPy5Lse3k41nE6BU2LyP9YCLLRcTY5B2l3+t5+r/lWcZTWpA7/DYdLh9VefJbM/o6l6mWIjAv4igRLZqGgXvO5v4lkvyeAvzEUXUWcZBFjeQiit2pnB1QLChnoIprVOjA675t2ANiBZBSjXT7OeThA5DWxErUw6MKiHe9vRyp92rUB0TpBKgZ9BBBd9cHvc9Vc0WvBx7bGvsfKJqOM7QmPJ8sd9c4hD91HtvP4EgDCj6C2nWeDcjy50Je6SY3vf5yuvqG5gMCwPx428PqwnVg7alZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <37DDAC07B6C64143B7F40A28E9503940@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba00f68-b4fd-4dd4-0ced-08d848da346d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 09:35:28.9609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVVs6ropl63vNB5IBuq4JXiq/VwhHIeqSsla1a4SpoxKJownNQqA3Rzhrs2kDLEodeXgqAbkWzevMzyyi4Tn1TLyyklgFhmDPNrmxPMSdeNoaRFPrDnW4XYHeGzicd1C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMDgtMjUgYXQgMTA6MjcgKzAyMDAsIGtyemtAa2VybmVsLm9yZyB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMjUsIDIwMjAgYXQgMDg6MjI6MThBTSArMDAwMCwgVmFpdHRpbmVu
LCBNYXR0aSB3cm90ZToNCj4gPiBIZWxsbyBLcnp5c3p0b2YsDQo+ID4gDQo+ID4gT24gVHVlLCAy
MDIwLTA4LTI1IGF0IDA5OjUwICswMjAwLCBrcnprQGtlcm5lbC5vcmcgd3JvdGU6DQo+ID4gPiBP
biBUdWUsIEF1ZyAyNSwgMjAyMCBhdCAwOTo0NTowMEFNICswMjAwLCBrcnprQGtlcm5lbC5vcmcg
d3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgQXVnIDI1LCAyMDIwIGF0IDA5OjI1OjM3QU0gKzAyMDAs
IGtyemtAa2VybmVsLm9yZw0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIEF1ZyAy
NSwgMjAyMCBhdCAwNjo1MTozM0FNICswMDAwLCBWYWl0dGluZW4sIE1hdHRpDQo+ID4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBIZWxsbyBLcnp5c3p0b2YsDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IEp1c3Qgc29tZSBxdWVzdGlvbnMgLSBwbGVhc2UgaWdub3JlIGlmIEkgbWlzdW5kZXJz
dG9vZCB0aGUNCj4gPiA+ID4gPiA+IGltcGFjdCBvZg0KPiA+ID4gPiA+ID4gdGhlIGNoYW5nZS4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gTW9uLCAyMDIwLTA4LTI0IGF0IDIxOjA2ICsw
MjAwLCBLcnp5c3p0b2YgS296bG93c2tpDQo+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gRGV2aWNlIHRyZWUgc2NoZW1hIGV4cGVjdHMgcmVndWxhdG9yIG5hbWVzIHRvIGJlDQo+ID4g
PiA+ID4gPiA+IGxvd2VyY2FzZS4gIFRoaXMNCj4gPiA+ID4gPiA+ID4gZml4ZXMNCj4gPiA+ID4g
PiA+ID4gZHRic19jaGVjayB3YXJuaW5ncyBsaWtlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gICAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LQ0KPiA+
ID4gPiA+ID4gPiBldmsuZHQueWFtbDogDQo+ID4gPiA+ID4gPiA+IHBtaWNANGI6DQo+ID4gPiA+
ID4gPiA+IHJlZ3VsYXRvcnM6TERPMTpyZWd1bGF0b3ItbmFtZTowOiAnTERPMScgZG9lcyBub3Qg
bWF0Y2gNCj4gPiA+ID4gPiA+ID4gJ15sZG9bMS02XSQnDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5v
cmc+DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiAgLi4uL2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW4tZGRyNC1ldmsuZHRzICAgIHwgMjINCj4gPiA+ID4gPiA+ID4gKysrKysrKysr
LS0tLS0tDQo+ID4gPiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW4tZGRyNC0NCj4gPiA+ID4gPiA+ID4gZXZrLmR0cw0KPiA+ID4gPiA+ID4gPiBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMNCj4gPiA+ID4gPiA+ID4g
aW5kZXggYTFlNTQ4M2RiYmJlLi4yOTljYWVkNWQ0NmUgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1kZHI0LWV2ay5kdHMNCj4g
PiA+ID4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLWRk
cjQtZXZrLmR0cw0KPiA+ID4gPiA+ID4gPiBAQCAtNjAsNyArNjAsNyBAQA0KPiA+ID4gPiA+ID4g
PiAgDQo+ID4gPiA+ID4gPiA+ICAJCXJlZ3VsYXRvcnMgew0KPiA+ID4gPiA+ID4gPiAgCQkJYnVj
azFfcmVnOiBCVUNLMSB7DQo+ID4gPiA+ID4gPiA+IC0JCQkJcmVndWxhdG9yLW5hbWUgPSAiQlVD
SzEiOw0KPiA+ID4gPiA+ID4gPiArCQkJCXJlZ3VsYXRvci1uYW1lID0gImJ1Y2sxIjsNCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSBhbSBub3QgYWdhaW5zdCB0aGlzIGNoYW5nZSBidXQgSSB3
b3VsZCBleHBlY3Qgc2VlaW5nIHNvbWUNCj4gPiA+ID4gPiA+IG90aGVyDQo+ID4gPiA+ID4gPiBw
YXRjaGVzIHRvbz8gSSBndWVzcyB0aGlzIHdpbGwgY2hhbmdlIHRoZSByZWd1bGF0b3IgbmFtZSBp
bg0KPiA+ID4gPiA+ID4gcmVndWxhdG9yDQo+ID4gPiA+ID4gPiBjb3JlLCByaWdodD8gU28gbWF5
YmUgSSBhbSBtaXN0YWtlbiBidXQgaXQgbG9va3MgdG8gbWUgdGhpcw0KPiA+ID4gPiA+ID4gY2hh
bmdlIGlzDQo+ID4gPiA+ID4gPiB2aXNpYmxlIGluIHN1cHBsaWVycywgc3lzZnMgYW5kIGRlYnVn
ZnMgdG9vPyBUaHVzIGNoYW5naW5nDQo+ID4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gPiBzb3Vu
ZHMNCj4gPiA+ID4gPiA+IGEgYml0IGxpa2UgYXNraW5nIGZvciBhIG5vc2UgYmxlZWQgOikgQW0g
SSByaWdodCB0aGF0IHRoZQ0KPiA+ID4gPiA+ID4gaW1wYWN0IG9mDQo+ID4gPiA+ID4gPiB0aGlz
IGNoYW5nZSBoYXMgYmVlbiB0aG9yb3VnaGx5IHRlc3RlZD8gQXJlIHRoZXJlIGFueSBvdGhlcg0K
PiA+ID4gPiA+ID4gcGF0Y2hlcw0KPiA+ID4gPiA+ID4gKHRoYXQgSSBoYXZlIG5vdCBzZWVuKSBy
ZWxhdGVkIHRvIHRoaXMgY2hhbmdlPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9oLCBjcmFwLCB0
aGUgbmFtZXMgb2YgcmVndWxhdG9ycyBpbiB0aGUgZHJpdmVyIGFyZQ0KPiA+ID4gPiA+IGxvd2Vy
Y2FzZSwNCj4gPiA+ID4gPiBidXQgdGhleQ0KPiA+ID4gPiA+IHVzZSBvZl9tYXRjaF9wdHIgZm9y
IHVwcGVyIGNhc2UuIFNlcmlvdXNseSwgd2h5IG1ha2luZyBhDQo+ID4gPiA+ID4gYmluZGluZw0K
PiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+ID4gaXMgY29udHJhZGljdG9yeSB0byB0aGUgZHJpdmVy
IGltcGxlbWVudGF0aW9uIG9uIHRoZSBmaXJzdA0KPiA+ID4gPiA+IGRheT8NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBUaGUgZHJpdmVyIGdvZXMgd2l0aCBiaW5kaW5nLCByaWdodD8gT25lIGV4cGVj
dHMgdXBwZXJjYXNlLA0KPiA+ID4gPiA+IG90aGVyDQo+ID4gPiA+ID4gbG93ZXJjYXNlLi4uDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gQW5kIHRlbGwgbWUsIHdoYXQgaXMgbm93IHRoZSBBQkk/IFRo
ZSBiaW5kaW5nIG9yIHRoZQ0KPiA+ID4gPiA+IGluY29ycmVjdA0KPiA+ID4gPiA+IGltcGxlbWVu
dGF0aW9uPw0KPiA+ID4gPiANCj4gPiA+ID4gV2FpdCwgbXkgbWlzdGFrZS4gSSBnb3QgY29uZnVz
ZWQgYnkgbXkgb3duIGNoYW5nZS4gVGhlIG5vZGUNCj4gPiA+ID4gbmFtZQ0KPiA+ID4gPiBzdGF5
cw0KPiA+ID4gPiB0aGUgc2FtZSwgc28gb2ZfbWF0Y2ggd2lsbCBiZSBjb3JyZWN0Lg0KPiA+IA0K
PiA+IFllcy4gSSB0aGluayBzbyB0b28uIE1hdGNoIHdpbGwgc3RpbGwgd29yayBhcyBlYXJsZXIu
DQo+ID4gDQo+ID4gPiA+IFRoZSBkcml2ZXIgaW50ZXJuYWxseSBhbHJlYWR5IHVzZXMgbG93ZXJj
YXNlIG5hbWVzLg0KPiA+IA0KPiA+IFllcC4gSSB3YXMgc2ltcGx5IHRoaW5raW5nIHRoYXQgaWYg
YW55b25lIGhhcyBiZWVuIHNwZWNpZnlpbmcgdGhlDQo+ID4gcmVndWxhdG9ycyBhcyBzdXBwbGll
cnMgYnkgbmFtZSAtIHRoZW4gdGhpcyBjaGFuZ2Ugd2lsbCBjaGFuZ2UNCj4gPiB0aGluZ3MNCj4g
PiAoYXMgaXMgc2VlbiBmb3IgTERPNSkuIEFkZGl0aW9uYWxseSwgaWYgYW55IHVzZXItc3BhY2Ug
U1cgaGFzIGJlZW4NCj4gPiByZWFkaW5nIHRoZSByZWd1bGF0b3Igc3RhdGVzIGZyb20gc3lzZnMg
LSB0aGVuIHRoZXNlIG5hbWVzIHdpbGwNCj4gPiBhbHNvDQo+ID4gY2hhbmdlIHRoZSBzeXNmcy4g
RGVidWdmcyBjaGFuZ2UgaXMgaG9wZWZ1bGx5IG5vdCBzdWNoIGEgYmlnIGRlYWwuDQo+IA0KPiBB
Ym91dCB1c2VyLXNwYWNlLCBJIHRoaW5rIHRoZSBlbWJlZGRlZCBEVCBpcyBub3QgcGFydCBvZiBr
ZXJuZWwgQUJJLA0KPiBzbw0KPiB0aGVyZSBpcyBubyBzdWNoIHJlcXVpcmVtZW50IGFib3V0IGtl
ZXBpbmcgaXQgc3RhYmxlLiBJIGFncmVlIHRob3VnaA0KPiBpdA0KPiBtaWdodCBiZSBhbm5veWlu
ZyBzdXJwcmlzZS4NCg0KSnVzdCB0byBlbnN1cmUgd2UgYXJlIHRhbGtpbmcgYWJvdXQgc2FtZSB0
aGluZzoNCkkgc2VlIHlvdSBhcmUgdGFsa2luZyBhYm91dCBlbWJlZGRlZCBEVCBub3QgYmVpbmcg
YW4gQUJJLiBJIGFncmVlIHdpdGgNCnlvdSAtIERUIGl0c2VsZiBpcyBub3QgQUJJLiBCdXQgaW4g
Y2FzZSB5b3UgbWlzc2VkIHRoaXMgd2UgaGF2ZToNCg0Kc3RhdGljIHNzaXplX3QgbmFtZV9zaG93
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUNCiphdHRyLA0KCQkJ
IGNoYXIgKmJ1ZikNCnsNCglzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldiA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KDQoJcmV0dXJuIHNwcmludGYoYnVmLCAiJXNcbiIsIHJkZXZfZ2V0X25hbWUo
cmRldikpOw0KfQ0Kc3RhdGljIERFVklDRV9BVFRSX1JPKG5hbWUpOw0KDQppbiByZWd1bGF0b3Ig
Y29yZS4gSSBiZWxpZXZlIHRoZSByZGV2X2dldF9uYW1lKHJkZXYpIHNoYWxsIGNoYW5nZQ0KYWNj
b3JkaW5nIHRvIHJlZ3VsYXRvci1uYW1lLiAoQnV0IGFzIEkgc2FpZCwgSSBoYXZlIG5vIGlkZWEg
aWYgdGhpcyBpcw0KdXNlZCBieSB1c2VyLXNwYWNlIG9uIHlvdXIgYm9hcmQgLSBJJ2xsIGxlYXZl
IHRoaXMgZm9yIHlvdSAmIG90aGVycyB0bw0KanVkZ2UpLg0KDQo+IA0KPiA+IFdoZXRoZXIgdGhp
cyByZWFsbHkgYnJlYWtzIGFueXRoaW5nIGlzIGJleW9uZCBteSBrbm93bGVkZ2UgYXMgSQ0KPiA+
IGRvbid0DQo+ID4gZXZlbiBoYXZlIHRoaXMgYm9hcmQuIEFueXdheXMsIEkgdGhpbmsgdGhhdCBi
eSBtaW5pbXVtIHRoZSBjb21taXQNCj4gPiBtZXNzYWdlIHNob3VsZCBwb2ludCBvdXQgdGhhdCB0
aGlzIGNoYW5nZSB3aWxsIGJlIHZpc2libGUgb3V0c2lkZQ0KPiA+IERUUw0KPiA+IGFuZCB0aGUg
QkQ3MTh4NyBkcml2ZXIgLSB1cCB0byB0aGUgdXNlci1zcGFjZS4NCj4gDQo+IEdvb2QgcG9pbnQs
IEkgd2lsbCBleHRlbmQgdGhlIGNvbW1pdCBtc2cgYWJvdXQgcG9zc2libGUgaW1wYWN0IGFuZA0K
PiBmaXhpbmcgc3VwcGxpZXMuDQo+IA0KDQpUaGFua3MgOikNCg0KLS1NYXR0aQ0KDQotLQ0KTWF0
dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywg
RmlubGFuZA0KU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0K
DQp+fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJlbmUgRGVzY2FydGVzLiBKdXN0IHRoZW4g
aGUgdmFuaXNoZWQgfn5+DQoNClNpbW9uIHNheXMgLSBpbiBMYXRpbiBwbGVhc2UuDQoibm9uIGNv
Z2l0byBtZSIgZGl4aXQgUmVuZSBEZXNjYXJ0ZSwgZGVpbmRlIGV2YW5lc2Nhdml0DQoNCihUaGFu
a3MgZm9yIHRoZSB0cmFuc2xhdGlvbiBTaW1vbikNCg0K
