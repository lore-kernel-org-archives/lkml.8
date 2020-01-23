Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2BC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C989420718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAWDTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 22:19:03 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:45739 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgAWDTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 22:19:03 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Thu, 23 Jan 2020 03:18:11 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 23 Jan 2020 03:17:35 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 23 Jan 2020 03:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMs+AhFWYTfgtTQW+ZOj3jBPNTKkdhzmLRZoYP8xuDs9IyFVhhgx+5SvHMchkBBQ+6+wmHljpultH+R0cK3VguV7IWe07+cHcxKkTA6N5V7n35NQNxHObF2U4gRgrGYkk405tWgBI3cdt5zzEN7CEx8HGkh6nYQgJlqrPOHGkQviWpoG0sksBcGy6xhLkC20R6ehnENwK1Ev5mQOzEsT+wIsiqYpVFN7GMAQkaRydYKkMYKbUyQsN1KSfMn5cz51k6rXCBWd8+cHGoTRoVxzpPaWqRLUXABv6kN5j5hTEFucUYN2m66NicXoS+iFGUD81dMM1qZyaY0fIquVPtZY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md0pB7/kLYOzIRGoV5gkIcMSpeT/tyFzzsKzZXIoty8=;
 b=b43uY2blH54CkvRVmW4HT+lq8w1rD8nioKp1qN6bm49pEKkSO3ccL2LZVuTez3qq/I1d9WuA2SDWqUJW/573cXfAVmN2ZS4AniIv4SJ10YFWsbU87uVWD8kHI/TXFAAMxFpmTq/sFAZyTBgfz1FyDTAnyRRFWyL8NH81vCiBz3Fv7EF4z//q/KburvTIt9wjK5JYOPiXp6lKnxvs9iRzS5cvNBtaGN6GmMfcDS2rLXmu3styERFrT9p0okomN5STKl6f37Z65YcuzN80187Kpo6yUvY8528OcHlRsSsoI2YYn4nl9BTBRz1vVHpiGxtfwiyOjAiHW5MXwouEwCWW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3206.namprd18.prod.outlook.com (52.132.247.79) by
 CH2PR18MB3304.namprd18.prod.outlook.com (52.132.245.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 03:17:34 +0000
Received: from CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::18a6:4bd:28d2:67de]) by CH2PR18MB3206.namprd18.prod.outlook.com
 ([fe80::18a6:4bd:28d2:67de%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 03:17:34 +0000
From:   Gang He <GHe@suse.com>
To:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Topic: [PATCH] ocfs2: fix the oops problem when write cloned file
Thread-Index: AQHV0Bf49UeZZZUyKki8pGxA20UtZKf3lezw
Date:   Thu, 23 Jan 2020 03:17:33 +0000
Message-ID: <CH2PR18MB3206B8AA09D9D7EA41F0E688CF0F0@CH2PR18MB3206.namprd18.prod.outlook.com>
References: <20200121050153.13290-1-ghe@suse.com>
In-Reply-To: <20200121050153.13290-1-ghe@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=GHe@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fac17bd4-b98e-4b89-4883-08d79fb2ca27
x-ms-traffictypediagnostic: CH2PR18MB3304:
x-microsoft-antispam-prvs: <CH2PR18MB3304ECECA78153EA26C2DB6ECF0F0@CH2PR18MB3304.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(54906003)(110136005)(7696005)(81156014)(81166006)(316002)(33656002)(71200400001)(9686003)(26005)(186003)(55016002)(2906002)(52536014)(86362001)(6506007)(4326008)(8936002)(8676002)(5660300002)(53546011)(478600001)(66476007)(76116006)(66556008)(64756008)(66446008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3304;H:CH2PR18MB3206.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rXXG8en7j98grsKG8nFLfQ8BiXJdB1tGg3uqi9SS+OFi2AINkRhDKOr1SddvAJBT9I6VhATeUb580RaqTeMPccOBNPB8DZTadPclIASKCCCZ2PP2/DYNW3hPMZHbLPHy7Wy5tlLBcQYQXt+xn1FlDl6f9dK91HjT1m4VyRtmnmpXWkl7t1TD4C8+bZ23Vjm0u/Q2OIRH0+8sQ2qmYxLtN8t6cvElH01e538sGFihk/EteCVqe/HDILyyVe+znsyBMOkwk/8lKg5tV4n6moXIBriTbEInwIa8KsDcTjZqyu0EHGtFTsDir8i4YuTb27IIYsPx3eYLDspbMryTEhTicpTfHMM2eEM9I89umVn/WyZY/z5Mkw8TgSGcgtYWD+8W9zRI55ZKze21AUOwfENWiQ54vDiToUI+X4ZjelpnxvakA5r44n0fhJ0Kg9YG8h5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fac17bd4-b98e-4b89-4883-08d79fb2ca27
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 03:17:33.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlgte6ZGrBXBH2bOD1QUpA1OeggYYG56gXsWIN43H1dT6BIN+3/Jqp6JZrc5msf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3304
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3V5cywNCg0KSGFwcHkgTHVuYXIgTmV3IFllYXIuDQpJZiB5b3UgYXJlIGZyZWUsIHBs
ZWFzZSBoZWxwIHRvIHJldmlldyB0aGlzIHBhdGNoLg0KU2luY2UgdGhpcyBpcyBhIHJlZ3Jlc3Np
b24gaXNzdWUsIGJyb2tlIHdyaXRpbmcgY2xvbmVkIGZpbGVzLg0KVGhlIHJvb3QgY2F1c2UgaXMg
aW5vZGUgYnVmZmVyIGhlYWQgaXMgTlVMTCB3aGVuIGNhbGxpbmcgb2NmczJfcmVmY291bnRfY293
Lg0KDQpUaGFua3MNCkdhbmcgDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogR2FuZyBIZQ0KPiBTZW50OiAyMDIwxOox1MIyMcjVIDEzOjAyDQo+IFRvOiBtYXJrQGZhc2hl
aC5jb207IGpsYmVjQGV2aWxwbGFuLm9yZzsgam9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tDQo+
IENjOiBHYW5nIEhlIDxHSGVAc3VzZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBvY2ZzMi1kZXZlbEBvc3Mub3JhY2xlLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0hdIG9jZnMyOiBmaXggdGhlIG9vcHMgcHJvYmxlbSB3aGVuIHdy
aXRlIGNsb25lZCBmaWxlDQo+IA0KPiBXcml0aW5nIGEgY2xvbmVkIGZpbGUgdHJpZ2dlcnMgYSBr
ZXJuZWwgb29wcyBhbmQgdGhlIHVzZXItc3BhY2UgY29tbWFuZA0KPiBwcm9jZXNzIGlzIGFsc28g
a2lsbGVkIGJ5IHRoZSBzeXN0ZW0uDQo+IFRoZSBidWcgY2FuIGJlIHJlcHJvZHVjZWQgc3RhYmx5
LCBlLmcuDQo+IDEpY3JlYXRlIGEgZmlsZSB1bmRlciBvY2ZzMiBmaWxlIHN5c3RlbSBkaXJlY3Rv
cnkuDQo+ICAgam91cm5hbGN0bCAtYiA+IGFhLnR4dA0KPiAyKWNyZWF0ZSBhIGNsb25lZCBmaWxl
IGZvciB0aGlzIGZpbGUuDQo+ICAgcmVmbGluayBhYS50eHQgYmIudHh0DQo+IDMpd3JpdGUgdGhl
IGNsb25lZCBmaWxlIHdpdGggZGQgY29tbWFuZC4NCj4gICBkZCBpZj0vZGV2L3plcm8gb2Y9YmIu
dHh0IGJzPTUxMiBjb3VudD0xIGNvbnY9bm90cnVuYw0KPiANCj4gVGhlIGRkIGNvbW1hbmQgaXMg
a2lsbGVkIGJ5IHRoZSBrZXJuZWwsIHRoZW4geW91IGNhbiBzZWUgdGhlIG9vcHMgbWVzc2FnZQ0K
PiB2aWEgZG1lc2cgY29tbWFuZC4NCj4gDQo+IFsgIDQ2My44NzU0MDRdIEJVRzoga2VybmVsIE5V
TEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczoNCj4gMDAwMDAwMDAwMDAwMDAyOCBbICA0
NjMuODc1NDEzXSAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsDQo+IG1vZGUg
WyAgNDYzLjg3NTQxNl0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdl
DQo+IFsgIDQ2My44NzU0MThdIFBHRCAwIFA0RCAwIFsgIDQ2My44NzU0MjVdIE9vcHM6IDAwMDAg
WyMxXSBTTVAgUFRJDQo+IFsgIDQ2My44NzU0MzFdIENQVTogMSBQSUQ6IDIyOTEgQ29tbTogZGQg
VGFpbnRlZDogRyAgICAgICAgICAgT0UNCj4gNS4zLjE2LTItZGVmYXVsdA0KPiBbICA0NjMuODc1
NDMzXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2
KSwNCj4gQklPUyBCb2NocyAwMS8wMS8yMDExIFsgIDQ2My44NzU1MDBdIFJJUDoNCj4gMDAxMDpv
Y2ZzMl9yZWZjb3VudF9jb3crMHhhNC8weDVkMCBbb2NmczJdIFsgIDQ2My44NzU1MDVdIENvZGU6
IDA2IDg5DQo+IDZjIDI0IDM4IDg5IGViIGY2IDQ0IDI0IDNjIDAyIDc0IGJlIDQ5IDhiIDQ3IDI4
IFsgIDQ2My44NzU1MDhdIFJTUDoNCj4gMDAxODpmZmZmYTJjYjQwOWRmY2U4IEVGTEFHUzogMDAw
MTAyMDIgWyAgNDYzLjg3NTUxMl0gUkFYOg0KPiBmZmZmOGIxZWJkY2E4MDAwIFJCWDogMDAwMDAw
MDAwMDAwMDAwMSBSQ1g6IGZmZmY4YjFlYjczYTlkZjANCj4gWyAgNDYzLjg3NTUxNV0gUkRYOiAw
MDAwMDAwMDAwMDU2YTAxIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6DQo+IDAwMDAwMDAwMDAw
MDAwMDAgWyAgNDYzLjg3NTUxN10gUkJQOiAwMDAwMDAwMDAwMDAwMDAxIFIwODoNCj4gZmZmZjhi
MWViNzNhOWRlMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAgWyAgNDYzLjg3NTUyMF0gUjEwOg0KPiAw
MDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IDAwMDAwMDAwMDAwMDAw
MDANCj4gWyAgNDYzLjg3NTUyMl0gUjEzOiBmZmZmOGIxZWI5MjJmMDQ4IFIxNDogMDAwMDAwMDAw
MDAwMDAwMCBSMTU6DQo+IGZmZmY4YjFlYjkyMmYwNDggWyAgNDYzLjg3NTUyNl0gRlM6ICAwMDAw
N2Y4ZjQ0ZDE1NTQwKDAwMDApDQo+IEdTOmZmZmY4YjFlYmViMDAwMDAoMDAwMCkga25sR1M6MDAw
MDAwMDAwMDAwMDAwMCBbICA0NjMuODc1NTI5XSBDUzoNCj4gMDAxMCBEUzogMDAwMCBFUzogMDAw
MCBDUjA6IDAwMDAwMDAwODAwNTAwMzMgWyAgNDYzLjg3NTUzMl0gQ1IyOg0KPiAwMDAwMDAwMDAw
MDAwMDI4IENSMzogMDAwMDAwMDAzYzE3YTAwMCBDUjQ6IDAwMDAwMDAwMDAwMDA2ZTANCj4gWyAg
NDYzLjg3NTU0Nl0gQ2FsbCBUcmFjZToNCj4gWyAgNDYzLjg3NTU5Nl0gID8gb2NmczJfaW5vZGVf
bG9ja19mdWxsX25lc3RlZCsweDE4Yi8weDk2MCBbb2NmczJdDQo+IFsgIDQ2My44NzU2NDhdICBv
Y2ZzMl9maWxlX3dyaXRlX2l0ZXIrMHhhZjgvMHhjNzAgW29jZnMyXSBbICA0NjMuODc1NjcyXQ0K
PiBuZXdfc3luY193cml0ZSsweDEyZC8weDFkMCBbICA0NjMuODc1Njg4XSAgdmZzX3dyaXRlKzB4
YWQvMHgxYTANCj4gWyAgNDYzLjg3NTY5N10gIGtzeXNfd3JpdGUrMHhhMS8weGUwIFsgIDQ2My44
NzU3MTBdDQo+IGRvX3N5c2NhbGxfNjQrMHg2MC8weDFmMCBbICA0NjMuODc1NzQzXQ0KPiBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJlDQo+IFsgIDQ2My44NzU3NThdIFJJ
UDogMDAzMzoweDdmOGY0NDgyZWQ0NA0KPiBbICA0NjMuODc1NzYyXSBDb2RlOiAwMCBmNyBkOCA2
NCA4OSAwMiA0OCBjNyBjMCBmZiBmZiBmZiBmZiBlYiBiNyAwZiAxZiA4MCAwMA0KPiAwMCAwMCBb
ICA0NjMuODc1NzY1XSBSU1A6IDAwMmI6MDAwMDdmZmYzMDBhNzlkOCBFRkxBR1M6IDAwMDAwMjQ2
DQo+IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxIFsgIDQ2My44NzU3NjldIFJBWDogZmZmZmZm
ZmZmZmZmZmZkYSBSQlg6DQo+IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwN2Y4ZjQ0ODJlZDQ0
IFsgIDQ2My44NzU3NzFdIFJEWDoNCj4gMDAwMDAwMDAwMDAwMDIwMCBSU0k6IDAwMDA1NWY3NzFi
NWMwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDAxDQo+IFsgIDQ2My44NzU3NzRdIFJCUDogMDAwMDAw
MDAwMDAwMDIwMCBSMDg6IDAwMDA3ZjhmNDRhZjljNzggUjA5Og0KPiAwMDAwMDAwMDAwMDAwMDAz
IFsgIDQ2My44NzU3NzZdIFIxMDogMDAwMDAwMDAwMDAwMDg5ZiBSMTE6DQo+IDAwMDAwMDAwMDAw
MDAyNDYgUjEyOiAwMDAwNTVmNzcxYjVjMDAwIFsgIDQ2My44NzU3NzldIFIxMzoNCj4gMDAwMDAw
MDAwMDAwMDIwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwNTVmNzcxYjVjMDAwDQo+
IA0KPiBUaGlzIHJlZ3Jlc3Npb24gcHJvYmxlbSB3YXMgaW50cm9kdWNlZCBieSBjb21taXQgZTc0
NTQwYjI4NTU2ICgib2NmczI6DQo+IHByb3RlY3QgZXh0ZW50IHRyZWUgaW4gb2NmczJfcHJlcGFy
ZV9pbm9kZV9mb3Jfd3JpdGUoKSIpLg0KPiANCj4gRml4ZXM6IGU3NDU0MGIyODU1NiAoIm9jZnMy
OiBwcm90ZWN0IGV4dGVudCB0cmVlIGluDQo+IG9jZnMyX3ByZXBhcmVfaW5vZGVfZm9yX3dyaXRl
KCkiKS4NCj4gU2lnbmVkLW9mZi1ieTogR2FuZyBIZSA8Z2hlQHN1c2UuY29tPg0KPiAtLS0NCj4g
IGZzL29jZnMyL2ZpbGUuYyB8IDE0ICsrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL29j
ZnMyL2ZpbGUuYyBiL2ZzL29jZnMyL2ZpbGUuYyBpbmRleA0KPiA5ODc2ZGI1MjkxM2EuLjZjZDVl
NDkyNGU0ZCAxMDA2NDQNCj4gLS0tIGEvZnMvb2NmczIvZmlsZS5jDQo+ICsrKyBiL2ZzL29jZnMy
L2ZpbGUuYw0KPiBAQCAtMjEwMSwxNyArMjEwMSwxNSBAQCBzdGF0aWMgaW50IG9jZnMyX2lzX2lv
X3VuYWxpZ25lZChzdHJ1Y3QgaW5vZGUNCj4gKmlub2RlLCBzaXplX3QgY291bnQsIGxvZmZfdCBw
b3MpICBzdGF0aWMgaW50DQo+IG9jZnMyX2lub2RlX2xvY2tfZm9yX2V4dGVudF90cmVlKHN0cnVj
dCBpbm9kZSAqaW5vZGUsDQo+ICAJCQkJCSAgICBzdHJ1Y3QgYnVmZmVyX2hlYWQgKipkaV9iaCwN
Cj4gIAkJCQkJICAgIGludCBtZXRhX2xldmVsLA0KPiAtCQkJCQkgICAgaW50IG92ZXJ3cml0ZV9p
bywNCj4gIAkJCQkJICAgIGludCB3cml0ZV9zZW0sDQo+ICAJCQkJCSAgICBpbnQgd2FpdCkNCj4g
IHsNCj4gIAlpbnQgcmV0ID0gMDsNCj4gDQo+ICAJaWYgKHdhaXQpDQo+IC0JCXJldCA9IG9jZnMy
X2lub2RlX2xvY2soaW5vZGUsIE5VTEwsIG1ldGFfbGV2ZWwpOw0KPiArCQlyZXQgPSBvY2ZzMl9p
bm9kZV9sb2NrKGlub2RlLCBkaV9iaCwgbWV0YV9sZXZlbCk7DQo+ICAJZWxzZQ0KPiAtCQlyZXQg
PSBvY2ZzMl90cnlfaW5vZGVfbG9jayhpbm9kZSwNCj4gLQkJCW92ZXJ3cml0ZV9pbyA/IE5VTEwg
OiBkaV9iaCwgbWV0YV9sZXZlbCk7DQo+ICsJCXJldCA9IG9jZnMyX3RyeV9pbm9kZV9sb2NrKGlu
b2RlLCBkaV9iaCwgbWV0YV9sZXZlbCk7DQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCWdvdG8gb3V0
Ow0KPiANCj4gQEAgLTIxMzYsNiArMjEzNCw3IEBAIHN0YXRpYyBpbnQgb2NmczJfaW5vZGVfbG9j
a19mb3JfZXh0ZW50X3RyZWUoc3RydWN0DQo+IGlub2RlICppbm9kZSwNCj4gDQo+ICBvdXRfdW5s
b2NrOg0KPiAgCWJyZWxzZSgqZGlfYmgpOw0KPiArCSpkaV9iaCA9IE5VTEw7DQo+ICAJb2NmczJf
aW5vZGVfdW5sb2NrKGlub2RlLCBtZXRhX2xldmVsKTsNCj4gIG91dDoNCj4gIAlyZXR1cm4gcmV0
Ow0KPiBAQCAtMjE3Nyw3ICsyMTc2LDYgQEAgc3RhdGljIGludCBvY2ZzMl9wcmVwYXJlX2lub2Rl
X2Zvcl93cml0ZShzdHJ1Y3QgZmlsZQ0KPiAqZmlsZSwNCj4gIAkJcmV0ID0gb2NmczJfaW5vZGVf
bG9ja19mb3JfZXh0ZW50X3RyZWUoaW5vZGUsDQo+ICAJCQkJCQkgICAgICAgJmRpX2JoLA0KPiAg
CQkJCQkJICAgICAgIG1ldGFfbGV2ZWwsDQo+IC0JCQkJCQkgICAgICAgb3ZlcndyaXRlX2lvLA0K
PiAgCQkJCQkJICAgICAgIHdyaXRlX3NlbSwNCj4gIAkJCQkJCSAgICAgICB3YWl0KTsNCj4gIAkJ
aWYgKHJldCA8IDApIHsNCj4gQEAgLTIyMzMsMTMgKzIyMzEsMTMgQEAgc3RhdGljIGludCBvY2Zz
Ml9wcmVwYXJlX2lub2RlX2Zvcl93cml0ZShzdHJ1Y3QNCj4gZmlsZSAqZmlsZSwNCj4gIAkJCQkJ
CQkgICAmZGlfYmgsDQo+ICAJCQkJCQkJICAgbWV0YV9sZXZlbCwNCj4gIAkJCQkJCQkgICB3cml0
ZV9zZW0pOw0KPiArCQkJbWV0YV9sZXZlbCA9IDE7DQo+ICsJCQl3cml0ZV9zZW0gPSAxOw0KPiAg
CQkJcmV0ID0gb2NmczJfaW5vZGVfbG9ja19mb3JfZXh0ZW50X3RyZWUoaW5vZGUsDQo+ICAJCQkJ
CQkJICAgICAgICZkaV9iaCwNCj4gIAkJCQkJCQkgICAgICAgbWV0YV9sZXZlbCwNCj4gLQkJCQkJ
CQkgICAgICAgb3ZlcndyaXRlX2lvLA0KPiAtCQkJCQkJCSAgICAgICAxLA0KPiArCQkJCQkJCSAg
ICAgICB3cml0ZV9zZW0sDQo+ICAJCQkJCQkJICAgICAgIHdhaXQpOw0KPiAtCQkJd3JpdGVfc2Vt
ID0gMTsNCj4gIAkJCWlmIChyZXQgPCAwKSB7DQo+ICAJCQkJaWYgKHJldCAhPSAtRUFHQUlOKQ0K
PiAgCQkJCQltbG9nX2Vycm5vKHJldCk7DQo+IC0tDQo+IDIuMTIuMw0KDQo=
