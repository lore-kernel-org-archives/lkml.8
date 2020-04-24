Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B677C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3746820728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RSHNaWvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDXCdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:33:01 -0400
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:25024
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDXCdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:33:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6YA9j+3O/UVkLA8bdgf2hVyRDonKnYqGxtDgwdGplmbNjTlVYg5CvczkPTU3ecvbIlNW6cG2nZVKSMzPpSKz8BgZfYXuMMA5dGmRjEFe/pHyrM2pUDz+0yzHoxFjklfeufNb+EX77Q/VkSCvY+XQQbYv6TNuYNo7q8s9YczxHkSznBMEpVcLrxQKy/1smcocUCJgcFJT7RDJimaasjVMm7hfboOJeeWw68bB6BmDXmCNgnUxCZFTwTvAqalvEoCqWcvtRfREkWgGdOjNg9kpCuK6eGK5v2wwqz2lF9CHjZIaFTju7WaIkcDwd5WN4hzl9RCBe0eAHcwjC+cHxYMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4T2iNjMsIsWSmLRXx5QflHLDC8ohmrgIiOX5FSR3Gc=;
 b=RtS/VzlrInJsjDU05LM5PGcUsUmMnGE0FXrDSYZw37SVd75XPAEoPeCMrhgQQr2WJPku02CfbzdvuqTLbk7rLrxpfb4kqsFRLE0Bk6J5/0gnh2XNFqVloLI6EN2AfGLQfmU1gDk1gLQ6pt4WusdM0VvaQQA8i43+ZVyHgMYyFuDXaMlWUVjhsI+VRZPbBEqghrpY6PTwOWeLVEs5WKGOqujdwTIRQjeXpKPQ/7Gg0P6hS+rmpOYpOEdP2Z2IW2TzbT++VRm5vRi0JGX1NnKrMPXQ4egUmvHcYPu748nNPCjqoJfCtt74zLnTDEa3lgg8PdSP73zXFm6kNe/QSpIErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4T2iNjMsIsWSmLRXx5QflHLDC8ohmrgIiOX5FSR3Gc=;
 b=RSHNaWvWmwB/wWEUxoFIJhEzGWFgqU/tU/AKWnDhUFS69tCdyHxGs8TRzPfz4B/1qhG0CwI/QaGJNSUXtaljrC1pWZ8fO5BTTheqqT5ziPlbOEKNDSecSsHiI6ilYDhzFnJle46eMQRyzemGx/aYhbsoOFqQ56oatW5Zgb7Un6E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3772.eurprd04.prod.outlook.com (2603:10a6:8:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 02:32:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2921.035; Fri, 24 Apr 2020
 02:32:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: Add context save/restore for suspend/resume
Thread-Topic: [PATCH] mailbox: imx: Add context save/restore for
 suspend/resume
Thread-Index: AQHWGcRI3NaCUTtP70667RBGRFojq6iHjCeAgAAAeYA=
Date:   Fri, 24 Apr 2020 02:32:55 +0000
Message-ID: <DB3PR0402MB3916D588A9432A9F1D1F99BAF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59294648-2179-4e3f-7984-08d7e7f7cc10
x-ms-traffictypediagnostic: DB3PR0402MB3772:|DB3PR0402MB3772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3772162F9ADB587054B41EA5F5D00@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(76116006)(33656002)(26005)(8936002)(186003)(71200400001)(66946007)(81156014)(4326008)(5660300002)(44832011)(6506007)(7696005)(86362001)(478600001)(316002)(52536014)(15650500001)(110136005)(64756008)(2906002)(66446008)(66476007)(9686003)(66556008)(8676002)(55016002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7uszPL5FqpSA6b4fTe22ArQeXSTjUVSQ/if4CErZR6bf0WXjxhARJ9OJOFgunFcibl51I0HG7ZP3jfIYjGoleNZGJ3/TldlGF2n+y5+gIj4UTtHSkCOyZ/RZqN+qeEfOjfZUz0ISywegr3vJK1sF3vNruFWvEW4qCOE90qU/XC7iS3AVXtv5gd4ikkOf8jjQZS2b7OjRjK4Zgj0LExHBD5/fC6ODLGc3ViSru5Z7VAs51UsaBJ6oGMiQEYpcm6ObebB1H3Rd4Pe8+z4G9BG1R+oCFAwKsjISHglwfS/7NwxSFDoeYhz56Q2snL7ki9tnIAag8t6l+HJqHFCxiOgPT9gkaY0dMmq+uEKVnwkyxTnn6Hu43tRPLQFtsQGp0N3ik5lnkmuIC0SWeuaYTspTkftmzhZwKgRqUmdQcvK/g9MAtwscej65x0/IJpWs7Rc
x-ms-exchange-antispam-messagedata: Khs9XcfaBcl9BAiewo5WJKiISHf8gT4JXJLmZDbm70Lz+sYUXQUxUL9skdvvrcv7RVc5AIaDFo4duvg5RbJOfch4XtP0WEDUkjgAtaXZ+cWKLKrxkqjOAuRVPhPM2po8g0mBsRPdViKJfuDqG5CsjCKVNbtvWitVbRZ/LK9OShwCeKFvamk7tIkDV6DM2V7cOJcOiQSjOSFnh1tV9l8quTtBZHsyVrICjhpPZha8bXWMwxLPY4fs2rM7ovhAWDKAvdF9RW8J+5HI76Rqg9UU0R8UwCkETWOmr7EmRV8oRGJptZJ/HaaBgCTqC4o5zWvhhVzxip6HoLL9X6v0UNmdu/jIWu73H7ps3/PU503R4sjzvLkpKlYTlwURyrDS4tEGbnvCj7NEj7NPs9v0oNXGtqU1kBM71z7rikuhGAJpY1cOSzsondDCQCc/SjKg7pmnKgkzIfXCSMxTUYM2jqskSJoC+xPHInd6zq0gEEZrD1Ytc5vBu+5lHDm5n3wYT1S9VHxbMMcZcM1HKKDYNJxEhGmvVT606Y+xxyEcBYM6BOVJj07KoS2W1gAnUUUvjmWdWxRLnmt03nLwd5r5yhf8Bq8I4AfbgYcfADRSLrv8rhj/Ju4K1SCYRhq3uossYWCAwyAM2gNdyY0DUUT3ZWCg+ojQKE7v9DO6as7WnBEMVcEV3+q3+N2YWsGTTlhJhIrOQ/3EnhtzDDPuePb46cfz2DiSSpebhAxjybA4/HI1ysIffFNDDETwL44lIcFg07bmC3RsuxWmefDTbAs9PyupZGfw42N+wvdqEfd8ytNzXKc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59294648-2179-4e3f-7984-08d7e7f7cc10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:32:56.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsDz7YyS3nC2uUoU45iNcvU6O1Wf1ngSwEXiKl6Dv2o+EdT4mTWl98uQmPz5NB1AhI9P3lgNjCz0DW6iw9r5fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gbWFpbGJveDogaW14OiBBZGQgY29udGV4dCBzYXZl
L3Jlc3RvcmUgZm9yDQo+IHN1c3BlbmQvcmVzdW1lDQo+IA0KPiA+IEZyb206IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAg
NzowMSBBTQ0KPiA+DQo+ID4gRm9yICJtZW0iIG1vZGUgc3VzcGVuZCBvbiBpLk1YOCBTb0NzLCBN
VSBzZXR0aW5ncyBjb3VsZCBiZSBsb3N0DQo+ID4gYmVjYXVzZSBpdHMgcG93ZXIgaXMgb2ZmLCBz
byBzYXZlL3Jlc3RvcmUgaXMgbmVlZGVkIGZvciBNVSBzZXR0aW5ncyBkdXJpbmcNCj4gc3VzcGVu
ZC9yZXN1bWUuDQo+ID4gSG93ZXZlciwgdGhlIHJlc3RvcmUgY2FuIE9OTFkgYmUgZG9uZSB3aGVu
IE1VIHNldHRpbmdzIGFyZSBhY3R1YWxseQ0KPiA+IGxvc3QsIGZvciB0aGUgc2NlbmFyaW8gb2Yg
c2V0dGluZ3MgTk9UIGxvc3QgaW4gImZyZWV6ZSIgbW9kZSBzdXNwZW5kLA0KPiA+IHNpbmNlIHRo
ZXJlIGNvdWxkIGJlIHN0aWxsIElQQyBnb2luZyBvbiBtdWx0aXBsZSBDUFVzLCByZXN0b3Jpbmcg
dGhlDQo+ID4gTVUgc2V0dGluZ3MgY291bGQgb3ZlcndyaXRlIHRoZSBUSUUgYnkgbWlzdGFrZSBh
bmQgY2F1c2Ugc3lzdGVtDQo+ID4gZnJlZXplLCBzbyBuZWVkIHRvIG1ha2Ugc3VyZSBPTkxZIHJl
c3RvcmUgdGhlIE1VIHNldHRpbmdzIHdoZW4gaXQgaXMNCj4gcG93ZXJlZCBvZmYuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+
IEFzIG1lbnRpb25lZCBiZWZvcmUsIHdlJ2QgYmV0dGVyIGtlZXAgdGhlIG9yaWdpbmFsIGF1dGhv
ci4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIHwgMzUN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jDQo+ID4gYi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyBp
bmRleCA5N2JmMGFjLi5iNTNjZjYzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9p
bXgtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4g
PiBAQCAtNjcsNiArNjcsOCBAQCBzdHJ1Y3QgaW14X211X3ByaXYgew0KPiA+ICAJc3RydWN0IGNs
awkJKmNsazsNCj4gPiAgCWludAkJCWlycTsNCj4gPg0KPiA+ICsJdTMyIHhjcjsNCj4gPiArDQo+
ID4gIAlib29sCQkJc2lkZV9iOw0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTU4MywxMiArNTg1LDQ1
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9tdV9kdF9pZHNbXQ0KPiA+
ID0geyAgfTsgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteF9tdV9kdF9pZHMpOw0KPiA+DQo+
ID4gK3N0YXRpYyBpbnQgaW14X211X3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KSB7
DQo+ID4gKwlzdHJ1Y3QgaW14X211X3ByaXYgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gPiArDQo+ID4gKwlwcml2LT54Y3IgPSBpbXhfbXVfcmVhZChwcml2LCBwcml2LT5kY2ZnLT54
Q1IpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IGlteF9tdV9yZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gKwlzdHJ1
Y3QgaW14X211X3ByaXYgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArDQo+ID4g
KwkvKg0KPiA+ICsJICogT05MWSByZXN0b3JlIE1VIHdoZW4gY29udGV4dCBsb3N0LCB0aGUgVElF
IGNvdWxkDQo+ID4gKwkgKiBiZSBzZXQgZHVyaW5nIG5vaXJxIHJlc3VtZSBhcyB0aGVyZSBpcyBN
VSBkYXRhDQo+ID4gKwkgKiBjb21tdW5pY2F0aW9uIGdvaW5nIG9uLCBhbmQgcmVzdG9yZSB0aGUg
c2F2ZWQNCj4gPiArCSAqIHZhbHVlIHdpbGwgb3ZlcndyaXRlIHRoZSBUSUUgYW5kIGNhdXNlIE1V
IGRhdGENCj4gPiArCSAqIHNlbmQgZmFpbGVkLCBtYXkgbGVhZCB0byBzeXN0ZW0gZnJlZXplLiBU
aGlzIGlzc3VlDQo+ID4gKwkgKiBpcyBvYnNlcnZlZCBieSB0ZXN0aW5nIGZyZWV6ZSBtb2RlIHN1
c3BlbmQuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghaW14X211X3JlYWQocHJpdiwgcHJpdi0+ZGNm
Zy0+eENSKSkNCj4gPiArCQlpbXhfbXVfd3JpdGUocHJpdiwgcHJpdi0+eGNyLCBwcml2LT5kY2Zn
LT54Q1IpOw0KPiANCj4gVGhpcyBjb3VsZCBiZSBzZXBhcmF0ZSBwYXRjaCBpZiBpdCBhaW1zIHRv
IGZpeCBhIHNwZWNpZmljIGNvcm5lciBjYXNlLg0KDQpUaGlzIGlzIE5PVCBjb3JuZXIgY2FzZSwg
aXQgY2FuIGJlIHJlcHJvZHVjZWQgd2l0aCBvdXIgaW14XzUuNC55IHZlcnkNCmVhc2lseSwgYW5k
IHRoaXMgaXNzdWUgY2F1c2UgbWUgbWFueSBkYXlzIHRvIGRlYnVnLi4uQWxzbyBjYXVzZSBDbGFy
aydzDQplZmZvcnQgdG8gaGVscCB0ZXN0IGl0IGEgbG90IGZvciBtYW55IGRheXMuLi4NCg0KSSBk
byBOT1QgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gZmlyc3Qgc2VuZCBvdXQgeW91ciBwYXRjaCB3
aXRoIGJ1ZyBmb3IgcmV2aWV3LA0KQW5kIHRoZW4gYWRkIGFub3RoZXIgcGF0Y2ggdG8gZml4IGl0
LiAxIHBhdGNoIGlzIGVub3VnaCBmb3IgdGhpcyBmZWF0dXJlLg0KDQoNCg0K
