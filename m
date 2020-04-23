Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD2C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1E620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fU5u47uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgDWKEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:04:39 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:15106
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5PTAGdaWHpDhAY/j/i0mhI+WqvcUrY4SeobfTwUQMw4QNQ2cgCzP8+Et4HURTNvef8DonJEYFtwen59h0f5FyeRhQ+Yym1cZ9OcpE1WMBj/B2Knae/DqRTfGjogy5HkB2zP5eXd3ux6I37/S/2rsElwZJS2xPO5nbfxtpBor9xrtlfTiJAbB6DCNWBI43AxrGEp9j/dpmQmJzeLyYMXTVwUXNGFpvfmos2uZzH/lcF3ZDUVnS/9vNWMpgJtIvQQTqsW5Zso6wzx/c883Ul211/hWt1Agw/j4azium46wffWoA/J9HAojw0LgnFfVwYMdm785dUHa1CjwJpMOzBAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSwV2Ap9HlsZ1NkPdvnNFWFdQ1+ohpxWu3UM03Gfg1s=;
 b=cuyimntaPO62xOn9xZeb+ROlfucr32Mr6cM9kglitw+TcuwZRgo6Y6LPdD2yWe86RcSqnsyHrPdwwilH6oUr2+OP6sDAq+KlRwJhVXtzZ2Sxvg9niLKtXonkD0jpP0FhV72KDsCX5SNFuco4upf4pYJ4RkPgv1xK/MQKkwu6iGDIvW/Ytk/nLJEqagu7N50g8enuncH2O5I2Xp+4Q/lEyQK57ef7pHlPLoB/OXr3ycLWuzZLG+yQ6LczxNRQp/usjk+IfoxeK4cI21cEZCfgyBbegDonST31l9ekIND8+6bBSbVeQyYWoj4HfrjxJgbyDa1Zga/UfYS44RG+bdEtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSwV2Ap9HlsZ1NkPdvnNFWFdQ1+ohpxWu3UM03Gfg1s=;
 b=fU5u47uh+lSki/V8nCEqxjmduBGH2Y6y8s68kMAcK62H3ka6XICAtAvOvnrQpNa4OLLYZ0DVWb4Xz2CE7iDDGEGoUs0S5P+9AR3FCSrnM3n+f8UJf8QONDJyFHmCjtECdsbpB/tdtZIk2C21ZIat+xTr9PFbr7T36k39v2hA7Yw=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4853.eurprd04.prod.outlook.com (2603:10a6:20b:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 10:04:34 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 10:04:33 +0000
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
Thread-Index: AQHWGT38Z8g88FkqQ0uX8uLlRjqzhqiGeivA
Date:   Thu, 23 Apr 2020 10:04:33 +0000
Message-ID: <AM6PR04MB49665455AE49EB1B500BEB4080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a80f697-9d4e-4252-c379-08d7e76db912
x-ms-traffictypediagnostic: AM6PR04MB4853:|AM6PR04MB4853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB485364D16DD38F8386BE38A580D30@AM6PR04MB4853.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(55016002)(110136005)(33656002)(2906002)(8676002)(8936002)(81156014)(54906003)(9686003)(5660300002)(478600001)(4326008)(71200400001)(316002)(86362001)(26005)(6506007)(44832011)(66946007)(52536014)(7696005)(186003)(66446008)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jr02sGcuR/LCSmG3Vz8eMALgQUjPyxLKP0qXhCOEr4POi3v7olUcujnVFpvUmJ9btLOS8XzmMPOy5Ia9jHF74hVc975w0ssR9de8yexOaTct+BP81a/Me/noQWyy78MXvjcw15uK9eyvnGa28Z3qckWQVLo3JK4KGcLBXf2VOXGzYJ62x46e1op4N9sV16vb1HhCF28iw1oq5ohosdIlfAVkTbKKDamj59NgBnPlqyemym7OFpKDs+ElHHuMvPwX7lciPD//ecVOS6xfxYL8R2aVuCycpns+v5zP9gR7VayOgTP5BmNuVDNI1YvPd5x5jiR9bMa2w3yEZqCH68rzpyt7oiuX4l6buOOTMFYOo4VbQ+dT1oqs4L3N4JPUBkRxcZqo/z8UhEBDua2+cxuzMqr9WcJgpj5J1n6uloAMzVbpt7unYXRPTh9XwFZLIOYG
x-ms-exchange-antispam-messagedata: bghWANjP4F5DrDR2Pn91YFmx0OJ3Tbx0n9bWTGO91VK3aRiWV8u9qfrG+fEISeCteUuxkY9ZaoOfRtN67OCXL1NU3Ge3JD73e//RXflX0bIlo05SF30kx7zz+gCnvbKv6tMb/c0hKJvdzUcEnxwitw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a80f697-9d4e-4252-c379-08d7e76db912
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:04:33.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rANNpRxQIv1GZvqwx8fuYl8HU9XhqMElw4LFU80jwmsNUMBzOtOELeZZMNMFe6k4OeApe+DvkpEele+QFZJIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDM6MDAgUE0NCj4gDQo+IEFkZCByZXNvdXJjZSBtYW5hZ2VtZW50IEFQSSwg
d2hlbiB3ZSBoYXZlIG11bHRpcGxlIHBhcnRpdGlvbiBydW5uaW5nDQo+IHRvZ2V0aGVyLCByZXNv
dXJjZXMgbm90IG93bmVkIHRvIGN1cnJlbnQgcGFydGl0aW9uIHNob3VsZCBub3QgYmUgdXNlZC4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0KUmln
aHQgbm93IEknbSBzdGlsbCBub3QgcXVpdGUgdW5kZXJzdGFuZCBpZiB3ZSByZWFsbHkgbmVlZCB0
aGlzLg0KQXMgY3VycmVudCByZXNvdXJjZSBpcyBib3VuZCB0byBwb3dlciBkb21haW5zLCBpZiBp
dCdzIG5vdCBvd25lZCBieSBvbmUgc3BlY2lmaWMNClNXIGV4ZWN1dGlvbiBlbnZpcm9ubWVudCwg
cG93ZXIgb24gd2lsbCBhbHNvIGZhaWwuDQpDYW4geW91IGNsYXJpZnkgaWYgYW55IGV4Y2VwdGlv
bnM/DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvaW14
L01ha2VmaWxlICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMgICAg
ICAgICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L2Zpcm13
YXJlL2lteC9zY2kuaCAgICB8ICAxICsNCj4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2
Yy9ybS5oIHwgNjkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
NCBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKSAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+IGRyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMgIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaA0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlIGIvZHJpdmVycy9maXJtd2FyZS9p
bXgvTWFrZWZpbGUNCj4gaW5kZXggMDhiYzlkZGZiZGZiLi4xN2VhMzYxM2UxNDIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvZmly
bXdhcmUvaW14L01ha2VmaWxlDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAgIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMA0KPiAgb2JqLSQoQ09ORklHX0lNWF9EU1ApCQkrPSBpbXgtZHNw
Lm8NCj4gLW9iai0kKENPTkZJR19JTVhfU0NVKQkJKz0gaW14LXNjdS5vIG1pc2MubyBpbXgtc2N1
LWlycS5vDQo+ICtvYmotJChDT05GSUdfSU1YX1NDVSkJCSs9IGlteC1zY3UubyBtaXNjLm8gaW14
LXNjdS1pcnEubyBybS5vDQo+ICBvYmotJChDT05GSUdfSU1YX1NDVV9QRCkJKz0gc2N1LXBkLm8N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMgYi9kcml2ZXJzL2Zpcm13
YXJlL2lteC9ybS5jIG5ldyBmaWxlDQo+IG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4u
N2IwMzM0ZGU1NDg2DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9p
bXgvcm0uYw0KPiBAQCAtMCwwICsxLDQwIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMCsNCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgMjAyMCBOWFANCj4gKyAqDQo+ICsg
KiBGaWxlIGNvbnRhaW5pbmcgY2xpZW50LXNpZGUgUlBDIGZ1bmN0aW9ucyBmb3IgdGhlIFJNIHNl
cnZpY2UuIFRoZXNlDQo+ICsgKiBmdW5jdGlvbiBhcmUgcG9ydGVkIHRvIGNsaWVudHMgdGhhdCBj
b21tdW5pY2F0ZSB0byB0aGUgU0MuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2Zp
cm13YXJlL2lteC9zdmMvcm0uaD4NCj4gKw0KPiArc3RydWN0IGlteF9zY19tc2dfcm1fcnNyY19v
d25lZCB7DQo+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gKwl1MTYgcmVzb3VyY2U7
DQo+ICt9IF9fcGFja2VkIF9fYWxpZ25lZCg0KTsNCj4gKw0KPiArLyoNCj4gKyAqIFRoaXMgZnVu
Y3Rpb24gY2hlY2sgQHJlc291cmNlIGlzIG93bmVkIGJ5IGN1cnJlbnQgcGFydGl0aW9uIG9yIG5v
dA0KPiArICoNCj4gKyAqIEBwYXJhbVtpbl0gICAgIGlwYyAgICAgICAgIElQQyBoYW5kbGUNCj4g
KyAqIEBwYXJhbVtpbl0gICAgIHJlc291cmNlICAgIHJlc291cmNlIHRoZSBjb250cm9sIGlzIGFz
c29jaWF0ZWQgd2l0aA0KPiArICoNCj4gKyAqIEByZXR1cm4gUmV0dXJucyAwIGZvciBzdWNjZXNz
IGFuZCA8IDAgZm9yIGVycm9ycy4NCj4gKyAqLw0KPiArYm9vbCBpbXhfc2Nfcm1faXNfcmVzb3Vy
Y2Vfb3duZWQoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTE2IHJlc291cmNlKQ0KPiArew0KPiAr
CXN0cnVjdCBpbXhfc2NfbXNnX3JtX3JzcmNfb3duZWQgbXNnOw0KPiArCXN0cnVjdCBpbXhfc2Nf
cnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ICsNCj4gKwloZHItPnZlciA9IElNWF9TQ19SUENf
VkVSU0lPTjsNCj4gKwloZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX1JNOw0KPiArCWhkci0+ZnVu
YyA9IElNWF9TQ19STV9GVU5DX0lTX1JFU09VUkNFX09XTkVEOw0KPiArCWhkci0+c2l6ZSA9IDI7
DQo+ICsNCj4gKwltc2cucmVzb3VyY2UgPSByZXNvdXJjZTsNCj4gKw0KPiArCWlteF9zY3VfY2Fs
bF9ycGMoaXBjLCAmbXNnLCB0cnVlKTsNCj4gKw0KPiArCXJldHVybiBoZHItPmZ1bmM7DQo+ICt9
DQo+ICtFWFBPUlRfU1lNQk9MKGlteF9zY19ybV9pc19yZXNvdXJjZV9vd25lZCk7DQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaCBiL2luY2x1ZGUvbGludXgv
ZmlybXdhcmUvaW14L3NjaS5oDQo+IGluZGV4IDE3YmE0ZTQwNTEyOS4uYjVjNWE1NmYyOWJlIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0KPiArKysgYi9p
bmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0KPiBAQCAtMTUsNiArMTUsNyBAQA0KPiAN
Cj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaD4gICNpbmNsdWRlDQo+
IDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3BtLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZmlybXdh
cmUvaW14L3N2Yy9ybS5oPg0KPiANCj4gIGludCBpbXhfc2N1X2VuYWJsZV9nZW5lcmFsX2lycV9j
aGFubmVsKHN0cnVjdCBkZXZpY2UgKmRldik7ICBpbnQNCj4gaW14X3NjdV9pcnFfcmVnaXN0ZXJf
bm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7IGRpZmYgLS1naXQNCj4gYS9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaCBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUv
aW14L3N2Yy9ybS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAw
MC4uZmM2ZWE2MmQ5ZDBlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9saW51eC9m
aXJtd2FyZS9pbXgvc3ZjL3JtLmgNCj4gQEAgLTAsMCArMSw2OSBAQA0KPiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChDKSAy
MDE2IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ICsgKiBDb3B5cmlnaHQgMjAxNy0y
MDE5IE5YUA0KPiArICoNCj4gKyAqIEhlYWRlciBmaWxlIGNvbnRhaW5pbmcgdGhlIHB1YmxpYyBB
UEkgZm9yIHRoZSBTeXN0ZW0gQ29udHJvbGxlciAoU0MpDQo+ICsgKiBQb3dlciBNYW5hZ2VtZW50
IChQTSkgZnVuY3Rpb24uIFRoaXMgaW5jbHVkZXMgZnVuY3Rpb25zIGZvciBwb3dlcg0KPiArc3Rh
dGUNCj4gKyAqIGNvbnRyb2wsIGNsb2NrIGNvbnRyb2wsIHJlc2V0IGNvbnRyb2wsIGFuZCB3YWtl
LXVwIGV2ZW50IGNvbnRyb2wuDQo+ICsgKg0KPiArICogUk1fU1ZDIChTVkMpIFJlc291cmNlIE1h
bmFnZW1lbnQgU2VydmljZQ0KPiArICoNCj4gKyAqIE1vZHVsZSBmb3IgdGhlIFJlc291cmNlIE1h
bmFnZW1lbnQgKFJNKSBzZXJ2aWNlLg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgX1NDX1JNX0FQ
SV9IDQo+ICsjZGVmaW5lIF9TQ19STV9BUElfSA0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvZmly
bXdhcmUvaW14L3NjaS5oPg0KPiArDQo+ICsvKg0KPiArICogVGhpcyB0eXBlIGlzIHVzZWQgdG8g
aW5kaWNhdGUgUlBDIFJNIGZ1bmN0aW9uIGNhbGxzLg0KPiArICovDQo+ICtlbnVtIGlteF9zY19y
bV9mdW5jIHsNCj4gKwlJTVhfU0NfUk1fRlVOQ19VTktOT1dOID0gMCwNCj4gKwlJTVhfU0NfUk1f
RlVOQ19QQVJUSVRJT05fQUxMT0MgPSAxLA0KPiArCUlNWF9TQ19STV9GVU5DX1NFVF9DT05GSURF
TlRJQUwgPSAzMSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19QQVJUSVRJT05fRlJFRSA9IDIsDQo+ICsJ
SU1YX1NDX1JNX0ZVTkNfR0VUX0RJRCA9IDI2LA0KPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElP
Tl9TVEFUSUMgPSAzLA0KPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9MT0NLID0gNCwNCj4g
KwlJTVhfU0NfUk1fRlVOQ19HRVRfUEFSVElUSU9OID0gNSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19T
RVRfUEFSRU5UID0gNiwNCj4gKwlJTVhfU0NfUk1fRlVOQ19NT1ZFX0FMTCA9IDcsDQo+ICsJSU1Y
X1NDX1JNX0ZVTkNfQVNTSUdOX1JFU09VUkNFID0gOCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRf
UkVTT1VSQ0VfTU9WQUJMRSA9IDksDQo+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1NVQlNZU19SU1JD
X01PVkFCTEUgPSAyOCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX0FUVFJJQlVURVMg
PSAxMCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX1NJRCA9IDExLA0KPiArCUlNWF9T
Q19STV9GVU5DX1NFVF9QRVJJUEhFUkFMX1BFUk1JU1NJT05TID0gMTIsDQo+ICsJSU1YX1NDX1JN
X0ZVTkNfSVNfUkVTT1VSQ0VfT1dORUQgPSAxMywNCj4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfUkVT
T1VSQ0VfT1dORVIgPSAzMywNCj4gKwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9NQVNURVIg
PSAxNCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9QRVJJUEhFUkFMID0gMTUsDQo+
ICsJSU1YX1NDX1JNX0ZVTkNfR0VUX1JFU09VUkNFX0lORk8gPSAxNiwNCj4gKwlJTVhfU0NfUk1f
RlVOQ19NRU1SRUdfQUxMT0MgPSAxNywNCj4gKwlJTVhfU0NfUk1fRlVOQ19NRU1SRUdfU1BMSVQg
PSAyOSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19NRU1SRUdfRlJBRyA9IDMyLA0KPiArCUlNWF9TQ19S
TV9GVU5DX01FTVJFR19GUkVFID0gMTgsDQo+ICsJSU1YX1NDX1JNX0ZVTkNfRklORF9NRU1SRUcg
PSAzMCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19BU1NJR05fTUVNUkVHID0gMTksDQo+ICsJSU1YX1ND
X1JNX0ZVTkNfU0VUX01FTVJFR19QRVJNSVNTSU9OUyA9IDIwLA0KPiArCUlNWF9TQ19STV9GVU5D
X0lTX01FTVJFR19PV05FRCA9IDIxLA0KPiArCUlNWF9TQ19STV9GVU5DX0dFVF9NRU1SRUdfSU5G
TyA9IDIyLA0KPiArCUlNWF9TQ19STV9GVU5DX0FTU0lHTl9QQUQgPSAyMywNCj4gKwlJTVhfU0Nf
Uk1fRlVOQ19TRVRfUEFEX01PVkFCTEUgPSAyNCwNCj4gKwlJTVhfU0NfUk1fRlVOQ19JU19QQURf
T1dORUQgPSAyNSwNCj4gKwlJTVhfU0NfUk1fRlVOQ19EVU1QID0gMjcsDQo+ICt9Ow0KPiArDQo+
ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfSU1YX1NDVSkNCj4gK2Jvb2wgaW14X3NjX3JtX2lzX3Jl
c291cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUxNiByZXNvdXJjZSk7DQo+ICsj
ZWxzZSBzdGF0aWMgaW5saW5lIGJvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVj
dCBpbXhfc2NfaXBjDQo+ICsqaXBjLCB1MTYgcmVzb3VyY2UpIHsNCj4gKwlyZXR1cm4gdHJ1ZTsN
Cj4gK30NCj4gKyNlbmRpZg0KPiArI2VuZGlmDQo+IC0tDQo+IDIuMTYuNA0KDQo=
