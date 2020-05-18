Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E2B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXhry4K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgERJH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:07:59 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:38222
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERJH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oU++r14XubQkYwMuZPE9y8da2DG0KxBEKcwUYS4h6cTZIuELiIyM60/JVV6TyfGfa0qR+YbPigqSVNzx6+S65r7GeevWcGRmC/4+1EcV1L33An7EDk9vGhXrOK4tds6FNl4+df2irOJ9cn5Jza493bk+gd7bu+x63JtuWUBUaqgoJz6wWPtukcxlvpPlDc5yRdVwKpuUkQytLniypEOvJopDZbf8XqxTRRtbDrk7rzUp49GA5Dlgj7acrUMgokzyg3iXjG7vawCFwRMzkcMWDu0YJD2xTiPgT3r8FhAhP7gcqWQep3JnZvsK/y2ew986girKeq5pNZZF8dkYWqdtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yrspS6BHbGlcu6SEQQN/tejSfrrVW2kdTkJ2wGqF0s=;
 b=ZFjcRJ4OHqCw3+2pMN20ci0cxVnmmzxKqH81ZOiPldqxphLr+fGcsEutjLqqQk9Oy0jwomjeMyGRX5X+6HMGmf19CQ0HuiCnbprN/oEcXsZ5Z1gl46rpjkSn6LzO8dQ5U5OvKAriL1ez7fX/4wk+CzjFgIfmgRTalXnaBYw92yDOIMUP6dGd3BFg+QHJwkGZsV2/iypwA3pzkA1a9a2J8QmpZF7/i72p7IU93kHU+OMwZ/ytNZLhyBmUPLGvCgpsPTb9Eqg1Ctb8zib8fhBcV6n2GFLKwL7L5OySJ4mL3YLBZL1mRZZuQbhhy9hmEH8iI/Gt0hAjfRL3A1uD3i7S6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yrspS6BHbGlcu6SEQQN/tejSfrrVW2kdTkJ2wGqF0s=;
 b=kXhry4K3jaBg5AZCIucc9IAlCbBBJYJ9iA+QGKanNriSsrHj+PkXoNn1R5Lfq2Wqcuzj/FEF3lq7S1OERBJ5yMy1ZQfHvvsOB098kW9gNAsLXeOGwudUuLIaVzjjtsE+cY7WYuKkLh6AzdJ1xrc6XJ7/aq0+LuyoNPCZn/PlRLo=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5509.eurprd04.prod.outlook.com (2603:10a6:20b:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 09:07:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:07:53 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
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
Thread-Index: AQHWKAWetFMEXJN0LUKOAmAiqHSdWqitlORg
Date:   Mon, 18 May 2020 09:07:53 +0000
Message-ID: <AM6PR04MB496643088C27DB303166ED0D80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589250194-29441-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589250194-29441-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abade521-3b81-43d0-fc0e-08d7fb0af2ea
x-ms-traffictypediagnostic: AM6PR04MB5509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5509F8E2226C8605DD34DA9D80B80@AM6PR04MB5509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8IvH1LXLxUdpjmyP8Vnqf10IxFec6sLnJ++sHF80q49xZjxUTrG4XRBV2tNCKZhLSxXvsOrLsvgpGwMoQg7wmt6gdB4EKqg3S/GRl6/1961+7Ptc7XQnxZ8Xh/9cpych1P/M+U9CosgDgiDqrRv1oBv3v6sxMfIAr5XfL7WnmGPUE9OoQlE8xxa0D2hGMlWoP90CkSQ96WhqHhyKw4TkjRXwfvZTsq/Q74R5chjN1vgNCanYUU4VSnoQrilJjHjBdta1i6bS40yFQxU+9s3Alcwe1KnDZ0mN5UigOXSCJYafup+4qo3xWBmlxvxtUcTDQZTG9g2zN6cPViffE4jcEQJ04yyyzZQhnKVbktY3wKgEpvibk6SlaZYUR1ZpW7DFScLYLPqwH+iI1JqpoSYBcvrF13lGClQCzMoMjtz5Qh1rqvshKanhF6pg5tU16wv3KVttcd3aGu7P005vN4j/lMAOAyMK3mkCf6jWxBe62k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(55016002)(8936002)(8676002)(26005)(186003)(71200400001)(6506007)(9686003)(4326008)(478600001)(7696005)(316002)(110136005)(86362001)(44832011)(66476007)(33656002)(64756008)(2906002)(76116006)(66446008)(52536014)(66946007)(66556008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: h5hTpmDHEVZctztSUIeuIbj4lOQQFHnqhOe8OSKyC5UDprNnbsSuAQskX4A4mpXLKtRHRh2WPHt8iQ7hRozULXYnt3rPo1DedpEAxWmhnT+QQISNXHt2FrFKilT8CdK+njkz37Jg3Dv5bKpVp5X5BFJpm8yohdb7uCsvIMAkhH4ay1JQSZP/CqQ7Im0TSJqwfQBE9FLeTNhGwGr4jW40FdTP8Fy/S04n5BC/PJ1yLPAuA4l5cPL3jA8Ah3h+Z7C0jqZ1J7SjwVzkH2QaqdyZTNgQeTG4fwjrpamMKNgCO9uyqhPg/YgOaKP/ijSO7tgv9AlQVFmRWgaSO/TXVc1SrYi1qGoRD3YQ2AgS2Erm/TBLql0WDy5al2CoBOKdNqUA6NRZDHeK+BzOXI1jDMIsd0MA5dKvu2pN2HNzx61mrwGl2whFxa5qp3dvo8zexXAmETsYEdC6GjEZO7RdHMcehvJNR68h8CRoHwryRzed3rM3DToXrVYj1gKpyJnVUWiq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abade521-3b81-43d0-fc0e-08d7fb0af2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 09:07:53.9385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9NL1yR1c7RwbWdqAwMMRS+W6QM+7SvaxkkL8XMdfYTiNxQI/Y/ecQ1NHZLnPwX38SX7TmB3c5DL8Ad3C08KtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTWF5IDEyLCAyMDIwIDEwOjIzIEFNDQo+IA0KPiBDb252ZXJ0IHRoZSBpLk1YIHJlc2V0IGJp
bmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4dCAgICAgIHwgNDkgLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14
LXNyYy55YW1sICAgICB8IDU4DQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25zKC0pICBkZWxldGUgbW9kZSAx
MDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgt
c3JjLnR4dA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4dA0KPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy50eHQN
Cj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDZlZDc5ZTYuLjAwMDAwMDANCj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3Jj
LnR4dA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDQ5ICswLDAgQEANCj4gLUZyZWVzY2FsZSBp
Lk1YIFN5c3RlbSBSZXNldCBDb250cm9sbGVyDQo+IC09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPiAtDQo+IC1QbGVhc2UgYWxzbyByZWZlciB0byByZXNldC50eHQgaW4g
dGhpcyBkaXJlY3RvcnkgZm9yIGNvbW1vbiByZXNldCAtY29udHJvbGxlcg0KPiBiaW5kaW5nIHVz
YWdlLg0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRpYmxlOiBTaG91
bGQgYmUgImZzbCw8Y2hpcD4tc3JjIg0KPiAtLSByZWc6IHNob3VsZCBiZSByZWdpc3RlciBiYXNl
IGFuZCBsZW5ndGggYXMgZG9jdW1lbnRlZCBpbiB0aGUNCj4gLSAgZGF0YXNoZWV0DQo+IC0tIGlu
dGVycnVwdHM6IFNob3VsZCBjb250YWluIFNSQyBpbnRlcnJ1cHQgYW5kIENQVSBXRE9HIGludGVy
cnVwdCwNCj4gLSAgaW4gdGhpcyBvcmRlci4NCj4gLS0gI3Jlc2V0LWNlbGxzOiAxLCBzZWUgYmVs
b3cNCj4gLQ0KPiAtZXhhbXBsZToNCj4gLQ0KPiAtc3JjOiBzcmNAMjBkODAwMCB7DQo+IC0gICAg
ICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDZxLXNyYyI7DQo+IC0gICAgICAgIHJlZyA9IDwweDAy
MGQ4MDAwIDB4NDAwMD47DQo+IC0gICAgICAgIGludGVycnVwdHMgPSA8MCA5MSAweDA0IDAgOTYg
MHgwND47DQo+IC0gICAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4gLX07DQo+IC0NCj4gLVNw
ZWNpZnlpbmcgcmVzZXQgbGluZXMgY29ubmVjdGVkIHRvIElQIG1vZHVsZXMNCj4gLT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLQ0KPiAtVGhlIHN5c3Rl
bSByZXNldCBjb250cm9sbGVyIGNhbiBiZSB1c2VkIHRvIHJlc2V0IHRoZSBHUFUsIFZQVSwgLUlQ
VSwgYW5kDQo+IE9wZW5WRyBJUCBtb2R1bGVzIG9uIGkuTVg1IGFuZCBpLk1YNiBJQ3MuIFRob3Nl
IGRldmljZSAtbm9kZXMgc2hvdWxkDQo+IHNwZWNpZnkgdGhlIHJlc2V0IGxpbmUgb24gdGhlIFNS
QyBpbiB0aGVpciByZXNldHMgLXByb3BlcnR5LCBjb250YWluaW5nIGEgcGhhbmRsZQ0KPiB0byB0
aGUgU1JDIGRldmljZSBub2RlIGFuZCBhIC1SRVNFVF9JTkRFWCBzcGVjaWZ5aW5nIHdoaWNoIG1v
ZHVsZSB0byByZXNldCwNCj4gYXMgZGVzY3JpYmVkIGluIC1yZXNldC50eHQNCj4gLQ0KPiAtZXhh
bXBsZToNCj4gLQ0KPiAtICAgICAgICBpcHUxOiBpcHVAMjQwMDAwMCB7DQo+IC0gICAgICAgICAg
ICAgICAgcmVzZXRzID0gPCZzcmMgMj47DQo+IC0gICAgICAgIH07DQo+IC0gICAgICAgIGlwdTI6
IGlwdUAyODAwMDAwIHsNCj4gLSAgICAgICAgICAgICAgICByZXNldHMgPSA8JnNyYyA0PjsNCj4g
LSAgICAgICAgfTsNCj4gLQ0KPiAtVGhlIGZvbGxvd2luZyBSRVNFVF9JTkRFWCB2YWx1ZXMgYXJl
IHZhbGlkIGZvciBpLk1YNToNCj4gLUdQVV9SRVNFVCAgICAgMA0KPiAtVlBVX1JFU0VUICAgICAx
DQo+IC1JUFUxX1JFU0VUICAgIDINCj4gLU9QRU5fVkdfUkVTRVQgMw0KPiAtVGhlIGZvbGxvd2lu
ZyBhZGRpdGlvbmFsIFJFU0VUX0lOREVYIHZhbHVlIGlzIHZhbGlkIGZvciBpLk1YNjoNCj4gLUlQ
VTJfUkVTRVQgICAgNA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwLi4yNzZhNTMzDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnlhbWwNCj4g
QEAgLTAsMCArMSw1OCBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiArLS0tDQo+ICt0aXRsZTogRnJlZXNj
YWxlIGkuTVggU3lzdGVtIFJlc2V0IENvbnRyb2xsZXINCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+
ICsgIC0gUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gKw0KPiArZGVz
Y3JpcHRpb246IHwNCj4gKyAgVGhlIHN5c3RlbSByZXNldCBjb250cm9sbGVyIGNhbiBiZSB1c2Vk
IHRvIHJlc2V0IHRoZSBHUFUsIFZQVSwNCj4gKyAgSVBVLCBhbmQgT3BlblZHIElQIG1vZHVsZXMg
b24gaS5NWDUgYW5kIGkuTVg2IElDcy4gVGhvc2UgZGV2aWNlDQo+ICsgIG5vZGVzIHNob3VsZCBz
cGVjaWZ5IHRoZSByZXNldCBsaW5lIG9uIHRoZSBTUkMgaW4gdGhlaXIgcmVzZXRzDQo+ICsgIHBy
b3BlcnR5LCBjb250YWluaW5nIGEgcGhhbmRsZSB0byB0aGUgU1JDIGRldmljZSBub2RlIGFuZCBh
DQo+ICsgIFJFU0VUX0lOREVYIHNwZWNpZnlpbmcgd2hpY2ggbW9kdWxlIHRvIHJlc2V0LCBhcyBk
ZXNjcmliZWQgaW4NCj4gKyAgcmVzZXQudHh0DQo+ICsNCj4gKyAgVGhlIGZvbGxvd2luZyBSRVNF
VF9JTkRFWCB2YWx1ZXMgYXJlIHZhbGlkIGZvciBpLk1YNToNCj4gKyAgICBHUFVfUkVTRVQgICAg
IDANCj4gKyAgICBWUFVfUkVTRVQgICAgIDENCj4gKyAgICBJUFUxX1JFU0VUICAgIDINCj4gKyAg
ICBPUEVOX1ZHX1JFU0VUIDMNCj4gKyAgVGhlIGZvbGxvd2luZyBhZGRpdGlvbmFsIFJFU0VUX0lO
REVYIHZhbHVlIGlzIHZhbGlkIGZvciBpLk1YNjoNCj4gKyAgICBJUFUyX1JFU0VUICAgIDQNCj4g
Kw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBpdGVtczoNCj4gKyAg
ICAgIC0gY29uc3Q6ICJmc2wsaW14NTEtc3JjIg0KDQpXaGF0IGFib3V0IG14Nj8NCg0KPiArDQo+
ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQoNCk5l
ZWQgZGVzY3JpcHRpb24gaGVyZQ0KDQo+ICsgICAgbWluSXRlbXM6IDENCj4gKyAgICBtYXhJdGVt
czogMg0KPiArDQo+ICsgICcjcmVzZXQtY2VsbHMnOg0KPiArICAgIGNvbnN0OiAxDQo+ICsNCj4g
K3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSByZWcNCj4gKyAgLSBpbnRlcnJ1
cHRzDQo+ICsgIC0gJyNyZXNldC1jZWxscycNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICBzcmNANzNmZDAwMDAg
ew0KDQpzL3NyYy9yZXNldC1jb250cm9sbGVyDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiArICAg
ICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg1MS1zcmMiOw0KPiArICAgICAgICByZWcgPSA8MHg3
M2ZkMDAwMCAweDQwMDA+Ow0KPiArICAgICAgICBpbnRlcnJ1cHRzID0gPDc1PjsNCj4gKyAgICAg
ICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArICAgIH07DQo+IC0tDQo+IDIuNy40DQoNCg==
