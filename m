Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FF320674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="mPEX+3nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGTHvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:51:35 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com ([40.107.2.139]:1134
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTHve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2eobh02jjUaNqSAxWe3uhqId0DqI3mPp0sReHzoakr5LniZrxts+aZVJWirnbu780GzVKMLEYphW8ARB8yGhv+mrTmnQPRxj8HjjgZr4CoxUowvwxkWt7WWg9oatcYFyW9bDIrRRZk35e0kdqI/VCZKcTqou+pA8m0+mpA/zE8BGj/L2krO7X6FT73kHhGMfJoLrudeo86+9Y3N1qeU4olLRHjnmBj/9z3AsLJ/GyZog6sGEe1Rn1/Hcufx9XTIqJS5AY+OUnyC2iDs2rxE1RV4d4CylwZ7UaIsxAialdwQZRHHKyL96h3UGTBt+sYrjg0SJM+wV49alO5PrCxcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z8NbxAc3mraN8N40UUuHiNsd/Xk8HO8r83SeQ/h1Oc=;
 b=SA4jsF+3hzm/3et6uISIAZpdGsnUfZdqGHNQJnRKu2G1Z5q2Q2Q6sBkxp908sqcTzEMP5opH/hswSqQxC30GqajoxyS7SVrVwUKHoY72s9xfpm7EwOv4BuyvQNy771+hBF0VR2J8hdVa+XFOVKrzKmdouVCzhyi2ewngSsA9noDHjDJepvsZxR4eaFRddprZbNc1zHcXcZWXCYEZ9KRwgZ+PNFd/hVs0wjuASjHS27UTtBqGofmDlyYBaWnuk/mY/xo7kW6+PRGWsVRv16Ihrv9N7PjtndaWPmxpivqH7MupPg9MNxyIcxTI+RGhHr/72azbOi69ZIveYK/Y7duwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z8NbxAc3mraN8N40UUuHiNsd/Xk8HO8r83SeQ/h1Oc=;
 b=mPEX+3njgJUgNpnT7iZr0ovylczb62rnpNfx3CTjZ6AGlHSbA2jHgPyXc/UQhk0cXMWuQEYeAxZuqD/yc2Stmb+ipPdJ71skc/sOfDhP389X35vlddl88GQ7+Q7c6H9pMOgnyLzGdbFE1Bx1S4DbMOkLB7ALDwVlptQU8GkPD1Y=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM7PR05MB6840.eurprd05.prod.outlook.com (2603:10a6:20b:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Mon, 20 Jul
 2020 07:51:30 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:51:30 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "jun.li@nxp.com" <jun.li@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIMLexdmM4+M0C6zPGY8HP2U6kH0FqAgACfygCAB2wiAIAARP2A
Date:   Mon, 20 Jul 2020 07:51:29 +0000
Message-ID: <163befb5f97724a1279a33023980da3264f0c00e.camel@toradex.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
         <20200714151822.250783-2-philippe.schenker@toradex.com>
         <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
         <08251297f72fe745be43205d0a73631f009681cc.camel@toradex.com>
         <AM7PR04MB71572600CE73140FE13CB17C8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB71572600CE73140FE13CB17C8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f02efdcd-5237-44a2-7739-08d82c81b6b0
x-ms-traffictypediagnostic: AM7PR05MB6840:
x-microsoft-antispam-prvs: <AM7PR05MB684079FABCC0ADC1B00134A8F47B0@AM7PR05MB6840.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMparIapX/jaZK2egr6QqNkD+BUWCGXHYkFRVL8wnuuENSilEIuQvhc7UO7K8w+VnfcnSpOOsZyuzStCJaeoWj4JSct4xXbIPsYnUREEFliRoSZxvtfEDxZRXcYfo79/ngzgSiu11KqY06U9FvuMxrX/XeGAa8VM0ZcU0n4E+ei/eDf8wGYN5OdkhlWRUYeGyjhFWfKiuG8eZLgIRYQdmoFGWWTOEVejUFhzRSbrreqvc2d8weKSulHkeDbXBAYS+fSjj7M3jJcZ+2CZrMClqiy2HYsDINWhViVeLGFdrjtpAuoXbUlRFnryKUmv960GfHLmLtGI4QDNJcfpLXiBHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39840400004)(26005)(8936002)(44832011)(6486002)(66946007)(71200400001)(316002)(64756008)(66476007)(66556008)(66446008)(7416002)(6512007)(2616005)(8676002)(54906003)(91956017)(83380400001)(4326008)(110136005)(5660300002)(86362001)(6506007)(186003)(36756003)(76116006)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ivuj6zEd80OI9s4eyxXuuYvAM5OT55VC+z6ZNFdYMOXMBWltH57Xp0izy+7cenAmbamGKVglGm9lE3haJGG/nsvl6tA8pP+biWkci8wKM+MkG/oYLjBEsUci/Dfh6DsUsc3cbin9mu/KCyBb/GNteleVTsc1jY7A9IWS9l1jGkPib60sr7FHUMAmsUujUgBip+cVmIj0FB4zOKHaG00rrnhAm25HIQZf7cqby1Dv422jIChOPfPrntMsX4kGhQebh9WwDpDFteK+kUqNTMKNIjpxpqvaAmrmup35uAooUBkvWgfPWIVVlSEQ8retVa9PlhVSUYV+Xu+3XB9mKubHv0rUJHycPuEvPFsZ2cnO07DPEPAzy6a6UJpH+fkL2arzKrblK+6lduxp3GCH8iuEsL5fFt9n6BIs32xQvQfTXVjdAJ5+Ep21APZLNvkRPijVaC/U9tbu/BtS8X9bjC/DCfDJPiMAV6M9xYcqCfi1ZJs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <602FA2E5CB648A449B3EBE19B3834B7E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02efdcd-5237-44a2-7739-08d82c81b6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 07:51:29.9417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKQjIAx91CVMjEgyKF1EbAypO0d2p/7M00cNh5zsnWtlAEi0N5QbBeegCuGPT7CLINDp0aAD5qGL+kSog+dx/LcyD+mbiWwPeLHueZIoZ4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDAzOjQ0ICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiAg
DQo+ID4gT24gV2VkLCAyMDIwLTA3LTE1IGF0IDAwOjUxICswMDAwLCBQZXRlciBDaGVuIHdyb3Rl
Og0KPiA+ID4gPiBUaGUgVG9yYWRleCBDb2xpYnJpIGlNWDZVTEwgYm9hcmQgaGFzIGEgc3BlY2lh
bCBVU0IgaGFyZHdhcmUNCj4gPiA+ID4gZGVzaWduLg0KPiA+ID4gPiBXaXRoIHJ1bnRpbWUtcG0g
ZW5hYmxlZCBVU0IgcmVzZXQgaXRzZWxmIGNvbnRpbnVvdXNseS4NCj4gPiA+ID4gRnVydGhlcm1v
cmUNCj4gPiA+ID4gdGhlIE9URyBwb3J0IGlzIGFsc28gbm90IGVudW1lcmF0aW5nIGRldmljZXMg
aWYgdGhlIENoaXBpZGVhIElQDQo+ID4gPiA+IGlzDQo+ID4gPiA+IGluIHJ1bnRpbWUgc2xlZXAg
bW9kZSBhbmQgYSBkZXZpY2Ugb3IgaG9zdCBnZXRzIHBsdWdnZWQgaW4uDQo+ID4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBIaSBQaGlsaXBwZSwNCj4gPiA+IA0KPiA+ID4gWW91IG1heSBkZXNjcmliZSB0
aGUgZGV0YWlsIHdoYXQncyB0aGUgc3BlY2lhbCBVU0IgaGFyZHdhcmUgZGVzaWduDQo+ID4gPiBm
b3INCj4gPiA+IHlvdXIgYm9hcmQsDQo+ID4gDQo+ID4gSWYgSSBvbmx5IGtuZXcgdGhlIHJvb3Qt
Y2F1c2Ugb2YgdGhhdCBwcm9ibGVtIC0gdW5mb3J0dW5hdGVseSBJDQo+ID4gZG9uJ3QuDQo+ID4g
VGhhdCdzIGFsc28gd2h5IEkgaGF2ZSBzdWNoIGEgaGFyZCB0aW1lIHRvIGRlc2NyaWJlIGl0Lg0K
PiA+IA0KPiA+ID4gYW5kIHdoeSBpdCBjYXVzZXMgdGhlIHByb2JsZW0sIGFuZCB3aHkgZGlzYWJs
ZSBydW50aW1lIHBtIGNvdWxkDQo+ID4gPiBmaXgNCj4gPiA+IHRoaXMgaXNzdWUsIHRoZW4sDQo+
ID4gDQo+ID4gSSBjYW5ub3QgcHJvdmlkZSB0aGUgJ3doeScgcGFydCB5ZXQuIEknbGwgdHJ5IHNv
bWV0aGluZyBtb3JlIGFuZA0KPiA+IGhvcGUgSSBjYW4gcHJvdmlkZQ0KPiA+IHlvdSBndXlzIHdp
dGggdGhlIGV4YWN0IGRlc2NyaXB0aW9uLg0KPiA+IA0KPiA+ID4gdGhlIG90aGVyIHVzZXJzIGNv
dWxkIGtub3cgaWYgaXQgY291bGQgYXBwbHkgdG8gdGhlaXIgcGxhdGZvcm1zIG9yDQo+ID4gPiBu
b3QNCj4gPiA+IGluIGZ1dHVyZS4NCj4gPiANCj4gPiBJIG9ubHkgZm91bmQgb3V0IGFib3V0IGl0
IGJlY2F1c2UgeW91IHdlcmUgcG9pbnRpbmcgbWUgaW4gdGhhdA0KPiA+IGRpcmVjdGlvbi4gSSBk
ZWJ1Z2dlZA0KPiA+IGZvciBob3VycyBub3cgYW5kIGRpZG4ndCBjYW1lIHRvIHRoZSByb290LWNh
dXNlIG9mIHRoZSBpc3N1ZS4gSQ0KPiA+IHRoaW5rIHRvIHJlYWxseQ0KPiA+IHVuZGVyc3RhbmQg
aXQgSSB3b3VsZCBuZWVkIHRvIGtub3cgbXVjaCBtb3JlIGFib3V0IHRoZSBDaGlwaWRlYSBJUC4N
Cj4gPiANCj4gPiBJJ2xsIGdldCBiYWNrIHRvIHlvdSBndXlzIHdpdGggYSBwcm9wb3NhbCBmb3Ig
YSBuZXcgZGVzY3JpcHRpb24uDQo+ID4gDQo+IA0KPiBQaGlsaXBwZSwgaXMgaXQgcG9zc2libGUg
dG8gc2hhcmUgeW91ciBVU0IgaGFyZHdhcmUgZGVzaWduIGF0IDZVTEw/DQoNCkl0J3MgYWN0dWFs
bHkgcHJldHR5IHNpbXBsZTogV2UgaGF2ZSBvbiBVU0JfT1RHMV9WQlVTIGEgMXVGIGNhcGFjaXRv
cg0KYW5kICszLjBWIG9uIFZERF9VU0JfQ0FQIHRvZ2V0aGVyIHdpdGggMTAwbiBhbmQgMTB1IGJ5
cGFzcyBjYXBzLiBOb3cgdGhlDQpiaWcgcHJvYmxlbSBpcyB0aGF0IHRoZSBkcml2ZXIgY2FuIG5v
dCBkZXRlY3QgdGhlIDVWIG9uIFZCVVMgc2lnbmFsLg0KDQpJIHRyaWVkIHRvICdpbmplY3QnIDVW
IHRvIHRoYXQgcGluIGxhc3Qgd2VlayBhbmQgdGhpbmdzIGdvdCByZWFsbHkNCmJldHRlciB3aXRo
IHJ1bnRpbWUtcG0uIEJ1dCBJIHN0aWxsIHRoaW5rcyBkaXNhYmxpbmcgaXQgZm9yIG91ciBib2Fy
ZA0Kd291bGQgbWFrZSBzZW5zZS4NCg0KSSdsbCBzZW5kIGEgbmV3IGRlc2NyaXB0aW9uIHRvZGF5
IHdoZXJlIEkgdHJ5IHRvIHBvaW50IHRvIFZCVVMgc2lnbmFsDQpub3QgY29ubmVjdGVkLg0KDQpQ
aGlsaXBwZQ0KDQo+IEFuZCBob3cgY2lfaGRyY19nYWRnZXRfY29ubmVjdCBpcyBjYWxsZWQgd2hl
biB0aGUgcnVudGltZSBwbSBpcw0KPiBkaXNhYmxlZD8NCj4gDQo+IFRoYW5rcywNCj4gUGV0ZXIN
Cj4gIA0K
