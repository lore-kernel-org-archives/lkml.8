Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A309C206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="msSkVLst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgFBHMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:12:40 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:23109
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbgFBHMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3EfUZMDoslAjrFNJKCAt9s1lKoXbkxz1z0c/J6JfbCQ/KHU4Zx1XWV9ZTrIdJB+qG9rkqB6vgD5qgCV7IxDKnwGEG0vQ/EAL5Wa3VVk/0+ZSTyVjBm57qXamTBmnzcCAuNgUrG5BkuNEFPvek0BRf6xJ0dPn0OwkuW4YjweR7UuRMeDE/VKKbgo4D6jEtdaK7jFCx90pGjxL0H7aUjSnNMfB6tVyIpdkJTBU7AlEIGQaqLA/bANdPGWifbJfe+elg9VgAwXGVMPnkIE4EdgGAxBTd4j7LIS4MuYY7nYPtEBFCTCkLULgoqAqk+JGv/Jx/PHOnWlGwH/mBbHz0zalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsxmZ/YLu7JJW2OouJhks77DKqu4qeSXkNgNvYah7g8=;
 b=in3xcik2E72JX6jR9VyK0Ddk4monPpRZVlr3xRvs+O9Yrv9pTrFM21f9vTlMBFlw6IjxNzFBEdnHiJU7LVH4+gF++7LxwJE8Yv7rQJzUSznmIVbAFpBS6cveu+sJ1zJG3PPpKeUk2K1wssW9Hkb7+Nvn50ozaOunfC0Mt1qRXSUID8fWFOYNq79nqCCQnkTGKt7XwISna+9389GKOiKV3iZMOZ5uYJBde+zVNeLkEnTko+vFSoVvaSFe/GbwkutDmrFm/88K3YMcg2e7p6+THNmjXlQ5Dh7lFsd0LuCmpM4k6wjQ0HnUPvegQ0FwpuP4OLwK1exLde628s87C9fSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsxmZ/YLu7JJW2OouJhks77DKqu4qeSXkNgNvYah7g8=;
 b=msSkVLst3vKF1CkOoUJpOHRXpEOn0//aR1kGpWtFC6vV4RrKfU3yiHzhs1vGdQqUVcSrwWHc2HudZob9eK0X0KmHnGwDB+v6yqs3znisyxNgXOkBcCWhYGIFVPj5VdruwF6TSFIb/SGDs0dgLVYZrgajvXhmrO9B0Q9R0QhjINo=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5061.eurprd04.prod.outlook.com (2603:10a6:20b:9::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Tue, 2 Jun
 2020 07:12:32 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 07:12:32 +0000
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
Thread-Index: AQHWGT38Z8g88FkqQ0uX8uLlRjqzhqjE34aAgAAp6oCAAB4oMA==
Date:   Tue, 2 Jun 2020 07:12:32 +0000
Message-ID: <AM6PR04MB49669AFB17E0FC1ABB6C6994808B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966DA95F44FA63CDEF7E4F5808B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760C2AC0CAEF7D8EEB1CA49888B0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760C2AC0CAEF7D8EEB1CA49888B0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66ecf813-ec98-46ee-9ae0-08d806c451bd
x-ms-traffictypediagnostic: AM6PR04MB5061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB506106AD07C1D7BFF755E4F7808B0@AM6PR04MB5061.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQ/cV9MjgVbMJF3OCu7o8nm53ED8/T5tG3Oq4yJaWvr9lwZjgy+M8btZdXWabWFpegF6csTIGmf35LHxDkbwO7AcjaCj29T4nCqCTMYVJVLd3+anDhMi9rqDzEKCUMRCdGWCP9lDxV+vl6zaZEMvP76721EA/Or4OOQ6G2Fm76GoV0aUgYWH56Fll6nJYrc67j8WyMmGAbwWExx+BgdRF7DiMeOZLVADHzOuY40ddN8HQEh7TMriJJN5NwxjIFXVzEFXn9w+5Zvhjb7gj/3JrR7IXgDhIgeoFEtFmJjfMFR39NOU8oIqWAeqvtrTq0YAA8MEDjpewJ5Bl8qgk1G5og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(7696005)(478600001)(52536014)(9686003)(110136005)(66946007)(2906002)(53546011)(8676002)(55016002)(6506007)(33656002)(44832011)(8936002)(54906003)(26005)(316002)(83380400001)(5660300002)(4326008)(76116006)(64756008)(66476007)(66556008)(66446008)(186003)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6miIeCzGxVv4JbW5TdY/hG9Ne15J2fsJGh6UEBAb2NxP9fvEzjjQu3rkAAc2N9MxEpSFrq4s5Xp5V9TMPWanBndKHaXX7ahsz4Fc9PqxLRUsN9T6o+CfG84LGaWLydgQuScd9PDXkqgmA8gjDyTNZVKYEZR1JYnCwc0lDNqZbR2pauSAC+ItBxcLQpP/LSsD7xD2YcawZwWpt3HYsvvcm5HRsTGgPKcrxfcCjLeFbx4RYUMoz/VUIrbLOGX+3Y4O+TkrG8EWAPp/FgIc6gLvHjBhikcbL3b+YKcR29MJVZjbnYMyVv5ainQyaxwT/H+k7S96Tge3nN7y3JbBh9sva6kl03Dd3GQIq/aNkKMA0aHAqc01qtjH4RA3ICuJzJFEbyyhXFMv8EWxBPhcIiTxauhSlHR3SOlHeU+FA/2HJmL87AzIfpmV+QhE9AxcFtOK5QVzd2cxTuttkwwaERXwYdk/LLXEaImvs+0/0GyuhMBW/QfvTNiYewfNDSmGSjiL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ecf813-ec98-46ee-9ae0-08d806c451bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 07:12:32.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAVoOImy7naqak1kckJsLgXQePDngzkk0n1iVoswFxGT97GWCS42A7EjhTu2emD0aFCsVOmG9Y32tWqUh4bf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVu
ZSAyLCAyMDIwIDE6MjQgUE0NCj4gDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzRdIGZpcm13
YXJlOiBpbXg6IGFkZCByZXNvdXJjZSBtYW5hZ2VtZW50IGFwaQ0KPiA+DQo+ID4gPiBGcm9tOiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAy
MywgMjAyMCAzOjAwIFBNDQo+ID4gPg0KPiA+ID4gQWRkIHJlc291cmNlIG1hbmFnZW1lbnQgQVBJ
LCB3aGVuIHdlIGhhdmUgbXVsdGlwbGUgcGFydGl0aW9uIHJ1bm5pbmcNCj4gPiA+IHRvZ2V0aGVy
LCByZXNvdXJjZXMgbm90IG93bmVkIHRvIGN1cnJlbnQgcGFydGl0aW9uIHNob3VsZCBub3QgYmUg
dXNlZC4NCj4gPiA+DQo+ID4gPiBSZXZpZXdlZC1ieTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJk
LmNyZXN0ZXpAbnhwLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvTWFrZWZp
bGUgICAgICAgfCAgMiArLQ0KPiA+ID4gIGRyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMgICAgICAg
ICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgaW5jbHVkZS9saW51eC9maXJt
d2FyZS9pbXgvc2NpLmggICAgfCAgMSArDQo+ID4gPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9p
bXgvc3ZjL3JtLmggfCA2OQ0KPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkgIGNyZWF0ZSBtb2RlDQo+ID4gPiAxMDA2NDQgZHJpdmVycy9maXJtd2FyZS9pbXgvcm0u
YyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9z
dmMvcm0uaA0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9N
YWtlZmlsZQ0KPiA+ID4gYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSBpbmRleCAwOGJj
OWRkZmJkZmIuLjE3ZWEzNjEzZTE0Mg0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L2Zpcm13YXJlL2lteC9NYWtlZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgv
TWFrZWZpbGUNCj4gPiA+IEBAIC0xLDQgKzEsNCBAQA0KPiA+ID4gICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4gPiA+ICBvYmotJChDT05GSUdfSU1YX0RTUCkJCSs9IGlteC1k
c3Aubw0KPiA+ID4gLW9iai0kKENPTkZJR19JTVhfU0NVKQkJKz0gaW14LXNjdS5vIG1pc2MubyBp
bXgtc2N1LWlycS5vDQo+ID4gPiArb2JqLSQoQ09ORklHX0lNWF9TQ1UpCQkrPSBpbXgtc2N1Lm8g
bWlzYy5vIGlteC1zY3UtaXJxLm8gcm0ubw0KPiA+ID4gIG9iai0kKENPTkZJR19JTVhfU0NVX1BE
KQkrPSBzY3UtcGQubw0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L3Jt
LmMgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9ybS5jDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NCBpbmRleCAwMDAwMDAwMDAwMDAuLjdiMDMzNGRlNTQ4Ng0KPiA+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvcm0uYw0KPiA+ID4gQEAgLTAsMCArMSw0
MCBAQA0KPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ID4g
Ky8qDQo+ID4gPiArICogQ29weXJpZ2h0IDIwMjAgTlhQDQo+ID4gPiArICoNCj4gPiA+ICsgKiBG
aWxlIGNvbnRhaW5pbmcgY2xpZW50LXNpZGUgUlBDIGZ1bmN0aW9ucyBmb3IgdGhlIFJNIHNlcnZp
Y2UuDQo+ID4gPiArVGhlc2UNCj4gPiA+ICsgKiBmdW5jdGlvbiBhcmUgcG9ydGVkIHRvIGNsaWVu
dHMgdGhhdCBjb21tdW5pY2F0ZSB0byB0aGUgU0MuDQo+ID4gPiArICovDQo+ID4gPiArDQo+ID4g
PiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaD4NCj4gPiA+ICsNCj4gPiA+
ICtzdHJ1Y3QgaW14X3NjX21zZ19ybV9yc3JjX293bmVkIHsNCj4gPiA+ICsJc3RydWN0IGlteF9z
Y19ycGNfbXNnIGhkcjsNCj4gPiA+ICsJdTE2IHJlc291cmNlOw0KPiA+ID4gK30gX19wYWNrZWQg
X19hbGlnbmVkKDQpOw0KPiA+ID4gKw0KPiA+ID4gKy8qDQo+ID4gPiArICogVGhpcyBmdW5jdGlv
biBjaGVjayBAcmVzb3VyY2UgaXMgb3duZWQgYnkgY3VycmVudCBwYXJ0aXRpb24gb3INCj4gPiA+
ICtub3QNCj4gPiA+ICsgKg0KPiA+ID4gKyAqIEBwYXJhbVtpbl0gICAgIGlwYyAgICAgICAgIElQ
QyBoYW5kbGUNCj4gPiA+ICsgKiBAcGFyYW1baW5dICAgICByZXNvdXJjZSAgICByZXNvdXJjZSB0
aGUgY29udHJvbCBpcyBhc3NvY2lhdGVkIHdpdGgNCj4gPiA+ICsgKg0KPiA+ID4gKyAqIEByZXR1
cm4gUmV0dXJucyAwIGZvciBzdWNjZXNzIGFuZCA8IDAgZm9yIGVycm9ycy4NCj4gPiA+ICsgKi8N
Cj4gPiA+ICtib29sIGlteF9zY19ybV9pc19yZXNvdXJjZV9vd25lZChzdHJ1Y3QgaW14X3NjX2lw
YyAqaXBjLCB1MTYNCj4gPiA+ICtyZXNvdXJjZSkgew0KPiA+ID4gKwlzdHJ1Y3QgaW14X3NjX21z
Z19ybV9yc3JjX293bmVkIG1zZzsNCj4gPiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIg
PSAmbXNnLmhkcjsNCj4gPiA+ICsNCj4gPiA+ICsJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJ
T047DQo+ID4gPiArCWhkci0+c3ZjID0gSU1YX1NDX1JQQ19TVkNfUk07DQo+ID4gPiArCWhkci0+
ZnVuYyA9IElNWF9TQ19STV9GVU5DX0lTX1JFU09VUkNFX09XTkVEOw0KPiA+ID4gKwloZHItPnNp
emUgPSAyOw0KPiA+ID4gKw0KPiA+ID4gKwltc2cucmVzb3VyY2UgPSByZXNvdXJjZTsNCj4gPiA+
ICsNCj4gPiA+ICsJaW14X3NjdV9jYWxsX3JwYyhpcGMsICZtc2csIHRydWUpOw0KPiA+DQo+ID4g
Tm8gbmVlZCBjaGVjayBlcnIgcmV0dXJuPw0KPiANCj4gTm8uIGl0IHVzZSBoZHItPmZ1bmMgYXMg
dGhlIHJlc291cmNlIG93bmVyIGJvb2wuDQo+IEhvd2V2ZXIgaW14X3NjdV9jYWxsX3JwYyBhbHNv
IHVzZSBoZHItPmZ1bmMgdG8gY2hlY2sgZXJyb3IgdmFsdWUgb3Igbm90Lg0KPiANCj4gV2hlbiBo
ZHItPmZ1bmMgaXMgMSwgaW14X3NjX3RvX2xpbnV4X2Vycm5vIHdpbGwgcmVwb3J0IGl0IC1FSU5W
QUwuIEhvd2V2ZXINCj4gaGVyZSAxIG1lYW5zIG5vdCBvd25lZC4NCg0KRm9yIHRoaXMgc3BlY2lh
bCBjYXNlLCBwbHMgYWRkIGEgY29kZSBjb21tZW50IGFib3V0IGl0Lg0KUmVmZXIgdG86DQpkcml2
ZXJzL2lucHV0L2tleWJvYXJkL2lteF9zY19wd3JrZXkuYw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoN
Cj4gDQo+ID4NCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIGhkci0+ZnVuYzsNCj4gPiA+ICt9DQo+
ID4gPiArRVhQT1JUX1NZTUJPTChpbXhfc2Nfcm1faXNfcmVzb3VyY2Vfb3duZWQpOw0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gPiBiL2lu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gPiBpbmRleCAxN2JhNGU0MDUxMjku
LmI1YzVhNTZmMjliZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUv
aW14L3NjaS5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0K
PiA+ID4gQEAgLTE1LDYgKzE1LDcgQEANCj4gPiA+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zp
cm13YXJlL2lteC9zdmMvbWlzYy5oPiAgI2luY2x1ZGUNCj4gPiA+IDxsaW51eC9maXJtd2FyZS9p
bXgvc3ZjL3BtLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0u
aD4NCj4gPiA+DQo+ID4gPiAgaW50IGlteF9zY3VfZW5hYmxlX2dlbmVyYWxfaXJxX2NoYW5uZWwo
c3RydWN0IGRldmljZSAqZGV2KTsgIGludA0KPiA+ID4gaW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90
aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7IGRpZmYgLS1naXQNCj4gPiA+IGEvaW5j
bHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmgNCj4gPiA+IGIvaW5jbHVkZS9saW51eC9m
aXJtd2FyZS9pbXgvc3ZjL3JtLmgNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLmZjNmVhNjJkOWQwZQ0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmgNCj4gPiA+IEBAIC0w
LDAgKzEsNjkgQEANCj4gPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsg
Ki8NCj4gPiA+ICsvKg0KPiA+ID4gKyAqIENvcHlyaWdodCAoQykgMjAxNiBGcmVlc2NhbGUgU2Vt
aWNvbmR1Y3RvciwgSW5jLg0KPiA+ID4gKyAqIENvcHlyaWdodCAyMDE3LTIwMTkgTlhQDQo+ID4N
Cj4gPiBVcGRhdGUgY29weXJpZ2h0DQo+IA0KPiBvaw0KPiANCj4gPg0KPiA+ID4gKyAqDQo+ID4g
PiArICogSGVhZGVyIGZpbGUgY29udGFpbmluZyB0aGUgcHVibGljIEFQSSBmb3IgdGhlIFN5c3Rl
bSBDb250cm9sbGVyDQo+ID4gPiArKFNDKQ0KPiA+ID4gKyAqIFBvd2VyIE1hbmFnZW1lbnQgKFBN
KSBmdW5jdGlvbi4gVGhpcyBpbmNsdWRlcyBmdW5jdGlvbnMgZm9yDQo+ID4gPiArcG93ZXIgc3Rh
dGUNCj4gPiA+ICsgKiBjb250cm9sLCBjbG9jayBjb250cm9sLCByZXNldCBjb250cm9sLCBhbmQg
d2FrZS11cCBldmVudCBjb250cm9sLg0KPiA+DQo+ID4gRml4IHRoZSBjb2RlIGNvbW1lbnRzDQo+
ID4NCj4gPiBPdGhlcndpc2UsIEknbSBmaW5lIHdpdGggdGhpcyBwYXRjaC4NCj4gT2suDQo+IA0K
PiBUaGFua3MsDQo+IFBlbmcuDQo+IA0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+IEFpc2hlbmcNCj4g
Pg0KPiA+ID4gKyAqDQo+ID4gPiArICogUk1fU1ZDIChTVkMpIFJlc291cmNlIE1hbmFnZW1lbnQg
U2VydmljZQ0KPiA+ID4gKyAqDQo+ID4gPiArICogTW9kdWxlIGZvciB0aGUgUmVzb3VyY2UgTWFu
YWdlbWVudCAoUk0pIHNlcnZpY2UuDQo+ID4gPiArICovDQo+ID4gPiArDQo+ID4gPiArI2lmbmRl
ZiBfU0NfUk1fQVBJX0gNCj4gPiA+ICsjZGVmaW5lIF9TQ19STV9BUElfSA0KPiA+ID4gKw0KPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQo+ID4gPiArDQo+ID4gPiAr
LyoNCj4gPiA+ICsgKiBUaGlzIHR5cGUgaXMgdXNlZCB0byBpbmRpY2F0ZSBSUEMgUk0gZnVuY3Rp
b24gY2FsbHMuDQo+ID4gPiArICovDQo+ID4gPiArZW51bSBpbXhfc2Nfcm1fZnVuYyB7DQo+ID4g
PiArCUlNWF9TQ19STV9GVU5DX1VOS05PV04gPSAwLA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19Q
QVJUSVRJT05fQUxMT0MgPSAxLA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfQ09ORklERU5U
SUFMID0gMzEsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9GUkVFID0gMiwNCj4g
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfR0VUX0RJRCA9IDI2LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVO
Q19QQVJUSVRJT05fU1RBVElDID0gMywNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfUEFSVElUSU9O
X0xPQ0sgPSA0LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfUEFSVElUSU9OID0gNSwNCj4g
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1BBUkVOVCA9IDYsDQo+ID4gPiArCUlNWF9TQ19STV9G
VU5DX01PVkVfQUxMID0gNywNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfQVNTSUdOX1JFU09VUkNF
ID0gOCwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1JFU09VUkNFX01PVkFCTEUgPSA5LA0K
PiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfU1VCU1lTX1JTUkNfTU9WQUJMRSA9IDI4LA0KPiA+
ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUFTVEVSX0FUVFJJQlVURVMgPSAxMCwNCj4gPiA+ICsJ
SU1YX1NDX1JNX0ZVTkNfU0VUX01BU1RFUl9TSUQgPSAxMSwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZV
TkNfU0VUX1BFUklQSEVSQUxfUEVSTUlTU0lPTlMgPSAxMiwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZV
TkNfSVNfUkVTT1VSQ0VfT1dORUQgPSAxMywNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfR0VUX1JF
U09VUkNFX09XTkVSID0gMzMsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0lTX1JFU09VUkNFX01B
U1RFUiA9IDE0LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9QRVJJUEhFUkFM
ID0gMTUsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0dFVF9SRVNPVVJDRV9JTkZPID0gMTYsDQo+
ID4gPiArCUlNWF9TQ19STV9GVU5DX01FTVJFR19BTExPQyA9IDE3LA0KPiA+ID4gKwlJTVhfU0Nf
Uk1fRlVOQ19NRU1SRUdfU1BMSVQgPSAyOSwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfTUVNUkVH
X0ZSQUcgPSAzMiwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfTUVNUkVHX0ZSRUUgPSAxOCwNCj4g
PiA+ICsJSU1YX1NDX1JNX0ZVTkNfRklORF9NRU1SRUcgPSAzMCwNCj4gPiA+ICsJSU1YX1NDX1JN
X0ZVTkNfQVNTSUdOX01FTVJFRyA9IDE5LA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfTUVN
UkVHX1BFUk1JU1NJT05TID0gMjAsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0lTX01FTVJFR19P
V05FRCA9IDIxLA0KPiA+ID4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfTUVNUkVHX0lORk8gPSAyMiwN
Cj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfQVNTSUdOX1BBRCA9IDIzLA0KPiA+ID4gKwlJTVhfU0Nf
Uk1fRlVOQ19TRVRfUEFEX01PVkFCTEUgPSAyNCwNCj4gPiA+ICsJSU1YX1NDX1JNX0ZVTkNfSVNf
UEFEX09XTkVEID0gMjUsDQo+ID4gPiArCUlNWF9TQ19STV9GVU5DX0RVTVAgPSAyNywNCj4gPiA+
ICt9Ow0KPiA+ID4gKw0KPiA+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19JTVhfU0NVKQ0KPiA+
ID4gK2Jvb2wgaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICpp
cGMsIHUxNg0KPiA+ID4gK3Jlc291cmNlKTsgI2Vsc2Ugc3RhdGljIGlubGluZSBib29sDQo+ID4g
PiAraW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUx
NiByZXNvdXJjZSkgew0KPiA+ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiA+ICt9DQo+ID4gPiArI2Vu
ZGlmDQo+ID4gPiArI2VuZGlmDQo+ID4gPiAtLQ0KPiA+ID4gMi4xNi40DQoNCg==
