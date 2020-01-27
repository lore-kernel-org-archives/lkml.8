Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E510D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rcNCWaKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgA0M6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:58:17 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:32577
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbgA0M6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:58:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm9f2c7dBJ0tX0NKcQ3UY+r25O0ReU+uaJYQL5STd0cftA4+smnXTduLW3iWa9J6ucrjrT9cayeYKAYXlz5u8sTaF5IUKCtMaPCF/dq1UkEZA3AEChlkapHXBxzVJ0Cmrh6e4n2idTR7uiNAPtvR21xBOyijeHwVvwwAVFN4ui5QNhJMIWlL8FiPy2vqyG9aypQteT3GlxOWf/cewY08ke/fuWlllAydeiHQ00qpJ5DvT8Xm+kWlRubEeh7wpa3KNKVRBiU2YMMrb6opYYV1i7p6q2xKWqn8ORuNbnIPHFZfjnqqdg/dvk+XHfEvmqVNMBOURW0b/wK67879AppDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78Fi6QTmD2Lcz/UakTAJC10xpmnmdp7tWhUelNbUHJM=;
 b=Is7CutMz9g2zUgmsnNVoIG+mVQv3OKxfzmvUaTuOB270s4VWVUmS28yKdZWo1PkU9cwzH8nqIHKReJj4itfJhbPuEJawWPdyYcX9LeefcPxqJ5Z4kwt0PoqIDyJbS00xcpBaAIfjDGXWtMHtnJfbLQq6uiAyfzz643cEj6H5wj3kBxNt6GR8tjhp+ccoecmC3bBeCGFFDbZxmWzdnw++IZ2EtNmW5RJQZP1/Ej0rdaArH/bGpeHb+KSZi2WD8OhfA1eHlX4eqAEK9ZjSZsQ6pKzmnRX3Wj4y5XYZjFl22BIIfj0rRNWBN6a5pu5GZAdiUkUVDfwHLyuhHZfja35Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78Fi6QTmD2Lcz/UakTAJC10xpmnmdp7tWhUelNbUHJM=;
 b=rcNCWaKVzoJURfaOMhl/OHfzCh+ZAApQLxcxHry2pl3TDdTNF7deevp8SH853BlwJOg+TyPLsOyi+H5mghRkLMYgEF3gF+3UelNkQF//7Sgql/gGinnXR94jD58Y8hPTs+HBk/59L6cr0BBtKqGDOIfMdz2YR/mV6qKUmKJ/lLU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6865.eurprd04.prod.outlook.com (52.132.213.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21; Mon, 27 Jan 2020 12:58:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 12:58:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        etienne carriere <etienne.carriere@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHV0U+oLeMoXVmSv0ua2imZc8QMhKf2/n+AgAeAeoA=
Date:   Mon, 27 Jan 2020 12:58:12 +0000
Message-ID: <AM0PR04MB448137850D19BADD11F75B18880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <CAN5uoS_YyPXiqZnNfM32cxeAsK+xuPX9QRK94-DJ6oMQFrZPXQ@mail.gmail.com>
 <CAN5uoS-9yUfAT4=a9ys4d_2wxh9nW_RgXd_-3T-zF2r-k-PtOw@mail.gmail.com>
