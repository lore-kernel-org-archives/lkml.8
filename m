Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A09C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E63217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jy17ehUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPLle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:41:34 -0500
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:2498
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbgAPLle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:41:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDC6o+ecfcG3EA05Muid8ikkaYdj59fImLz8GFCmHlKslTGVYf7F4KW24bdrlaQ3AnR2TB1Dptx9C5hpwj8EkWUlPF8bwXUL2rFE0dk12hks180hmFZj3S6PhvHYRIETY/L/yAHBYemIHHz445pi1bSejrBoLj86IsfRXENmXp2RwJ24ntCOjnaDER1SxaSmnRxEBibkXQUFDH28oCE30KcZNCSkRjwr06t/u8uqaf2gJjaLC9dcvb0V9kYZwGkU/sFhMAcapkIHlkX8ny2G3oLo7IwOu+fS2j1b4ZYvCBE+bcEZGNts7ABpWLM8wf3pd6GJIUzLIxL+ppZpVHd8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKup4/XUMY8qX58+CZySttIZaRAxOxZVoNjXFr4HkYM=;
 b=E/GDHHziwMenKKYY5PR8iDLLlnXZCDYjq15QaJvArjv728wQJflE+zLr9PVPAX1krLWD8cUaOFcuf8WLJqlQde0AqTVKRTWh5r02tmvgis+fktE4yzAXMr9thB0TdVOv59JSJiNdZZFHPveB/SOwEdCS4yx7rSbtd4sF0YAwhlQRtupz/h3APaziwlCzb/LviYCPsXqr79yseJKVpF5ElKgDHv3wAuBD9dKQts3xG63T9GL7cuvcjXfj4qvJugU15v/P/llYw0qP+cUfHcMET+Leo0BsKsYi8fsP7cBwabpSMvad4TIXVVXGAMNHvHfohkLR4OFS0fCDHSTkzhf2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKup4/XUMY8qX58+CZySttIZaRAxOxZVoNjXFr4HkYM=;
 b=jy17ehUkCr0gnBD3NeNQGq0Cfwl3rnye/URvHDWO5/gcw7+gmBI4RF8079K/nXyYC95iIIQarEVFJDHzk47psE9dIn2l8DrzvPEoZoC4M6CHUsZs5/bf+YvGA+LB5J7kTuZOTnlsuAYysYvc8Ejn+Ei+i7osyobMSO0kmZ35mXo=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB5462.namprd02.prod.outlook.com (20.177.229.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 11:41:28 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::f964:6ae7:834b:8fa7]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::f964:6ae7:834b:8fa7%5]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 11:41:28 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "m.tretter@pengutronix.de" <m.tretter@pengutronix.de>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 0/6] clk: zynqmp: Extend and fix zynqmp clock driver
Thread-Topic: [PATCH v3 0/6] clk: zynqmp: Extend and fix zynqmp clock driver
Thread-Index: AQHVqzaKZfjuMgYuu0e5sIMWLWz5cqe2qOMAgDbD6rA=
Date:   Thu, 16 Jan 2020 11:41:27 +0000
Message-ID: <BYAPR02MB405593B79AB01004F0BB9101B7360@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
 <19c5f918-7e00-75e4-10d1-53f0a30748b2@xilinx.com>
