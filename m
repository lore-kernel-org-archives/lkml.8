Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B11C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DD5206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="EgO5rA34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBKKla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:41:30 -0500
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:29242
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbgBKKl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:41:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8XLFqFipVUW6v1pTDG0d/7hRDjNG6TRCqOpUXxXKEAbZZzTDwIbYFCbaZjeV4GRfMzZ8Y//+UiBQkw6CfehKgtWmsLYz+omlmQjgdH0IqUZ9czobjznkuzdwI10ll4kDzThubUPJWN5VvOlJUzqcaooSIsIZ9uyEnXK8vEty035ASTW4S3wo655UZpDnwKatfk95VyqSBP/rxiRRSNaS4R/ZzEY9GuqwjkQIDXJnA3zVRotAkvEc8PUcY5NRxACDL/J3NOoPb5B0AeIF/kUSS6BfHO/tHdbUn6Fwjkc1ql18FzW8huqTGClvmolOyPnRMkwrtt6VZlRMuieL91jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tDkihZo0MP/9rHRel5OKyOilvsl7lmsUIUxuPWJEVk=;
 b=JMWYDdA/JwmLgutumUvRPkg0K+xyqWUgSkbPH9sT9nOUa935r3GLimDGMLKwsexdcr30GLCr5wYtqQ5XpO6CR8GYNS53o1WtDYUVe9lKVTQUgIHVyS1HZU1uNy1LF0TjxQVzQALdM33aklI3cszBIkEqXyOtbkpk+eSvCushRfqwXvbROOl7Z+4A9KhGrTKG3hxKQBHdrRulcSN6ODIAj9NbRpPgOYa7zDUcJZZv7KENpWktiKUvuMHRqT6mKTDmr57FJrJhJFXfrsk0sbVRy9I/zp89deU3jLFlg/KlN0zrjm3ax9A5GIGgbsBipOi6OH8PKEs0e9M/tn45mfs7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tDkihZo0MP/9rHRel5OKyOilvsl7lmsUIUxuPWJEVk=;
 b=EgO5rA34JrZx9+//3exvQe23BfcE4GPY8KcRaYO0H84UQrZ9IO7yVyiaO2RazalsMUFVR3jq3QOjoc+kgC3ouxUwA2Wmwy0o1qjHEia/fVPij6J14E8lNw2mWxf1TooU+qHOiTvZR9bnQvewO4VKD6YWF0W+BqpFp+luuT/eOM0=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3566.namprd11.prod.outlook.com (20.178.251.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 10:41:26 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 10:41:26 +0000
From:   =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [[PATCH staging] 6/7] staging: wfx: use sleeping gpio accessors
Thread-Topic: [[PATCH staging] 6/7] staging: wfx: use sleeping gpio accessors
Thread-Index: AQHV4LfWip/3nlTlaUy2h9rm5Cx/R6gVzi2A
Date:   Tue, 11 Feb 2020 10:41:26 +0000
Message-ID: <1829603.oaOZQPt0r4@pc-42>
References: <cover.1581410026.git.mirq-linux@rere.qmqm.pl>
 <01ac32e4318da8a7db085c82cfca9831ecec5d40.1581410026.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <01ac32e4318da8a7db085c82cfca9831ecec5d40.1581410026.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c25a25e-0de5-4a21-74b5-08d7aedef256
