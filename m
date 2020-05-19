Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5E020758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NRz23eUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgESCq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:46:27 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:62117
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbgESCq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZsWsC1ggtDhLlLuuUaU9S3DWRCDL3VKZ3AemLwL6EhkB6tuQAbU3uog2GjTdpFhNQ/Bp4qZFBOnjdUtstAmZ9jNLKrNqzMVE/aiGauVQ8ZVaPT1lNkO+ZU/2z5XG3r1d+cNdr6+Ji8qiMrsr8iA8Lt5fHtPn7AXF/C/NcPPHtjivTOlzL+T1UiKaCJGrj/iqC64RqfsCzuG6UevkbWsGExnpuoo+wHmCddv8aoezfWqw3xi+nC33apTjo840n+GUFWw2YCmjc3qgiQwRXwyjB9vuxbgV5RIFSTqmZc8ChWEZMyUNVoTFUEPJicMhKxv5gaUcidlXLFgGyBdWCUb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUJPPye1T7oHq0tzhGOmONo49TzbTxO/dYPleWC4r9g=;
 b=RFg9yXTAMUZm5vgCvZRjFL1uJRSoqlz6ukKmS93o9soShbziRzD6Y7eucKCSVm4Z5/q/WtxLkqQiqCXmpQLS/dudghOm7/cpOgPdJgWx5VIz3rziMKnJYUiQ2/UE8WjDOXBJv0VL7PFpCRi/tcRU/JfHHY1IfnYvSNHu5fmEYyCLT3xqmtgG01A77Wi1oBcRAi0CnZ2v6ukCMJd1qvNhEJ/ym5Zmx6RpgW06O+E76rrN9acrdXTt5u4QaOcx5c6fxhRKbVi3jgO1wT0R0sd/Fp8FD5TxjAWy2YlknsiNrKNVu+sZlA+EV1zU8KV2L9GCBq69o0sFdjGzS7AppcFVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUJPPye1T7oHq0tzhGOmONo49TzbTxO/dYPleWC4r9g=;
 b=NRz23eUw6sdEolwYRhYmQlzVhyOBUbmFJXkZvjST2WdeObxnJMGKjmb6hkAD6YV2f8+BPms4vMsC23M/IDk1g/jHbSGECjM3x384xuPIbZyXnpKeDMIWEPLsMCLd0WgXCpHyQ5Nz5VpzgcMjlBFWhYE8X41E2NmxY1Ggs7AA8Co=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5863.eurprd04.prod.outlook.com (2603:10a6:20b:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 02:46:21 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:46:21 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: timer: Convert i.MX GPT to json-schema
Thread-Topic: [PATCH 1/3] dt-bindings: timer: Convert i.MX GPT to json-schema
Thread-Index: AQHWLSSmpbYMtM446EG0c6gnhRlcxaius5QA
Date:   Tue, 19 May 2020 02:46:21 +0000
Message-ID: <AM6PR04MB49669345E21DC28009C486E680B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
 <1589813260-20036-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589813260-20036-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88366295-949c-4719-0309-08d7fb9ed06c
x-ms-traffictypediagnostic: AM6PR04MB5863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5863781C0DE5F8DE7825E89880B90@AM6PR04MB5863.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9S8Dl2avePaJRf1rT7dqrAQbeVokHg86EJzNMi3rvOCpF91CjbaLQ4jC3zPUIHAbkd7kxVUg20wA7Eeu+bYUbmuIENIAWFmBTPDSCJFV96aewDVSfAnKOl+0iXtZT4+6QlXWGIEGHND0hyIJm7qbs9TyFPHw1Yg3O+6QZbuNv0RMczKCmZhLtW2cDbiWcSo6P1W0V8zm5kH4pEgv9zvKV2LbRlAMZMo56BJAQ4sKGsz4DSMj57EgdC838pjZ5zx5OLc6p/RQcfv9UwLyBab0uwvJ/gkvq9HXWRFrGh4uu6jRXWtvmsXyOcchq/j4FJAESQ0UQrMCxAz3nnzTTpFbOQu/DKy9E/PoJ76Bn+9uH2uVN9TEGO6LemIqrOhEgEzTyzmhilmY8F8eikmxbzwv2ggxMnwFOmjymi83eq2hidPpcsR3vk1aeVHNmf7hXDJmhu6+PmeKA7ueoYbXBvBeV8m9TxOgThrN2UvqqpoHFGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(26005)(86362001)(8676002)(186003)(7416002)(2906002)(44832011)(5660300002)(33656002)(316002)(478600001)(8936002)(6506007)(7696005)(71200400001)(4326008)(110136005)(9686003)(52536014)(66446008)(64756008)(76116006)(66946007)(66476007)(55016002)(66556008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TX9us50lLYwwnxYyhGVEhXWsGUSe7Brte1E9FyAdLMydnOSWgkUdW/v3cIU0qxw6mIovPnR0hRQxr0qE5Wyuc6cDWtla8Ed7vaHR0DMgkVUklEhjRiDFXOIRUZ0IJQKr94uvkmYdfeeuMblBdI1igXvfGMD7dHbyw9EI+5VN5MRfcDn4/dlBGU8wHOVG+l5S6rIcLH63qnUeSVygMFLZZ4XgQBbGeAo1cBmwq90N3fdDzw1yLh6Q0NXt+mg8J7uhmm3SY41HFeJbA9MXkMkMYXEXTwHIfWVJu5o3eWqLvHwldtzPnO0kNDvQNCaNFSelM0kzunZfk9Thx4u29upYgKiH7L8zOdJH9AQXXeIkh8LoF/TKljI9BP8aXnH0ZjofxacQotdDFqS4B9N1oBXMDOYnaKaGwbWacfJohY8IHWZ5R326hv77S6TDAzotu3ceOrUwATr+UmlTUTpcP4fLdH/B0bACMh9VdxSVXGd6XMBhiRhKzMngU/ghCE0jVtVs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88366295-949c-4719-0309-08d7fb9ed06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:46:21.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGPaTQcohMlkDbJ4IPNLgdwFRGBlwr9mkBJyo2gVSCNnFQ1BYZErhL4HDP/krSVDprS2Q+rTFfQIWId5MzKd7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMTA6NDggUE0NCj4gDQo+IENvbnZlcnQgdGhlIGkuTVggR1BUIGJpbmRp
bmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0ICAgICAgIHwgIDQ1IC0tLS0t
LS0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdwdC55YW1sICAg
ICAgfCAxMDkNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEw
OSBpbnNlcnRpb25zKCspLCA0NSBkZWxldGlvbnMoLSkgIGRlbGV0ZSBtb2RlIDEwMDY0NA0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdwdC50eHQNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dGltZXIvZnNsLGlteGdwdC55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0DQo+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0DQo+IGRlbGV0ZWQgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCA1ZDhmZDViLi4wMDAwMDAwDQo+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9mc2wsaW14Z3B0LnR4dA0KPiArKysgL2Rl
di9udWxsDQo+IEBAIC0xLDQ1ICswLDAgQEANCj4gLUZyZWVzY2FsZSBpLk1YIEdlbmVyYWwgUHVy
cG9zZSBUaW1lciAoR1BUKQ0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtDQo+IC0t
IGNvbXBhdGlibGUgOiBzaG91bGQgYmUgb25lIG9mIGZvbGxvd2luZzoNCj4gLSAgZm9yIGkuTVgx
Og0KPiAtICAtICJmc2wsaW14MS1ncHQiOw0KPiAtICBmb3IgaS5NWDIxOg0KPiAtICAtICJmc2ws
aW14MjEtZ3B0IjsNCj4gLSAgZm9yIGkuTVgyNzoNCj4gLSAgLSAiZnNsLGlteDI3LWdwdCIsICJm
c2wsaW14MjEtZ3B0IjsNCj4gLSAgZm9yIGkuTVgzMToNCj4gLSAgLSAiZnNsLGlteDMxLWdwdCI7
DQo+IC0gIGZvciBpLk1YMjU6DQo+IC0gIC0gImZzbCxpbXgyNS1ncHQiLCAiZnNsLGlteDMxLWdw
dCI7DQo+IC0gIGZvciBpLk1YNTA6DQo+IC0gIC0gImZzbCxpbXg1MC1ncHQiLCAiZnNsLGlteDMx
LWdwdCI7DQo+IC0gIGZvciBpLk1YNTE6DQo+IC0gIC0gImZzbCxpbXg1MS1ncHQiLCAiZnNsLGlt
eDMxLWdwdCI7DQo+IC0gIGZvciBpLk1YNTM6DQo+IC0gIC0gImZzbCxpbXg1My1ncHQiLCAiZnNs
LGlteDMxLWdwdCI7DQo+IC0gIGZvciBpLk1YNlE6DQo+IC0gIC0gImZzbCxpbXg2cS1ncHQiLCAi
ZnNsLGlteDMxLWdwdCI7DQo+IC0gIGZvciBpLk1YNkRMOg0KPiAtICAtICJmc2wsaW14NmRsLWdw
dCI7DQo+IC0gIGZvciBpLk1YNlNMOg0KPiAtICAtICJmc2wsaW14NnNsLWdwdCIsICJmc2wsaW14
NmRsLWdwdCI7DQo+IC0gIGZvciBpLk1YNlNYOg0KPiAtICAtICJmc2wsaW14NnN4LWdwdCIsICJm
c2wsaW14NmRsLWdwdCI7DQo+IC0tIHJlZyA6IHNwZWNpZmllcyBiYXNlIHBoeXNpY2FsIGFkZHJl
c3MgYW5kIHNpemUgb2YgdGhlIHJlZ2lzdGVycy4NCj4gLS0gaW50ZXJydXB0cyA6IHNob3VsZCBi
ZSB0aGUgZ3B0IGludGVycnVwdC4NCj4gLS0gY2xvY2tzIDogdGhlIGNsb2NrcyBwcm92aWRlZCBi
eSB0aGUgU29DIHRvIGRyaXZlIHRoZSB0aW1lciwgbXVzdCBjb250YWluDQo+IC0gICAgICAgICAg
IGFuIGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIGNsb2NrLW5hbWVzLg0KPiAtLSBjbG9jay1uYW1l
cyA6IG11c3QgaW5jbHVkZSAiaXBnIiBlbnRyeSBmaXJzdCwgdGhlbiAicGVyIiBlbnRyeS4NCj4g
LQ0KPiAtRXhhbXBsZToNCj4gLQ0KPiAtZ3B0MTogdGltZXJAMTAwMDMwMDAgew0KPiAtCWNvbXBh
dGlibGUgPSAiZnNsLGlteDI3LWdwdCIsICJmc2wsaW14MjEtZ3B0IjsNCj4gLQlyZWcgPSA8MHgx
MDAwMzAwMCAweDEwMDA+Ow0KPiAtCWludGVycnVwdHMgPSA8MjY+Ow0KPiAtCWNsb2NrcyA9IDwm
Y2xrcyBJTVgyN19DTEtfR1BUMV9JUEdfR0FURT4sDQo+IC0JCSA8JmNsa3MgSU1YMjdfQ0xLX1BF
UjFfR0FURT47DQo+IC0JY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+IC19Ow0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhn
cHQueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9mc2ws
aW14Z3B0LnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNWM3
MTg2Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aW1lci9mc2wsaW14Z3B0LnlhbWwNCj4gQEAgLTAsMCArMSwxMDkgQEANCj4gKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAl
WUFNTCAxLjINCj4gKy0tLQ0KPiArDQo+ICt0aXRsZTogRnJlZXNjYWxlIGkuTVggR2VuZXJhbCBQ
dXJwb3NlIFRpbWVyIChHUFQpDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIFNhc2NoYSBI
YXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAg
Y29tcGF0aWJsZToNCj4gKyAgICBvbmVPZjoNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IG9uIGku
TVgxIHRoZSBmb2xsb3dpbmcgY29tcGF0aWJsZSBtdXN0IGJlIHNwZWNpZmllZA0KDQpTdWNoIGEg
ZGVzY3JpcHRpb24gc2VlbXMgbm90IG5lY2Vzc2FyeSBpbiBvcmRlciB0byBtYWtlIHRoZSBkb2Mg
bW9yZSBjbGVhbg0KDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6ICJm
c2wsaW14MS1ncHQiDQo+ICsNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IG9uIGkuTVgyMSB0aGUg
Zm9sbG93aW5nIGNvbXBhdGlibGUgbXVzdCBiZSBzcGVjaWZpZWQNCj4gKyAgICAgICAgaXRlbXM6
DQo+ICsgICAgICAgICAgLSBjb25zdDogImZzbCxpbXgyMS1ncHQiDQo+ICsNCj4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IG9uIGkuTVgyNyB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGVzIG11c3QgYmUg
c3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2ws
aW14MjctZ3B0Ig0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14MjEtZ3B0Ig0KPiArDQo+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBvbiBpLk1YMzEgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxl
IG11c3QgYmUgc3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29u
c3Q6ICJmc2wsaW14MzEtZ3B0Ig0KPiArDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBvbiBpLk1Y
MjUgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxlcyBtdXN0IGJlIHNwZWNpZmllZA0KPiArICAgICAg
ICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDI1LWdwdCINCj4gKyAgICAg
ICAgICAtIGNvbnN0OiAiZnNsLGlteDMxLWdwdCINCj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlv
bjogb24gaS5NWDUwIHRoZSBmb2xsb3dpbmcgY29tcGF0aWJsZXMgbXVzdCBiZSBzcGVjaWZpZWQN
Cj4gKyAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogImZzbCxpbXg1MC1ncHQi
DQo+ICsgICAgICAgICAgLSBjb25zdDogImZzbCxpbXgzMS1ncHQiDQo+ICsNCj4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IG9uIGkuTVg1MSB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGVzIG11c3QgYmUg
c3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2ws
aW14NTEtZ3B0Ig0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14MzEtZ3B0Ig0KPiArDQo+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBvbiBpLk1YNTMgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxl
cyBtdXN0IGJlIHNwZWNpZmllZA0KPiArICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNv
bnN0OiAiZnNsLGlteDUzLWdwdCINCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDMxLWdw
dCINCj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogb24gaS5NWDZRIHRoZSBmb2xsb3dpbmcg
Y29tcGF0aWJsZXMgbXVzdCBiZSBzcGVjaWZpZWQNCj4gKyAgICAgICAgaXRlbXM6DQo+ICsgICAg
ICAgICAgLSBjb25zdDogImZzbCxpbXg2cS1ncHQiDQo+ICsgICAgICAgICAgLSBjb25zdDogImZz
bCxpbXgzMS1ncHQiDQo+ICsNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IG9uIGkuTVg2REwgdGhl
IGZvbGxvd2luZyBjb21wYXRpYmxlIG11c3QgYmUgc3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1z
Og0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14NmRsLWdwdCINCj4gKw0KPiArICAgICAg
LSBkZXNjcmlwdGlvbjogb24gaS5NWDZTTCB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGVzIG11c3Qg
YmUgc3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6ICJm
c2wsaW14NnNsLWdwdCINCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDZkbC1ncHQiDQo+
ICsNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IG9uIGkuTVg2U1ggdGhlIGZvbGxvd2luZyBjb21w
YXRpYmxlcyBtdXN0IGJlIHNwZWNpZmllZA0KPiArICAgICAgICBpdGVtczoNCj4gKyAgICAgICAg
ICAtIGNvbnN0OiAiZnNsLGlteDZzeC1ncHQiDQo+ICsgICAgICAgICAgLSBjb25zdDogImZzbCxp
bXg2ZGwtZ3B0Ig0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsg
IGludGVycnVwdHM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBjbG9ja3M6DQo+ICsg
ICAgaXRlbXM6DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBTb0MgR1BUIGlwZyBjbG9jaw0KPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogU29DIEdQVCBwZXIgY2xvY2sNCj4gKyAgICBtYXhJdGVtczog
Mg0KDQptYXhJdGVtcyBpcyBub3QgbmVlZGVkDQoNCj4gKw0KPiArICBjbG9jay1uYW1lczoNCj4g
KyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6IGlwZw0KPiArICAgICAgLSBjb25zdDogcGVy
DQo+ICsgICAgbWF4SXRlbXM6IDINCg0KRGl0dG8gDQoNCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsg
IC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGludGVycnVwdHMNCj4gKyAgLSBjbG9j
a3MNCj4gKyAgLSBjbG9jay1uYW1lcw0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9jbG9jay9pbXgyNy1jbG9jay5oPg0KPiArDQo+ICsgICAgdGltZXJAMTAwMDMwMDAgew0K
PiArICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXgyNy1ncHQiLCAiZnNsLGlteDIxLWdwdCI7
DQo+ICsgICAgICAgIHJlZyA9IDwweDEwMDAzMDAwIDB4MTAwMD47DQo+ICsgICAgICAgIGludGVy
cnVwdHMgPSA8MjY+Ow0KPiArICAgICAgICBjbG9ja3MgPSA8JmNsa3MgSU1YMjdfQ0xLX0dQVDFf
SVBHX0dBVEU+LA0KPiArICAgICAgICAgICAgICAgICA8JmNsa3MgSU1YMjdfQ0xLX1BFUjFfR0FU
RT47DQo+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KPiArICAgIH07DQo+
IC0tDQo+IDIuNy40DQoNCg==
