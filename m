Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D85C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E0E2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lGUtdG4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCSKEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:04:43 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:37294
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgCSKEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es0XVrdESJsaa9TVvQ6bpn4wikVBdYqv/ZmoS1lv1PLhqTz+PrctvLCEGbzZkBNNHs5lyk4VdwRgZuW+5SI6ddRnop1eriTmJsr4RjypBpwLCkiMCH61osaWbQFO1XWZS+3o+Oz7KzTC2jDC8afqkFQICTPKAJDs5W/h3PNraM4LKLu0XdeoDIn7/z+v2Ssa3qiVTN+M4BdUTQrn5+mKoj/IEXdzorCJOjz5ymZHhEO5r9Rns6DB38qolM+FI7G6xUYuzRQ6ACQNwNcWbab4+paVFSJ7VBqKl9+R8fM8/OF4gyURQz+OqKCIxYs+eexnjvZCtp/saKtvewPJW16ZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwIavESmyljaC0b4pkj/HPWYredwvbwPvAF2YWqPYA=;
 b=i+5HvszqtqkbrxfBxX8L8F8zGMcbv8Hd7Xeh2G4SeMC+XFnL74npa955f5WQo3ZboeBHMLIc5xvaJ2kYdvfzRuOGQpcFz75Em09O8mTABfuUb34MQE56SRz6ZLrHwHVhT26YWRwfsEul2KR/uLJxo6SE7AUdmoC63hKvONlciczDC+3ePVxW1IhQKcHqwi3LEcITt8Fo3Nj9S7rhWON2sOjpWVpqnEtbDAGLGyGoYNMMNNAshBq9RBVShcXiF6xFEYzRBQsggzSeYnBrfP7jBssPmtAXTYRaLGdqYt7z+cCmjIzuxr4zafgrcarat+VGvRS4LxNwxKsMR3e7M71i4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwIavESmyljaC0b4pkj/HPWYredwvbwPvAF2YWqPYA=;
 b=lGUtdG4C4BGwggYVoTcEmGcdRvdHir7XSo3xWmpV7EgtUWvMp2vS/JROKLBFPpODncqEKY8cjLuBiLLh2T6suZgOnUsqYsfyExMMUnHu4yz8GE6U6ihUZnD782KnTNx2Y4f9wGz6o0Idnmk/XO3CsGMGZVOCbVHL6BYf7gWik8I=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7058.eurprd04.prod.outlook.com (10.186.129.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Thu, 19 Mar 2020 10:04:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 10:04:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Topic: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Index: AQHV+FiylUv3TAYoQ06tNnE7fjyGF6hPulFg
Date:   Thu, 19 Mar 2020 10:04:38 +0000
Message-ID: <AM0PR04MB448104BDB759F703B21A0DD388F40@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5d469e5-82a8-4f1c-7169-08d7cbecefae
x-ms-traffictypediagnostic: AM0PR04MB7058:|AM0PR04MB7058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB70587783246EB19770BA73CC88F40@AM0PR04MB7058.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(86362001)(6506007)(55016002)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(186003)(52536014)(4326008)(478600001)(966005)(9686003)(26005)(5660300002)(7416002)(44832011)(316002)(110136005)(2906002)(33656002)(8676002)(81166006)(81156014)(8936002)(54906003)(7696005)(6636002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7058;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kkDchdd4xpQn6tDeX1JnZzhbZTM+vWWZLCHh0/vjLNwS6z7entg8GHLGmtLE61ZR1IciM+TYA5PzxuftkCI7cpUvanNWnHnVqGdt+w46GnnHcTKq6Cp0qlyelabckKZ3bUkYawUDRYq7OIaRsRxJEqW6a2QWHSgshFQYGzb+BpEqkwRYrJDqF23oJ7K78T658ALq65jJ5xNn5WFqAZmQBNJU58Lao2bKwWIrM0LJmpt0x15EhL7TXW4DMWfa3PRCkyyOCgfDwlMf5PbVkuSo6mvA/MJXwCbYsNqW6f5+/W8+8rUXFvaY1uIPwkrEZSU55Lr5BUkW1soKyvrGFDVXVamD5X3p/9D+WAWGrDb1tU+AZno6qAUw4LJqHD4ordvN8rp0e9iCbHy7DnhWwg0yv5w03VGBx/Lq73ZETaBWgvEb4lOdfPVU1ID4S+HnqmGHoORrOwx+D09RpIpz02isfVKqTPASL2HgwbutTpJecCIkz04TJGfQqgqJXWqteVZ8tpPClnx8SgVldoieO0HZ0Q==
x-ms-exchange-antispam-messagedata: mxhG98HSsQ6hQ7WG78I74iQnQH5LQAG4PEknDhncPMzU7ELj7uipL+YDAdQoWdH174eXIbYA6zEj3N5NuKRiy95P0k8el4hl88pH6A1K5+YtHjnBkBxeldHmjU+1fUqyE0bxIuENxNfxcCco5YmVoA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d469e5-82a8-4f1c-7169-08d7cbecefae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 10:04:38.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCmmhN7LKOSOXX0okSP/b8tl7PkCUZCMpsTGT1WTrBjYTiOjDU5kLEsJnrbiFL1O72yTknRO8BeCLJ/kQkjFyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIFYyIDAwLzEwXSBjbGs6IGlteDogZml4ZXMg
YW5kIGltcHJvdmUgZm9yIGkuTVg4TQ0KDQpJcyBpdCBwb3NzaWJsZSBmb3IgeW91IHRvIHRha2Ug
dGhpcyBwYXRjaHNldCBmb3IgNS43Pw0KDQpDdXJyZW50bHkgdGhlIGkuTVg4TSBjcHUgY2xvY2sg
aGFzIHNvbWUgZGVwZW5kZW5jeSBvbiBVLUJvb3Qgc2V0dGluZ3MsDQpXaGVuIHVib290IGhhcyBk
aWZmZXJlbnQgc2V0dGluZ3MsIHRoZSBrZXJuZWwgd2lsbCBoYW5nLg0KV2l0aCB0aGlzIHBhdGNo
c2V0LCBpdCB3aWxsIG5vdCwgYXQgbGVhc3QgSSB0ZXN0ZWQgb24gaS5NWDhNTS1FVksgd2l0aCB5
b3VyDQpsYXN0ZXN0IGZvci1uZXh0IGJyYW5jaC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4g
RnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBQYXRjaGVzIGJhc2VkIG9u
IGZvci1uZXh0DQo+IA0KPiBWMjoNCj4gIFBhdGNoIDcsIGRyb3Agd2FpdCBhZnRlciB3cml0ZSwg
YWRkIG9uZSBsaW5lIGNvbW1lbnQgZm9yIHdyaXRlIHR3aWNlDQo+IA0KPiBWMToNCj4gUGF0Y2gg
MSwyIGlzIHRvIGZpeCB0aGUgbG9ja2RlcCB3YXJuaW5nIHJlcG9ydGVkIGJ5IExlb25hcmQgUGF0
Y2ggMyBpcyB0byBmaXggcGxsDQo+IG11eCBiaXQgUGF0Y2ggNCBpcyBhbGlnbiB3aXRoIG90aGVy
IGkuTVg4TSB1c2luZyBnYXRlIFBhdGNoIDUgaXMgdG8gc2ltcGxpZnkNCj4gaS5NWDhNUCBjbGsg
cm9vdCB1c2luZyBjb21wb3NpdGUNCj4gDQo+IFBhdGNoIDN+NSBpcyBhY3R1YWxseSBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNDAyNzYxLw0KPiB3aXRoIGEgbWluaW1hbCBj
aGFuZ2UgdG8gcGF0Y2ggNSBoZXJlLg0KPiANCj4gUGF0Y2ggNiBpcyB0byB1c2UgY29tcG9zaXRl
IGNvcmUgY2xrIGZvciBBNTMgY2xrIHJvb3QgUGF0Y2ggNyw4LDkgaXMgYWN0dWFsbHkgdG8NCj4g
Zml4IENPUkUvQlVTIGNsayBzbGljZSBpc3N1ZS4NCj4gIFRoaXMgaXNzdWUgaXMgdHJpZ2dlcnJl
ZCBhZnRlciB3ZSB1cGRhdGUgVS1Cb290IHRvIGluY2x1ZGUgIHRoZSBBNTMgY2xrIGZpeGVzDQo+
IHRvIHNvdXJjZXMgZnJvbSBQTEwsIG5vdCBmcm9tIEE1MyByb290IGNsaywgIGJlY2F1c2Ugb2Yg
dGhlIHNpZ25vZmYgdGltaW5nIGlzDQo+IDFHSHouIFUtQm9vdCBzZXQgdGhlIEE1MyByb290ICBt
dXggdG8gMiwgc3lzIHBsbDIgNTAwTUh6LiBLZXJuZWwgd2lsbCBzZXQNCj4gdGhlIEE1MyByb290
IG11eCB0byAgNCwgc3lzIHBsbDEgODAwTUh6LCB0aGVuIGdhdGUgb2ZmIHN5cyBwbGwyIDUwME1I
ei4gVGhlbg0KPiBrZXJuZWwgIHdpbGwgZ2F0ZSBvZmYgQTUzIHJvb3QgYmVjYXVzZSBjbGtfaWdu
b3JlX3Vuc2VkLCBBNTMgZGlyZWN0bHkgc291cmNlcw0KPiBQTEwsIHNvIGl0IGlzIG9rIHRvIGdh
dGUgb2ZmIEE1MyByb290LiBIb3dldmVyIHdoZW4gZ2F0ZSBvZmYgQTUzICByb290IGNsaywNCj4g
c3lzdGVtIGhhbmcsIGJlY2F1c2UgdGhlIG9yaWdpbmFsIG11eCBzeXMgcGxsMiA1MDBNSHogIGdh
dGVkIG9mZiB3aXRoDQo+IENMS19PUFNfUEFSRU5UX0VOQUJMRSBmbGFnLg0KPiANCj4gIEl0IGlz
IGx1Y2t5IHRoYXQgd2Ugbm90IG1ldCBpc3N1ZSBmb3Igb3RoZXIgY29yZS9idXMgY2xrIHNsaWNl
ICBleGNlcHQgQTUzDQo+IFJPT1QgY29yZSBzbGljZS4gQnV0IGl0IGlzIGFsd2F5cyB0cmlnZ2Vy
cmVkIGFmdGVyICBVLUJvb3QgYW5kIExpbnV4IGJvdGgNCj4gc3dpdGNoIHRvIHVzZSBBUk0gUExM
IGZvciBBNTMgY29yZSwgYnV0ICBoYXZlIGRpZmZlcmVudCBtdXggc2V0dGluZ3MgZm9yIEE1Mw0K
PiByb290IGNsayBzbGljZS4NCj4gDQo+ICBTbyB0aGUgdGhyZWUgcGF0Y2hlcyBpcyB0byBhZGRy
ZXNzIHRoaXMgaXNzdWUuDQo+IA0KPiBQYXRjaCAxMCBpcyBtYWtlIG1lbXJlcGFpciBhcyBjcml0
aWNhbC4NCj4gDQo+IFBlbmcgRmFuICgxMCk6DQo+ICAgYXJtNjQ6IGR0czogaW14OG06IGFzc2ln
biBjbG9ja3MgZm9yIEE1Mw0KPiAgIGNsazogaW14OG06IGRyb3AgY2xrX2h3X3NldF9wYXJlbnQg
Zm9yIEE1Mw0KPiAgIGNsazogaW14OiBpbXg4bXA6IGZpeCBwbGwgbXV4IGJpdA0KPiAgIGNsazog
aW14OG1wOiBEZWZpbmUgZ2F0ZXMgZm9yIHBsbDEvMiBmaXhlZCBkaXZpZGVycw0KPiAgIGNsazog
aW14OG1wOiB1c2UgaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9jb3JlIHRvIHNpbXBsaWZ5IGNvZGUN
Cj4gICBjbGs6IGlteDhtOiBtaWdyYXRlIEE1MyBjbGsgcm9vdCB0byB1c2UgY29tcG9zaXRlIGNv
cmUNCj4gICBjbGs6IGlteDogYWRkIG11eCBvcHMgZm9yIGkuTVg4TSBjb21wb3NpdGUgY2xrDQo+
ICAgY2xrOiBpbXg6IGFkZCBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2J1cw0KPiAgIGNsazogaW14
OiB1c2UgaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9idXMgZm9yIGkuTVg4TSBidXMgY2xrIHNsaWNl
DQo+ICAgY2xrOiBpbXg4bXA6IG1hcmsgbWVtcmVwYWlyIGNsb2NrIGFzIGNyaXRpY2FsDQo+IA0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCAgMTAgKy0NCj4g
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kgfCAgMTAgKy0NCj4gYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgfCAgMTEgKystDQo+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8ICAgOSArLQ0KPiAgZHJpdmVy
cy9jbGsvaW14L2Nsay1jb21wb3NpdGUtOG0uYyAgICAgICAgfCAgNjcgKysrKysrKysrKysrLQ0K
PiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYyAgICAgICAgICAgICAgfCAgMjcgKysrLS0t
DQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jICAgICAgICAgICAgICB8ICAyNSArKyst
LQ0KPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYyAgICAgICAgICAgICAgfCAxNTANCj4g
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlt
eDhtcS5jICAgICAgICAgICAgICB8ICAyOSArKystLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGsu
aCAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsrDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Ns
b2NrL2lteDhtcC1jbG9jay5oICB8ICAyOCArKysrKy0NCj4gIDExIGZpbGVzIGNoYW5nZWQsIDI0
MCBpbnNlcnRpb25zKCspLCAxMzMgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjE2LjQNCg0K