x-ms-traffictypediagnostic: MN2PR11MB3566:
x-microsoft-antispam-prvs: <MN2PR11MB356663A702F98E2DD9E7D70793180@MN2PR11MB3566.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(6486002)(81166006)(2906002)(8936002)(6916009)(186003)(6506007)(8676002)(81156014)(26005)(6512007)(9686003)(64756008)(66446008)(478600001)(33716001)(91956017)(76116006)(316002)(54906003)(66476007)(66946007)(4326008)(66556008)(71200400001)(85202003)(86362001)(85182001)(5660300002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3566;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhSt70E1ZnoEUIYiElP82JCC/EUTllr8sH/LbLHrgvwRyNs+f/cSRlTsWTis1Y/F1MHUVGdoNIf4I+CV6crz69HPF0N7I8nYM+xzLh2AJ7vBVbD8VopYFh/eCphazh4zEoiqAXTAr08Hya5vzgtNNk8E6jSRybwqYMDA8nDD5WeDs4JGLRhKR1PhXYa57AechHZVoyn/Iaf9HDdtTKB65dpnHT9vacwt2Z706x2AGfH1YI8rN71f7xrl6X4OCZviXikibTE+Z9bl/43MSrw6bhOtUjKU/Nz1E4uTGJX20iAgOjnWBwdPD2pqgYqFpBP+CJ7JsdAFRFttVMgCqD/Om9zA6TwcSXt27WAuigDSfKHw1qW1G9h5nFT995R6Ha3n6G0FGo4Y+bmn+wypLXOkklCyWk9Urp5n4FwJOewf/ZsU9ANs3k9/y6xnRwC4Xscr/7ZOr1/1dnek2FGvu+rXFrAdQh3QEMCRN6V3R/KmHl2Ek7EGMNYeyignoHd9+lTC
x-ms-exchange-antispam-messagedata: OdR80dhz999SiLQdsnsW1CHo7ieZN9U9EdYbE3ZfhhQO0/2pH5M4Njovb6jOyvVIX6/djfntpI9ngqxjJO4LYcNho7ZaahzvxTZP9n3+H9KAJWPd42hsTVtSWNRGhiAKOteJflN8gNTzMmUgIELoxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95E258236B5B4A49AEECCC2A7732F570@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c25a25e-0de5-4a21-74b5-08d7aedef256
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 10:41:26.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0DoIyU4GojM99WzmBu9lE1DurPF0EYOD4/DMJH3YK9L82DT1og1dCLi9BlvoKkub6lqn2t4eqTKU05agYoLkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlc2RheSAxMSBGZWJydWFyeSAyMDIwIDA5OjQ2OjU1IENFVCBNaWNoYcWCIE1pcm9zxYJh
dyB3cm90ZToNCj4gRHJpdmVyIGNhbGxzIEdQSU8gZ2V0L3NldCBvbmx5IGZyb20gbm9uLWF0b21p
YyBjb250ZXh0IGFuZCBzbyBjYW4gdXNlIGFueQ0KPiBHUElPcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4NCj4gLS0tDQo+
ICBkcml2ZXJzL3N0YWdpbmcvd2Z4L2JoLmMgICAgICB8IDYgKysrLS0tDQo+ICBkcml2ZXJzL3N0
YWdpbmcvd2Z4L2J1c19zcGkuYyB8IDQgKystLQ0KPiAgZHJpdmVycy9zdGFnaW5nL3dmeC9tYWlu
LmMgICAgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2JoLmMgYi9k
cml2ZXJzL3N0YWdpbmcvd2Z4L2JoLmMNCj4gaW5kZXggOTgzYzQxZDFmZTdjLi5jNjMxOWFiN2U3
MWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy93ZngvYmguYw0KPiArKysgYi9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2JoLmMNCj4gQEAgLTIwLDEwICsyMCwxMCBAQCBzdGF0aWMgdm9pZCBk
ZXZpY2Vfd2FrZXVwKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQ0KPiAgew0KPiAgICAgICAgIGlmICgh
d2Rldi0+cGRhdGEuZ3Bpb193YWtldXApDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IC0g
ICAgICAgaWYgKGdwaW9kX2dldF92YWx1ZSh3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cCkpDQo+ICsg
ICAgICAgaWYgKGdwaW9kX2dldF92YWx1ZV9jYW5zbGVlcCh3ZGV2LT5wZGF0YS5ncGlvX3dha2V1
cCkpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAtICAgICAgIGdwaW9kX3NldF92
YWx1ZSh3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cCwgMSk7DQo+ICsgICAgICAgZ3Bpb2Rfc2V0X3Zh
bHVlX2NhbnNsZWVwKHdkZXYtPnBkYXRhLmdwaW9fd2FrZXVwLCAxKTsNCj4gICAgICAgICBpZiAo
d2Z4X2FwaV9vbGRlcl90aGFuKHdkZXYsIDEsIDQpKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAo
IWNvbXBsZXRpb25fZG9uZSgmd2Rldi0+aGlmLmN0cmxfcmVhZHkpKQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICB1ZGVsYXkoMjAwMCk7DQo+IEBAIC00NSw3ICs0NSw3IEBAIHN0YXRpYyB2b2lk
IGRldmljZV9yZWxlYXNlKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2KQ0KPiAgICAgICAgIGlmICghd2Rl
di0+cGRhdGEuZ3Bpb193YWtldXApDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiAt
ICAgICAgIGdwaW9kX3NldF92YWx1ZSh3ZGV2LT5wZGF0YS5ncGlvX3dha2V1cCwgMCk7DQo+ICsg
ICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHdkZXYtPnBkYXRhLmdwaW9fd2FrZXVwLCAw
KTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IHJ4X2hlbHBlcihzdHJ1Y3Qgd2Z4X2RldiAqd2Rl
diwgc2l6ZV90IHJlYWRfbGVuLCBpbnQgKmlzX2NuZikNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3RhZ2luZy93ZngvYnVzX3NwaS5jIGIvZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMNCj4g
aW5kZXggYzVmNzgxNjEyMzRkLi42MzRiNGU1YmIwNTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
c3RhZ2luZy93ZngvYnVzX3NwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3Nw
aS5jDQo+IEBAIC0yMDgsOSArMjA4LDkgQEAgc3RhdGljIGludCB3Znhfc3BpX3Byb2JlKHN0cnVj
dCBzcGlfZGV2aWNlICpmdW5jKQ0KPiAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAg
ICBpZiAoc3BpX2dldF9kZXZpY2VfaWQoZnVuYyktPmRyaXZlcl9kYXRhICYgV0ZYX1JFU0VUX0lO
VkVSVEVEKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBncGlvZF90b2dnbGVfYWN0aXZlX2xv
dyhidXMtPmdwaW9fcmVzZXQpOw0KPiAtICAgICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKGJ1
cy0+Z3Bpb19yZXNldCwgMSk7DQo+ICsgICAgICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fu
c2xlZXAoYnVzLT5ncGlvX3Jlc2V0LCAxKTsNCj4gICAgICAgICAgICAgICAgIHVkZWxheSgxMDAp
Ow0KPiAtICAgICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKGJ1cy0+Z3Bpb19yZXNldCwgMCk7
DQo+ICsgICAgICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoYnVzLT5ncGlvX3Jl
c2V0LCAwKTsNCj4gICAgICAgICAgICAgICAgIHVkZWxheSgyMDAwKTsNCj4gICAgICAgICB9DQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmMgYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L21haW4uYw0KPiBpbmRleCA4NGFkYWQ2NGZjMzAuLmU4YmRlYjlhYTNhOSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9z
dGFnaW5nL3dmeC9tYWluLmMNCj4gQEAgLTQyMCw3ICs0MjAsNyBAQCBpbnQgd2Z4X3Byb2JlKHN0
cnVjdCB3ZnhfZGV2ICp3ZGV2KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAiZW5hYmxlICdx
dWllc2NlbnQnIHBvd2VyIG1vZGUgd2l0aCBncGlvICVkIGFuZCBQRFMgZmlsZSAlc1xuIiwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgZGVzY190b19ncGlvKHdkZXYtPnBkYXRhLmdwaW9fd2Fr
ZXVwKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgd2Rldi0+cGRhdGEuZmlsZV9wZHMpOw0K
PiAtICAgICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKHdkZXYtPnBkYXRhLmdwaW9fd2FrZXVw
LCAxKTsNCj4gKyAgICAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcCh3ZGV2LT5w
ZGF0YS5ncGlvX3dha2V1cCwgMSk7DQo+ICAgICAgICAgICAgICAgICBjb250cm9sX3JlZ193cml0
ZSh3ZGV2LCAwKTsNCj4gICAgICAgICAgICAgICAgIGhpZl9zZXRfb3BlcmF0aW9uYWxfbW9kZSh3
ZGV2LCBISUZfT1BfUE9XRVJfTU9ERV9RVUlFU0NFTlQpOw0KPiAgICAgICAgIH0gZWxzZSB7DQo+
IC0tDQo+IDIuMjAuMQ0KPiANCg0KUmV2aWV3ZWQtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJv
bWUucG91aWxsZXJAc2lsYWJzLmNvbT4NCg0KLS0gDQpKw6lyw7RtZSBQb3VpbGxlcg0KDQo=