In-Reply-To: <CAN5uoS-9yUfAT4=a9ys4d_2wxh9nW_RgXd_-3T-zF2r-k-PtOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b38e304e-1ca3-4144-f7df-08d7a3289165
x-ms-traffictypediagnostic: AM0PR04MB6865:
x-microsoft-antispam-prvs: <AM0PR04MB686587D18044FD0729F1174B880B0@AM0PR04MB6865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(110136005)(33656002)(316002)(26005)(186003)(44832011)(7696005)(9686003)(15650500001)(55016002)(966005)(45080400002)(478600001)(86362001)(52536014)(8936002)(8676002)(81156014)(81166006)(71200400001)(76116006)(2906002)(66446008)(66946007)(66476007)(66556008)(64756008)(6506007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6865;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLlVIMf3TvhGbvXOA4Y6otPFgMMMLZkm1Uq2yrxmOswlG9ewvf9IDdz/3DX9n1OY8NBntwzacqFfXRzF0H4SDubffhdafEqVHls5cnBRXiqPXA2o2vX9g+xtNG1yf/U+/yNfBriVG3N9kQK4IncZ7uLYrlm/9ukR1XV6ObcnW0lHb9FSqVIUEM8TXED8VZOy8w2Rho/wUZU2HNuUl+dLfybJ4B4QsymptEiPrm6bPwdn6T7O402Y8vXfwCFY+Mnd9Cck/fUjERXIwmjdpTBt6fVJvjwVAkpv/es/xYrc4SHiBN0Rhr3DQmBeTgK+aMhJK2zsKsRgDqFG+BuEHGTwMIHkWkXAWeQfpjrvYFn+MmAkhF0TcdRaq4XU0HxGnrE6IsZopjUO1FcRblRk8xq1MQXYVff7ct5qqsZLuqflFW9gnKUgz+QH6BGEXLMO/V9ss6vEp3N1zphnxrjzw/mr7MCwWTy5QwyZrMMyKrySW0nor8T0P6/OpdW1mO09pNER7VgeK7VtTLQqxkM+ADDrXLul8qMs5yzpxXagCy6vxlyUUbSP69vMDMar3FScaAOkZ4trQvOkpyAc+M6mD5X93cGJNkDizzx74ev78RhRpIkvV78aN592Z21zm/XRNfcA
x-ms-exchange-antispam-messagedata: eaKexnBtcFZXHbZsR6buTwYaBJpFudLST1sm+v0OLsZpwfduelDK+e4sygKvcae3jC89v4oTPzSRrCd5x2c5PCEk8cQFGHRQG5W8zU8pE4bvQh8AWPSzEkHs2Uh43jU97+uav9kWmldArR0RFArV2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38e304e-1ca3-4144-f7df-08d7a3289165
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 12:58:12.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOGplK4blC3MZzzbM1/PI0G8uzhBPW8nHs4CI2IZGPotap57XzykLBxxp2k7VOmerGu+YzsKbJsrHEt/GGRHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAyLzJdIG1haWxib3g6IGludHJvZHVjZSBBUk0gU01D
IGJhc2VkIG1haWxib3gNCj4gDQo+IEhlbGxvIFBlbmcgYW5kIGFsbCwNCj4gDQo+IA0KPiA+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBtYWlsYm94IGRy
aXZlciBpbXBsZW1lbnRzIGEgbWFpbGJveCB3aGljaCBzaWduYWxzIHRyYW5zbWl0dGVkDQo+ID4g
ZGF0YSB2aWEgYW4gQVJNIHNtYyAoc2VjdXJlIG1vbml0b3IgY2FsbCkgaW5zdHJ1Y3Rpb24uIFRo
ZSBtYWlsYm94DQo+ID4gcmVjZWl2ZXIgaXMgaW1wbGVtZW50ZWQgaW4gZmlybXdhcmUgYW5kIGNh
biBzeW5jaHJvbm91c2x5IHJldHVybiBkYXRhDQo+ID4gd2hlbiBpdCByZXR1cm5zIGV4ZWN1dGlv
biB0byB0aGUgbm9uLXNlY3VyZSB3b3JsZCBhZ2Fpbi4NCj4gPiBBbiBhc3luY2hyb25vdXMgcmVj
ZWl2ZSBwYXRoIGlzIG5vdCBpbXBsZW1lbnRlZC4NCj4gPiBUaGlzIGFsbG93cyB0aGUgdXNhZ2Ug
b2YgYSBtYWlsYm94IHRvIHRyaWdnZXIgZmlybXdhcmUgYWN0aW9ucyBvbiBTb0NzDQo+ID4gd2hp
Y2ggZWl0aGVyIGRvbid0IGhhdmUgYSBzZXBhcmF0ZSBtYW5hZ2VtZW50IHByb2Nlc3NvciBvciBv
biB3aGljaA0KPiA+IHN1Y2ggYSBjb3JlIGlzIG5vdCBhdmFpbGFibGUuIEEgdXNlciBvZiB0aGlz
IG1haWxib3ggY291bGQgYmUgdGhlIFNDUA0KPiA+IGludGVyZmFjZS4NCj4gPg0KPiA+IE1vZGlm
aWVkIGZyb20gQW5kcmUgUHJ6eXdhcmEncyB2MiBwYXRjaA0KPiA+IGh0dHBzOi8vZXVyMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4g
PiAua2VybmVsLm9yZyUyRnBhdGNod29yayUyRnBhdGNoJTJGODEyOTk5JTJGJmFtcDtkYXRhPTAy
JTdDMDElNw0KPiBDcGVuZy5mYQ0KPiA+DQo+IG4lNDBueHAuY29tJTdDNzM1Y2M2Y2QwMDQwNDA4
MmJmOGMwOGQ3OWY2N2I5M2ElN0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNkDQo+ID4NCj4gOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzE1MzE0MDE0MDg3ODI3OCZhbXA7c2RhdGE9bTBsY0FFSXIw
WlANCj4gdHlQSG9yU1cNCj4gPiBOWWdqZkk1cDBnZW5KTGxocUhNSUhCZzAlM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxp
QGdtYWlsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3
YXJhQGFybS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+IA0KPiBJJ3ZlIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgeW91ciBjaGFuZ2Ugb24gbXkgYm9h
cmQuIEl0IGlzIGEgc3RtMzJtcDEgd2l0aCBUWg0KPiBzZWN1cmUgaGFyZGVuaW5nIGFuZCBJIHJ1
biBhbiBPUC1URUUgZmlybXdhcmUgKHBvc3NpYmx5IGEgVEYtQQ0KPiBzcF9taW4pIHdpdGggYSBT
Q01JIHNlcnZlciBmb3IgY2xvY2sgYW5kIHJlc2V0LiBVcHN0cmVhbSBpbiBwcm9ncmVzcy4NCj4g
VGhlIHBsYXRmb3JtIHVzZXMgMiBpbnN0YW5jZXMgb2YgeW91ciBTTUMgYmFzZWQgbWFpbGJveCBk
ZXZpY2UgZHJpdmVyDQo+ICgyIG1haWxib3hlcykuIFdvcmtzIG5pY2Ugd2l0aCB5b3VyIGNoYW5n
ZS4NCj4gDQo+IFlvdSBjYW4gYWRkIG15IFQtYiB0YWc6IFRlc3RlZC1ieTogRXRpZW5uZSBDYXJy
aWVyZQ0KPiA8ZXRpZW5uZS5jYXJyaWVyZUBsaW5hcm8ub3JnPg0KDQpUaGFua3MsIGJ1dCB0aGlz
IHBhdGNoIGhhcyBiZWVuIGRyb3BwZWQuDQoNClBlciBTdWRlZXAsIHdlIGFsbCB1c2Ugc21jIHRy
YW5zcG9ydCwgbm90IHNtYyBtYWlsYm94ICwNCkknbGwgcG9zdCBwYXRjaCBpbiBhIGZldyBkYXlz
IGJhc2VkIG9uIHRoZSB0cmFuc3BvcnQgc3BsaXQgcGF0Y2guDQoNCj4gDQo+IEZZSSwgSSdsbCAo
aG9wZWZ1bGx5IHNvb24pIHBvc3QgYSBjaGFuZ2UgcHJvcG9zYWwgaW4gVS1Cb290IE1MIGZvciBh
biBlcXV2YWxlbnQNCj4gJ1NNQyBiYXNlZCBtYWlsYm94JyBkcml2ZXIgYW5kIFNDTUkgYWdlbnQg
cHJvdG9jb2wvZGV2aWNlIGRyaXZlcnMgZm9yIGNsb2NrDQo+IGFuZCByZXNldCBjb250cm9sbGVy
cy4NCg0KR3JlYXQgdG8ga25vdyB5b3UgZGlkIHNjbWkgYWdlbnQgY29kZSBpbiBVLUJvb3QuIERv
IHlvdSBoYXZlIHNvbWUgcHVibGljIHJlcG8NCmZvciBhY2Nlc3M/DQoNClRoYW5rcywNClBlbmcu
DQoNCj4gSSdtIGFsc28gd29ya2luZyBvbiBnZXR0aW5nIHRoaXMgU0NNSSBzZXJ2ZXIgdXBzdHJl
YW0gaW4gVEYtQSBhbmQgT1AtVEVFLg0KPiBZb3VyIFNNQyBiYXNlZCBtYWlsYm94IGRyaXZlciBp
cyBhIHZhbHVhYmxlIG5vdGlmaWNhdGlvbiBzY2hlbWUgZm9yIG91ciBTQ01JDQo+IHNlcnZpY2Vz
IHN1cHBvcnQgaW4gQXJtIFRaIHNlY3VyZSB3b3JsZC4NCj4gDQo+IFJlZ2FyZHMsDQo+IEV0aWVu
bmUNCg==
