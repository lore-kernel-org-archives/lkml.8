Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2633C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98738207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G33oEG8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgERJ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:59:04 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:61195
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgERJ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp+vxEhs3TF5E9NdOgXErr8ZI7KzI7Eltb4fNdzbfMav71SNyq/hzdX2Glhn7cRk4/GyqPX+PWtaURfFk4h0IYl0mdcm9PhaN0Cm7Gcz5JgEWvT8T10YKhKrp1J62Z9hSZpds+omNKzHoqjxfHipj57TFEfroA6LNd0JTk6inxDuFPVH0SP38ZuTcXwCHA690irH3xjNbZDSeRHHHxzyg3xTx/OlEFr8eQN4iGnbgyDHYprWHpJQwGLXQ8L7ddWPMFwT44rizPGKAQcYYTdEPQVS9rMNmOjSzrEBd3DHTy0AYm2u7Zx07dASJbfJ7wH0hmoIQCt+V2HXPLtOkq3nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzkSqmCfl3gsfOqRJDHsoaKWKJPRsKHfDgaS37cMMA4=;
 b=E8lXU0awceJEN+KWZyveit7+UmREFsP2cLojXm007fLc5hNi8EzTFk3cS4eu3XjFJgR7O5VJaOWP2ye0YAKyehM5a6oxZpHI3nAQi8bOos6BqKG66N33a6qzkcd8phNAMdyqeSUp4T68WRw5keY+JsDENHocMM+uxM58WjEg8sr87LtxHzhLZVZR6OY6j+Gw1blY7ZLhjCvFIYae3g8yf7/8fVkTyShnmJu7ZZNrhMNkQ4IdH3TTyGC4CiogikJOwUgCxSEq6W2zp6YKvQEe45aXUjnucnugkJpQlq2rN3ZLv5lD3bZGdK6Em8o4dP6iHhymyNuSfovICs/D+iBDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzkSqmCfl3gsfOqRJDHsoaKWKJPRsKHfDgaS37cMMA4=;
 b=G33oEG8UvLe4yIvewwViGgm7NqaCIoPaRYHicUAbauIlwLiLilP4zxiOAELnmNlPLDQcKAsMDirV8ung3tcUrXLujJelx2PcJkIBWB37ncNUSypxaf4WS2D5Pyybh4JqS4pK02vzJsogbLTstTVy9zkjfYo960b6Z0UvfI6KIAQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3945.eurprd04.prod.outlook.com (2603:10a6:8:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 09:58:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:58:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: reset: Convert i.MX reset to json-schema
Thread-Topic: [PATCH] dt-bindings: reset: Convert i.MX reset to json-schema
Thread-Index: AQHWKAWfz/hL/av3lkeqLSh6w78ioaitoQOAgAAEbYA=
Date:   Mon, 18 May 2020 09:58:57 +0000
Message-ID: <DB3PR0402MB3916154554C6AB2C6BBEDE1DF5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589250194-29441-1-git-send-email-Anson.Huang@nxp.com>
 <719ed778a36e7edfea080d42e9b837432e595d15.camel@pengutronix.de>
In-Reply-To: <719ed778a36e7edfea080d42e9b837432e595d15.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0b58638-d1a6-4477-b0e5-08d7fb121534
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3945B5450F5D4E09D94D9674F5B80@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfHXL3fQBkgp2bJOQaBFgyP+v6eyKTffxbJJRLai6RZP3RSvOyEnfNzo6I8uCBeOlqDjG69ml5eBNTav40yXF/tDtvhvCscT8nMzt5IJezT20hfSGyMpzuMH236sY7n7Pa8JSfKmEgGsbmTA+wL0iK45iigAHOnai8z5zpO6KVe1PwaJqgw6i9HKq9KfYOFelv4S9xx3irG/Nd3V2pfQjLpkX2rbySby0zAolhj8+eLi35Uvoyy/kq8/TyodrhnGTf9/lU2ybvJ8VJdY7YG6+gNUgRkvwE3LB3OkQ3l9KoNg83umi24FCEe7KCb6o0Fo3e+2DrQj78UB0I6tj+NV04oujIeIkXAyNDecTLDO9N/0nW1odVab2Lz7Hk9Asefss4cnP8bbNjqcXeMgb3BFudszM2pTb3h1AAPKTSsJf3mD/0SpH/tsIvGhj9pafTbhGnQhBGRZY/NODaj41EgU5FiVLMhjCnd1jDgVCUW1K0FD2vnTRJobjPbfBPV+QsHx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(26005)(5660300002)(71200400001)(186003)(2906002)(7696005)(8936002)(55016002)(44832011)(66946007)(76116006)(66556008)(66476007)(33656002)(86362001)(83080400001)(52536014)(66446008)(110136005)(316002)(478600001)(4326008)(6506007)(9686003)(45080400002)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e12wAll5lyTHMbCxZiF27lzk0u2J7e5m4GcZE5QE/PtwF/gSBjICTTNmmq16dvI7Xd4Te7NYLKhKuhvcbLkv2QPNervPvYtt5O35kN48AzwkY+SzdMlB5eN6W31G04W3+K/hK4bEqyjSWnfk4L72vu5VdJ2nxkZSqyt2gAzK+qjChinMBZB/KB2SL9owNsFK/40JM8Gary2RihgJr/lWZQoHQ85/Rk0XVCQzj7qykxvNL33I3rluegjCx60Bkk4BF8537ZudAHwZIF3dIngC2K7NRwURtuJMkHTX1rczXmp7aVY4P8qJ0fLc4IOTa8Rh4vKs0Xpfn6COogcF+ag3usu4MkqPPOYL5s648SNItsK5RsywNIN8JOHwZ0f96ld43iF6XFLvtxwAUX7ifdeCO28+3/3i64M/n5fireuloy7zKrEAweASlamfUIaMR45OdD74XbhZek41ul33gTYC59y+zBZcFFCbqqCtYWAeIOQznx1Yz2DvTiMERJdvhBbU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b58638-d1a6-4477-b0e5-08d7fb121534
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 09:58:57.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMAWE+tfhRA5UieTaTDbvlLvFlTLSILsiZLV6Ev5XpYodUtIU/SUEB8Bj7Os2ocPr7aHlTcVe6Kli4wbq3pDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogcmVzZXQ6
IENvbnZlcnQgaS5NWCByZXNldCB0byBqc29uLXNjaGVtYQ0KPiANCj4gSGkgQW5zb24sDQo+IA0K
PiBPbiBUdWUsIDIwMjAtMDUtMTIgYXQgMTA6MjMgKzA4MDAsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IENvbnZlcnQgdGhlIGkuTVggcmVzZXQgYmluZGluZyB0byBEVCBzY2hlbWEgZm9ybWF0IHVz
aW5nIGpzb24tc2NoZW1hLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiB0aGFuayB5b3UgZm9yIHRoZSBjb252ZXJzaW9uLg0K
PiANCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1z
cmMudHh0ICAgICAgfCA0OSAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMueWFtbCAgICAgfCA1OA0KPiArKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNDkgZGVs
ZXRpb25zKC0pICBkZWxldGUgbW9kZQ0KPiA+IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMudHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNy
Yy55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4dA0KPiA+IGRlbGV0ZWQgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4IDZlZDc5ZTYuLjAwMDAwMDANCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMudHh0DQo+ID4gKysrIC9k
ZXYvbnVsbA0KPiA+IEBAIC0xLDQ5ICswLDAgQEANCj4gPiAtRnJlZXNjYWxlIGkuTVggU3lzdGVt
IFJlc2V0IENvbnRyb2xsZXINCj4gPiAtPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiAtDQo+ID4gLVBsZWFzZSBhbHNvIHJlZmVyIHRvIHJlc2V0LnR4dCBpbiB0aGlz
IGRpcmVjdG9yeSBmb3IgY29tbW9uIHJlc2V0DQo+ID4gLWNvbnRyb2xsZXIgYmluZGluZyB1c2Fn
ZS4NCj4gPiAtDQo+ID4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gLS0gY29tcGF0aWJsZTog
U2hvdWxkIGJlICJmc2wsPGNoaXA+LXNyYyINCj4gPiAtLSByZWc6IHNob3VsZCBiZSByZWdpc3Rl
ciBiYXNlIGFuZCBsZW5ndGggYXMgZG9jdW1lbnRlZCBpbiB0aGUNCj4gPiAtICBkYXRhc2hlZXQN
Cj4gPiAtLSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiBTUkMgaW50ZXJydXB0IGFuZCBDUFUg
V0RPRyBpbnRlcnJ1cHQsDQo+ID4gLSAgaW4gdGhpcyBvcmRlci4NCj4gPiAtLSAjcmVzZXQtY2Vs
bHM6IDEsIHNlZSBiZWxvdw0KPiA+IC0NCj4gPiAtZXhhbXBsZToNCj4gPiAtDQo+ID4gLXNyYzog
c3JjQDIwZDgwMDAgew0KPiA+IC0gICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDZxLXNyYyI7
DQo+ID4gLSAgICAgICAgcmVnID0gPDB4MDIwZDgwMDAgMHg0MDAwPjsNCj4gPiAtICAgICAgICBp
bnRlcnJ1cHRzID0gPDAgOTEgMHgwNCAwIDk2IDB4MDQ+Ow0KPiA+IC0gICAgICAgICNyZXNldC1j
ZWxscyA9IDwxPjsNCj4gPiAtfTsNCj4gPiAtDQo+ID4gLVNwZWNpZnlpbmcgcmVzZXQgbGluZXMg
Y29ubmVjdGVkIHRvIElQIG1vZHVsZXMNCj4gPiAtPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiA+IC0NCj4gPiAtVGhlIHN5c3RlbSByZXNldCBjb250cm9s
bGVyIGNhbiBiZSB1c2VkIHRvIHJlc2V0IHRoZSBHUFUsIFZQVSwgLUlQVSwNCj4gPiBhbmQgT3Bl
blZHIElQIG1vZHVsZXMgb24gaS5NWDUgYW5kIGkuTVg2IElDcy4gVGhvc2UgZGV2aWNlIC1ub2Rl
cw0KPiA+IHNob3VsZCBzcGVjaWZ5IHRoZSByZXNldCBsaW5lIG9uIHRoZSBTUkMgaW4gdGhlaXIg
cmVzZXRzIC1wcm9wZXJ0eSwNCj4gPiBjb250YWluaW5nIGEgcGhhbmRsZSB0byB0aGUgU1JDIGRl
dmljZSBub2RlIGFuZCBhIC1SRVNFVF9JTkRFWA0KPiA+IHNwZWNpZnlpbmcgd2hpY2ggbW9kdWxl
IHRvIHJlc2V0LCBhcyBkZXNjcmliZWQgaW4gLXJlc2V0LnR4dA0KPiA+IC0NCj4gPiAtZXhhbXBs
ZToNCj4gPiAtDQo+ID4gLSAgICAgICAgaXB1MTogaXB1QDI0MDAwMDAgew0KPiA+IC0gICAgICAg
ICAgICAgICAgcmVzZXRzID0gPCZzcmMgMj47DQo+ID4gLSAgICAgICAgfTsNCj4gPiAtICAgICAg
ICBpcHUyOiBpcHVAMjgwMDAwMCB7DQo+ID4gLSAgICAgICAgICAgICAgICByZXNldHMgPSA8JnNy
YyA0PjsNCj4gPiAtICAgICAgICB9Ow0KPiA+IC0NCj4gPiAtVGhlIGZvbGxvd2luZyBSRVNFVF9J
TkRFWCB2YWx1ZXMgYXJlIHZhbGlkIGZvciBpLk1YNToNCj4gPiAtR1BVX1JFU0VUICAgICAwDQo+
ID4gLVZQVV9SRVNFVCAgICAgMQ0KPiA+IC1JUFUxX1JFU0VUICAgIDINCj4gPiAtT1BFTl9WR19S
RVNFVCAzDQo+ID4gLVRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBSRVNFVF9JTkRFWCB2YWx1ZSBp
cyB2YWxpZCBmb3IgaS5NWDY6DQo+ID4gLUlQVTJfUkVTRVQgICAgNA0KPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgt
c3JjLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjI3
NmE1MzMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnlhbWwNCj4gPiBAQCAtMCwwICsxLDU4IEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiAraHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZp
DQo+ID4NCj4gK2NldHJlZS5vcmclMkZzY2hlbWFzJTJGcmVzZXQlMkZmc2wlMkNpbXgtc3JjLnlh
bWwlMjMmYW1wO2RhdGE9MDIlDQo+IDdDMDENCj4gPg0KPiArJTdDYW5zb24uaHVhbmclNDBueHAu
Y29tJTdDZDYyMmYzYjMxY2NhNGIyZTdiNDgwOGQ3ZmIwZmFlOTklN0MNCj4gNjg2ZWExZA0KPiA+
DQo+ICszYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyNTM5MTcwODI3Njc0
MTYmYW1wO3MNCj4gZGF0YT03ZSUyDQo+ID4NCj4gK0ZBeTNkejRnb1hXNnJOSDJ0QWwzejVvTlEl
MkZJWjZOeWtuNHVCWjdTMjAlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiArJHNjaGVtYToNCj4gPiAr
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAl
M0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJlZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlh
bWwlMjMmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fucw0KPiBvbi5odWENCj4gPg0KPiArbmclNDBueHAu
Y29tJTdDZDYyMmYzYjMxY2NhNGIyZTdiNDgwOGQ3ZmIwZmFlOTklN0M2ODZlYTFkM2JjMmINCj4g
NGM2ZmE5Mg0KPiA+DQo+ICtjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyNTM5MTcwODI3Njc0
MTYmYW1wO3NkYXRhPVUlMkZzNjANCj4gUUtIYVBjNUFyDQo+ID4gK0d4SlA5N0ZMTCUyQnNDbGda
a3VTbWVRV0tvZm00b1ElM0QmYW1wO3Jlc2VydmVkPTANCj4gPiArDQo+ID4gK3RpdGxlOiBGcmVl
c2NhbGUgaS5NWCBTeXN0ZW0gUmVzZXQgQ29udHJvbGxlcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5l
cnM6DQo+ID4gKyAgLSBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiA+
ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBUaGUgc3lzdGVtIHJlc2V0IGNvbnRyb2xs
ZXIgY2FuIGJlIHVzZWQgdG8gcmVzZXQgdGhlIEdQVSwgVlBVLA0KPiA+ICsgIElQVSwgYW5kIE9w
ZW5WRyBJUCBtb2R1bGVzIG9uIGkuTVg1IGFuZCBpLk1YNiBJQ3MuIFRob3NlIGRldmljZQ0KPiA+
ICsgIG5vZGVzIHNob3VsZCBzcGVjaWZ5IHRoZSByZXNldCBsaW5lIG9uIHRoZSBTUkMgaW4gdGhl
aXIgcmVzZXRzDQo+ID4gKyAgcHJvcGVydHksIGNvbnRhaW5pbmcgYSBwaGFuZGxlIHRvIHRoZSBT
UkMgZGV2aWNlIG5vZGUgYW5kIGENCj4gPiArICBSRVNFVF9JTkRFWCBzcGVjaWZ5aW5nIHdoaWNo
IG1vZHVsZSB0byByZXNldCwgYXMgZGVzY3JpYmVkIGluDQo+ID4gKyAgcmVzZXQudHh0DQo+ID4g
Kw0KPiA+ICsgIFRoZSBmb2xsb3dpbmcgUkVTRVRfSU5ERVggdmFsdWVzIGFyZSB2YWxpZCBmb3Ig
aS5NWDU6DQo+ID4gKyAgICBHUFVfUkVTRVQgICAgIDANCj4gPiArICAgIFZQVV9SRVNFVCAgICAg
MQ0KPiA+ICsgICAgSVBVMV9SRVNFVCAgICAyDQo+ID4gKyAgICBPUEVOX1ZHX1JFU0VUIDMNCj4g
PiArICBUaGUgZm9sbG93aW5nIGFkZGl0aW9uYWwgUkVTRVRfSU5ERVggdmFsdWUgaXMgdmFsaWQg
Zm9yIGkuTVg2Og0KPiA+ICsgICAgSVBVMl9SRVNFVCAgICA0DQo+ID4gKw0KPiA+ICtwcm9wZXJ0
aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBj
b25zdDogImZzbCxpbXg1MS1zcmMiDQo+IA0KPiAiZnNsLGlteDUxLXNyYyIgaXMgdGhlIG9ubHkg
Y29tcGF0aWJsZSB0aGUgZHJpdmVyIG1hdGNoZXMgb24sIGJ1dCB3ZSBoYXZlDQo+IHRoZXNlIGNv
bWJpbmF0aW9ucyBvbiBjb21wYXRpYmxlIFNSQ3MgaW4gdGhlIGRldmljZSB0cmVlczoNCj4gDQo+
ICAgImZzbCxpbXg1MC1zcmMiLCAiZnNsLGlteDUxLXNyYyINCj4gICAiZnNsLGlteDUxLXNyYyIN
Cj4gICAiZnNsLGlteDUzLXNyYyIsICJmc2wsaW14NTEtc3JjIg0KPiAgICJmc2wsaW14NnEtc3Jj
IiwgImZzbCxpbXg1MS1zcmMiDQo+ICAgImZzbCxpbXg2c2wtc3JjIiwgImZzbCxpbXg1MS1zcmMi
DQo+ICAgImZzbCxpbXg2c2xsLXNyYyIsICJmc2wsaW14NTEtc3JjIg0KPiAgICJmc2wsaW14NnN4
LXNyYyIsICJmc2wsaW14NTEtc3JjIg0KPiAgICJmc2wsaW14NnVsLXNyYyIsICJmc2wsaW14NTEt
c3JjIg0KPiANCj4gVGhhdCBjb3VsZCBiZSBkZXNjcmliZWQgdXNpbmcgb25lT2YgYW5kIGFuZCBh
biBpdGVtcyBsaXN0IG9mIGNvbnN0IHZhbHVlcyBwZXINCj4gU29DIGxpa2UgaW4gdGhlIHFjb20g
YmluZGluZ3MuDQoNClllcywgSSBub3RpY2VkIHRoaXMgYW5kIHdpbGwgYWRkIGFsbCBvZiB0aGVt
IGluIFYyIHBlciBTb0MsIHRoYW5rcy4NCg0KQW5zb24NCg==
