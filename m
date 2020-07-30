Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7E222B42
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bvSvTYG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgG3EEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:04:33 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:40421
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgG3EEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4iaer2yeWmc9wVCfWAi3+Lc05Va0ystjZWS+fRj/QUNCXrxWMfLrRovtUYzd0koIeEYrkHgNDJNGYYnoawvJZZeI3YvOapwP76ITcRaur4txJzWDvAJbng2eikgfTO9JL78tMBwhSwDGS8L6y7ktyxco9mf++LzO8lvQvH4rmqt8Pq/zPoKMLaCv3uWA/8/IvqBb1RL0qNszsVUgBrCIz6toO6ll3u4tX2hAhGpVYH7LdyopcuJ8bXuRqiJiJU4sXly0J7P7kRlxrkUAOh6h3UMDEYRZmBrBlkyxUEsFsxTZkcrS4hdUiU9Eq2fQXJQfNF8jbFzxyqpV3aaF3MFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXQIDPz5khuIwtpdRt/jMpAvmezCH1beRb2K2YFUpVs=;
 b=N8kk3f05ZpkrTZvThql5fwjP3id5f68qjWWxHJTWj43c26/D5qwRJATVZi4bmiB/mqFTwjeZwfHJ8OSHuHKAewNOSVZ7AQ6kQ3j4NpEGH9lHnOSYMPnHg+n6kuokZ0DSZPOrxFf94esHgMtpJzWxSaqtQtvxBL4V7NeCMFlpbpN9iz3mSn/jLx0xdhIMNbZp5OTtLQcAAyx+XF+o9CySUD7v0YJyZjiJmivrYTIv5DlCfrnibpf/ATUrAkm2oImGDNczGGwqs/jBJfSr5/Sh9Iro3UuB1C/Ky2FlXXGx1DbjKNnCj3AoeDmgJAp+2fVVQoKAhQtXMBbvfcLXZ3N9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXQIDPz5khuIwtpdRt/jMpAvmezCH1beRb2K2YFUpVs=;
 b=bvSvTYG6IsWCyCkw5Eep9z+VnNLJKbo76NIGI67e9IygVYmTUCWLUEhXO8i4dPQ5YPPiPMUt5FvPiByxbU1Gtk7nlDFNKcPAswzU5LUqlEKYO8TQMo5/OcDipHA3mtt4t8y0bTH09SOWbuRSk0W5Ybnd+A4tg5Y2MkrmUIqr3vg=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3706.eurprd04.prod.outlook.com (2603:10a6:8:5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 04:04:28 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5%9]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 04:04:28 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Zyngier <maz@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>
CC:     Hulk Robot <hulkci@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] irqchip/imx-intmux: Fix irqdata regs save in
 imx_intmux_runtime_suspend()
Thread-Topic: [PATCH -next] irqchip/imx-intmux: Fix irqdata regs save in
 imx_intmux_runtime_suspend()
Thread-Index: AQHWZb/VbEhDiB85BEerXnuvJ/ZhRKkex8iAgACfHLA=
Date:   Thu, 30 Jul 2020 04:04:28 +0000
Message-ID: <DB8PR04MB679585BFCB23BE391A7C7AF6E6710@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200729155849.33919-1-weiyongjun1@huawei.com>
 <46666de74c4b03142524f514ea64ddad@kernel.org>