In-Reply-To: <19c5f918-7e00-75e4-10d1-53f0a30748b2@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [14.142.15.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 090fb488-c584-4c6a-bf1c-08d79a79061b
x-ms-traffictypediagnostic: BYAPR02MB5462:|BYAPR02MB5462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5462D09D86D2F091F766E164B7360@BYAPR02MB5462.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(66476007)(86362001)(8936002)(66946007)(33656002)(64756008)(52536014)(55016002)(76116006)(7696005)(66446008)(2906002)(478600001)(66556008)(7416002)(4326008)(6506007)(55236004)(54906003)(8676002)(26005)(110136005)(81166006)(316002)(186003)(53546011)(81156014)(9686003)(71200400001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5462;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGTMoTl5P4oXHqIvzz+N45d+gcNjCSN+sgYDN7NAMI1uHYTafGeqSdbTjH1gnhJnORv9zOak2FzYMOZsWA9wmPSp3y1lVO1T8E7UvczhmL1lQpWyUOcHceMxWj0cu6s+d9ICDTpClw4Wpm3dXY1Rv8NA7/X1AwVCyMjlvz8h96oIZSw/TU/J4nBSiiA0zsWCqnxuAF7hZchSJnTi51KQbQ3CQjhuFcii9EnBwX3YbM27rtA3q3MgoiM/INA6kGBagLswkThafm571SVUg8LoSwPwlouqyXpfiUkpiwdvufeWu3xVBa5taDh8z1cD3ixwgCzYJ1pzHsezlznnVEqndceWztWnBQKY37UQoUjigqL2aHrMPebGLEy9MvpaZ4QqXLAHfv2gLShRPcUPbf8tTSnY4hu2jdtp0+eYBWKIwXD3bZWGYUWBdT55cCyibeUpzJFKay7BeUHW93a9iYErMvcx5un0aRnKsDKAKru1orV5pgSyX17MpDQTnvVvaMJM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090fb488-c584-4c6a-bf1c-08d79a79061b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 11:41:27.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpvNucDhAeCtij91AgK9dbSKS9Zg5LpDkGM7LAF+1/5Dbb3Q7EY6guvWdbJm0v8RP/i1YzUQvxjxcUJ96LrnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KQ291bGQgcGxlYXNlIGxldCB1cyBrbm93IGlmIHlvdSBoYXZlIGNvbW1l
bnQgb24gdGhpcyBwYXRjaCBzZXJpZXM/DQoNClRoYW5rcywNClJhamFuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGls
aW54LmNvbT4NCj4gU2VudDogMTIgRGVjZW1iZXIgMjAxOSAwODo1MCBQTQ0KPiBUbzogUmFqYW4g
VmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2Jv
eWRAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
TWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBKb2xseSBTaGFoIDxKT0xMWVNA
eGlsaW54LmNvbT47DQo+IG0udHJldHRlckBwZW5ndXRyb25peC5kZTsgZ3VzdGF2b0BlbWJlZGRl
ZG9yLmNvbTsgVGVqYXMgUGF0ZWwNCj4gPFRFSkFTUEB4aWxpbnguY29tPjsgTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhbUB4aWxpbnguY29tPjsgbWRmQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWNs
a0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBjbGs6IHp5bnFtcDogRXh0ZW5kIGFu
ZCBmaXggenlucW1wIGNsb2NrIGRyaXZlcg0KPiANCj4gT24gMDUuIDEyLiAxOSA3OjM1LCBSYWph
biBWYWphIHdyb3RlOg0KPiA+IFp5bnFNUCBjbG9jayBkcml2ZXIgY2FuIGJlIHVzZWQgZm9yIFZl
cnNhbCBwbGF0Zm9ybSBhbHNvLiBBZGQgc3VwcG9ydA0KPiA+IGZvciBWZXJzYWwgcGxhdGZvcm0g
aW4gWnlucU1QIGNsb2NrIGRyaXZlci4NCj4gPg0KPiA+IEFsc28gdGhpcyBwYXRjaCBzZXJpZXMg
Zml4ZXMgZGl2aWRlciBjYWxjdWxhdGlvbiBhbmQgYWRkcyBzdXBwb3J0IGZvciBnZXQNCj4gPiBt
YXhpbXVtIGRpdmlkZXIsIGNsb2NrIHdpdGggQ0xLX0RJVklERVJfUE9XRVJfT0ZfVFdPIGZsYWcg
YW5kIHdhcm4gdXNlcg0KPiBpZg0KPiA+IGNsb2NrIHVzZXJzIGFyZSBtb3JlIHRoYW4gYWxsb3dl
ZC4NCj4gPg0KPiA+IFJhamFuIFZhamEgKDUpOg0KPiA+ICAgZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgYmluZGluZ3MgZm9yIHZlcnNhbCBjbG9jayBkcml2ZXINCj4gPiAgIGNsazogenlucW1wOiBF
eHRlbmQgZHJpdmVyIGZvciB2ZXJzYWwNCj4gPiAgIGNsazogenlucW1wOiBXYXJuIHVzZXIgaWYg
Y2xvY2sgdXNlciBhcmUgbW9yZSB0aGFuIGFsbG93ZWQNCj4gPiAgIGNsazogenlucW1wOiBBZGQg
c3VwcG9ydCBmb3IgZ2V0IG1heCBkaXZpZGVyDQo+ID4gICBjbGs6IHp5bnFtcDogRml4IGRpdmlk
ZXIgY2FsY3VsYXRpb24NCj4gPg0KPiA+IFRlamFzIFBhdGVsICgxKToNCj4gPiAgIGNsazogenlu
cW1wOiBBZGQgc3VwcG9ydCBmb3IgY2xvY2sgd2l0aCBDTEtfRElWSURFUl9QT1dFUl9PRl9UV08g
ZmxhZw0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3hsbngsdmVyc2Fs
LWNsay55YW1sIHwgIDY0ICsrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvY2xrL3p5bnFtcC9jbGtj
LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICstDQo+ID4gIGRyaXZlcnMvY2xrL3p5
bnFtcC9kaXZpZGVyLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMTE4ICsrKysrKysrKysrKysr
KysrKystDQo+ID4gIGRyaXZlcnMvY2xrL3p5bnFtcC9wbGwuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA2ICstDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICAg
ICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay94
bG54LXZlcnNhbC1jbGsuaCAgICAgICAgfCAxMjMgKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IGluY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaCAgICAgICAgICAgICAgIHwgICAy
ICsNCj4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAzMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jbG9jay94bG54LHZlcnNhbC0NCj4gY2xrLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sveGxueC12ZXJzYWwtY2xrLmgNCj4gPg0KPiAN
Cj4gVGhhdCBmaXJtd2FyZSBjaGFuZ2VzIGxvb2tzIGdvb2QuIFRoYXQncyB3aHkgZmVlbCBmcmVl
IHRvIGFkZCBteQ0KPiBBY2tlZC1ieTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54
LmNvbT4NCj4gdG8gdGhhdCBwYXRjaGVzLg0KPiBJZiB5b3Ugd2FudCBtZSB0byB0YWtlIGl0IHZp
YSBteSB0cmVlIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQo=
