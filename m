Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79844C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC41207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kH6ASc1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGWX7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:59:49 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:64628
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbgGWX7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:59:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em1sslBKnepiklYIeKfhgKgS4CtkWDIPgOoiROQhj8EIH9wfSAK8nTXojME/Y+3fCIyajCYxgxqv1IHCHKb3A5YOsO5E2M3n9Qg+WzTl8ztFHB8gtwiGykFR+EwwMfLhba237ogfkDc4OyanneoXuKOcapf4TYL0jKgXwyiGCIj3iu+gMsE7YPcFWTlsiui0rx75EAqnrq0PNraQmvIMXoyoFpiS9abVD7J4sS1aoUvjQTf17RserHzVloH4Rc83sjiQkT53igbewRKqQuzxN4JNaKWIZqB4bFlQqS2pl+SB0fEIONOUFkD9p8IodfgaaEAdy81xTr7YuOwgdLN5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH1Z5VmGvMB0oN6HaQYz4zs5yQnKNTAmVjcyw97en5E=;
 b=F/S1REmyQlhy8FrBwPIevrEFFa8qFXlHhSVS0OF6Cu5RcxbYe+im6V/+4uvnpPBl0Obw/Y8ApeKkScZNWkLH9ySOpcTlqiRevOpWLTXRXxz5uwt+V6U4V+c+DDdYO8mrQUxONAcLy/j0W2MeZOTtWe6+CJ4MWddo1eOa5l+LARLxyJBNdpBWTax1kHZ6/y2olrAsEgL7ZG4Mbn5k5JhLfaPjt1OGMrwIDabmQ3CctgRPMWFDeCwR9YR5C0RDZbO32sjU2LssKdiR+S9s0HQ2U6bLUOvnO8Ji776W9l6vv+i9qr15Lat9wMkQF+Ye0+ignghCPtWGRq5y/o8Og75qPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH1Z5VmGvMB0oN6HaQYz4zs5yQnKNTAmVjcyw97en5E=;
 b=kH6ASc1BG5PEbHL1lr9FZFEvDRYCPeEh1QsnhULaEmqgMMPTQXMDyZ+HB4yHG3yhSRJ3ywhwI40DttxBN0tax0RQJL7LTujQwXs3j/GHjgO3gSpo1ANm5EX+VsA8HXOiMug1e8yNGVKHwEVqH0NqKiQ0chYMX0uArZEgNS7mg2g=
Received: from BYAPR02MB5622.namprd02.prod.outlook.com (2603:10b6:a03:9b::32)
 by BYAPR02MB5207.namprd02.prod.outlook.com (2603:10b6:a03:69::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 23:59:44 +0000
Received: from BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::9d9e:6608:a5e1:3f8b]) by BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::9d9e:6608:a5e1:3f8b%5]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 23:59:44 +0000
From:   Amit Sunil Dhamne <amitsuni@xilinx.com>
To:     Michael Tretter <m.tretter@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>, Tejas Patel <TEJASP@xilinx.com>
Subject: RE: [PATCH v2 2/3] clk: zynqmp: Use firmware specific divider clock
 flags
Thread-Topic: [PATCH v2 2/3] clk: zynqmp: Use firmware specific divider clock
 flags
Thread-Index: AQHWX/UegERsBTjj+UCuJ9YhF7c866kTl64AgAI/aqA=
Date:   Thu, 23 Jul 2020 23:59:43 +0000
Message-ID: <BYAPR02MB5622F9742DED5D3E4FF893B3A7760@BYAPR02MB5622.namprd02.prod.outlook.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1595400932-303612-3-git-send-email-amit.sunil.dhamne@xilinx.com>
 <20200722132708.GD21264@pengutronix.de>
