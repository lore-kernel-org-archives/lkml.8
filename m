Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BC020936
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="assvi7c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgIIGau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:30:50 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:64322
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbgIIGat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGGKyVQ+J3ao8YMDsaREAyhPhh44tDgg+lVzqENWOibYkLdvGTrASxsUeCtYjdQUwUGFLwUaAiVpR6aK6TQEAM45CC8WUvizJEPHuUJdYbv55o8vl10KC378TGUwgVdo0jFsEfNKJb6zI0Cfuv6zkTJ6MvBfqaEtbbk62siG3bwEXLeMeX1NKOk/ls7fHfKhXdUSpD/T6z2u+/htYbQffRh6hzq6qh6WO+yL8Sbm6ICp/Gdx3Q2O8Z94+qpMo9nM8QyuQ+hOTx276fh/gNbwaOlEnecOUqifz08MM9+LI5XdokgX0K2Dv5thArzLjT0Z9drH5SQsjoyrZzwFGHst7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qMZfnKjWitdkg1/6HYKiLWZLak+ytMCozqtCpN+y+s=;
 b=Y+AMWYbPCmwa3arQkj6l6U8tUsdl4+vfeJpFJXvVyJ8Ru7h0ZmDFSNCm3vTeXoWHM2P2iuMDpuM4ggI2ifh9URMP3OKCCZGOmB4i4taQMUMrNc+9xQE3RIAiWwJQzcn1Ofqkjb5iVseKEv0Pm2HUAzOzGOXpcDtx3hruBab7/ciyklsNZx9zg7nhKmTGPjHdQiych0PdTwijQM9PJWvxqWT59bhcE9FTOhr0NFk62FOi+fMC2odiuXxAi+ajhTwQPJ6ouoAUzU0/Yt7GjudXkOdpghW2+wZJIPSc5OT6vRrjnTuDLEIOAlfD/oGUWW0aZeZogNNrs1iawqIulgXQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qMZfnKjWitdkg1/6HYKiLWZLak+ytMCozqtCpN+y+s=;
 b=assvi7c6kxJHZCASpTNmq04SyL/gtzp7C4m2uH5gfwiqXbi8X2hEC29EVvWdX4X8nsb9sTMlIx101LlCyMSLYgRjVvDTEOKKgyQyKGLogiN1B91v6lt44fFdAQIFkJdWdngjnH/ecklo0T0k16fVDuzEbzTJyqB4jBGmDJRM+v0=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2282.eurprd03.prod.outlook.com (2603:10a6:3:24::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 9 Sep 2020 06:30:44 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 06:30:44 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Thread-Topic: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Thread-Index: AQHWhfCctrMc+RkfU02vebcoA9GUSalf2ZuA
Date:   Wed, 9 Sep 2020 06:30:44 +0000
Message-ID: <5ea2a75a873b6291962f6b6a7949e9d185187911.camel@fi.rohmeurope.com>
References: <20200908145900.4423-1-krzk@kernel.org>
In-Reply-To: <20200908145900.4423-1-krzk@kernel.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3276392-d076-4a3f-b6cd-08d85489e1b9
x-ms-traffictypediagnostic: HE1PR0301MB2282:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2282325FE07455D165461DC3AD260@HE1PR0301MB2282.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/msr5oceY6Ex64Yqwk0o53vHgbX1NsxXrKEALzDv18PyNqqqi+Cf+EbRmG/GptM6Flx4HNUoldKGYQySxj6M23I6Xx2M28vrBHzjO0RqezlzfYrz5iYNZJQWT/8F/oR5Sd48Jo3kuY6L1disETc5DCFBzNUxFFYhpxD0x5RaXB9ao8KZZbudxUiF0U5fqZhrMWpDGoGJvlBXIZcZMCqSoKQid2IkTeOi2/ySjMpwj9Ls3HxQsMB5m1D7VTZ5z2/IeAE7TBmZVM7UksY+ugImoXLW9bahlopKkYkbKKexN8HBYaTnW3jB2GEoci0qazW3wf58AVG7+Jmb6HdVxUxzSy9W9OxZV2u1xK6Bd49YChzJyaA794UAbDe8BG/wwlA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(478600001)(6512007)(5660300002)(110136005)(71200400001)(3450700001)(2616005)(8936002)(6506007)(8676002)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006)(316002)(186003)(6486002)(86362001)(2906002)(83380400001)(26005)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TpSsAf5cFDYEEq3fp/j4UjxOOfo01vCI0vhBkeDCzcSc6KhDE5XBgG1CoRXk+Gu3Eu00MJ5ICDddb6Txjy9nPMxMZwIt4FdSqEHBrw9etRnZqaY6YC/z6ze+3nfzqW38FeK5DtxJFN/wuxjvtqxeFkL3BHXOjpJDwdFPYl9aBqML5Pnawk+Z2XOpjh73ocdvpCWOSl0IeKkqEpY2UqVm8n1vUS9yUE1hI9KHaVL2n0NZB+ihup0WvOiy1b+4YFrebXqiWteLjQguoe76ENoZwCwUAXPVMcCGyFX5CpkFjQCWIhgbBgUgIFs55onzt3RGBrSAHNGWkvAiJU1xHcM1fvVZz/w7TrtfgOZ6ZU2KT4zGDi/VURKAAuMucTtr7U9mGrdpE/GU7jPOy3b7O/vy+5hyRx+Sll+E7sS3e7EcNk83//JKJL7WbEe6kRs89eUnH0iBND/LfsE2B70/phCYBy+BmVqxoocsF/GBT08CJE9Sziv8uO1NaDStMMVwJjpwp+rZ7Ns8Y8131vwLTuvDa9G86YyEWB3DndS0cqizlo2rYLGFmmWA9H91LuMKu5cA7KtSf0uUjIYl6Xbg9/xTZPazI4h6gLxnoumiSgMoydak9Xc6qK++IYcZNb66Za9UVs1k8Kj/fxtQPWhT/SQt4A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E53E74421E28A449E0A3D42A59E5F75@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3276392-d076-4a3f-b6cd-08d85489e1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 06:30:44.5643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sS1CrKGLJtK++ENDoC/4hFuDYUehayzTDd7IvqWUxiG2vyRJ8OkvlqhabTcu2bvs5Jug3l0+5mbmRBP6YdsF8yH0k65yZ4LDFL7JO/OF8HuAU8CaLBKU9V5KpMUwlVkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2282
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMDktMDggYXQgMTY6NTkgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IEdQSU9fQUNUSVZFX3ggZmxhZ3MgYXJlIG5vdCBjb3JyZWN0IGluIHRoZSBjb250
ZXh0IG9mIGludGVycnVwdA0KPiBmbGFncy4NCj4gVGhlc2UgYXJlIHNpbXBsZSBkZWZpbmVzIHNv
IHRoZXkgY291bGQgYmUgdXNlZCBpbiBEVFMgYnV0IHRoZXkgd2lsbA0KPiBub3QNCj4gaGF2ZSB0
aGUgc2FtZSBtZWFuaW5nOg0KPiAxLiBHUElPX0FDVElWRV9ISUdIID0gMCA9IElSUV9UWVBFX05P
TkUNCj4gMi4gR1BJT19BQ1RJVkVfTE9XICA9IDEgPSBJUlFfVFlQRV9FREdFX1JJU0lORw0KPiAN
Cj4gQ29ycmVjdCB0aGUgaW50ZXJydXB0IGZsYWdzLCBhc3N1bWluZyB0aGUgYXV0aG9yIG9mIHRo
ZSBjb2RlIHdhbnRlZA0KPiBzb21lDQo+IGxvZ2ljYWwgYmVoYXZpb3IgYmVoaW5kIHRoZSBuYW1l
ICJBQ1RJVkVfeHh4IiwgdGhpcyBpczoNCj4gICBBQ1RJVkVfTE9XID0+IElSUV9UWVBFX0xFVkVM
X0xPVw0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJu
ZWwub3JnPg0KDQpGb3IgQkQ3MDUyODoNCkFja2VkLUJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRp
LnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYWN0ODk0NWEudHh0ICAgICAgICAgIHwgMiArLQ0KPiAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9nYXRld29ya3MtZ3NjLnlhbWwg
ICAgfCAzICsrLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2ht
LGJkNzA1MjgtcG1pYy50eHQgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzA1MjgtDQo+IHBtaWMudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzA1MjgtDQo+IHBtaWMu
dHh0DQo+IGluZGV4IGMzYzAyY2U3M2NkZS4uMzg2ZWVjMDZjZjA4IDEwMDY0NA0KPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MDUyOC1wbWljLnR4
dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3
MDUyOC1wbWljLnR4dA0KPiBAQCAtMzksNyArMzksNyBAQCBwbWljOiBwbWljQDRiIHsNCj4gIAlj
b21wYXRpYmxlID0gInJvaG0sYmQ3MDUyOCI7DQo+ICAJcmVnID0gPDB4NGI+Ow0KPiAgCWludGVy
cnVwdC1wYXJlbnQgPSA8JmdwaW8xPjsNCj4gLQlpbnRlcnJ1cHRzID0gPDI5IEdQSU9fQUNUSVZF
X0xPVz47DQo+ICsJaW50ZXJydXB0cyA9IDwyOSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KDQpUaGlz
IGlzIGhvdyBpdCBzaG91bGQgaGF2ZSBiZWVuIGZyb20gdGhlIGJlZ2lubmluZyA6KSBUaGFua3Mh
DQoNCkJyLA0KCU1hdHRpDQoNCi0tDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2
ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kDQpTV0RDDQpLaXZpaGFyanVubGVua2tp
IDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+fiAiSSBkb24ndCB0aGluayBzbywiIHNhaWQg
UmVuZSBEZXNjYXJ0ZXMuIEp1c3QgdGhlbiBoZSB2YW5pc2hlZCB+fn4NCg0KU2ltb24gc2F5cyAt
IGluIExhdGluIHBsZWFzZS4NCiJub24gY29naXRvIG1lIiBkaXhpdCBSZW5lIERlc2NhcnRlLCBk
ZWluZGUgZXZhbmVzY2F2aXQNCg0KKFRoYW5rcyBmb3IgdGhlIHRyYW5zbGF0aW9uIFNpbW9uKQ0K
DQo=
