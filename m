Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F4C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDEA2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="mS9jTq+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGTKLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:11:06 -0400
Received: from mail-eopbgr130120.outbound.protection.outlook.com ([40.107.13.120]:52100
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728155AbgGTKLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SizEBc3wDcfSrryMsxKhTuXpXBK7qGZUqdruJ08US3e8IMdN+IFxdf1Wo71qsqSH58QePRVitUsBnex4fQ4lZGFol6ny95BnyvZlN5nHHZDbCduXLp+vo4w2lsq1AOFWRfNUpGjDvhlRw0J9nLvdmzrH4jdFhyc36NUSRZiujjU2TKZ1yepgPWv9VCMU5YH1Eaw5n3nvNxxTtdkqWMnqe7s2ZO8arpueKWwcmW9zxIJ0yjJWRadMQ7jtU/GxChuzLeY5W31PI0a7/1CFOif+hNODODokTpTzTM+mnHcs9uUuCN9hosC1a4+IKUnfLr3iOsePQc8Btr8USXE4AbBa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou4p4h/zi2ZzT6xxfRYsyAy8ouBhIOYnsI/tgSEpr3A=;
 b=cy7mEfa5FiUXVparnJmpw2VufSOmfY1Z2C3lOrTJnEKfohEwKcijslyOtY3J++6CXMDSdge5SV0sfHe1K26U1f+XgOGLXK0nN0xPLDOVcR7nHWon8CMoeX6qY2g4Nwb3nVG94cBNi4ig+MxgkWFsBh6aedtWyF6K+QBdqS2h+BxrfOcExmgYXJbPP803p6q8pWcKrWH8GVyji+xAZbzAj9iJonMx3h1VbGYMyLK1oaJmdAYkWYZeLRkoalHozY2FAA0NlJFOM29LDS/RkRA3t+9+/AsY2rPBL7jdslTeKxNnvPCx08mKlzeq8CR2V7UtUyC6DOK5jBrg/gI7PqKxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou4p4h/zi2ZzT6xxfRYsyAy8ouBhIOYnsI/tgSEpr3A=;
 b=mS9jTq+6atPlggd3cyxG45n83BOBGuOMNJGhHfkbmrQwjE7QhGjdl4pqLS2n2KyMcKAaKEZNaCrVSlYN3cHxLBlGSMJITycfwkO2IxrjMQaazeh1L+y7+AGzl6N0vGkEiudUyh7ByPQFR9oxLgfMCTWwdgspz932jenKVl7b4so=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5173.eurprd05.prod.outlook.com (2603:10a6:20b:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 10:10:58 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 10:10:58 +0000
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
Thread-Index: AQHWWfIMLexdmM4+M0C6zPGY8HP2U6kH0FqAgACfygCAB2wiAIAARP2AgAAEJ4CAACLRAA==
Date:   Mon, 20 Jul 2020 10:10:58 +0000
Message-ID: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
         <20200714151822.250783-2-philippe.schenker@toradex.com>
         <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
         <08251297f72fe745be43205d0a73631f009681cc.camel@toradex.com>
         <AM7PR04MB71572600CE73140FE13CB17C8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
         <163befb5f97724a1279a33023980da3264f0c00e.camel@toradex.com>
         <AM7PR04MB715721D95968DDB78B45A3AF8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB715721D95968DDB78B45A3AF8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b1e93a-0cb9-416f-e70a-08d82c9532e3
x-ms-traffictypediagnostic: AM6PR05MB5173:
x-microsoft-antispam-prvs: <AM6PR05MB51735D8388F0ED610D2A6D22F47B0@AM6PR05MB5173.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8cqjNHXrQswZCVvE9qOJcaQgdnVpcYEar2ApkejxtbMqeU8lGBUsFYFKQKG72y7e2/yt8jG6aFIZc0690BwjghB1DckhcgOrBfbzN0xB+4DdQQWm/I/YRFuxOHNL6Zi+WL4+3DonGpbxcuh9YhwfgodHbWKdyyeX1ySk1HHc70nh1K37ukKVzx4WPJzIr0XYMfLY6ajgcrLzq8U2lz/OdnyJgYfQ2MrDQvc0nzz9P6QgNzyuvXvHmdIxq6LOePKSCXz8rGPBSE/wiqJ3CtoE9BmwuTwYjiJ/h6nGve9rgqpCQtp56pwuciAsS40jomsDulrRLL6R03THgUL/PLw5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(366004)(346002)(376002)(136003)(36756003)(316002)(91956017)(6512007)(8676002)(66946007)(64756008)(66446008)(66476007)(66556008)(2906002)(76116006)(71200400001)(8936002)(7416002)(86362001)(83380400001)(5660300002)(26005)(186003)(2616005)(6506007)(4326008)(6486002)(478600001)(110136005)(44832011)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VJaVjDel6cdCUUjW9/N84jk3CuJ06jBYQsFNl7ACwwSDrzT+v73yAmTMm48Eupyf9rOhBA68gYSG3FTt1Mo+WJiS9/BKGOE+0HG1NW35nlhLSFQbozFOsnkAgw4ebgPQ9anb9fwPIlqINPX0YySJmXaMEu44Y9Bb/PxaChQILTvl5d8yZgh+3t2sxevfsC0fYxNPUbCGr/sE5ZHha2ksQ18mnYqGcCqIL8MW1ASo1IIebzNcVsHk5tiEjSImUGidIScav/e9v7J2le0SHzod2YwbWENKoXjMKRv7FsZQoA0QvXCEvbJozv+lx8qRUgq0O59nlVB7FTdjBt3UyfMgrDqUiEPAQgVwWq+Cw+ifWOh1IRGx9hDMHIJYuF2bdAPf8o2kjGdrxVk0sdY58Ykg4gpD8GZi1717/NwHS0AQqPilSTv8HyAriWJii/u8UEAcVmHwxNYohKMEGUoONlUmw5Wx7/IO96S+zHiArMz6NWk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FA3308FC877D44581D78F1360C1BF12@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b1e93a-0cb9-416f-e70a-08d82c9532e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:10:58.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmarczWNfQy087IbXKfhMuKNlmjjIDnHEHHzAfuUxdV+qPRv1yrxguEQ5Ysyt5gOL72/4Vrd20M6Xtv6gsP1B11LraUgVFORxv/EtenRevQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDA4OjA2ICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiAg
DQo+ID4gT24gTW9uLCAyMDIwLTA3LTIwIGF0IDAzOjQ0ICswMDAwLCBQZXRlciBDaGVuIHdyb3Rl
Og0KPiA+ID4gPiBPbiBXZWQsIDIwMjAtMDctMTUgYXQgMDA6NTEgKzAwMDAsIFBldGVyIENoZW4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBUaGUgVG9yYWRleCBDb2xpYnJpIGlNWDZVTEwgYm9hcmQgaGFz
IGEgc3BlY2lhbCBVU0IgaGFyZHdhcmUNCj4gPiA+ID4gPiA+IGRlc2lnbi4NCj4gPiA+ID4gPiA+
IFdpdGggcnVudGltZS1wbSBlbmFibGVkIFVTQiByZXNldCBpdHNlbGYgY29udGludW91c2x5Lg0K
PiA+ID4gPiA+ID4gRnVydGhlcm1vcmUNCj4gPiA+ID4gPiA+IHRoZSBPVEcgcG9ydCBpcyBhbHNv
IG5vdCBlbnVtZXJhdGluZyBkZXZpY2VzIGlmIHRoZSBDaGlwaWRlYQ0KPiA+ID4gPiA+ID4gSVAN
Cj4gPiA+ID4gPiA+IGlzIGluIHJ1bnRpbWUgc2xlZXAgbW9kZSBhbmQgYSBkZXZpY2Ugb3IgaG9z
dCBnZXRzIHBsdWdnZWQNCj4gPiA+ID4gPiA+IGluLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSGkgUGhpbGlwcGUsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gWW91IG1heSBk
ZXNjcmliZSB0aGUgZGV0YWlsIHdoYXQncyB0aGUgc3BlY2lhbCBVU0IgaGFyZHdhcmUNCj4gPiA+
ID4gPiBkZXNpZ24NCj4gPiA+ID4gPiBmb3IgeW91ciBib2FyZCwNCj4gPiA+ID4gDQo+ID4gPiA+
IElmIEkgb25seSBrbmV3IHRoZSByb290LWNhdXNlIG9mIHRoYXQgcHJvYmxlbSAtIHVuZm9ydHVu
YXRlbHkgSQ0KPiA+ID4gPiBkb24ndC4NCj4gPiA+ID4gVGhhdCdzIGFsc28gd2h5IEkgaGF2ZSBz
dWNoIGEgaGFyZCB0aW1lIHRvIGRlc2NyaWJlIGl0Lg0KPiA+ID4gPiANCj4gPiA+ID4gPiBhbmQg
d2h5IGl0IGNhdXNlcyB0aGUgcHJvYmxlbSwgYW5kIHdoeSBkaXNhYmxlIHJ1bnRpbWUgcG0NCj4g
PiA+ID4gPiBjb3VsZA0KPiA+ID4gPiA+IGZpeCB0aGlzIGlzc3VlLCB0aGVuLA0KPiA+ID4gPiAN
Cj4gPiA+ID4gSSBjYW5ub3QgcHJvdmlkZSB0aGUgJ3doeScgcGFydCB5ZXQuIEknbGwgdHJ5IHNv
bWV0aGluZyBtb3JlIGFuZA0KPiA+ID4gPiBob3BlIEkgY2FuIHByb3ZpZGUgeW91IGd1eXMgd2l0
aCB0aGUgZXhhY3QgZGVzY3JpcHRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiA+IHRoZSBvdGhlciB1
c2VycyBjb3VsZCBrbm93IGlmIGl0IGNvdWxkIGFwcGx5IHRvIHRoZWlyDQo+ID4gPiA+ID4gcGxh
dGZvcm1zIG9yDQo+ID4gPiA+ID4gbm90IGluIGZ1dHVyZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkg
b25seSBmb3VuZCBvdXQgYWJvdXQgaXQgYmVjYXVzZSB5b3Ugd2VyZSBwb2ludGluZyBtZSBpbiB0
aGF0DQo+ID4gPiA+IGRpcmVjdGlvbi4gSSBkZWJ1Z2dlZCBmb3IgaG91cnMgbm93IGFuZCBkaWRu
J3QgY2FtZSB0byB0aGUNCj4gPiA+ID4gcm9vdC1jYXVzZSBvZiB0aGUgaXNzdWUuIEkgdGhpbmsg
dG8gcmVhbGx5IHVuZGVyc3RhbmQgaXQgSSB3b3VsZA0KPiA+ID4gPiBuZWVkIHRvIGtub3cgbXVj
aCBtb3JlIGFib3V0IHRoZSBDaGlwaWRlYSBJUC4NCj4gPiA+ID4gDQo+ID4gPiA+IEknbGwgZ2V0
IGJhY2sgdG8geW91IGd1eXMgd2l0aCBhIHByb3Bvc2FsIGZvciBhIG5ldyBkZXNjcmlwdGlvbi4N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFBoaWxpcHBlLCBpcyBpdCBwb3NzaWJsZSB0byBzaGFy
ZSB5b3VyIFVTQiBoYXJkd2FyZSBkZXNpZ24gYXQNCj4gPiA+IDZVTEw/DQo+ID4gDQo+ID4gSXQn
cyBhY3R1YWxseSBwcmV0dHkgc2ltcGxlOiBXZSBoYXZlIG9uIFVTQl9PVEcxX1ZCVVMgYSAxdUYN
Cj4gPiBjYXBhY2l0b3IgYW5kDQo+ID4gKzMuMFYgb24gVkREX1VTQl9DQVAgdG9nZXRoZXIgd2l0
aCAxMDBuIGFuZCAxMHUgYnlwYXNzIGNhcHMuIE5vdyB0aGUNCj4gPiBiaWcNCj4gPiBwcm9ibGVt
IGlzIHRoYXQgdGhlIGRyaXZlciBjYW4gbm90IGRldGVjdCB0aGUgNVYgb24gVkJVUyBzaWduYWwu
DQo+ID4gDQo+IA0KPiBDb3VsZCB5b3UgY29uZmlybSBpdCBkb2VzIG5vdCBzZWUgVkJVUyBhdCBy
ZWdpc3RlciBPVEdTQz8gSWYgaXQgaXMsDQo+IGhvdyBjYW4gaXQgd29yayB3aXRoIHJ1bnRpbWUN
Cj4gZGlzYWJsZWQsIHRoZSBVU0JDTUQuUlMgc2V0dGluZyAoY2lfaGRyY19nYWRnZXRfY29ubmVj
dCBpcyBjYWxsZWQpDQo+IGRlcGVuZHMgb24gVkJVUy4NCj4gDQo+IFBldGVyDQoNCkZvciB0aGlz
IHJlYXNvbiBJJ20gdXNpbmcgYSB3b3JrYXJvdW5kIGluIGV4dGNvbiBsaWtlIHRoaXM6DQoNCmV4
dGNvbiA9IDwmZXh0Y29uX3VzYmNfZGV0PiwgPCZleHRjb25fdXNiY19kZXQ+Ow0KDQpJIGtub3cg
dGhhdCB0aGlzIGlzIHVuZG9jdW1lbnRlZCBhbmQgd3JvbmcsIGJ1dCBpdCB3b3JrcyBmb3Igb3Vy
DQpoYXJkd2FyZS4gV2l0aCB0aGlzIGFuZCBlbmFibGVkIHJ1bnRpbWUtcG0gZGV2aWNlcyBkbyBu
b3QgZ2V0DQplbnVtZXJhdGVkLg0KDQpCdXQgd2l0aCBydW50aW1lLXBtIGRpc2FibGVkLCBkZXZp
Y2VzIGdldCBlbnVtZXJhdGVkLg0KDQpGdXJ0aGVyIHdpdGggdGhpcyB3b3JrYXJvdW5kIHRoZSBW
QlVTIHNpZ25hbCBnZXRzICdzaW11bGF0ZWQnDQppbiBod19yZWFkX290Z3NjLg0KDQpBbm90aGVy
IHByb2JsZW0gd2l0aCBydW50aW1lLXBtIGVuYWJsZWQgaXMgdGhhdCB3aXRoIG5vIGRldmljZXMg
cGx1Z2dlZA0KaW50byBVU0IgaXQgcmVzZXRzIGl0c2VsZiBldmVyeSB+MSBzZWNvbmQuDQoNClBo
aWxpcHBlLg0KPiANCj4gPiBJIHRyaWVkIHRvICdpbmplY3QnIDVWIHRvIHRoYXQgcGluIGxhc3Qg
d2VlayBhbmQgdGhpbmdzIGdvdCByZWFsbHkNCj4gPiBiZXR0ZXIgd2l0aCBydW50aW1lLXBtLg0K
PiA+IEJ1dCBJIHN0aWxsIHRoaW5rcyBkaXNhYmxpbmcgaXQgZm9yIG91ciBib2FyZCB3b3VsZCBt
YWtlIHNlbnNlLg0KPiA+IA0KPiA+IEknbGwgc2VuZCBhIG5ldyBkZXNjcmlwdGlvbiB0b2RheSB3
aGVyZSBJIHRyeSB0byBwb2ludCB0byBWQlVTDQo+ID4gc2lnbmFsIG5vdCBjb25uZWN0ZWQuDQo+
ID4gDQo+ID4gUGhpbGlwcGUNCj4gPiANCj4gPiA+IEFuZCBob3cgY2lfaGRyY19nYWRnZXRfY29u
bmVjdCBpcyBjYWxsZWQgd2hlbiB0aGUgcnVudGltZSBwbSBpcw0KPiA+ID4gZGlzYWJsZWQ/DQo+
ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IFBldGVyDQo+ID4gPiANCg==
