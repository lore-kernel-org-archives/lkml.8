Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0422146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lugudhm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCEIoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:44:12 -0500
Received: from mail-eopbgr150129.outbound.protection.outlook.com ([40.107.15.129]:20036
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgCEIoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:44:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHYFtC78jrSpoajpDIQlGQotuZ+vg6k5ha59Q37vZB+EBVGiYDJzi7epYEs7A0gER5KSdhAYL8bYRsq/Q2pjT2CwrRK0mSkHvHzyfFIRV+Quc2RVLZshuAyTYc3b/SZs873z2Tb35APjGCBgb11A88FhvMs0doV3VLfRjA87Or9LgOWDRVMEghPo4Xbzex8rGhkHdmDY168ttvoE0QduY6hk5niDaY9udOOcXnAl8EO/Dg2Ey09nVfspF/1o3HTnUpSEvgxnH8GCw+XyR60uCIhqesxAYz+mdg5id1g3vHM/miYrslXo6ZL8Je+AoyWquhgaCTHY525Z13eGx9AIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0XOU+p6rqZ5221PhnSOt3EZNG3K9O+zu0qIkOijz+A=;
 b=myBuPNSzu1Oxh9gbhrGl30O0QBtTiIaQvsw1su6T8qMJI+MsXqp+zztR4Z+ztir3kcM6lNsxYcfM/zAOIZZZgFiV2DYHHVVqoirmR2TG7Ne4FWEujmAqzkt+g1WHosAATH4QXgu1ij8ukqKuarVxBmoitWxmGiAF5S5P+HVZTjMlu/aJ13Yk4K1EEzVodSPoLCwNfGBstPty2tHg7jzxvWP08U4qDgh2XEo6rFeB05ulc1DDqi/A70BnUMSs+P8eX/7eprHXm70HJAG3OeoiJS7E2ppKj1XHrhMqkOR+FlD8gqJhsqFScu0i+C3SQjg5Gr+y3TUfT77sADm3Z3oAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0XOU+p6rqZ5221PhnSOt3EZNG3K9O+zu0qIkOijz+A=;
 b=lugudhm9d2cg89j2ZVvxiRgC/6wLrigFNA5zZw8gWAtDmbs6EZMniz4kqxBUZj4oybEM/r4mLV4NtbZCMQYU47CYgeQcR4BNkkVfWi3RZ23AwUyfdOuGvx0kaAJNpsHXqCmhxvQ1Cbh2exv+CIEgV8XS4dqnsPKQwZKoOgFnd/c=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (10.167.127.12) by
 HE1PR0702MB3836.eurprd07.prod.outlook.com (52.133.5.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5; Thu, 5 Mar 2020 08:43:33 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87%5]) with mapi id 15.20.2793.011; Thu, 5 Mar 2020
 08:43:33 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>
CC:     "williams@redhat.com" <williams@redhat.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 4/5] perf bench: Share some global variables to fix build
 with gcc 10
Thread-Topic: [PATCH 4/5] perf bench: Share some global variables to fix build
 with gcc 10
Thread-Index: AQHV8ZTykRSfudvvH0q4VUAIVRb2L6g5sSMA
Date:   Thu, 5 Mar 2020 08:43:32 +0000
Message-ID: <bb1a3048a0f75d1fdf497c67d16a022cdd15c437.camel@nokia.com>
References: <20200303194827.6461-1-acme@kernel.org>
         <20200303194827.6461-5-acme@kernel.org>
