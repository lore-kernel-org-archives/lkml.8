Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B201C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F292074F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lg1HlFnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZFIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 01:08:31 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:55053
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbgDZFIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 01:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLHjv1Kk2YbMOMLqv+jG8TmcNnaSnX2v+4+kMjHX4qEoBv6KSobKRlXZiBfPCQeU0YX8BnwYNqAIijA/CNlZhDzw7qaCQQKAgN2aqPzHN62ONdlkBeVAUipUuA/a2h0ht92/rBCv77P9h6Lc8GaIbsEhhHJwIlhvF5uncPmlDCWlAn4elgWjgswvNejou60DHaYKy9Q6SISNNnAERfnLPMQU0AY6zWCEd01bhfqNApwIJ9oZqzcRbOHdIi1Aq8M0wn6+UcuIrGv0ohet2qU/RlEF0YAwKh9H6nz+QTVoVHOVxp4AlSfx5Ud7yK1LunRPYkGWAWPKWv15F7ywkqSyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdE0tORgtp4TnrKJl4UHB0JJtUJekB4Nyb1JqDsQX0A=;
 b=msbzdXa37iAKtRf8/EZfiv+ewxnlIS7PjpsZ1OFbETUr+DbsIsmoDZHWqMj4VL1VIQRcn45LHXryq7zQmrbcaB2//IN59oNN2xaujkyQhu3hStM2RNsGFUa8CTURRmzVoS9P9vk3r7TVJEH5RFU158DEhdRuLsL5rG6jH4TjCRah3WB4zYzsr/kHl7ahNqHtv7J128Z+nmkqfpGLc4Rec3b0gUbb/PJINc/kRZJUeHQHqUKW7OTUGRCNYGDPQuY/LvjVylehlCzwbmgu/4ozoU0mz3b8KtbPSoT6p0jSg6Vc/spL+9Hc+p9zRiRGIvrt9AEgyTD+7DNJvUc62j0kRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdE0tORgtp4TnrKJl4UHB0JJtUJekB4Nyb1JqDsQX0A=;
 b=Lg1HlFnT8j+H3yGfHpN8AdT7sI/gP/IEREyUaLgnbX0U4a/iAhUPMKzSL+2uWukoi5aq6N0GIQ0ZWXNBEDMJ1FmC4r3egp0lfO04FiIjGABOJl8Txmfgewz1qrMN9xNNJkvU35ghdyYCelO2uYGoMPMhqa4AqzpFV2YvmeFDWRM=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4789.eurprd04.prod.outlook.com (2603:10a6:20b:7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 05:08:24 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 05:08:23 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: RE: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Topic: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Index: AQHV+FjQX+/rv+yfS06A3Zgldk2vUaiLHGJw
Date:   Sun, 26 Apr 2020 05:08:23 +0000
Message-ID: <AM6PR04MB4966D0EF272CAB282BF72EB580AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46e3401a-c185-464f-fe16-08d7e99fd894
x-ms-traffictypediagnostic: AM6PR04MB4789:|AM6PR04MB4789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4789603BC2A76F896367F4CB80AE0@AM6PR04MB4789.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(8936002)(110136005)(54906003)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(6506007)(7696005)(86362001)(6636002)(81156014)(71200400001)(26005)(33656002)(9686003)(55016002)(8676002)(316002)(7416002)(4326008)(186003)(2906002)(52536014)(44832011)(478600001)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axFZ78kJow5VdMFYpU0zhHxDcAZM78qtvkpI3frwtxroOMiZMsb8Q2Qf/DIh688CNQwIh0sp9xbrEOoe7UFh5oIQVRf+za4u1UbbD4YftDeYX1Z/zoIBbW0Ki9UWFNKnUmoROHg/6G+kdlAVBqddJXBUklc+6csOqtWiKWyZsdAnGh5aTSMm9ZROfrJLxyL3ikbhgeIfiwEwz1NCjrOGcMY8KZGqaqH7xLbn9fAfEUcM0xz9D647BsRYcYf/VPOcbvPJ7iucw865Z3VieA22tbeqoX77ioiIeTST+cjB6j2qUiIRK1PjEktx3CXn81AxyD7MzlRz7xHJzQJkoNgIq0RDmNEfZ4XzWsz0Mz3Bw3QnChz23Yf8zRDN6J7/6j6j7yDp56VdsnHmhQg6Q3QNCXSmWQUWUV9Mln1CL6HR2AdnELl3/1PggARz1UUZZL+o
x-ms-exchange-antispam-messagedata: pICzRlt4bd8ScSYCmoqKJRqr19v5xXtQxrqTDtAOy5CzGAg2xza2ddi2UX/qjH4Adq9yDvMtpA2kQI21YD11u0nkRb3SZbFeWVN1NDykpwIygSexktovlzdcsE+kXhKaRIx0cJmNNj7bYWSyzWwQ4lLkgFIntDdVuYg3kVYxdEo2fqnptuEEDWfcWeVRr0hLRNorunRGghD8BUcKU79goFbZoFj7pzmKyRqAWypbwTebrnYj+m32ly1ztE0Pps9OKK3Ej4fri6DKPtnFu8W97RxkHrgyeXq4Td3RBYzQXnuZaA7vFRY90SDJwTqzhj9TmfnArYnhiIlsncVcjdwB9RJuEt+Vpd3LbS+8NBbTS/PfgQc8VsAePQv1CPkYGuAhMApJw/Q4t0ldGdWg/jp21GvEmfoEuGPEb0T0YVEYuvcoiX0NTOIOV66ky0j2eETgGcHrrzd1LoqCfFLpFlCg2OvtOy6ljoxMb3G35X0ajLajHqTrATLmIXl9GaH8kQhQq/dZybqSNDf91B3rcpH6oFQIT47rtG5RHd3nSnN/BUH4vMGmz1hXyZbAcdI/V0KmL9KQ3mBjzakao/Qbaw5A0o6ytE7fKuUm3/T+7XYhu/P73uqpe8WnueEH67dbjDIPEIYUpvxe4b3xpL2aCKSQggzSOsLA5Bgp9vlxm1EARNHmYqHH1rkFyBeG5yctE7nmd1j/uRNotZxf3iPmAV6K8kgbLUElM1XVc+LjWtW/AH1BHZZMvzPdccP99RldROfq1Lx4ZaPecqrbc6LHRQ6wtUMAnyy9Aqg74RldGXAbdqY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e3401a-c185-464f-fe16-08d7e99fd894
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 05:08:23.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTTd7vuZI79xZePbzMM8QfJSKGyfICzll1j76AS4CUDmEsdWTO+jfuhs4fxdA4fs3XpkScMNEfkAel4/S4xAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEyLCAyMDIwIDY6MjAgUE0NCj4gDQo+IFRoZSBDT1JFL0JVUyByb290IHNsaWNlIGhhcyBm
b2xsb3dpbmcgZGVzaWduLCBzaW1wbGllZCBncmFwaDoNCj4gVGhlIGRpZmZlcmVuY2UgaXMgY29y
ZSBub3QgaGF2ZSBwcmVfZGl2IGJsb2NrLg0KPiBBIGNvbXBvc2l0ZSBjb3JlL2J1cyBjbGsgaGFz
IDggaW5wdXRzIGZvciBtdXggdG8gc2VsZWN0LCBzYXlpbmcgY2xrWzAtN10uDQo+IA0KPiAgICAg
ICAgICAgICBTRUxfQSAgR0ENCj4gICAgICAgICAgICAgKy0tKyAgKy0rDQo+ICAgICAgICAgICAg
IHwgICstPisgKy0tLS0tLSsNCj4gQ0xLWzAtN10tLS0+KyAgfCAgKy0rICAgICAgfA0KPiAgICAg
ICAgfCAgICB8ICB8ICAgICAgKy0tLS12LS0tKyAgICArLS0tLSsNCj4gICAgICAgIHwgICAgKy0t
KyAgICAgIHxwcmVfZGl2YSstLS0tPiAgICB8ICArLS0tLS0tLS0tKw0KPiAgICAgICAgfCAgICAg
ICAgICAgICAgKy0tLS0tLS0tKyAgICB8bXV4ICstLStwb3N0X2RpdiB8DQo+ICAgICAgICB8ICAg
ICstLSsgICAgICB8cHJlX2RpdmIrLS0tPisgICAgfCAgKy0tLS0tLS0tLSsNCj4gICAgICAgIHwg
ICAgfCAgfCAgICAgICstLS0tXi0tLSsgICAgKy0tLS0rDQo+ICAgICAgICArLS0tPisgIHwgICst
KyAgICAgIHwNCj4gICAgICAgICAgICAgfCAgKy0+KyArLS0tLS0tKw0KPiAgICAgICAgICAgICAr
LS0rICArLSsNCj4gICAgICAgICAgICAgU0VMX0IgIEdCDQo+IA0KPiBUaGVyZSB3aWxsIGJlIHN5
c3RlbSBoYW5nLCB3aGVuIGRvaW5nIHRoZSBmb2xsb3dpbmcgc3RlcHM6DQo+IDEuIHN3aXRjaCBt
dXggZnJvbSBjbGswIHRvIGNsazENCj4gMi4gZ2F0ZSBvZmYgY2xrMA0KPiAzLiBzd3RpY2ggZnJv
bSBjbGsxIHRvIGNsazIsIG9yIGdhdGUgb2ZmIGNsazENCj4gDQo+IFN0ZXAgMyB0cmlnZ2VycyBz
eXN0ZW0gaGFuZy4NCg0KV2h5IFN0ZXAgMyB0cmlnZ2VycyBzeXN0ZW0gaGFuZz8gSXMgdGhpcyBh
IEhXIGxpbWl0YXRpb24/DQoNCj4gDQo+IElmIHdlIHNraXAgc3RlcDIsIGtlZXAgY2xrMCBvbiwg
c3RlcCAzIHdpbGwgbm90IHRyaWdnZXIgc3lzdGVtIGhhbmcuDQo+IEhvd2V2ZXIgd2UgaGF2ZSBD
TEtfT1BTX1BBUkVOVF9FTkFCTEUgZmxhZywgd2hpY2ggd2lsbCB1bnByZXBhcmUgZGlzYWJsZQ0K
PiB0aGUgY2xrMCB3aGljaCB3aWxsIG5vdCBiZSB1c2VkLg0KPiANCj4gVG8gYWRkcmVzcyB0aGlz
IGlzc3VlLCB3ZSBjb3VsZCB1c2UgZm9sbG93aW5nIHNpbXBsaWVkIHNvZnR3YXJlIGZsb3c6DQo+
IEFmdGVyIHRoZSBmaXJzdCB0YXJnZXQgcmVnaXN0ZXIgc2V0DQo+IHdhaXQgdGhlIHRhcmdldCBy
ZWdpc3RlciBzZXQgZmluaXNoZWQNCj4gc2V0IHRoZSB0YXJnZXQgcmVnaXN0ZXIgc2V0IGFnYWlu
DQo+IHdhaXQgdGhlIHRhcmdldCByZWdpc3RlciBzZXQgZmluaXNoZWQNCj4gDQo+IFRoZSB1cHBl
ciBmbG93IHdpbGwgbWFrZSBzdXJlIFNFTF9BIGFuZCBTRUxfQiBib3RoIHNldCB0aGUgbmV3IG11
eCwgYnV0IHdpdGgNCj4gb25seSBvbmUgcGF0aCBnYXRlIG9uLg0KPiANCj4gQW5kIHRoZXJlIHdp
bGwgYmUgbm8gc3lzdGVtIGhhbmcgYW55bW9yZSB3aXRoIHN0ZXAzLg0KDQpJcyB0aGlzIElDIHBy
b3Bvc2VkIHNvbHV0aW9uPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gLS0tDQo+IA0KPiBWMjoNCj4gIERyb3Agd2FpdCBhZnRlciB3cml0ZSwg
YWRkIG9uZSBsaW5lIGNvbW1lbnQgZm9yIHdyaXRlIHR3aWNlLg0KPiANCj4gIGRyaXZlcnMvY2xr
L2lteC9jbGstY29tcG9zaXRlLThtLmMgfCA2Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0
ZS04bS5jDQo+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtOG0uYw0KPiBpbmRleCA5
OTc3MzUxOWI1YTUuLmVhZTAyYzE1MWNlZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14
L2Nsay1jb21wb3NpdGUtOG0uYw0KPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWNvbXBvc2l0
ZS04bS5jDQo+IEBAIC0yNCw2ICsyNCwxMiBAQA0KPiANCj4gICNkZWZpbmUgUENHX0NHQ19TSElG
VAkJMjgNCj4gDQo+ICsjZGVmaW5lIFBSRV9SRUdfT0ZGCQkweDMwDQo+ICsjZGVmaW5lIFBSRV9N
VVhBX1NISUZUCQkyNA0KPiArI2RlZmluZSBQUkVfTVVYQV9NQVNLCQkweDcNCj4gKyNkZWZpbmUg
UFJFX01VWEJfU0hJRlQJCTgNCj4gKyNkZWZpbmUgUFJFX01VWEJfTUFTSwkJMHg3DQoNCkFyZSB0
aG9zZSBtYWNyb3MgdXNlZCBzb21ld2hlcmU/DQoNCj4gKw0KPiAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgaW14OG1fY2xrX2NvbXBvc2l0ZV9kaXZpZGVyX3JlY2FsY19yYXRlKHN0cnVjdCBjbGtfaHcN
Cj4gKmh3LA0KPiAgCQkJCQkJdW5zaWduZWQgbG9uZyBwYXJlbnRfcmF0ZSkNCj4gIHsNCj4gQEAg
LTEyNCw2ICsxMzAsNTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzDQo+IGlteDhtX2Ns
a19jb21wb3NpdGVfZGl2aWRlcl9vcHMgPSB7DQo+ICAJLnNldF9yYXRlID0gaW14OG1fY2xrX2Nv
bXBvc2l0ZV9kaXZpZGVyX3NldF9yYXRlLA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgdTggaW14OG1f
Y2xrX2NvbXBvc2l0ZV9tdXhfZ2V0X3BhcmVudChzdHJ1Y3QgY2xrX2h3ICpodykgew0KPiArCXN0
cnVjdCBjbGtfbXV4ICptdXggPSB0b19jbGtfbXV4KGh3KTsNCj4gKwl1MzIgdmFsOw0KPiArDQo+
ICsJdmFsID0gcmVhZGwobXV4LT5yZWcpID4+IG11eC0+c2hpZnQ7DQo+ICsJdmFsICY9IG11eC0+
bWFzazsNCj4gKw0KPiArCXJldHVybiBjbGtfbXV4X3ZhbF90b19pbmRleChodywgbXV4LT50YWJs
ZSwgbXV4LT5mbGFncywgdmFsKTsgfQ0KDQpZb3UgZG9uJ3QgaGF2ZSB0byByZWRlZmluaXRpb24g
dGhlbSBpZiB0aGV5J3JlIHRoZSBzYW1lIGFzIGNsa19tdXhfb3BzLg0KWW91IGhhdmUgdGhlIGFj
Y2VzcyB0byBjbGtfbXV4X29wcy4NCg0KPiArDQo+ICtzdGF0aWMgaW50IGlteDhtX2Nsa19jb21w
b3NpdGVfbXV4X3NldF9wYXJlbnQoc3RydWN0IGNsa19odyAqaHcsIHU4DQo+ICtpbmRleCkgew0K
PiArCXN0cnVjdCBjbGtfbXV4ICptdXggPSB0b19jbGtfbXV4KGh3KTsNCj4gKwl1MzIgdmFsID0g
Y2xrX211eF9pbmRleF90b192YWwobXV4LT50YWJsZSwgbXV4LT5mbGFncywgaW5kZXgpOw0KPiAr
CXVuc2lnbmVkIGxvbmcgZmxhZ3MgPSAwOw0KPiArCXUzMiByZWc7DQo+ICsNCj4gKwlpZiAobXV4
LT5sb2NrKQ0KPiArCQlzcGluX2xvY2tfaXJxc2F2ZShtdXgtPmxvY2ssIGZsYWdzKTsNCj4gKw0K
PiArCXJlZyA9IHJlYWRsKG11eC0+cmVnKTsNCj4gKwlyZWcgJj0gfihtdXgtPm1hc2sgPDwgbXV4
LT5zaGlmdCk7DQo+ICsJdmFsID0gdmFsIDw8IG11eC0+c2hpZnQ7DQo+ICsJcmVnIHw9IHZhbDsN
Cj4gKwkvKiB3cml0ZSB0d2ljZSB0byBtYWtlIHN1cmUgU0VMX0EvQiBwb2ludCB0aGUgc2FtZSBt
dXggKi8NCj4gKwl3cml0ZWwocmVnLCBtdXgtPnJlZyk7DQo+ICsJd3JpdGVsKHJlZywgbXV4LT5y
ZWcpOw0KDQpXaHkgdGhpcyBhZmZlY3RzIGJvdGggU0VMX0EvQj8NClZlcnkgdHJpY2t5IGFuZCBt
YXkgd29ydGggbW9yZSBjb21tZW50cy4NCg0KQmVzaWRlcyB0aGF0LCBJJ2QgbGlrZSB0byBzZWUg
QWJlbCdzIGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAr
DQo+ICsJaWYgKG11eC0+bG9jaykNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShtdXgtPmxv
Y2ssIGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50
DQo+ICtpbXg4bV9jbGtfY29tcG9zaXRlX211eF9kZXRlcm1pbmVfcmF0ZShzdHJ1Y3QgY2xrX2h3
ICpodywNCj4gKwkJCQkgICAgICAgc3RydWN0IGNsa19yYXRlX3JlcXVlc3QgKnJlcSkgew0KPiAr
CXN0cnVjdCBjbGtfbXV4ICptdXggPSB0b19jbGtfbXV4KGh3KTsNCj4gKw0KPiArCXJldHVybiBj
bGtfbXV4X2RldGVybWluZV9yYXRlX2ZsYWdzKGh3LCByZXEsIG11eC0+ZmxhZ3MpOyB9DQoNClNh
bWUgYXMgYm92ZS4NCg0KPiArDQo+ICsNCj4gK2NvbnN0IHN0cnVjdCBjbGtfb3BzIGlteDhtX2Ns
a19jb21wb3NpdGVfbXV4X29wcyA9IHsNCj4gKwkuZ2V0X3BhcmVudCA9IGlteDhtX2Nsa19jb21w
b3NpdGVfbXV4X2dldF9wYXJlbnQsDQo+ICsJLnNldF9wYXJlbnQgPSBpbXg4bV9jbGtfY29tcG9z
aXRlX211eF9zZXRfcGFyZW50LA0KPiArCS5kZXRlcm1pbmVfcmF0ZSA9IGlteDhtX2Nsa19jb21w
b3NpdGVfbXV4X2RldGVybWluZV9yYXRlLA0KPiArfTsNCj4gKw0KPiAgc3RydWN0IGNsa19odyAq
aW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9mbGFncyhjb25zdCBjaGFyICpuYW1lLA0KPiAgCQkJCQlj
b25zdCBjaGFyICogY29uc3QgKnBhcmVudF9uYW1lcywNCj4gIAkJCQkJaW50IG51bV9wYXJlbnRz
LCB2b2lkIF9faW9tZW0gKnJlZywgQEAgLTEzNiw2DQo+ICsxOTMsNyBAQCBzdHJ1Y3QgY2xrX2h3
ICppbXg4bV9jbGtfaHdfY29tcG9zaXRlX2ZsYWdzKGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJc3Ry
dWN0IGNsa19nYXRlICpnYXRlID0gTlVMTDsNCj4gIAlzdHJ1Y3QgY2xrX211eCAqbXV4ID0gTlVM
TDsNCj4gIAljb25zdCBzdHJ1Y3QgY2xrX29wcyAqZGl2aWRlcl9vcHM7DQo+ICsJY29uc3Qgc3Ry
dWN0IGNsa19vcHMgKm11eF9vcHM7DQo+IA0KPiAgCW11eCA9IGt6YWxsb2Moc2l6ZW9mKCptdXgp
LCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIW11eCkNCj4gQEAgLTE1NywxMCArMjE1LDEyIEBAIHN0
cnVjdCBjbGtfaHcNCj4gKmlteDhtX2Nsa19od19jb21wb3NpdGVfZmxhZ3MoY29uc3QgY2hhciAq
bmFtZSwNCj4gIAkJZGl2LT5zaGlmdCA9IFBDR19ESVZfU0hJRlQ7DQo+ICAJCWRpdi0+d2lkdGgg
PSBQQ0dfQ09SRV9ESVZfV0lEVEg7DQo+ICAJCWRpdmlkZXJfb3BzID0gJmNsa19kaXZpZGVyX29w
czsNCj4gKwkJbXV4X29wcyA9ICZpbXg4bV9jbGtfY29tcG9zaXRlX211eF9vcHM7DQo+ICAJfSBl
bHNlIHsNCj4gIAkJZGl2LT5zaGlmdCA9IFBDR19QUkVESVZfU0hJRlQ7DQo+ICAJCWRpdi0+d2lk
dGggPSBQQ0dfUFJFRElWX1dJRFRIOw0KPiAgCQlkaXZpZGVyX29wcyA9ICZpbXg4bV9jbGtfY29t
cG9zaXRlX2RpdmlkZXJfb3BzOw0KPiArCQltdXhfb3BzID0gJmNsa19tdXhfb3BzOw0KPiAgCX0N
Cj4gDQo+ICAJZGl2LT5sb2NrID0gJmlteF9jY21fbG9jazsNCj4gQEAgLTE3Niw3ICsyMzYsNyBA
QCBzdHJ1Y3QgY2xrX2h3ICppbXg4bV9jbGtfaHdfY29tcG9zaXRlX2ZsYWdzKGNvbnN0DQo+IGNo
YXIgKm5hbWUsDQo+ICAJZ2F0ZS0+bG9jayA9ICZpbXhfY2NtX2xvY2s7DQo+IA0KPiAgCWh3ID0g
Y2xrX2h3X3JlZ2lzdGVyX2NvbXBvc2l0ZShOVUxMLCBuYW1lLCBwYXJlbnRfbmFtZXMsDQo+IG51
bV9wYXJlbnRzLA0KPiAtCQkJbXV4X2h3LCAmY2xrX211eF9vcHMsIGRpdl9odywNCj4gKwkJCW11
eF9odywgbXV4X29wcywgZGl2X2h3LA0KPiAgCQkJZGl2aWRlcl9vcHMsIGdhdGVfaHcsICZjbGtf
Z2F0ZV9vcHMsIGZsYWdzKTsNCj4gIAlpZiAoSVNfRVJSKGh3KSkNCj4gIAkJZ290byBmYWlsOw0K
PiAtLQ0KPiAyLjE2LjQNCg0K
