Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E0CC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57D520781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiM2fOEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDWOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:04:42 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:12358
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbgDWOEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFF9bHlv682Wm0nAzsgBtDj1vWFJ9EgyVJp2PT62jvBrv/B1E6Xw7usVannnMtv/H6BATIRjFLggDRXbOzv2ql61QDiNKkMbtAJXrFUbNi1crmLCguhUMzI22PrD9IytLWJL6c9IZt+OPXgjaISe1RNf/F7PnLm8KvMK/KSi5BI2eEGKHxMausynHQUk+VnLoQ5uNM/1MYXAusqstP9riVqlQgs2sPYp547RQ6iGxBWDkElWZfAgUL7uZq0GgXEwVQpHIWCNPfPSqjT1KExahnMkgJx+OD4cOmxhEuo1f5BrrJq/am2e9cqSYvfE5vqnew3QikBzqlupZ0GAuv7Enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRe0Vl6e3fYbcWX06M5HAEOmvqk/aiY6g0c0IoPv+D0=;
 b=fzuXssN1lOp/FwRTy5O2d/rpjJ3Su85frOUoiXDFvVmTSW5K6ZHknK07YD7NdIa4IFSRT+zdXW1EJ4b390ukJNqjQtzWJCaljOgs1TS0755HYCwYpPdiEn33eEu7tzdAqngF3ysUad+VMS6gNAPZnOP5OniV1L7ogHj5f+ULupBlTCR0B6s3N+C1hlj9SUQ+W14a54br3mk8secRReEpVpimwpLCUA5HePcWpcJafi609wwsrE1mcDI4WhsRSwdVH1gDLbXwVnG2wrglTjiZRzBGKPbDOrZm7mrQLsU94ipxNsKdKbDTfqpFQPJkGF4SwnbUQ835JNdSQW6ppMpFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRe0Vl6e3fYbcWX06M5HAEOmvqk/aiY6g0c0IoPv+D0=;
 b=SiM2fOEcxJ3YCf5I202EFkEuVkpmST+s0ZHNzsblZw5ZEph3wM+oDF4PyswYY7Hd+jBR+yb9skglDMVBx/k4g0Q6b6Kxdw0hgmwjWE8Tg69YaLrkPjhoc9GDfnopuG703AUrjr52DjOdOC5a++DVkoapVD6Pjys87woScYxHnIA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB3960.eurprd04.prod.outlook.com (2603:10a6:209:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 14:04:36 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 14:04:36 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/4] firmware: imx: add resource management api
