Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DABC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5172072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="gR4XktBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgFDH36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:29:58 -0400
Received: from mail-eopbgr1400115.outbound.protection.outlook.com ([40.107.140.115]:61477
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbgFDH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:29:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYV3LXNOh4WLO0dk8BhVetwsywZFp3xQSmO3o6gX09/oFS99r0Dhtx36p+gWM/2eyT05P61zBOLW6AkChWamAPi1oQxoGcyawJ+e5cJcuGalVp+YMUJI4zziosjLCgmrufkl9UFIQvavm6hW9tKtapv8LJctwObQ+yiTLEfv8NZ+ct55p+2McPVmqBlcrXdgmL7VA9zzy+6XoC4v7eHZHcy59zYtjYF7a2sJ3BWkk5iw1YVaV4SJnrdeU1qHJVX4ylIgv04lkKWS1UL9GDW1kgbKXKofAYdYvbQO7lTp/Ir9Di/vsN+z8KGeTRpbztwPp4O3KVG3FLI95r+07YzEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJJveFjxg5MyDnLPdCOmwTN6UkaubPru6J+BBIzOTbU=;
 b=anLZxCVlrfiKk4aQSjpRWJiG9I/+ST87sZXF3hvmSr1C5Axx0OGZdDwnL/ak5XhOXjOmuouOHcKQ6WYJ5/zBPyG9XnzWtwgnn8qbZw37e3aTqLnbzW6X1nsCHOJ0eBqJDuNIIrLqyu4U3BO6NnWwyEjNwlWo7z7OKx/nDAI6AhE6rKG/zOUcJ5Buiv4LbNTMiqfyyNqrvBw5jeCrAjnYWD22Xakm0PC7XX7f3hd74snQdtdrsb6VKYUw9BYZCbNo6+/mg/OV2lKSM8KOck4Nw8ydCaOMG/oaY5GXPR0PJGq4PuleVUVHUCsdGIxgX912kXYmFIkj4ZPSqt3W3bNz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJJveFjxg5MyDnLPdCOmwTN6UkaubPru6J+BBIzOTbU=;
 b=gR4XktBIrN9gYL6Qy8jOcwmdTuuQRe/5MfM9eljzfUNl3HBfXx48GIksAW2+O69j8GHYo8FfQWcW9il+wfYkgbYfQa5g0I9C7orVU1nTvtowqBPTv9jeXNzIE/6R6OPNI5frPSPJnxIkQBx/7CFjVkrN9EpBIcE6TAwyif5sMug=
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com (2603:1096:403:e::12)
 by TYXPR01MB1774.jpnprd01.prod.outlook.com (2603:1096:403:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Thu, 4 Jun
 2020 07:29:49 +0000
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe]) by TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe%7]) with mapi id 15.20.3045.018; Thu, 4 Jun 2020
 07:29:49 +0000
From:   "Tada, Kenta (Sony)" <Kenta.Tada@sony.com>
To:     Waiman Long <longman@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Topic: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Index: AdY5cwNjHOfD1WXzRFK+VbW3aFu0ZgASi0kAACClRRA=
Date:   Thu, 4 Jun 2020 07:29:48 +0000
Message-ID: <TYXPR01MB1503D6F73C6356DED5D2C849F5890@TYXPR01MB1503.jpnprd01.prod.outlook.com>
References: <TYXPR01MB150318D484EE220452A5085AF5880@TYXPR01MB1503.jpnprd01.prod.outlook.com>
 <d0356d0a-83dd-f3ae-c0ba-82089976c014@redhat.com>
