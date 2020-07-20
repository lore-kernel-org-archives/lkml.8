Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F0CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1077920702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G9Gz7b85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGTIG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:06:27 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:53216
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTIG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk5uqkE27ATbG91Q2EASEeV8PmX5RRuJPcjYke7RAqpDfPEp9v8fb4/Xe5dEnaw+fk+TmuCSIWRB1jCaZQqok2Yk8Eaf3iW0h6FtooY+yJlT/KyU7y4hb/EfWtv/qFs4ava/MJ5H9xvT8+4wOV2X0rF+rVEGcPOmQWlB4A/Zj/YnRT6xkUOWv9QaSdjqPpiLzFBLGVu2YYNaAYHmkTrDFmiHfjK8Z7dIiliE3RIYfYyYMmK+q1Lb40GRxDooL66gLU4jLZW/aAD38AktSYOYNjWMYNjELVSrotUpuOlgsKql23kHsaQlB2Q2pEghL6pKxzbzIvtMfaQyCNmz9Lnyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP4d0VpOex5Z6qYkvlIGx3wQBh3pbDR9g+3h5cbexyY=;
 b=BXhKrLv5vFt0lZDJqTq44FUVZylsA7NozsJzKf7U16tO8qRRsoUKzSa+fXgimQXw315vKUCxuDuMrhj9rsZQlWYID4zavBjo/xXa8QXsEgIxDLf25rDlZBNZJWjJrxpCI+124HKlszJsyRC7b+jzMsbdBmEBfzoYavilpZHn3pIquCiOs7sciHvhDYM5oeW0h5BndtalNqSO6Mj+CU4nXYagFB+EBeRdsecvo1KfMIAHD9jhheQJ5nvmEy24kS3YvEmd3s9LsEsKPE8voot2eQRFA9M1X0X5eQkDkn19BCmpfm92AzOlF24tVOERy0YAETr0L1PcKdYgcR/IBvIyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP4d0VpOex5Z6qYkvlIGx3wQBh3pbDR9g+3h5cbexyY=;
 b=G9Gz7b85qr9044NjR61uHwMon0Ke57e5J2bX4NQHQ26jmg/0SERRZ0lBFRvx6bQ5igJI9ktq4qiw+TCKHT/CuWsArpSpxTGtSNkfSjUM4jiNSDk5s+Bk35OOMmL2Lh4klEAXIbW9c/r/w8kIBtx8wDeUG9vMtdxRsdbWVb0dLEI=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4165.eurprd04.prod.outlook.com (2603:10a6:209:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:06:21 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:06:21 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Jun Li <jun.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIPNKRf0OmdJ0GCrPpelAWmTKkHzuSggAChQYCAB2sK0IAARhSAgAAC5LA=
Date:   Mon, 20 Jul 2020 08:06:21 +0000
Message-ID: <AM7PR04MB715721D95968DDB78B45A3AF8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
         <20200714151822.250783-2-philippe.schenker@toradex.com>
         <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
         <08251297f72fe745be43205d0a73631f009681cc.camel@toradex.com>
         <AM7PR04MB71572600CE73140FE13CB17C8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <163befb5f97724a1279a33023980da3264f0c00e.camel@toradex.com>
In-Reply-To: <163befb5f97724a1279a33023980da3264f0c00e.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc71eed7-245a-48ea-4e91-08d82c83ca05
x-ms-traffictypediagnostic: AM6PR04MB4165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4165548AE08370AF09D9E9B78B7B0@AM6PR04MB4165.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vtqnGpFnuTFnnLCcXEMD+TQGr3ROr92wcDa0WwYeHloR3j+A8K7CTrwyG72f5bpP9GYy65F6iWYi8KS+MyBcQ9FCKQuN9t/TjlYqr1hnOQwg0VYOwH2yhISWC3QNpg/hJ301c2flVLSrCbE8Afctb8/SZzdBTTsIN2r+jzcZoBFqI9DnVLC47EqQQLtBkGuf5VpLvEizEngrVPpzo2xSp47vPgbb8LQ/s+Ev6XwB2evGSlBR+IJVl1dNbMTSS6t6ZIe+DxuXCHTE0uMD00pZIKU0H0lTLZrvbGHSEKe/WfWlr2INjh3aD2OclNZx7BbvlK1AuQqkwjzSKGmYuK+mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(2906002)(7696005)(8936002)(64756008)(5660300002)(76116006)(66446008)(186003)(52536014)(66946007)(66556008)(66476007)(86362001)(71200400001)(9686003)(33656002)(44832011)(4326008)(54906003)(110136005)(6506007)(7416002)(26005)(478600001)(8676002)(83380400001)(316002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: td21z0aiHHczWatx9125/BjrjVBI3t05guDCH3iVcmhlw5Q5cXJgEYPd+agSI2PtYX4NwOo5K2sNXjebKvDrHGLBeK0nNlIOqC12flTcP7GJhpCDAQyeTU6vmNrekSwyOoJN2HXqkHIjJ+NgiPtck6x0N8MBuNIjKekiDwZFzc53yb0SjjYKvjcAsHyA7IRF5UabzHcNWHy0wDBjaP74InrqCndNQcheZYZWWhesAX3Ps5x4MOQCAT7SeuiNwsjLRVl1/BnL7aYubBIJhLikAeRrLjYUBcfZ1nPWC6ywThp7h40kxS42suPHUmcKD81QakO8kGPNoXNneHZOMogi6tYxmoKFNTNPs+o/fAT1bMmTUBXK7TFSka/SHeXJ1DznYb8/9yVxmusT4ShXOoGASuth2p98FWpd9X/HelpRtNwEP2OzBXQiY+kYmXQm8lZdnp7YcTwiHm4QeYy/vLCVXQhJLKDfI7sOwGnME/T6wxw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc71eed7-245a-48ea-4e91-08d82c83ca05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:06:21.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PeAEyRF/yqqYYBYaZJTJAmvQ0AeM0gamU/sNDliwWUwciWm9l+GRDudtc1FrBWMKE0VEciSGtuL1JxXr/orlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiBNb24sIDIwMjAtMDctMjAgYXQgMDM6NDQgKzAwMDAsIFBldGVyIENoZW4gd3JvdGU6
DQo+ID4NCj4gPiA+IE9uIFdlZCwgMjAyMC0wNy0xNSBhdCAwMDo1MSArMDAwMCwgUGV0ZXIgQ2hl
biB3cm90ZToNCj4gPiA+ID4gPiBUaGUgVG9yYWRleCBDb2xpYnJpIGlNWDZVTEwgYm9hcmQgaGFz
IGEgc3BlY2lhbCBVU0IgaGFyZHdhcmUNCj4gPiA+ID4gPiBkZXNpZ24uDQo+ID4gPiA+ID4gV2l0
aCBydW50aW1lLXBtIGVuYWJsZWQgVVNCIHJlc2V0IGl0c2VsZiBjb250aW51b3VzbHkuDQo+ID4g
PiA+ID4gRnVydGhlcm1vcmUNCj4gPiA+ID4gPiB0aGUgT1RHIHBvcnQgaXMgYWxzbyBub3QgZW51
bWVyYXRpbmcgZGV2aWNlcyBpZiB0aGUgQ2hpcGlkZWEgSVANCj4gPiA+ID4gPiBpcyBpbiBydW50
aW1lIHNsZWVwIG1vZGUgYW5kIGEgZGV2aWNlIG9yIGhvc3QgZ2V0cyBwbHVnZ2VkIGluLg0KPiA+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhpIFBoaWxpcHBlLA0KPiA+ID4gPg0KPiA+ID4gPiBZ
b3UgbWF5IGRlc2NyaWJlIHRoZSBkZXRhaWwgd2hhdCdzIHRoZSBzcGVjaWFsIFVTQiBoYXJkd2Fy
ZSBkZXNpZ24NCj4gPiA+ID4gZm9yIHlvdXIgYm9hcmQsDQo+ID4gPg0KPiA+ID4gSWYgSSBvbmx5
IGtuZXcgdGhlIHJvb3QtY2F1c2Ugb2YgdGhhdCBwcm9ibGVtIC0gdW5mb3J0dW5hdGVseSBJDQo+
ID4gPiBkb24ndC4NCj4gPiA+IFRoYXQncyBhbHNvIHdoeSBJIGhhdmUgc3VjaCBhIGhhcmQgdGlt
ZSB0byBkZXNjcmliZSBpdC4NCj4gPiA+DQo+ID4gPiA+IGFuZCB3aHkgaXQgY2F1c2VzIHRoZSBw
cm9ibGVtLCBhbmQgd2h5IGRpc2FibGUgcnVudGltZSBwbSBjb3VsZA0KPiA+ID4gPiBmaXggdGhp
cyBpc3N1ZSwgdGhlbiwNCj4gPiA+DQo+ID4gPiBJIGNhbm5vdCBwcm92aWRlIHRoZSAnd2h5JyBw
YXJ0IHlldC4gSSdsbCB0cnkgc29tZXRoaW5nIG1vcmUgYW5kDQo+ID4gPiBob3BlIEkgY2FuIHBy
b3ZpZGUgeW91IGd1eXMgd2l0aCB0aGUgZXhhY3QgZGVzY3JpcHRpb24uDQo+ID4gPg0KPiA+ID4g
PiB0aGUgb3RoZXIgdXNlcnMgY291bGQga25vdyBpZiBpdCBjb3VsZCBhcHBseSB0byB0aGVpciBw
bGF0Zm9ybXMgb3INCj4gPiA+ID4gbm90IGluIGZ1dHVyZS4NCj4gPiA+DQo+ID4gPiBJIG9ubHkg
Zm91bmQgb3V0IGFib3V0IGl0IGJlY2F1c2UgeW91IHdlcmUgcG9pbnRpbmcgbWUgaW4gdGhhdA0K
PiA+ID4gZGlyZWN0aW9uLiBJIGRlYnVnZ2VkIGZvciBob3VycyBub3cgYW5kIGRpZG4ndCBjYW1l
IHRvIHRoZQ0KPiA+ID4gcm9vdC1jYXVzZSBvZiB0aGUgaXNzdWUuIEkgdGhpbmsgdG8gcmVhbGx5
IHVuZGVyc3RhbmQgaXQgSSB3b3VsZA0KPiA+ID4gbmVlZCB0byBrbm93IG11Y2ggbW9yZSBhYm91
dCB0aGUgQ2hpcGlkZWEgSVAuDQo+ID4gPg0KPiA+ID4gSSdsbCBnZXQgYmFjayB0byB5b3UgZ3V5
cyB3aXRoIGEgcHJvcG9zYWwgZm9yIGEgbmV3IGRlc2NyaXB0aW9uLg0KPiA+ID4NCj4gPg0KPiA+
IFBoaWxpcHBlLCBpcyBpdCBwb3NzaWJsZSB0byBzaGFyZSB5b3VyIFVTQiBoYXJkd2FyZSBkZXNp
Z24gYXQgNlVMTD8NCj4gDQo+IEl0J3MgYWN0dWFsbHkgcHJldHR5IHNpbXBsZTogV2UgaGF2ZSBv
biBVU0JfT1RHMV9WQlVTIGEgMXVGIGNhcGFjaXRvciBhbmQNCj4gKzMuMFYgb24gVkREX1VTQl9D
QVAgdG9nZXRoZXIgd2l0aCAxMDBuIGFuZCAxMHUgYnlwYXNzIGNhcHMuIE5vdyB0aGUgYmlnDQo+
IHByb2JsZW0gaXMgdGhhdCB0aGUgZHJpdmVyIGNhbiBub3QgZGV0ZWN0IHRoZSA1ViBvbiBWQlVT
IHNpZ25hbC4NCj4gDQoNCkNvdWxkIHlvdSBjb25maXJtIGl0IGRvZXMgbm90IHNlZSBWQlVTIGF0
IHJlZ2lzdGVyIE9UR1NDPyBJZiBpdCBpcywgaG93IGNhbiBpdCB3b3JrIHdpdGggcnVudGltZQ0K
ZGlzYWJsZWQsIHRoZSBVU0JDTUQuUlMgc2V0dGluZyAoY2lfaGRyY19nYWRnZXRfY29ubmVjdCBp
cyBjYWxsZWQpIGRlcGVuZHMgb24gVkJVUy4NCg0KUGV0ZXINCg0KPiBJIHRyaWVkIHRvICdpbmpl
Y3QnIDVWIHRvIHRoYXQgcGluIGxhc3Qgd2VlayBhbmQgdGhpbmdzIGdvdCByZWFsbHkgYmV0dGVy
IHdpdGggcnVudGltZS1wbS4NCj4gQnV0IEkgc3RpbGwgdGhpbmtzIGRpc2FibGluZyBpdCBmb3Ig
b3VyIGJvYXJkIHdvdWxkIG1ha2Ugc2Vuc2UuDQo+IA0KPiBJJ2xsIHNlbmQgYSBuZXcgZGVzY3Jp
cHRpb24gdG9kYXkgd2hlcmUgSSB0cnkgdG8gcG9pbnQgdG8gVkJVUyBzaWduYWwgbm90IGNvbm5l
Y3RlZC4NCj4gDQo+IFBoaWxpcHBlDQo+IA0KPiA+IEFuZCBob3cgY2lfaGRyY19nYWRnZXRfY29u
bmVjdCBpcyBjYWxsZWQgd2hlbiB0aGUgcnVudGltZSBwbSBpcw0KPiA+IGRpc2FibGVkPw0KPiA+
DQo+ID4gVGhhbmtzLA0KPiA+IFBldGVyDQo+ID4NCg==
