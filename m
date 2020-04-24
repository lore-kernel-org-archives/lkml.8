Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB9C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0128120728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HiHOu5fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDXDPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:15:17 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:6178
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgDXDPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:15:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO+zbsT+gdUvTmZOx3X4olr6SppBeK+L2JYas5TVlYxZ2V6jr3/MuIgEQ2I4tcShOcUrM/SlnyEiT51cuwg4+8yQL6YTwlBq7NTxifBFVNzk+ctSUZQic1PfA4YEU0Ils+0nUq7eKafLiPO7wqZBBGC2DOR2K5DIe37Dxu6FAbfwJisVObB6tOq0Ro97fFAMlofwvPWjLLaob0ffP7NvqsFVQ5m8igm/9yuhgseX13IxoJjZUH7Sk479bB5uxSkuxJ+bAZrQZj1HZI7ylYnNgfUGodjC1SSVj1qmAxemenCEb2cpccY7vae2rSJ8+N9ZDWX0qn5247yDGUQvGC6Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Tv0N8kijGl1KhcR0VDit+04WjnE44e4//m4BpBLFk=;
 b=f0gZopDnbSumixsGlr8RwLSb4d9abgIlkQoDXazEaHgLBs3N1Tc0uVnfFtS6NpHy8OjBPRRByyfq0YenGiTsPVg7DfmHZgIIhdeNpjMXlcCVlcyLDTsw7one1wlX2mmwX/2BGHbYDAjZ1aC0+UgkQ4dE6O9XSt4J18Ih4Dmxcb8GZDt9d0dIRxgcjcdITiOmSoW3+E08FTIrWr2BxdA6UEO2988nPHXYIhKCUlRbP4g7q/3qCZ2rC1Ibpqir7Gn+Qi90Bxtgmdwh1QtS9s6TKmqqZz5b0VSnj2QM9uxB00+e1cHipf8ZiXOXpjtbDadTzsU3fWtRhsa1KnmHwdQrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Tv0N8kijGl1KhcR0VDit+04WjnE44e4//m4BpBLFk=;
 b=HiHOu5fF/PuUf97uEz8G8yUTS8kVt2ZmurhCxVfKrr4IH6BBq1WE/4ntm+KlGX6yL1R4A1nSkaDENvI/shuL4B3+HCWWAm8GHZYAj2TVv0vajC54kwQfMTVlwRd1KkawFq5WzH05vs3mYqUINQNtoKe6+GVaaWoLYuePmAPUf2c=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4791.eurprd04.prod.outlook.com (2603:10a6:20b:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 03:15:10 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 03:15:10 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Thread-Topic: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Thread-Index: AQHWGcUy/MHx513YSkqpWUZybaROrqiHjXLggAABSQCAAAEoAIAAA6+AgAAFLhA=
Date:   Fri, 24 Apr 2020 03:15:10 +0000
Message-ID: <AM6PR04MB49664B014A9C1BE4CB977FA480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
 <1587683231-18468-2-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB496669637FE86E928B9E0EBE80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB391699FFA107CD570B943705F5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB49668CCFFB4439B051E99A3B80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F906513074C97A8B4AA7F5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916F906513074C97A8B4AA7F5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01853220-4ac6-4578-7e84-08d7e7fdb2c4
x-ms-traffictypediagnostic: AM6PR04MB4791:|AM6PR04MB4791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB47910F96D6A7C53C19826A1B80D00@AM6PR04MB4791.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(186003)(9686003)(5660300002)(33656002)(110136005)(55016002)(316002)(81156014)(76116006)(66446008)(66946007)(86362001)(66476007)(66556008)(2906002)(8936002)(71200400001)(8676002)(52536014)(64756008)(478600001)(4326008)(6506007)(26005)(44832011)(7696005)(53546011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdcsPjnmwR7vRn/5Il5PuPGz2sbQMN01dVswroC4WSjy6GSrsQACyNJ7QqNrOE+4p4iBwSJ79YIOpD1SZcFYbmjmnLTKYOKCA2tk+SiiJJACR+xJ9sN3VY7t07FvCz/uz0Ruw98ezcCEKfoyLXCq0SpJmA5/FYN7uQESEiITFiDSqeWaExIZc+P+lf2OXjAJkolAiq46+HYgKuaZ7wWYHa178DyMy5tnpafokEpGmX9aXInA+R9SvSZQR4zsggjpJEnhaxhSgFJOpC3dWbVQskzG1S2aPBxS89bZjJ/d6ZmKuvjNr9qdSOJWPrN+7o2CUwQbDHxgbTmjEnzWRxYCsQsC8mn/LNwuXbuv0sbpU+admXxd4xTeXf7M787/2ns2bs89IL2qT8gPacSUZIqJJ0F5Ee8JFZM08LT1C7V4HLstw94FCXdTVDgh4/nR/BrZ
x-ms-exchange-antispam-messagedata: MefHjIN8L30cnhMXFsHFY91/Ehodr+9im4GLXU783WsBwFVU8dGN97fq1O0ZjGcmqzxRB1kAFPjD4pUWuphjFGs6yI5gBERShaE0fruV0MdLO7yCrmNcTQMNd1rFZI61PK2+PK0ti9FEZyN+htUkPQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01853220-4ac6-4578-7e84-08d7e7fdb2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:15:10.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd0TwPdpWeroL9358D2GAJOjnuVv0akogIpFN10Z2fwkmlPaPfyoFoIVk+A4ZEWuGpWAKH97ZZGT3mzjicSiqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAyNCwgMjAyMCAxMDo1NCBBTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIDIv
Ml0gZmlybXdhcmU6IGlteDogTVUgSVJRIGdyb3VwIG51bWJlciBzaG91bGQgYmUNCj4gPiA3DQo+
ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4g
U2VudDogRnJpZGF5LCBBcHJpbCAyNCwgMjAyMCAxMDozNiBBTQ0KPiA+ID4NCj4gPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogQWlzaGVuZyBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+ID4gU2VudDogMjAyMOW5tDTmnIgyNOaXpSAxMDozMw0K
PiA+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBzaGF3bmd1b0Br
ZXJuZWwub3JnOw0KPiA+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+ID4gYmVuLmRvb2tzQGNvZGV0aGlu
ay5jby51azsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+IENjOiBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiA+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMl0gZmlybXdh
cmU6IGlteDogTVUgSVJRIGdyb3VwIG51bWJlciBzaG91bGQNCj4gPiA+ID4gYmUNCj4gPiA+ID4g
Nw0KPiA+ID4gPg0KPiA+ID4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+ID4gPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAgNzowNyBBTQ0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gVGhlIE1VIElSUSBncm91cCBudW1iZXIgc2hvdWxkIGJlIDcgaW5z
dGVhZCBvZiA0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEFyZSB3ZSB1c2luZyBv
dGhlcnMgSVJRIGdyb3VwPw0KPiA+ID4gPiBJZiBub3QsIHRoaXMgY2hhbmdlIG1heSBzbG93IGRv
d24gdGhlIGlycSBoYW5kbGluZyBzcGVlZC4NCj4gPiA+DQo+ID4gPiBUaGUgaXJxIGhhbmRsaW5n
IGlzIHVzaW5nIHdvcmsgcXVldWUsIE5PVCBpbiBJU1IsIHNvIHRoZSBzcGVlZCBpcw0KPiA+ID4g
Tk9UIHRoYXQgc2Vuc2l0aXZlLg0KPiA+DQo+ID4gU0NVIElQQyBpcyBzaGFyZWQgYnkgdGhlIHdo
b2xlIHN5c3RlbSwgZWFjaCBTQ1UgdHJhbnNmZXIgdGFrZXMgYWJvdXQNCj4gPiAxMH4yMCB1cy4N
Cj4gPiBIZXJlIHlvdSBtYXkgd2FzdGUgMzB+NjB1cyBpZiBub3QgcmVhbGx5IHVzZWQuDQo+ID4N
Cj4gPiA+IFRoZSBzY3UgZ3JvdXAgaXJxIGRyaXZlciBzaG91bGQgcHJvdmlkZSBmdWxsIGZ1bmN0
aW9ucywgYXMgb3RoZXINCj4gPiA+IGRyaXZlcnMgdXNpbmcgaXQgbWF5IGVuYWJsZSB0aGUgZ3Jv
dXAgdGhleSB3YW50Lg0KPiA+DQo+ID4gQmVsb3cgYXJlIGV4dHJhIEdST1VQcyB5b3UncmUgZ29p
bmcgdG8gYWRkOg0KPiA+ICNkZWZpbmUgU0NfSVJRX0dST1VQX1NZU0NUUiAgICAgNFUgICAvKiE8
IFN5c3RlbSBjb3VudGVyIGludGVycnVwdHMgKi8NCj4gPiAjZGVmaW5lIFNDX0lSUV9HUk9VUF9S
RUJPT1RFRCAgIDVVICAgLyohPCBQYXJ0aXRpb24gcmVib290IGNvbXBsZXRlDQo+ID4gKi8NCj4g
PiAjZGVmaW5lIFNDX0lSUV9HUk9VUF9SRUJPT1QgICAgIDZVICAgLyohPCBQYXJ0aXRpb24gcmVi
b290IHN0YXJ0aW5nICovDQo+ID4gQXJlIHdlIHJlYWxseSBnb2luZyB0byB1c2UgaXQ/IEl0IHNl
ZW1zIEkgYWxzbyBkaWRuJ3Qgc2VlIGFueSB1c2VycyBpbg0KPiA+IGRvd25zdHJlYW0gdHJlZS4N
Cj4gPg0KPiA+IFNvbWUgZnVuY3Rpb25zIHByb3ZpZGVkIGJ5IFNDRlcgbWF5IG5vdCByZWFsbHkg
dXNlZCBieSBMaW51eC4NCj4gPiBJIHRoaW5rIEkncyBiZXR0ZXIgdG8gYWRkIHRoZW0gd2hlbiB3
ZSByZWFsbHkgbmVlZCB0aGVtLCBvdGhlcndpc2Ugd2UNCj4gPiBiZW5lZml0IG5vdGhpbmcgQnV0
IHdhc3RpbmcgQ1BVIG1pcHMuDQo+IA0KPiBJIGRvbid0IGFncmVlIHRoaXMsIGlmIFNDRlcgTk9U
IHN1cHBvcnQgaXQsIGl0IHNob3VsZCBmaXggZnJvbSBTQ0ZXLiBUaGlzIGlzIGFsaWduZWQNCj4g
d2l0aCBvdXIgaW50ZXJuYWwgdHJlZS4NCg0KSG1tLCBpbnRlcm5hbCB0cmVlIGRvZXMgbm90IGRl
Y2lkZSB1cHN0cmVhbSB0cmVlLiBUaGF0J3MgYSBsZXNzb24gd2UndmUgYWxyZWFkeSBsZWFybmVk
DQpmb3IgbWFueSB5ZWFycy4NCg0KRm9yIGV4YW1wbGUsIHdlIG9ubHkgdXBzdHJlYW0gU0NVIEFQ
SSByZWFsbHkgdXNlZCBieSBMaW51eC4NCk5vdCBhbGwgb2YgdGhlbSBhcyB3ZSBzaW1wbHkgZGlk
IGZvciBsb2NhbCA0LjE5IHJlbGVhc2UuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gQW5z
b24NCg==