In-Reply-To: <d0356d0a-83dd-f3ae-c0ba-82089976c014@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [211.125.130.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e327e089-aba4-40a3-9f22-08d808591042
x-ms-traffictypediagnostic: TYXPR01MB1774:
x-microsoft-antispam-prvs: <TYXPR01MB177458E27DE799D0AFB7881DF5890@TYXPR01MB1774.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTG9LWe/56jO/nM+tvm1Lltb5eox0rYHK1uoyqjqOqSYq8uvscAlizvl6ITLu6LJQrGOj6cmEu6xulRIC3Md6axa9D8PXs0i8FsH7bcadCkLN6aV8y02k2wWVhkMsWVdDDoEjJU53MYZjtBQOom6cWIcDZU5w1XCG6SPTa9UvHBV0hqas2WxXnX769rFrh3XkDM7EFpVL7RKwie3DAwCFQDPEwq7zZ8hU0QEZixu678SCwvhVQJpcHH9IrZX4WasibrGq92sIZmBzZJohU1qWfBBpWwrfSTBsEOgoL2iDAI0jtiV9zZeQEq7pI6JMt4Rv5QZpyUsrxM8hoiUhgHt+NDeEHTvrQ296ksC/0A+dCKXoTDm5p6IBfnPDr1XnlCj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1503.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(316002)(53546011)(33656002)(71200400001)(4326008)(8676002)(26005)(86362001)(8936002)(2906002)(64756008)(7416002)(110136005)(6506007)(66446008)(83380400001)(66556008)(66946007)(5660300002)(9686003)(7696005)(76116006)(52536014)(478600001)(186003)(66476007)(55016002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: e6THDXd1vHlivvfGx/ELEnUWgBujbJTy0wPW2th1iI6TtyzdjFSeSmHicLdjt88IYwYkdVaHKqkp0FW4MoxBIvoMCk7AMpHRwI6j7sQUGIuyer2h0o/v2h2ei71Nv0Dgemq63FLRTTFPGy3wfgzg1bHsX+KKgxfk6MzMtDdaFWx+epFzRDB30I76dLFVBJyvlRkHhqV/rgekvBmiLvT5uAnvl6EeFxbZYzz+1H5seqmrVc03EtEhaLJXbKmWvrcap7HEfmry+bB7S6MW1h4C5CCzItecirCNaZl5wpyhiWkc/0uAhLrVj9WmX/NvS7FDyZ/Pux3o21eDV4E4Thzbs29zy8FuconWREQgD7j1HPfn2E2MoZv5St4hHb/GAknBxKiphfCBuRvHeDX8t+VyRVcxDjBfilXDNLmlC6tFfhAraSW9JEg3J3rR3SzzbJKWq4y7QsZquTOS6mIFwjCJ0JKDAmwaCGQ/ewkur8OP7tZQz0I2Chp700b2MGefBsTg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e327e089-aba4-40a3-9f22-08d808591042
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 07:29:48.8269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hOYYY10xaEnY6CDaqYXmP4TWH/NHQvNlay4ClmZcTaZLCVDo+XqNXezLDNybKyrBnJKw5YSGBMQck0+4Nj00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pkl0IGNvbmZsaWN0cyB3aXRoIHlvdXIgbmV3IGNvZGUuIFdlIGNhbiBoYXZlIGFuIGFyZ3VtZW50
IG9uIHdoZXRoZXIgSUIgc2hvdWxkIGZvbGxvdyBob3cgU1NCIGlzIGJlaW5nIGhhbmRsZWQuIEJl
Zm9yZSB0aGF0IGlzIHNldHRsZWQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uLg0K
SXQgY29uZmxpY3RzIGJ1dCBJIHRoaW5rIHVzZXJzIHdobyByZWFkIHRoZSBiZWxvdyBkb2N1bWVu
dCBnZXQgY29uZnVzZWQuDQpEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvc3BlY19jdHJsLnJz
dC4NCg0KRXNwZWNpYWxseSwgc2VjY29tcCB1c2VycyBtdXN0IGtub3cgdGhlIGRpZmZlcmVuY2Ug
b2YgdGhpcyBpbXBsaWNpdCBzcGVjaWZpY2F0aW9uDQpiZWNhdXNlIGJvdGggSUIgYW5kIFNTQiBh
cmUgZm9yY2UgZGlzYWJsZWQgc2ltdWx0YW5lb3VzbHkgd2hlbiBzZWNjb21wIGlzIGVuYWJsZWQN
CndpdGhvdXQgU0VDQ09NUF9GSUxURVJfRkxBR19TUEVDX0FMTE9XIG9uIHg4Ni4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5j
b20+IA0KU2VudDogVGh1cnNkYXksIEp1bmUgNCwgMjAyMCAxMjo0MCBBTQ0KVG86IFRhZGEsIEtl
bnRhIChTb255KSA8S2VudGEuVGFkYUBzb255LmNvbT47IHg4NkBrZXJuZWwub3JnOyB0Z2x4QGxp
bnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsgaHBhQHp5dG9yLmNv
bTsganBvaW1ib2VAcmVkaGF0LmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IHRvbnkubHVja0Bp
bnRlbC5jb207IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbQ0KQ2M6IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHg4Ni9zcGVjdWxhdGlv
bjogQ2hlY2sgd2hldGhlciBzcGVjdWxhdGlvbiBpcyBmb3JjZSBkaXNhYmxlZA0KDQpPbiA2LzMv
MjAgMzoxMiBBTSwgVGFkYSwgS2VudGEgKFNvbnkpIHdyb3RlOg0KPiBPbmNlIFBSX1NQRUNfRk9S
Q0VfRElTQUJMRSBpcyBzZXQsIHVzZXJzIGNhbm5vdCBzZXQgUFJfU1BFQ19FTkFCTEUuDQo+IFRo
aXMgY29tbWl0IGNoZWNrcyB3aGV0aGVyIFBSX1NQRUNfRk9SQ0VfRElTQUJMRSB3YXMgcHJldmlv
dXNseSBzZXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtlbnRhIFRhZGEgPEtlbnRhLlRhZGFAc29u
eS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIHwgMyArKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIA0KPiBp
bmRleCBlZDU0YjNiMjFjMzkuLjY3OGFjZTE1NzAzNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL2NwdS9idWdzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4g
QEAgLTExNzMsNiArMTE3Myw5IEBAIHN0YXRpYyBpbnQgaWJfcHJjdGxfc2V0KHN0cnVjdCB0YXNr
X3N0cnVjdCAqdGFzaywgdW5zaWduZWQgbG9uZyBjdHJsKQ0KPiAgIAkJaWYgKHNwZWN0cmVfdjJf
dXNlciA9PSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUIHx8DQo+ICAgCQkgICAgc3BlY3RyZV92Ml91
c2VyID09IFNQRUNUUkVfVjJfVVNFUl9TVFJJQ1RfUFJFRkVSUkVEKQ0KPiAgIAkJCXJldHVybiAt
RVBFUk07DQo+ICsJCS8qIElmIHNwZWN1bGF0aW9uIGlzIGZvcmNlIGRpc2FibGVkLCBlbmFibGUg
aXMgbm90IGFsbG93ZWQgKi8NCj4gKwkJaWYgKHRhc2tfc3BlY19pYl9mb3JjZV9kaXNhYmxlKHRh
c2spKQ0KPiArCQkJcmV0dXJuIC1FUEVSTTsNCj4gICAJCXRhc2tfY2xlYXJfc3BlY19pYl9kaXNh
YmxlKHRhc2spOw0KPiAgIAkJdGFza191cGRhdGVfc3BlY190aWYodGFzayk7DQo+ICAgCQlicmVh
azsNCg0KVGhlcmUgaXMgYSBjb21tZW50IHVwIGEgZmV3IGxpbmVzIGFib3V0IHRoaXM6DQoNCiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIEluZGlyZWN0IGJyYW5jaCBzcGVjdWxhdGlvbiBpcyBhbHdheXMgYWxsb3dl
ZCB3aGVuDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBtaXRpZ2F0aW9uIGlz
IGZvcmNlIGRpc2FibGVkLg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQpJ
dCBjb25mbGljdHMgd2l0aCB5b3VyIG5ldyBjb2RlLiBXZSBjYW4gaGF2ZSBhbiBhcmd1bWVudCBv
biB3aGV0aGVyIElCIHNob3VsZCBmb2xsb3cgaG93IFNTQiBpcyBiZWluZyBoYW5kbGVkLiBCZWZv
cmUgdGhhdCBpcyBzZXR0bGVkLA0KDQpOYWNrZWQtYnk6IFdhaW1hbiBMb25nIDxsb25nbWFuQHJl
ZGhhdC5jb20+DQoNCg==
