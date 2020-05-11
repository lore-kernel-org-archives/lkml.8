Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B185C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41ADA20735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xn1SEQKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgEKLaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:30:09 -0400
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:35097
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729763AbgEKL35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrB7az6Se4vnY1hDos44bcWB4DUlXJhzFzavv5rRkrLW6NSJ6ByvW3UybqyhXpWq+cMP58F0muKWFZNmD1k7ZRVoRPwPXL45PH2/dLA0V7DYUnt4KREhjhqWAuD2j2JqWwqrphkCqVgLBFXsUnhT+l60DUX/z0TDin5t3mKBYGjPyR7NN1KZC1Wblj5B1dgxKNmUr+KyFl4geRF++M9OTxCM3DcjzDeMS5RdfNAQObgq07CT2FowG/l3UVo3zcR8djqBPoNLmIMULZwfu17ksD0EYeolShqXoS77wDhMhun9oepRcUkf6m61i4s4FjgT4tAR4/prg+ww9H+hjbopYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObWcEOpEpFfJVPvHgm43Z5lZ0yWMZH7Kj09ih2sUlqQ=;
 b=IDBG96fDVjQZ1NGxR1M8jeiaCR3Ujq0EmXr/QAy0pp+Edby54+DncpPnHqM0MlTMJd+1E8goS4MNxhaC49GdcIFF9iEcdx0pGb4hFMVPGyJ3W6CleKkY5XA8cMbBJ7PnToqSGlYTj08TrHzi/DRJm2/p4Ff+F9VhYJ9IhnPJ5ri1ULj6UHksVP4Tg0sE7BJ/68MGG2d29mxX12hcrJhJlbPC8MLK5LsDVhOaBCP5oHTGbzUoUt2J2Fghl2uzUgp9B82Xv6OxnHg89/wzVqtZYHPZamVZGelzJTwATvSriEFEPgKSXu4cw29jB6nIvclffF5tqq6LZLEb/Luz3fZpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObWcEOpEpFfJVPvHgm43Z5lZ0yWMZH7Kj09ih2sUlqQ=;
 b=Xn1SEQKb1oeEJdB7xERLdkIW1EySQMDwhZpiIxp2fMOJpmXeXmoqPJbj47IyKXM00+f5jyptaFu83jzJN8OrMcSftGGpnRqDSqTeqTHqKkIGfoXme9P0nvLPxlIL8U//e+W4Ovpov/2pimrD3NzSfNDxPogPsH6krIwuz/cx+Ps=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10) by AM6PR0402MB3320.eurprd04.prod.outlook.com
 (2603:10a6:209:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Mon, 11 May
 2020 11:29:52 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::a5f9:57c:97d3:491f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::a5f9:57c:97d3:491f%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 11:29:52 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Subject: RE: [PATCH] dt-bindings: reset: Convert i.MX7 reset to json-schema
Thread-Topic: [PATCH] dt-bindings: reset: Convert i.MX7 reset to json-schema
Thread-Index: AQHWJds0OPSvvSW4KEe8q/kgqrzEB6iiv38AgAADi5A=
Date:   Mon, 11 May 2020 11:29:51 +0000
Message-ID: <AM6PR0402MB3911ED577118BB1A0B12E3FFF5A10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1589012077-12088-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966E5E547A29199B84936A180A10@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966E5E547A29199B84936A180A10@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be39db33-fe36-404c-4006-08d7f59e9f43
x-ms-traffictypediagnostic: AM6PR0402MB3320:|AM6PR0402MB3320:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB332048A2B623866A8D4C164CF5A10@AM6PR0402MB3320.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYB+wtYYdCwsSvxypFWVqeNLvXQSYwpzevM27Gg5UN03woSc6OcvR3ZctX4sR5lnsw4BfFUx+hgT129ULu2qvA0K8dvOEQLVIPsh8JWWNH+aB4nzO6lPnW+Q3pJLqsxxIB/UAU43i9ghBHmfvnGhZp1XLGhZUtxGsJ9QMuAqpHxuFvV225YWZ44oh0BwEEm9f34BMr8ic4mF9h0dgfvioxdgdYlruL7cZLGeo9oDJLZ2SoRPm56pgLJ/eMbMpMQ8EFac0Z6mvR2Ay431Bxrwqexw0I12je8x82dTnNJrmuSlXvQdw/i7gLgI2Hc68gIALBhCiesDz8Ty5jlaigGMWrRgEgn33M8fvGfcndq8JvuntnlxlQ6HAizFfTH9NndbrrZl90v7OJzC4wnzDiDvO6Wai8JDxVUhnwbO/UjxYzra6TViNVuIpEyifw7qSZGpnzB7/CBtpUjManL7DxjafWyZDWGJv+6EOUodo4PMvHIE6tpUPF1+LIOnljPpYIyZDwz+258qA+8TI9eZWOl4viXfJXUUu6MmMn1TQOYkNxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(33430700001)(478600001)(86362001)(44832011)(33440700001)(186003)(26005)(110136005)(6506007)(2906002)(316002)(66476007)(66556008)(64756008)(66446008)(8676002)(52536014)(5660300002)(66946007)(33656002)(8936002)(76116006)(4326008)(7696005)(9686003)(55016002)(71200400001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: E03Wi1iyO2PB4lkv+3nKoaQSN7q8BMSVoOe89Lr3TFkQ3L0rvmojv/PpdpKPVYU79CBGIv4pU6zlfzeIVTfrpxnWNjlmNYx1zH+iEBLxG8nmqpgbSPRH+4qKzlbZkuMX+pQ5Lul0lc9NVp0DHtoVKCTQH1Ez5sM+Kv7BHl23kH+dbgxCKqSAobg7Rid4tufrAtiTjd0VQi96++3YUZi4KgNO98mymKcFH4DC7vPXDYdAwpkxowcscrIB+SfKnvulXmicer0y8JEOua9Zv/XTXV3gWJCj+QMoU5R0n2W0/iWXwcv6yIUjoKQd7SwKW7RKQyi6wYoAUSaAjMpZ0ctntRod6eKpQjPVkcKW7I1mDU2Zk0G/3lcb/0wzZdu/O3oBABXRDtiL4tb2HKu379EEtaqSYmVParyvC6yr4IbLPlzcFCpcC/ti+5lwspkCviE9EeKzIFgjZjYF5K+CCqQdJRTGNymQ0GyJf9ciEQQCYLs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be39db33-fe36-404c-4006-08d7f59e9f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 11:29:52.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pd5HphrPJQcB420keX35oDsRZix6VaVA2SVS5nFeMrNMcawxK4Av6myvJpvv62NnRtn/3wW9Qpq2CzKwG/PT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IHJlc2V0OiBDb252ZXJ0IGku
TVg3IHJlc2V0IHRvIGpzb24tc2NoZW1hDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArDQo+ID4gK21h
aW50YWluZXJzOg0KPiA+ICsgIC0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIFRoZSBzeXN0ZW0gcmVzZXQgY29udHJv
bGxlciBjYW4gYmUgdXNlZCB0byByZXNldCB2YXJpb3VzIHNldCBvZg0KPiA+ICsgIHBlcmlwaGVy
YWxzLiBEZXZpY2Ugbm9kZXMgdGhhdCBuZWVkIGFjY2VzcyB0byByZXNldCBsaW5lcyBzaG91bGQN
Cj4gPiArICBzcGVjaWZ5IHRoZW0gYXMgYSByZXNldCBwaGFuZGxlIGluIHRoZWlyIGNvcnJlc3Bv
bmRpbmcgbm9kZSBhcw0KPiA+ICsgIHNwZWNpZmllZCBpbiByZXNldC50eHQuDQo+ID4gKw0KPiA+
ICsgIEZvciBsaXN0IG9mIGFsbCB2YWxpZCByZXNldCBpbmRpY2VzIHNlZQ0KPiA+ICsgICAgPGR0
LWJpbmRpbmdzL3Jlc2V0L2lteDctcmVzZXQuaD4gZm9yIGkuTVg3LA0KPiA+ICsgICAgPGR0LWJp
bmRpbmdzL3Jlc2V0L2lteDhtcS1yZXNldC5oPiBmb3IgaS5NWDhNUSBhbmQNCj4gPiArICAgIDxk
dC1iaW5kaW5ncy9yZXNldC9pbXg4bXEtcmVzZXQuaD4gZm9yIGkuTVg4TU0gYW5kDQo+ID4gKyAg
ICA8ZHQtYmluZGluZ3MvcmVzZXQvaW14OG1xLXJlc2V0Lmg+IGZvciBpLk1YOE1OIGFuZA0KPiAN
Cj4gSG93IGFib3V0IGNvbWJpbmUgYWJvdmUgdGhyZWUgaXRlbXM/DQoNCldpbGwgZG8uDQoNCj4g
DQo+ID4gKyAgICA8ZHQtYmluZGluZ3MvcmVzZXQvaW14OG1wLXJlc2V0Lmg+IGZvciBpLk1YOE1Q
DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBp
dGVtczoNCj4gPiArICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgIC0gZnNsLGlteDdkLXNyYw0K
PiA+ICsgICAgICAgIC0gZnNsLGlteDhtcS1zcmMNCj4gPiArICAgICAgICAtIGZzbCxpbXg4bW0t
c3JjDQo+ID4gKyAgICAgICAgLSBmc2wsaW14OG1uLXNyYw0KPiA+ICsgICAgICAgIC0gZnNsLGlt
eDhtcC1zcmMNCj4gPiArICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4gKw0KPiA+ICsgIHJlZzoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAnI3Jlc2V0LWNlbGxzJzoNCj4gPiArICAgIGNv
bnN0OiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiAr
ICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsgIC0gJyNyZXNldC1jZWxscycNCj4g
PiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBs
ZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0
LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsNCj4gPiArICAgIHJlc2V0LWNvbnRyb2xsZXJA
MzAzOTAwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDdkLXNyYyIsICJz
eXNjb24iOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDMwMzkwMDAwIDB4MjAwMD47DQo+ID4gKyAg
ICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg5IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+
ICsgICAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsu
Li4NCj4gDQo+IElzIHRoaXMgcmVxdWlyZWQ/DQoNCkl0IGNhbiBiZSByZW1vdmVkLCB3aWxsIHJl
bW92ZSBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCkFuc29uDQo=