In-Reply-To: <20200303194827.6461-5-acme@kernel.org>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ee40b5b-abbf-4a0e-b148-08d7c0e149af
x-ms-traffictypediagnostic: HE1PR0702MB3836:
x-microsoft-antispam-prvs: <HE1PR0702MB3836FD5633D3CC71C3D1F561B4E20@HE1PR0702MB3836.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(6486002)(71200400001)(54906003)(110136005)(36756003)(81166006)(76116006)(26005)(186003)(2906002)(81156014)(7416002)(478600001)(2616005)(66476007)(5660300002)(66946007)(64756008)(66446008)(66556008)(8936002)(6512007)(8676002)(4326008)(86362001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3836;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yqVbg6x2qFZ12IT1i/IAf0/G4u3w8uT8LC1xtkZ1k3LwQtwDEvrHuWXMDiU42xE8CGEBVH9P/UIvQE1AFhp5P47N4FDOhmeCl92DQOhpmmOR5IYN7orYibR08l3G7c3ox9O0CEL4l6AHsl2IZbhbZrQAvz4ssfsjGkEj6NCB9ACBj37Kj4KEmoDxqGwuj3JzrE8dFk+oRlNiSJAWq00HMwmmdmiDZhErYsALOdGehOwRigJMbuvUUIXc6iqTGalPYn2EHqOY3QrOjha9yd6bwzhmTNpki6geAbwhcjyZ2vguqZiByxfyO9H1nigQp9KO5S42kqDfYHtfDTiDDVEt1FjJ0wDS5BkDoio9/U1mKibCwLanhFXwaj4Dt8GrmYt5hrsn/VBdkNJYzHLl2xs6Hvc9zE6POWLFSsBtEq7pHtTK9U6rFCLp4ouBQoFd8oa6
x-ms-exchange-antispam-messagedata: /UVnvmy/jCS0/WzXQi3xCCSne9QBH97KXmNCug1SlMcx91dlGJYjlKd+MeKKwUoZN/Q2zIgDJEE4haUC9pyryU5tSLqR0DAn9IHaZvYYmsdsKD1faDztOHB5NxOad8psGZ+8rBm9U2rWltP32Sb0tg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBCBB3ABE3FB454DA4566DFD0905E922@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee40b5b-abbf-4a0e-b148-08d7c0e149af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 08:43:32.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S301rbVIj/xwr4WHHl/wU/zwrxvb5KdzPfb0trqsX9YASBY1baS/SzEjnvJPqmifZTvVJnoxOm/t3h+NwenUa46tIuNHo6tOvpSDt8v0inA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDE2OjQ4IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IEZyb206IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUByZWRoYXQu
Y29tPg0KDQpCVFcgdGhlcmUncyBhbHNvIHNvbWUgZGl2LWJ5LXplcm8gYnVncyBoZXJlIGlmIHJ1
bnRpbWUgaXMgemVybzoNCg0KJCBwZXJmIGJlbmNoIGVwb2xsIHdhaXQgLS1ydW50aW1lPTANCiMg
UnVubmluZyAnZXBvbGwvd2FpdCcgYmVuY2htYXJrOg0KUnVuIHN1bW1hcnkgW1BJRCAzMDg1OV06
IDcgdGhyZWFkcyBtb25pdG9yaW5nIG9uIDY0IGZpbGUtZGVzY3JpcHRvcnMgZm9yIDANCnNlY3Mu
DQoNCkZsb2F0aW5nIHBvaW50IGV4Y2VwdGlvbiAoY29yZSBkdW1wZWQpDQoNCj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL3BlcmYvYmVuY2gvZXBvbGwtd2FpdC5jIGIvdG9vbHMvcGVyZi9iZW5jaC9lcG9s
bC0NCj4gd2FpdC5jDQo+IGluZGV4IDdhZjY5NDQzN2Y0ZS4uZDFjNWNiNTI2YjlmIDEwMDY0NA0K
PiAtLS0gYS90b29scy9wZXJmL2JlbmNoL2Vwb2xsLXdhaXQuYw0KPiArKysgYi90b29scy9wZXJm
L2JlbmNoL2Vwb2xsLXdhaXQuYw0KPiANCj4gQEAgLTUxOSw3ICs1MTgsNyBAQCBpbnQgYmVuY2hf
ZXBvbGxfd2FpdChpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YpDQo+ICAJCXFzb3J0KHdvcmtl
ciwgbnRocmVhZHMsIHNpemVvZihzdHJ1Y3Qgd29ya2VyKSwgY21wd29ya2VyKTsNCj4gIA0KPiAg
CWZvciAoaSA9IDA7IGkgPCBudGhyZWFkczsgaSsrKSB7DQo+IC0JCXVuc2lnbmVkIGxvbmcgdCA9
IHdvcmtlcltpXS5vcHMvcnVudGltZS50dl9zZWM7DQo+ICsJCXVuc2lnbmVkIGxvbmcgdCA9IHdv
cmtlcltpXS5vcHMgLyBiZW5jaF9fcnVudGltZS50dl9zZWM7DQo+ICANCj4gIAkJdXBkYXRlX3N0
YXRzKCZ0aHJvdWdocHV0X3N0YXRzLCB0KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVy
Zi9iZW5jaC9mdXRleC1oYXNoLmMgYi90b29scy9wZXJmL2JlbmNoL2Z1dGV4LQ0KPiBoYXNoLmMN
Cj4gaW5kZXggOGJhMGMzMzMwYTlhLi4yMTc3Njg2MmU5NDAgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L3BlcmYvYmVuY2gvZnV0ZXgtaGFzaC5jDQo+ICsrKyBiL3Rvb2xzL3BlcmYvYmVuY2gvZnV0ZXgt
aGFzaC5jDQo+IA0KPiBAQCAtMjA0LDcgKzIwNCw3IEBAIGludCBiZW5jaF9mdXRleF9oYXNoKGlu
dCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikNCj4gIAlwdGhyZWFkX211dGV4X2Rlc3Ryb3koJnRo
cmVhZF9sb2NrKTsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGkgPCBudGhyZWFkczsgaSsrKSB7DQo+
IC0JCXVuc2lnbmVkIGxvbmcgdCA9IHdvcmtlcltpXS5vcHMvcnVudGltZS50dl9zZWM7DQo+ICsJ
CXVuc2lnbmVkIGxvbmcgdCA9IHdvcmtlcltpXS5vcHMgLyBiZW5jaF9fcnVudGltZS50dl9zZWM7
DQo+ICAJCXVwZGF0ZV9zdGF0cygmdGhyb3VnaHB1dF9zdGF0cywgdCk7DQo+ICAJCWlmICghc2ls
ZW50KSB7DQo+ICAJCQlpZiAobmZ1dGV4ZXMgPT0gMSkNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bl
cmYvYmVuY2gvZnV0ZXgtbG9jay1waS5jIGIvdG9vbHMvcGVyZi9iZW5jaC9mdXRleC0NCj4gbG9j
ay1waS5jDQo+IGluZGV4IGQwY2FlODEyNTQyMy4uMzBkOTcxMjFkYzRmIDEwMDY0NA0KPiAtLS0g
YS90b29scy9wZXJmL2JlbmNoL2Z1dGV4LWxvY2stcGkuYw0KPiArKysgYi90b29scy9wZXJmL2Jl
bmNoL2Z1dGV4LWxvY2stcGkuYw0KPiANCj4gQEAgLTIxMSw3ICsyMTAsNyBAQCBpbnQgYmVuY2hf
ZnV0ZXhfbG9ja19waShpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YpDQo+ICAJcHRocmVhZF9t
dXRleF9kZXN0cm95KCZ0aHJlYWRfbG9jayk7DQo+ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwgbnRo
cmVhZHM7IGkrKykgew0KPiAtCQl1bnNpZ25lZCBsb25nIHQgPSB3b3JrZXJbaV0ub3BzL3J1bnRp
bWUudHZfc2VjOw0KPiArCQl1bnNpZ25lZCBsb25nIHQgPSB3b3JrZXJbaV0ub3BzIC8gYmVuY2hf
X3J1bnRpbWUudHZfc2VjOw0KPiAgDQo+ICAJCXVwZGF0ZV9zdGF0cygmdGhyb3VnaHB1dF9zdGF0
cywgdCk7DQo+ICAJCWlmICghc2lsZW50KQ0KDQo=