In-Reply-To: <20200722132708.GD21264@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a538ffa-2176-40bc-6827-08d82f6478b9
x-ms-traffictypediagnostic: BYAPR02MB5207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5207F14493B4D8C3C5E09D1CA7760@BYAPR02MB5207.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQTRv1OITXcG7+tRZ5w0/xcSJeWkmURLPCTbfgiKVa39geSo6pfhs0a8D8ByuLgA4YxIJdluy4bX2vf26rNYQwPk8fiBBvVHE9UOU8IIEutBq1Sn3AadiSOFpcdkUXxwVg8Bchw+SUU71yrn2G4xaEeuzh/6DCfJiriGJd96ChvCp8TJMkdRrmNq9jluRBEibE1CqwZtZ80bwj/5QZH8O9DlHQkiIzu5Ah6d/M7QuU/DowAMxWNEg+t75+sdTWNvUcLTFiAyMUOTvtnbPb/SoQIkOHucFY7V9ggpVxrPUvSXXS2PkL/PW2q5EOoRcDkWxbi9Nv0KhfqJZYSFo4Ft5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5622.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(66556008)(66476007)(64756008)(5660300002)(66446008)(66946007)(478600001)(83380400001)(107886003)(76116006)(71200400001)(7696005)(55016002)(9686003)(86362001)(6916009)(8676002)(186003)(8936002)(316002)(2906002)(6506007)(53546011)(33656002)(54906003)(4326008)(52536014)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oPO5gRCYsEFdf6VSCFcPe1YYFhNK2ai1yFKb3NOQF4U9a2vYiaaNYb8VZhTTUwG5k7r3VCf6Uzuf1L4hyRcB6krz0mV1i6usngTpSHfOdyKBzUinIoSdLDY9wh7LudPJqyMa6VBRm7S4DAZ5Z5ZRHhRllzyxQkbl+PdsVf0ijz47hlr/VfaMOy66tcR87tC6L/zu3syEoaDfeF8bD1xANLG98YSRLqatqra5L8B0aM4ePJBJX8VOeECzKhIVl3zGwrDn9aWXaEeO3pRKmTxZt4eoYO4UcF2ePX6YnkYmz9EA/48PlonaiwP5pDm+BZFO6rGfI4Xn+ek08D3p+Nw7HOmqc7DG67ftEy+G+xwLc0TSsoQ/81vvwL7LYVhuE0mg3dpByxfdH/oLQHjb6c2t/g5toAaI/GtHNeiJbLEqaEbBt65pTd9Bj9gV7Qc+Xm0aGKrMvOMScdU8ohstIJu+UiKZ83+23GUOMaMKug5fg28Rb4OmkufrbfvFszx5Dm91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a538ffa-2176-40bc-6827-08d82f6478b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 23:59:43.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgAWMggYhCL99/ekMA3oAUoLihV5H5wceD9G093flGJzklvaU3dugJNohEGDEvyCB6sycTOaTU2cKNKEjl0IUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCwNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gV2lsbCBwdXNoIHRoZSBGbGFnIGNv
bnZlcnNpb24gdG8gYSBuZXcgZnVuY3Rpb24uDQoNClRoYW5rcywNCkFtaXQNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFRyZXR0ZXIgPG0udHJldHRlckBw
ZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIyLCAyMDIwIDY6MjcgQU0N
Cj4gVG86IEFtaXQgU3VuaWwgRGhhbW5lIDxhbWl0c3VuaUB4aWxpbnguY29tPg0KPiBDYzogbXR1
cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lkQGNvZGVhdXJvcmEub3JnOyBzYm95ZEBrZXJuZWwu
b3JnOw0KPiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IG1hcmsucnV0bGFuZEBh
cm0uY29tOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgUmFqYW4gVmFqYSA8UkFKQU5W
QHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT47IFRlamFzIFBh
dGVsIDxURUpBU1BAeGlsaW54LmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhamFuIFZhamENCj4gPFJB
SkFOVkB4aWxpbnguY29tPjsgVGVqYXMgUGF0ZWwgPFRFSkFTUEB4aWxpbnguY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDIvM10gY2xrOiB6eW5xbXA6IFVzZSBmaXJtd2FyZSBzcGVjaWZp
YyBkaXZpZGVyIGNsb2NrDQo+IGZsYWdzDQo+IA0KPiBPbiBUdWUsIDIxIEp1bCAyMDIwIDIzOjU1
OjMxIC0wNzAwLCBBbWl0IFN1bmlsIERoYW1uZSB3cm90ZToNCj4gPiBGcm9tOiBSYWphbiBWYWph
IDxyYWphbi52YWphQHhpbGlueC5jb20+DQo+ID4NCj4gPiBVc2UgWnlucU1QIHNwZWNpZmljIGRp
dmlkZXIgY2xvY2sgZmxhZ3MgaW5zdGVhZCBvZiB1c2luZyBDQ0YgZmxhZ3MuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSYWphbiBWYWphIDxyYWphbi52YWphQHhpbGlueC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogVGVqYXMgUGF0ZWwgPHRlamFzLnBhdGVsQHhpbGlueC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQW1pdCBTdW5pbCBEaGFtbmUgPGFtaXQuc3VuaWwuZGhhbW5lQHhpbGlueC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL3p5bnFtcC9jbGstenlucW1wLmggfCAgOSAr
KysrKysrKysNCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL2RpdmlkZXIuYyAgICB8IDE2ICsrKysr
KysrKysrKysrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvenlucW1wL2Nsay16
eW5xbXAuaA0KPiA+IGIvZHJpdmVycy9jbGsvenlucW1wL2Nsay16eW5xbXAuaCBpbmRleCAzY2I2
MTQ5Li5lYzMzNTI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGstenlu
cW1wLmgNCj4gPiArKysgYi9kcml2ZXJzL2Nsay96eW5xbXAvY2xrLXp5bnFtcC5oDQo+ID4gQEAg
LTMyLDYgKzMyLDE1IEBADQo+ID4gIC8qIGRvIG5vdCBnYXRlLCBldmVyICovDQo+ID4gICNkZWZp
bmUgWllOUU1QX0NMS19JU19DUklUSUNBTCAgICAgICAgIEJJVCgxMSkNCj4gPg0KPiA+ICsvKiBU
eXBlIEZsYWdzIGZvciBkaXZpZGVyIGNsb2NrICovDQo+ID4gKyNkZWZpbmUgWllOUU1QX0NMS19E
SVZJREVSX09ORV9CQVNFRCAgICAgICAgICAgQklUKDApDQo+ID4gKyNkZWZpbmUgWllOUU1QX0NM
S19ESVZJREVSX1BPV0VSX09GX1RXTyAgICAgICAgICAgICAgICBCSVQoMSkNCj4gPiArI2RlZmlu
ZSBaWU5RTVBfQ0xLX0RJVklERVJfQUxMT1dfWkVSTyAgICAgICAgICBCSVQoMikNCj4gPiArI2Rl
ZmluZSBaWU5RTVBfQ0xLX0RJVklERVJfSElXT1JEX01BU0sgICAgICAgICBCSVQoMykNCj4gPiAr
I2RlZmluZSBaWU5RTVBfQ0xLX0RJVklERVJfUk9VTkRfQ0xPU0VTVCAgICAgICBCSVQoNCkNCj4g
PiArI2RlZmluZSBaWU5RTVBfQ0xLX0RJVklERVJfUkVBRF9PTkxZICAgICAgICAgICBCSVQoNSkN
Cj4gPiArI2RlZmluZSBaWU5RTVBfQ0xLX0RJVklERVJfTUFYX0FUX1pFUk8gICAgICAgICBCSVQo
NikNCj4gPiArDQo+ID4gIGVudW0gdG9wb2xvZ3lfdHlwZSB7DQo+ID4gICAgICAgICBUWVBFX0lO
VkFMSUQsDQo+ID4gICAgICAgICBUWVBFX01VWCwNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvenlucW1wL2RpdmlkZXIuYw0KPiA+IGIvZHJpdmVycy9jbGsvenlucW1wL2RpdmlkZXIuYyBp
bmRleCAzYWI1N2Q5Li44NmNiNzg1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3p5bnFt
cC9kaXZpZGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay96eW5xbXAvZGl2aWRlci5jDQo+ID4g
QEAgLTMyMCw3ICszMjAsMjEgQEAgc3RydWN0IGNsa19odyAqenlucW1wX2Nsa19yZWdpc3Rlcl9k
aXZpZGVyKGNvbnN0DQo+IGNoYXIgKm5hbWUsDQo+ID4gICAgICAgICAvKiBzdHJ1Y3QgY2xrX2Rp
dmlkZXIgYXNzaWdubWVudHMgKi8NCj4gPiAgICAgICAgIGRpdi0+aXNfZnJhYyA9ICEhKChub2Rl
cy0+ZmxhZyAmIENMS19GUkFDKSB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAobm9k
ZXMtPmN1c3RvbV90eXBlX2ZsYWcgJiBDVVNUT01fRkxBR19DTEtfRlJBQykpOw0KPiA+IC0gICAg
ICAgZGl2LT5mbGFncyA9IG5vZGVzLT50eXBlX2ZsYWc7DQo+ID4gKyAgICAgICBkaXYtPmZsYWdz
ID0gMDsNCj4gPiArICAgICAgIGRpdi0+ZmxhZ3MgfD0gKG5vZGVzLT50eXBlX2ZsYWcgJg0KPiBa
WU5RTVBfQ0xLX0RJVklERVJfT05FX0JBU0VEKSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IENMS19ESVZJREVSX09ORV9CQVNFRCA6IDA7DQo+ID4gKyAgICAgICBkaXYtPmZsYWdzIHw9IChu
b2Rlcy0+dHlwZV9mbGFnICYNCj4gWllOUU1QX0NMS19ESVZJREVSX1BPV0VSX09GX1RXTykgPw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBDTEtfRElWSURFUl9QT1dFUl9PRl9UV08gOiAwOw0K
PiA+ICsgICAgICAgZGl2LT5mbGFncyB8PSAobm9kZXMtPnR5cGVfZmxhZyAmDQo+IFpZTlFNUF9D
TEtfRElWSURFUl9BTExPV19aRVJPKSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIENMS19E
SVZJREVSX0FMTE9XX1pFUk8gOiAwOw0KPiA+ICsgICAgICAgZGl2LT5mbGFncyB8PSAobm9kZXMt
PnR5cGVfZmxhZyAmDQo+IFpZTlFNUF9DTEtfRElWSURFUl9QT1dFUl9PRl9UV08pID8NCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgQ0xLX0RJVklERVJfSElXT1JEX01BU0sgOiAwOw0KPiA+ICsg
ICAgICAgZGl2LT5mbGFncyB8PSAobm9kZXMtPnR5cGVfZmxhZyAmDQo+IFpZTlFNUF9DTEtfRElW
SURFUl9ST1VORF9DTE9TRVNUKSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIENMS19ESVZJ
REVSX1JPVU5EX0NMT1NFU1QgOiAwOw0KPiA+ICsgICAgICAgZGl2LT5mbGFncyB8PSAobm9kZXMt
PnR5cGVfZmxhZyAmDQo+IFpZTlFNUF9DTEtfRElWSURFUl9SRUFEX09OTFkpID8NCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgQ0xLX0RJVklERVJfUkVBRF9PTkxZIDogMDsNCj4gPiArICAgICAg
IGRpdi0+ZmxhZ3MgfD0gKG5vZGVzLT50eXBlX2ZsYWcgJg0KPiBaWU5RTVBfQ0xLX0RJVklERVJf
TUFYX0FUX1pFUk8pID8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgQ0xLX0RJVklERVJfTUFY
X0FUX1pFUk8gOiAwOw0KPiANCj4gQWRkIGEgaGVscGVyIGZ1bmN0aW9uIGZvciBjb252ZXJ0aW5n
IHRoZSBmbGFncy4NCj4gDQo+IE1pY2hhZWwNCj4gDQo+ID4gICAgICAgICBkaXYtPmh3LmluaXQg
PSAmaW5pdDsNCj4gPiAgICAgICAgIGRpdi0+Y2xrX2lkID0gY2xrX2lkOw0KPiA+ICAgICAgICAg
ZGl2LT5kaXZfdHlwZSA9IG5vZGVzLT50eXBlOw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0KPiA+
IFRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgaW50ZW5kZWQgZm9yIHRoZSBzb2xl
IHVzZSBvZiB0aGUgbmFtZWQNCj4gcmVjaXBpZW50KHMpIGFuZCBjb250YWluKHMpIGNvbmZpZGVu
dGlhbCBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBwcm9wcmlldGFyeSwNCj4gcHJpdmlsZWdlZCBv
ciBjb3B5cmlnaHRlZCB1bmRlciBhcHBsaWNhYmxlIGxhdy4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkDQo+IHJlY2lwaWVudCwgZG8gbm90IHJlYWQsIGNvcHksIG9yIGZvcndhcmQgdGhpcyBl
bWFpbCBtZXNzYWdlIG9yIGFueQ0KPiBhdHRhY2htZW50cy4gRGVsZXRlIHRoaXMgZW1haWwgbWVz
c2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGltbWVkaWF0ZWx5Lg0KPiA+DQo=
