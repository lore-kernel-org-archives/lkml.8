Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F80C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB5B206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="auSAoO5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgF2TTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbgF2TOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:20 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03on070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe08::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6528C008649;
        Mon, 29 Jun 2020 03:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lShKbRmB0J5eEkEW4N5PhK5fGGteVPmStCbBiVn9AXUhnPgFLF+eQGo/WuOVDxtCdYdnn5aNTWSS4MTpWnR5A0Crlsx8Qe047VyRUUTD7wMby0wD+bMFxnTjPuaxNn927fImDLhE4NNO7Kca4jy3s5B6GDox50rK3JvEppLXtaqC4UycWLDljK9CxJXpwWY5Tw3R9RIb2zgjefTbdy+JZWGkzha0Fh5umVj//XqY2h9qpmDmcZqShKkOfm8GSABed3Ge9XPxAVp1MksdhhjeZEWuCefCh0pcG+GmIs6slIJzk5/8r5rOBqs1KHBzHqaaBPXh3SdKz48gE/pDO/Dw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in2MCgJq3Xc/5ZXebcY0aOhH359BoUq2fD4d3C5vmTQ=;
 b=JDxOVPnYQA9FalLLc3STPw7c0q6wi9/HH96PzgiqIZ1OtOXK2om3U34JJED/0ov9+3UZZI06R66t0xoHOace+Ou0myZkf79ejwXZqf+Jg1nPFhXKd5GcagGihoxBM/6EzNWnamE6gak53f2qMVztL/9uaSth6a108dFvnrzXCMJEOn8wYq0AZ3rD7kSf1uoyD/DqVMTvkSwJkwffmPrBp6OqohLBMIPnmT1P2864YWoXo9UIKAijCUuySUolwvcYlL6inJWusPstBZxyO3TFUSYviElN7/bTaIY+3NaxzIWoAp5/8j0UXvRqJeJVFZ8B6CWcSQD6Vp+i1McHbViUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in2MCgJq3Xc/5ZXebcY0aOhH359BoUq2fD4d3C5vmTQ=;
 b=auSAoO5Phsbi0Wt4eTILKyH4TR2qbBWflfmbeRMeBHJ41s1LwAymmqevVgi983txILmLMBT/Zwd+DrHyEkQE7aapCd5Ht12cc0Ox/RLWJ6KorHSUSMUmCYYr2YpZB05t5gMJP6BdhviGkbjoQ6D7CruwaEMX151fHZDeIMQ2WMc=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5733.eurprd05.prod.outlook.com (2603:10a6:20b:29::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 10:04:13 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 10:04:13 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lpDotuJDHYTE6xfL+NZ7/3sKjvNfGAgAAsA4A=
Date:   Mon, 29 Jun 2020 10:04:13 +0000
Message-ID: <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
         <20200629072703.GC30684@b29397-desktop>
In-Reply-To: <20200629072703.GC30684@b29397-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd9b0e6-d15c-4993-8ab1-08d81c13c6d2
x-ms-traffictypediagnostic: AM6PR05MB5733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB57338B6CD114BB30320B4BCAF46E0@AM6PR05MB5733.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DG4SW2paJ82qPJ+7yUvu25xZnBVAERjxBURLqh7HlTdDwWtq15CRFo4TX3Jss7gtJ9GtFNV6qaZiBnsAhAuYQbG6kBnSVFrigCPQRguxJL/C6LoKc3ZjuQGLjnfa8YeDfmcerPXTIqA/VsUI/+OXLrMMFFEueyT5FNn+W2J2l+GqriPBlq8CQfUeBQbU/NF/30UMhnNOaGOJ2ThDziJnfsZ8jVz9yJxv0P6uxkNjsBLDumgMp/WsUysZ30oFOV8XB7m1tg14R5gvbWWhjzDX6EoVDZTgOmvhSqn/jOtB/A1nMvJCFVWnCRP8xogXAHjXja3Gi1P0vjr9eLgpm3Bj/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(366004)(478600001)(6916009)(71200400001)(8676002)(64756008)(66556008)(8936002)(2906002)(2616005)(66946007)(66476007)(66446008)(186003)(6506007)(76116006)(83380400001)(91956017)(86362001)(4326008)(316002)(6512007)(6486002)(36756003)(5660300002)(53546011)(44832011)(54906003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HjqHgVTh/aEP3kFJT5ZFIax/kB587xfbdUDOpD1RKQOF4s44Rel3hOJLau3do29mlClcHhu7YqWNCL/LOrSwTlc6ESPNTb0i5NYrakGTxkCNJc670Tl5ZHKuXX23M1aJuXOLeIF+BBWMAMxQHOyKNB9WRkVSDdaas7ZsfF4/Twgkbk3uH+DVGIVc/QqIHNLelNgpb4WnaFGs/Z+zpwXMEkW1AGnEh5mRccEJiVYAIPYklvYQzj2PzuX95llYGywbnRpZ+xxfEOpCE1c20yju/vUfSiWPbqKlljNLGa2noY435dEIw7MfgPZODt5pYCaNErg1sDgy8PQL1Nei+KkhMZEVbqXSCMmqjx20999k1Ssl8bZXzpQmmWYjH1sNGXGbFYWcSB4UpNF7xlcf6mShkh7Gsd5gn/wZ3wZhIeEGxXRUb+1xJmZLoyF6aFlEA1qbZHskFLgppxV0g9jDYwl2w9806/ujYmmNqG9Su5Rm+oA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F8B996D3B72A54792DA5F6A7A962314@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9b0e6-d15c-4993-8ab1-08d81c13c6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 10:04:13.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5y4jLqaa/DRqd5YqBrRlxEOJmSmViajvbF+vEQ9XWScmZFBmHh4Nug3vZVpVIzbPxXBy4ezzqSQmctuzFsuftH3DW/uN8dzsgW0S1KTPWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDA3OjI2ICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiBP
biAyMC0wNi0yNiAxMzowMzoxMSwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6DQo+ID4gSWYgdGhl
IGhhcmR3YXJlIGlzIGluIGxvdy1wb3dlci1tb2RlIGFuZCBvbmUgcGx1Z3MgaW4gZGV2aWNlIG9y
IGhvc3QNCj4gPiBpdCBkaWQgbm90IHN3aXRjaCB0aGUgbW9kZSBkdWUgdG8gdGhlIGVhcmx5IGV4
aXQgb3V0IG9mIHRoZQ0KPiA+IGludGVycnVwdC4NCj4gDQo+IERvIHlvdSBtZWFuIHRoZXJlIGlz
IG5vIGNvbWluZyBjYWxsIGZvciByb2xlLXN3aXRjaD8gQ291bGQgeW91IHBsZWFzZQ0KPiBzaGFy
ZQ0KPiB5b3VyIGR0cyBjaGFuZ2VzPyBUcnkgYmVsb3cgcGF0Y2g6DQoNCkhlcmUgYXJlIG15IERU
UyBjaGFuZ2VzOg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJp
LWV2YWwtdjMuZHRzaQ0KYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5k
dHNpDQppbmRleCA5NzYwMTM3NWYyNjQwLi5jNDI0ZjcwN2ExYWZhIDEwMDY0NA0KLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KQEAgLTEzLDYgKzEzLDEzIEBADQog
ICAgICAgICAgICAgICAgc3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQogICAgICAg
IH07DQogDQorICAgICAgIGV4dGNvbl91c2JjX2RldDogdXNiY19kZXQgew0KKyAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAibGludXgsZXh0Y29uLXVzYi1ncGlvIjsNCisgICAgICAgICAgICAg
ICBpZC1ncGlvID0gPCZncGlvNyAxNCBHUElPX0FDVElWRV9ISUdIPjsNCisgICAgICAgICAgICAg
ICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KKyAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9
IDwmcGluY3RybF91c2JjX2RldD47DQorICAgICAgIH07DQorDQogICAgICAgIC8qIGZpeGVkIGNy
eXN0YWwgZGVkaWNhdGVkIHRvIG1wYzI1OHggKi8NCiAgICAgICAgY2xrMTZtOiBjbGsxNm0gew0K
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KQEAgLTE3NCw2ICsx
ODEsNyBAQA0KIH07DQogDQogJnVzYm90ZzEgew0KKyAgICAgICBleHRjb24gPSA8JmV4dGNvbl91
c2JjX2RldD4sIDwmZXh0Y29uX3VzYmNfZGV0PjsNCiAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0K
IH07DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kN
CmIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCmluZGV4IGUxOGU4OWRlYzg3
OTIuLmNhZWE5MGQyNDIxZmQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNv
bGlicmkuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCkBA
IC00NTcsNyArNDU3LDcgQEANCiB9Ow0KIA0KICZ1c2JvdGcxIHsNCi0gICAgICAgZHJfbW9kZSA9
ICJob3N0IjsNCisgICAgICAgZHJfbW9kZSA9ICJvdGciOw0KIH07DQogDQogJnVzZGhjMSB7DQpA
QCAtNDg2LDcgKzQ4Niw3IEBADQogJmlvbXV4YyB7DQogICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQogICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvMSAmcGluY3RybF9n
cGlvMiAmcGluY3RybF9ncGlvMw0KJnBpbmN0cmxfZ3BpbzQNCi0gICAgICAgICAgICAgICAgICAg
ICZwaW5jdHJsX2dwaW83ICZwaW5jdHJsX3VzYmNfZGV0PjsNCisgICAgICAgICAgICAgICAgICAg
ICZwaW5jdHJsX2dwaW83PjsNCiANCiAgICAgICAgcGluY3RybF9ncGlvMTogZ3BpbzEtZ3JwIHsN
CiAgICAgICAgICAgICAgICBmc2wscGlucyA9IDwNCg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9jaGlwaWRlYS9jb3JlLmMgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jb3JlLmMN
Cj4gaW5kZXggZThjZTMwMGFkNDkwLi45ZTEwZGNmZWI5OGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2NoaXBpZGVhL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jb3Jl
LmMNCj4gQEAgLTEzMTMsNiArMTMxMywyOSBAQCBzdGF0aWMgdm9pZCBjaV9jb250cm9sbGVyX3N1
c3BlbmQoc3RydWN0DQo+IGNpX2hkcmMgKmNpKQ0KPiAgCWVuYWJsZV9pcnEoY2ktPmlycSk7DQo+
ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBIYW5kbGUgdGhlIHdha2V1cCBpbnRlcnJ1cHQgdHJpZ2dl
cmVkIGJ5IGV4dGNvbiBjb25uZWN0b3INCj4gKyAqIFdlIG5lZWQgdG8gY2FsbCBjaV9pcnEgYWdh
aW4gZm9yIGV4dGNvbiBzaW5jZSB0aGUgZmlyc3QNCj4gKyAqIGludGVycnVwdCAod2FrZXVwIGlu
dCkgb25seSBsZXQgdGhlIGNvbnRyb2xsZXIgYmUgb3V0IG9mDQo+ICsgKiBsb3cgcG93ZXIgbW9k
ZSwgYnV0IG5vdCBoYW5kbGUgYW55IGludGVycnVwdHMuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lk
IGNpX2V4dGNvbl93YWtldXBfaW50KHN0cnVjdCBjaV9oZHJjICpjaSkNCj4gK3sNCj4gKwlzdHJ1
Y3QgY2lfaGRyY19jYWJsZSAqY2FibGVfaWQsICpjYWJsZV92YnVzOw0KPiArCXUzMiBvdGdzYyA9
IGh3X3JlYWRfb3Rnc2MoY2ksIH4wKTsNCj4gKw0KPiArCWNhYmxlX2lkID0gJmNpLT5wbGF0ZGF0
YS0+aWRfZXh0Y29uOw0KPiArCWNhYmxlX3ZidXMgPSAmY2ktPnBsYXRkYXRhLT52YnVzX2V4dGNv
bjsNCj4gKw0KPiArCWlmICghSVNfRVJSKGNhYmxlX2lkLT5lZGV2KSAmJiBjaS0+aXNfb3RnICYm
DQo+ICsJCShvdGdzYyAmIE9UR1NDX0lESUUpICYmIChvdGdzYyAmIE9UR1NDX0lESVMpKQ0KPiAr
CQljaV9pcnEoY2ktPmlycSwgY2kpOw0KPiArDQo+ICsJaWYgKCFJU19FUlIoY2FibGVfdmJ1cy0+
ZWRldikgJiYgY2ktPmlzX290ZyAmJg0KPiArCQkob3Rnc2MgJiBPVEdTQ19CU1ZJRSkgJiYgKG90
Z3NjICYgT1RHU0NfQlNWSVMpKQ0KPiArCQljaV9pcnEoY2ktPmlycSwgY2kpOw0KPiArfQ0KPiAr
DQo+ICBzdGF0aWMgaW50IGNpX2NvbnRyb2xsZXJfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgY2lfaGRyYyAqY2kgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
QEAgLTEzNDMsNiArMTM2Niw3IEBAIHN0YXRpYyBpbnQgY2lfY29udHJvbGxlcl9yZXN1bWUoc3Ry
dWN0IGRldmljZQ0KPiAqZGV2KQ0KPiAgCQllbmFibGVfaXJxKGNpLT5pcnEpOw0KPiAgCQlpZiAo
Y2lfb3RnX2lzX2ZzbV9tb2RlKGNpKSkNCj4gIAkJCWNpX290Z19mc21fd2FrZXVwX2J5X3NycChj
aSk7DQo+ICsJCWNpX2V4dGNvbl93YWtldXBfaW50KGNpKTsNCj4gIAl9DQo+ICANCj4gIAlyZXR1
cm4gMDsNCg0KVGhhbmtzIGZvciBjcmVhdGluZyB0aGlzIHBhdGNoISBJIHdhbnRlZCBhbHNvIHNv
bWV0aGluZyBsaWtlIHRoYXQsIGJ1dA0KY291bGRuJ3QgZmluZCBvdXQgd2hlcmUgdG8gcHV0IGl0
LiANCg0KSSB0cmllZCB0aGlzIHBhdGNoIGFuZCB3aXRoIHRoZSBhYm92ZSBkZXZpY2V0cmVlIGNo
YW5nZXMgdGhpcyB3b3Jrcw0KcGVyZmVjdGx5ISBUaGFua3MgUGV0ZXIhDQoNClNob3VsZCBJIHNl
bmQgdGhlIHBhdGNoIHdpdGggeW91IGFzIHRoZSAiU3VnZ2VzdGVkLWJ5IiBvciBkbyB5b3Ugd2Fu
dCB0bw0Kc2VuZCB0aGUgcGF0Y2ggc28geW91IGFyZSB0aGUgQXV0aG9yPyBJIHdvdWxkIGhhdmUg
aXQgcmVhZHkgaW4gbXkgZ2l0DQpyZXBvLg0KDQo+IA0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhh
dCBiZWhhdmlvdXIgYW5kIGxldHMgdGhlIHJlc3Qgb2YgdGhlIGNvZGUgY2hlY2sNCj4gPiBpZg0K
PiA+IHNvbWV0aGluZyBoYXMgdG8gYmUgZG9uZS4gSWYgbm90aGluZyBoYXMgdG8gYmUgZG9uZSB0
aGUgc2FtZSByZXR1cm4NCj4gPiB2YWx1ZSBnZXRzIHJldHVybmVkIGFzIGJlZm9yZS4NCj4gDQo+
IEJlZm9yZSB0aGUgY29udHJvbGxlciBsZWF2aW5nIGxvdyBwb3dlciBtb2RlLCBvdGdzYyB2YWx1
ZSBtYXkgbm90DQo+IGNvcnJlY3Qgc2luY2UgdGhlIGNvbnRyb2xsZXIvUEhZIGlzIHN0aWxsIGlu
IGxvdyBwb3dlciBtb2RlLg0KPiANCj4gPiBGaXhlczogMWY4NzRlZGNiNzMxICgidXNiOiBjaGlw
aWRlYTogYWRkIHJ1bnRpbWUgcG93ZXIgbWFuYWdlbWVudA0KPiA+IHN1cHBvcnQiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4
LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiBIaSBQZXRlcg0KPiA+IA0KPiA+IER1cmlu
ZyBteSBpbnZlc3RpZ2F0aW9uIEkgZm91bmQgYSBidWcgaW4gY2lfaXJxLiBJIHdvdWxkIGFwcHJl
Y2lhdGUNCj4gPiBpZiB5b3UgY291bGQgcmV2aWV3IHRoaXMuIEZyb20gd2hhdCBJIHNlZSB0aGlz
IHBhdGNoIHNob3VsZCBiZSBzYXZlDQo+ID4gdG8gYXBwbHkuDQo+ID4gDQo+ID4gVGhpcyBwYXRj
aCBkb2VzIG5vdCBzb2x2ZSBhbGwgb2Ygb3VyIGlzc3Vlcy4gV2hlbiBJIGhhdmUgUlVOVElNRV9Q
TQ0KPiA+IGVuYWJsZWQgb24gaW14NnVsbCBvciBpbXg3LiBSTkRJUyBzdGlsbCBkb2VzIG5vdCBj
b21lIHVwLiBTbyB0aGVyZQ0KPiA+IGhhcyB0byBiZSBhbm90aGVyIGJ1ZyBoaWRpbmcgc29tZXdo
ZXJlIGluIHRoZSBSdW50aW1lIFBNIGNvZGUgdG8NCj4gPiBwcmV2ZW50DQo+ID4gUk5ESVMgZnJv
bSB3b3JraW5nIHByb3Blcmx5LiBJIHF1aWNrbHkgbG9va2VkIHRocm91Z2ggeW91ciBwYXRjaGVz
DQo+ID4gdGhhdCBhZGRlZCB0aGlzIHN0dWZmIGJhY2sgaW4gMjAxNSBidXQgY291bGRuJ3Qgc3Bv
dCBhbnl0aGluZw0KPiA+IHJlbGF0ZWQgdG8NCj4gPiB1c2IgZ2FkZ2V0LW1vZGUuDQo+ID4gDQo+
ID4gSWYgeW91IHJpZ2h0IGF3YXkga25vdyB3aGVyZSB0aGUgcHJvYmxlbSBjb3VsZCBiZSBoaWRp
bmcgaXRzZWxmLA0KPiA+IEkgd291bGQgYXBwcmVjaWF0ZSBhIGhpbnQuDQo+ID4gDQo+IA0KPiBJ
IG5lZWQgaW5mb3JtYXRpb24gZm9yIGNhbGwgdHJhY2UgZm9yIGZ1cnRoZXIgc3VnZ2VzdGlvbi4N
Cj4gDQo+IFBldGVyDQo+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+ICBkcml2ZXJzL3VzYi9jaGlwaWRl
YS9jb3JlLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9j
b3JlLmMNCj4gPiBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NvcmUuYw0KPiA+IGluZGV4IDlhN2M1
M2QwOWFiNC4uNTE1OTQyMGEyM2E0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2NoaXBp
ZGVhL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NvcmUuYw0KPiA+IEBA
IC01MTgsNyArNTE4LDcgQEAgc3RhdGljIGlycXJldHVybl90IGNpX2lycShpbnQgaXJxLCB2b2lk
ICpkYXRhKQ0KPiA+ICAJCWRpc2FibGVfaXJxX25vc3luYyhpcnEpOw0KPiA+ICAJCWNpLT53YWtl
dXBfaW50ID0gdHJ1ZTsNCj4gPiAgCQlwbV9ydW50aW1lX2dldChjaS0+ZGV2KTsNCj4gPiAtCQly
ZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4gKwkJcmV0ID0gSVJRX0hBTkRMRUQ7DQo+ID4gIAl9DQo+
ID4gIA0KPiA+ICAJaWYgKGNpLT5pc19vdGcpIHsNCj4gPiAtLSANCj4gPiAyLjI3LjANCj4gPiAN
Cg==
