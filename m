Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43548C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CC22076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9kwg9tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgDWK5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:57:25 -0400
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:6076
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbgDWK5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:57:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv6GFdvvg6dtwbUwcQ07JwyrVFIWZUVEzWTJF9XMKzIpj26+IGiPBjlyH56dOz3sdYz/PyT6cl+ZDcu0Fcl2dikVQo6hP6fv2vLJOnYMjy7Sax1Z8CaOwdZMtnaG2yt3BYvgZuuwduc+oXDNjvib8OGFYXdGQcHrbNV0JksdWvSH+cVxm/ki7DMqmfAzmSmLAeNNW2osHAqijBa3C6wwX3hLgy+2g6P3lBw7KrQCNfq3rvNI/h3doeTJUJMFQsUTx+gES5wuJ3jDv9y9fF4pZ3yzwZDLqsroqzB3K7TcIOMsXoZjBmJiPWzSjAsdH7/xLsrba+FnF6Ge77kK0uDVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IpFPas55nW/5x4+KAT2CQzGVt7RKIc6llwxuy9o49A=;
 b=NxNLN518YSaV7mCP6U513fgB/V10Flk/2z6cywG5FpXUEiK24tSm3Pyf9V5JkD2Tmj7HNLhiXZ+Pq95B+JzoPs0/Ie8IL8i/9h4Fdzp7WAwti7An8XlfG+mZbLvFcifxfR7zFKqdFw9RziI5OZPAK9K++M/yj5dzGZadjacApimbyToT/rlKUhC5v/q/WXQNuLGIa59Z2AfZsvcEDIQN+7eqiF+IFpB9Yxs/ytqXIl98BgblDxHQqdCwG/9wwm6Gvkkxo+FP+1NpfRwt34I6hJ+5wltOzJFJ1/k4Wm55LFTMqCqfmgaV+Kj1JqcU7i3FUgWzZpkVdGexAUNTwuj/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IpFPas55nW/5x4+KAT2CQzGVt7RKIc6llwxuy9o49A=;
 b=N9kwg9tzu3WJVzyysSdOL2L/uFgr4mrg0aoYbGRTVqu5pC3ofm45hiN7u15YOV3FW6OTeGklLhioc6lNWbVizZk0M81zv/UjSfZww00wdFKU0vSxcgy22hR3PdijGxsHJF1Byw+ZKWO+jnBV72lHQAeBw7uVDfhVSLkt/HhUodc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2823.eurprd04.prod.outlook.com (2603:10a6:4:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:57:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 10:57:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHWGT37doAjG8vSF0ywBJjXXTGn3qiGerCAgAAOdvA=
Date:   Thu, 23 Apr 2020 10:57:20 +0000
Message-ID: <DB6PR0402MB276030B2D59423AF0FD3769388D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-3-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49665455AE49EB1B500BEB4080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49665455AE49EB1B500BEB4080D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f702d9e4-5d46-4cfe-efe2-08d7e7751878
x-ms-traffictypediagnostic: DB6PR0402MB2823:|DB6PR0402MB2823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2823B9F39BC50B607B955D4D88D30@DB6PR0402MB2823.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(86362001)(33656002)(316002)(110136005)(54906003)(5660300002)(478600001)(52536014)(71200400001)(7696005)(186003)(8936002)(2906002)(4326008)(81156014)(8676002)(26005)(76116006)(9686003)(6506007)(66946007)(66476007)(66556008)(64756008)(44832011)(55016002)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: biakb3Dna1Y2GlDfC3yX6JSIYe8LfDfk+dMcXC2FfjubUhmMDcZ52HrBRskgZmEN+2LuI85gY9xB51dylz+V6SSageX371GV5sHutdBn5PII/ymSABqvpocODC8yJCKatq3DGuKxjCmPnLqR2p0StRFQDWzP3HE5Xyn4GcAUnQv/i5Bng6XC+oyjshLQ9k7b39fM8L+w9gFQYnGwMkkl1eHNLKf2K0gq1ckWj8phPBV5Us4i0Yxg3pGXr8ay7qI1VkwabV8LaJt0rtyPJ0y4Tx5Vv/At/fOmR78sEtnYE/9348jpF/DjPMl6hM6lTzhUIE9M8THhVN+R1pOoUvKYKbIYmJEUBIQ9LVPEODmsr41SNR6vBovENIT34Qz78L0Gv9iu+d5J3B3/nz8ixf4AGWlv1MnURQHcB7ZlVSv3/GYkzrKi6dD0Uz79EqqMLE6X
x-ms-exchange-antispam-messagedata: //iZeDFceTExmhgKc9hopxFl6/eeEgBMqqHL0ZCKAU6Bxn7+dPeYl4MNCbdcqsnTa+1Bu81QN0g54kZ2gJtKgvxrmUuof3RjASYFmACsU6WP+79XUgxCmCQCqTbtq6A9MBDLyq7v1NwQ/uxSarWO8w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f702d9e4-5d46-4cfe-efe2-08d7e7751878
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:57:20.2344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FOQDhoD7il7a5TjsnH+giZi9vhx7q2YtLqvkTIlb/NqbTsrojmHm0gh3LQT2Ixss9G+fQDp806LPKnG73OYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIDIvNF0gZmlybXdhcmU6IGlteDogYWRkIHJlc291cmNlIG1h
bmFnZW1lbnQgYXBpDQo+IA0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyMCAzOjAwIFBNDQo+ID4NCj4gPiBBZGQg
cmVzb3VyY2UgbWFuYWdlbWVudCBBUEksIHdoZW4gd2UgaGF2ZSBtdWx0aXBsZSBwYXJ0aXRpb24g
cnVubmluZw0KPiA+IHRvZ2V0aGVyLCByZXNvdXJjZXMgbm90IG93bmVkIHRvIGN1cnJlbnQgcGFy
dGl0aW9uIHNob3VsZCBub3QgYmUgdXNlZC4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBMZW9uYXJk
IENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gUmlnaHQgbm93IEknbSBzdGlsbCBub3Qg
cXVpdGUgdW5kZXJzdGFuZCBpZiB3ZSByZWFsbHkgbmVlZCB0aGlzLg0KPiBBcyBjdXJyZW50IHJl
c291cmNlIGlzIGJvdW5kIHRvIHBvd2VyIGRvbWFpbnMsIGlmIGl0J3Mgbm90IG93bmVkIGJ5IG9u
ZQ0KPiBzcGVjaWZpYyBTVyBleGVjdXRpb24gZW52aXJvbm1lbnQsIHBvd2VyIG9uIHdpbGwgYWxz
byBmYWlsLg0KPiBDYW4geW91IGNsYXJpZnkgaWYgYW55IGV4Y2VwdGlvbnM/DQoNClRoZXJlIHdp
bGwgYmUgbG90cyBvZiBmYWlsdXJlcyB3aGVuIGJvb3QgTGludXggZG9tdSBpZiBubyBjaGVjay4N
Cg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gUmVnYXJkcw0KPiBBaXNoZW5nDQo+IA0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZSAgICAgICB8ICAyICstDQo+ID4g
IGRyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMgICAgICAgICAgIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oICAgIHwgIDEgKw0K
PiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaCB8IDY5DQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEx
MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBk
cml2ZXJzL2Zpcm13YXJlL2lteC9ybS5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBpbmNsdWRl
L2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZmlybXdhcmUvaW14L01ha2VmaWxlDQo+ID4gYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtl
ZmlsZSBpbmRleCAwOGJjOWRkZmJkZmIuLjE3ZWEzNjEzZTE0Mg0KPiA+IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVycy9maXJt
d2FyZS9pbXgvTWFrZWZpbGUNCj4gPiBAQCAtMSw0ICsxLDQgQEANCj4gPiAgIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICBvYmotJChDT05GSUdfSU1YX0RTUCkJCSs9IGlt
eC1kc3Aubw0KPiA+IC1vYmotJChDT05GSUdfSU1YX1NDVSkJCSs9IGlteC1zY3UubyBtaXNjLm8g
aW14LXNjdS1pcnEubw0KPiA+ICtvYmotJChDT05GSUdfSU1YX1NDVSkJCSs9IGlteC1zY3UubyBt
aXNjLm8gaW14LXNjdS1pcnEubyBybS5vDQo+ID4gIG9iai0kKENPTkZJR19JTVhfU0NVX1BEKQkr
PSBzY3UtcGQubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9ybS5jIGIv
ZHJpdmVycy9maXJtd2FyZS9pbXgvcm0uYyBuZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4
IDAwMDAwMDAwMDAwMC4uN2IwMzM0ZGU1NDg2DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L2RyaXZlcnMvZmlybXdhcmUvaW14L3JtLmMNCj4gPiBAQCAtMCwwICsxLDQwIEBADQo+ID4gKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5
cmlnaHQgMjAyMCBOWFANCj4gPiArICoNCj4gPiArICogRmlsZSBjb250YWluaW5nIGNsaWVudC1z
aWRlIFJQQyBmdW5jdGlvbnMgZm9yIHRoZSBSTSBzZXJ2aWNlLg0KPiA+ICtUaGVzZQ0KPiA+ICsg
KiBmdW5jdGlvbiBhcmUgcG9ydGVkIHRvIGNsaWVudHMgdGhhdCBjb21tdW5pY2F0ZSB0byB0aGUg
U0MuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9z
dmMvcm0uaD4NCj4gPiArDQo+ID4gK3N0cnVjdCBpbXhfc2NfbXNnX3JtX3JzcmNfb3duZWQgew0K
PiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiArCXUxNiByZXNvdXJjZTsNCj4g
PiArfSBfX3BhY2tlZCBfX2FsaWduZWQoNCk7DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBUaGlz
IGZ1bmN0aW9uIGNoZWNrIEByZXNvdXJjZSBpcyBvd25lZCBieSBjdXJyZW50IHBhcnRpdGlvbiBv
ciBub3QNCj4gPiArICoNCj4gPiArICogQHBhcmFtW2luXSAgICAgaXBjICAgICAgICAgSVBDIGhh
bmRsZQ0KPiA+ICsgKiBAcGFyYW1baW5dICAgICByZXNvdXJjZSAgICByZXNvdXJjZSB0aGUgY29u
dHJvbCBpcyBhc3NvY2lhdGVkIHdpdGgNCj4gPiArICoNCj4gPiArICogQHJldHVybiBSZXR1cm5z
IDAgZm9yIHN1Y2Nlc3MgYW5kIDwgMCBmb3IgZXJyb3JzLg0KPiA+ICsgKi8NCj4gPiArYm9vbCBp
bXhfc2Nfcm1faXNfcmVzb3VyY2Vfb3duZWQoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTE2DQo+
ID4gK3Jlc291cmNlKSB7DQo+ID4gKwlzdHJ1Y3QgaW14X3NjX21zZ19ybV9yc3JjX293bmVkIG1z
ZzsNCj4gPiArCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gKw0K
PiA+ICsJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ID4gKwloZHItPnN2YyA9IElN
WF9TQ19SUENfU1ZDX1JNOw0KPiA+ICsJaGRyLT5mdW5jID0gSU1YX1NDX1JNX0ZVTkNfSVNfUkVT
T1VSQ0VfT1dORUQ7DQo+ID4gKwloZHItPnNpemUgPSAyOw0KPiA+ICsNCj4gPiArCW1zZy5yZXNv
dXJjZSA9IHJlc291cmNlOw0KPiA+ICsNCj4gPiArCWlteF9zY3VfY2FsbF9ycGMoaXBjLCAmbXNn
LCB0cnVlKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gaGRyLT5mdW5jOw0KPiA+ICt9DQo+ID4gK0VY
UE9SVF9TWU1CT0woaW14X3NjX3JtX2lzX3Jlc291cmNlX293bmVkKTsNCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4gPiBiL2luY2x1ZGUvbGludXgv
ZmlybXdhcmUvaW14L3NjaS5oDQo+ID4gaW5kZXggMTdiYTRlNDA1MTI5Li5iNWM1YTU2ZjI5YmUg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0KPiA+IEBAIC0xNSw2ICsxNSw3
IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oPiAg
I2luY2x1ZGUNCj4gPiA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9wbS5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oPg0KPiA+DQo+ID4gIGludCBpbXhfc2N1X2Vu
YWJsZV9nZW5lcmFsX2lycV9jaGFubmVsKHN0cnVjdCBkZXZpY2UgKmRldik7ICBpbnQNCj4gPiBp
bXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsg
ZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL3JtLmgNCj4g
PiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3N2Yy9ybS5oDQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZjNmVhNjJkOWQwZQ0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvcm0uaA0K
PiA+IEBAIC0wLDAgKzEsNjkgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjArICovDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAxNiBGcmVlc2NhbGUg
U2VtaWNvbmR1Y3RvciwgSW5jLg0KPiA+ICsgKiBDb3B5cmlnaHQgMjAxNy0yMDE5IE5YUA0KPiA+
ICsgKg0KPiA+ICsgKiBIZWFkZXIgZmlsZSBjb250YWluaW5nIHRoZSBwdWJsaWMgQVBJIGZvciB0
aGUgU3lzdGVtIENvbnRyb2xsZXINCj4gPiArKFNDKQ0KPiA+ICsgKiBQb3dlciBNYW5hZ2VtZW50
IChQTSkgZnVuY3Rpb24uIFRoaXMgaW5jbHVkZXMgZnVuY3Rpb25zIGZvciBwb3dlcg0KPiA+ICtz
dGF0ZQ0KPiA+ICsgKiBjb250cm9sLCBjbG9jayBjb250cm9sLCByZXNldCBjb250cm9sLCBhbmQg
d2FrZS11cCBldmVudCBjb250cm9sLg0KPiA+ICsgKg0KPiA+ICsgKiBSTV9TVkMgKFNWQykgUmVz
b3VyY2UgTWFuYWdlbWVudCBTZXJ2aWNlDQo+ID4gKyAqDQo+ID4gKyAqIE1vZHVsZSBmb3IgdGhl
IFJlc291cmNlIE1hbmFnZW1lbnQgKFJNKSBzZXJ2aWNlLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4g
KyNpZm5kZWYgX1NDX1JNX0FQSV9IDQo+ID4gKyNkZWZpbmUgX1NDX1JNX0FQSV9IDQo+ID4gKw0K
PiA+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3NjaS5oPg0KPiA+ICsNCj4gPiArLyoN
Cj4gPiArICogVGhpcyB0eXBlIGlzIHVzZWQgdG8gaW5kaWNhdGUgUlBDIFJNIGZ1bmN0aW9uIGNh
bGxzLg0KPiA+ICsgKi8NCj4gPiArZW51bSBpbXhfc2Nfcm1fZnVuYyB7DQo+ID4gKwlJTVhfU0Nf
Uk1fRlVOQ19VTktOT1dOID0gMCwNCj4gPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9BTExP
QyA9IDEsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19TRVRfQ09ORklERU5USUFMID0gMzEsDQo+ID4g
KwlJTVhfU0NfUk1fRlVOQ19QQVJUSVRJT05fRlJFRSA9IDIsDQo+ID4gKwlJTVhfU0NfUk1fRlVO
Q19HRVRfRElEID0gMjYsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19QQVJUSVRJT05fU1RBVElDID0g
MywNCj4gPiArCUlNWF9TQ19STV9GVU5DX1BBUlRJVElPTl9MT0NLID0gNCwNCj4gPiArCUlNWF9T
Q19STV9GVU5DX0dFVF9QQVJUSVRJT04gPSA1LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1BB
UkVOVCA9IDYsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19NT1ZFX0FMTCA9IDcsDQo+ID4gKwlJTVhf
U0NfUk1fRlVOQ19BU1NJR05fUkVTT1VSQ0UgPSA4LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VU
X1JFU09VUkNFX01PVkFCTEUgPSA5LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX1NVQlNZU19S
U1JDX01PVkFCTEUgPSAyOCwNCj4gPiArCUlNWF9TQ19STV9GVU5DX1NFVF9NQVNURVJfQVRUUklC
VVRFUyA9IDEwLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX01BU1RFUl9TSUQgPSAxMSwNCj4g
PiArCUlNWF9TQ19STV9GVU5DX1NFVF9QRVJJUEhFUkFMX1BFUk1JU1NJT05TID0gMTIsDQo+ID4g
KwlJTVhfU0NfUk1fRlVOQ19JU19SRVNPVVJDRV9PV05FRCA9IDEzLA0KPiA+ICsJSU1YX1NDX1JN
X0ZVTkNfR0VUX1JFU09VUkNFX09XTkVSID0gMzMsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19JU19S
RVNPVVJDRV9NQVNURVIgPSAxNCwNCj4gPiArCUlNWF9TQ19STV9GVU5DX0lTX1JFU09VUkNFX1BF
UklQSEVSQUwgPSAxNSwNCj4gPiArCUlNWF9TQ19STV9GVU5DX0dFVF9SRVNPVVJDRV9JTkZPID0g
MTYsDQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19NRU1SRUdfQUxMT0MgPSAxNywNCj4gPiArCUlNWF9T
Q19STV9GVU5DX01FTVJFR19TUExJVCA9IDI5LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfTUVNUkVH
X0ZSQUcgPSAzMiwNCj4gPiArCUlNWF9TQ19STV9GVU5DX01FTVJFR19GUkVFID0gMTgsDQo+ID4g
KwlJTVhfU0NfUk1fRlVOQ19GSU5EX01FTVJFRyA9IDMwLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNf
QVNTSUdOX01FTVJFRyA9IDE5LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfU0VUX01FTVJFR19QRVJN
SVNTSU9OUyA9IDIwLA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfSVNfTUVNUkVHX09XTkVEID0gMjEs
DQo+ID4gKwlJTVhfU0NfUk1fRlVOQ19HRVRfTUVNUkVHX0lORk8gPSAyMiwNCj4gPiArCUlNWF9T
Q19STV9GVU5DX0FTU0lHTl9QQUQgPSAyMywNCj4gPiArCUlNWF9TQ19STV9GVU5DX1NFVF9QQURf
TU9WQUJMRSA9IDI0LA0KPiA+ICsJSU1YX1NDX1JNX0ZVTkNfSVNfUEFEX09XTkVEID0gMjUsDQo+
ID4gKwlJTVhfU0NfUk1fRlVOQ19EVU1QID0gMjcsDQo+ID4gK307DQo+ID4gKw0KPiA+ICsjaWYg
SVNfRU5BQkxFRChDT05GSUdfSU1YX1NDVSkNCj4gPiArYm9vbCBpbXhfc2Nfcm1faXNfcmVzb3Vy
Y2Vfb3duZWQoc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTE2DQo+ID4gK3Jlc291cmNlKTsgI2Vs
c2Ugc3RhdGljIGlubGluZSBib29sDQo+ID4gK2lteF9zY19ybV9pc19yZXNvdXJjZV9vd25lZChz
dHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1MTYgcmVzb3VyY2UpIHsNCj4gPiArCXJldHVybiB0cnVl
Ow0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+ICsjZW5kaWYNCj4gPiAtLQ0KPiA+IDIuMTYuNA0K
DQo=