Thread-Topic: [PATCH 2/4] firmware: imx: add resource management api
Thread-Index: AQHWGT38Z8g88FkqQ0uX8uLlRjqzhqiGeivAgAAPRACAADPS4A==
Date:   Thu, 23 Apr 2020 14:04:36 +0000
Message-ID: <AM6PR04MB4966169A7CB00C084FEA601980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49665455AE49EB1B500BEB4080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276030B2D59423AF0FD3769388D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB276030B2D59423AF0FD3769388D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b68fb112-d8d3-4206-98b3-08d7e78f41dc
x-ms-traffictypediagnostic: AM6PR04MB3960:|AM6PR04MB3960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB39606919BDA4547BD8A7C5A680D30@AM6PR04MB3960.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(110136005)(316002)(76116006)(54906003)(4326008)(52536014)(44832011)(33656002)(186003)(66946007)(5660300002)(55016002)(9686003)(66476007)(66446008)(64756008)(66556008)(86362001)(71200400001)(8936002)(2906002)(8676002)(478600001)(26005)(6506007)(81156014)(7696005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEGISpq9ABZVG67I+6dLlIWLIn/uY/uT0tDXCK00/Uc2PGCGBzcJUvu4GuMuMxHGCMs8IystY/7Lw97BVSmg9Zo4aN1PiNHqPvqoAXW/VD50e0UZYdAZDDDe9Wyk+HHNK11QLD6uUsSSM3MqGnX4tKn/ijD/b/32gBxBXaI0vKUCHKawrhWGStH9/NvHBF0Eokis48eMBTqlQESrP6BRJF9jF62k6aKSjE22djd46cZBRYAS8dfvrEtNBxwYRLCYjPnb1hA8xPHOzl1eYzM/n7H5sN12Cmpzk5+6On+Sf1S2+66mKbYWJwdD3TD3lFoIAmCU70ojh22EhpsVt/3TJUCLNibTZMbkXUQRcUAG96upGWHGmG1VmeVDa6x7wJRE5IzrC6fHXOocjC88pGlmFrGJANysra/cuUiqqsUBPTU2psbOBhBxul7XINeOOqed
x-ms-exchange-antispam-messagedata: EQ+TkoaMGzyqFi4+G+pRC5qgYyVIUv/oPzJnzt3CgM2ZAm5qABUlLzhiufh9707NWediCvwoaAxuIVfOXeuspG/Hn92EpGdTQgyt5wUQWcnWLReJubNy1I2f/BJr9uNqa2Sk57mmKsrWyOqi/XvIxw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68fb112-d8d3-4206-98b3-08d7e78f41dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 14:04:36.6931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3VokFAKyDhLG++N/6bGIV2AhvgN/ZluBXoy4G6gHgbiSCPNEvySxSlMEilRggsICswRDmwz+UgEd+6eCUeSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDY6NTcgUE0NCj4gPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDM6MDAgUE0NCj4gPiA+
DQo+ID4gPiBBZGQgcmVzb3VyY2UgbWFuYWdlbWVudCBBUEksIHdoZW4gd2UgaGF2ZSBtdWx0aXBs
ZSBwYXJ0aXRpb24gcnVubmluZw0KPiA+ID4gdG9nZXRoZXIsIHJlc291cmNlcyBub3Qgb3duZWQg
dG8gY3VycmVudCBwYXJ0aXRpb24gc2hvdWxkIG5vdCBiZSB1c2VkLg0KPiA+ID4NCj4gPiA+IFJl
dmlld2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBS
aWdodCBub3cgSSdtIHN0aWxsIG5vdCBxdWl0ZSB1bmRlcnN0YW5kIGlmIHdlIHJlYWxseSBuZWVk
IHRoaXMuDQo+ID4gQXMgY3VycmVudCByZXNvdXJjZSBpcyBib3VuZCB0byBwb3dlciBkb21haW5z
LCBpZiBpdCdzIG5vdCBvd25lZCBieQ0KPiA+IG9uZSBzcGVjaWZpYyBTVyBleGVjdXRpb24gZW52
aXJvbm1lbnQsIHBvd2VyIG9uIHdpbGwgYWxzbyBmYWlsLg0KPiA+IENhbiB5b3UgY2xhcmlmeSBp
ZiBhbnkgZXhjZXB0aW9ucz8NCj4gDQo+IFRoZXJlIHdpbGwgYmUgbG90cyBvZiBmYWlsdXJlcyB3
aGVuIGJvb3QgTGludXggZG9tdSBpZiBubyBjaGVjay4NCj4gDQoNCldoYXQga2luZCBvZiBmZWF0
dXJlcyBkaWQgeW91IG1lYW4/IA0KQ291bGQgeW91IGNsYXJpZnkgYSBiaXQgbW9yZT8gSSdkIGxp
a2UgdG8gdW5kZXJzdGFuZCB0aGlzIGlzc3VlIGJldHRlci4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
DQo+IFRoYW5rcywNCj4gUGVuZy4NCj4gDQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4gQWlzaGVuZw0K
PiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSAgICAg
ICB8ICAyICstDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvcm0uYyAgICAgICAgICAgfCA0
MCArKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lt
eC9zY2kuaCAgICB8ICAxICsNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMv
cm0uaCB8IDY5DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKSAg
Y3JlYXRlIG1vZGUNCj4gPiA+IDEwMDY0NCBkcml2ZXJzL2Zpcm13YXJlL2lteC9ybS5jICBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5o
DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxl
DQo+ID4gPiBiL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlIGluZGV4IDA4YmM5ZGRmYmRm
Yi4uMTdlYTM2MTNlMTQyDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdh
cmUvaW14L01ha2VmaWxlDQo+ID4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmls
ZQ0KPiA+ID4gQEAgLTEsNCArMSw0IEBADQo+ID4gPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPiA+ID4gIG9iai0kKENPTkZJR19JTVhfRFNQKQkJKz0gaW14LWRzcC5vDQo+
ID4gPiAtb2JqLSQoQ09ORklHX0lNWF9TQ1UpCQkrPSBpbXgtc2N1Lm8gbWlzYy5vIGlteC1zY3Ut
aXJxLm8NCj4gPiA+ICtvYmotJChDT05GSUdfSU1YX1NDVSkJCSs9IGlteC1zY3UubyBtaXNjLm8g
aW14LXNjdS1pcnEubyBybS5vDQo+ID4gPiAgb2JqLSQoQ09ORklHX0lNWF9TQ1VfUEQpCSs9IHNj
dS1wZC5vDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvcm0uYyBiL2Ry
aXZlcnMvZmlybXdhcmUvaW14L3JtLmMNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4
IDAwMDAwMDAwMDAwMC4uN2IwMzM0ZGU1NDg2DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiAr
KysgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9ybS5jDQo+ID4gPiBAQCAtMCwwICsxLDQwIEBADQo+
ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ID4gPiArLyoNCj4g
PiA+ICsgKiBDb3B5cmlnaHQgMjAyMCBOWFANCj4gPiA+ICsgKg0KPiA+ID4gKyAqIEZpbGUgY29u
dGFpbmluZyBjbGllbnQtc2lkZSBSUEMgZnVuY3Rpb25zIGZvciB0aGUgUk0gc2VydmljZS4NCj4g
PiA+ICtUaGVzZQ0KPiA+ID4gKyAqIGZ1bmN0aW9uIGFyZSBwb3J0ZWQgdG8gY2xpZW50cyB0aGF0
IGNvbW11bmljYXRlIHRvIHRoZSBTQy4NCj4gPiA+ICsgKi8NCj4gPiA+ICsNCj4gPiA+ICsjaW5j
bHVkZSA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oPg0KPiA+ID4gKw0KPiA+ID4gK3N0cnVj
dCBpbXhfc2NfbXNnX3JtX3JzcmNfb3duZWQgew0KPiA+ID4gKwlzdHJ1Y3QgaW14X3NjX3JwY19t
c2cgaGRyOw0KPiA+ID4gKwl1MTYgcmVzb3VyY2U7DQo+ID4gPiArfSBfX3BhY2tlZCBfX2FsaWdu
ZWQoNCk7DQo+ID4gPiArDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGNoZWNr
IEByZXNvdXJjZSBpcyBvd25lZCBieSBjdXJyZW50IHBhcnRpdGlvbiBvcg0KPiA+ID4gK25vdA0K
PiA+ID4gKyAqDQo+ID4gPiArICogQHBhcmFtW2luXSAgICAgaXBjICAgICAgICAgSVBDIGhhbmRs
ZQ0KPiA+ID4gKyAqIEBwYXJhbVtpbl0gICAgIHJlc291cmNlICAgIHJlc291cmNlIHRoZSBjb250
cm9sIGlzIGFzc29jaWF0ZWQgd2l0aA0KPiA+ID4gKyAqDQo+ID4gPiArICogQHJldHVybiBSZXR1
cm5zIDAgZm9yIHN1Y2Nlc3MgYW5kIDwgMCBmb3IgZXJyb3JzLg0KPiA+ID4gKyAqLw0KPiA+ID4g
K2Jvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICppcGMs
IHUxNg0KPiA+ID4gK3Jlc291cmNlKSB7DQo+ID4gPiArCXN0cnVjdCBpbXhfc2NfbXNnX3JtX3Jz
cmNfb3duZWQgbXNnOw0KPiA+ID4gKwlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZtc2cu
aGRyOw0KPiA+ID4gKw0KPiA+ID4gKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4g
PiA+ICsJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19STTsNCj4gPiA+ICsJaGRyLT5mdW5jID0g
SU1YX1NDX1JNX0ZVTkNfSVNfUkVTT1VSQ0VfT1dORUQ7DQo+ID4gPiArCWhkci0+c2l6ZSA9IDI7
DQo+ID4gPiArDQo+ID4gPiArCW1zZy5yZXNvdXJjZSA9IHJlc291cmNlOw0KPiA+ID4gKw0KPiA+
ID4gKwlpbXhfc2N1X2NhbGxfcnBjKGlwYywgJm1zZywgdHJ1ZSk7DQo+ID4gPiArDQo+ID4gPiAr
CXJldHVybiBoZHItPmZ1bmM7DQo+ID4gPiArfQ0KPiA+ID4gK0VYUE9SVF9TWU1CT0woaW14X3Nj
X3JtX2lzX3Jlc291cmNlX293bmVkKTsNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2Zpcm13YXJlL2lteC9zY2kuaA0KPiA+ID4gYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9z
Y2kuaA0KPiA+ID4gaW5kZXggMTdiYTRlNDA1MTI5Li5iNWM1YTU2ZjI5YmUgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0KPiA+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4gPiA+IEBAIC0xNSw2ICsxNSw3IEBADQo+
ID4gPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaD4gICNp
bmNsdWRlDQo+ID4gPiA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9wbS5oPg0KPiA+ID4gKyNpbmNs
dWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmg+DQo+ID4gPg0KPiA+ID4gIGludCBpbXhf
c2N1X2VuYWJsZV9nZW5lcmFsX2lycV9jaGFubmVsKHN0cnVjdCBkZXZpY2UgKmRldik7ICBpbnQN
Cj4gPiA+IGlteF9zY3VfaXJxX3JlZ2lzdGVyX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqbmIpOyBkaWZmIC0tZ2l0DQo+ID4gPiBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2
Yy9ybS5oDQo+ID4gPiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oDQo+ID4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5mYzZlYTYy
ZDlkMGUNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZmly
bXdhcmUvaW14L3N2Yy9ybS5oDQo+ID4gPiBAQCAtMCwwICsxLDY5IEBADQo+ID4gPiArLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBD
b3B5cmlnaHQgKEMpIDIwMTYgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4NCj4gPiA+ICsg
KiBDb3B5cmlnaHQgMjAxNy0yMDE5IE5YUA0KPiA+ID4gKyAqDQo+ID4gPiArICogSGVhZGVyIGZp
bGUgY29udGFpbmluZyB0aGUgcHVibGljIEFQSSBmb3IgdGhlIFN5c3RlbSBDb250cm9sbGVyDQo+
ID4gPiArKFNDKQ0KPiA+ID4gKyAqIFBvd2VyIE1hbmFnZW1lbnQgKFBNKSBmdW5jdGlvbi4gVGhp
cyBpbmNsdWRlcyBmdW5jdGlvbnMgZm9yDQo+ID4gPiArcG93ZXIgc3RhdGUNCj4gPiA+ICsgKiBj
b250cm9sLCBjbG9jayBjb250cm9sLCByZXNldCBjb250cm9sLCBhbmQgd2FrZS11cCBldmVudCBj
b250cm9sLg0KPiA+ID4gKyAqDQo+ID4gPiArICogUk1fU1ZDIChTVkMpIFJlc291cmNlIE1hbmFn
ZW1lbnQgU2VydmljZQ0KPiA+ID4gKyAqDQo+ID4gPiArICogTW9kdWxlIGZvciB0aGUgUmVzb3Vy
Y2UgTWFuYWdlbWVudCAoUk0pIHNlcnZpY2UuDQo+ID4gPiArICovDQo+ID4gPiArDQo+ID4gPiAr
I2lmbmRlZiBfU0NfUk1fQVBJX0gNCj4gPiA+ICsjZGVmaW5lIF9TQ19STV9BUElfSA0KPiA+ID4g
Kw0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQo+ID4gPiArDQo+
ID4gPiArLyoNCj4gPiA+ICsgKiBUaGlzIHR5cGUgaXMgdXNlZCB0byBpbmRpY2F0ZSBSUEMgUk0g
ZnVuY3Rpb24gY2FsbHMuDQo+ID4gPiArICovDQo+ID4gPiArZW51bSBpbXhfc2Nfcm1fZnVuYyB7
DQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX1VOS05PV04gPSAwLA0KPiA+ID4gKwlJTVhfU0NfUk1f
RlVOQ19QQVJUSVRJT05fQUxMT0MgPSAxLA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfQ09O
RklERU5USUFMID0gMzEsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9GUkVFID0g
MiwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfR0VUX0RJRCA9IDI2LA0KPiA+ID4gKwlJTVhfU0Nf
Uk1fRlVOQ19QQVJUSVRJT05fU1RBVElDID0gMywNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfUEFS
VElUSU9OX0xPQ0sgPSA0LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfUEFSVElUSU9OID0g
NSwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1BBUkVOVCA9IDYsDQo+ID4gPiArCUlNWF9T
Q19STV9GVU5DX01PVkVfQUxMID0gNywNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfQVNTSUdOX1JF
U09VUkNFID0gOCwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1JFU09VUkNFX01PVkFCTEUg
PSA5LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfU1VCU1lTX1JTUkNfTU9WQUJMRSA9IDI4
LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX0FUVFJJQlVURVMgPSAxMCwNCj4g
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX01BU1RFUl9TSUQgPSAxMSwNCj4gPiA+ICsJSU1YX1ND
X1JNX0ZVTkNfU0VUX1BFUklQSEVSQUxfUEVSTUlTU0lPTlMgPSAxMiwNCj4gPiA+ICsJSU1YX1ND
X1JNX0ZVTkNfSVNfUkVTT1VSQ0VfT1dORUQgPSAxMywNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNf
R0VUX1JFU09VUkNFX09XTkVSID0gMzMsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0lTX1JFU09V
UkNFX01BU1RFUiA9IDE0LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9QRVJJ
UEhFUkFMID0gMTUsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0dFVF9SRVNPVVJDRV9JTkZPID0g
MTYsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX01FTVJFR19BTExPQyA9IDE3LA0KPiA+ID4gKwlJ
TVhfU0NfUk1fRlVOQ19NRU1SRUdfU1BMSVQgPSAyOSwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNf
TUVNUkVHX0ZSQUcgPSAzMiwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfTUVNUkVHX0ZSRUUgPSAx
OCwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfRklORF9NRU1SRUcgPSAzMCwNCj4gPiA+ICsJSU1Y
X1NDX1JNX0ZVTkNfQVNTSUdOX01FTVJFRyA9IDE5LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19T
RVRfTUVNUkVHX1BFUk1JU1NJT05TID0gMjAsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0lTX01F
TVJFR19PV05FRCA9IDIxLA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfTUVNUkVHX0lORk8g
PSAyMiwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfQVNTSUdOX1BBRCA9IDIzLA0KPiA+ID4gKwlJ
TVhfU0NfUk1fRlVOQ19TRVRfUEFEX01PVkFCTEUgPSAyNCwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZV
TkNfSVNfUEFEX09XTkVEID0gMjUsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0RVTVAgPSAyNywN
Cj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19JTVhfU0NV
KQ0KPiA+ID4gK2Jvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhfc2Nf
aXBjICppcGMsIHUxNg0KPiA+ID4gK3Jlc291cmNlKTsgI2Vsc2Ugc3RhdGljIGlubGluZSBib29s
DQo+ID4gPiAraW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICpp
cGMsIHUxNiByZXNvdXJjZSkgew0KPiA+ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiA+ICt9DQo+ID4g
PiArI2VuZGlmDQo+ID4gPiArI2VuZGlmDQo+ID4gPiAtLQ0KPiA+ID4gMi4xNi40DQoNCg==