In-Reply-To: <46666de74c4b03142524f514ea64ddad@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b63d1774-2f31-421e-3834-08d8343da7a0
x-ms-traffictypediagnostic: DB3PR0402MB3706:
x-microsoft-antispam-prvs: <DB3PR0402MB37062B16F275D668039CA587E6710@DB3PR0402MB3706.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObOxU38ibinrTuXCAzEoE4hiYA0PML+k6np0ysYNUNiPQrdUwJ2SKCjx+JpdeYUlMe5l8DLNWMO4zm74HFV18wQXtKCXfsAaPybvI58WTj+lkZYWRiMiNiou2DwxLcSEgbcqO4dDFDH/yeo+4hcbJgM/fAmPuL1LqiAKwC4YDs9NkovVCnC2qBY4p1LBgJNyLS/ZJwsjpMX3yLHv/zF1sdiwAAbRq8KXOsMD6K1lIVHBXBVnwyiq1pPSAU1uZrIHdZ20ClJr+oV7A59SOIk7pneDXwXh8fhDfxlS9utfIXTBarfh/ZpCEGbb6a9g247DGozEoKjd+O5Ep4Twq6j/6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(8936002)(71200400001)(2906002)(53546011)(8676002)(33656002)(478600001)(316002)(7696005)(52536014)(4326008)(86362001)(5660300002)(64756008)(66556008)(66476007)(66446008)(66946007)(76116006)(55016002)(110136005)(83380400001)(6506007)(186003)(54906003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M6qKmFxZ5zlQzzvlvgrHT5llyRnrPD9XhXTakGbRTw/ZA2z7a6snnjdTiTKxd3zyLFHj8SA3btrBVbSmJYHVrz9IpoqThw4tERTuS3EKtdp2V18XzqddrrkyYPos4u+aiV3aZZQlYHLyjadrnq5N97x9Nl92HNBrjsSIypOvzzSRJbfTZjm25F2gpsNLmMNDNPvW4V52Y92jFThCKpLl0Rj2pM1wf2ciFEWc5NatjC01DtKDwmlnbgR7lS4UoePhhKVmfHtf1ZZgm8ACUtJDm5Yarg6eaFT3b6UvZjWxkyE9aHes/WoVOrveL5oaIj4oxRFcIBhk0QaZMA3DFcaiUfvw/csK7fsMCXkXVZ9lCkb9Z3Mkj9izxf7L6tZt8ytRDCrKo4C3oKCbHzy841KHl/KJV9rcqBlWr3vG7fEtiHy3mGhUNERupZdRotDi9A5VQ9k0dopzP7wqEl62ZfKHBkFBQNzCkbknZk0eZFWZD/E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d1774-2f31-421e-3834-08d8343da7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 04:04:28.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWJPwPuK4JiLBxCP3JA5jh2Qymhl1irr5e9FRGTAoPCyQ81CjQ4ah9jjw4nsnMgEzh9rZ5tS2tHPTFBzlMmoQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3706
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jfUwjMwyNUgMTowMA0KPiBUbzogV2VpIFlvbmdq
dW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+DQo+IENjOiBIdWxrIFJvYm90IDxodWxrY2lAaHVh
d2VpLmNvbT47IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsNCj4gSmFzb24g
Q29vcGVyIDxqYXNvbkBsYWtlZGFlbW9uLm5ldD47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IEpvYWtpbSBa
aGFuZw0KPiA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAtbmV4dF0gaXJxY2hpcC9pbXgtaW50bXV4OiBGaXggaXJxZGF0YSByZWdz
IHNhdmUgaW4NCj4gaW14X2ludG11eF9ydW50aW1lX3N1c3BlbmQoKQ0KPiANCj4gT24gMjAyMC0w
Ny0yOSAxNjo1OCwgV2VpIFlvbmdqdW4gd3JvdGU6DQo+ID4gR2NjIHJlcG9ydCB3YXJuaW5nIGFz
IGZvbGxvd3M6DQo+ID4NCj4gPiBkcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pbnRtdXguYzozMTY6
Mjk6IHdhcm5pbmc6DQo+ID4gIHZhcmlhYmxlICdpcnFjaGlwX2RhdGEnIHNldCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+ID4gICAzMTYgfCAgc3RydWN0IGludG11
eF9pcnFjaGlwX2RhdGEgaXJxY2hpcF9kYXRhOw0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gaXJxZGF0YSByZWdzIGlzIHN0b3Jl
ZCB0byB0aGlzIHZhcmlhYmxlIG9uIHRoZSBzdGFjayBpbg0KPiA+IGlteF9pbnRtdXhfcnVudGlt
ZV9zdXNwZW5kKCksIHdoaWNoIG1lYW5zIGEgbm9wLiB0aGlzIGNvbW1pdCBmaXggdG8NCj4gPiBz
YXZlIHJlZ3MgdG8gdGhlIHJpZ2h0IHBsYWNlLg0KPiA+DQo+ID4gRml4ZXM6IGJiNDAzMTExZTAx
NyAoImlycWNoaXAvaW14LWludG11eDogSW1wbGVtZW50IGludG11eCBydW50aW1lDQo+ID4gcG93
ZXIgbWFuYWdlbWVudCIpDQo+ID4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3
ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBZb25nanVuIDx3ZWl5b25nanVuMUBodWF3
ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pbnRtdXguYyB8
IDEyICsrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KDQpbLi4uXQ0KPiBBbWF6aW5nLiBUaGFua3MgZm9yIGZpeGluZyB0aGlz
Lg0KPiANCj4gSm9oYWtpbTogSSBndWVzcyB0aGlzIHdhcyBuZXZlciB0ZXN0ZWQsIHdhcyBpdD8N
Cg0KDQpIaSBNYXJjLA0KDQpGaXJzdGx5LCB0aGFua3MgV2VpIFlvbmdqdW4gZm9yIGZpeGluZyB0
aGlzLg0KDQpJIGRvIHRoZSBpbnRtdXggZnVuY3Rpb24gdGVzdCBmb3IgZWFjaCB2ZXJzaW9uLg0K
DQpBdCBteSBzaWRlLCBJIHRlc3QgaW50bXV4IHdpdGggQ0FOIGRldmljZS4gVGhpcyBpbnRtdXgg
aW4gTTQgY29yZSBzdWJzeXN0ZW0sIGRldmljZXMgbG9jYXRlZCBpbiBNNCBjb3JlIHN1YnN5c3Rl
bSB3aWxsIHJvdXRlIGlycXMgaW50byBpbnRtdXguDQpDQU4gdHJhbnNjZWl2ZXIgaXMgY29udHJv
bGxlZCBieSBhbiBJL08gZXhwYW5kZXIgd2hpY2ggaXMgbGluZWQgdG8gSTJDIGZyb20gTTQgY29y
ZSBzdWJzeXN0ZW0uIEFuZCBDQU4gZGV2aWNlIGlzIGxvY2F0ZWQgaW4gQTM1IGNvcmUgc3Vic3lz
dGVtLg0KDQpBZnRlciBpbXBsZW1lbnRpbmcgcnVudGltZSBwbSwgSSB0ZXN0IENBTiB3b3JrIGZp
bmUgd2hlbiBkbyBzdXNwZW5kL3Jlc3VtZSB0ZXN0IGFuZCBJIGNoZWNrIHRoZSBydW50aW1lIHN0
YXR1cy4gSSBndWVzcyBpbnRtdXggcmVnaXN0ZXIncyBzdGF0ZSB3aWxsIG5vdCBsb3N0IGluIE00
IGNvcmUgc3Vic3lzdGVtIHdoZW4gc3lzdGVtIHN1c3BlbmRlZC4NCg0KSG93ZXZlciwgdGhpcyBp
cyBhIHNpbGx5IG1pc3Rha2UsIEkgYW0gc28gc29ycnkgZm9yIHRoaXMuDQoNCkJlc3QgUmVnYXJk
cywNCkpvYWtpbSBaaGFuZw0KPiAgICAgICAgICBNLg0KPiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFk
LiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0K
